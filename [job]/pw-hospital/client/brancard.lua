
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)



RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

	Citizen.Wait(5000)
end)




prop_amb = false
veh_detect = 0


RegisterNetEvent('hospital:client:Dualenxe')
AddEventHandler('hospital:client:Dualenxe', function()
	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
	local closestObject = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), 7.0, GetHashKey("20ramambo"), 18)
		if closestObject ~= 0 then
			veh_detect = closestObject
			veh_detection = 4.8
			prop_depth = -2.5
			prop_height = 0.3
		end
			if DoesEntityExist(veh_detect) then
				local coords = GetEntityCoords(veh_detect) + GetEntityForwardVector(veh_detect) * - veh_detection
				local coords_spawn = GetEntityCoords(veh_detect) + GetEntityForwardVector(veh_detect) * - (veh_detection + 4.0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), coords.x , coords.y, coords.z, true) <= 3.0 then
					if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
						local prop = GetClosestObjectOfType(GetEntityCoords(GetPlayerPed(-1)), 9.0, GetHashKey("trump-stretcher"))
								if prop ~= 0 then 
									prop_exist = prop
								end
							local closestObject321 = GetClosestVehicle(pedCoords, 3.0, GetHashKey("trump-stretcher"), 70)
							if DoesEntityExist(closestObject321) then
								
								in_ambulance(closestObject321, veh_detect, prop_depth, prop_height)
								DetachEntity(closestObject321, true, true)
							end
						
					end
				end
			end
		--end
end)							

RegisterNetEvent('hospital:client:TakeBrancard')
AddEventHandler('hospital:client:TakeBrancard', function()
    for _,g in pairs(Config.Hash) do
			local closestObject = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), 7.0, GetHashKey(g.hash), 18)
			if closestObject ~= 0 then
				veh_detect = closestObject
				veh_detection = g.detection
				prop_depth = g.depth
				prop_height = g.height
			end
		end
		if prop_amb == false then
			if GetVehiclePedIsIn(GetPlayerPed(-1)) == 0 then
				if DoesEntityExist(veh_detect) then
					local coords = GetEntityCoords(veh_detect) + GetEntityForwardVector(veh_detect) * - veh_detection
					local coords_spawn = GetEntityCoords(veh_detect) + GetEntityForwardVector(veh_detect) * - (veh_detection + 4.0)
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), coords.x , coords.y, coords.z, true) <= 1.0 then
						if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3)then

							if IsEntityAttachedToEntity(prop, GetPlayerPed(-1)) ~= 0 or prop ~= 0 then
									while not HasModelLoaded("trump-stretcher") do
										RequestModel("trump-stretcher")
										Citizen.Wait(1)
									end
									local object = CreateVehicle(GetHashKey("trump-stretcher"), coords_spawn, true, true)
									SetVehicleExtra(object, 1, 0)
									SetVehicleExtra(object, 2, 1)
									SetVehicleExtra(object, 3, 1) -- blackboard
									SetVehicleExtra(object, 5, 1) -- lifepack
									SetVehicleExtra(object, 6, 1) -- bag
									SetVehicleExtra(object, 7, 1) -- backpack
									SetVehicleExtra(object, 12, 1)
									SetVehicleExtra(object, 11, 0)
									SetEntityHeading(GetPlayerPed(-1), GetEntityHeading(GetPlayerPed(-1)) - 180.0)
									SetVehicleEngineOn(object, 1, 1, 1)
									prendre(object, vehicle)
							end
						end
					end
				end
			end
		end
		
end)


function LoadAnim(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(1)
	end
end

function prendre(propObject)
	NetworkRequestControlOfEntity(propObject)

	LoadAnim("anim@heists@box_carry@")

	AttachEntityToEntity(propObject, GetPlayerPed(-1), GetPlayerPed(-1), -0.05, 1.3, -0.345 , 180.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)
		---
	while IsEntityAttachedToEntity(propObject, GetPlayerPed(-1)) do

		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
			TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if IsPedDeadOrDying(GetPlayerPed(-1)) then
			ClearPedTasksImmediately(GetPlayerPed(-1))
			SetVehicleExtra(propObject, 1, 1)
			SetVehicleExtra(propObject, 2, 0)
			DetachEntity(propObject, true, true)
		end
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(veh_detect), true) <= 7.0 then
			
			ESX.ShowHelpNotification("Nhấn [E] để lấy ra")
			
			if (IsControlJustPressed(0, 38)) then
				ClearPedTasksImmediately(GetPlayerPed(-1))
				SetVehicleExtra(propObject, 1, 1)
				SetVehicleExtra(propObject, 2, 0)
				--SetVehicleExtra(propObject, 3, 0)

				DetachEntity(propObject, true, true)
				prop_amb = true

				in_ambulance(propObject, veh_detect, prop_depth, prop_height)
			end
		else
			ESX.ShowHelpNotification("Nhấn [X] để thả xe ra")
		end

		if IsControlJustPressed(0, 73) then
			ClearPedTasksImmediately(GetPlayerPed(-1))
			SetVehicleExtra(propObject, 1, 1)
			SetVehicleExtra(propObject, 2, 0)
			DetachEntity(propObject, true, false)
			SetVehicleOnGroundProperly(propObject)
		end
		
	end
end


function in_ambulance(propObject, amb, depth, height)
	veh_detect = 0
	NetworkRequestControlOfEntity(amb)

	AttachEntityToEntity(propObject, amb, 0.0, 0.0, depth, height, 0.0, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
	
	while IsEntityAttachedToEntity(propObject, amb) do
		Citizen.Wait(5)

		if GetVehiclePedIsIn(GetPlayerPed(-1)) == 0 then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(amb), true) <= 7.0 then
				
				ESX.ShowHelpNotification("Nhấn [E] để lấy cán ra khỏi xe")
				if IsControlJustPressed(0, 38) then
					DetachEntity(propObject, true, true)
					prop_amb = false
					SetEntityHeading(GetPlayerPed(-1), GetEntityHeading(GetPlayerPed(-1)) - 180.0)
					SetVehicleExtra(propObject, 1, 0)
					SetVehicleExtra(propObject, 2, 1)
					prendre(propObject)
				end
			end
		end
	end
end

Citizen.CreateThread(function()
	while true do
		local sleep = 2000	
		local pedCoords = GetEntityCoords(GetPlayerPed(-1))
		local closestObject = GetClosestVehicle(pedCoords, 3.0, GetHashKey("trump-stretcher"), 70)
		if DoesEntityExist(closestObject) then
			sleep = 5
			local propCoords = GetEntityCoords(closestObject)
			local propForward = GetEntityForwardVector(closestObject)
			local litCoords = (propCoords + propForward)
			local sitCoords = (propCoords + propForward * 0.1)
			local pickupCoords = (propCoords + propForward * 1.2)
			local pickupCoords2 = (propCoords + propForward * - 1.2)
			
			if GetDistanceBetweenCoords(pedCoords, litCoords, true) <= 5.0 then
				if GetDistanceBetweenCoords(pedCoords, sitCoords, true) <= 2.0 then
					
					ESX.ShowHelpNotification("Nhấn [H] để tương tác")
					if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' and not IsEntityDead(GetPlayerPed(-1)) then 
						--print('right')
						if IsControlJustPressed(0, 74) then
							TriggerEvent("pw-brandcard:AmbulanceMenu")
						end
					elseif IsEntityDead(GetPlayerPed(-1)) then 
						if IsControlJustPressed(0, 74) then
							TriggerEvent("pw-brandcard:MainMenu")
						end
					else
						if IsControlJustPressed(0, 74) then
							TriggerEvent("pw-brandcard:MainMenu")
						end
					
					end
					
				elseif IsEntityAttachedToEntity(closestObject, GetPlayerPed(-1)) == false and not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
					if GetDistanceBetweenCoords(pedCoords, pickupCoords2, true) <= 2.5 then
						
						ESX.ShowHelpNotification("Nhấn [E] để đẩy xe")
						if IsControlJustPressed(0, 38) then
							SetVehicleExtra(closestObject, 1, 0)
							SetVehicleExtra(closestObject, 2, 1)
							prop_exist = 0
							prendre(closestObject)
						end
					end
				end	
			end
		end
		Citizen.Wait(sleep)
	end
end)

RegisterNetEvent('pw-brandcard:client:namlen')
AddEventHandler('pw-brandcard:client:namlen', function()
	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
	local closestObject = GetClosestVehicle(pedCoords, 3.0, GetHashKey("trump-stretcher"), 70)
	LoadAnim("savecouch@")
	AttachEntityToEntity(GetPlayerPed(-1), closestObject, GetPlayerPed(-1), 0, 0.2, 1.1, 0.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)
	TaskPlayAnim(GetPlayerPed(-1), "savecouch@", "t_sleep_loop_couch", 8.0, 8.0, -1, 1, 0, false, false, false)
end)

RegisterNetEvent('pw-brandcard:client:ngoiphai')
AddEventHandler('pw-brandcard:client:ngoiphai', function()
	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
	local closestObject = GetClosestVehicle(pedCoords, 3.0, GetHashKey("trump-stretcher"), 70)
	LoadAnim("amb@prop_human_seat_chair_food@male@base")
	AttachEntityToEntity(GetPlayerPed(-1), closestObject, GetPlayerPed(-1), 0, -0.2, 0.55, 0.0, 0.0, -90.0, 0.0, false, false, false, false, 2, true)
	TaskPlayAnim(GetPlayerPed(-1), "amb@prop_human_seat_chair_food@male@base", "base", 8.0, 8.0, -1, 1, 0, false, false, false)
end)
	
RegisterNetEvent('pw-brandcard:client:ngoitrai')
AddEventHandler('pw-brandcard:client:ngoitrai', function()
	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
	local closestObject = GetClosestVehicle(pedCoords, 3.0, GetHashKey("trump-stretcher"), 70)
	LoadAnim("amb@prop_human_seat_chair_food@male@base")
	AttachEntityToEntity(GetPlayerPed(-1), closestObject, GetPlayerPed(-1), 0, -0.2, 0.55, 0.0, 0.0, 90.0, 0.0, false, false, false, false, 2, true)
	TaskPlayAnim(GetPlayerPed(-1), "amb@prop_human_seat_chair_food@male@base", "base", 8.0, 8.0, -1, 1, 0, false, false, false)
end)

RegisterNetEvent('pw-brandcard:client:ngoitren')
AddEventHandler('pw-brandcard:client:ngoitren', function()
	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
	local closestObject = GetClosestVehicle(pedCoords, 3.0, GetHashKey("trump-stretcher"), 70)
	LoadAnim("amb@world_human_stupor@male_looking_left@base")
	AttachEntityToEntity(GetPlayerPed(-1), closestObject, GetPlayerPed(-1), 0, 0.3, 1.5, 0.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)
	TaskPlayAnim(GetPlayerPed(-1), "amb@world_human_stupor@male_looking_left@base", "base", 8.0, 8.0, -1, 1, 0, false, false, false)
end)	


RegisterNetEvent('pw-brandcard:client:roikhoi')
AddEventHandler('pw-brandcard:client:roikhoi', function()
	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
	local closestObject = GetClosestVehicle(pedCoords, 3.0, GetHashKey("trump-stretcher"), 70)
	DetachEntity(GetPlayerPed(-1), true, true)
	local x, y, z = table.unpack(GetEntityCoords(closestObject) + GetEntityForwardVector(closestObject) * - 2.4)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
end)



RegisterNetEvent('pw-brandcard:client:blackboard')
AddEventHandler('pw-brandcard:client:blackboard', function()
	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
	local closestObject = GetClosestVehicle(pedCoords, 3.0, GetHashKey("trump-stretcher"), 70)
	if IsVehicleExtraTurnedOn(closestObject, 3) == false then
		SetVehicleExtra(closestObject, 3, 0) 
	else
		SetVehicleExtra(closestObject, 3, 1)
	end
end)

RegisterNetEvent('pw-brandcard:client:lifepack')
AddEventHandler('pw-brandcard:client:lifepack', function()
	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
	local closestObject = GetClosestVehicle(pedCoords, 3.0, GetHashKey("trump-stretcher"), 70)
	if IsVehicleExtraTurnedOn(closestObject, 5) == false then
		SetVehicleExtra(closestObject, 5, 0)
	else
		SetVehicleExtra(closestObject, 5, 1)
	end
end)

RegisterNetEvent('pw-brandcard:client:bag')
AddEventHandler('pw-brandcard:client:bag', function()
	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
	local closestObject = GetClosestVehicle(pedCoords, 3.0, GetHashKey("trump-stretcher"), 70)
	if IsVehicleExtraTurnedOn(closestObject, 6) == false then
		SetVehicleExtra(closestObject, 6, 0)
	else
		SetVehicleExtra(closestObject, 6, 1)
	end
end)

RegisterNetEvent('pw-brandcard:client:backpack')
AddEventHandler('pw-brandcard:client:backpack', function()
	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
	local closestObject = GetClosestVehicle(pedCoords, 3.0, GetHashKey("trump-stretcher"), 70)
	if IsVehicleExtraTurnedOn(closestObject, 7) == false then
		SetVehicleExtra(closestObject, 7, 0)
	else
		SetVehicleExtra(closestObject, 7, 1)
	end
end)

RegisterNetEvent('pw-brandcard:client:seat')
AddEventHandler('pw-brandcard:client:seat', function()
	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
	local closestObject = GetClosestVehicle(pedCoords, 3.0, GetHashKey("trump-stretcher"), 70)
	if IsVehicleExtraTurnedOn(closestObject, 11) == false then
		SetVehicleExtra(closestObject, 11, 0)
		SetVehicleExtra(closestObject, 12, 1)
	else
		SetVehicleExtra(closestObject, 11, 1)
		SetVehicleExtra(closestObject, 12, 0)
	end
end)
