ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('pw-mechanicjob:server:IsVehicleOwned', function(source, cb, plate)
    local retval = false
    MySQL.query("SELECT * FROM `owned_vehicles` WHERE `plate` = '"..plate.."'", function(result)
        if result[1] ~= nil then
            retval = true
        end
        cb(retval)
    end)
end)

function IsVehicleOwned(plate)
    local retval = false
    MySQL.query("SELECT * FROM `owned_vehicles` WHERE `plate` = '"..plate.."'", function(result)
        if result[1] ~= nil then
            retval = true
        end
    end)
    return retval
end


ESX.RegisterServerCallback('pw-mechanicjob:server:GetAttachedVehicle', function(source, cb)
    cb(Config.Plates)
end)

ESX.RegisterServerCallback('pw-mechanicjob:server:IsMechanicAvailable', function(source, cb)
	local amount = 0
	for k, v in pairs(ESX.GetPlayers()) do
        local Player = ESX.GetPlayerFromId(v)
        if Player ~= nil then 
            if Player.getJob().name == "mechanic" then
                amount = amount + 1
            end
        end
    end
    cb(amount)
end)

RegisterServerEvent('pw-mechanicjob:server:SetAttachedVehicle')
AddEventHandler('pw-mechanicjob:server:SetAttachedVehicle', function(veh, garage, k)
    if veh ~= false then
        Config.Customs[garage].attachvehicle[k].AttachedVehicle = veh
        --Config.Plates[k].AttachedVehicle = veh

        TriggerClientEvent('pw-mechanicjob:client:SetAttachedVehicle', -1, veh, garage, k)
    else
        Config.Customs[garage].attachvehicle[k].AttachedVehicle = false
        TriggerClientEvent('pw-mechanicjob:client:SetAttachedVehicle', -1, false, garage, k)
    end
end)


