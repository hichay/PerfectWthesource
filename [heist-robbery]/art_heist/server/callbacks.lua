ESX              = nil
Opod = {
    data = {
        PaintingCache   = Config.PaintingLocations,
        BankVault       = Config.BankVault,
        SystemsHacked   = false,
        RobberyOngoing  = false,
        WindowCut       = false,
        GalleryClosed   = false,
        EggDisplayCut   = 'fixed',
        Robbers         = {},
        DoorStatus      = false,
        WinchSpawned    = false,
        LastRobbed      = 0
    }
}

TriggerEvent(Config.SharedObject, function(obj) ESX = obj end)

Citizen.CreateThread(function()
    Opod.data.BankVault.isLocked = true
    Opod.data.BankVault.doorRotating    = false
    Opod.data.BankVault.curHeading = Opod.data.BankVault.defaultHeading
    for _, v in ipairs(Opod.data.PaintingCache) do
        v.isStolen = false
    end
end)

ESX.RegisterServerCallback('opod-artHeist:CheckEntityStatus', function(source, cb)
    while Opod == nil do Citizen.Wait(0) end
    cb(Opod.data)
end)

ESX.RegisterServerCallback('opod-artHeist:CanStartRobbery', function(source, cb)
    while Opod == nil do Citizen.Wait(0) end
    if (GetGameTimer() - Opod.data.LastRobbed < (Config.Cooldown * 1000) and Opod.data.LastRobbed ~= 0) then
        cb('already_robbed')
    end
    local xPlayers = ESX.GetPlayers()
    local copsOnline = 0
    for _, v in ipairs(xPlayers) do
        local xPlayer = ESX.GetPlayerFromId(v)
        if xPlayer.job.name == 'police' then
            copsOnline = copsOnline + 1
        end
    end
    if copsOnline < Config.RequiredPolice then
        cb('not_enough')
    end
    cb('cut')
end)

ESX.RegisterServerCallback('opod-artHeist:HasItem', function(source, cb, item, amount)
    xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem(item).count > 0 then
        if amount then
            xPlayer.removeInventoryItem(item, amount)
        end
        cb(true)
    else
        cb(false)
    end
end)   