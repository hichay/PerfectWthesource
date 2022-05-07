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

function GetVehicleStatus(plate)
    local retval = nil
    MySQL.query("SELECT `status` FROM `owned_vehicles` WHERE `plate` = '"..plate.."'", function(result)
        if result[1] ~= nil then
            retval = result[1].status ~= nil and json.decode(result[1].status) or nil
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
AddEventHandler('pw-mechanicjob:server:SetAttachedVehicle', function(veh, k)
    if veh ~= false then
        Config.Plates[k].AttachedVehicle = veh
        TriggerClientEvent('pw-mechanicjob:client:SetAttachedVehicle', -1, veh, k)
    else
        Config.Plates[k].AttachedVehicle = nil
        TriggerClientEvent('pw-mechanicjob:client:SetAttachedVehicle', -1, false, k)
    end
end)


function IsAuthorized(CitizenId)
    local retval = false
    for _, cid in pairs(Config.AuthorizedIds) do
        if cid == CitizenId then
            retval = true
            break
        end
    end
    return retval
end



ESX.RegisterServerCallback('pw-mechanicjob:GetDressing', function(source, cb)
    local xPlayer  = GetPlayerFromId(source)
    while not xPlayer do xPlayer = GetPlayerFromId(source); Citizen.Wait(tonumber('0')); end
    local lab = false
    TriggerEvent('esx_datastore:getDataStore', 'property', Identifier(xPlayer), function(store)
      local count  = store.count('dressing')
      local labels = {}
      for i=tonumber('1'), count, tonumber('1') do
        local entry = store.get('dressing', i)
        table.insert(labels, entry.label)
      end
      lab = labels
    end) 
    while not lab do Citizen.Wait(tonumber('0')); end
    cb(lab)
end)

ESX.RegisterServerCallback('pw-mechanicjob:getOutfit', function(source, cb, num)
    local xPlayer  = GetPlayerFromId(source)
    while not xPlayer do xPlayer = GetPlayerFromId(source); Citizen.Wait(tonumber('0')); end
    local lab = false
    TriggerEvent('esx_datastore:getDataStore', 'property', Identifier(xPlayer), function(store)
      local outfit = store.get('dressing', num)
      lab = outfit.skin
    end)
    while not lab do Citizen.Wait(tonumber('0')); end
    cb(lab)
end)