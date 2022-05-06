local spawnedCoral = 0
local coralPlants = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.CoralField.coords, true) < 100 then
			SpawnCoralPlants()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(50)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #coralPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(coralPlants[i]), false) < 2 then
				nearbyObject, nearbyID = coralPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('coral_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				--ESX.TriggerServerCallback('esx_drugs:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

						Citizen.Wait(150)
						ClearPedTasks(playerPed)
						Citizen.Wait(150)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(coralPlants, nearbyID)
						spawnedCoral = spawnedCoral - 1
		
						TriggerServerEvent('esx_drugs:pickedUpCoral')
					else
						ESX.ShowNotification(_U('coral_inventoryfull'))
					end

					--isPickingUp = false

				--end, 'coral')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(coralPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnCoralPlants()
	while spawnedCoral < 50 do
		Citizen.Wait(1)
		local coralCoords = GenerateCoralCoords()

		ESX.Game.SpawnLocalObject('prop_coral_01', coralCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(coralPlants, obj)
			spawnedCoral = spawnedCoral + 1
		end)
	end
end



function ValidateCoralCoord(plantCoord)
	if spawnedCoral > 0 then
		local validate = true

		for k, v in pairs(coralPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.CoralField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateCoralCoords()
	while true do
		Citizen.Wait(1)

		local coralCoordX, coralCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-90, 90)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-90, 90)

		coralCoordX = Config.CircleZones.CoralField.coords.x + modX
		coralCoordY = Config.CircleZones.CoralField.coords.y + modY

		local coordZ = GetCoordZ(coralCoordX, coralCoordY)
		local coord = vector3(coralCoordX, coralCoordY, coordZ)

		if ValidateCoralCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end