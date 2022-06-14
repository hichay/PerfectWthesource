local Barrels = {}
local ActiveBarrels = {}

local inZone = 0
local setDeleteAll = false
local isPlacing = false
local hasShownMessage = false

--Creates da hives
--TODO: cache close hives
Citizen.CreateThread(function()
    while true do
        local plyCoords = GetEntityCoords(PlayerPedId())
        if Barrels == nil then Barrels = {} end
        for idx, hive in ipairs(Barrels) do
            if idx % 100 == 0 then
                Wait(0) --Process 100 per frame
            end
            --convert timestamp -> growth percent
            local harvestPercent = getHiveReadyPercent(hive)
            if #(plyCoords - hive.coords) < (50.0 + harvestPercent) and not setDeleteAll then
                local curStage = getStageFromPercent(harvestPercent)
                local isChanged = (ActiveBarrels[hive.id] and ActiveBarrels[hive.id].stage ~= curStage)

                if isChanged then
                    removeBeehive(hive.id)
                end

                if not ActiveBarrels[hive.id] or isChanged then
                    local beeHive = createBarrelstageAtCoords(curStage, hive.coords, hive.heading)
                    ActiveBarrels[hive.id] = {
                        object = beeHive,
                        stage = curStage
                    }
                end
            else
                removeBeehive(hive.id)
            end
        end
        if setDeleteAll then
            Barrels = {}
            setDeleteAll = false
        end
        Wait(2000)
    end
end)

AddEventHandler("pw-inventory:itemUsed", function(item)
    if not isPlacing and item == "vineyardbarrel" then
        if inZone > 0 then
            isPlacing = true
            if not hasShownMessage then
                local message = "\n" .. "Rotate with arrow keys" .. "\n" .. "Press [Enter] to place when hive is visible" .. "\n" .. "Press [Escape] to cancel."
                TriggerEvent('chatMessage','Instructions' .. ' ',3,message,"feed",false);
                hasShownMessage = true
            end
            placeObject("prop_wooden_barrel", function(pPlaced, pCoords, pHeading)
                if pPlaced then
                    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_HAMMERING", 0, true)
                    local finished = exports["pw-taskbar"]:taskBar(10, "Installing beehive", false, true, false, false, nil, 5.0, PlayerPedId())
                    ClearPedTasks(PlayerPedId())
                    if finished == 100 then
                        RPC.execute("pw-vineyard:installBarbel", pCoords, pHeading)
                        TriggerEvent("inventory:removeItem", item, 1)
                    end
                else
                    TriggerEvent("DoLongHudText", "Couldn't place it or you canceled.")
                end
                isPlacing = false
            end)
        else
            TriggerEvent("DoLongHudText", "I should find a better area to install this in.")
        end
    end
end)

AddEventHandler("pw-beekeeping:checkBeehive", function(pContext, pEntity)
    local hiveId = getHiveId(pEntity)
    if not hiveId then return end
    showHiveMenu(hiveId)
end)

AddEventHandler("np-beekeeping:addQueen", function(data)
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
    local finished = exports["pw-taskbar"]:taskBar(10, "Adding Queen bee", false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        RPC.execute("np-beekeeping:addQueen", data.id)
        TriggerEvent("inventory:removeItem", "beequeen", 1)
    end
end)


AddEventHandler("pw-polyzone:enter", function(zone, data)
    if zone == "np-beekeeping:bee_zone" then
        inZone = inZone + 1
        if inZone == 1 then
            local result = RPC.execute("np-beekeeping:getBarrels")
        end
    end
end)

AddEventHandler("pw-polyzone:exit", function(zone, data)
    if zone == "np-beekeeping:bee_zone" then
        inZone = inZone - 1
        stopPlacing()
        if inZone < 0 then inZone = 0 end
        if inZone == 0 then
            setDeleteAll = true
        end
    end
end)

RegisterNetEvent('np-beekeeping:trigger_zone')
AddEventHandler('np-beekeeping:trigger_zone', function (type, pData)
    --Update all hives
    if type == 1 then
        for _, hive in ipairs(Barrels) do
            local keep = false
            for _, newhive in ipairs(pData) do
                if hive.id == newhive.id then
                    keep = true
                    break
                end
            end

            if not keep then
                removeBeehive(hive.id)
            end
        end
        Barrels = pData
    end

    --New hive being added
    if type == 2 then
        Barrels[#Barrels+1] = pData
    end

    --hive being harvested/updated
    if type == 3 then
        for idx, hive in ipairs(Barrels) do
            if hive.id == pData.id then
                Barrels[idx] = pData
                break
            end
        end
    end
  
    --hive being removed
    if type == 4 then
        for idx, hive in ipairs(Barrels) do
            print(hive)
            print(pData.id)
            if hive.id == pData.id then
                table.remove(Barrels, idx)
                removeBeehive(hive.id)
                break
            end
        end
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource ~= GetCurrentResourceName() then return end
    for idx, hive in pairs(ActiveBarrels) do
        DeleteObject(hive.object)
    end
end)

function createBarrelstageAtCoords(pStage, pCoords, pHeading)
    local model = HiveConfig.HiveObjects[pStage].hash
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    local hiveObject = CreateObject(model, pCoords.x, pCoords.y, pCoords.z, 0, 0, 0)
    FreezeEntityPosition(hiveObject, true)
    if not pHeading then pHeading = 0.0 end
    SetEntityHeading(hiveObject, pHeading + 0.00001)
    return hiveObject
end

function removeBeehive(pHiveId)
    if ActiveBarrels[pHiveId] then
        DeleteObject(ActiveBarrels[pHiveId].object)
        ActiveBarrels[pHiveId] = nil
    end
end

function getStageFromPercent(pPercent)
  if pPercent < 50.0 then
    return 1
  elseif pPercent >= 50.0 and pPercent < 100.0 then
    return 2
  else
    return 3
  end
end

function getHiveReadyPercent(pHive)
    local timeDiff = (GetCloudTimeAsInt() - math.max(pHive.last_harvest, pHive.timestamp)) / 60
    local queenFactor = (pHive.has_queen and HiveConfig.QueenFactor or 1)
    local growthFactors = (HiveConfig.GrowthTime / queenFactor)
    return math.min((timeDiff / growthFactors) * 100, 100.0)
end

function getHiveId(pEntity)
    for hiveId, hive in pairs(ActiveBarrels) do
        if hive.object == pEntity then
            return hiveId
        end
    end
end

function getHiveById(pHiveId)
    for _, hive in pairs(Barrels) do
        if hive.id == pHiveId then
            return hive
        end
    end
end

function showHiveMenu(pHiveId)
    local hive = getHiveById(pHiveId)
    --Build context menu
    local harvest = getHiveReadyPercent(hive)
    local context = {}
    context[#context+1] = {
        icon = 'honey-pot',
        title = 'Thu hoạch' .. ': ' .. string.format("%.2f", harvest) .. '%',
        description = (hive.has_queen and "Có ong chúa" or "Không ong chúa"),
    }
    --Only allow changing gender in the first 2~ stages
    if getStageFromPercent(harvest) < 2 and not hive.has_queen then
        context[#context+1] = {
            title = 'Thêm ong chúa',
            key = { id = pHiveId },
            action = 'np-beekeeping:addQueen',
            description = 'Giúp đàn ong vui hơn.',
            disabled = not exports["pw-inventory"]:hasEnoughOfItem("beequeen", 1, false)
        }
    end

    if harvest >= 95 or myjob == "police" or myjob == "judge" then
        context[#context+1] = {
            title = 'Phá hủy tổ',
            key = { id = pHiveId },
            action = 'np-beekeeping:removeHive',
        }
    end




    exports['pw-context']:showContextMenu(context)
end
