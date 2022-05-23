ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


Config = {
    SellNpcItems = {
        ["joint"] = {
            minprice = 20,
            maxprice = 40,
            minamount = 1,
            maxamount = 3
        },
        ["1gcocaine"] = {
            minprice = 40,
            maxprice = 70,
            minamount = 1,
            maxamount = 3
        },
        ["1gmeta"] = {
            minprice = 25,
            maxprice = 55,
            minamount = 1,
            maxamount = 3
        },
        ["lean"] = {
            minprice = 22,
            maxprice = 48,
            minamount = 1,
            maxamount = 3
        },
    }
}

--[[

    Events

]]

RegisterServerEvent("pw-drugs:offer")
AddEventHandler("pw-drugs:offer", function(ped)
	local src = source

    --local cid = exports["pw-base"]:getChar(src, "id")
	local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local itemId = false

    local inventory = exports["pw-inventory"]:getInventory("" .. xPlayer.getIdentifier())
    for i, v in ipairs(inventory) do
        if Config.SellNpcItems[v.item_id] then
            itemId = v.item_id
            break
        end
    end

    if itemId then
        local MinAmount = Config.SellNpcItems[itemId].minamount
		local MaxAmount = Config.SellNpcItems[itemId].maxamount
		local PriceMin = Config.SellNpcItems[itemId].minprice
		local PriceMax = Config.SellNpcItems[itemId].maxprice
		local Amount = math.random(MinAmount, MaxAmount)
		local Price = math.random(PriceMin, PriceMax) * Amount

        local Label = exports["pw-inventory"]:getItem(itemId, "displayname")
		print(Label)
        TriggerClientEvent("pw-drugs:c_startoffers", src, ped, itemId, Price, Label, Amount)
    else
        TriggerClientEvent("pw-drugs:canceloffers", src, ped)
		TriggerClientEvent("DoLongHudText", src, "Bạn không có thuốc để bán", 2)
    end
end)

RegisterServerEvent("pw-drugs:selling")
AddEventHandler("pw-drugs:selling", function(item, price, amount, ped)
	local src = source

    --local cid = exports["pw-base"]:getChar(src, "id")
	local xPlayer = ESX.GetPlayerFromId(src)
	
    if not xPlayer then return end

    local hasAmount = false

    local inventory = exports["pw-inventory"]:getInventory("" .. xPlayer.getIdentifier())
    for i, v in ipairs(inventory) do
        if item == v.item_id then
            if amount <= v.amount then
                hasAmount = true
            end

            break
        end
    end

	if hasAmount then
        local Label = exports["pw-inventory"]:getItem(item, "displayname")

        TriggerClientEvent("inventory:removeItem", src, item, amount)
		--exports["pw-financials"]:updateCash(src, "+", price)
		xPlayer.addMoney(price)
		TriggerClientEvent("pw-drugs:client:sell", src, ped)
		TriggerClientEvent("DoLongHudText", src, "Bạn đã bán "  .. amount .." " .. Label.. " và nhận được $ ".. price)
        TriggerClientEvent("evidence:drugs", src, Label)
	else
		TriggerClientEvent("pw-drugs:canceloffers", src, ped)
		TriggerClientEvent("DoLongHudText", src, "Bạn không có đủ hàng")
	end
end)

RegisterServerEvent("pw-drugs:robgive")
AddEventHandler("pw-drugs:robgive", function(item, amount)
	local src = source

    --local cid = exports["pw-base"]:getChar(src, "id")
	local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local hasAmount = false

    local inventory = exports["pw-inventory"]:getInventory("" .. xPlayer.getIdentifier())
    for i, v in ipairs(inventory) do
        if item == v.item_id then
            if amount <= v.amount then
                hasAmount = true
            end

            break
        end
    end

	if hasAmount then
        TriggerClientEvent("inventory:removeItem", src, item, amount)
	else
		TriggerClientEvent("pw-drugs:canceloffers", src, ped)
		TriggerClientEvent("DoLongHudText", src, "Bạn không có hàng để đưa")
	end
end)