
-- local handCuffed = false
IsDoingCuff = false
function getIsCuffed()
	return isHandcuffed
end

function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end


function policeSoft()
	if not inmenus and isCop then
		local isInVeh = IsPedInAnyVehicle(PlayerPedId(), false)
		if not isInVeh then
			TriggerEvent("police:cuffFromMenu",true)
		end
	end
end

--[[ function GetClosestPlayer()
	local players = ESX.GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local closestPed = -1
	local ply = PlayerPedId()
	local plyCoords = GetEntityCoords(ply, 0)
	if not IsPedInAnyVehicle(PlayerPedId(), false) then

		for index,value in ipairs(players) do
			local target = GetPlayerPed(value)
			if(target ~= ply) then
				local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
				local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
				if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
					closestPlayer = value
					closestPed = target
					closestDistance = distance
				end
			end
		end
		
		return closestPlayer, closestDistance, closestPed

	else
		TriggerEvent("DoShortHudText","Inside Vehicle.",2)
	end

end ]]

tryingcuff = false
RegisterNetEvent('police:cuff2')
AddEventHandler('police:cuff2', function(t,softcuff)
	if not tryingcuff then

		
		tryingcuff = true

		--t, distance, ped = GetClosestPlayer()
		target, distance = ESX.Game.GetClosestPlayer()

		Citizen.Wait(100)
		if distance <= 2.0 then
			TriggerEvent('police:cuff2')
			TriggerServerEvent("police:cuffGranted2", GetPlayerServerId(target), softcuff)
		else
			ClearPedSecondaryTask(PlayerPedId())
			TriggerEvent("DoLongHudText", "Không có người nào ở gần!",2)
		end

		tryingcuff = false

	end
end)

RegisterNetEvent('police:cuff')
AddEventHandler('police:cuff', function(t)
	if not tryingcuff then



		TriggerEvent("Police:ArrestingAnim")
		tryingcuff = true

		--t, distance = GetClosestPlayer()
		target, distance = ESX.Game.GetClosestPlayer()
		if distance <= 2.0 then
			TriggerServerEvent("police:cuffGranted", GetPlayerServerId(target))
		else
			TriggerEvent("DoLongHudText", "Không có người nào ở gần!",2)
		end


		tryingcuff = false
	end
end)


local cuffstate = false


RegisterNetEvent('police:cuffFromMenu')
AddEventHandler('police:cuffFromMenu', function(softcuff)
	if not cuffstate and not isHandcuffed and not IsPedRagdoll(PlayerPedId()) and not IsPlayerFreeAiming(PlayerId()) and not IsPedInAnyVehicle(PlayerPedId(), false) and not IsDoingCuff then
		cuffstate = true

		--t, distance = GetClosestPlayer()
		target, distance = ESX.Game.GetClosestPlayer()
		if(distance ~= -1 and distance < 2 and not IsPedRagdoll(PlayerPedId())) then
			if softcuff then
				TriggerEvent("DoLongHudText", "Bạn đang cố gắng còng tay một người!",1)
			else
				TriggerEvent("DoLongHudText", "Bạn đang cố gắng còng tay một người!",1)
			end
			
			TriggerEvent("police:cuff2", GetPlayerServerId(target),softcuff)
		end

		cuffstate = false
	end
end)


RegisterNetEvent('police:uncuffMenu')
AddEventHandler('police:uncuffMenu', function()
	--t, distance = GetClosestPlayer()
	target, distance = ESX.Game.GetClosestPlayer()
	-- error debug fix - syd
	if not IsPedInAnyVehicle(PlayerPedId(), false) then
		if(distance ~= -1 and distance < 2) then
			--print('uncuff event')
			TriggerServerEvent("falseCuffs", GetPlayerServerId(target))
			TriggerEvent("DoLongHudText", "Bạn đang mở còng tay!",1)
			TriggerEvent("police:douncuffing")
		else
			TriggerEvent("DoLongHudText", "Không có ai ở gần!",2)
		end
	end
end)

-- hopefully resolve the death / revive restrain bug.

RegisterNetEvent('resetCuffs')
AddEventHandler('resetCuffs', function()
	ClearPedTasksImmediately(PlayerPedId())
	handcuffType = 49
	isHandcuffed = false
	handCuffedWalking = false
	TriggerEvent("police:currentHandCuffedState",isHandcuffed,handCuffedWalking)
	--TriggerEvent("DensityModifierEnable",true)
	TriggerEvent("handcuffed",false)
end)

RegisterNetEvent('falseCuffs')
AddEventHandler('falseCuffs', function()
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5000)
	ClearPedTasksImmediately(PlayerPedId())
	handcuffType = 49
	isHandcuffed = false
	handCuffedWalking = false
	TriggerEvent("police:currentHandCuffedState",isHandcuffed,handCuffedWalking)
	--TriggerEvent("DensityModifierEnable",true)
	TriggerEvent("handcuffed",false)
end)


local cuffAttemptCount = 0
local lastCuffAttemptTime = 0
local lastCuffBreakoutTime = 0

RegisterNetEvent('police:getArrested2')
AddEventHandler('police:getArrested2', function(cuffer)

	ClearPedTasksImmediately(PlayerPedId())
	CuffAnimation(cuffer)

	local cuffPed = GetPlayerPed(GetPlayerFromServerId(tonumber(cuffer)))
	local finished = 0
	if lastCuffAttemptTime + 60000 < GetGameTimer() then
		cuffAttemptCount = 0
		lastCuffAttemptTime = 0
	end
	if not isDead and cuffAttemptCount < 4 then
		cuffAttemptCount = cuffAttemptCount + 1
		lastCuffAttemptTime = GetGameTimer()
		TriggerEvent("police:recentlyAttemptedCuffed", GetGameTimer())
		finished = exports["np-taskbarskill"]:taskBar(100,1)
	end


	local inRange = #(GetEntityCoords( PlayerPedId()) - GetEntityCoords(cuffPed)) < 2.5
	if inRange and finished ~= 100 then
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'handcuff', 0.4)
		handcuffType = 16
		isHandcuffed = true
		handCuffedWalking = false
		TriggerEvent("police:currentHandCuffedState",isHandcuffed,handCuffedWalking)
		TriggerEvent("DoLongHudText", "Đã bị còng!",1)
		TriggerEvent("handcuffed",true)

	elseif inRange and finished == 100 then
		canBeTackled = false
		disableRagdoll = true
		lastCuffBreakoutTime = GetGameTimer()

		Wait(15000)
		canBeTackled = true
		disableRagdoll = false
		SetPedCanRagdoll(PlayerPedId(), true)
	end

end)


function CuffAnimation(cuffer)
	loadanimdict("mp_arrest_paired")
	local cuffer = GetPlayerPed(GetPlayerFromServerId(tonumber(cuffer)))
	local dir = GetEntityHeading(cuffer)
	--TriggerEvent('police:cuffAttach',cuffer)
	SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(cuffer, 0.0, 0.45, 0.0))
	Citizen.Wait(100)
	SetEntityHeading(PlayerPedId(),dir)
	TaskPlayAnim(PlayerPedId(), "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, -1, 32, 0, 0, 0, 0)
end

RegisterNetEvent('police:cuffAttach')
AddEventHandler('police:cuffAttach', function(cuffer)
	local count = 350
	while count > 0 do
		Citizen.Wait(1)
		count = count - 1
		AttachEntityToEntity(PlayerPedId(), cuffer, 11816, 0.0, 0.45, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
	end
	DetachEntity(PlayerPedId(), true, false)	
end)


RegisterNetEvent('police:cuffTransition')
AddEventHandler('police:cuffTransition', function()
	--[[ loadAnimDict("mp_arrest_paired")
	Citizen.Wait(100)
	TaskPlayAnim(PlayerPedId(), "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, -1, 48, 0, 0, 0, 0)
	Citizen.Wait(3500)
	ClearPedTasksImmediately(PlayerPedId()) ]]
	IsDoingCuff = true
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,4000, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)
	IsDoingCuff = false
end)


RegisterNetEvent('police:douncuffing')
AddEventHandler('police:douncuffing', function()
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
end)


RegisterNetEvent('police:getArrested')
AddEventHandler('police:getArrested', function(cuffer)

		if(isHandcuffed) then
			Citizen.Wait(3500)
			ClearPedTasksImmediately(PlayerPedId())
			isHandcuffed = false
			handcuffType = 49
			TriggerEvent("police:currentHandCuffedState",isHandcuffed,handCuffedWalking)
			TriggerEvent("handcuffed",true)
		else
			ClearPedTasksImmediately(PlayerPedId())
			CuffAnimation(cuffer)

			local cuffPed = GetPlayerPed(GetPlayerFromServerId(tonumber(cuffer)))
			if Vdist2( GetEntityCoords( GetPlayerPed(-1) , GetEntityCoords(cuffPed) ) ) < 1.5 then
				handcuffType = 49
				isHandcuffed = true
				TriggerEvent("police:currentHandCuffedState",isHandcuffed,handCuffedWalking)
				TriggerEvent("handcuffed",false)
			end
		end
end)


handCuffedWalking = false
RegisterNetEvent('handCuffedWalking')
AddEventHandler('handCuffedWalking', function()

	if handCuffedWalking then
		handCuffedWalking = false
		TriggerEvent("handcuffed",false)
		TriggerEvent("animation:PlayAnimation","cancel")
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'handcuff', 0.4)
		TriggerEvent("police:currentHandCuffedState",false,false)
		return
	end
	handCuffedWalking = true
	isHandcuffed = false
	TriggerEvent("handcuffed",true)
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'handcuff', 0.4)
	TriggerEvent("police:currentHandCuffedState",isHandcuffed,handCuffedWalking)

end)

handcuffs = 0
function alterHandcuffs(cuffMode)
	local factor = cuffMode
	if cuffMode then
		local hcmodel = "prop_cs_cuffs_01"
		local plyCoords = GetEntityCoords(PlayerPedId(), false)
		local handcuffs = CreateObject(GetHashKey(hcmodel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
		AttachEntityToEntity(handcuffs, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.05, 0.0, 0.0, 0.0, 80.0, 1, 0, 0, 0, 0, 1)
	else
		DeleteEntity(handcuffs)
		handcuffs = 0
	end
end

handcuffType = 16


local isTargetCuffed = false

function cuffCheck()
	if not isHandcuffed and not IsPedRagdoll(PlayerPedId()) and not IsPlayerFreeAiming(PlayerId()) and not IsPedInAnyVehicle(PlayerPedId(), false) then
		--t, distance = GetClosestPlayer()
		target, distance = ESX.Game.GetClosestPlayer()
		if(distance ~= -1 and distance < 3 and not IsPedRagdoll(PlayerPedId())) then
			TriggerServerEvent("police:IsTargetCuffed", GetPlayerServerId(target)) 
		end
	end
end

RegisterNetEvent('police:isPlayerCuffed')
AddEventHandler('police:isPlayerCuffed', function(requestedID)
	TriggerServerEvent("police:confirmIsCuffed",requestedID,handCuffed)
end)


RegisterNetEvent('police:TargetIsCuffed')
AddEventHandler('police:TargetIsCuffed', function(result)
	isTargetCuffed = result
	if isTargetCuffed then
		TriggerEvent("openSubMenu","handcuffer")
	else
		TriggerEvent("police:cuffFromMenu")
	end
	isTargetCuffed = false
end)

RegisterNetEvent('police:AttemptCuffFromInventory')
AddEventHandler('police:AttemptCuffFromInventory', function()
	cuffCheck()
end)


--[[ Citizen.CreateThread(function()
	while true do
   Citizen.Wait(10)

	 -- Run cuff script if police is targeting someone with a weapon and pressed E

	   if true then

		   local isInVeh = IsPedInAnyVehicle(PlayerPedId(), false)

		   if isInVeh then

			   if IsControlJustReleased(0,172) or IsDisabledControlJustReleased(0,172) then
				   TriggerEvent("platecheck:frontradar")
				   Citizen.Wait(400)
			   end

			   if IsControlJustReleased(0,173) then
				   TriggerEvent("platecheck:rearradar")
				   Citizen.Wait(400)
			   end

			   if IsControlJustReleased(0,174) then
				   TriggerEvent("startSpeedo")
				   Citizen.Wait(400)
			   end
																		   
		   else

			   if IsControlJustReleased(2,172) and not IsControlPressed(0,19) then
				   TriggerEvent("police:cuffFromMenu",false)
				   Citizen.Wait(400)
			   end

			   if IsControlJustReleased(2,172) and IsControlPressed(0,19) then
				   TriggerEvent("police:cuffFromMenu",true)
				   Citizen.Wait(400)
			   end

			   if IsControlJustReleased(2,173) then
				   TriggerEvent("police:uncuffMenu")
				   Citizen.Wait(400)
			   end
			   -- left arrow
			   if IsControlJustReleased(2,174) then
				   TriggerEvent("escortPlayer")
				   Citizen.Wait(400)
			   end
			   -- right arrow
			   if IsControlJustReleased(2,175) then
				   TriggerEvent("police:forceEnter")
				   Citizen.Wait(400)
			   end

		   end

		end
	end
end) ]]

-- INFO: HANDCUFF ANIMATION THREAD
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
			
		if handCuffedWalking or isHandcuffed then
			if handCuffedWalking and IsPedClimbing(PlayerPedId()) then
				Wait(500)
				SetPedToRagdoll(PlayerPedId(), 3000, 1000, 0, 0, 0, 0)
			end
			if isHandcuffed and CanPedRagdoll(PlayerPedId()) then
				SetPedCanRagdoll(PlayerPedId(), false)
			end

			number = 49

			if handCuffed then
				number = 17
			else
				number = 49
			end

			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 21, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
			--local dead = exports["isPed"]:isPed("dead")
			

			if (not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "idle", 3) and not isDead  ) or (IsPedRagdoll(PlayerPedId()) and not isDead) then
					RequestAnimDict('mp_arresting')
				while not HasAnimDictLoaded("mp_arresting") do
					Citizen.Wait(1)
				end
				TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, 8.0, -1, number, 0.0, 0, 0, 0)
			end
			--[[ if isDead then
				Citizen.Wait(1000)
			end ]]
		end
	end
end)

