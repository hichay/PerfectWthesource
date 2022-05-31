ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local EmergencyPlayers = {}

local CallSigns = {}
function GetCallsign(id)
    local result = MySQL.query.await([[SELECT callsign FROM users WHERE id = ?]], { id })
    if result[1] ~= nil and result[1].callsign ~= nil then
         return result[1].callsign
    else
        return 0
    end
end

RegisterNetEvent("e-blips:updateBlips", function(pJob, pSelfUpdate)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(source)
    if pJob == 'police' or pJob == 'ambulance' then
        local callSign = GetCallsign(xPlayer.id)

        for k, v in pairs(EmergencyPlayers) do
            TriggerClientEvent("e-blips:deleteHandlers", k)
        end

        EmergencyPlayers[src] = {
            netId = src,
            job = pJob,
            callsign = callSign or "CALLSIGN NOT DEFINED"
        }

        Citizen.Wait(1000)

        for k, v in pairs(EmergencyPlayers) do
            TriggerClientEvent("e-blips:setHandlers", k, EmergencyPlayers)
        end
    elseif EmergencyPlayers[src] then
        EmergencyPlayers[src] = nil
        TriggerClientEvent("e-blips:deleteHandlers", src)

        for k, v in pairs(EmergencyPlayers) do
            TriggerClientEvent("e-blips:removeHandler", k, src)
        end
    end
end)

AddEventHandler("playerDropped", function()
	local src = source

    if EmergencyPlayers[src] then
        EmergencyPlayers[src] = nil

        for k, v in pairs(EmergencyPlayers) do
            TriggerClientEvent("e-blips:removeHandler", k, src)
        end
    end
end)