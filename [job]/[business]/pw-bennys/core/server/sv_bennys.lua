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

RegisterNetEvent("pw-bennys:addToInUse")
AddEventHandler("pw-bennys:addToInUse", function(currentBennys)
    local src = source

    inUseBennys[currentBennys] = src
end)

RegisterNetEvent("pw-bennys:removeFromInUse")
AddEventHandler("pw-bennys:removeFromInUse", function(currentBennys)
    local src = source

    inUseBennys[currentBennys] = nil
end)

RegisterNetEvent("pw-bennys:updateRepairCost")
AddEventHandler("pw-bennys:updateRepairCost", function(price)
    local src = source

    repairPrices[src] = price
end)

RegisterNetEvent("pw-bennys:attemptPurchase")
AddEventHandler("pw-bennys:attemptPurchase", function(cheap, type, upgradeLevel)

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
        TriggerClientEvent("pw-bennys:purchaseFailed", src)
    else
        xPlayer.removeAccountMoney('money', price)
        TriggerClientEvent("pw-bennys:purchaseSuccessful", src)
        --[[ else
            TriggerClientEvent("pw-bennys:purchaseFailed", src)
        end ]]
    end
end)



RegisterNetEvent("pw-bennys:updateVehicle")
AddEventHandler("pw-bennys:updateVehicle", function(prop, plate)
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

--[[

    RPCs

]]

RPC.register("pw-bennys:checkIfUsed", function(src, currentBennys)
    return inUseBennys[currentBennys]
end)