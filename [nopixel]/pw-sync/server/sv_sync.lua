local readyPlayers = {}

RegisterNetEvent("np:sync:player:ready")
AddEventHandler("np:sync:player:ready", function()
    local src = source

    readyPlayers[src] = true
end)

RegisterNetEvent("sync:request")
AddEventHandler("sync:request", function(native, playerid, entityid, args)
    local src = source

    if readyPlayers[playerid] then
        TriggerClientEvent("sync:execute", playerid, native, entityid, args)
    end
end)

RegisterNetEvent("np-sync:executeSyncNative")
AddEventHandler("np-sync:executeSyncNative", function(native, netEntity, options, args)
    local src = source

    TriggerClientEvent("np-sync:clientExecuteSyncNative", -1, native, netEntity, options, args)
end)