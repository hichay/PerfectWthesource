RegisterNetEvent("pw:vehicle:wheelchair:control")
AddEventHandler("pw:vehicle:wheelchair:control", function(pArgs, pEntity)
	ToggleWheelchairControl(pEntity)
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function GetClosestWheelChair()
	local playerPed = PlayerPedId()
	local modelHash = `npwheelchair`
	local entity = GetEntityInFrontOfPlayer(2.0, playerPed)
	local entityModel = GetEntityModel(entity)

	if DoesEntityExist(entity) and entityModel == modelHash then
		return entity
	end
end

function ToggleWheelchairControl(pEntity)
	local wheelchair = pEntity

	if IsPushingWheelchair then
		IsPushingWheelchair = false
		return
	end

	if not wheelchair then return end

	local playerPed = PlayerPedId()
	local currentStearingAngle, currentForwardSpeed, canMove, onFourWheels = 0.0, 0.0, false
	local carryDict, carryAnim = "anim@heists@box_carry@", "idle"
	local walkDict, walkAnim = "move_action@generic@core", "walk"
	local hasWalkingVelocity = false

	AttachEntityToEntity(playerPed, wheelchair, GetEntityBoneIndexByName(wheelchair, "misc_b"), -0.23, -0.4, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 0, 1, 0, 1)

	loadAnimDict(carryDict)
	loadAnimDict(walkDict)

	IsPushingWheelchair = true

	local isEmpty, driver = IsVehicleSeatFree(wheelchair, -1)

	if not isEmpty then
		driver = GetPedInVehicleSeat(wheelchair, -1)
		RequestVehicleControl(driver, wheelchair)
	end

	Citizen.CreateThread(function()
		Debug("[Wheelchair] Controlling: %s | Empty: %s |", IsPushingWheelchair, isEmpty)

		while IsPushingWheelchair do
			local isMovingForward, isMovingBackwards = IsControlPressed(0, 32), IsControlPressed(0, 8)
			local isStearingLeft, isStearingRight = IsControlPressed(0, 34), IsControlPressed(0, 9)
			local forwardSpeed, steeringAngle = 1.5, 30.0
			local IsWalking = false

			if not IsEntityPlayingAnim(playerPed, carryDict, carryAnim, 3) then
				TaskPlayAnim(playerPed, carryDict, carryAnim, 8.0, 8.0, -1, 51, 0, false, false, false)
			end

			if isEmpty then
				NetworkRequestControlOfEntity(wheelchair)
			end

			if IsControlPressed(0, 21) then
				forwardSpeed = 2.5
				steeringAngle = 30.0 / forwardSpeed
			end

			if canMove and isMovingForward then
				IsWalking, currentForwardSpeed = true, forwardSpeed
				DecorSetFloat(playerPed, "forwardspeed", forwardSpeed)

				if isEmpty then
					SetVehicleForwardSpeed(wheelchair, forwardSpeed)
				end
			end

			if canMove and isMovingBackwards then
				IsWalking, currentForwardSpeed = true, -1.0
				DecorSetFloat(playerPed, "forwardspeed", -1.0)

				if isEmpty then
					SetVehicleForwardSpeed(wheelchair, -1.0)
				end
			end

			if currentForwardSpeed ~= 0.0 and not isMovingForward and not isMovingBackwards then
				currentForwardSpeed = 0.0
				DecorSetFloat(playerPed, "forwardspeed", 0.0)
			end

			if isStearingLeft then
				currentStearingAngle = steeringAngle
				DecorSetFloat(playerPed, "steeringangle", currentStearingAngle * 0.01)

				if isEmpty then
					SetVehicleSteeringAngle(wheelchair, steeringAngle)
				end
			end

			if isStearingRight then
				currentStearingAngle = -steeringAngle
				DecorSetFloat(playerPed, "steeringangle", currentStearingAngle * 0.01)

				if isEmpty then
					SetVehicleSteeringAngle(wheelchair, -steeringAngle)
				end
			end

			if currentStearingAngle ~= 0.0 and (isMovingForward or isMovingBackwards) and (not isStearingLeft and not isStearingRight) then
				currentStearingAngle = 0.0
				DecorSetFloat(playerPed, "steeringangle", 0.0)

				if isEmpty then
					SetVehicleSteeringAngle(wheelchair, 0.0)
				end
			end

			local isPlayingWalkAnim = IsEntityPlayingAnim(playerPed,  walkDict, walkAnim, 3)

			if (IsWalking or hasWalkingVelocity) and not isPlayingWalkAnim then
				TaskPlayAnim(playerPed, walkDict, walkAnim, 8.0, 8.0, -1, 1, 0, false, false, false)
			elseif not IsWalking and not hasWalkingVelocity and isPlayingWalkAnim then
				StopAnimTask(playerPed, walkDict, walkAnim, 3.0)
			end

			Citizen.Wait(0)
		end

		if not isEmpty then
			RestoreVehicleControl(driver, wheelchair)
		end

		DetachEntity(playerPed, false, true) -- Might be good to pass P3 (-_-) as true, otherwise in rare occasions the player gets catapulted to the sky....
		StopAnimTask(playerPed, carryDict, carryAnim, 3.0)
		StopAnimTask(playerPed, walkDict, walkAnim, 3.0)

		RemoveAnimDict(walkDict)
		RemoveAnimDict(carryDict)
		Debug("[Wheelchair] Controlling: %s | Empty: %s |", IsPushingWheelchair, isEmpty)
	end)

	Citizen.CreateThread(function()
		while IsPushingWheelchair do
			local hasDriver = not IsVehicleSeatFree(wheelchair, -1)
			local isEngineOn = GetIsVehicleEngineRunning(wheelchair)
			local velocity, isUpright = GetEntityVelocity(wheelchair), IsEntityUpright(wheelchair, 50.0)
			local vY, vZ = math.abs(velocity.y), math.abs(velocity.z)
			onFourWheels, canMove, hasWalkingVelocity = IsVehicleOnAllWheels(wheelchair), false, false

			if not isEngineOn then
				Sync.SetVehicleEngineOn(wheelchair, true, true, false)
				Sync.SetVehicleUndriveable(wheelchair, false)
			end

			if onFourWheels or vZ < 0.3 then -- Might need to adjust the vZ check to a higher value
				canMove = true
			end

			if vY > 0.5 then -- This will trigger the walking anim if the wheelchair is being manipulated by the driver
				hasWalkingVelocity = true
			end

			if vZ > 2.0 or not IsEntityAttachedToEntity(playerPed, wheelchair) or IsPedDeadOrDying(playerPed, 1) then
				IsPushingWheelchair = false
				Debug("[Wheelchair] Fall Detected | Velocity: %s |", vZ)
			end

			if not isUpright then
				IsPushingWheelchair = false
			end

			if hasDriver then
				local currentDriver = GetPedInVehicleSeat(wheelchair, -1)

				if currentDriver ~= driver then
					RestoreVehicleControl(driver, wheelchair)
					driver = currentDriver
					RequestVehicleControl(driver, wheelchair)
					Debug("[Wheelchair] New Driver Detected | Control Requested |")
				end

				isEmpty = not hasDriver
			elseif not isEmpty and not hasDriver then
				isEmpty = not hasDriver
				RestoreVehicleControl(driver, wheelchair)
				driver = nil
				Debug("[Wheelchair] No Driver Detected | Restoring Local Controls |")
			end

			Citizen.Wait(400)
		end
	end)
end



HasControlOverVehicle, PlayerControlling, VehicleControlled = true

DecorRegister("forwardspeed", 1)
DecorRegister("steeringangle", 1)

RegisterNetEvent("np:vehicle:transfer:control")
AddEventHandler("np:vehicle:transfer:control", function(pServerID, vNetID)
	local playerID, vehicle = GetPlayerFromServerId(pServerID), NetToVeh(vNetID)

	if not HasControlOverVehicle and not DoesEntityExist(vehicle) then return end

	local playerPed, targetPed = GetPlayerPed(-1), GetPlayerPed(playerID)

	if vehicle == GetVehiclePedIsIn(playerPed) then
		PlayerControlling, VehicleControlled = serverID, vNetID

		HasControlOverVehicle = false


		Citizen.CreateThread(function()
			Debug("[Vehicle] Transfered Controls | Player: %s | Veh: %s |", pServerID, vNetID)

			while not HasControlOverVehicle do
				local canMove, forwardSpeed, steeringAngle = IsVehicleOnAllWheels(vehicle), DecorGetFloat(targetPed, "forwardspeed"), DecorGetFloat(targetPed, "steeringangle")

				if canMove and forwardSpeed ~= 0.0 then
					SetVehicleForwardSpeed(vehicle, forwardSpeed)
				end

				if steeringAngle ~= 0.0 then
					SetVehicleSteerBias(vehicle, steeringAngle)
				end

				Citizen.Wait(0)
			end

			Debug("[Vehicle] Restored Controls | Player: %s | Veh: %s |", pServerID, vNetID)
		end)

		Citizen.CreateThread(function()
			while not HasControlOverVehicle do
				if vehicle ~= GetVehiclePedIsIn(playerPed) then
					HasControlOverVehicle = true
				end

				Citizen.Wait(400)
			end
		end)
	end
end)

RegisterNetEvent("np:vehicle:recover:control")
AddEventHandler("np:vehicle:recover:control", function(pServerID, vNetID)
	if not HasControlOverVehicle and PlayerControlling == pServerID or VehicleControlled == vNetID then
		HasControlOverVehicle = true
	end
end)

function RequestVehicleControl(playerPed, vehicle)
	if DoesEntityExist(playerPed) and IsPedAPlayer(playerPed) then
		local serverID = GetPlayerServerId(NetworkGetPlayerIndexFromPed(playerPed))
		local netID = VehToNet(vehicle)
		TriggerServerEvent("np:vehicle:request:control", serverID, netID)
	end
end

function RestoreVehicleControl(playerPed, vehicle)
	if DoesEntityExist(playerPed) and IsPedAPlayer(playerPed) then
		local serverID = GetPlayerServerId(NetworkGetPlayerIndexFromPed(playerPed))
		local netID = VehToNet(vehicle)
		TriggerServerEvent("np:vehicle:restore:control", serverID, netID)
	end
end