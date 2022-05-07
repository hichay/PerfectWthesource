RPC.register("pw-carwash:cleanVehicle", function(src)
    local cid = exports["pw-base"]:getChar(src, "id")
    if not cid then return false end

    local cash = exports["pw-financials"]:getCash(src)
    if cash < 100 then
        TriggerClientEvent("DoLongHudText", src, "You dont have $100 with you", 2)
        return false
    end

    if not exports["pw-financials"]:updateCash(src, "-", 100) then
        return false
    end

    exports["pw-financials"]:updateBalance(11, "+", 100)
    exports["pw-financials"]:transactionLog(11, 11, 100, "", cid, 7)

    return true
end)