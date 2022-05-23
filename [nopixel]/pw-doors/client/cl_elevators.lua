local Elevators = {}
local currentFloorId = nil
local currentElevator = nil

Citizen.CreateThread(function()
    Elevators = RPC.execute("pw-doors:elevators:fetch")

    setSecuredAccesses(Elevators, "elevator")

    for elevatorId, elevator in ipairs(Elevators) do
        local floors = elevator.floors

        for floorId, floor in ipairs(floors) do
            local zones = floor.zones

            for zoneId, zone in ipairs(zones) do
                if not zone.options.data then zone.options.data = {} end

                local data, lib = zone.options.data or {}, zone.target and "pw-polytarget" or "pw-polyzone"

                data.floorId = floorId
                data.elevatorId = elevatorId

                if zone.type == "box" then
                    exports[lib]:AddBoxZone("pw-doors:elevator", zone.center, zone.width, zone.length, zone.options)
                elseif zone.type == "circle" then
                    exports[lib]:AddCircleZone("pw-doors:elevator", zone.center, zone.radius, zone.options)
                end
            end
        end
    end

    exports['pw-interact']:AddPeekEntryByPolyTarget('pw-doors:elevator', {
        {
            id = "elevatorPrompt",
            event = "pw-doors:elevator:prompt",
            icon = "chevron-circle-up",
            label = "Elevator"
        }}, { distance = { radius = 1.5 } })
end)



AddEventHandler('pw-doors:elevator:prompt', function(pParameters, pEntity, pContext)
    local data = pContext.zones and pContext.zones['pw-doors:elevator']

    if not data or not Elevators[data.elevatorId] then return end

    local hasHackingDevice = exports["pw-inventory"]:hasEnoughOfItem('water', 1)

    OpenElevatorMenu(data.elevatorId, data.floorId, hasHackingDevice)
end)

function OpenElevatorMenu(pElevator, pCurrentFloor, pBreachingDevice)
    local elevator = Elevators[pElevator]

    if not elevator then return end

    currentElevator = elevator

    local elements, access, hasAccess = {}, {}, hasSecuredAccess(pElevator, 'elevator')

    for floorId, floor in ipairs(elevator.floors) do
        local isCurrentFloor = floorId == pCurrentFloor
        local isRestricted = floor.locked and not hasAccess

        local status = ''

        if isCurrentFloor then
            currentFloorId = floorId
            status = status .. ' | Tầng đang ở'
        end

        if isRestricted then
            status = status .. ' | Hạn chế'
        end

        elements[#elements+1] = {
            title = floor.name .. status,
            description = floor.description,
            action = (not isCurrentFloor and not isRestricted) and 'pw-doors:elevator:teleport' or '',
            key = floor.teleport,
            disabled = isCurrentFloor or isRestricted
        }

        if hasAccess then
            access[#access+1] = {
                title = floor.name .. (floor.locked and ' | Hiện đang khóa' or ' | Hiện đang mở'),
                action = 'pw-doors:elevator:access',
                key = { elevatorId = pElevator, floorId = floorId, locked = floor.locked}
            }
        end
    end

    if hasAccess then
        elements[#elements+1] = {
            title = 'Quản lý',
            children = access
        }
    end

    if not hasAccess and pBreachingDevice then
        elements[#elements+1] = {
            title = 'Hack Control Panel',
            action = 'pw-doors:elevator:hackControlPanel',
            key = { type = "elevator", id = pElevator }
        }
    end

    exports['np-ui']:showContextMenu(reverse(elements))
end



function TeleportPlayer(pCoords, pOnArriveEvent)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local teleportCoords = vector3(pCoords["x"], pCoords["y"], pCoords["z"])
    local heading = pCoords["w"]

    local time = math.floor((#(teleportCoords - playerCoords) / 50) * 100)
    local entity = IsPedInAnyVehicle(playerPed) and GetVehiclePedIsIn(playerPed) or playerPed

    DoScreenFadeOut(400)

    for floorId, floor in ipairs(currentElevator.floors) do
        if floorId == currentFloorId then
          if floor.teleport and floor.teleport.onLeaveEvent then
            TriggerEvent(floor.teleport.onLeaveEvent)
          end
        end
    end

    while IsScreenFadingOut() do
        Citizen.Wait(0)
    end

    NetworkFadeOutEntity(playerPed, true, true)

    SetPedCoordsKeepVehicle(playerPed, teleportCoords)

    SetEntityHeading(entity, heading)

    SetGameplayCamRelativeHeading(0.0)

    Citizen.Wait(time)

    if pOnArriveEvent then
        TriggerEvent(pOnArriveEvent)
    end

    NetworkFadeInEntity(playerPed, true)

    DoScreenFadeIn(400)
end



RegisterUICallback('pw-doors:elevator:teleport', function (data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })

    local taskActive, coords, heading, onArriveEvent, onLeaveEvent =
      true, data.key.coords, data.key.heading, data.key.onArriveEvent, data.key.onLeaveEvent

    Citizen.CreateThread(function ()
        local playerPed = PlayerPedId()
        local startingCoords = GetEntityCoords(playerPed)

        while taskActive do
            local playerCoords = GetEntityCoords(playerPed)

            if #(startingCoords - playerCoords) >= 1.6 or IsPedRagdoll(playerPed) or IsPedBeingStunned(playerPed) then
                exports['np-taskbar'].taskCancel()
            end

            Citizen.Wait(100)
        end
    end)

    local time = math.random(4000, 12000)
    local finished = exports["np-taskbar"]:taskBar(time, "Waiting for the Elevator", false)

    taskActive = false

    if finished ~= 100 then return end

    TeleportPlayer(coords, heading, onArriveEvent, onLeaveEvent)
end)


RegisterUICallback('pw-doors:elevator:access', function (data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })

    local elevatorId, floorId, locked = data.key.elevatorId, data.key.floorId, data.key.locked

    if not hasSecuredAccess(elevatorId, 'elevator') then return end

    TriggerServerEvent('pw-doors:change-elevator-state', elevatorId, floorId, not locked)
end)

RegisterNetEvent("pw-doors:elevators:updateState")
AddEventHandler("pw-doors:elevators:updateState", function (pElevatorId, pFloorId, pRestricted, pForceUnlock)
    local elevator = Elevators[pElevatorId]

    if not elevator then return end

    elevator["forceUnlocked"] = pForceUnlock
    elevator["floors"][pFloorId]["locked"] = pRestricted
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    Citizen.Wait(3000)

    Elevators = RPC.execute("pw-doors:elevators:fetch")

    setSecuredAccesses(Elevators, "elevator")

    for elevatorId, elevator in ipairs(Elevators) do
        local floors = elevator.floors

        for floorId, floor in ipairs(floors) do
            local zones = floor.zones

            for zoneId, zone in ipairs(zones) do
                if not zone.options.data then zone.options.data = {} end

                local data, lib = zone.options.data or {}, zone.target and "pw-polytarget" or "pw-polyzone"

                data.floorId = floorId
                data.elevatorId = elevatorId

                if zone.type == "box" then
                    exports[lib]:AddBoxZone("pw-doors:elevator", zone.center, zone.width, zone.length, zone.options)
                elseif zone.type == "circle" then
                    exports[lib]:AddCircleZone("pw-doors:elevator", zone.center, zone.radius, zone.options)
                end
            end
        end
    end

    -- PolyZoneInteraction("pw-doors:elevator:prompt", "[E] For Elevator", 38, function (data)
    --     if not data or not Elevators[data.elevatorId] then return end

    --     OpenElevatorMenu(data.elevatorId, data.floorId)
    -- end)

    local peek = {
        group = { "pw-doors:elevator" },
        data = {
            {
                id = "elevatorPrompt",
                label = "Elevator",
                icon = "chevron-circle-up",
                event = "pw-doors:elevator:prompt",
                parameters = {},
            }
        },
        options = {
            distance = { radius = 1.5 }
        }
    }

    exports["pw-interact"]:AddPeekEntryByPolyTarget(peek.group, peek.data, peek.options)
end)

RegisterUICallback('pw-doors:elevator:hackControlPanel', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })

    local id = data.key.id
    local accessType = data.key.type

    local hackId = RPC.execute('np-doors:startAccessHack', accessType, id)

    if not hackId then return TriggerEvent('DoLongHudText', 'Unable to establish connection', 2) end

    exports['np-ui']:openApplication('memorygame', {
        gameFinishedEndpoint = 'np-doors:elevator:completeHacking',
        gameTimeoutDuration = 14000,
        coloredSquares =  10,
        gridSize = 5,
        parameters = {
            hackId = hackId,
        },
    })
end)

RegisterUICallback('np-doors:elevator:completeHacking', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })

    local success = data.success
    local hackId = data.parameters.hackId

    RPC.execute('np-doors:completeAccessHack', success, hackId)

    clearAccessCache()

    Citizen.Wait(3000)

    exports['np-ui']:closeApplication('memorygame')
end)