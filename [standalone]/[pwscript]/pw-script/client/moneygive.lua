function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

RegisterNetEvent('pw-scripts:client:Duatien')
AddEventHandler('pw-scripts:client:Duatien', function(player,soluong)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			loadAnimDict('gestures@m@standing@fat')
			TaskPlayAnim(PlayerPedId(), 'gestures@m@standing@fat', 'gesture_hello',5.0, 1.0, 5.0, 48, 0.0, 0, 0, 0)
			TriggerServerEvent("pw-scripts:server:Duatien",player,tonumber(soluong))
		else
			TriggerEvent("ESX:Notify","Người này không đứng gần bạn","error")
		end
end)



RegisterCommand('tattuido', function()
	TriggerEvent("closeInventoryGui")
end, false)

