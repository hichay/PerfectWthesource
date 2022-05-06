RegisterCommand('godmode', function()
	TriggerEvent("admin:c_godmode")
end, false)

local godmode = false
RegisterNetEvent('admin:c_godmode')
AddEventHandler('admin:c_godmode', function()
	local playerPed = GetPlayerPed(-1)

	if not godmode then
	    godmode = true
	    TriggerEvent("ESX:Notify","Godmode On","info")
	elseif godmode then
	    godmode = false
	    TriggerEvent("ESX:Notify","Godmode Off","info")
	end
end)

Citizen.CreateThread(function() --Godmode
	while true do
		Citizen.Wait(1)

		if godmode then
			SetEntityInvincible(GetPlayerPed(-1), true)
			SetPlayerInvincible(PlayerId(), true)
			SetPedCanRagdoll(GetPlayerPed(-1), false)
			ClearPedBloodDamage(GetPlayerPed(-1))
			ResetPedVisibleDamage(GetPlayerPed(-1))
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
			SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), false)
			SetEntityCanBeDamaged(GetPlayerPed(-1), false)
		elseif not godmode then
			SetEntityInvincible(GetPlayerPed(-1), false)
			SetPlayerInvincible(PlayerId(), false)
			SetPedCanRagdoll(GetPlayerPed(-1), true)
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
			SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), true)
			SetEntityCanBeDamaged(GetPlayerPed(-1), true)
		end
	end
end)