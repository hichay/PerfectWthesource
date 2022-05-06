function AdvStatsFunction(plate, mileage, maxhealth)
    if AdvStatsTable[plate] == nil then
        AdvStatsTable[plate] = {}
        AdvStatsTable[plate].plate = plate
        AdvStatsTable[plate].mileage = mileage
        AdvStatsTable[plate].maxhealth = maxhealth
    end
end

if Config.UseMileage then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsUsing(ped)
            local plate = tostring(GetVehicleNumberPlateText(vehicle))
            local newPos = GetEntityCoords(ped)      

            if IsPedInAnyVehicle(ped, false)  then
                if plate ~= nil then
                    if AdvStatsTable[plate] ~= nil then
                        if AdvStatsTable[plate].plate == plate then
                            if oldPos == nil then
                                oldPos = newPos
                            end
                            local dist = #(newPos-oldPos)
                            if dist > 10.0 then
                                AdvStatsTable[plate].mileage = AdvStatsTable[plate].mileage+GetEntitySpeed(vehicle)*Config.MileageMultiplier/100
                                oldPos = newPos
                            end
                        end
                    end
                end
            else
                Wait(1000)
            end
        end
    end)
end

RegisterNetEvent('cd_garage:checkmileage')
AddEventHandler('cd_garage:checkmileage', function()
    local ped = GetPlayerPed(-1)
    if IsPedInAnyVehicle(ped, false) then
        local vehicle = GetVehiclePedIsIn(ped,false)
        local plate = tostring(GetVehicleNumberPlateText(vehicle))
        local AdvStats = GetAdvStats(plate, false)
        if AdvStats then
            if AdvStats.plate ~= nil then
                if AdvStats.plate == plate then
                    local maxhealth = GetMaxHealth(AdvStats.mileage)
                    if Config.SpeedMetrics == 'miles' then
                        Success_Notification(Locales[Config.Language]['miles_check_miles'], roundDecimals(AdvStats.mileage, 2))
                    else
                        Success_Notification(Locales[Config.Language]['miles_check_kilometers'], roundDecimals(AdvStats.mileage, 2))
                    end
                    if Config.ShowMaxHealth then
                        Success_Notification(Locales[Config.Language]['maxhealth_check'], round(maxhealth)..' / 1000')
                    end
                end
            else
                Error_Notification(Locales[Config.Language]['advstats_nill'])
            end
        else
            print('the adv_stat function returned nil value')
        end
    else
        Error_Notification(Locales[Config.Language]['get_inside_veh'])
    end
end)

function GetMaxHealth(mileage)
    if mileage == nil then
        return 1000.0
    end
    if mileage >= 30000.0 and mileage < 45000.0 then
        return  950.0
    elseif mileage >= 45000.0 and mileage < 60000.0 then
        return  900.0
    elseif mileage >= 60000.0 and mileage < 75000.0 then
        return  850.0
    elseif mileage >= 75000.0 and mileage < 90000.0 then
        return  800.0
    elseif mileage >= 90000.0 and mileage < 105000.0 then
        return  750.0
    elseif mileage >= 105000.0 and mileage < 120000.0 then
        return  700.0
    elseif mileage >= 120000.0 and mileage < 135000.0 then
        return  650.0
    elseif mileage >= 135000.0 and mileage < 150000.0 then
        return  600.0
    elseif mileage >= 150000.0 and mileage < 165000.0 then
        return  550.0
    elseif mileage >= 165000.0 and mileage < 180000.0 then
        return  500.0
    elseif mileage >= 180000.0 and mileage < 195000.0 then
        return  450.0
    elseif mileage >= 195000.0 and mileage < 210000.0 then
        return  400.0
    elseif mileage >= 210000.0 then
        return 300.0
    else
        return 1000.0
    end
end

function GetAdvStats(plate, insidegarage)
    if Config.UseMileage then
        if plate ~= nil then
            local result
            if AdvStatsTable[plate] ~= nil then
                if AdvStatsTable[plate].plate == nil then
                    AdvStatsTable[plate].plate = plate
                elseif AdvStatsTable[plate].mileage == nil then
                    AdvStatsTable[plate].mileage = 0.0
                elseif AdvStatsTable[plate].maxhealth == nil then
                    AdvStatsTable[plate].maxhealth = 1000.0
                end
                return AdvStatsTable[plate]
            else
                local AdvStats = Callback(plate)
                local timeout = 0 while not AdvStats and timeout <= 50 do Wait(0) timeout=timeout+1 end
                if AdvStats then
                    AdvStatsFunction(plate, AdvStats.mileage, AdvStats.maxhealth)
                    local timeout = 0 while AdvStatsTable[plate] == nil and timeout <= 50 do Wait(0) timeout=timeout+1 end
                    if AdvStatsTable[plate].plate == nil then
                        AdvStatsTable[plate].plate = plate
                    elseif AdvStatsTable[plate].mileage == nil then
                        AdvStatsTable[plate].mileage = 0.0
                    elseif AdvStatsTable[plate].maxhealth == nil then
                        AdvStatsTable[plate].maxhealth = 1000.0
                    end
                    return AdvStatsTable[plate]
                else
                    if insidegarage then
                        return {mileage = 0.0}
                    else
                        return false
                    end
                end
            end
        else
            return false
        end
    else
        return false
    end
end

function Callback(plate)
    CB_id = CB_id + 1
    TriggerServerEvent('cd_garage:Callback', CB_id, plate)
    local timeout = 0 while CB[CB_id] == nil and timeout <= 50 do Wait(0) timeout=timeout+1 end
    return CB[CB_id]
end

RegisterNetEvent('cd_garage:Callback')
AddEventHandler('cd_garage:Callback', function(id, result)
    CB[id] = result
    Wait(5000)
    CB[id] = nil
end)