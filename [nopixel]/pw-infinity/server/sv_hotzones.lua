local HotZones = {}

RegisterNetEvent("pw-infinity:hotzones:requestList")
AddEventHandler("pw-infinity:hotzones:requestList", function()
    local src = source

    TriggerClientEvent("pw-infinity:hotzones:updateList", src, HotZones)
end)

RegisterNetEvent("pw-infinity:hotzones:enteredZone")
AddEventHandler("pw-infinity:hotzones:enteredZone", function(zoneId)
    local src = source

end)

RegisterNetEvent("pw-infinity:hotzones:exitZone")
AddEventHandler("pw-infinity:hotzones:exitZone", function(zoneId)
    local src = source

end)