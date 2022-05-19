RegisterNetEvent("pw-vehicleSync:updateSirenState")
AddEventHandler("pw-vehicleSync:updateSirenState", function(pNetId, pSirenState, pSirenPreset)
    TriggerClientEvent("pw-vehicleSync:updateSirenState", -1, pNetId, pSirenState, pSirenPreset)
end)