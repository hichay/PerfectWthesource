
local isLoadComplete = true
local isArrest = false


function LoadAnimDict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end

RegisterNetEvent('moon-arress:arrest_ani')
AddEventHandler('moon-arress:arrest_ani', function()

    local player = GetPlayerPed( -1 )

	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        LoadAnimDict( "random@arrests" )
		LoadAnimDict( "random@arrests@busted" )
		if ( IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3 ) ) then

			TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (3000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
			Wait (2000)
			isLoadComplete = true
			isArrest = false
        else
			isArrest = true
            TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (4000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (500)
			TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (1000)
			TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
			Wait (2000)
			isLoadComplete = true
        end     
    end
end)



Citizen.CreateThread(function()

	while true do
	
		Citizen.Wait(0)
	
		local lPed = GetPlayerPed(-1)
		
		if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedCuffed(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then

			if IsControlJustReleased(0, 20) and isLoadComplete then

				if DoesEntityExist(lPed) then
					isLoadComplete = false
					local _, hash = GetCurrentPedWeapon( lPed, true )
					if hash ~= 0xA2719263 then
						SetCurrentPedWeapon(lPed, 0xA2719263, true)
						Wait(1000)
					end
					TriggerEvent('moon-arress:arrest_ani')
				end
			end
		end		
		--if IsEntityPlayingAnim(lPed, "random@arrests@busted", "idle_a", 3) then

		if isArrest then
		
			-- DisableAllControlActions(0)
			--DisableAllControlActions(1)
			--DisableAllControlActions(2)

			if isLoadComplete then
				EnableControlAction(0, 311, true)
				EnableControlAction(0, 249, true)
				EnableControlAction(1, 249, true)
			end
	
		end
	
	end

end)