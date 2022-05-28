local DroppedEvidences = {}

function GetRandomString(lenght)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local randomString, stringLenght = '', lenght or 10
    local charTable = {}

    for char in chars:gmatch"." do
        table.insert(charTable, char)
    end

    for i = 1, stringLenght do
        randomString = randomString .. charTable[math.random(1, #charTable)]
    end
    return randomString
end

local function generateDNA()
    for i = 1, 10 do
        local dna = GetRandomString(10)

        local exist = MySQL.scalar.await([[
            SELECT dna
            FROM users
            WHERE dna = ?
        ]],
        { dna })

        if not exist then
            return dna
        end

        Citizen.Wait(500)
    end
end

RPC.register("pw-evidence:getDNA", function(src)
	local xPlayer = ESX.GetPlayerFromId(source)
	local cid = xPlayer.id
    if not cid then
        return "ERROR"
    end

    local dna = MySQL.scalar.await([[
        SELECT dna
        FROM users
        WHERE id = ?
    ]],
    { cid })

    if not dna then
        dna = generateDNA()

        MySQL.update.await([[
            UPDATE users
            SET dna = ?
            WHERE id = ?
        ]],
        { dna, cid })
    end

    return dna
end)

RPC.register("pw-evidence:fetchEvidence", function(src)
    return true, DroppedEvidences
end)

RPC.register("pw-evidence:addEvidence", function(src, pDropped)
    for k, v in pairs(pDropped) do
        DroppedEvidences[k] = v
    end

    return true
end)

RPC.register("pw-evidence:clearEvidence", function(src, pCoords, pEvidence)
    for i, v in ipairs(pEvidence) do
        if DroppedEvidences[v] then
            DroppedEvidences[v] = nil
        end
    end

    local players = GetPlayers()
    for i, v in ipairs(players) do
        local coords = GetEntityCoords(GetPlayerPed(v))

        if #(pCoords - coords) < 50.0 then
            TriggerClientEvent("pw-evidence:clearCache", v)
        end
    end

    return true
end)