Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

ESX = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if ESX == nil then
            TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end) 
            Citizen.Wait(200)
        end
    end
end)

-- Code

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local occasionVehicles = {}
local inRange
local vehiclesSpawned = false
local isConfirming = false

Citizen.CreateThread(function()
    while true do
        inRange = false
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        if ESX ~= nil then
            for _,slot in pairs(Config.OccasionSlots) do
                local dist = GetDistanceBetweenCoords(pos, slot["x"], slot["y"], slot["z"])

                if dist <= 40 then
                    inRange = true
                    if not vehiclesSpawned then
                        vehiclesSpawned = true

                        ESX.TriggerServerCallback('rl-occasions:server:getVehicles', function(vehicles)
                            occasionVehicles = vehicles
                            despawnOccasionsVehicles()
                            spawnOccasionsVehicles(vehicles)
                        end)
                    end
                end
            end

            if inRange then
                for i = 1, #Config.OccasionSlots, 1 do
                    local vehPos = GetEntityCoords(Config.OccasionSlots[i]["occasionid"])
                    local dstCheck = GetDistanceBetweenCoords(pos, vehPos)

                    if dstCheck <= 2 then
                        if not IsPedInAnyVehicle(ped) then
                            if not isConfirming then
                                DrawText3Ds(vehPos.x, vehPos.y, vehPos.z + 1.45, '~g~E~w~ xem hợp đồng')
                                DrawText3Ds(vehPos.x, vehPos.y, vehPos.z + 1.25, Config.OccasionSlots[i]["model"]..', Giá: €'..Config.OccasionSlots[i]["price"]..',-')
                                if Config.OccasionSlots[i]["owner"] == ESX.GetPlayerData().identifier then
                                    DrawText3Ds(vehPos.x, vehPos.y, vehPos.z + 1.05, '~r~G~w~ để lấy lại xe')
                                    if IsControlJustPressed(0, Keys["G"]) then
                                        isConfirming = true
                                    end
                                end
                                if IsControlJustPressed(0, Keys["E"]) then
                                    currentVehicle = i
                                    
                                    ESX.TriggerServerCallback('rl-occasions:server:getSellerInformation', function(info)
                                        if info ~= nil then 
                                            account = json.decode(info.accounts)
                                        else
                                            info = {}
                                            info.charinfo = {
                                                firstname = "Not",
                                                lastname = "known..",
                                                account = "Account unknown..",
                                                phone = "Phone number unknown.."
                                            }
                                        end
                                        
                                        openBuyContract(info, Config.OccasionSlots[currentVehicle])
                                    end, Config.OccasionSlots[currentVehicle]["owner"])
                                end
                            else
                                DrawText3Ds(vehPos.x, vehPos.y, vehPos.z + 1.45, 'Are you sure you want to take your vehicle off the occasions?')
                                DrawText3Ds(vehPos.x, vehPos.y, vehPos.z + 1.25, '~g~7~w~ - Yes | ~r~8~w~ - No')
                                if IsDisabledControlJustPressed(0, Keys["7"]) then
                                    isConfirming = false
                                    currentVehicle = i
                                    TriggerServerEvent("rl-occasions:server:ReturnVehicle", Config.OccasionSlots[i])
                                end
                                if IsDisabledControlJustPressed(0, Keys["8"]) then
                                    isConfirming = false
                                end
                            end
                        end
                    end
                end

                local sellDist = GetDistanceBetweenCoords(pos, Config.SellVehicle["x"], Config.SellVehicle["y"], Config.SellVehicle["z"])

                if sellDist <= 13.0 and IsPedInAnyVehicle(ped) then 
                    DrawMarker(2, Config.SellVehicle["x"], Config.SellVehicle["y"], Config.SellVehicle["z"] + 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.6, 255, 0, 0, 155, false, false, false, true, false, false, false)
                    if sellDist <= 3.5 and IsPedInAnyVehicle(ped) then
                        DrawText3Ds(Config.SellVehicle["x"], Config.SellVehicle["y"], Config.SellVehicle["z"], '~g~E~w~ - Put vehicle for sale')
                        if IsControlJustPressed(0, Keys["E"]) then
                            local VehiclePlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(ped))
                            ESX.TriggerServerCallback('rl-garage:server:checkVehicleOwner', function(owned)
                                if owned then
								ESX.TriggerServerCallback('rl-occasions:server:getSellerInformation', function(info)
                                    openSellContract(true,info)
								end, ESX.GetPlayerData().identifier)	
                                else
                                    RLCore.Functions.Notify('This is not your vehicle?', 'error', 3500)
									print('This is not your vehicle?')
                                end
                            end, VehiclePlate)
                        end
                    end
                end
            end

            if not inRange then
                if vehiclesSpawned then
                    vehiclesSpawned = false
                    despawnOccasionsVehicles()
                end
                Citizen.Wait(1000)
            end
        end

        Citizen.Wait(3)
    end
end)

function spawnOccasionsVehicles(vehicles)
    local oSlot = Config.OccasionSlots

    if vehicles ~= nil then
        for i = 1, #vehicles, 1 do
            local model = GetHashKey(vehicles[i].model)
            RequestModel(model)
            while not HasModelLoaded(model) do
                Citizen.Wait(0)
            end

            oSlot[i]["occasionid"] = CreateVehicle(model, oSlot[i]["x"], oSlot[i]["y"], oSlot[i]["z"], false, false)

            oSlot[i]["price"] = vehicles[i].price
            oSlot[i]["owner"] = vehicles[i].seller
            oSlot[i]["model"] = vehicles[i].model
            oSlot[i]["plate"] = vehicles[i].plate
            oSlot[i]["oid"]   = vehicles[i].occasionid
            oSlot[i]["desc"]  = vehicles[i].description
            oSlot[i]["mods"]  = vehicles[i].mods

                    
            ESX.Game.SetVehicleProperties(oSlot[i]["occasionid"], json.decode(oSlot[i]["mods"]))

            SetModelAsNoLongerNeeded(model)
            SetVehicleOnGroundProperly(oSlot[i]["occasionid"])
            SetEntityInvincible(oSlot[i]["occasionid"],true)
            SetEntityHeading(oSlot[i]["occasionid"], oSlot[i]["h"])
            SetVehicleDoorsLocked(oSlot[i]["occasionid"], 3)

            SetVehicleNumberPlateText(oSlot[i]["occasionid"], vehicles[i].occasionid)
            FreezeEntityPosition(oSlot[i]["occasionid"],true)
        end
    end
end

function despawnOccasionsVehicles()
    local oSlot = Config.OccasionSlots
    for i = 1, #Config.OccasionSlots, 1 do
        local oldVehicle = GetClosestVehicle(Config.OccasionSlots[i]["x"], Config.OccasionSlots[i]["y"], Config.OccasionSlots[i]["z"], 1.3, 0, 70)
        if oldVehicle ~= 0 then
            ESX.Game.DeleteVehicle(oldVehicle)
        end
    end
end

function openSellContract(bool,data)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "sellVehicle",
        pData = data,
        plate = GetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1)))
    })
end

function openBuyContract(sellerData, vehicleData)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "buyVehicle",
        sellerData = sellerData,
        vehicleData = vehicleData
    })
end

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('error', function(data)
    RLCore.Functions.Notify(data.message, 'error')
end)

RegisterNUICallback('buyVehicle', function()
    local vehData = Config.OccasionSlots[currentVehicle]
    TriggerServerEvent('rl-occasions:server:buyVehicle', vehData)
end)

DoScreenFadeIn(250)

RegisterNetEvent('rl-occasions:client:BuyFinished')
AddEventHandler('rl-occasions:client:BuyFinished', function(model, plate, mods)
    local vehmods = json.decode(mods)

    DoScreenFadeOut(250)
    Citizen.Wait(500)
    ESX.Game.SpawnVehicleqb(model, function(veh)
        SetVehicleNumberPlateText(veh, plate)
        SetEntityHeading(veh, Config.BuyVehicle.h)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        exports['rl-hud']:SetFuel(veh, 100)
		print('buy car')
        --RLCore.Functions.Notify("Bought Vehicle", "success", 2500)
        TriggerEvent("vehiclekeys:client:SetOwner", plate, veh)
        SetVehicleEngineOn(veh, true, true)
        Citizen.Wait(500)
        ESX.Game.SetVehicleProperties(veh, vehmods)
    end, Config.BuyVehicle, true)
    Citizen.Wait(500)
    DoScreenFadeIn(250)
    currentVehicle = nil
end)

RegisterNetEvent('rl-occasions:client:ReturnOwnedVehicle')
AddEventHandler('rl-occasions:client:ReturnOwnedVehicle', function(vehdata)
    local vehmods = json.decode(vehdata.mods)
    DoScreenFadeOut(250)
    Citizen.Wait(500)
    ESX.Game.SpawnVehicleqb(vehdata.model, function(veh)
        SetVehicleNumberPlateText(veh, vehdata.plate)
        SetEntityHeading(veh, Config.BuyVehicle.h)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        exports['rl-hud']:SetFuel(veh, 100)
        --RLCore.Functions.Notify("Your vehicle is up for sale again..")
        TriggerEvent("vehiclekeys:client:SetOwner", vehdata.plate, veh)
        SetVehicleEngineOn(veh, true, true)
        Citizen.Wait(500)
        ESX.Game.SetVehicleProperties(veh, vehmods)
    end, Config.BuyVehicle, true)
    Citizen.Wait(500)
    DoScreenFadeIn(250)
    currentVehicle = nil
end)

RegisterNUICallback('sellVehicle', function(data)
    local vehicleData = {}
	
    local PlayerData = ESX.GetPlayerData()
    vehicleData.ent = GetVehiclePedIsUsing(GetPlayerPed(-1))
    vehicleData.model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicleData.ent))
    vehicleData.plate = GetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1)))
    vehicleData.mods = ESX.Game.GetVehicleProperties(vehicleData.ent)
	local stats = {}
	stats = {
                ["engine_damage"] = ESX.Game.GetVehicleProperties(vehicleData.ent).engineHealth, 
                ["body_damage"] = ESX.Game.GetVehicleProperties(vehicleData.ent).bodyHealth, 
                ["fuel"] = ESX.Math.Round(ESX.Game.GetVehicleProperties(vehicleData.ent).fuelLevel,1), 
                ["dirty"] = ESX.Game.GetVehicleProperties(vehicleData.ent).dirtLevel,
            }
	vehicleData.stats = stats
    vehicleData.desc = data.desc

    TriggerServerEvent('rl-occasions:server:sellVehicle', data.price, vehicleData)
    sellVehicleWait(data.price)
end)

function sellVehicleWait(price)
    DoScreenFadeOut(250)
    Citizen.Wait(250)
    ESX.Game.DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
    Citizen.Wait(1500)
    DoScreenFadeIn(250)
	print('Your vehicle is upto sale for, €'..price)
    --RLCore.Functions.Notify('Your vehicle is upto sale for, €'..price..',-', 'success')
    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
end

RegisterNetEvent('rl-occasion:client:refreshVehicles')
AddEventHandler('rl-occasion:client:refreshVehicles', function()
    if inRange then
        ESX.TriggerServerCallback('rl-occasions:server:getVehicles', function(vehicles)
            occasionVehicles = vehicles
            despawnOccasionsVehicles()
            spawnOccasionsVehicles(vehicles)
        end)
    end
end)

Citizen.CreateThread(function()
    OccasionBlip = AddBlipForCoord(Config.SellVehicle["x"], Config.SellVehicle["y"], Config.SellVehicle["z"])

    SetBlipSprite (OccasionBlip, 326)
    SetBlipDisplay(OccasionBlip, 4)
    SetBlipScale  (OccasionBlip, 0.75)
    SetBlipAsShortRange(OccasionBlip, true)
    SetBlipColour(OccasionBlip, 3)

    BeginTextCommandSetBlipName("CUSTOM_TEXT")
    AddTextComponentSubstringPlayerName("Larry's RV Sales")
    EndTextCommandSetBlipName(OccasionBlip)
end)