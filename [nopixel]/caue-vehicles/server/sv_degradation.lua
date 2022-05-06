
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
    MySQL.query("SELECT degradation FROM `owned_vehicles` WHERE `plate` = '"..plate.."'", function(result)
        return result
    end)
end

function getMileage(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.query("SELECT mileage FROM `owned_vehicles` WHERE `plate` = '"..plate.."'", function(result)
        return result
    end)
end


RegisterNetEvent("caue-vehicles:updateVehicleHealth")
AddEventHandler("caue-vehicles:updateVehicleHealth", function(plate, body, engine)
    local src = source

    
		MySQL.query('UPDATE owned_vehicles SET body_damage = @body_damage, engine_damage = @engine_damage WHERE plate = @plate', {['@body_damage'] = body, ['@engine_damage'] = engine, ['@plate'] = plate})

      
end)

RegisterNetEvent("caue-vehicles:updateVehicleDegradation")
AddEventHandler("caue-vehicles:updateVehicleDegradation", function(source, plate, degradations)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
		MySQL.query("UPDATE `owned_vehicles` SET `degradation` = '"..json.encode(degradations).."' WHERE `plate` = '"..plate.."'")
    end
end)

RegisterNetEvent("caue-vehicles:adminRepair")
AddEventHandler("caue-vehicles:adminRepair", function(target)
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

    TriggerEvent("caue-vehicles:updateVehicleHealth", ,plate, 1000, 1000)
    TriggerEvent("caue-vehicles:updateVehicleDegradation", plate, defaultDegradation)
end)

RegisterNetEvent("caue-vehicles:bennysResetDegradation")
AddEventHandler("caue-vehicles:bennysResetDegradation", function(pVid, pPlate)
    TriggerEvent("caue-vehicles:updateVehicleDegradation", vid, pPlate, defaultDegradation)
end)

RegisterNetEvent("caue-vehicles:updateVehicleMileage")
AddEventHandler("caue-vehicles:updateVehicleMileage", function(plate, mileage)
    local src = source

    local curMileage = getMileage(plate)

	local Milerunning = curMileage + mileage
	local TimeUpdate = 0
	if not GetGameTimer() > TimeUpdate then
		TimeUpdate = GetGameTimer() + 300000

		MySQL.query("UPDATE `owned_vehicles` SET `mileage` = '"..roundDecimals(Milerunning).."' WHERE `plate` = '"..plate.."'")
	end

end)


RPC.register("caue-vehicles:getDegradation", function(src, plate)
    return getDegradation(plate)
end)

RPC.register("caue-vehicles:getMileage", function(src, plate)
    return getMileage(plate)
end)