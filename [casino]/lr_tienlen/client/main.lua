ESX = nil




LRTL = {}
LRTL.__index = LRTL

function LRTL:Init()
    local o = {}
    setmetatable(o, LRTL)
    o.isJoined = false
    o.currentTable = nil
    o.currentSlot = nil
    o.isOpen = false
    return o
end

function LRTL:Toggle()
    self.isOpen = not self.isOpen
    if self.isOpen then 
        SetNuiFocus(true, true)
        SendNUIMessage({
            event = "toggle",
            data = true
        })
        if not self.isJoined then 
            ESX.TriggerServerCallback("lr_tienlen:callback:getTablesStatus", function(result)
                SendNUIMessage({
                    event = "initTables",
                    data = result
                })
            end)
        end
    else
        SetNuiFocus(false, false)
        SendNUIMessage({
            event = "toggle",
            data = false
        })
    end
end

function LRTL:EventHandler()
    RegisterNetEvent("lr_tienlen:client:syncTableData")
    AddEventHandler("lr_tienlen:client:syncTableData", function(data)
        SendNUIMessage({
            event = "initTables",
            data = data
        })
    end)
    RegisterNUICallback("Close", function()
        self:Toggle()
    end)
    RegisterNUICallback("JoinTable", function(data, cb)
        local tableIndex = tonumber(data.tableIndex)
        local slot = data.slot
        ESX.TriggerServerCallback("lr_tienlen:callback:joinTable", function(canJoin)
            if canJoin then 
                self.isJoined = true
                self.currentTable = tableIndex
                self.currentSlot = slot
                cb({
                    canJoin = true,
                    currentTable = self.currentTable,
                    currentSlot = self.currentSlot
                })
            else
                cb(false)
            end
        end, tableIndex, slot)
    end)
    RegisterNetEvent("lr_tienlen:client:sync")
    AddEventHandler("lr_tienlen:client:sync", function(data)
        SendNUIMessage({
            event = "syncPlayerData",
            data = data
        })
    end)
    RegisterNUICallback("Ready", function(data, cb)
        ESX.TriggerServerCallback("lr_tienlen:callback:ready", function(canReady)
            cb(canReady)
        end, self.currentTable)
    end)
    RegisterNetEvent("lr_tienlen:client:start")
    AddEventHandler("lr_tienlen:client:start", function()
        SendNUIMessage({
            event = "start"
        })
    end)
    RegisterNUICallback("Leave", function(data, cb)
        TriggerServerEvent("lr_tienlen:server:leave", self.currentTable)
        self.isJoined = false
        self.currentTable = nil
        self.currentSlot = nil
    end)
    RegisterNetEvent("lr_tienlen:client:newCards")
    AddEventHandler("lr_tienlen:client:newCards", function(cards)
        SendNUIMessage({
            event = "syncCards",
            data = cards
        })
    end)

    RegisterNetEvent("lr_tienlen:client:dealCards")
    AddEventHandler("lr_tienlen:client:dealCards", function(slot, card)
        SendNUIMessage({
            event = "deal",
            data = {
                slot = slot,
                card = card
            }
        })
    end)

    RegisterNUICallback("Sort", function(data, cb)
        ESX.TriggerServerCallback("lr_tienlen:callback:sort", function(data)
            cb(data)
        end, self.currentTable)
    end)
    RegisterNUICallback("getCardData", function(data, cb)
        ESX.TriggerServerCallback("lr_tienlen:callback:getCardData", function(data)
            cb(data)
        end, self.currentTable, data.index)
    end)

    AddEventHandler("onResourceStop", function(rsN)
        if rsN == GetCurrentResourceName() then 
            SetNuiFocus(false, false)
        end
    end)

    RegisterNetEvent("lr_tienlen:client:syncTurn")
    AddEventHandler("lr_tienlen:client:syncTurn", function(slot)
        SendNUIMessage({
            event = "turn",
            data = slot
        })
    end)

    RegisterNetEvent("lr_tienlen:client:syncTime")
    AddEventHandler("lr_tienlen:client:syncTime", function(time)
        SendNUIMessage({
            event = "time",
            data = time
        })
    end)

    RegisterNetEvent("lr_tienlen:client:hit")
    AddEventHandler("lr_tienlen:client:hit", function(slot, cardIndex)
        SendNUIMessage({
            event = "hit",
            data = {
                slot = slot,
                card = cardIndex
            }
        })
    end)

    RegisterNUICallback("Hit", function(data, cb)
        TriggerServerEvent("lr_tienlen:server:hit", self.currentTable, data.cards)
    end)

    RegisterNUICallback("Next", function(slot, cb)
        TriggerServerEvent("lr_tienlen:server:next", self.currentTable)
    end)

    RegisterNetEvent("lr_tienlen:client:flipDesk")
    AddEventHandler("lr_tienlen:client:flipDesk", function()
        SendNUIMessage({
            event = "flipDesk"
        })
    end)

    RegisterNetEvent("lr_tienlen:client:removeAllCards")
    AddEventHandler("lr_tienlen:client:removeAllCards", function()
        SendNUIMessage({
            event = "removeAllCards"
        })
    end)
    RegisterNetEvent("lr_tienlen:client:end")
    AddEventHandler("lr_tienlen:client:end", function()
        SendNUIMessage({
            event = "end"
        })
    end)
    RegisterNetEvent("lr_tienlen:client:addMoney")
    AddEventHandler("lr_tienlen:client:addMoney", function(slot, money)
        SendNUIMessage({
            event = "addMoney",
            data = {
                slot = slot,
                money = money
            }
        })
    end)
    RegisterNetEvent("lr_tienlen:client:removeMoney")
    AddEventHandler("lr_tienlen:client:removeMoney", function(slot, money)
        SendNUIMessage({
            event = "removeMoney",
            data = {
                slot = slot,
                money = money
            }
        })
    end)
    RegisterNUICallback("Kick", function(data, cb)
        TriggerServerEvent("lr_tienlen:server:requestKick", self.currentTable, data.slot)
    end)
    RegisterNetEvent("lr_tienlen:client:requestKick")
    AddEventHandler("lr_tienlen:client:requestKick", function(slot, slotName, name)
        SendNUIMessage({
            event = "requestKick",
            data = {
                slot = slot,
                slotName = slotName,
                name = name
            }
        })
    end)
    RegisterNUICallback("AcceptRequest", function(data, cb)
        TriggerServerEvent("lr_tienlen:server:acceptRequest", self.currentTable, data.slot)
    end)
    RegisterNetEvent("lr_tienlen:client:kicked")
    AddEventHandler("lr_tienlen:client:kicked", function()
        SendNUIMessage({
            event = "kicked"
        })
    end)
end

function LRTL:MainThread()
    -- while true do 
        -- coroutine.yield(0)
        -- if IsControlJustPressed(0, 83) then 
            -- self:Toggle()
        -- end
    -- end
end

Citizen.CreateThread(function()
    while ESX == nil do 
        Wait(0)
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
    rt = LRTL:Init()
    rt:EventHandler()
    rt:MainThread()
end)

RegisterNetEvent("lr_tienlen:client:OpenTable")
AddEventHandler("lr_tienlen:client:OpenTable", function(data)

	LRTL:Toggle()
	
end)
