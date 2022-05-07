ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local defaultDegradation = {
    ["brake"] = 100,
    ["axle"] = 100,
    ["radiator"] = 100,
    ["clutch"] = 100,
    ["transmission"] = 100,
    ["electronics"] = 100,
    ["injector"] = 100,
    ["tire"] = 100,
}

local vehiclesHealth = {
    ["identifier"] = {},
    ["plate"] = {},
}

local vehiclesDegradation = {
    ["identifier"] = {},
    ["plate"] = {},
}

local vehiclesMileage = {
    ["identifier"] = {},
    ["plate"] = {},
    ["updates"] = {},
}

function getDegradation(plate)
	local xPlayer = ESX.GetPlayerFromId(source)
    local result = MySQL.scalar.await("SELECT degradation FROM `owned_vehicles` WHERE `plate` = '"..plate.."'")
	return result
	
end

function getMileage(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
	
	local result = MySQL.scalar.await("SELECT mileage FROM `owned_vehicles` WHERE `plate` = '"..plate.."'")

	return result
end


RegisterNetEvent("pw-vehicles:updateVehicleHealth")
AddEventHandler("pw-vehicles:updateVehicleHealth", function(plate, body, engine)
    local src = source

	MySQL.query('UPDATE owned_vehicles SET body_damage = @body_damage, engine_damage = @engine_damage WHERE plate = @plate', {['@body_damage'] = body, ['@engine_damage'] = engine, ['@plate'] = plate})

end)

RegisterNetEvent("pw-vehicles:updateVehicleDegradation")
AddEventHandler("pw-vehicles:updateVehicleDegradation", function(plate, degradations)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(source)
    --if xPlayer then
		MySQL.query("UPDATE `owned_vehicles` SET `degradation` = '"..json.encode(degradations).."' WHERE `plate` = '"..plate.."'")
    --end
end)

RegisterNetEvent("pw-vehicles:adminRepair")
AddEventHandler("pw-vehicles:adminRepair", function(target)
    if not target then return end

    local ped = GetPlayerPed(target)
    if not ped then return end

    local vehicle = GetVehiclePedIsIn(ped, false)
    if not vehicle then return end

    local plate = string.gsub(GetVehicleNumberPlateText(vehicle), "%s+", "")
    if not plate then return end

    local vid = MySQL.scalar.await([[
        SELECT id
        FROM vehicles
        WHERE plate = ?
    ]],
    { plate })

    TriggerEvent("pw-vehicles:updateVehicleHealth",plate, 1000, 1000)
    TriggerEvent("pw-vehicles:updateVehicleDegradation", plate, defaultDegradation)
end)

RegisterNetEvent("pw-vehicles:bennysResetDegradation")
AddEventHandler("pw-vehicles:bennysResetDegradation", function(pVid, pPlate)
    TriggerEvent("pw-vehicles:updateVehicleDegradation", vid, pPlate, defaultDegradation)
end)

RegisterNetEvent("pw-vehicles:updateVehicleMileage")
AddEventHandler("pw-vehicles:updateVehicleMileage", function(plate, mileage)
    local src = source

    local curMileage = getMileage(plate)
	local Milerunning = curMileage + mileage
	local TimeUpdate = 0
	if GetGameTimer() > TimeUpdate then
		TimeUpdate = GetGameTimer() + 0

		MySQL.query("UPDATE `owned_vehicles` SET mileage = '"..Milerunning.."' WHERE `plate` = '"..plate.."'")
	end

end)


RPC.register("pw-vehicles:getDegradation", function(src, plate)
    return getDegradation(plate)
end)

RPC.register("pw-vehicles:getMileage", function(src, plate)
    return getMileage(plate)
end)