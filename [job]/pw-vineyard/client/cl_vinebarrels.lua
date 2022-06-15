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
            --TriggerEvent('table',Barrels)
            --convert timestamp -> growth percent
            --local harvestPercent = getHiveReadyPercent(hive)
            if #(plyCoords - hive.coords) < 50.0 and not setDeleteAll then
                --local curStage = getStageFromPercent(harvestPercent)
                --local isChanged = (ActiveBarrels[hive.id] and ActiveBarrels[hive.id].stage ~= curStage)

                --[[ if isChanged then
                    removeBeehive(hive.id)
                end ]]

                if not ActiveBarrels[hive.id] then
                    print('active')
                    local beeHive = createBarrelstageAtCoords("prop_wooden_barrel", hive.coords, hive.heading)
                    ActiveBarrels[hive.id] = {
                        object = beeHive
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

function isGrapeBarrel(p2)
    --TriggerEvent('table',p2)
    --return p2 and p2.meta and p2.meta.data and p2.meta.data.metadata and p2.meta.data.metadata.type == "vinewood_grape_barrel"
    local hiveId = getHiveId(p2)
    local hive = getHiveById(hiveId)
    return hive
end

AddEventHandler("pw-inventory:itemUsed", function(item)
    if not isPlacing and item == "vineyardbarrel" then
        --if inZone > 0 then
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
        --else
            --TriggerEvent("DoLongHudText", "I should find a better area to install this in.")
        --end
    end
end)

AddEventHandler("pw-vineyard:checkBeehive", function(pContext, pEntity)
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
    if zone == "np-vineyard:vineyard_zone" then
        inZone = inZone + 1
        print('inzoe')
        if inZone == 1 then
            print('sure')
            local result = RPC.execute("np-beekeeping:getBarrels")
        end
    end
end)

AddEventHandler("pw-polyzone:exit", function(zone, data)
    if zone == "np-vineyard:vineyard_zone" then
        inZone = inZone - 1
        stopPlacing()
        if inZone < 0 then inZone = 0 end
        if inZone == 0 then
            setDeleteAll = true
        end
    end
end)

RegisterNetEvent('pw-vineyard:trigger_zone')
AddEventHandler('pw-vineyard:trigger_zone', function (type, pData)
    --Update all hive
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

function createBarrelstageAtCoords(pObject, pCoords, pHeading)
    local model = GetHashKey(pObject)
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

--[[ function getHiveReadyPercent(pHive)
    local timeDiff = (GetCloudTimeAsInt() - math.max(pHive.last_harvest, pHive.timestamp)) / 60
    local queenFactor = (pHive.has_queen and HiveConfig.QueenFactor or 1)
    local growthFactors = (HiveConfig.GrowthTime / queenFactor)
    return math.min((timeDiff / growthFactors) * 100, 100.0)
end ]]

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


--[[ Citizen.CreateThread(function()
    exports["pw-interact"]:AddPeekEntryByModel({`prop_wooden_barrel` }, {
        {
            id = "peek_prop_vineyard_barrel",
            event = "pw-vineyard:checkBeehive",
            icon = "shopping-basket",
            label = "Pick Up",
          },
    }, {
        distance = { radius = 2.0 },
        --[[ isEnabled = function(p1, p2, p3)
            return isGrapeBarrel(p2)
        end,
        })

end) ]]
--[[ RegisterUICallback("np-vineyard:changeBarrelName", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = "done" } })
    exports["np-ui"]:closeApplication("textbox")
    RPC.execute("np-vineyard:changeBarrelName", data.key, data.values.name)
  end) ]]

AddEventHandler("np-vineyard:changeBarrelName", function(id, name)
    print(id,name)
    local newData = { name = name }
    RPC.execute("pw-vineyard:changeBarrelName", id, name)   
end)




RegisterUICallback("np-vineyard:addGrapesToBarrel", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = "done" } })
    exports["np-ui"]:closeApplication("textbox")
    local newData = data.key.newData
    local objectId = data.key.objectId
    local items = exports["np-inventory"]:getItemsOfType("vineyardgrapes", false, true)
    if #items == 0 then return end
    for _, item in pairs(items) do
      local info = json.decode(item.information)
      if (info.status ~= "dead") and (info.class == data.values.class) and (item.amount >= tonumber(data.values.amount)) and (info.type == data.values.type) then
        if not newData.grapes[info.class] then
          newData.grapes[info.class] = {}
        end
        if not newData.grapes[info.class][info.type] then
          newData.grapes[info.class][info.type] = 0
        end
        newData.grapes[info.class][info.type] = newData.grapes[info.class][info.type] + tonumber(data.values.amount)
        TriggerEvent("inventory:removeItemBySlot", "vineyardgrapes", tonumber(data.values.amount), item.slot)
        Wait(250)
      end
    end
    RPC.execute("np-vineyard:changeBarrelData", objectId, newData)
  end)

AddEventHandler("np-vineyard:barrelAction", function(p1, p2, p3)
    if not isGrapeBarrel(p2) then return end
    local data = isGrapeBarrel(p2).meta
    --TriggerEvent('table',data)
    local objectId = data.id
    if p1.action == "view_details" then
      local pcts = {}
      local total = 0
      local detailsString =
        "\nName: " .. data.name ..
        "\nAge: " .. (data.sealed and getTimestamp(data) or "Not Sealed") ..
        "\nGrapes: 0"
      if data.grapes then
        for cls, types in pairs(data.grapes) do
          for type, cnt in pairs(types) do
            total = total + cnt
          end
        end
        detailsString = detailsString:sub(1, -2)
        detailsString = detailsString .. "~" .. tostring(math.floor(((total + 1) / 100)) * 100)
        for cls, types in pairs(data.grapes) do
          detailsString = detailsString .. " \n " .. ((cls == "red") and "Red" or "White") .. ":"
          for type, cnt in pairs(types) do
            detailsString = detailsString .. "\n - " .. type .. ": " .. math.floor(cnt / total * 100) .. "%"
          end
          -- detailsString = detailsString:sub(1, -4)
          -- detailsString = detailsString .. ")"
        end
      end
      TriggerEvent("chatMessage", "----- Hero Wine -----", 2, detailsString, "feed", false, { i18n = {
        "Name",
        "Age",
        "Red",
        "White",
        "sweet",
        "sour",
        "extra-sweet",
      }})
      -- TriggerEvent("DoLongHudText", detailsString, 1, 12000, { i18n = {
      --   "Name",
      --   "Age",
      --   "Red",
      --   "White",
      --   "sweet",
      --   "sour",
      --   "extra-sweet",
      -- }})
      return
    end
    if p1.action == "change_name" then
      --[[ exports["np-ui"]:openApplication("textbox", {
        callbackUrl = "np-vineyard:changeBarrelName",
        key = objectId,
        items = {
          { label = "Name", name = "name" },
        },
        show = true,
      })
      return ]]

    local input = exports["pw-input"]:showInput({
        {
            icon = "tshirt",
            label = "Tên",
            name = "name",
        },
    })

    if input["name"] then
        local name = input["name"]

        if not name or name == "" then
            TriggerEvent("DoLongHudText", "Phải đặt tên", 2)
            return
        end

        TriggerEvent('np-vineyard:changeBarrelName', objectId, name)
    end

    end
    if p1.action == "seal" then
        TriggerEvent('table',data.grapes)
      if not data.grapes then
        TriggerEvent("DoLongHudText", "You need at least 1200 grapes to seal!", 2)
        return
      end
      local total = 0
      for cls, types in pairs(data.grapes) do
        for type, cnt in pairs(types) do
          total = total + cnt
        end
      end
      if total < 12 then
        TriggerEvent("DoLongHudText", "You need at least 1200 grapes to seal!", 2)
        return
      end
      local newData = { sealed = true, created_at = getCurrentTime() }
      RPC.execute("np-vineyard:changeBarrelData", objectId, newData)
      return
    end
    if p1.action == "add_grapes" then
      local newData = { grapes = (data.grapes or {}) }
      local items = exports["pw-inventory"]:getItemsOfType("vineyardgrapes", false, true)
      if #items == 0 then return end
      exports["np-ui"]:openApplication("textbox", {
        callbackUrl = "np-vineyard:addGrapesToBarrel",
        key = { objectId = objectId, newData = newData },
        items = {
          { label = "Amount", name = "amount" },
          {
            label = "Class",
            name = "class", 
            _type = "select",
            options = {
              { name = "Green", id = "green" },
              { name = "Red", id = "red" },
            },
          },
          {
            label = "Type",
            name = "type", 
            _type = "select",
            options = {
              { name = "Sweet", id = "sweet" },
              { name = "Extra Sweet", id = "extra-sweet" },
              { name = "Dry", id = "dry" },
            },
          },
        },
        show = true,
      })
      return
    end
    if p1.action == "pour_bottles" then
      local hasEnough = exports["np-inventory"]:hasEnoughOfItem("vineyardwinebottleempty", 1, false, true)
      if not hasEnough then
        TriggerEvent("DoLongHudText", "You need empty wine bottles!", 2)
        return
      end
      TriggerEvent("doAnim","cokecut")
      local finished = exports["np-taskbar"]:taskBar(10000, "Bottling Wine")
      ClearPedTasks(PlayerPedId())
      if finished ~= 100 then return end
      exports['np-objects']:DeleteObject(objectId)
      TriggerEvent("inventory:removeItem", "vineyardwinebottleempty", 1)
      Wait(500)
      for i = 1, 6 do
        local mData = {
          aged = getTimestamp(data),
          id = math.random(1000000000, 9999999999),
          _hideKeys = { "id" },
        }
        TriggerEvent("player:receiveItem", "vineyardwinebottle", 1, false, mData, mData)
        Wait(250)
      end
      return
    end
  end)

Citizen.CreateThread(function()
    exports["pw-interact"]:AddPeekEntryByModel({ `prop_wooden_barrel` }, {
      {
        id = "peek_prop_vineyard_barrel",
        event = "np-vineyard:pickupBarrel",
        icon = "shopping-basket",
        label = "Pick Up",
      },
      {
        id = "peek_prop_vineyard_barrel_details",
        event = "np-vineyard:barrelAction",
        icon = "info-circle",
        label = "View Label",
        parameters = { action = "view_details" },
      },
      {
        id = "peek_prop_vineyard_barrel_name",
        event = "np-vineyard:barrelAction",
        icon = "pencil-alt",
        label = "Change Name",
        parameters = { action = "change_name" },
      },
    }, {
      distance = { radius = 2.0 },
      isEnabled = function(p1, p2, p3)
        return isGrapeBarrel(p1)
      end,
    })
    
    exports["pw-interact"]:AddPeekEntryByModel({ `prop_wooden_barrel` }, {
      {
        id = "peek_prop_vineyard_barrel_add",
        event = "np-vineyard:barrelAction",
        icon = "plus",
        label = "Add Grapes",
        parameters = { action = "add_grapes" },
      },
      {
        id = "peek_prop_vineyard_barrel_seal",
        event = "np-vineyard:barrelAction",
        icon = "cog",
        label = "Seal (Permanently)",
        parameters = { action = "seal" },
      },
    }, {
      distance = { radius = 2.0 },
      isEnabled = function(p1, p2, p3)
        --local data = p2.meta.data.metadata
        return isGrapeBarrel(p1) and not isGrapeBarrel(p1).meta.sealed
      end,
    })
  
    exports["pw-interact"]:AddPeekEntryByModel({ `prop_wooden_barrel` }, {
      {
        id = "peek_prop_vineyard_barrel_pour",
        event = "np-vineyard:barrelAction",
        icon = "plus-circle",
        label = "Pour Bottles",
        parameters = { action = "pour_bottles" },
      },
    }, {
      distance = { radius = 2.0 },
      isEnabled = function(p1, p2, p3)
        --local data = p2.meta.data.metadata
        return isGrapeBarrel(p1) and isGrapeBarrel(p1).meta.sealed
      end,
    })
  end)

  HiveZones = {
    -- x, y, z, radius
    {vector3(-1767.42, 2085.61, 190.0), 323.59},
    {vector3(-2647.73, 346.97, 190.0), 274.71},
    {vector3(-2805.30, 928.79, 190.0), 210.28},
    {vector3(-2384.85, 783.33, 190.0), 213.92},
    {vector3(-2206.06, 1454.55, 190.0), 347.85},
    {vector3(-1150.00, 1825.76, 190.0), 251.40},
    {vector3(-1021.21, 1392.42, 190.0), 188.70},
    {vector3(-1366.67, 1148.48, 190.0), 213.26},
    {vector3(440.91, 640.15, 190.0), 119.79},
    {vector3(1663.64, -403.03, 190.0), 280.02},
    {vector3(2118.18, -250.00, 190.0), 179.33},
    {vector3(2250.00, -1109.09, 190.0), 246.32},
    {vector3(2206.06, -1727.27, 300.0), 356.77},
    {vector3(1948.48, -2254.55, 190.0), 215.32},
}

Citizen.CreateThread(function()
    for id, zone in ipairs(HiveZones) do
        exports["pw-polyzone"]:AddCircleZone("np-vineyard:vineyard_zone", zone[1], zone[2],{
            zoneEvents={"pw-vineyard:trigger_zone"},
            data = {
                id = id,
            },
        })
    end
end)