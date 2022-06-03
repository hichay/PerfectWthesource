RegisterCommand("tete", function(source, args, rawCommand)
    TriggerEvent("pw-privateisland:VehicleList")
end, false)

Citizen.CreateThread(function()

    for k, v in pairs(Config.VehicleLocation) do
        addBlip(v.coords, 378, 0.7, 46, "[Đảo] - Thuê xe")
    end 
    for k, v in pairs(Config.HeliCopterLocation) do
        addBlip(v.coords, 576, 0.7, 46, "[Đảo] - Thuê máy bay")
    end 

end)



addBlip = function(coords, sprite, size, colour, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipScale  (blip, size)
    SetBlipColour (blip, colour)
    --SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipAlpha(blip, 0.7)
    BeginTextCommandSetBlipName("CUSTOM_TEXT")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3)
        local pos = GetEntityCoords(PlayerPedId())
        for k, v in pairs(Config.VehicleLocation) do
            if #(pos - v.coords) <= 7 then
                local pos = GetEntityCoords(PlayerPedId())
                DrawMarker(2, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)   
                local InVehicle = IsPedInAnyVehicle(PlayerPedId())

                if InVehicle then
                    DrawText3Ds(v.coords.x, v.coords.y, v.coords.z, '[E] Cất phương tiện')
                    if IsControlJustPressed(0, 38) then
                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                    end
                else
                    DrawText3Ds(v.coords.x, v.coords.y, v.coords.z, '[E] Lấy phương tiện')
                    if IsControlJustPressed(0, 38) then
                        --if IsControlJustPressed(0, 38) then
                            TriggerEvent('pw-privateisland:VehicleList', v.coords)                                       
                        --end
                    end
                
                end
            end
        end

        for k, v in pairs(Config.HeliCopterLocation) do
            if #(pos - v.coords) <= 7 then
                local pos = GetEntityCoords(PlayerPedId())
                DrawMarker(34, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)   
                local InVehicle = IsPedInAnyVehicle(PlayerPedId())

                if InVehicle then
                    DrawText3Ds(v.coords.x, v.coords.y, v.coords.z, '[E] Cất phương tiện')
                    if IsControlJustPressed(0, 38) then
                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                    end
                else
                    DrawText3Ds(v.coords.x, v.coords.y, v.coords.z, '[E] Lấy phương tiện')
                    if IsControlJustPressed(0, 38) then
                        --if IsControlJustPressed(0, 38) then
                            TriggerEvent('pw-privateisland:HeliCopter', v.coords)                                       
                        --end
                    end
                
                end
            end
        end
    end
end)



RegisterNetEvent('pw-privateisland:VehicleList', function(data)
	for k, v in pairs(Config.VehicleList) do
        --Menu.addButton(v, "SpawnListVehicle", k) 
	
		TriggerEvent('pw-context:sendMenu', {
			{
				id = k,
				header = ""..v.label,
				txt = "",
				params = {
					event = "pw-privateisland:SpawnListVehicle",
					args = {
					model = v.model,
                    price = v.price,
                    coord = data
					}
				}
			},

		})
	end
end)

RegisterNetEvent('pw-privateisland:HeliCopter', function(data)
	for k, v in pairs(Config.HelicopterList) do
        --Menu.addButton(v, "SpawnListVehicle", k) 
	
		TriggerEvent('pw-context:sendMenu', {
			{
				id = k,
				header = ""..v.label,
				txt = "",
				params = {
					event = "pw-privateisland:SpawnListVehicle",
					args = {
					model = v.model,
                    price = v.price,
                    coord = data
					}
				}
			},

		})
	end
end)



RegisterNetEvent('pw-privateisland:SpawnListVehicle')
AddEventHandler('pw-privateisland:SpawnListVehicle', function(data)
    local model = data.model
    local price = data.price
    local coords = {
        x = data.coord.x,
        y = data.coord.y,
        z = data.coord.z,
        h = 200,
    }

    ESX.Game.SpawnVehicleqb(model, function(veh)
        SetVehicleNumberPlateText(veh, "ACBV"..tostring(math.random(0000, 9999)))
        SetEntityHeading(veh, coords.h)
        exports['pw-fuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
        
end)

