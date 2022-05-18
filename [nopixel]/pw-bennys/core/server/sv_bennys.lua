ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



local inUseBennys = {}
local repairPrices = {}

AddEventHandler("playerDropped", function()
	local src = source

    for k, v in pairs(inUseBennys) do
        if v == src then
            inUseBennys[k] = nil
        end
    end
end)

RegisterNetEvent("caue-bennys:addToInUse")
AddEventHandler("caue-bennys:addToInUse", function(currentBennys)
    local src = source

    inUseBennys[currentBennys] = src
end)

RegisterNetEvent("caue-bennys:removeFromInUse")
AddEventHandler("caue-bennys:removeFromInUse", function(currentBennys)
    local src = source

    inUseBennys[currentBennys] = nil
end)

RegisterNetEvent("caue-bennys:updateRepairCost")
AddEventHandler("caue-bennys:updateRepairCost", function(price)
    local src = source

    repairPrices[src] = price
end)

RegisterNetEvent("caue-bennys:attemptPurchase")
AddEventHandler("caue-bennys:attemptPurchase", function(cheap, type, upgradeLevel)

    local xPlayer = ESX.GetPlayerFromId(source)
    local src = source

    local price = 0
    if type == "repair" then
        price = repairPrices[src]
    elseif type == "performance" then
        price = vehicleCustomisationPrices.performance.prices[tonumber(upgradeLevel)]
    else
        price = vehicleCustomisationPrices[type].price
    end

    if cheap then
        price = math.ceil(price / 2)
    end

    local cash = xPlayer.getAccount('money').money

    if price > cash then
        TriggerClientEvent("caue-bennys:purchaseFailed", src)
    else
        xPlayer.removeAccountMoney('money', price)
        TriggerClientEvent("caue-bennys:purchaseSuccessful", src)
        --[[ else
            TriggerClientEvent("caue-bennys:purchaseFailed", src)
        end ]]
    end
end)


RegisterNetEvent("caue-bennys:updateVehicle")
AddEventHandler("caue-bennys:updateVehicle", function(prop, plate)
    local src = source
    local result = MySQL.query.await('SELECT * FROM `owned_vehicles` WHERE UPPER(plate) = @plate', {
        ['@plate'] = plate:upper()
    })
    if result[1] then
        MySQL.query('UPDATE `owned_vehicles` SET `vehicle` = @vehicle WHERE UPPER(plate) = @plate', {
            ['@vehicle'] = json.encode(prop),
            ['@plate'] = plate:upper()
        })
    end
end)

RegisterNetEvent("caue-bennys:resetDegredation")
AddEventHandler("caue-bennys:resetDegredation", function(pVid, pPlate)
    local src = source

    TriggerEvent("caue-vehicles:bennysResetDegradation", pVid, pPlate)
end)

--[[

    RPCs

]]

RPC.register("caue-bennys:checkIfUsed", function(src, currentBennys)
    return inUseBennys[currentBennys]
end)