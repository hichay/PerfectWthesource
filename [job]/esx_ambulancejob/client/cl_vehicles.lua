Citizen.CreateThread(function()
    for k,v in ipairs(VehiclesConfig) do
        
        exports["pw-npcs"]:RegisterNPC(v["NPC"],"name_"..v["NPC"].id)

        local group = { "isEmsVehicleSeller" }
        local data = {
            {
                id = "ems_vehicles_" .. k,
                label = v["Label"],
                icon = "taxi",
                event = "pw-ems:showVehicles",
                parameters = v,
            }
        }


        local options = {
            distance = { radius = 2.5 },
            isEnabled = function()
                return ESX.GetPlayerData().job.name == v["Job"]
            end
        }
        exports["pw-interact"]:AddPeekEntryByFlag(group, data, options)
    end
end)


AddEventHandler("pw-ems:showVehicles", function()
    local datamen = {}
    for k,v in ipairs(VehiclesConfig) do
        for _, vehicle in ipairs(v["Vehicles"]) do
            vehicle.garage = v["Garage"]
            vehicle.spawn = v["Spawn"]
            datamen[#datamen + 1] = {

				title = vehicle.name,
				description = "$" .. vehicle.price,
				image = vehicle.image,
				children = {
					{ icon = "check", description = '' ,title = "Mua xe", action = "pw-ems:buyVeh", key = {vehicle = vehicle, spawn = v['Spawn']} },
				},
			}
        end
    end

    --exports["np-ui"]:showContextMenu(datamen)
    exports["pw-context"]:showContextMenu(datamen)
end)


AddEventHandler("pw-ems:buyVeh", function(params)
    local vehicle = params.vehicle
    local hash = GetHashKey(vehicle.model)
    local success = RPC.execute('pw-policejob:buyJobVehicle',vehicle.price)
    local newPlate = exports['pw-vehicleshop']:GeneratePlate()
    if success then
        if not HasModelLoaded(hash) then
            RequestModel(hash)
            while not HasModelLoaded(hash) do
                Citizen.Wait(10)
            end
        end

        local lastSelectedVehicleEntity = CreateVehicle(hash, 442.23022, -978.9822, -107.6886, 23.429121, false, false)
        local vehicleProps = ESX.Game.GetVehicleProperties(lastSelectedVehicleEntity)
        vehicleProps.plate = newPlate

        stats = {
            ["engine_damage"] = GetVehicleEngineHealth(lastSelectedVehicleEntity),
            ["body_damage"] = GetVehicleBodyHealth(lastSelectedVehicleEntity),
            ["fuel"] = GetVehicleFuelLevel(lastSelectedVehicleEntity),
            ["dirty"] = GetVehicleDirtLevel(lastSelectedVehicleEntity),
            ["radiator"] = 100,
            ["axle"] = 100,
            ["brake"] = 100,
            ["clutch"] = 100,
            ["tire"] = 100,
            ["electronics"] = 100,
            ["transmission"] = 100,
            ["injector"] = 100,
        }

        TriggerServerEvent('pw-policejob:server:setVehicleOwned', vehicleProps, stats,vehicle.model, ESX.GetPlayerData().job.name, vehicle.garage)
        ESX.Game.SpawnVehicle(vehicle.model, vehicle.spawn.coords, vehicle.spawn.heading, function(veh)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            SetVehicleNumberPlateText(veh, vehicleProps.plate)
            TriggerEvent("vehiclekeys:client:SetOwner", ESX.Game.GetVehicleProperties(veh).plate)
        end)

        if lastSelectedVehicleEntity ~= nil then
            DeleteVehicle(lastSelectedVehicleEntity)
        end
        TriggerEvent('DoLongHudText',"Mua xe thành công",1)
    else
        TriggerEvent('DoLongHudText',"Không có đủ tiền để thực hiện",2)
    end

end)