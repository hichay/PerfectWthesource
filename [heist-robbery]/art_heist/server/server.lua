ESX = nil

TriggerEvent(Config.SharedObject, function(obj) ESX = obj end)


Citizen.CreateThread(function()
    Opod.data.BankVault.isLocked = true
    Opod.data.BankVault.doorRotating    = false
    Opod.data.BankVault.curHeading = Opod.data.BankVault.defaultHeading
    for _, v in ipairs(Opod.data.PaintingCache) do
        v.isStolen = false
    end
end)


AddEventHandler('playerDropped', function(reason)
    if Opod.data.Robbers[source] ~= nil then
        Opod.data.Robbers[source] = nil
    end
    local robberCount = 0
    for _, robber in pairs(Opod.data.Robbers) do
        if robber ~= nil then
            robberCount = robberCount + 1
        end
    end
    if robberCount == 0 then
        TriggerEvent('opod-artHeist:RobberyAlert', false)
        TriggerEvent('opod-artHeist:ResetGallery')
    end
end)


RegisterNetEvent('opod-artHeist:StealPainting')
AddEventHandler('opod-artHeist:StealPainting', function(paintingTarget)
    local xPlayer = ESX.GetPlayerFromId(source)
    local TypeOfPainting = ''
    if Config.RandomPainting then
        TypeOfPainting = 'painting_' .. math.random(1, 3)
    else
        --TypeOfPainting = 'painting_' .. (Opod.data.PaintingCache[paintingTarget].tier or 1)
        TypeOfPainting = 'painting_'..paintingTarget
    end

    --xPlayer.addInventoryItem(TypeOfPainting, 1)
    TriggerClientEvent("player:receiveItem",source,TypeOfPainting ,1,true,true,"Bức tranh từ triển lãm")
    Opod.data.PaintingCache[paintingTarget]['isStolen'] = true
    TriggerClientEvent('opod-artHeist:RegisterPainting', -1, paintingTarget, true)
end)

RegisterNetEvent('opod-artHeist:ResetGallery')
AddEventHandler('opod-artHeist:ResetGallery', function()
    Opod.data.BankVault.isLocked    = true
    Opod.data.SystemsHacked         = false
    Opod.data.RobberyOngoing        = false
    Opod.data.WinchSpawned          = false
    Opod.data.WindowCut             = false
    Opod.data.DoorStatus            = false
    for _, v in ipairs(Opod.data.PaintingCache) do
        v.isStolen = false
    end
    TriggerClientEvent('opod-artHeist:ResetGallery', -1)
end)

RegisterNetEvent('opod-artHeist:RegisterDoors')
AddEventHandler('opod-artHeist:RegisterDoors', function(setLocked)
    Opod.data.DoorStatus    = setLocked
    TriggerClientEvent('opod-artHeist:RegisterDoors', -1, setLocked)
end)

RegisterNetEvent('opod-artHeist:HackSecurity')
AddEventHandler('opod-artHeist:HackSecurity', function(setHacked)
    Opod.data.SystemsHacked    = setHacked
    TriggerClientEvent('opod-artHeist:HackSecurity', -1, setHacked)
end)

RegisterNetEvent('opod-artHeist:SetWindowCut')
AddEventHandler('opod-artHeist:SetWindowCut', function(setCut)
    Opod.data.WindowCut    = setCut
    Opod.data.RobberyOngoing    = setCut
    if setCut then
        Opod.data.LastRobbed = os.time()
    end
    TriggerClientEvent('opod-artHeist:SetWindowCut', -1, setCut)
end)

RegisterNetEvent('opod-artHeist:SetDisplayCut')
AddEventHandler('opod-artHeist:SetDisplayCut', function(setCut)
    Opod.data.EggDisplayCut    = setCut
    TriggerClientEvent('opod-artHeist:SetDisplayCut', -1, setCut)
end)

RegisterNetEvent('opod-artHeist:SetVaultDoor')
AddEventHandler('opod-artHeist:SetVaultDoor', function(setLocked)
    Opod.data.BankVault.isLocked    = setLocked
    TriggerClientEvent('opod-artHeist:SetVaultDoor', -1, setLocked)
end)

RegisterNetEvent('opod-artHeist:SetGalleryClosed')
AddEventHandler('opod-artHeist:SetGalleryClosed', function(setClosed)
    if Opod.data.GalleryClosed ~= setClosed then
        Opod.data.GalleryClosed    = setClosed
        Opod.data.DoorStatus       = setClosed
        TriggerClientEvent('opod-artHeist:SetGalleryClosed', -1, setClosed)
    end
end)

RegisterNetEvent('opod-artHeist:StartRapealing')
AddEventHandler('opod-artHeist:StartRapealing', function(targetNetworkId, winchNetworkId, insideMuseum)
    if not insideMuseum then
        Opod.data.Robbers[source] = true
    end
    TriggerClientEvent('opod-artHeist:StartRapealing', -1, targetNetworkId, winchNetworkId, insideMuseum)
end)

RegisterNetEvent('opod-artHeist:SetWinchSync')
AddEventHandler('opod-artHeist:SetWinchSync', function(setSpawned)
    Opod.data.WinchSpawned  = setSpawned
    TriggerClientEvent('opod-artHeist:SetWinchSync', -1, setSpawned)
end)

RegisterNetEvent('opod-artHeist:DetachRope')
AddEventHandler('opod-artHeist:DetachRope', function()
    TriggerClientEvent('opod-artHeist:DetachRope', -1)
end)

