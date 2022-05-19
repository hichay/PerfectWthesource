
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
    TriggerEvent('caue-vehicles:garage')
end, false)

AddEventHandler("caue-vehicles:garage", function()
    local job = ESX.GetPlayerData().job.name
    local garage = Garages[nearGarage["garage"]]

    if garage["jobGarage"] and garage["type"] ~= job then
        TriggerEvent("DoLongHudText", "You can't use this garage", 2)
        return
    end

    --[[ if garage["houseid"] and not exports["caue-housing"]:hasKey(garage["houseid"]) then
        TriggerEvent("DoLongHudText", "You can't use this garage", 2)
        return
    end ]]
	print(nearGarage["garage"])

    local vehiclesGarage = RPC.execute("caue-vehicles:getGarage", nearGarage["garage"])

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
            description = "Plate: " .. v["plate"],
            children = { 
                { title = "Take Out Vehicle", action = "caue-vehicles:retriveVehicle", key = v["plate"] },
                { title = "Vehicle Status", description = "Động cơ: " .. status.engine_damage / 10 .. "% | Thân vỏ: " .. status.body_damage / 10 .. "% | Xăng: " .. status.fuel .. "%"},
            
            }
                 
        }
    end

    exports["np-ui"]:showContextMenu(data)
end)


RegisterUICallback('caue-vehicles:retriveVehicle', function (data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local vehicle = RPC.execute("pw-vehicles:getVehicle", data.key)
    if vehicle then
        if not nearGarage["coords"] then return end
        --TriggerEvent('table',nearGarage["coords"])
        --local position = table.unpack(nearGarage["coords"])
        local x, y, z, w = table.unpack(nearGarage["coords"])
        --TriggerEvent("caue-vehicles:spawnVehicle", vehicle.model, nearGarage["coords"], vehicle.id, vehicle.plate, vehicle.fuel, vehicle.modifications, vehicle.fakePlate, vehicle.harness, vehicle.body_damage, vehicle.engine_damage)
        ESX.Game.SpawnVehicle(vehicle.model, vector3(x,y,z), w , function(veh)
            local vehicleProps = vehicle.vehicle
            ESX.Game.SetVehicleProperties(veh, vehicleProps)
            SetVehicleMod(veh,48,vehicleProps.modLivery)
            TriggerEvent("vehiclekeys:client:SetOwner", ESX.Game.GetVehicleProperties(veh).plate)	

            RPC.execute("pw-vehicles:setJobVehicleState", vehicle.plate, "0")
            TriggerEvent('DoLongHudText',"Xe đã được lấy ra khỏi garage",1)
        end)
    end
end)

--[[ AddEventHandler("caue-vehicles:retriveVehicle", function(vehID)
    local vehicle = RPC.execute("caue-vehicles:getVehicle", vehID)
    if vehicle then
        if not nearGarage["coords"] then return end

        --TriggerEvent("caue-vehicles:spawnVehicle", vehicle.model, nearGarage["coords"], vehicle.id, vehicle.plate, vehicle.fuel, vehicle.modifications, vehicle.fakePlate, vehicle.harness, vehicle.body_damage, vehicle.engine_damage)
        ESX.Game.SpawnVehicle(vehicle.model, spawnPoint.coords, spawnPoint.heading, function(veh)
            local vehicleProps = allVehicleProps[data2.current.plate]
            --TriggerEvent('table',vehicleProps)
            
            ESX.Game.SetVehicleProperties(veh, vehicle.vehicle)
            SetVehicleMod(veh,48,vehicleProps.modLivery)
            TriggerEvent("vehiclekeys:client:SetOwner", ESX.Game.GetVehicleProperties(veh).plate)	

            RPC.execute("pw-vehicles:setJobVehicleState", vehicle.id, "0")
            TriggerEvent('DoLongHudText',"Xe đã được lấy ra khỏi garage",1)
        end)
    end
end) ]]

AddEventHandler("caue-vehicles:storeVehicle", function(params)
    --local vid = GetVehicleIdentifier(vehicle)
    local lastveh = GetVehiclePedIsIn(PlayerPedId(),true)
    local plate = GetVehicleNumberPlateText(lasteveh)
    if not vid then return end

    local garage = nearGarage["garage"]
    if garage == "" then return end

    --local canStore = RPC.execute("caue-vehicles:canStoreVehicle", plate)
    local vehicle = RPC.execute("caue-vehicles:getVehicle", plate)
    if not vehicle then return end

    local garageData = Garages[nearGarage["garage"]]

    --[[ if garageData["houseid"] then
        if exports["caue-housing"]:hasKey(garageData["houseid"]) then
            local cid = exports["caue-base"]:getChar("id")
            local owner = RPC.execute("caue-vehicles:selectVehicle", vid, "vehicles", "cid")

            if owner ~= cid then
                TriggerEvent("DoLongHudText", "You cant't use this garage", 2)
                return
            end
        else
            TriggerEvent("DoLongHudText", "You can't use this garage", 2)
            return
        end
    end ]]
    RPC.execute("pw-vehicles:setJobVehicleState", plate, "1")
    Sync.DeleteVehicle(lastveh)
    Sync.DeleteEntity(lastveh)
    --[[ local store1 = RPC.execute("caue-vehicles:updateVehicle", vid, "garage", "garage", garage)
    if store1 then
        local store2 = RPC.execute("caue-vehicles:updateVehicle", vid, "garage", "state", "In")
        if store2 then
            Sync.DeleteVehicle(vehicle)
            Sync.DeleteEntity(vehicle)
        end
    end ]]
end)

RegisterNetEvent("caue-vehicles:setGarage")
AddEventHandler("caue-vehicles:setGarage", function(pGarage, pVar, pValue, pEdit)
    if pEdit then
        Garages[pGarage][pVar] = pValue
    else
        Garages[pGarage] = pVar
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(2000)

    Garages = RPC.execute("caue-vehicles:requestGarages")
end)