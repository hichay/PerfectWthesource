
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local Today = os.date('%Y-%m-%d', os.time())
RegisterServerEvent('online-reward:checkIn')
AddEventHandler('online-reward:checkIn',
    function()
        local src = source
        PlayerCheckin(src)
        if Config['debug'] then
            print('online-reward', 'Id ' .. src, 'tried to checkin for daily reward.')
        end
    end
)
function table.Count(tbl)
    local c = 0
    for k, v in pairs(tbl) do
        c = c + 1
    end
    return c
end
local clrnum = function(num)
    return num % 1 == 0 and string.format('%.0f', num) or num
end
local timekeeper = {date = os.date('%Y-%m-%d', os.time()), list = {}}
local timecache = {}
function InitPlayerTime()
    local str = LoadResourceFile(GetCurrentResourceName(), 'data/timekeeper.json')
    if str then
        local obj = json.decode(str)
        if obj then
            timekeeper = obj
            local today = os.date('%Y-%m-%d', os.time())
            if timekeeper.date ~= today then
                timekeeper.date = today
                timekeeper.list = {}
                SavePlayerTime()
                if Config['debug'] then
                    print('online-reward', 'New day old timekeeper will be terminated.')
                end
            end
            if Config['debug'] then
                print('online-reward', 'Init Timekeeper.')
            end
        else
            timekeeper = {date = os.date('%Y-%m-%d', os.time()), list = {}}
            SavePlayerTime()
            if Config['debug'] then
                print('online-reward', 'Timekeeper is corrupted create a new one.')
            end
        end
    else
        timekeeper = {date = os.date('%Y-%m-%d', os.time()), list = {}}
        SavePlayerTime()
        if Config['debug'] then
            print('online-reward', 'Timekeeper is not found create a new one.')
        end
    end
end
function SavePlayerTime()
    if Config['debug'] then
        print('online-reward', 'Saved ' .. table.Count(timekeeper.list) .. ' Time.')
    end
    SaveResourceFile(GetCurrentResourceName(), 'data/timekeeper.json', json.encode(timekeeper), -1)
end
InitPlayerTime()
function discord_message(hook, message, desc, color, delay)
    if hook == nil or hook == '' or message == nil or message == '' then
        return false
    end
    local embeds = {
        {
            ['title'] = message,
            ['description'] = desc,
            ['type'] = 'rich',
            ['color'] = color,
            ['footer'] = {['text'] = ''}
        }
    }
    delay = delay or 0
    Citizen.CreateThread(
        function()
            Citizen.Wait(delay * 1000)
            PerformHttpRequest(
                hook,
                function(err, text, headers)
                end,
                'POST',
                json.encode({username = Config['discord_bot'], embeds = embeds}),
                {['Content-Type'] = 'application/json'}
            )
        end
    )
end
function GetIdent(src)
    local f =
        string.format(
            Config['translate']['discord_identifier'],
            GetPlayerIdentifier(src, 0),
            os.date('%H:%M:%S - %d/%m/%Y', os.time())
        )
    return f
end
function PlayerAddTime(src, time)
    local steamhex = GetPlayerIdentifier(src, 0)
    timekeeper.list[steamhex] = timekeeper.list[steamhex] or {time = 0, rc = {}}
    timekeeper.list[steamhex].time = timekeeper.list[steamhex].time + time
    for i = 1, #Config['online_tier'] do
        local data = Config['online_tier'][i]
        if not timekeeper.list[steamhex].rc[i] and timekeeper.list[steamhex].time >= data.time then
            timekeeper.list[steamhex].rc[i] = true
            local xPlayer = ESX.GetPlayerFromId(src)
            if data.item then
                for k, v in pairs(data.item) do
                    if string.match(string.lower(k), 'weapon_') then
                        xPlayer.addWeapon(k, v or 0)
                        if Config['debug'] then
                            print('online-reward', steamhex, 'rewarded weapon ' .. k .. ' => ' .. v)
                        end
                    else
                        --xPlayer.addInventoryItem(k, v or 1)
                        print(k,v)
                        TriggerClientEvent("player:receiveItem",src,k,v or 1)
                        if Config['debug'] then
                            print('online-reward', steamhex, 'rewarded item ' .. k .. ' => ' .. v)
                        end
                    end
                end
            end
            if data.cash then
                xPlayer.addMoney(data.cash)
                if Config['debug'] then
                    print('online-reward', steamhex, 'rewarded cash $' .. data.cash)
                end
            end
            if data.vehicle then
                GiveVehicle(src, data.vehicle)
                if Config['debug'] then
                    print('online-reward', steamhex, 'rewarded ' .. data.vehicle)
                end
            end
            if
                Config['discord_webhook'] and Config['discord_webhook']['online_reward'] and
                Config['discord_webhook']['online_reward'] ~= ''
            then
                local left = clrnum(data.time / 60)
                discord_message(
                    Config['discord_webhook']['online_reward'],
                    string.format(Config['translate']['discord_time'], xPlayer.name, left),
                    GetIdent(src),
                    Config['discord_color']['online_reward']
                )
            end
            if Config['debug'] then
                print('online-reward',steamhex,'get reward by achived ' .. data.time .. '. (' .. (timekeeper.list[steamhex].time) .. ')'
                )
            end
        end
    end
end
AddEventHandler('esx:playerLoaded',
    function(source)
        local src = source
        timecache[src] = GetGameTimer()
    end
)
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(60000)
            local xPlayers = ESX.GetPlayers()
            for i = 1, #xPlayers, 1 do
                local src = xPlayers[i]
                local time = 0
                if timecache[src] then
                    time = math.floor((GetGameTimer() - timecache[src]) / 1000)
                else
                    timecache[src] = 0
                end
                timecache[src] = GetGameTimer()
                if time > 0 then
                    PlayerAddTime(src, time)
                end
            end
            SavePlayerTime()
        end
    end
)
function PlayerCheckin(src, cb)
    local steamhex = GetPlayerIdentifier(src, 0)
    local xPlayer = ESX.GetPlayerFromId(src)
    IsPlayerAlreadyCheckin(src,function(state)
            if not state then
                MySQL.Async.execute(
                    'INSERT INTO user_daily_reward VALUES(@identifier, CURDATE()) ON DUPLICATE KEY UPDATE received_date=received_date;',
                    {['@identifier'] = steamhex},
                    function()
                        PlayerGetTotalDay(
                            src,
                            function(count)
                                if count > 0 and Config['daily_reward'][count] then
                                    local data = Config['daily_reward'][count]
                                    print('yo')
                                    if data.item then
                                        for k, v in pairs(data.item) do
                                            if string.match(string.lower(k), 'weapon_') then
                                                xPlayer.addWeapon(k, v or 0)
                                            else
                                                --xPlayer.addInventoryItem(k, v)
                                                print(k,v)
                                                TriggerClientEvent("player:receiveItem",src,k,v)
                                            end
                                        end
                                    end
                                    if data.cash then
                                        xPlayer.addMoney(data.cash)
                                    end
                                    if data.vehicle then
                                        GiveVehicle(src, data.vehicle)
                                    end
                                    if Config['debug'] then
                                        print(
                                            'online-reward',
                                            'Id ' .. src,
                                            'achived on day ' .. count .. ' and get his/her reward.'
                                        )
                                    end
                                else
                                    print('no config for this day reward')
                                end
                                if cb then
                                    cb(true)
                                end
                                if
                                    Config['discord_webhook'] and Config['discord_webhook']['daily_reward'] and
                                    Config['discord_webhook']['daily_reward'] ~= ''
                                then
                                    discord_message(
                                        Config['discord_webhook']['daily_reward'],
                                        string.format(Config['translate']['discord_gift'], xPlayer.name, count),
                                        GetIdent(src),
                                        Config['discord_color']['daily_reward']
                                    )
                                end
                            end
                        )
                    end
                )
            else
                print(src, 'already checkin on this day')
                if cb then
                    cb(false)
                end
            end
        end
    )
end
function PlayerGetTotalDay(src, cb)
    local steamhex = GetPlayerIdentifier(src, 0)
    MySQL.Async.fetchAll(
        'SELECT COUNT(identifier) AS total_date FROM user_daily_reward WHERE identifier = @identifier AND MONTH(received_date) = MONTH(CURDATE())',
        {['@identifier'] = steamhex},
        function(data)
            if not data or not data[1] then
                cb(0)
                return
            end
            cb(data[1].total_date)
        end
    )
end
ESX.RegisterServerCallback(
    'online-reward:getTotalDay',
    function(src, cb)
        PlayerGetTotalDay(
            src,
            function(day)
                IsPlayerAlreadyCheckin(
                    src,
                    function(bool)
                        if cb then
                            cb({day = day, state = bool})
                        end
                    end
                )
            end
        )
    end
)
ESX.RegisterServerCallback(
    'online-reward:checkIn',
    function(src, cb)
        PlayerCheckin(
            src,
            function(state)
                cb(state)
            end
        )
    end
)
function IsPlayerAlreadyCheckin(src, cb)
    local steamhex = GetPlayerIdentifier(src, 0)
    MySQL.Async.fetchAll(
        'SELECT identifier FROM user_daily_reward WHERE identifier = @identifier AND received_date = CURDATE()',
        {['@identifier'] = steamhex},
        function(data)
            if data and data[1] then
                cb(true)
            else
                cb(false)
            end
        end
    )
end
Citizen.CreateThread(
    function()
        while true do
            local cur = os.date('%Y-%m-%d', os.time())
            if cur ~= Today then
                InitPlayerTime()
                Today = cur
            end
            Citizen.Wait(60000)
        end
    end
)
local NumberCharset = {}
local Charset = {}
for i = 48, 57 do
    table.insert(NumberCharset, string.char(i))
end
for i = 65, 90 do
    table.insert(Charset, string.char(i))
end
for i = 97, 122 do
    table.insert(Charset, string.char(i))
end
function GetRandomNumber(length)
    math.randomseed(GetGameTimer())
    if length > 0 then
        return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
    else
        return ''
    end
end
function GetRandomLetter(length)
    Citizen.Wait(1)
    math.randomseed(GetGameTimer())
    if length > 0 then
        return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    else
        return ''
    end
end
function GiveVehicle(src, hash)
    local xPlayer = ESX.GetPlayerFromId(src)
    if type(hash) == 'string' then
        hash = GetHashKey(hash)
    end
    local plate =
        (Config['vehicle_custom_plate'] ~= nil and Config['vehicle_custom_plate'](src, hash) or
        (GetRandomLetter(Config['vehicle_plate_length_text']) ..
        ' ' .. GetRandomNumber(Config['vehicle_plate_length_number'])))
    plate = string.upper(plate)
    local veh = {
        dirtLevel = 5.0,
        model = hash,
        modBrakes = -1,
        color1 = 6,
        modRightFender = -1,
        modExhaust = -1,
        windowTint = -1,
        modAPlate = -1,
        modEngineBlock = -1,
        modBackWheels = -1,
        health = 1000,
        modWindows = -1,
        tyreSmokeColor = {255, 255, 255},
        modRearBumper = -1,
        modAerials = -1,
        modStruts = -1,
        modTrimA = -1,
        modGrille = -1,
        modTransmission = -1,
        extras = {[12] = false, [10] = false},
        modSmokeEnabled = false,
        modHorns = -1,
        modTrunk = -1,
        modArchCover = -1,
        modShifterLeavers = -1,
        pearlescentColor = 111,
        modLivery = -1,
        modSeats = -1,
        modSpeakers = -1,
        modAirFilter = -1,
        modSuspension = -1,
        modFrontBumper = -1,
        modDoorSpeaker = -1,
        wheels = 0,
        modEngine = -1,
        neonColor = {255, 0, 255},
        modSpoilers = -1,
        modFender = -1,
        modDashboard = -1,
        color2 = 0,
        modTurbo = false,
        plate = plate,
        modArmor = -1,
        modTrimB = -1,
        modVanityPlate = -1,
        plateIndex = 0,
        modRoof = -1,
        modSideSkirt = -1,
        modXenon = false,
        modSteeringWheel = -1,
        wheelColor = 156,
        modFrame = -1,
        modOrnaments = -1,
        modTank = -1,
        modHydrolic = -1,
        modHood = -1,
        modFrontWheels = -1,
        modPlateHolder = -1,
        modDial = -1,
        neonEnabled = {false, false, false, false}
    }
    MySQL.Async.execute(
        'INSERT INTO owned_vehicles (owner, plate, vehicle, `stored`) VALUES (@owner, @plate, @vehicle, 1)',
        {['@owner'] = xPlayer.identifier, ['@plate'] = veh.plate, ['@vehicle'] = json.encode(veh)},
        function(rowsChanged)
            if Config['debug'] then
                print(
                    'online-reward',
                    'Awarded ' .. hash .. ' vehicle (PLATE:' .. plate .. ') to ' .. xPlayer.identifier
                )
            end
        end
    )
end
