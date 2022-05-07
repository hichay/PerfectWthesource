--[[

    Variables

]]

pedsFlags = {}
defaultpedsFlags = {
    isDead = false,
    isCuffed = false,
    isRobbing = false,
    isEscorting = false,
    isEscorted = false,
    isBlindfolded = false,
    isInTrunk = false,
    isInBeatMode = false,
    isInsideVanillaUnicorn = false,
    isNPC = false,
    isJobEmployer = false,
    isSittingOnChair = false,
    isPoledancing = false,
    isPawnBuyer = false,
    isRecycleExchange = false,
    isVehicleSpawner = false,
    isBoatRenter = false,
    isMethDude = false,
    isBankAccountManager = false,
    isShopKeeper = false,
    isWeaponShopKeeper = false,
    isToolShopKeeper = false,
    isSportShopKeeper = false,
    isCasinoChipSeller = false,
}

--[[

    Functions

]]

function GetPedFlags(netID)
    local flags = pedsFlags[netID]
    local field = 0

    for flag, enabled in pairs(flags) do
        local mask = Flags["PedFlags"][flag]

        if mask ~= nil then
            field = enabled and field | mask or field &~ mask
        end
    end

    return field
end


--[[

    Events

]]

RegisterNetEvent("pw:flags:ped:stateChanged")
AddEventHandler("pw:flags:ped:stateChanged", function(netId, pFlag, pState)
    local src = source

    if pedsFlags[netID] then
        pedsFlags[netID][pFlag] = pState
    end
end)

RegisterNetEvent("pw-base:sessionStarted")
AddEventHandler("pw-base:sessionStarted", function()
    local src = source

    pedsFlags[src] = defaultpedsFlags
end)

RegisterNetEvent("SpawnEventsServer")
AddEventHandler("SpawnEventsServer", function()
    local src = source

    Citizen.Wait(5000)

    pedsFlags[src] = defaultpedsFlags
    TriggerClientEvent("pw:flags:set", src, src, "player", "PedFlags", GetPedFlags(src))
end)

RegisterNetEvent("pw-flags:ped:getFlags")
AddEventHandler("pw-flags:ped:getFlags", function()
    local src = source

    if pedsFlags[src] then
        TriggerClientEvent("pw:flags:set", src, src, "player", "PedFlags", GetPedFlags(src))
    end
end)