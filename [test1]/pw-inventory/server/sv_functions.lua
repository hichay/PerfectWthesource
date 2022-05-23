
itemList = {}



function getItem(pClass, pInfo)
    local infoReturn = nil
	
    if itemList[pClass] then
        if pInfo then
            if itemList[pClass][pInfo] then
                infoReturn = itemList[pClass][pInfo]
            end
        else
            infoReturn = itemList[pClass]
        end
    end
    return infoReturn
end

function getInventory(pInventory)
    local inventory = MySQL.query.await([[
        SELECT count(item_id) as amount, id, name, item_id, information, slot, dropped, creationDate
        FROM user_inventory2
        WHERE name = ?
        GROUP BY slot
    ]],
    { pInventory })

    return inventory
end

function K9Sniff(pId)
    local inventory = getInventory("" .. pId)

    for i, v in ipairs(inventory) do
        if itemList[v.item_id].contraband then
            return true
        end
    end

    return false
end

function K9SniffVehicle(pId)
    local inventoryGlovebox = getInventory("Glovebox-" .. pId)
    local inventoryTrunk = getInventory("Trunk-" .. pId)

    for i, v in ipairs(inventoryGlovebox) do
        if itemList[v.item_id].contraband then
            return true
        end
    end

    for i, v in ipairs(inventoryTrunk) do
        if itemList[v.item_id].contraband then
            return true
        end
    end

    return false
end

function getQuantity(src, itemid, checkQuality, metaInformation)
    --local cid = exports["caue-base"]:getChar(src, "id")
	local xPlayer = ESX.GetPlayerFromId(src)
    local inventory = getInventory("" .. xPlayer.getIdentifier())

    local amount = 0
    for i,v in pairs(inventory) do
        local qCheck = not checkQuality or v.quality > 0
        if v.item_id == itemid and qCheck then
            if metaInformation then
                local totalMetaKeys = 0
                local metaFoundCount = 0
                local itemMeta = json.decode(v.information)
                for metaKey, metaValue in pairs(metaInformation) do
                    totalMetaKeys = totalMetaKeys + 1
                    if itemMeta[metaKey] and itemMeta[metaKey] == metaValue then
                        metaFoundCount = metaFoundCount + 1
                    end
                end
                if totalMetaKeys <= metaFoundCount then
                    amount = amount + v.amount
                end
            else
                amount = amount + v.amount
            end
        end
    end
    return amount
end

function hasEnoughOfItem(src, itemid, amount, checkQuality, metaInformation)
    if itemid == nil or itemid == 0 or amount == nil or amount == 0 then
        return false
    end
    amount = tonumber(amount)
    local slot = 0
    local found = false

    if getQuantity(src, itemid, checkQuality, metaInformation) >= amount then
        return true
    end

    return false
end

--[[

    Exports

]]

exports("getItem", getItem)
exports("getInventory", getInventory)
exports("K9Sniff", K9Sniff)
exports("K9SniffVehicle", K9SniffVehicle)
exports("getQuantity", getQuantity)
exports("hasEnoughOfItem", hasEnoughOfItem)

--[[

    Events

]]

AddEventHandler("pw-inventory:luaItemList", function(pItems)
    itemList = pItems
end)