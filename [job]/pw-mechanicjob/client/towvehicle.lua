RegisterCommand("flatbed", function(source, args, rawCommand)
    TriggerEvent("pw-mechanicjob:client:TowVehicle")
end, false)

RegisterNetEvent('pw-mechanicjob:client:TowVehicle')
AddEventHandler('pw-mechanicjob:client:TowVehicle', function()
	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, true)

	local towmodel = GetHashKey('flatbed')
	local isVehicleTow = IsVehicleModel(vehicle, towmodel)

	if isVehicleTow then
		local targetVehicle = ESX.Game.GetVehicleInDirection()
		if CurrentTow == nil then
			if CurrentlyTowedVehicle == nil then
				if targetVehicle ~= 0 then
					if not IsPedInAnyVehicle(PlayerPedId()) then
						if vehicle ~= targetVehicle then
							ESX.Progressbar("towing_vehicle", "Đang đưa xe lên...", 5000, false, true, {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							}, {
								animDict = "mini@repair",
								anim = "fixing_a_ped",
								flags = 16,
							}, {}, {}, function()	
								StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_ped", 1.0)
								AttachEntityToEntity(targetVehicle, vehicle, GetEntityBoneIndexByName(vehicle, 'bodyshell'), 0.0, -1.5 + -0.85, 0.0 + 1.15, 0, 0, 0, 1, 1, 0, 1, 0, 1)
								FreezeEntityPosition(targetVehicle, true)
								ESX.Notify("Xe đã được gắn lên xuống","info")
								CurrentTow = targetVehicle
							end, function() -- Cancel
								StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_ped", 1.0)
							end)
						end
					end
				end
			end
		else
			ESX.Progressbar("untowing_vehicle", "Đang gỡ xe xuống", 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
                flags = 16,
            }, {}, {}, function() -- Done

				StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_ped", 1.0)
                FreezeEntityPosition(CurrentTow, false)
				Citizen.Wait(250)
                AttachEntityToEntity(CurrentTow, vehicle, 20, -0.0, -15.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                DetachEntity(CurrentTow, true, true)
				CurrentTow = nil
				ESX.Notify("Xe đã được lấy xuống","info")
			end, function() -- Cancel
				StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_ped", 1.0)
			end)
		end
	end	

end)