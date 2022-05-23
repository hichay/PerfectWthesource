
local vehiclesGarage = {}

local nearGarage = {
    ["garage"] = "",
    ["space"] = 0,
    ["coords"] = nil,
}

local Garages = {}


function IsOnParkingSpot(pEntity, pCheck, pRadius)
    local entityCoords = GetEntityCoords(pEntity)

    local _distance = 300
    local garage = nil
    for k, v in pairs(Garages) do
        local distance = #(entityCoords - v["pos"]["xyz"])

        if distance < _distance then
            if distance < v["distance"] then
                _distance = distance
                garage = k
            end
        end
    end

    if not garage then
        return false
    end

    local radius = 2.0
    if pRadius then
        radius = pRadius
    end

    local space = nil
    local nearest = 999.99
    for i, v in ipairs(Garages[garage]["spaces"]) do
        local distance = #(entityCoords - v["xyz"])
        if distance < radius and distance < nearest then
            if pCheck and not IsAnyVehicleNearPoint(v["x"], v["y"], v["z"], radius) then
                space = i
                nearest = distance
            else
                space = i
                nearest = distance
            end
        end
    end

    if not space then
        return false
    end

    nearGarage = {
        ["garage"] = garage,
        ["space"] = space,
        ["coords"] = Garages[garage]["spaces"][space],
    }

    return true
end


exports("IsOnParkingSpot", IsOnParkingSpot)
RegisterCommand("openga", function(source, args, rawCommand)
    TriggerEvent('pw-vehicles:garage')
end, false)

AddEventHandler("pw-vehicles:garage", function()
    local job = ESX.GetPlayerData().job.name
    local garage = Garages[nearGarage["garage"]]

    if garage["jobGarage"] and garage["type"] ~= job then
        TriggerEvent("DoLongHudText", "Bạn không có quyền sử dụng garage này", 2)
        return
    end

    --[[ if garage["houseid"] and not exports["pw-housing"]:hasKey(garage["houseid"]) then
        TriggerEvent("DoLongHudText", "Bạn không có quyền sử dụng garage này", 2)
        return
    end ]]

    local vehiclesGarage = RPC.execute("pw-vehicles:getGarage", nearGarage["garage"])

    local data = {
        {
            title = "Garage " .. nearGarage["garage"],
        }
    }
	--TriggerEvent('table',vehiclesGarage)

    for i, v in ipairs(vehiclesGarage) do
        local status = json.decode(v.stats)
        data[#data + 1] = {
            
            title = GetLabelText(GetDisplayNameFromVehicleModel(v["model"])),
            description = "Biển: " .. v["plate"],
            disabled = v.stored,
            children = { 
                { title = "Lấy xe ra", action = "pw-vehicles:retriveVehicle", key = v["plate"] },
                { title = "Tình trạng", description = "Động cơ: " .. status.engine_damage / 10 .. "% | Thân vỏ: " .. status.body_damage / 10 .. "% | Xăng: " .. status.fuel .. "%"},
            
            }
                 
        }
    end

    exports["np-ui"]:showContextMenu(data)
end)


RegisterUICallback('pw-vehicles:retriveVehicle', function (data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local vehicle = RPC.execute("pw-vehicles:getVehicle", data.key)
    if vehicle then
        if not nearGarage["coords"] then return end
        --TriggerEvent('table',nearGarage["coords"])
        --local position = table.unpack(nearGarage["coords"])
        local x, y, z, w = table.unpack(nearGarage["coords"])
        --TriggerEvent("pw-vehicles:spawnVehicle", vehicle.model, nearGarage["coords"], vehicle.id, vehicle.plate, vehicle.fuel, vehicle.modifications, vehicle.fakePlate, vehicle.harness, vehicle.body_damage, vehicle.engine_damage)
        ESX.Game.SpawnVehicle(vehicle.model, vector3(x,y,z), w , function(veh)
            local vehicleProps = json.decode(vehicle.vehicle)
            ESX.Game.SetVehicleProperties(veh, vehicleProps)
            SetVehicleMod(veh,48,vehicleProps.modLivery)
            TriggerEvent("vehiclekeys:client:SetOwner", ESX.Game.GetVehicleProperties(veh).plate)	
            --SetVehicleNumberPlateText(veh,)
            RPC.execute("pw-vehicles:setJobVehicleState", vehicle.plate, "1")
            TriggerEvent('DoLongHudText',"Xe đã được lấy ra khỏi garage",1)
        end)
    end
end)


AddEventHandler("pw-vehicles:storeVehicle", function(params, pEntity)

    local lastveh = GetVehiclePedIsIn(PlayerPedId(),true)
    local plate = GetVehicleNumberPlateText(pEntity)

    local vehicle = RPC.execute("pw-vehicles:getVehicle", plate)
    if not vehicle then return end

    local garageData = Garages[nearGarage["garage"]]

    RPC.execute("pw-vehicles:setJobVehicleState", plate, "0")
    Sync.DeleteVehicle(pEntity)
    Sync.DeleteEntity(pEntity)
    TriggerEvent('DoLongHudText',"Xe đã được cất vào garage",1)
end)

RegisterNetEvent("pw-vehicles:setGarage")
AddEventHandler("pw-vehicles:setGarage", function(pGarage, pVar, pValue, pEdit)
    if pEdit then
        Garages[pGarage][pVar] = pValue
    else
        Garages[pGarage] = pVar
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(2000)

    Garages = RPC.execute("pw-vehicles:requestGarages")
end)