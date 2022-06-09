ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)


ModdedVehicles = {}
VehicleStatus = {}
ClosestPlate = nil
isLoggedIn = true
insidegarage = false
PlayerJob = {}
markers = {}
inmark = false
cancel = true
garagename = nil
stashname = nil

local onDuty = false
local ShowingNotification = false
local ShowingCheckNoti = false

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("CUSTOM_TEXT")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

--[[ Citizen.CreateThread(function()
    while true do
        if isLoggedIn then
            SetClosestPlate()
        end
        Citizen.Wait(1000)
    end
end)

function SetClosestPlate()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for id,_ in pairs(Config.Plates) do
        if current ~= nil then
            if #(pos - vector3(Config.Plates[id].coords.x, Config.Plates[id].coords.y, Config.Plates[id].coords.z)) < dist then
                current = id
                dist = #(pos - vector3(Config.Plates[id].coords.x, Config.Plates[id].coords.y, Config.Plates[id].coords.z))
            end
        else
            dist = #(pos - vector3(Config.Plates[id].coords.x, Config.Plates[id].coords.y, Config.Plates[id].coords.z))
            current = id
        end
    end
    ClosestPlate = current
end ]]

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    -- ESX.GetPlayerData(function(PlayerData)
        -- PlayerJob = PlayerData.job
        -- if PlayerData.job.onduty then
            -- if PlayerData.job.name == "mechanic" then
                -- TriggerServerEvent("QBCore:ToggleDuty")
            -- end
        -- end
    -- end)
    isLoggedIn = true
    --[[ ESX.TriggerServerCallback('pw-mechanicjob:server:GetAttachedVehicle', function(plates)
        for k, v in pairs(plates) do
            Config.Plates[k].AttachedVehicle = v.AttachedVehicle
        end
    end) ]]

end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    PlayerJob = PlayerData.job.name
end)

-- RegisterNetEvent('QBCore:Client:SetDuty')
-- AddEventHandler('QBCore:Client:SetDuty', function(duty)
    -- onDuty = duty
-- end)


Citizen.CreateThread(function()
    Wait(2000)
    for k, v in pairs (Config.Customs) do
        local blip = AddBlipForCoord(v.shopcoord.x, v.shopcoord.y, v.shopcoord.z)
        SetBlipSprite (blip, v.Blips.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, v.Blips.scale)
        SetBlipColour (blip, v.Blips.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('CUSTOM_TEXT')
        AddTextComponentSubstringPlayerName("Xưởng sửa xe: ~r~"..k.."")
        EndTextCommandSetBlipName(blip)
    end
end)


CreateThread(function()
    Wait(500)
    while true do
        for k,v in pairs(Config.Customs) do
            local distance = #(GetEntityCoords(PlayerPedId()) - vector3(v.shopcoord.x,v.shopcoord.y,v.shopcoord.z))
            if distance < v.radius then
                TriggerEvent('pw-mechanicjob:ingarage',v,k)
                TriggerEvent('pw-mechanicjob:Solo',v,k)
                while distance < v.radius do
                    distance = #(GetEntityCoords(PlayerPedId()) - vector3(v.shopcoord.x,v.shopcoord.y,v.shopcoord.z))
                    Wait(500)
                end
            else
                insidegarage = false
            end
        end
        Wait(1000)
    end
end)


RegisterNetEvent('pw-mechanicjob:ingarage')
AddEventHandler('pw-mechanicjob:ingarage', function(garage,garage_id)
    currentprivate = garage_id
    garagename = garage
    insidegarage = true

    CreateThread(function()
        Wait(2000)
        local stats_show = nil
        while insidegarage do
            Wait(500)
            for k,v in pairs(Config.Customs) do
                --print(k)
                garagename = k
                
                if v.attachvehicle then 
                    for n,m in pairs(v.attachvehicle) do 
                        local distance = #(GetEntityCoords(PlayerPedId()) - vector3(m.coord.x,m.coord.y,m.coord.z))
                        local invehicle = IsPedInAnyVehicle(PlayerPedId())
                        local vehicle = GetVehiclePedIsIn(PlayerPedId())
                        if distance < 10 and invehicle and MechanicPermission(currentprivate) then
                            if distance < 3 and invehicle then 
                                --DrawMarkerInput(vector3(v.coord.x,v.coord.y,v.coord.z),'Upgrade Menu','renzu_customs:openmenu',false,'mod_'..k)
                                if m.AttachedVehicle == false and invehicle then
                                    DrawMarkerInput(vector3(m.coord.x,m.coord.y,m.coord.z),'pw-mechanicjob:AttachVehicle',false,k,{data = m,garagename =garagename, slot = n})
                                    ClosestPlate = n
                                else
                                    TriggerNoDraw(vector3(m.coord.x,m.coord.y,m.coord.z),'pw-mechanicjob:MainMenu',false)
                                end
                            end 
                        end                  
                    end
                end

                if v.vehiclespawn then 
                    local distance = #(GetEntityCoords(PlayerPedId()) - v.vehiclespawn.coord)
                    if distance < 10 and MechanicPermission(currentprivate) then
                        local invehicle = IsPedInAnyVehicle(PlayerPedId())
                        if distance < 3 and not invehicle then 
                            if not ShowingNotification then
                                ShowingNotification = true
                                exports["pw-interaction"]:showInteraction("[E] Lấy xe")
                            end
                            DrawMarkerInput(v.vehiclespawn.coord,'pw-mechanicjob:VehicleList',false,k,{v.vehiclespawn.coord,v.vehiclespawn.heading})
                        end
                        if distance < 3 and invehicle then
                            if not ShowingNotification then
                                ShowingNotification = true
                                exports["pw-interaction"]:showInteraction("[E] Xóa xe")
                            end
                            DrawMarkerInput(v.vehiclespawn.coord,'pw-mechanicjob:DeleteSpawnVehicle',false,k)
                        end
                    else 
                        ShowingNotification = false
                        exports["pw-interaction"]:hideInteraction()
                    end
                end
            end
            
        end
    end)
end)

RegisterNetEvent('pw-mechanicjob:Solo')
AddEventHandler('pw-mechanicjob:Solo', function(garage,garage_id)
    currentprivate = garage_id
    stashname = string.gsub(currentprivate, "%s+", "")
    local stashmenu = nil
    local craftitem1 = nil
    local craftitem2 = nil
    local bossmenu = nil
    for k,v in pairs(Config.Customs) do
        stashmenu = v.stashinventory
        exports['pw-polytarget']:AddCircleZone("mechanic_stash", stashmenu.coord, stashmenu.radius, stashmenu.options)

        craftitem1 = v.craft1
        exports['pw-polytarget']:AddCircleZone("craftitem_1", craftitem1.coord, craftitem1.radius, craftitem1.options)
        
        craftitem2 = v.craft2
        exports['pw-polytarget']:AddCircleZone("craftitem_2", craftitem2.coord, craftitem2.radius, craftitem2.options)
        
        
        bossmenu = v.bossmenu
        exports["pw-polytarget"]:AddCircleZone("mechanic_bossmenu", bossmenu.coord, bossmenu.radius, bossmenu.options)

    end
    
    
    local stash = {
        group = { "mechanic_stash" },
        data = {
            {
                id = "stash_inventory",
                label = "Kho doanh nghiệp",
                icon = "box",
                event = "pw-mechanicjob:OpenStashInventory",
            }
        },
        options = {
            distance = { radius = 1.5 },
            --[[ isEnabled = function(pEntity, pContext)
                return ShopPermmision(currentprivate,'paintmenu')
            end,  ]]
        }
    }

    exports["pw-interact"]:AddPeekEntryByPolyTarget(stash.group, stash.data, stash.options)

    local crafitem1 = {
        group = { "craftitem_1" },
        data = {
            {
                id = "craftitem_1_mechanic",
                label = "Chế mảnh",
                icon = "gavel",
                event = "pw-npcs:ped:craft",
                parameters = {craftitem1.invid},
            }
        },
        options = {
            distance = { radius = 1.5 },
            --[[ isEnabled = function(pEntity, pContext)
                return ShopPermmision(currentprivate,'paintmenu')
            end,  ]]
        }
    }

    exports["pw-interact"]:AddPeekEntryByPolyTarget(crafitem1.group, crafitem1.data, crafitem1.options)

    local crafitem2 = {
        group = { "craftitem_2" },
        data = {
            {
                id = "craftitem_2_mechanic",
                label = "Chế tạo bộ phận",
                icon = "gavel",
                event = "pw-npcs:ped:craft",
                parameters = {craftitem2.invid},
            }
        },
        options = {
            distance = { radius = 1.5 },
            --[[ isEnabled = function(pEntity, pContext)
                return ShopPermmision(currentprivate,'paintmenu')
            end,  ]]
        }
    }

    exports["pw-interact"]:AddPeekEntryByPolyTarget(crafitem2.group, crafitem2.data, crafitem2.options)

    local bossmenu = {
        group = { "mechanic_bossmenu" },
        data = {
            {
                id = "the_mechanicbossaction",
                label = "Mở boss Menu",
                icon = "people-group",
                event = "renzu_customs:OpenBossMenu",
            }
        },
        options = {
            distance = { radius = 1.5 },
            isEnabled = function(pEntity, pContext)
                return MechanicPermission(currentprivate,'bossmenu')
              end,
        }
    }

    exports["pw-interact"]:AddPeekEntryByPolyTarget(bossmenu.group, bossmenu.data, bossmenu.options)

end)

RegisterNetEvent('pw-mechanicjob:OpenStashInventory')
AddEventHandler('pw-mechanicjob:OpenStashInventory', function()
    TriggerEvent("server-inventory-open", "1", stashname.."-Mechanicbox")
end)

RegisterNetEvent('pw-mechanicjob:OpenBossMenu')
AddEventHandler('pw-mechanicjob:OpenBossMenu', function()
    TriggerServerEvent('pw-bossmenu:server:openMenu')
end)

RegisterNetEvent('pw-mechanicjob:DeleteSpawnVehicle')
AddEventHandler('pw-mechanicjob:DeleteSpawnVehicle', function()
    DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
end)


function MechanicPermission(shop, type)
    local type = type
    local shop = shop
    if PlayerData.job == nil then return false end
    if Config.Customs[shop].min_grade == nil then
        Config.Customs[shop].min_grade = true
    end
    local perms = Config.Customs[shop] ~= nil and Config.Customs[shop].job == PlayerData.job.name and PlayerData.job.grade >= Config.Customs[shop].min_grade
    if type ~= nil then
        perms = Config.Customs[shop] ~= nil and Config.Customs[shop].job == PlayerData.job.name and Config.Customs[shop] ~= nil and Config.Customs[shop][type] ~= nil and PlayerData.job.grade >= Config.Customs[shop][type].grade
    end

    return perms
end

function DrawMarkerInput(vec,event,server,name,var,u)
    if markers[name] == nil then
        markers[name] = true
        inmark = true
        CreateThread(function()
            cancel = false
            local coord = GetEntityCoords(PlayerPedId())
            local invehicle = IsPedInAnyVehicle(PlayerPedId())
            local newcarrymode = carrymode
            local newcarrymod = carrymod
            while #(vec - coord) <= 15 and not cancel and inmark do
                Citizen.Wait(5)
                coord = GetEntityCoords(PlayerPedId())

                DrawMarker(22, vec ,0,0,0,0,0,1.0,1.0,1.0,1.0,255, 255, 220,200,0,0,0,1)
                
                if invehicle ~= IsPedInAnyVehicle(PlayerPedId()) or carrymode ~= newcarrymode or carrymod ~= newcarrymod then
                    inmark = false
                    markers[name] = nil
                end
                --print(#(vec - coord))
                if IsControlJustReleased(0,38) then
                    exports["pw-interaction"]:hideInteraction()
                    ShowingNotification = false
                    if not server then
                        if u then
                            TriggerEvent(event,table.unpack(var))
                        else
                            TriggerEvent(event,var)
                        end
                    else
                        TriggerServerEvent(event,var)
                    end
                    Wait(100)
                    while #(vec - coord) < 3 and not cancel and inmark do coord = GetEntityCoords(PlayerPedId()) Wait(100) end
                    markers[name] = nil
                    break
                end
                
            end
            markers[name] = nil
            return
        end)
    end
end

function TriggerNoDraw(vec,event,server)

    inmark = true
    CreateThread(function()
        cancel = false
        local coord = GetEntityCoords(PlayerPedId())
        local invehicle = IsPedInAnyVehicle(PlayerPedId())
        local newcarrymode = carrymode
        local newcarrymod = carrymod
        while #(vec - coord) <= 15 and not cancel and inmark do
            Citizen.Wait(5)
            coord = GetEntityCoords(PlayerPedId())
            if invehicle ~= IsPedInAnyVehicle(PlayerPedId()) or carrymode ~= newcarrymode or carrymod ~= newcarrymod then
                inmark = false
            end
            --DrawMarker(22, vec ,0,0,0,0,0,1.0,1.0,1.0,1.0,255, 255, 220,200,0,0,0,1)
            --print(#(vec - coord))
            if IsControlJustReleased(0,38) then
                exports["pw-interaction"]:hideInteraction()
                ShowingNotification = false
                if not server then
                    if u then
                        TriggerEvent(event,table.unpack(var))
                    else
                        TriggerEvent(event,var)
                    end
                else
                    TriggerServerEvent(event,var)
                end
                Wait(100)
                
            end
            
        end
        return
    end)
    
end
RegisterNetEvent('pw-mechanicjob:AttachVehicle')
AddEventHandler('pw-mechanicjob:AttachVehicle', function(data)
    local attachveh= data.data
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if attachveh.AttachedVehicle == false then
        --ClosestPlate = k
        DoScreenFadeOut(150)
        Wait(150)
        attachveh.AttachedVehicle = vehicle
        SetEntityCoords(vehicle, attachveh.coord.x, attachveh.coord.y, attachveh.coord.z)
        SetEntityHeading(vehicle, attachveh.coord.w)
        FreezeEntityPosition(vehicle, true)
        Wait(500)
        DoScreenFadeIn(250)
        TriggerServerEvent('pw-mechanicjob:server:SetAttachedVehicle', vehicle, data.garagename, data.slot)
    end
end)



RegisterCommand("deat", function(source, args, rawCommand)
    --Config.Customs['Horse Brother'].attachvehicle[1].AttachedVehicle = nil
    DoScreenFadeIn(150)
    TriggerEvent('pw-mechanicjob:DetachVehicle')    
end, false)


RegisterNetEvent('pw-mechanicjob:DetachVehicle')
AddEventHandler('pw-mechanicjob:DetachVehicle', function()
    inmark = false
    cancel = true
    DoScreenFadeOut(150)
    Wait(150)
    FreezeEntityPosition(Config.Customs[garagename].attachvehicle[ClosestPlate].AttachedVehicle, false)
    SetEntityCoords(Config.Customs[garagename].attachvehicle[ClosestPlate].AttachedVehicle, Config.Customs[garagename].attachvehicle[ClosestPlate].coord.x, Config.Customs[garagename].attachvehicle[ClosestPlate].coord.y, Config.Customs[garagename].attachvehicle[ClosestPlate].coord.z)
    SetEntityHeading(Config.Customs[garagename].attachvehicle[ClosestPlate].AttachedVehicle, Config.Customs[garagename].attachvehicle[ClosestPlate].coord.w)
    TaskWarpPedIntoVehicle(PlayerPedId(), Config.Customs[garagename].attachvehicle[ClosestPlate].AttachedVehicle, -1)
    Wait(500)
    DoScreenFadeIn(250)
    Config.Customs[garagename].attachvehicle[ClosestPlate].AttachedVehicle = false
    TriggerServerEvent('pw-mechanicjob:server:SetAttachedVehicle', false, garagename, ClosestPlate)
end)

RegisterNetEvent('pw-mechanicjob:client:SetAttachedVehicle')
AddEventHandler('pw-mechanicjob:client:SetAttachedVehicle', function(veh, garage, key)
    if veh ~= false then
        Config.Customs[garage].attachvehicle[key].AttachedVehicle = veh
    else
        Config.Customs[garage].attachvehicle[key].AttachedVehicle = false
    end
end)


RegisterNetEvent('vehiclemod:client:fixEverything')
AddEventHandler('vehiclemod:client:fixEverything', function()
    if (IsPedInAnyVehicle(PlayerPedId(), false)) then
        local veh = GetVehiclePedIsIn(PlayerPedId(),false)
        if not IsThisModelABicycle(GetEntityModel(veh)) and GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
            local plate = GetVehicleNumberPlateText(veh)
            TriggerServerEvent("vehiclemod:server:fixEverything", plate)
        else
            ESX.Notify("You Are Not The Driver Or On A Bicycle", "error")
        end
    else
        ESX.Notify("You Are Not In A Vehicle", "error")
    end
end)

local openingDoor = false

function ScrapAnim(time)
    local time = time / 1000
    loadAnimDict("mp_car_bomb")
    TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    Citizen.CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(2000)
            time = time - 2
            if time <= 0 then
                openingDoor = false
                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
            end
        end
    end)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end


function round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 1) .. "f", num))
end

function noSpace(str)
    local normalisedString = string.gsub(str, "%s+", "")
    return normalisedString
end