local Small_UI_enabled = false
local Large_UI_enabled = false
local Dispatch = {}
local count = 0
local NUI_status = false
local cooldown = false

local GlobalInfo
local GlobalCoords
local SourceName
local ExtraDutyChecks = true

local ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        if Config and Config.ESXTrigger then
            TriggerEvent(Config.ESXTrigger, function(obj) ESX = obj end)
            Citizen.Wait(0)
        else
            print('dispatch - error 9846541')
        end
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    Wait(2000)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

if Config and Config.UsingMultichar == false then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            if NetworkIsSessionStarted() then
                Wait(5000)
                TriggerServerEvent('cd_dispatch:PlayerLoaded')
                break
            end
        end
    end)
end

RegisterNetEvent('cd_garage_GrabInfo')
AddEventHandler('cd_garage_GrabInfo', function(xPlayer)
    Wait(5000)
    TriggerServerEvent('cd_dispatch:PlayerLoaded')
end)

Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    Dispatch[count] = {}
    while true do
        Citizen.Wait(0)
        if Config and Config.ToggleUI ~= nil and Config.MoveRight ~= nil and Config.MoveLeft ~= nil and Config.Respond ~= nil and Config.OpenLarge ~= nil then
            if Dispatch and count then
                if Small_UI_enabled then
                    if Dispatch[count] ~= nil then
                        local MyCoords = GetEntityCoords(GetPlayerPed(-1))
                        if IsControlJustReleased(0, Config.MoveRight) then
                            Increasecount()

                        elseif IsControlJustReleased(0, Config.MoveLeft) then
                            Decreasecount()

                        elseif IsControlJustReleased(0, Config.Respond) then
                            if Dispatch[count].coords ~= nil then
                                if Dispatch[count].responding_state ~= nil and Dispatch[count].responding_state == false then
                                    if not cooldown then
                                        cooldown = true
                                        TriggerEvent('cd_dispatch:StopSpammings')
                                        AddResponding(count, true)

                                    else
                                        if Config.Language and Config.Client_Locales[Config.Language]['cooldown'] then
                                            -- AvengersWater('error_notif', Config.Client_Locales[Config.Language]['cooldown'])
											TriggerEvent("ESX:Notify",Config.Client_Locales[Config.Language]['cooldown'],'info')
                                        else
                                            ErrorLocale('cooldown')
                                        end
                                    end
                                else
                                    if not cooldown then
                                        cooldown = true
                                        TriggerEvent('cd_dispatch:StopSpammings')
                                        RemoveResponding(count, true)
                                    else
                                        if Config.Language and Config.Client_Locales[Config.Language]['cooldown'] then
                                            --AvengersWater('error_notif', Config.Client_Locales[Config.Language]['cooldown'])
											TriggerEvent("ESX:Notify",Config.Client_Locales[Config.Language]['cooldown'],'info')
                                        else
                                            ErrorLocale('cooldown')
                                        end
                                    end
                                end
                            else
                                print('dispatch - error 7986416')
                            end

                        elseif IsControlJustPressed(0, Config.OpenLarge) then
                            if not Large_UI_enabled then
                                Large_UI_enabled = true
                                HideSmallUI()

                                SendNUIMessage({
                                    action = 'loading',
                                })

                                local job = GetJob()
                                TriggerServerEvent('cd_dispatch:GlobalInfo', job)
                                while GlobalInfo == nil do
                                    Wait(100)
                                end

                                TriggerEvent('cd_dispatch:ToggleNUIFocus')
                                SendNUIMessage({
                                    action = 'showlarge',
                                    job = job,
                                    GlobalInfo = GlobalInfo,
                                    mode = GetTime(),
                                })
                            end

                        elseif IsControlJustPressed(0, Config.MoveMode) then
                            TriggerEvent('cd_dispatch:ToggleNUIFocus')
                            SendNUIMessage({action = 'movemode'})
                        end
                    else
                        print('dispatch - error 9+84651')
                    end
                end

                if IsControlJustPressed(0, Config.ToggleUI) then
                    if IsAllowed() then
                        if not Small_UI_enabled then
                            ShowSmallUI()
                        else
                            HideSmallUI()
                        end
                    end
                end
            else
                print('dispatch - error 8465115')
            end
        else
            print('dispatch - error 4684584')
        end
    end
end)

RegisterNUICallback('hidelarge', function()
    HideLargeUI()
end)

RegisterNUICallback('deletesingle', function(data)
    if data and type(data) == 'table' then
        for k, v in pairs(data) do
            if Dispatch and Dispatch[tonumber(v)] then
                Dispatch[tonumber(v)] = nil
                count = #Dispatch
            else
                print('dispatch - error 3651468')
            end
        end
    else
        print('dispatch - error 7796854')
    end
end)

RegisterNUICallback('deleteall', function()
    Dispatch = nil
    Dispatch = {}
    count = 0
    Dispatch[count] = {}
end)

RegisterNUICallback('addresponding', function(data)
    if data and type(data) == 'table' then
        for k, v in pairs(data) do
            AddResponding(v, false)
        end
    else
        print('dispatch - error 9846451')
    end
end)

RegisterNUICallback('removeresponding', function(data)
    if data and type(data) == 'table' then
        for k, v in pairs(data) do
            RemoveResponding(v, false)
        end
    else
        print('dispatch - error 6958414')
    end
end)

RegisterNUICallback('getcoords', function(data)
    if data and type(data) == 'table' then
        for k, v in pairs(data) do
            TriggerServerEvent('cd_dispatch:GetCoords', v)
        end
        while GlobalCoords == nil do Wait(100) end
        SendNUIMessage({
            action = 'updatecoords',
            coords = GlobalCoords,
        })
        GlobalCoords = nil
    else
        print('dispatch - error 96841658')
    end
end)

RegisterNUICallback('moveend', function()
    NUI_status = false
end)





RegisterNetEvent('cd_dispatch:SendSourceName')
AddEventHandler('cd_dispatch:SendSourceName', function(SourceName2)
    if SourceName2 and type(SourceName2) == 'string' then
        SourceName = SourceName2
    else
        print('dispatch - error 7658146')
    end
end)

RegisterNetEvent('cd_dispatch:AddNotification')
AddEventHandler('cd_dispatch:AddNotification', function(t)
    if Dispatch and t and t.job and type(t) == 'table' and type(t.job) == 'string' and t.coords and type(t.coords) == 'vector3' and t.coords.x and t.coords.y then
        if GetJob() == t.job then
            local ThisCount
            count = count+1
            ThisCount = count
            Dispatch[count] = {}
            Dispatch[count].job = tostring(t.job)
            Dispatch[count].responding = 0
            Dispatch[count].responding_state = false
            Dispatch[count].coords = {x = round(t.coords.x, 2), y = round(t.coords.y, 2), z = round(t.coords.z, 2)}
            Dispatch[count].title = tostring(t.title)
            Dispatch[count].message = tostring(t.message)
            Dispatch[count].flash = t.flash

            SendNUIMessage({
                action = 'AddNotification',
                count = ThisCount,
                job = Dispatch[ThisCount].job,
                responding = Dispatch[ThisCount].responding,
                flash = Dispatch[ThisCount].flash,
                coords = Dispatch[ThisCount].coords,
                title = Dispatch[ThisCount].title,
                message = Dispatch[ThisCount].message,
            })
            ThisCount = nil

            if t.blip and t.coords and t.coords.x and t.coords.y and t.coords.z and t.blip.sprite and t.blip.scale and t.blip.colour and t.blip.text and t.blip.time and type(t.blip.time) == 'number' then
                --AvengersWater('blip_sound', t.blip.sound)
				BlipSound(t.blip.sound)
                local blip = AddBlipForCoord(t.coords.x, t.coords.y, t.coords.z)
		
                SetBlipSprite(blip, tonumber(t.blip.sprite))
                SetBlipScale(blip, tonumber(t.blip.scale))
                SetBlipColour(blip, tonumber(t.blip.colour))
				
                if t.blip.flashes then
		    SetBlipFlashes(blip,true)	
		    	
                end
		if t.blip.pulse then
		   PulseBlip(blip)	
		end
				
                BeginTextCommandSetBlipName("CUSTOM_TEXT")
                AddTextComponentString(tostring(t.blip.text))
                EndTextCommandSetBlipName(blip)
                local time = tonumber(t.blip.time*0.1)
		
		
                SetBlipFade(blip, 250, t.blip.time)
                Wait(time)
                SetBlipFade(blip, 230, 30000)
                Wait(time)
                SetBlipFade(blip, 210, 30000)
                Wait(time)
                SetBlipFade(blip, 190, 30000)
                Wait(time)
                SetBlipFade(blip, 170, 30000)
                Wait(time)
                SetBlipFade(blip, 150, 30000)
                Wait(time)
                SetBlipFade(blip, 130, 30000)
                Wait(time)
                SetBlipFade(blip, 110, 30000)
                Wait(time)
                SetBlipFade(blip, 90, 30000)
                Wait(time)
                SetBlipFade(blip, 70, 30000)
                Wait(time)
                RemoveBlip(blip)
            else
                print('dispatch - error 4681561')
            end
        else
            print('dispatch - error 6814514')
        end
    else
        print('dispatch - error 1466485')
    end
end)

RegisterNetEvent('cd_dispatch:AddResponding')
AddEventHandler('cd_dispatch:AddResponding', function(job, responding, count2, SourceName2)
    if job and responding and count2 and SourceName2 and type(job) == 'string' and type(responding) == 'number' and type(count2) == 'number' and type(SourceName2) == 'string' then
        if Dispatch and Dispatch[count2] and CheckJob(job) then
            Dispatch[count2].responding = tonumber(responding+1)
            SendNUIMessage({
                action = 'addresponding',
                count2 = count2,
                SourceName = SourceName2,
            })
        else
            print('dispatch - error 46985446')
        end
    else
        print('dispatch - error 34864689')
    end
end)

RegisterNetEvent('cd_dispatch:RemoveResponding')
AddEventHandler('cd_dispatch:RemoveResponding', function(job, responding, count2, SourceName2)
    if job and responding and count2 and SourceName2 and type(job) == 'string' and type(responding) == 'number' and type(count2) == 'number' and type(SourceName2) == 'string' then
        if Dispatch and Dispatch[count2] and CheckJob(job) then
            Dispatch[count2].responding = tonumber(responding-1)
            SendNUIMessage({
                action = 'removeresponding',
                count2 = count2,
                SourceName = SourceName2,
            })
        else
            print('dispatch - error 3456541')
        end
    else
        print('dispatch - error 9845231')
    end
end)

RegisterNetEvent('cd_dispatch:GlobalInfo')
AddEventHandler('cd_dispatch:GlobalInfo', function(job, GlobalInfo2)
    if job and GlobalInfo2 and type(job) == 'string' and type(GlobalInfo2) == 'table' then
        if CheckJob(job) then
            GlobalInfo = GlobalInfo2
        end
    else
        print('dispatch - error 6984644')
    end
end)

RegisterNetEvent('cd_dispatch:GetCoords')
AddEventHandler('cd_dispatch:GetCoords', function(job, GlobalCoords2)
    if job and GlobalCoords2 and type(job) == 'string' and type(GlobalCoords2) == 'table' then
        if CheckJob(job) then
            GlobalCoords = GlobalCoords2
        end
    else
        print('dispatch - error 7769845')
    end
end)

RegisterNetEvent('cd_dispatch:ToggleNUIFocus')
AddEventHandler('cd_dispatch:ToggleNUIFocus', function()
    NUI_status = true
    while NUI_status ~= false do
        Citizen.Wait(5)
        SetNuiFocus(NUI_status, NUI_status)
    end
    SetNuiFocus(false, false)
end)

RegisterNetEvent('cd_dispatch:StopSpammings')
AddEventHandler('cd_dispatch:StopSpammings', function()
    Wait(1000)
    cooldown = false
end)

RegisterNetEvent('cd_dispatch:GetNonOnesyncCoords')
AddEventHandler('cd_dispatch:GetNonOnesyncCoords', function(job)
    if job and type(job) == 'string' then
        if CheckJob(job) then
            TriggerServerEvent('cd_dispatch:GetNonOnesyncCoords', GetEntityCoords(GetPlayerPed(-1)))
        end
    else
        print('dispatch - error 1654656')
    end
end)

RegisterNetEvent('cd_dispatch:OnDutyChecks')
AddEventHandler('cd_dispatch:OnDutyChecks', function(state)
    if state ~= nil and type(state) == 'boolean' then
        if state == true then
            ExtraDutyChecks = state
        elseif state == false then
            ExtraDutyChecks = state
        end
    else
        print('dispatch - error 3516544')
    end
end)

function AddResponding(count2, send)
    if count2 and send ~= nil and type(count2) == 'number' and type(send) == 'boolean' then
        if Dispatch and Dispatch[count2] and Dispatch[count2].coords and Dispatch[count2].coords.x and Dispatch[count2].coords.y then
            if Dispatch[count2].job and Dispatch[count2].responding and Dispatch[count2].responding_state ~= nil and SourceName then
                Dispatch[count2].responding_state = true
                SetNewWaypoint(Dispatch[count2].coords.x, Dispatch[count2].coords.y)
                if send == true then
                    TriggerServerEvent('cd_dispatch:AddResponding', Dispatch[count2].job, Dispatch[count2].responding, count2, SourceName)
                end
            else
                print('dispatch - error 16546486')
            end
        else
            print('dispatch - error 9845146')
        end
    else
        print('dispatch - error 1654764')
    end
end

function RemoveResponding(count2, send)
    if count2 and send ~= nil and type(count2) == 'number' and type(send) == 'boolean' then
        if Dispatch and Dispatch[count2] and Dispatch[count2].coords and Dispatch[count2].coords.x and Dispatch[count2].coords.y then
            if Dispatch[count2].job and Dispatch[count2].responding and Dispatch[count2].responding_state ~= nil and SourceName then
                Dispatch[count2].responding_state = false
                SetWaypointOff()
                if send == true then
                    TriggerServerEvent('cd_dispatch:RemoveResponding', Dispatch[count2].job, Dispatch[count2].responding, count2, SourceName)
                end
            else
                print('dispatch - error 635154')
            end
        else
            print('dispatch - error 4658152')
        end
    else
        print('dispatch - error 3515615')
    end
end

function HideLargeUI()
    Large_UI_enabled = false
    NUI_status = false
    GlobalInfo = nil
    ShowSmallUI()
end

function ShowSmallUI()
    Small_UI_enabled = true
    SendNUIMessage({
        action = GetNUIState(Small_UI_enabled),
        SourceName = SourceName,
    })
end

function HideSmallUI()
    Small_UI_enabled = false
    SendNUIMessage({action = GetNUIState(Small_UI_enabled)})
end

function GetTime()
    local hours = GetClockHours()
    if Config and Config.DayHours and Config.DayHours[1] and type(Config.DayHours[1]) == 'number' and Config.DayHours[2] and type(Config.DayHours[2]) == 'number' then
        if hours > Config.DayHours[1] and hours < Config.DayHours[2] then
            return 'day'
        else
            return 'night'
        end
    else
        print('dispatch - error 3156544')
        return 'day'
    end
end

function GetNUIState(Small_UI_enabled)
    if Small_UI_enabled ~= nil and type(Small_UI_enabled) == 'boolean' then
        if Small_UI_enabled then
            return 'showsmall'
        else
            return 'hidesmall'
        end
    else
        print('dispatch - error 6146541')
    end
end

function Increasecount()
    if Dispatch and count and Dispatch[count] then
        if #Dispatch ~= 0 then
            count = count+1
            if count > #Dispatch then
                count = 1
            end
            while Dispatch[count] == nil do
                Wait(0)
                count = count+1
                if count > #Dispatch then
                    count = 1
                end
            end
            SendNUIMessage({action = 'MoveRight'})
        end
    else
        print('dispatch - error 351654')
    end
end

function Decreasecount()
    if Dispatch and count and Dispatch[count] then
        if #Dispatch ~= 0 then
            count = count-1
            if count < 1 then
                count = #Dispatch
            end
            while Dispatch[count] == nil do
                Wait(0)
                count = count-1
                if count < 1 then
                    count = #Dispatch
                end
            end
            SendNUIMessage({action = 'MoveLeft'})
        end
    else
        print('dispatch - error 7651451')
    end
end

function round(num, decimals)
    if num and type(num) == 'number' and decimals and type(decimals) == 'number' then
        local mult = math.pow(10, decimals or 0)
        return math.floor(num * mult + 0.5) / 100
    else
        print('dispatch - error 6844511')
    end
end

function IsAllowed()
    if Config and Config.AllowedJobs and Config.AllowedJobs[GetJob()] and ExtraDutyChecks == true then
        return true
    else
        return false
    end
end

function CheckJob(job)
    if job and type(job) == 'string' then
        if GetJob() == job and ExtraDutyChecks == true then
            return true
        else
            return false
        end
    else
        print('dispatch - error 6124512')
        return false
    end
end

function GetJob()
    if ESX then
        while ESX.PlayerData == nil or ESX.PlayerData.job == nil or ESX.PlayerData.job.name == nil do
            Wait(0)
        end
        return ESX.PlayerData.job.name
    else
        print('dispatch - error 6458416')
        return 'unemployed'
    end
end

function ErrorLocale(locale1)
    print('['..GetCurrentResourceName()..'] - ERROR - This locale is missing or incorrect ('..locale1..')')
end

local zoneNames = {
    AIRP = "Los Santos International Airport",
    ALAMO = "Alamo Sea",
    ALTA = "Alta",
    ARMYB = "Fort Zancudo",
    BANHAMC = "Banham Canyon Dr",
    BANNING = "Banning",
    BAYTRE = "Baytree Canyon",
    BEACH = "Vespucci Beach",
    BHAMCA = "Banham Canyon",
    BRADP = "Braddock Pass",
    BRADT = "Braddock Tunnel",
    BURTON = "Burton",
    CALAFB = "Calafia Bridge",
    CANNY = "Raton Canyon",
    CCREAK = "Cassidy Creek",
    CHAMH = "Chamberlain Hills",
    CHIL = "Vinewood Hills",
    CHU = "Chumash",
    CMSW = "Chiliad Mountain State Wilderness",
    CYPRE = "Cypress Flats",
    DAVIS = "Davis",
    DELBE = "Del Perro Beach",
    DELPE = "Del Perro",
    DELSOL = "La Puerta",
    DESRT = "Grand Senora Desert",
    DOWNT = "Downtown",
    DTVINE = "Downtown Vinewood",
    EAST_V = "East Vinewood",
    EBURO = "El Burro Heights",
    ELGORL = "El Gordo Lighthouse",
    ELYSIAN = "Elysian Island",
    GALFISH = "Galilee",
    GALLI = "Galileo Park",
    golf = "GWC and Golfing Society",
    GRAPES = "Grapeseed",
    GREATC = "Great Chaparral",
    HARMO = "Harmony",
    HAWICK = "Hawick",
    HORS = "Vinewood Racetrack",
    HUMLAB = "Humane Labs and Research",
    JAIL = "Bolingbroke Penitentiary",
    KOREAT = "Little Seoul",
    LACT = "Land Act Reservoir",
    LAGO = "Lago Zancudo",
    LDAM = "Land Act Dam",
    LEGSQU = "Legion Square",
    LMESA = "La Mesa",
    LOSPUER = "La Puerta",
    MIRR = "Mirror Park",
    MORN = "Morningwood",
    MOVIE = "Richards Majestic",
    MTCHIL = "Mount Chiliad",
    MTGORDO = "Mount Gordo",
    MTJOSE = "Mount Josiah",
    MURRI = "Murrieta Heights",
    NCHU = "North Chumash",
    NOOSE = "N.O.O.S.E",
    OCEANA = "Pacific Ocean",
    PALCOV = "Paleto Cove",
    PALETO = "Paleto Bay",
    PALFOR = "Paleto Forest",
    PALHIGH = "Palomino Highlands",
    PALMPOW = "Palmer-Taylor Power Station",
    PBLUFF = "Pacific Bluffs",
    PBOX = "Pillbox Hill",
    PROCOB = "Procopio Beach",
    RANCHO = "Rancho",
    RGLEN = "Richman Glen",
    RICHM = "Richman",
    ROCKF = "Rockford Hills",
    RTRAK = "Redwood Lights Track",
    SanAnd = "San Andreas",
    SANCHIA = "San Chianski Mountain Range",
    SANDY = "Sandy Shores",
    SKID = "Mission Row",
    SLAB = "Stab City",
    STAD = "Maze Bank Arena",
    STRAW = "Strawberry",
    TATAMO = "Tataviam Mountains",
    TERMINA = "Terminal",
    TEXTI = "Textile City",
    TONGVAH = "Tongva Hills",
    TONGVAV = "Tongva Valley",
    VCANA = "Vespucci Canals",
    VESP = "Vespucci",
    VINE = "Vinewood",
    WINDF = "Ron Alternates Wind Farm",
    WVINE = "West Vinewood",
    ZANCUDO = "Zancudo River",
    ZP_ORT = "Port of South Los Santos",
    ZQ_UAR = "Davis Quartz"
}

local CarColours = {
    -- Black
    { index = 0, label = 'black'},
    { index = 1, label = 'black'},
    { index = 2, label = 'black'},
    { index = 3, label = 'grey'},
    { index = 11, label = 'black'},
    { index = 12, label = 'matte black'},
    { index = 15, label = 'black'},
    { index = 16, label = 'black'},
    { index = 21, label = 'oil'},
    { index = 147, label = 'carbon'},
     -- White
    { index = 106, label = 'white'},
    { index = 107, label = 'creme'},
    { index = 111, label = 'white'},
    { index = 112, label = 'white'},
    { index = 113, label = 'beige'},
    { index = 121, label = 'white'},
    { index = 122, label = 'white'},
    { index = 131, label = 'white'},
    { index = 132, label = 'white'},
    { index = 134, label = 'white'},
    -- Grey
    { index = 4, label = 'silver'},
    { index = 5, label = 'grey'},
    { index = 6, label = 'grey'},
    { index = 7, label = 'grey'},
    { index = 8, label = 'grey'},
    { index = 9, label = 'night'},
    { index = 10, label = 'aluminum'},
    { index = 13, label = 'grey'},
    { index = 14, label = 'grey'},
    { index = 17, label = 'grey'},
    { index = 18, label = 'grey'},
    { index = 19, label = 'silver'},
    { index = 20, label = 'grey'},
    { index = 22, label = 'grey'},
    { index = 23, label = 'grey'},
    { index = 24, label = 'grey'},
    { index = 25, label = 'silver'},
    { index = 26, label = 'titanium'},
    { index = 66, label = 'grey'},
    { index = 93, label = 'champagne'},
    { index = 144, label = 'grey'},
    { index = 156, label = 'grey'},
    -- Red
    { index = 27, label = 'red'},
    { index = 28, label = 'red'},
    { index = 29, label = 'red'},
    { index = 30, label = 'red'},
    { index = 31, label = 'red'},
    { index = 32, label = 'red'},
    { index = 33, label = 'red'},
    { index = 34, label = 'red'},
    { index = 35, label = 'red'},
    { index = 39, label = 'red'},
    { index = 40, label = 'red'},
    { index = 43, label = 'red'},
    { index = 44, label = 'red'},
    { index = 46, label = 'red'},
    { index = 143, label = 'red'},
    { index = 150, label = 'red'},
    -- Pink
    { index = 135, label = 'pink'},
    { index = 136, label = 'pink'},
    { index = 137, label = 'pink'},
    -- Blue
    { index = 54, label = 'blue'},
    { index = 60, label = 'blue'},
    { index = 61, label = 'blue'},
    { index = 62, label = 'blue'},
    { index = 63, label = 'blue'},
    { index = 64, label = 'blue'},
    { index = 65, label = 'blue'},
    { index = 67, label = 'blue'},
    { index = 68, label = 'blue'},
    { index = 69, label = 'blue'},
    { index = 70, label = 'blue'},
    { index = 73, label = 'blue'},
    { index = 74, label = 'blue'},
    { index = 75, label = 'blue'},
    { index = 77, label = 'blue'},
    { index = 78, label = 'blue'},
    { index = 79, label = 'blue'},
    { index = 80, label = 'blue'},
    { index = 82, label = 'blue'},
    { index = 83, label = 'blue'},
    { index = 84, label = 'blue'},
    { index = 85, label = 'blue'},
    { index = 86, label = 'blue'},
    { index = 87, label = 'blue'},
    { index = 127, label = 'blue'},
    { index = 140, label = 'blue'},
    { index = 141, label = 'blue'},
    { index = 146, label = 'blue'},
    { index = 157, label = 'blue'},
    -- Yellow
    { index = 42, label = 'yellow'},
    { index = 88, label = 'yellow'},
    { index = 89, label = 'yellow'},
    { index = 91, label = 'yellow'},
    { index = 126, label = 'yellow'},
    -- Green
    { index = 49, label = 'green'},
    { index = 50, label = 'green'},
    { index = 51, label = 'green'},
    { index = 52, label = 'green'},
    { index = 53, label = 'green'},
    { index = 55, label = 'green'},
    { index = 56, label = 'green'},
    { index = 57, label = 'green'},
    { index = 58, label = 'green'},
    { index = 59, label = 'green'},
    { index = 92, label = 'green'},
    { index = 125, label = 'green'},
    { index = 128, label = 'green'},
    { index = 133, label = 'green'},
    { index = 151, label = 'green'},
    { index = 152, label = 'green'},
    { index = 155, label = 'green'},
    -- Orange
    { index = 36, label = 'orange'},
    { index = 38, label = 'orange'},
    { index = 41, label = 'orange'},
    { index = 123, label = 'orange'},
    { index = 124, label = 'orange'},
    { index = 130, label = 'orange'},
    { index = 138, label = 'orange'},
    -- Brown
    { index = 45, label = 'copper'},
    { index = 47, label = 'brown'},
    { index = 48, label = 'brown'},
    { index = 90, label = 'bronze'},
    { index = 94, label = 'brown'},
    { index = 95, label = 'brown'},
    { index = 96, label = 'brown'},
    { index = 97, label = 'brown'},
    { index = 98, label = 'brown'},
    { index = 99, label = 'beige'},
    { index = 100, label = 'brown'},
    { index = 101, label = 'brown'},
    { index = 102, label = 'brown'},
    { index = 103, label = 'brown'},
    { index = 104, label = 'brown'},
    { index = 105, label = 'brown'},
    { index = 108, label = 'brown'},
    { index = 109, label = 'brown'},
    { index = 110, label = 'brown'},
    { index = 114, label = 'brown'},
    { index = 115, label = 'brown'},
    { index = 116, label = 'beige'},
    { index = 129, label = 'brown'},
    { index = 153, label = 'brown'},
    { index = 154, label = 'beige'},
    -- Purple
    { index = 71, label = 'purple'},
    { index = 72, label = 'purple'},
    { index = 76, label = 'violet'},
    { index = 81, label = 'purple'},
    { index = 142, label = 'violet'},
    { index = 145, label = 'purple'},
    { index = 148, label = 'purple'},
    { index = 149, label = 'purple'},
    -- Chrome
    { index = 117, label = 'chrome'},
    { index = 118, label = 'chrome'},
    { index = 119, label = 'aluminum'},
    -- Metal
    { index = 120, label = 'chrome'},
    { index = 37, label = 'gold'},
    { index = 158, label = 'gold'},
    { index = 159, label = 'gold'},
    { index = 160, label = 'gold'}
}





function GetPedSex(ped)
    if ped and type(ped) == 'number' then
        if IsPedModel(ped, 'mp_f_freemode_01') then
            sex = 'female'
        elseif IsPedModel(ped, 'mp_m_freemode_01') then
            sex = 'male'
        else
            sex = 'person'
        end
        return sex
    else
        print('dispatch - error 746515')
    end
end

function GetStreetNames(coords)
    if coords and type(coords) == 'vector3' then
        local street = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
        local street1 = GetStreetNameFromHashKey(street)
        local zone = tostring(GetNameOfZone(coords.x, coords.y, coords.z))
        local street2 = zoneNames[tostring(zone)]
        return {street1 = street1, street2 = street2}
    else
        print('dispatch - error 468511')
    end
end

function GetVehicleColour(vehicle)
    if vehicle and type(vehicle) == 'number' then
        local primary, secondary = GetVehicleColours(vehicle)
        local carcolour = nil
        for k, v in pairs (CarColours) do
            if v.index == primary then
                carcolour = v.label
                break
            end
        end
        return carcolour
    else
        print('dispatch - error 4645465')
    end
end

function GetVehicleLabel(vehicle)
    if vehicle and type(vehicle) == 'number' then
        local vehicleLabel = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))

        if vehicleLabel == 'null' or vehicleLabel == 'carnotfound' or vehicleLabel == 'NULL' then
            vehicleLabel = 'vehicle'
        end
        if vehicleLabel ~= 'null' or vehicleLabel ~= 'carnotfound' or vehicleLabel ~= 'NULL'then
            local text = GetLabelText(vehicleLabel)
            if text == nil or text == 'null' or text == 'NULL' then
                vehicleLabel = vehicleLabel
            else
                vehicleLabel = text
            end
        end
        return vehicleLabel
    else
        print('dispatch - error 165468')
    end
end

function GetPlayerInfo()
    local ped = PlayerPedId()
    if ped then
        local coords = GetEntityCoords(ped)
        if coords then
            local streetnames = GetStreetNames(coords)
            if streetnames then
                local sex = GetPedSex(ped)
                if sex then
                    if IsPedInAnyVehicle(ped,true) then
                        vehicle = GetVehiclePedIsIn(ped, false)
                        vehicle_label = GetVehicleLabel(vehicle)
			vehicle_plate = GetVehicleNumberPlateText(vehicle)
                        vehicle_colour = GetVehicleColour(vehicle)
                    else
                        vehicle = nil
                        vehicle_label = nil
                        vehicle_colour = nil
                    end
                    return {
                        ped = ped,
                        coords = coords,
                        street_1 = streetnames.street1,
                        street_2 = streetnames.street2,
                        sex = sex,
                        vehicle = vehicle,
                        vehicle_label = vehicle_label,
			vehicle_plate = vehicle_plate,
                        vehicle_colour = vehicle_colour
                    }
                else
                    print('dispatch - error 986465')
                end
            else
                print('dispatch - error 7496554')
            end
        else
            print('dispatch - error 35154656')
        end
    else
        print('dispatch - error 46853615')
    end
end