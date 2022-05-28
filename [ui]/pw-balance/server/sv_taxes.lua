
local Taxes = {}

--[[

    Functions

]]

function getTax(tax)
    if not tax or not Taxes[tax] then return 0 end

    return Taxes[tax]
end

function priceWithTax(price, tax)
    local percent = getTax(tax)
    local tax = math.ceil((price / 100) * percent)
    local total = math.ceil(price + tax)

    local data = {
        ["percent"] = percent,
        ["tax"] = tax,
        ["total"] = total,
		["text"] = total,
    }

    return data
end

function addTax(tax, amount)
    if not tax or not amount then return end

    local affectedRows = MySQL.update.await([[
        UPDATE financials_taxes
        SET total = total + ?
        WHERE tax = ?
    ]],
    { amount, tax })

    -- if affectedRows and affectedRows ~= 0 then
        -- updateBalance(1, "+", amount)
    -- end
end

function getTaxFromValue(tax, amount)
	if not tax or not amount then return end
	local _tax = priceWithTax(amount, tax)
	
	amount = _tax["tax"]
	
	return amount
	
end

function addTaxFromValue(tax, amount)
    if not tax or not amount then return end

    local _tax = priceWithTax(amount, tax)

    amount = _tax["tax"]

    local affectedRows = MySQL.update.await([[
        UPDATE financials_taxes
        SET total = total + ?
        WHERE tax = ?
    ]],
    { amount, tax })

    -- if affectedRows and affectedRows ~= 0 then
        -- updateBalance(1, "+", amount)
    -- end
end

--[[

    Exports

]]

exports("getTax", getTax)
exports("priceWithTax", priceWithTax)
exports("addTax", addTax)
exports("addTaxFromValue", addTaxFromValue)
exports("getTaxFromValue", getTaxFromValue)
--[[

    RPCs

]]

RPC.register("pw-balance:getTax", function(src, tax)
    return getTax(tax)
end)

RPC.register("pw-balance:priceWithTax", function(src, price, tax)
    return priceWithTax(price, tax)
end)

RPC.register("pw-balance:getTaxFromValue", function(src, price, tax)
    return getTaxFromValue(price, tax)
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    local result = MySQL.query.await([[
        SELECT tax, percent
        FROM financials_taxes
    ]])

    for i, v in ipairs(result) do
        Taxes[v.tax] = v.percent
    end
end)