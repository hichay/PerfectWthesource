ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local VehicleStatus = {}
local VehicleDrivingDistance = {}

ESX.RegisterServerCallback('pw-mechanicjob:server:GetDrivingDistances', function(source, cb)
    cb(VehicleDrivingDistance)
end)

RegisterServerEvent("vehiclemod:server:setupVehicleStatus")
AddEventHandler("vehiclemod:server:setupVehicleStatus", function(plate, engineHealth, bodyHealth)
    local src = source
    local engineHealth = engineHealth ~= nil and engineHealth or 1000.0
    local bodyHealth = bodyHealth ~= nil and bodyHealth or 1000.0
    if VehicleStatus[plate] == nil then 
        if IsVehicleOwned(plate) then
            local statusInfo = GetVehicleStatus(plate)
            if statusInfo == nil then 
                statusInfo =  {
                    ["engine_damage"] = engineHealth,
                    ["body_damage"] = bodyHealth,
					["dirty"] = Config.MaxStatusValues["dirty"],
                    ["radiator"] = Config.MaxStatusValues["radiator"],
                    ["axle"] = Config.MaxStatusValues["axle"],
                    ["brakes"] = Config.MaxStatusValues["brakes"],
                    ["clutch"] = Config.MaxStatusValues["clutch"],
                    ["fuelinjector"] = Config.MaxStatusValues["fuelinjector"],
					["tire"] = Config.MaxStatusValues["tire"],
					["cooling"] = Config.MaxStatusValues["cooling"],
					["electronic"] = Config.MaxStatusValues["electronic"],
					["transmission"] = Config.MaxStatusValues["transmission"],
                }
            end
            VehicleStatus[plate] = statusInfo
            TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, statusInfo)
        else
            local statusInfo = {
                ["engine_damage"] = engineHealth,
				["body_damage"] = bodyHealth,
				["dirty"] = Config.MaxStatusValues["dirty"],
				["radiator"] = Config.MaxStatusValues["radiator"],
				["axle"] = Config.MaxStatusValues["axle"],
				["brakes"] = Config.MaxStatusValues["brakes"],
				["clutch"] = Config.MaxStatusValues["clutch"],
				["fuelinjector"] = Config.MaxStatusValues["fuelinjector"],
				["tire"] = Config.MaxStatusValues["tire"],
				["cooling"] = Config.MaxStatusValues["cooling"],
				["electronic"] = Config.MaxStatusValues["electronic"],
				["transmission"] = Config.MaxStatusValues["transmission"],
            }
            VehicleStatus[plate] = statusInfo
            TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, statusInfo)
        end
    else
        TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

--[[ RegisterServerEvent('pw-mechanicjob:server:UpdateDrivingDistance')
AddEventHandler('pw-mechanicjob:server:UpdateDrivingDistance', function(amount, plate)
    VehicleDrivingDistance[plate] = amount

    TriggerClientEvent('pw-mechanicjob:client:UpdateDrivingDistance', -1, VehicleDrivingDistance[plate], plate)

    MySQL.query("SELECT * FROM `owned_vehicles` WHERE `plate` = '"..plate.."'", function(result)
        if result[1] ~= nil then
            MySQL.query("UPDATE `owned_vehicles` SET `drivingdistance` = '"..amount.."' WHERE `plate` = '"..plate.."'")
        end
    end)
end) ]]

ESX.RegisterServerCallback('pw-mechanicjob:server:IsVehicleOwned', function(source, cb, plate)
    local retval = false
    MySQL.query("SELECT * FROM `owned_vehicles` WHERE `plate` = '"..plate.."'", function(result)
        if result[1] ~= nil then
            retval = true
        end
        cb(retval)
    end)
end)

RegisterServerEvent('pw-mechanicjob:server:LoadStatus')
AddEventHandler('pw-mechanicjob:server:LoadStatus', function(veh, plate)
    VehicleStatus[plate] = veh
    TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, veh)
end)

RegisterServerEvent("vehiclemod:server:updatePart")
AddEventHandler("vehiclemod:server:updatePart", function(plate, part, level)
    if VehicleStatus[plate] ~= nil then
        if part == "engine_damage" or part == "body_damage" then
            VehicleStatus[plate][part] = level
            if VehicleStatus[plate][part] < 0 then
                VehicleStatus[plate][part] = 0
            elseif VehicleStatus[plate][part] > 1000 then
                VehicleStatus[plate][part] = 1000.0
            end
        else
            VehicleStatus[plate][part] = level
            if VehicleStatus[plate][part] < 0 then
                VehicleStatus[plate][part] = 0
            elseif VehicleStatus[plate][part] > 100 then
                VehicleStatus[plate][part] = 100
            end
        end
        TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

RegisterServerEvent('pw-mechanicjob:server:SetPartLevel')
AddEventHandler('pw-mechanicjob:server:SetPartLevel', function(plate, part, level)
    if VehicleStatus[plate] ~= nil then
        VehicleStatus[plate][part] = level
        TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

RegisterServerEvent("vehiclemod:server:fixEverything")
AddEventHandler("vehiclemod:server:fixEverything", function(plate)
    if VehicleStatus[plate] ~= nil then 
        for k, v in pairs(Config.MaxStatusValues) do
            VehicleStatus[plate][k] = v
        end
        TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

RegisterServerEvent("vehiclemod:server:saveStatus")
AddEventHandler("vehiclemod:server:saveStatus", function(plate)
	--print(VehicleStatus[plate])
	-- for k,v in pairs(VehicleStatus[plate]) do
		-- print(k,v)
	-- end
	
    if VehicleStatus[plate] ~= nil then
        MySQL.query('UPDATE owned_vehicles SET stats = @stats WHERE plate = @plate', {['@stats'] = json.encode(VehicleStatus[plate]), ['@plate'] = plate})
    end
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


ESX.RegisterServerCallback('pw-mechanicjob:server:GetStatus', function(source, cb, plate)
    if VehicleStatus[plate] ~= nil and next(VehicleStatus[plate]) ~= nil then
        cb(VehicleStatus[plate])
    else
        cb(nil)
    end
end)

ESX.RegisterServerCallback('pw-mechanicjob:checkPropertyDataStore', function(source, cb)
    local xPlayer = GetPlayerFromId(source)
    local foundStore = false

    TriggerEvent('esx_datastore:getDataStore', 'property', Identifier(xPlayer), function(store)
        foundStore = true
    end)
    cb(foundStore)
end)

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