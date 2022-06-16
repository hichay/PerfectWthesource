-- AddEventHandler('esx:playerLoaded', function(xPlayer)
-- 	TriggerServerEvent("free:collect")
-- end)

RegisterNetEvent("free:toggleFreeMenu")
AddEventHandler("free:toggleFreeMenu", function(state)
	SetNuiFocus(state, state)
	SendNUIMessage({type = "toggleshow", enable = state})
end)

RegisterNetEvent("free:setTimeout")
AddEventHandler("free:setTimeout", function(t,n)
	SendNUIMessage({type = "settimeout", timeout = tonumber(t * 1000),counttime = n})
end)

RegisterNetEvent("free:giveWpn")
AddEventHandler("free:giveWpn", function(wpn,ammo)
	local ped = GetPlayerPed(-1)
	wpn = GetHashKey(wpn)
	if HasPedGotWeapon(ped, wpn, false) then AddAmmoToPed(ped, wpn, ammo) else GiveWeaponToPed(ped, wpn, ammo, false, false) end
end)

RegisterNUICallback("hidemenu", function(data, cb)
	TriggerEvent("free:toggleFreeMenu", false)
end)

RegisterNUICallback("collect", function(data, cb)
	TriggerServerEvent("free:collect", data.t)
end)

Citizen.CreateThread(function()

    local isPauseMenu = false

	while true do
		Citizen.Wait(0)

		if IsPauseMenuActive() then -- ESC Key
			if not isPauseMenu then
				isPauseMenu = not isPauseMenu
				SendNUIMessage({ action = 'toggleUi', value = false })
			end
		else
			if isPauseMenu then
				isPauseMenu = not isPauseMenu
				SendNUIMessage({ action = 'toggleUi', value = true })
			end

		end


	end
end)

--TriggerEvent('chat:addSuggestion', '', 'Open daily rewards menu',{})