RegisterNetEvent("LoadPlayerDamaged")
AddEventHandler("LoadPlayerDamaged", function()
    local src = source
    --local cid = exports["pw-base"]:getChar(src, "id")
	local xPlayer = ESX.GetPlayerFromId(src)
	local cid = xPlayer.id
    if not cid then return end

    local bones = MySQL.scalar.await([[
        SELECT bones
        FROM users
        WHERE id = ?
    ]],
    { cid })

    if bones then
        TriggerClientEvent("bones:client:updatefromDB", src, json.decode(bones))
    end
end)

RegisterNetEvent("bones:server:updateServer")
AddEventHandler("bones:server:updateServer", function(bones)
    local src = source

    --local cid = exports["pw-base"]:getChar(src, "id")
	local xPlayer = ESX.GetPlayerFromId(src)
	local cid = xPlayer.id
    if not cid then return end

    MySQL.update.await([[
        UPDATE users
        SET bones = ?
        WHERE id = ?
    ]],
    { json.encode(bones), cid })
end)

RegisterNetEvent("Evidence:GetWounds")
AddEventHandler("Evidence:GetWounds", function(target)
    local src = source
    TriggerClientEvent("Evidence:GiveWounds", target, src)
end)

RegisterNetEvent("Evidence:GiveWoundsFinish")
AddEventHandler("Evidence:GiveWoundsFinish", function(damage, target, bones)
    local src = source
    TriggerClientEvent("Evidence:CurrentDamageListTarget", target, damage, bones, src)
end)

RegisterNetEvent("updateHealLocation")
AddEventHandler("updateHealLocation", function(bonestarget, targetid)
    TriggerClientEvent("updateHealLocation:client", targetid, bonestarget)
end)


RegisterNetEvent("pw-evidence:hospitalHeal")
AddEventHandler("pw-evidence:hospitalHeal", function()
    local src = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local cid = xPlayer.id
    --local cid = exports["pw-base"]:getChar(src, "id")
    if not cid then return end

    local accountId = exports["pw-base"]:getChar(src, "bankid")
    local bank = exports["pw-financials"]:getBalance(accountId)

    local groupBank = exports["pw-groups"]:groupBank("ems")

    local comment = "Despesas com assistência médica"
    exports["pw-financials"]:transaction(accountId, groupBank, 200, comment, cid, 1)
end)
