
local cuffstate = false
local tryingcuff = false
local cuffAttemptCount = 0
local lastCuffAttemptTime = 0
local handCuffed = false
local handCuffedWalking = false

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
	local players = GetPlayers()
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
		TriggerEvent("DoLongHudText","Dentro do Veiculo.",2)
	end
end

function policeCuff()
	local job = ESX.GetPlayerData().job.name 

    if not inmenus and (job == 'police' or job == "doc") then
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			TriggerEvent("platecheck:frontradar")
		else
			if not IsControlPressed(0, 19) then
				TriggerEvent("pw-police:cuffPlayer")
			end
		end
	end
end

function policeUnCuff()
	local job = ESX.GetPlayerData().job.name

    if not inmenus and (job == 'police' or job == "doc") then
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			TriggerEvent("platecheck:rearradar")
		else
			TriggerEvent("pw-police:uncuffPlayer")
		end
	end
end

function CuffAnimation(cuffer)
	loadAnimDict("mp_arrest_paired")

    local cuffer = GetPlayerPed(GetPlayerFromServerId(tonumber(cuffer)))
	local dir = GetEntityHeading(cuffer)

    SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(cuffer, 0.0, 0.45, 0.0))

    Citizen.Wait(100)

    SetEntityHeading(PlayerPedId(), dir)
	TaskPlayAnim(PlayerPedId(), "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, -1, 32, 0, 0, 0, 0)
end



RegisterNetEvent("pw-police:cuffPlayer")
AddEventHandler("pw-police:cuffPlayer", function()
	if not cuffstate and not exports["pw-lib"]:getVar("handcuffed") and not IsPedRagdoll(PlayerPedId()) and not IsPlayerFreeAiming(PlayerId()) and not IsPedInAnyVehicle(PlayerPedId(), false) and exports["pw-inventory"]:hasEnoughOfItem("cuffs",1,false) then
		cuffstate = true

		--local t, distance = GetClosestPlayer()
		local target, distance = ESX.Game.GetClosestPlayer()
		if distance ~= -1 and distance < 2 and not IsPedRagdoll(PlayerPedId()) then
			TriggerEvent("DoLongHudText", "Bạn đã còng tay!")
			TriggerEvent("pw-police:cuff", GetPlayerServerId(target))
		end

		cuffstate = false
	end
end)

RegisterNetEvent("pw-police:cuff")
AddEventHandler("pw-police:cuff", function(t, softcuff)
	if not tryingcuff then
		tryingcuff = true
		local target, distance = ESX.Game.GetClosestPlayer()
        --local target, distance, ped = GetClosestPlayer()
		local ped = GetPlayerPed(target)
        Citizen.Wait(500)

        if distance ~= -1 and #(GetEntityCoords(ped) - GetEntityCoords(PlayerPedId())) < 2.5 and GetEntitySpeed(ped) < 1.0 then
			TriggerServerEvent("pw-police:cuff", GetPlayerServerId(target))
		else
			ClearPedSecondaryTask(PlayerPedId())
			TriggerEvent("DoLongHudText", "Không có ai ở gần (Hãy lại gần)!", 2)
		end

		tryingcuff = false
	end
end)

RegisterNetEvent("pw-police:getArrested")
AddEventHandler("pw-police:getArrested", function(cuffer)
	if lastCuffAttemptTime + 5000 > GetGameTimer() and (not handCuffed or not handCuffedWalking) then
		ClearPedTasksImmediately(PlayerPedId())
		return
	end

	ClearPedTasksImmediately(PlayerPedId())
	CuffAnimation(cuffer)

	local cuffPed = GetPlayerPed(GetPlayerFromServerId(tonumber(cuffer)))
	local finished = 0

	if lastCuffAttemptTime + 180000 < GetGameTimer() then
		cuffAttemptCount = 0
		lastCuffAttemptTime = 0
	end

    if not exports["pw-lib"]:getVar("dead") and cuffAttemptCount < 4 then
		cuffAttemptCount = cuffAttemptCount + 1
		lastCuffAttemptTime = GetGameTimer()
        exports["pw-lib"]:setVar("recentcuff", GetGameTimer())
        local cuffAttemptTbl = {
			[1] = { 1000, 15 },
			[2] = { 900, 13 },
			[3] = { 800, 11 },
			[4] = { 700, 9 },
		}
		finished = exports["pw-taskbarskill"]:taskBarSkill(cuffAttemptTbl[cuffAttemptCount][1], cuffAttemptTbl[cuffAttemptCount][2])
	end

	if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(cuffPed)) < 2.5 and finished ~= 100 then
        handCuffed = true
		handCuffedWalking = false

        exports["pw-lib"]:setVar("handcuffed", handCuffed or handCuffedWalking)
        exports["pw-flags"]:SetPedFlag(PlayerPedId(), "isCuffed", handCuffed or handCuffedWalking)
        TriggerEvent("pw-police:cuffs:state", handCuffed or handCuffedWalking)

        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3.0, "handcuff", 0.4)
        TriggerEvent("DoLongHudText", "Đã bị còng!")
	end
end)

RegisterNetEvent("pw-police:cuffTransition")
AddEventHandler("pw-police:cuffTransition", function()
	loadAnimDict("mp_arrest_paired")
	Citizen.Wait(100)
	TaskPlayAnim(PlayerPedId(), "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, -1, 48, 0, 0, 0, 0)
	Citizen.Wait(3500)
	ClearPedTasksImmediately(PlayerPedId())
end)

RegisterNetEvent("pw-police:uncuffPlayer")
AddEventHandler("pw-police:uncuffPlayer", function()
	--local t, distance = GetClosestPlayer()
	local target, distance = ESX.Game.GetClosestPlayer()

    if distance ~= -1 and distance < 2 then
		TriggerEvent("animation:PlayAnimation", "uncuff")
		Wait(3000)
		TriggerServerEvent("pw-police:uncuff", GetPlayerServerId(target))
		TriggerEvent("DoLongHudText", "Bạn đã tháo còng cho ai đó!")
	else
		TriggerEvent("DoLongHudText", "Không có ai ở gần!", 2)
	end
end)

RegisterNetEvent("pw-police:uncuff")
AddEventHandler("pw-police:uncuff", function()
	ClearPedTasksImmediately(PlayerPedId())

	handCuffed = false
	handCuffedWalking = false

    exports["pw-lib"]:setVar("handcuffed", handCuffed or handCuffedWalking)
    exports["pw-flags"]:SetPedFlag(PlayerPedId(), "isCuffed", handCuffed or handCuffedWalking)
    TriggerEvent("pw-police:cuffs:state", handCuffed or handCuffedWalking)

    exports["esx_policejob"]:setIsInBeatmode(false)
end)

RegisterNetEvent("pw-police:softcuffPlayer")
AddEventHandler("pw-police:softcuffPlayer", function()
	local t, distance = GetClosestPlayer()

    if distance ~= -1 and distance < 2 then
		TriggerEvent("animation:PlayAnimation", "uncuff")
		Wait(3000)
		TriggerServerEvent("pw-police:softcuff", GetPlayerServerId(t))
	else
		TriggerEvent("DoLongHudText", "Không có ai ở gần!!", 2)
	end
end)

RegisterNetEvent("pw-police:handCuffedWalking")
AddEventHandler("pw-police:handCuffedWalking", function()
	if handCuffedWalking then
		handCuffedWalking = false
		handCuffed = true
	else
		handCuffedWalking = true
		handCuffed = false
	end

	exports["pw-lib"]:setVar("handcuffed", handCuffed or handCuffedWalking)
    exports["pw-flags"]:SetPedFlag(PlayerPedId(), "isCuffed", handCuffed or handCuffedWalking)
    TriggerEvent("pw-police:cuffs:state", handCuffed or handCuffedWalking)

	TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3.0, "handcuff", 0.4)

	ClearPedTasksImmediately(PlayerPedId())
end)

RegisterNetEvent("pw-police:resetCuffs")
AddEventHandler("pw-police:resetCuffs", function()
	ClearPedTasksImmediately(PlayerPedId())

    handCuffed = false
	handCuffedWalking = false

    exports["pw-lib"]:setVar("handcuffed", handCuffed or handCuffedWalking)
    exports["pw-flags"]:SetPedFlag(PlayerPedId(), "isCuffed", handCuffed or handCuffedWalking)
    TriggerEvent("pw-police:cuffs:state", handCuffed or handCuffedWalking)
end)


RPC.register("isPlyCuffed", function()
	local isCuffed = exports["pw-lib"]:getVar("handcuffed")
	return isCuffed
end)



Citizen.CreateThread(function()
    RegisterCommand("+policeCuff", policeCuff, false)
	RegisterCommand("-policeCuff", function() end, false)
	exports["pw-keybinds"]:registerKeyMapping("", "Police", "Cuff / Radar Front", "+policeCuff", "-policeCuff", "UP")

    RegisterCommand("+policeUnCuff", policeUnCuff, false)
	RegisterCommand("-policeUnCuff", function() end, false)
	exports["pw-keybinds"]:registerKeyMapping("", "Police", "UnCuff / Radar Rear", "+policeUnCuff", "-policeUnCuff", "DOWN")
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if handCuffed or handCuffedWalking then
			if handCuffedWalking and IsPedClimbing(PlayerPedId()) then
				Wait(500)
				SetPedToRagdoll(PlayerPedId(), 3000, 1000, 0, 0, 0, 0)
			end

            if handCuffed and CanPedRagdoll(PlayerPedId()) then
				SetPedCanRagdoll(PlayerPedId(), false)
			end

			local number = handCuffed and 17 or 49

			-- disable actions
			-- Disable Actions
			-- DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			-- DisableControlAction(0, 32, true) -- W
			-- DisableControlAction(0, 34, true) -- A
			-- DisableControlAction(0, 31, true) -- S
			-- DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
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

			DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing

			local dead = exports["pw-lib"]:getVar("dead")
			local intrunk = exports["pw-lib"]:getVar("trunk")
			local isInBeatMode = exports["esx_policejob"]:getIsInBeatmode()

			if (not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "idle", 3) and not dead and not intrunk and not isInBeatMode) or (IsPedRagdoll(PlayerPedId()) and not dead and not intrunk and not isInBeatMode) then
				RequestAnimDict("mp_arresting")
				while not HasAnimDictLoaded("mp_arresting") do
					Citizen.Wait(1)
				end
				TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, 8.0, -1, number, 0.0, 0, 0, 0)
			end

			if dead or intrunk or isInBeatMode then
				Citizen.Wait(1000)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(4000)

		if not handCuffed and not CanPedRagdoll(PlayerPedId()) then
			SetPedCanRagdoll(PlayerPedId(), true)
		end
	end
end)