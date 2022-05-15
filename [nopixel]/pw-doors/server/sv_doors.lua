--[[

    Events

]]

-- RegisterNetEvent("pw-base:sessionStarted")
-- AddEventHandler("pw-base:sessionStarted", function()
    -- local src = source

    -- TriggerClientEvent("pw-doors:initial-lock-state", -1, DOOR_CONFIG)
-- end)

RegisterNetEvent("pw-doors:change-lock-state")
AddEventHandler("pw-doors:change-lock-state", function(pDoorId, pDoorLockState, pDoorForceUnlock)
    local src = source

    DOOR_CONFIG[pDoorId]["lock"] = pDoorLockState
    TriggerClientEvent("pw-doors:change-lock-state", -1, pDoorId, pDoorLockState, pDoorForceUnlock)

    if DOOR_CONFIG[pDoorId]["connected"] then
        DOOR_CONFIG[DOOR_CONFIG[pDoorId]["connected"]]["lock"] = pDoorLockState
        TriggerClientEvent("pw-doors:change-lock-state", -1, DOOR_CONFIG[pDoorId]["connected"], pDoorLockState, pDoorForceUnlock)
    end
end)

RegisterNetEvent("pw-door:add")
AddEventHandler("pw-door:add", function(doorCoords, doorModel)
    local src = source
    local name = GetPlayerName(src)

    local output = '--Name: ' .. name .. ' | ' .. os.date('!%Y-%m-%dT%H:%M:%SZ\n')

    output = output .. '{\n'
    output = output .. '    ["active"] = true,\n'
    output = output .. '    ["model"] = ' .. doorModel .. ',\n'
    output = output .. '    ["coords"] = vector3(' .. string.format("%.2f", doorCoords["x"]) .. ', ' .. string.format("%.2f", doorCoords["y"]) .. ', ' .. string.format("%.2f", doorCoords ["z"]) .. '),\n'
    output = output .. '    ["lock"] = 1,\n'
    output = output .. '    ["automatic"] = {},\n'
    output = output .. '    ["access"] = {},\n'
    output = output .. '},\n\n'


    file = io.open('doors.txt', "a")
    io.output(file)
    io.write(output)
    io.close(file)

    TriggerClientEvent("DoLongHudText", src, "Door saved")
end)