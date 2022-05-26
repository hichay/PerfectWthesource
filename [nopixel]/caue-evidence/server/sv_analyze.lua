ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("pw-evidence:analyze", function()
    local src = source

    local inventory = exports["pw-inventory"]:getInventory("analyze_evidence")
    local item = inventory[1]

    if item and (string.find(item.item_id, "evidence") or item.item_id == "dnaswab") then
        local metadata = json.decode(item.information)

        if metadata.identifier == "FADED" or metadata.identifier == "Scratched off data" then
            TriggerClientEvent("DoLongHudText", src, "Không thể phân tích bằng chứng này.", 2)
            return
        end

        local updated = false

        if metadata["Kết quả"] then
            if metadata["Kết quả"] == "Cần phân tích" then
                if math.random(100) <= 70 then
                    metadata["Kết quả"] = metadata.identifier
                else
                    metadata["Kết quả"] = "Không"
                end

                updated = true
                TriggerClientEvent("DoLongHudText", src, "Phân tích xong", 1)
            else
                TriggerClientEvent("DoLongHudText", src, "Bằng chứng này đã được phân tích.", 2)
            end
        elseif metadata["DNA"] then
            if metadata["DNA"] == "Cần phân tích" then
                if math.random(100) <= 80 or item.item_id == "dnaswab" then
                    metadata["DNA"] = metadata.identifier
                else
                    metadata["DNA"] = "Không"
                end

                updated = true
                TriggerClientEvent("DoLongHudText", src, "Phân tích xong", 1)
            else
                TriggerClientEvent("DoLongHudText", src, "Bằng chứng này đã được phân tích.", 2)
            end
        end

        if updated then
            MySQL.update.await([[
                UPDATE user_inventory2
                SET information = ?
                WHERE id = ?
            ]],
            { json.encode(metadata), item.id })
        end
    else
        TriggerClientEvent("DoLongHudText", src, "Không có bằng chứng để phân tích.", 2)
    end
end)


RegisterNetEvent("pw-evidence:dnaSwab", function(pTarget)
	local src = source

    --local cid = exports["pw-base"]:getChar(pTarget, "id")
	local xPlayer = ESX.GetPlayerFromId(pTarget)
	local cid = xPlayer.id
    if not cid then return end

    local dna = MySQL.scalar.await([[
        SELECT dna
        FROM users
        WHERE id = ?
    ]],
    { cid })

    local data = {
        ["identifier"] = dna,
        ["DNA"] = "Không phân tích",
        ["_hideKeys"] = { "identifier" },
    }

    TriggerClientEvent("player:receiveItem", src, "dnaswab", 1, true, data)
    TriggerClientEvent("DoLongHudText", pTarget, "Một mẫu DNA đã được thu thập!")
end)