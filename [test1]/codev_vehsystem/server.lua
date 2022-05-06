ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('vehicle_system:getVehInfo')
AddEventHandler('vehicle_system:getVehInfo', function(plate, curVeh)
    local src = source
    local vehPlate = plate
    local vehData = {}
    local curVehicle = curVeh
    local identifier = getIdentifier(src)
        MySQL.Async.fetchAll('SELECT * FROM carsystem WHERE carplate = @plate', {['@plate'] = vehPlate}, function(result)
        local found = false
        if result[1] and result[1].carplate ~= nil then
            local vehiclePlate = result[1].carplate
            if vehiclePlate == plate then
                if vehiclePlate == vehPlate then
                    vehData.ignition = result[1].ignition
                    vehData.engine = result[1].engine
                    vehData.km = result[1].km
                    vehData.engineCheck = result[1].engineCheck
                    vehData.startCheck = result[1].startCheck
                    if identifier == result[1].owner then
                        vehData.owned = true
                    elseif result[1].owner == 'no_owner' then
                        vehData.owned = true
                    else
                        vehData.owned = false
                    end
                    found = true
                end
            end
        end
        if found then
            TriggerClientEvent('vehicle_system:getVehInfoClient', src, vehData, curVehicle)
        else
            MySQL.Async.execute('INSERT INTO carsystem (carplate) VALUES (@carplate)',{['@carplate'] = plate})
            vehData.ignition = 0
            vehData.engine = 0
            vehData.km = 0
            vehData.engineCheck = 0
            vehData.startCheck = 0
            vehData.owned = true

            TriggerClientEvent('vehicle_system:getVehInfoClient', src, vehData, curVehicle)
        end
    end)
end)

RegisterServerEvent('vehicle_system:updateVehInfo')
AddEventHandler('vehicle_system:updateVehInfo', function(plate, data)
    local src = source
    MySQL.Async.execute('INSERT INTO carsystem (carplate, ignition, engine, km) VALUES (@carplate, @ignition, @engine, @km) ON DUPLICATE KEY UPDATE ignition=@ignition, engine=@engine, km=@km',{['@ignition'] = data.ignition, ['@engine'] = '0', ['@km'] = data.km, ['@carplate'] = plate})
end)

RegisterServerEvent('vehicle_system:fixEngineCheck')
AddEventHandler('vehicle_system:fixEngineCheck', function(plate)
    local src = source
    MySQL.Async.execute('UPDATE carsystem SET engineCheck = km WHERE carplate = @carplate',{['@carplate'] = plate})
end)


RegisterServerEvent('vehicle_system:fixStartCheck')
AddEventHandler('vehicle_system:fixStartCheck', function(plate)
    local src = source
    MySQL.Async.execute('UPDATE carsystem SET startCheck = km WHERE carplate = @carplate',{['@carplate'] = plate})
end)

RegisterServerEvent('vehicle_system:setOwner')
AddEventHandler('vehicle_system:setOwner', function(source, plate)
    local src = source
    local identifier = getIdentifier(src)
    MySQL.Async.execute('UPDATE carsystem SET owner = @identifier WHERE carplate = @carplate',{['@carplate'] = plate, ['@identifier'] = identifier})
end)


RegisterCommand('fixengine', function(source, args, rawCommand)
    if true then
        TriggerClientEvent('vehicle_system:fixengine', source)
    end
end)

RegisterCommand('fixstart', function(source, args, rawCommand)
    if true then
        TriggerClientEvent('vehicle_system:fixstart', source)
    end
end)

ESX.RegisterServerCallback("vehicle_system:checkowner",function(source, cb, plate)
	local src = source
    local vehPlate = plate
	local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @vehPlate1', {['@vehPlate1'] = vehPlate}, function(result)
		
		if result[1] ~= nil and result[1].owner == xPlayer.identifier then
		 cb(true)
		else
		 cb(false)
		end
	end)	
end)

function getIdentifier(src)
    local ident
    for i, idnt in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(idnt, 1, string.len(Config.ownerIdentifier)) == Config.ownerIdentifier then
            ident = idnt
        end
    end
    return ident
end