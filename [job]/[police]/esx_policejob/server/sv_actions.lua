RegisterNetEvent("police:remmaskGranted")
AddEventHandler("police:remmaskGranted", function(pTarget)
    TriggerClientEvent("police:remmaskAccepted", pTarget)
end)

RegisterNetEvent("police:targetCheckInventory")
AddEventHandler("police:targetCheckInventory", function(pTarget, pFrisk)
    local src = source

    --local cid = exports["pw-base"]:getChar(pTarget, "id")
    local xPlayer = ESX.GetPlayerFromId(pTarget)
    if not xPlayer then return end

    if pFrisk then
        local inv = exports["pw-inventory"]:getInventory("" .. xPlayer.getIdentifier())

        local hasWeapons = false

        for i, v in ipairs(inv) do
            if tonumber(v.item_id) then
                hasWeapons = true
                break
            end
        end

        if hasWeapons then
            TriggerClientEvent("DoLongHudText", src, "Tìm thấy vũ khí")
        else
            TriggerClientEvent("DoLongHudText", src, "Không tìm thấy vũ khí nào")
        end
    else
        TriggerClientEvent("DoLongHudText", pTarget, "Tìm kiếm trong người")
        TriggerClientEvent("server-inventory-open", src, "1", ("" .. xPlayer.getIdentifier()))
    end
end)

RegisterNetEvent("police:rob")
AddEventHandler("police:rob", function(pTarget)
    local src = source

    local cash = exports["pw-financials"]:getCash(pTarget)

    if cash > 0 then
        if exports["pw-financials"]:updateCash(pTarget, "-", cash) then
            exports["pw-financials"]:updateCash(src, "+", cash)
        end
    end
end)

RegisterNetEvent("police:gsr")
AddEventHandler("police:gsr", function(pTarget)
	local src = source

    local shotRecently = RPC.execute(pTarget, "police:gsr")

    if shotRecently then
        TriggerClientEvent("DoLongHudText", src, "Encontramos residuo de polvora")
    else
        TriggerClientEvent("DoLongHudText", src, "Não encontramos nenhum residuo de polvora")
    end
end)
