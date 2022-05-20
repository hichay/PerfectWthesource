RegisterNetEvent("pw-vehicleSync:updateSyncState")
AddEventHandler("pw-vehicleSync:updateSyncState", function(pNetId, pSyncState)
    TriggerClientEvent("pw-vehicleSync:updateSyncState", -1, pNetId, pSyncState)
end)