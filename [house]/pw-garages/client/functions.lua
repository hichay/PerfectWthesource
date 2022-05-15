ESX = nil
local  createdBlips = {}
local hello = false
playerCid = nil
Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    while true do
        Citizen.Wait(10)
        if ESX == nil then
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(200)
        end
    end
end)

PWGarages = {}
PWGarages.Config = {}
PWGarages.Functions = {
    TriggerNUI = (function(onVehicle, name, data, key)
        if key == 'garages' or key == 'houses' then
            ESX.TriggerServerCallback('pw-garages:server:getOwnedVehicles', function(vehicles)
                while not vehicles do Wait(0) end
    
                if onVehicle then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                    ESX.TriggerServerCallback('pw-garages:server:isVehicleOwned', function(owned)
                       
                        if owned then
                            SendNUIMessage({
                                open = true,
                                type = "open-garage",
                                key = key,
                                vehicles = vehicles,
                                slots = math.ceil(((#PWGarages.Functions.GetFreeSlots(name, key) * 100) / #PWGarages.Config[key][name]['slots'])),
                                garage = name,
                                vehicledata = {true, GetVehicleNumberPlateText(vehicle), PWGarages.Config[key][name]['payment']}
                            })
                        else
                            SendNUIMessage({
                                open = true,
                                type = "open-garage",
                                key = key,
                                vehicles = vehicles,
                                slots = math.ceil(((#PWGarages.Functions.GetFreeSlots(name, key) * 100) / #PWGarages.Config[key][name]['slots'])),
                                garage = name,
                                vehicledata = {false}
                            })
                        end
                    end, vehicleProps.plate)
                else
                    SendNUIMessage({
                        open = true,
                        type = "open-garage",
                        key = key,
                        vehicles = vehicles,
                        slots = math.ceil(((#PWGarages.Functions.GetFreeSlots(name, key) * 100) / #PWGarages.Config[key][name]['slots'])),
                        garage = name
                    })
                end
                SetNuiFocus(true, true)
            end, PWGarages.Functions.GetNearbyVehicles(true), #PWGarages.Functions.GetFreeSlots(name, key), name, key)
        elseif key == 'impounds' then
            ESX.TriggerServerCallback('pw-garages:server:hasFines', function(hasfines)
                if hasfines == false then
                    ESX.TriggerServerCallback('pw-garages:server:getImpoundedVehicles', function(vehicles)
                        while not vehicles do Wait(0) end
            
                        SendNUIMessage({
                            open = true,
                            type = "open-impound",
                            key = key,
                            vehicles = vehicles,
                            impound = name,
                        })
                        SetNuiFocus(true, true)
                    end, name)
                else
                    print('has fine not work')
					TriggerEvent("ESX:Notify","Hãy chắc chắn rằng bạn không nợ bill của ban ngành nào!","error")
                end
            end)
        end
    end),

    GetFreeSlotsOLD = (function(slots)
        local freeSlots = {}
        for key, slot in pairs(slots) do
            if slot[2] == true then
                --table.insert(freeSlots, key)
				freeSlots[#freeSlots + 1] = key
            end
        end
        return freeSlots
    end),

    CreateBlips = function()
        for key, value in pairs(PWGarages.Config) do
			
            if key == 'garages' then

                for name, data in pairs(value) do
                    local garagetype = ""
                    if data['payment']['onetime'] == true then 
                        garagetype = "Thuê giờ"
                        color = 43
                    else 
                        garagetype = "Trả một lần"
                        color = 59
                    end

                    if data['blip']['enable'] == true then
                        local blip = AddBlipForCoord(data['blip']['coords'].x, data['blip']['coords'].y, data['blip']['coords'].z)
                        SetBlipSprite(blip, PWGarages.Config['settings']['blip'][data['blip']['type']][2])
                        SetBlipDisplay(blip, PWGarages.Config['settings']['blip'][data['blip']['type']][3])
                        SetBlipScale(blip, PWGarages.Config['settings']['blip'][data['blip']['type']][4])
                        SetBlipColour(blip, color)
                        SetBlipAsShortRange(blip, true)
                    
                        BeginTextCommandSetBlipName("CUSTOM_TEXT")
                        AddTextComponentString('Garage để xe '..garagetype)
                        EndTextCommandSetBlipName(blip)
                    
                        --table.insert(createdBlips, blip)
						createdBlips[#createdBlips + 1] = blip
                    end
                end
            elseif key == 'impounds' then 
                for name, data in pairs(value) do
                    if data['blip']['enable'] == true then
                        local blip = AddBlipForCoord(data['blip']['coords'].x, data['blip']['coords'].y, data['blip']['coords'].z)
                        SetBlipSprite(blip, PWGarages.Config['settings']['blip'][data['blip']['type']][2])
                        SetBlipDisplay(blip, PWGarages.Config['settings']['blip'][data['blip']['type']][3])
                        SetBlipScale(blip, PWGarages.Config['settings']['blip'][data['blip']['type']][4])
                        SetBlipColour(blip, PWGarages.Config['settings']['blip'][data['blip']['type']][1])
                        SetBlipAsShortRange(blip, true)
                    
                        BeginTextCommandSetBlipName("CUSTOM_TEXT")
                        AddTextComponentString('Garage chuộc xe')
                        EndTextCommandSetBlipName(blip)
                    
                        --table.insert(createdBlips, blip)
						createdBlips[#createdBlips + 1] = blip
                    end
                end
            elseif key == 'houses' then
                for name, data in pairs(value) do
                    if PWGarages.Functions.HasHouseAccess(name) == true then
                        local blip = AddBlipForCoord(data['coords'].x, data['coords'].y, data['coords'].z)
                        SetBlipSprite(blip, PWGarages.Config['settings']['blip']['house'][2])
                        SetBlipDisplay(blip, PWGarages.Config['settings']['blip']['house'][3])
                        SetBlipScale(blip, PWGarages.Config['settings']['blip']['house'][4])
                        SetBlipColour(blip, PWGarages.Config['settings']['blip']['house'][1])
                        SetBlipAsShortRange(blip, true)
                    
                        BeginTextCommandSetBlipName("CUSTOM_TEXT")
                        AddTextComponentString("Garage nhà: "..name)
                        EndTextCommandSetBlipName(blip)
                    
                        --table.insert(createdBlips, blip)
						createdBlips[#createdBlips + 1] = blip
                    end
                end
            end
        end
    end,

    HasHouseAccess = function(house)
        for key, value in pairs(PWGarages.Config['houses'][house]['acess']) do
            --print(key,value)
            if value == ESX.GetPlayerData().identifier then
                return true
            end
        end

        return false
       

    end,

    DeleteBlips = function()
        for k, v in pairs(createdBlips) do
            RemoveBlip(v)
        end
    end,

    DrawText3D = (function(vector, text)
        local onScreen, _x,_y = World3dToScreen2d(vector.x, vector.y, vector.z)
        local px,py,pz = table.unpack(GetGameplayCamCoords())
        local scale = 0.30
        if onScreen then
            SetTextScale(scale, scale)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(255, 255, 255, 215)
            SetTextOutline()
            SetTextEntry("CUSTOM_TEXT")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x,_y)
        end
    end),
    ShowFloatingHelpNotification123 = (function(msg, coords)
        if string.match(msg, "~INPUT_PICKUP~") then
            msg = msg:gsub("~INPUT_PICKUP~", "[E]")
            end
        AddTextEntry('asdFloatingHelpNotification', msg)
        SetFloatingHelpTextWorldPosition(1, coords)
        SetFloatingHelpTextStyle(1, 1, 2, 2, 3, 4)
        BeginTextCommandDisplayHelp('asdFloatingHelpNotification')
        EndTextCommandDisplayHelp(2, false, false, -1)
    
    end),
    GetNearbyVehicles = (function(plates)
        local playerPed = PlayerPedId()
        local nearbyVehicles = ESX.Game.GetVehicles()
        local nearbyPlates = {}
        for k, v in pairs(nearbyVehicles) do
			
            if #(GetEntityCoords(v) - GetEntityCoords(playerPed)) < 10.0 then
                if plates == true then
					local data = ESX.Game.GetVehicleProperties(v)
                    --table.insert(nearbyPlates, data.plate)
					nearbyPlates[#nearbyPlates + 1] = data.plate
                else
                    local data = ESX.Game.GetVehicleProperties(v)
					--table.insert(nearbyPlates, {v, data.plate})
					nearbyPlates[#nearbyPlates +1] = {v, data.plate}
                    
                end
            end
        end
        return nearbyPlates
    end),

    IsSpawnClear = (function(coords, area)
        local vehicles = ESX.Game.GetVehicles()
        local vehiclesInArea = {}
    
        for i=1, #vehicles, 1 do
            local vehicleCoords = GetEntityCoords(vehicles[i])
            local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)
    
            if distance <= area then
                --table.insert(vehiclesInArea, vehicles[i])
				vehiclesInArea[#vehiclesInArea + 1 ] = vehicles[i]
            end
        end
        
        return #vehiclesInArea == 0
    end),

    GetClosestImpound = (function()
        local ped = PlayerPedId()
        local closestImpound = {10000.0}
        for k, v in pairs(PWGarages.Config['impounds']) do
            local coords = GetEntityCoords(ped)
            local dst = #(v['blip']['coords']) 
            if dst < closestImpound[1] then
                closestImpound = {dst, v['blip']['coords']}
            end
        end
    
        return closestImpound
    end),
    
    GetClosestGarage = (function()
        local ped = PlayerPedId()
        local closestImpound = {10000.0}
        for k, v in pairs(PWGarages.Config['garages']) do
            local coords = GetEntityCoords(ped)
            local dst = #(vector3(v['blip']['coords'].x ,v['blip']['coords'].y ,v['blip']['coords'].z) - coords) 
            if dst < closestImpound[1] then
                closestImpound = {dst, k}
            end
        end
    
        return closestImpound
    end),

    GetClosestHouse = (function()
        local ped = PlayerPedId()
        local closestHouse = {10000.0}
        for k, v in pairs(PWGarages.Config['houses']) do
            local coords = GetEntityCoords(ped)
            local dst = #(v['coords']) 
            if dst < closestHouse[1] then
                closestHouse = {dst, k}
            end
        end
    
        return closestHouse
    end),
    
    GetFreeSlots = (function(name, typ)
        local slots = PWGarages.Config[typ][name]['slots']
        local counter = {}
        for k, v in pairs(slots) do
            if v[2] == true then
                --table.insert(counter, k)
				counter[#counter + 1] = k
            end
        end
        return counter
    end),

    DeletePlayerVehicle = (function(plate)
        local stats = {}
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            ESX.TriggerServerCallback('pw-garages:server:GetVehicleStatus', function(statsvalue)
                print(statsvalue.engine_damage)
                stats = {
                    ["engine_damage"] = statsvalue.engine_damage, 
                    ["body_damage"] = statsvalue.body_damage, 
                    ["fuel"] = statsvalue.fuel, 
                    ["dirty"] = statsvalue.dirty,
                    ["radiator"] = statsvalue.radiator,
                    ["axle"] = statsvalue.axle, 
                    ["brakes"] = statsvalue.brakes,
                    ["clutch"] = statsvalue.clutch,
                    ["tire"] = statsvalue.tire,
                    ["cooling"] = statsvalue.cooling,
                    ["electonic"] = statsvalue.electonic,
                }
                
            end,plate)
            ESX.Game.DeleteVehicle(veh)
            
        else
            local vehicles = PWGarages.Functions.GetNearbyVehicles(false)
            for _, vehicle in pairs(vehicles) do
                if vehicle[2] == plate then
                    local veh = vehicle[1]
                    stats = {
                        ["engine_damage"] = ESX.Game.GetVehicleProperties(veh).engineHealth, 
                        ["body_damage"] = ESX.Game.GetVehicleProperties(veh).bodyHealth, 
                        ["fuel"] = ESX.Math.Round(ESX.Game.GetVehicleProperties(veh).fuelLevel,1), 
                        ["dirty"] = ESX.Game.GetVehicleProperties(veh).dirtLevel,
                    }
                    ESX.Game.DeleteVehicle(veh)
                end
            end
        end
        
        return stats
        
    end),

    drawTxt = function(x, y, s, ss , text, red, green, blue, alpha)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(s, s)
        SetTextColour(red, green, blue, alpha)
        SetTextDropShadow(0, 0, 0, 0, 255)
        if ss then
            SetTextEdge(1, 0, 0, 0, 255)
        end
        SetTextDropShadow()
        SetTextOutline()
    
        BeginTextCommandDisplayText("CUSTOM_TEXT")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(x, y - 1 / 2 - 0.065)
    end,

    playAnim = function()
        local ped = PlayerPedId()
        local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
        local animation = "machinic_loop_mechandplayer"
        if IsPedArmed(ped, 7) then
            SetCurrentPedWeapon(ped, 0xA2719263, true)
        end
    
        if IsEntityPlayingAnim(ped, animDict, animation, 3) then
            ClearPedSecondaryTask(ped)
        else
            PWGarages.Functions.loadAnimDict(animDict)
            local animLength = GetAnimDuration(animDict, animation)
            TaskPlayAnim(PlayerPedId(), animDict, animation, 1.0, 4.0, animLength, 0, 0, 0, 0, 0)
        end
    end,

    loadAnimDict = function(dict)
        while not HasAnimDictLoaded(dict) do
            RequestAnimDict(dict)
            Citizen.Wait(5)
        end
    end,

    tprint = function(a,b) for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end,
}