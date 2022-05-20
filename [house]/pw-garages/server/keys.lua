ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local VehicleList = {}

ESX.RegisterServerCallback('vehiclekeys:CheckHasKey', function(source, cb, plate, vehicle)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(CheckOwner(plate, xPlayer.getIdentifier(),vehicle))
    --print(CheckOwner(plate, xPlayer.getIdentifier(),vehicle))
    --[[ local identifier = GetPlayerIdentifier(source, 0)

	exports['ghmattimysql']:execute('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == xPlayer.identifier)
        else
            if CheckOwner(plate, xPlayer.getIdentifier()) then
                cb(true)
            else
			    cb(false)
            end
		end
	end) ]]
    
end)

RPC.register('HasVehicleKey',function(src, plate, vehicle)
	local xPlayer = ESX.GetPlayerFromId(source)
	return CheckOwner(plate, xPlayer.getIdentifier(),vehicle)
end)



RegisterServerEvent('vehiclekeys:server:SetVehicleOwner')
AddEventHandler('vehiclekeys:server:SetVehicleOwner', function(plate)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    if VehicleList ~= nil then
        if DoesPlateExist(plate) then
			
            for k, val in pairs(VehicleList) do
                if val.plate == plate then
                    table.insert(VehicleList[k].owners, Player.getIdentifier())
                end
            end
        else
            local vehicleId = #VehicleList+1
            VehicleList[vehicleId] = {
                plate = plate, 
                owners = {},
            }
            VehicleList[vehicleId].owners[1] = Player.getIdentifier()
        end
    else
        local vehicleId = #VehicleList+1
        VehicleList[vehicleId] = {
            plate = plate, 
            owners = {},
        }
        VehicleList[vehicleId].owners[1] = Player.getIdentifier()
    end
end)

RegisterServerEvent('vehiclekeys:server:GiveVehicleKeys')
AddEventHandler('vehiclekeys:server:GiveVehicleKeys', function(plate, target)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if CheckOwner(plate, xPlayer.getIdentifier()) then
        if ESX.GetPlayerFromId(target) ~= nil then
            TriggerClientEvent('vehiclekeys:client:SetOwner', target, plate)
            TriggerClientEvent('ESX:Notify', src, "Bạn đã đưa chìa khóa thành công!")

            TriggerClientEvent('ESX:Notify', target, "Bạn vừa nhận được chìa khóa!")
        else
            TriggerClientEvent('ESX:Notify', target, "Người chơi không online!")
        end
    else
        TriggerClientEvent('ESX:Notify', target, "Bạn không có chìa khóa xe này!","error")
    end
end)

--[[ QBCore.Commands.Add("motor", "Toggle engine On/Off of the vehicle", {}, false, function(source, args)
	TriggerClientEvent('vehiclekeys:client:ToggleEngine', source)
end)

QBCore.Commands.Add("geefsleutels", "Give keys of the vehicle", {{name = "id", help = "Speler id"}}, true, function(source, args)
	local src = source
    local target = tonumber(args[1])
    TriggerClientEvent('vehiclekeys:client:GiveKeys', src, target)
end) ]]

function DoesPlateExist(plate)
    if VehicleList ~= nil then
        for k, val in pairs(VehicleList) do
            if val.plate == plate then
                return true
            end
        end
    end
    return false
end


function CheckOwner(plate, identifier, vehicle)
    local retval = false
    if VehicleList ~= nil then
        for k, val in pairs(VehicleList) do
            if (val.vehicle ~= nil and val.vehicle == vehicle) or val.plate == plate then
                for key, owner in pairs(VehicleList[k].owners) do
                    if owner == identifier then
                        retval = true
                    end
                end
            end
        end
    end
    return retval
end

--[[ QBCore.Functions.CreateUseableItem("lockpick", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent("lockpicks:UseLockpick", source, false)
end)

QBCore.Functions.CreateUseableItem("advancedlockpick", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent("lockpicks:UseLockpick", source, true)
end) ]]