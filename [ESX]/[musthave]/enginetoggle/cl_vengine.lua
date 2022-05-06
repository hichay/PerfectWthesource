-- Configuration


interactionDistance = 3.5 
local commandEnabled = true -- (false by default) If you set this to true, typing "/engine" in chat will also toggle your engine.
ESX = nil
-- You're all set now!


-- Code, no need to modify this, unless you know what you're doing or you want to fuck shit up.
-- No support will be provided if you modify this part below.
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    if commandEnabled then
        RegisterCommand('dongco', function() 
            batdongco()
        end, false)
		RegisterCommand('trunk', function() 
            trunk()
        end, false)
		RegisterCommand('rdoors', function() 
            rdoors()
        end, false)
		RegisterCommand('hood', function() 
            hood()
        end, false)
		RegisterCommand('seatbealt', function() 
            seatbealt()
        end, false)
    end
end)

function batdongco()
    local player = GetPlayerPed(-1)
	
	if (IsPedSittingInAnyVehicle(player)) then 
		local vehicle = GetVehiclePedIsIn(player,false)
		
		if IsEngineOn == true then
			IsEngineOn = false
			ESX.ShowNotification("Động cơ đã được ~r~TẮT~s~.")
			SetVehicleEngineOn(vehicle,false,false,false)
		else
			IsEngineOn = true
			ESX.ShowNotification("Động cơ đã được ~g~BẬT~s~.")
			SetVehicleUndriveable(vehicle,false)
			SetVehicleEngineOn(vehicle,true,false,false)
		end
		
		while (IsEngineOn == false) do
			SetVehicleUndriveable(vehicle,true)
			Citizen.Wait(0)
		end
	end
end


function trunk()
    local player = GetPlayerPed(-1)
			if controlsave_bool == true then
				vehicle = saveVehicle
			else
				vehicle = GetVehiclePedIsIn(player,true)
			end
			
			local isopen = GetVehicleDoorAngleRatio(vehicle,5)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			
			if distanceToVeh <= interactionDistance then
				if (isopen == 0) then
				SetVehicleDoorOpen(vehicle,5,0,0)
				else
				SetVehicleDoorShut(vehicle,5,0)
				end
			else
				ShowNotification("~r~You must be near your vehicle to do that.")
			end
end


function rdoors()
    local player = GetPlayerPed(-1)
    		if controlsave_bool == true then
				vehicle = saveVehicle
			else
				vehicle = GetVehiclePedIsIn(player,true)
			end
			local isopen = GetVehicleDoorAngleRatio(vehicle,2) and GetVehicleDoorAngleRatio(vehicle,3)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			
			if distanceToVeh <= interactionDistance then
				if (isopen == 0) then
				SetVehicleDoorOpen(vehicle,2,0,0)
				SetVehicleDoorOpen(vehicle,3,0,0)
				else
				SetVehicleDoorShut(vehicle,2,0)
				SetVehicleDoorShut(vehicle,3,0)
				end
			else
				ShowNotification("~r~You must be near your vehicle to do that.")
			end
end

function hood()
   local player = GetPlayerPed(-1)
    	if controlsave_bool == true then
			vehicle = saveVehicle
		else
			vehicle = GetVehiclePedIsIn(player,true)
		end
			
			local isopen = GetVehicleDoorAngleRatio(vehicle,4)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			
			if distanceToVeh <= interactionDistance then
				if (isopen == 0) then
				SetVehicleDoorOpen(vehicle,4,0,0)
				else
				SetVehicleDoorShut(vehicle,4,0)
				end
			else
				ShowNotification("~r~You must be near your vehicle to do that.")
			end
end






function func_TuDongLai()
	local playerPed = PlayerPedId()
	local Vehicle = GetVehiclePedIsUsing(playerPed)
	--if GetEntityModel(Vehicle) == -1848994066 then
			if GetPedInVehicleSeat(Vehicle, -1) == PlayerPedId() then
					autopilot = true
					local waypoint = GetFirstBlipInfoId(8)
					local waypointCoord = GetBlipCoords(waypoint)
					local speed = 50
					local timesRepeated = 0
					Citizen.Wait(50)
					TaskVehicleDriveToCoord(playerPed, Vehicle, waypointCoord, 100.0, 0, -1848994066, 524863, 10.0)
					SetDriveTaskDrivingStyle(playerPed, 524863)
					SetPedKeepTask(playerPed, true)
					local hasArrived = false
					while not hasArrived do
							Citizen.Wait(5)
							SetEntityMaxSpeed(Vehicle, speed / 3.6)
							if GetPedInVehicleSeat(Vehicle, -1) == playerPed then
									local myCoords = GetEntityCoords(playerPed)
									local distance = GetDistanceBetweenCoords(myCoords, waypointCoord, false)
									drawTxt('Tự động lái: ~g~Đã mở', 0.07, 0.38, 0.4)
									drawTxt('Tốc độ: ' .. speed .. 'KM/H', 0.07, 0.42, 0.4)
									drawTxt('Tăng tốc: Nút mũi tên lên', 0.07, 0.46, 0.4)
									drawTxt('Giảm tốc: Nút mũi tên xuống', 0.07, 0.50, 0.4)
									drawTxt('Tắt tự động: nút `', 0.07, 0.54, 0.4)
									drawTxt('Khoảng cách: ' .. math.ceil(distance) .. 'M', 0.07, 0.58, 0.4)

									if distance <= 25.0 then
											hasArrived = true
											ESX.ShowNotification('Đã điến điểm chỉ định!')
											ClearPedTasks(playerPed)
											ClearPedSecondaryTask(playerPed)
									end

									if IsControlJustPressed(0, 243) then
											hasArrived = true
											ESX.ShowNotification('Đã tắt tự động lái')
											ClearPedTasks(playerPed)
											ClearPedSecondaryTask(playerPed)
									end

									if IsControlJustPressed(0, 173) then

											if speed > 10 then
													local Slower = speed - 10
													speed = Slower
													SetEntityMaxSpeed(Vehicle, speed / 3.6)
											end

									elseif IsControlJustPressed(0, 27) then
											if speed < 200 then
													local Faster = speed + 10
													speed = Faster
													SetEntityMaxSpeed(Vehicle, speed / 3.6)
											end
									end
							else
									hasArrived = true
							end
					end
					autopilot = false
					ClearPedTasks(playerPed)
					ClearPedSecondaryTask(playerPed)
					SetEntityMaxSpeed(Vehicle, 100.0)
			else
					ESX.ShowNotification('Bạn phải là người lái!')
			end

	--else

	--    ESX.ShowNotification('Phương tiện không hỗ trợ!')

	--end

end



RegisterCommand('autopilot', function(source)
	func_TuDongLai()
end, false)



function drawTxt(text, x, y, scale)
	SetTextFont(ESX.FontId)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(255, 255, 255, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextCentre(1)
	SetTextEntry("CUSTOM_TEXT")
	AddTextComponentString(text)
  DrawText(x, y)
  DrawRect(0.0, 0.50, 0.3, 0.25, 41, 11, 41, 68)

end



function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end