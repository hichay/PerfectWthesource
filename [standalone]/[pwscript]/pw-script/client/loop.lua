

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = GetPlayerPed(-1)
		id = PlayerId()
		DisablePlayerVehicleRewards(id)
		if IsPedBeingStunned(ped) then
			SetPedMinGroundTimeForStungun(GetPlayerPed(-1), math.random(4000, 7000))
		else
			Citizen.Wait(1000)
		end
	end
end)



