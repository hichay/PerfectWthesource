
ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 

if Config == nil then 
    print("Config is nil") 
    return
else if type(Config["chance"]) ~= "table" then 
    print("Config: Chance Table is not valid.") 
    return 
end 
    
function GetChance(tier) 
    return 
    Config["chance"][tier].rate 
end
    
function GetDiscordColor(tier) 
    return Config["chance"][tier].discord_color or 2368548
end
    
function discord_message(hook, message, desc, color, delay) if hook == nil or hook == "" or message == nil or message == "" then
    return false 
end 
local embeds = {
        {
            ["title"] = message, ["description"] = desc, ["type"] = "rich", ["color"] = color, ["footer"] = {
                ["text"] = "",
            },
        }
    }
Citizen.CreateThread(function() Citizen.Wait(delay * 1000) 
    PerformHttpRequest(hook, function(err, text, headers) end, 'POST', json.encode({username = Config["discord_bot"], embeds = embeds
    }), {
        ['Content-Type'] = 'application/json'
    }) end) 
end
    
function GetIdent(src) 
    local f = string.format(Config["translate"]["discord_identifier"], GetPlayerIdentifier(src, 0), os.date("%H:%M:%S - %d/%m/%Y", os.time())) 
    return f 
end 

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
    
function GetRandomNumber(length) math.randomseed(GetGameTimer()) 
    if length > 0 then
        return GetRandomNumber(length - 1)..NumberCharset[math.random(1, #NumberCharset)]
    else 
        return ''
    end
end
    
function GetRandomLetter(length) 
    Citizen.Wait(1) math.randomseed(GetGameTimer()) 
    if length > 0 then
        return GetRandomLetter(length - 1)..Charset[math.random(1, #Charset)]
    else 
        return ''
    end 
end
    
function GiveVehicle(src, hash) 
    local xPlayer = ESX.GetPlayerFromId(src) 
    if xPlayer == nil then
        return 
    end
    if type(hash) == "string" then 
        hash = GetHashKey(hash) 
    end 
    local plate = (Config["vehicle_custom_plate"] ~= nil and Config["vehicle_custom_plate"](src, hash) or(GetRandomLetter(Config["vehicle_plate_length_text"]).." "..GetRandomNumber(Config["vehicle_plate_length_number"]))) plate = string.upper(plate) 
    local veh = {
        dirtLevel = 5.0, model = hash, modBrakes = -1, color1 = 6, modRightFender = -1, modExhaust = -1, windowTint = -1, modAPlate = -1, modEngineBlock = -1, modBackWheels = -1, health = 1000, modWindows = -1, tyreSmokeColor = {
            255, 255, 255
        }, modRearBumper = -1, modAerials = -1, modStruts = -1, modTrimA = -1, modGrille = -1, modTransmission = -1, extras = {
            [12] = false, [10] = false
        }, modSmokeEnabled = false, modHorns = -1, modTrunk = -1, modArchCover = -1, modShifterLeavers = -1, pearlescentColor = 111, modLivery = -1, modSeats = -1, modSpeakers = -1, modAirFilter = -1, modSuspension = -1, modFrontBumper = -1, modDoorSpeaker = -1, wheels = 0, modEngine = -1, neonColor = {
            255, 0, 255
        }, modSpoilers = -1, modFender = -1, modDashboard = -1, color2 = 0, modTurbo = false, plate = plate, modArmor = -1, modTrimB = -1, modVanityPlate = -1, plateIndex = 0, modRoof = -1, modSideSkirt = -1, modXenon = false, modSteeringWheel = -1, wheelColor = 156, modFrame = -1, modOrnaments = -1, modTank = -1, modHydrolic = -1, modHood = -1, modFrontWheels = -1, modPlateHolder = -1, modDial = -1, neonEnabled = {
            false, false, false, false
        }
    }

    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, `stored`) VALUES (@owner, @plate, @vehicle, 1)', {
        ['@owner'] = xPlayer.identifier, ['@plate'] = veh.plate, ['@vehicle'] = json.encode(veh)
    }, function(rowsChanged) 
        if Config["debug"] then 
            print("lootbox", "Awarded "..hash.." vehicle (PLATE:"..plate..") to "..xPlayer.identifier) 
        end 
    end) 
end
    
function BroadcastText(name, item, tier, gnum) 
    local gacha = Config["lootbox"][gnum]
    if gacha == nil then
        return 
    end
    if Config["reward_broadcast"] and Config["reward_broadcast_tier_limit"][tier] then 
        TriggerClientEvent('chatMessage', -1, Config["translate"]["broadcast_header"] or "Lootbox ", {
        255, 255, 255}, string.format(Config["translate"]["broadcast_text"], name, item, gacha.name or "Unknown")) 
    end 
end
    
function GiveItem(src, class, amount) 
    local xPlayer = ESX.GetPlayerFromId(src) 
    if xPlayer then 
        local item = xPlayer.getInventoryItem(class) 
        if not item then 
            print("Gacha: Item "..class.." is not found!") 
            return 
        end
		if not xPlayer.canCarryItem(class, amount) then	
            print("Gacha: Item "..class.." reach limit.") 
            return 
        end 
        xPlayer.addInventoryItem(class, amount) 
    end 
end
    
function Openlootbox(src, name) 
    if not ESX then 
        print("Gacha: ESX is not loaded.") 
        return 
    end 
    local gacha = Config["lootbox"][name]

    if gacha == nil then
        return 
    end 
    math.randomseed(os.time()) 
    local xPlayer = ESX.GetPlayerFromId(src) 

    if xPlayer == nil then
        return 
    end 
    local max = 0 
    local wheel = {}

    for k, v in pairs(gacha.list) do 
        local b = max 
        local c = max + GetChance(v.tier) max = c table.insert(wheel, {
            base = b, chance = c,
        }) 
    end 
    local rand = math.random() * max 
    local found

    for k, v in pairs(wheel) do
        if rand > v.base and rand <= v.chance then 
            found = k local v = gacha.list[found]
            if v.item and type(v.item) == "string" then
                if string.match(string.lower(v.item), "weapon_") then 
                    local weapon_name = ESX.GetWeaponLabel(v.item) 
                    if Config["wheel_delay_award"] then 
                        Citizen.CreateThread(function() 
                            Citizen.Wait((Config["wheel_duration"] * 1000) + 1000) 
                            xPlayer.addWeapon(v.item, v.amount or 0) 
                            BroadcastText(GetPlayerName(src), weapon_name, v.tier, name) 
                        end)
                    else 
                        xPlayer.addWeapon(v.item, v.amount or 0) 
                        BroadcastText(GetPlayerName(src), weapon_name, v.tier, name) 
                    end

                    if Config["lootbox_discord"] and Config["lootbox_discord"]["weapon"] and Config["lootbox_discord"]["weapon"] ~= "" then 
                        discord_message(Config["lootbox_discord"]["weapon"], string.format(Config["translate"]["discord_gacha_unbox"], 
                        GetPlayerName(src), gacha.name, weapon_name, xPlayer.getIdentifier()), GetIdent(src), 
                        GetDiscordColor(v.tier), Config["wheel_duration"] or 5) 
                    end
                else 
                    local item = xPlayer.getInventoryItem(v.item) 
                    local item_name = item and item.label or "Unknown"

                    if Config["wheel_delay_award"] then 
                        Citizen.CreateThread(function() 
                            Citizen.Wait((Config["wheel_duration"] * 1000) + 1000) 
                            BroadcastText(GetPlayerName(src), item_name, v.tier, name) 
                            --GiveItem(src, v.item, v.amount or 1) 
                            TriggerClientEvent("player:receiveItem",src, v.item, v.amount or 1)
                        end)
                    else 
                        BroadcastText(GetPlayerName(src), item_name, v.tier, name) 
                        --GiveItem(src, v.item, v.amount or 1) 
                        TriggerClientEvent("player:receiveItem",src, v.item, v.amount or 1)
                    end

                    if Config["lootbox_discord"] and Config["lootbox_discord"]["item"] and Config["lootbox_discord"]["item"] ~= "" then 
                        discord_message(Config["lootbox_discord"]["item"], string.format(Config["translate"]["discord_gacha_unbox"], 
                        GetPlayerName(src), gacha.name, item_name, xPlayer.getIdentifier()), GetIdent(src), 
                        GetDiscordColor(v.tier), Config["wheel_duration"] or 5) 
                    end 
                end 
            elseif v.money and type(v.money) == "number" then 
                local item_name = "$"..string.Comma(v.money) 
                if Config["wheel_delay_award"] then 
                    Citizen.CreateThread(function() 
                        Citizen.Wait((Config["wheel_duration"] * 1000) + 1000) 
                        xPlayer.addMoney(v.money) 
                        BroadcastText(GetPlayerName(src), item_name, v.tier, name) 
                    end)
                else 
                    xPlayer.addMoney(v.money) 
                    BroadcastText(GetPlayerName(src), item_name, v.tier, name) 
                end
                if Config["lootbox_discord"] and Config["lootbox_discord"]["money"] and Config["lootbox_discord"]["money"] ~= "" then 
                    discord_message(Config["lootbox_discord"]["money"], string.format(Config["translate"]["discord_gacha_unbox"], 
                    GetPlayerName(src), gacha.name, item_name, xPlayer.getIdentifier()), GetIdent(src), 
                    GetDiscordColor(v.tier), Config["wheel_duration"] or 5) 
                end 
            elseif v.vehicle and(type(v.vehicle) == "string" or type(v.vehicle) == "number") then 
                local vehicle_name = v.name or v.vehicle
                if Config["wheel_delay_award"] then 
                    Citizen.CreateThread(function() 
                        Citizen.Wait((Config["wheel_duration"] * 1000) + 1000)
                        GiveVehicle(src, v.vehicle) 
                        BroadcastText(GetPlayerName(src), vehicle_name, v.tier, name) end)
                    else 
                        GiveVehicle(src, v.vehicle) 
                        BroadcastText(GetPlayerName(src), vehicle_name, v.tier, name) 
                    end
                    if Config["lootbox_discord"] and Config["lootbox_discord"]["vehicle"] and Config["lootbox_discord"]["vehicle"] ~= "" then 
                        discord_message(Config["lootbox_discord"]["vehicle"], string.format(Config["translate"]["discord_gacha_unbox"], 
                        GetPlayerName(src), gacha.name, vehicle_name, xPlayer.getIdentifier()), GetIdent(src), 
                        GetDiscordColor(v.tier), Config["wheel_duration"] or 5) 
                    end 
                end 
            end 
        end
        if found then 
            TriggerClientEvent("mon_lootbox:StartWheel", src, name, found)
        else 
            print("Gacha: Internal Error") 
        end 
    end
    if Config["lootbox"] then
        if ESX and ESX.RegisterUsableItem then
            for k, v in pairs(Config["lootbox"]) do
                if type(k) == "string" and type(v) == "table" then 
                    print("Gacha: register item "..k) 
                    ESX.RegisterUsableItem(k, function(source) 
                        local xPlayer = ESX.GetPlayerFromId(source) 
                        if xPlayer == nil then
                            return 
                        end 
                        xPlayer.removeInventoryItem(k, 1) Openlootbox(source, k) 
                    end) 
                end 
            end
        else 
            print("Gacha: ESX is not loaded") 
        end 
    end 
    RegisterServerEvent("mon_lootbox:handler") 
    AddEventHandler("mon_lootbox:handler", function(action, data) end)
    function string.Comma(number) 
        if tonumber(number) then 
            number = string.format("%f", number) number = string.match(number, "^(.-)%.?0*$")
        end 
        local k
        while true do 
            number, k = string.gsub(number, "^(-?%d+)(%d%d%d)", "%1,%2") 
            if (k == 0) then
                break
            end
        end
        return number 
    end 
end