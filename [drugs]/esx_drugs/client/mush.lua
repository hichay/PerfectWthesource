local spawnedMush = 0
local mushPlants = {}
local isPickingUp, isProcessing = false, false

Citizen.CreateThread(function() -- kiem tra toa do mush
      while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())
		
		if GetDistanceBetweenCoords(coords, Config.CircleZones.MushField.coords, true) < 30 then
			SpawnMushPlants()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function() --hai mushroom
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #mushPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(mushPlants[i]), false) < 1 then
				nearbyObject, nearbyID = mushPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('mush_pickupprompt'))
				
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('esx_drugs:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

						Citizen.Wait(3000)
						ClearPedTasks(playerPed)
						Citizen.Wait(1500)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(mushPlants, nearbyID)
						spawnedMush = spawnedMush - 1
		
						TriggerServerEvent('esx_drugs:pickedUpMushroom')
					else
						ESX.ShowNotification(_U('mush_inventoryfull'))
					end

					isPickingUp = false

				end, 'mushroom')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(mushPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnMushPlants() --spawn model mushroom
    RequestModel(GetHashKey("prop_stoneshroom1"))
	while not HasModelLoaded(GetHashKey("prop_stoneshroom1")) do
        Citizen.Wait(1)
    end
	while spawnedMush < 50 do
		Citizen.Wait(1)
		local mushCoords = GenerateMushCoords()
    
		ESX.Game.SpawnLocalObject('prop_stoneshroom1', mushCoords, function(obj1)
			PlaceObjectOnGroundProperly(obj1)
			FreezeEntityPosition(obj, true)

			table.insert(mushPlants, obj1)
			spawnedMush = spawnedMush + 1
		end)
	end
end


function ValidateMushCoord(plantCoord) --hien thi toa do mush
	if spawnedMush > 0 then
		local validate = true

		for k, v in pairs(mushPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.MushField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateMushCoords()
	while true do
		Citizen.Wait(1)

		local mushCoordX, mushCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-90, 90)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-90, 90)

		mushCoordX = Config.CircleZones.MushField.coords.x + modX
		mushCoordY = Config.CircleZones.MushField.coords.y + modY

		local coordZ = GetCoordZ(mushCoordX, mushCoordY)
		local coord = vector3(mushCoordX, mushCoordY, coordZ)

		if ValidateMushCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0, 46.68, 17.21}

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end