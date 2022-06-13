IsSmelterProcessing = false
IsSmelterProcessingFinished = false

local BasicSmelter = {
    aluminiummate = {amount = 5, itemrefined = 'aluminium', slot = 1, time = 10},
    --glass = {amount = 5, itemrefined = 'copper', slot = 2, time = 10},
    --glass = {amount = 5, itemrefined = 'glass', slot = 3, time = 10},
    --glass = {amount = 5, itemrefined = 'plastic', slot = 4, time = 10},
    --glass = {amount = 5, itemrefined = 'rubber', slot = 5, time = 10},
    --glass = {amount = 5, itemrefined = 'scrapmetal', slot = 5, time = 10},
    ironmate = {amount = 5, itemrefined = 'steel', slot = 5, time = 10},
}

local RefinedSmelter = {
    steel = {amount = 3, itemrefined = 'refinedsteel', slot = 1, time = 10},
    aluminium = {amount = 3, itemrefined = 'refinedaluminium', slot = 2, time = 8},
    glass = {amount = 3, itemrefined = 'refinedglass', slot = 3, time = 4},
    copper = {amount = 3, itemrefined = 'refinedcopper', slot = 4, time = 5},
    plastic = {amount = 3, itemrefined = 'refinedplastic', slot = 5, time = 1},
    rubber = {amount = 3, itemrefined = 'refinedrubber', slot = 6, time = 3},
    scrapmetal = {amount = 3, itemrefined = 'refinedscrap', slot = 7, time = 5},
}

local Totaltime = 0
RegisterNetEvent("pw-alchemist:SmelterStared")
AddEventHandler("pw-alchemist:SmelterStared", function(basic)
    local src = source
    if basic then 
        local inventory = exports["pw-inventory"]:getInventory("smelter-basic")
        TriggerClientEvent('pw-alchemist:SmelterProcessing',-1,true)
        IsSmelterProcessing = true
        for i, v in ipairs(inventory) do
            local Amountperitem = BasicSmelter[v.item_id].amount
            local Item = BasicSmelter[v.item_id]
            totalamount = v.amount / Amountperitem
            amountrefined = math.floor(totalamount)
            if Item then
                TriggerEvent('server-remove-item', 'smelter-basic', v.item_id, v.amount)
                TriggerEvent('server-inventory-give', 'smelter-basic', BasicSmelter[v.item_id].itemrefined, BasicSmelter[v.item_id].slot, amountrefined)
                Timerefined = amountrefined * BasicSmelter[v.item_id].time
                Totaltime = Totaltime + Timerefined
            end
        end
        TriggerClientEvent("DoLongHudText",src,'Dự kiến '..Totaltime..' giây lò sẽ nung xong',2)
        Citizen.Wait(Totaltime * 1000)
        TriggerClientEvent('pw-alchemist:SmelterReady',-1,true)
        IsSmelterProcessingFinished = true

    else 
        local inventory = exports["pw-inventory"]:getInventory("smelter-refined")      
        TriggerClientEvent('pw-alchemist:SmelterProcessing',-1,true)
        IsSmelterProcessing = true
        for i, v in ipairs(inventory) do
            local Amountperitem = RefinedSmelter[v.item_id].amount
            local Item = RefinedSmelter[v.item_id]
            totalamount = v.amount / Amountperitem
            amountrefined = math.floor(totalamount)
            if Item then
                TriggerEvent('server-remove-item', 'smelter-refined', v.item_id, v.amount)
                TriggerEvent('server-inventory-give', 'smelter-refined', RefinedSmelter[v.item_id].itemrefined, RefinedSmelter[v.item_id].slot, amountrefined)
                Timerefined = amountrefined * RefinedSmelter[v.item_id].time
                Totaltime = Totaltime + Timerefined
            end
        end
        TriggerClientEvent("DoLongHudText",src,'Dự kiến '..Totaltime..' giây lò sẽ nung xong',2)
        Citizen.Wait(Totaltime * 1000)
        TriggerClientEvent('pw-alchemist:SmelterReady',-1,true)
        IsSmelterProcessingFinished = true
        
    end
    
end)


RPC.register('pw-alchemist:getInitialState',function(src)
    data = {
        ['IsWeedProcessingFinished'] = IsWeedProcessingFinished,
        ['IsSmelterProcessing'] = IsSmelterProcessing,
    }
    return data
end)
