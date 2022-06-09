ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

ESX.RegisterServerCallback("lr_tienlen:callback:getTablesStatus", function(source, cb)
    cb(Decks)
end)

--[[ ESX.RegisterServerCallback("lr_tienlen:callback:joinTable", function(source, cb, tableIndex)
    Decks[tableIndex]:Join(10, 2)
    Decks[tableIndex]:Join(10, 3)
    Decks[tableIndex]:Join(10, 4)
    cb(Decks[tableIndex]:Join(source, 1))
    Decks[tableIndex]:Ready(1)
    Decks[tableIndex]:Ready(2)
    Decks[tableIndex]:Ready(3)
    Decks[tableIndex]:Ready(4)
    Decks[tableIndex]:Start()
end) ]]

ESX.RegisterServerCallback("lr_tienlen:callback:sort", function(source, cb, tableIndex, slot)
    local slot = Decks[tableIndex]:GetPlayerSlot(source)
    if slot == nil then return end 
    Decks[tableIndex]:HandSort(slot)
    cb(Decks[tableIndex].slot[tostring(slot)].hand)
end)

ESX.RegisterServerCallback("lr_tienlen:callback:getCardData", function(source, cb, tableIndex, cardIndex)
    print("getCardData", cardIndex)
    local card = Decks[tableIndex]:GetCardData(cardIndex, source)
    if card ~= nil then
        cb({
            rank = card[1],
            suit = card[2]
        })
    end
end)

RegisterNetEvent("lr_tienlen:server:hit")
AddEventHandler("lr_tienlen:server:hit", function(tableIndex, cards)
    local slot = Decks[tableIndex]:GetPlayerSlot(source)
    if slot == nil then return end
    if not Decks[tableIndex]:IsSpecialCards(cards, slot) then
        if Decks[tableIndex].lastTurnSlot == slot then
            if Decks[tableIndex]:CanHit(cards) then
                Decks[tableIndex]:Hit(tonumber(slot), cards)
            else
                print(false)
            end
        else
            TriggerClientEvent("esx:showNotification", source, "Không phải lượt của bạn")
        end
    else
        if Decks[tableIndex]:CanHit(cards) then
            Decks[tableIndex]:Hit(tonumber(slot), cards)
        else
            print(false)
        end
    end
end)

RegisterNetEvent("lr_tienlen:server:next")
AddEventHandler("lr_tienlen:server:next", function(tableIndex)
    local slot = Decks[tableIndex]:GetPlayerSlot(source)
    if slot == nil then return end
    if Decks[tableIndex].lastTurnSlot == slot then
        Decks[tableIndex]:Next(slot)
    else
        TriggerClientEvent("esx:showNotification", source, "Không phải lượt của bạn")
    end
end)

ESX.RegisterServerCallback("lr_tienlen:callback:joinTable", function(source, cb, tableIndex, slot)
    --[[ Decks[1]:Join(10, 2) ]]
    --[[ Decks[tableIndex]:Join(10, 3)
    Decks[tableIndex]:Join(10, 4) ]]
    if Decks[tableIndex]:Join(source, slot) then 
        
        --[[ Decks[tableIndex]:Ready(1)
        Decks[tableIndex]:Ready(2)
        Decks[tableIndex]:Ready(3)
        Decks[tableIndex]:Ready(4) ]]
        cb(true)
        --[[ Decks[tableIndex]:Start() ]]
    else
        cb(false)
    end
end)



ESX.RegisterServerCallback("lr_tienlen:callback:ready", function(source, cb, tableIndex)
    local slot = Decks[tableIndex]:GetPlayerSlot(source)
    if slot ~= nil then 
        Decks[tableIndex]:Ready(slot, function(canReady)
            cb(canReady)
        end)
    end
end)

RegisterNetEvent("lr_tienlen:server:leave")
AddEventHandler("lr_tienlen:server:leave", function(tableIndex)
    local slot = Decks[tableIndex]:GetPlayerSlot(source)
    if slot ~= nil then 
        Decks[tableIndex]:Leave(slot)
    end
end)

RegisterCommand('ready', function(source, args, rawCommand)
    Decks[tonumber(args[1])]:Ready(args[2], function(canReady)

    end)
end)
RegisterCommand('leave', function(source, args, rawCommand)
    Decks[tonumber(args[1])]:Leave(args[2])
end)
RegisterCommand("join", function(source, args , rawCommand)
    Decks[tonumber(args[1])]:Join(10, args[2])
end)
RegisterCommand("kickk", function(source, args, rawCommand)
    print(args[1], args[2])
    Decks[tonumber(args[1])]:RequestKick(args[2], source)
end)

RegisterNetEvent("lr_tienlen:server:requestKick")
AddEventHandler("lr_tienlen:server:requestKick", function(tableIndex, slot)
    Decks[tableIndex]:RequestKick(slot, source)
end)

RegisterNetEvent("lr_tienlen:server:acceptRequest")
AddEventHandler("lr_tienlen:server:acceptRequest", function(tableIndex, slot)
    Decks[tableIndex]:AcceptKick(slot, source)
end)

function SyncTablesData()
    TriggerClientEvent("lr_tienlen:client:syncTableData", -1, Decks)
end

AddEventHandler("esx:playerDropped", function(playerId)
    local playerData = GetPlayerTable(playerId)
    if playerData ~= nil then 
        Decks[playerData.tableIndex]:Leave(playerData.slot)
        --[[ if Decks[playerData.tableIndex]:CountPlayers() <= 1 then 
            Decks[playerData.tableIndex].started = false
            Decks[playerData.tableIndex]:TriggerClientEvent("lr_tienlen:client:end")
            Wait(1000)
            Decks[playerData.tableIndex]:New()
        end ]]
    end
end)