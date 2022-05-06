local vehiclemeters = -1
local previousvehiclepos = nil
local CheckDone = false
DrivingDistance = {}

function GetDamageMultiplier(meters)
    local check = round(meters / 10000, -4)
	local check2 = meters
	--print('checj'..check)
    local retval = nil
    for k, v in pairs(Config.MinimalMetersForDamage) do
		--print(v.min)
        if check > v.min and check < v.max then
			print(k,v)
            retval = k
            break
        elseif check >= Config.MinimalMetersForDamage[#Config.MinimalMetersForDamage].min then
            retval = #Config.MinimalMetersForDamage
            break
        end
    end

    return retval
end



Citizen.CreateThread(function()
    Wait(500)
    while true do
        local ped = PlayerPedId()
        local invehicle = IsPedInAnyVehicle(ped, true)
        if invehicle then
            local veh = GetVehiclePedIsIn(ped)
            local seat = GetPedInVehicleSeat(veh, -1)
            local pos = GetEntityCoords(ped)
            local vehclass = GetVehicleClass(GetVehiclePedIsIn(ped))
            local plate = GetVehicleNumberPlateText(veh)

            if plate ~= nil then
                if seat == ped then
                    if not CheckDone then
                        if vehiclemeters == -1 then
                            CheckDone = true
                            ESX.TriggerServerCallback('pw-mechanicjob:server:IsVehicleOwned', function(IsOwned)
                                if IsOwned then
                                    if DrivingDistance[plate] ~= nil then
                                        vehiclemeters = DrivingDistance[plate]
                                    else
                                        DrivingDistance[plate] = 0
                                        vehiclemeters = DrivingDistance[plate]
                                    end
                                else
                                    if DrivingDistance[plate] ~= nil then
                                        vehiclemeters = DrivingDistance[plate]
                                    else
                                        DrivingDistance[plate] = math.random(0, 100)
                                        vehiclemeters = DrivingDistance[plate]
                                    end
                                end
                            end, plate)
                        end
                    end
                else
                    if vehiclemeters == -1 then
                        if DrivingDistance[plate] ~= nil then
                            vehiclemeters = DrivingDistance[plate]
                        end
                    end
                end

                if vehiclemeters ~= -1 then
                    if seat == ped then
                        if previousvehiclepos ~= nil then
							--print(vehiclemeters)
                            local Distance = #(pos - previousvehiclepos)
                            local DamageKey = GetDamageMultiplier(vehiclemeters)

                            vehiclemeters = vehiclemeters + ((Distance / 100) * 325)
                            DrivingDistance[plate] = vehiclemeters
							
                            if DamageKey ~= nil then
                                local DamageData = Config.MinimalMetersForDamage[DamageKey]
                                local chance = math.random(1,5)
                                local odd = math.random(1,5)
                                local CurrentData = VehicleStatus[plate]
                                if chance == odd then
									--print('damage')
                                    --for k, v in pairs(Config.Damages) do
										local randum = math.random(1,8)
										local damagedpart = ""
										if randum == 1 then 
											damagedpart = "radiator"
										elseif randum == 2 then 
											damagedpart = "axle"
										elseif randum == 3 then
											damagedpart = "brakes"
										elseif randum == 4 then
											damagedpart = "clutch"
										elseif randum == 5 then
											damagedpart = "fuelinjector"
										elseif randum == 6 then
											damagedpart = "tire"
										elseif randum == 7 then
											damagedpart = "electronic"
										elseif randum == 8 then
											damagedpart = "transmission"
										end
                                        local randmultiplier = (math.random(DamageData.multiplier.min, DamageData.multiplier.max) / 100)
                                        local newDamage = 0
                                        if CurrentData[damagedpart] - randmultiplier >= 0 then
                                            newDamage = CurrentData[damagedpart] - randmultiplier
                                        else
                                            newDamage = 0
                                        end
                                        TriggerServerEvent('pw-mechanicjob:server:SetPartLevel', plate, damagedpart, newDamage)
                                    --end
                                    TriggerServerEvent("vehiclemod:server:saveStatus",plate)
                                end
                            end

                            local amount = round(DrivingDistance[plate] / 10000, -4)

                            --TriggerEvent('qb-hud:client:UpdateDrivingMeters', true, amount)
							
                            TriggerServerEvent('pw-mechanicjob:server:UpdateDrivingDistance', DrivingDistance[plate], plate)
							TriggerServerEvent("vehiclemod:server:saveStatus",plate)
                        end
                    else
                        if invehicle then
                            if DrivingDistance[plate] ~= nil then
                                local amount = round(DrivingDistance[plate] / 10000, -4)
                                --TriggerEvent('qb-hud:client:UpdateDrivingMeters', true, amount)
								--print('so luong'..amount)
                            end
                        else
                            if vehiclemeters ~= -1 then
                                vehiclemeters = -1
                            end
                            if CheckDone then
                                CheckDone = false
                            end
                        end
                    end
                end

                previousvehiclepos = pos
            end
        else
            if vehiclemeters ~= -1 then
                vehiclemeters = -1
            end
            if CheckDone then
                CheckDone = false
            end
            if previousvehiclepos ~= nil then
                previousvehiclepos = nil
            end
        end

        if invehicle then
            Citizen.Wait(2000)
        else
            Citizen.Wait(500)
        end
    end
end)

function round(num, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces>0 then
      local mult = 10^numDecimalPlaces
      return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
end
 
RegisterNetEvent('pw-mechanicjob:client:UpdateDrivingDistance')
AddEventHandler('pw-mechanicjob:client:UpdateDrivingDistance', function(amount, plate)
    DrivingDistance[plate] = amount
end)