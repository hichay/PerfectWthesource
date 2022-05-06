
ESX = nil
TriggerEvent(Config['esx_routers']['server_shared_obj'],
             function(obj) ESX = obj end)
			 
ESX.RegisterServerCallback('azael_ui-diving:authenticating',
                           function(playerId, cb)
    if true then
        cb(true)
    else
        cb(false)
    end
end)
ESX.RegisterUsableItem(Config['item']['scuba_gear'], function(playerId)
    
        if Config['use_scuba_gear_in_water'] then
            TriggerClientEvent('azael_ui-diving:scubaDiving', playerId)
        else
            TriggerClientEvent('azael_ui-diving:scubaCheckPedInWater', playerId)
        end
    
end)
ESX.RegisterUsableItem(Config['item']['scuba_oxygen_tank'], function(playerId)
    
        if Config['use_scuba_oxygen_tank_in_water'] then
            local xPlayer = ESX.GetPlayerFromId(playerId)
            xPlayer.removeInventoryItem(Config['item']['scuba_oxygen_tank'], 1)
            TriggerClientEvent(Config['esx_routers']['server_status_add'],
                               playerId, 'scubaOxygen',
                               Config['scuba_oxygen_add'])
        else
            TriggerClientEvent('azael_ui-diving:scubaoxygenCheckPedInWater',
                               playerId)
        end
    
end)
RegisterNetEvent('azael_ui-diving:scubaoxygenUsableItem')
AddEventHandler('azael_ui-diving:scubaoxygenUsableItem', function(canUseItem)
    
        local playerId = source
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if canUseItem then
            xPlayer.removeInventoryItem(Config['item']['scuba_oxygen_tank'], 1)
            TriggerClientEvent(Config['esx_routers']['server_status_add'],
                               playerId, 'scubaOxygen',
                               Config['scuba_oxygen_add'])
        end
    
end)
ESX.RegisterUsableItem(Config['item']['snorkelling_gear'], function(playerId)
   
        if Config['use_snorkelling_gear_in_water'] then
            TriggerClientEvent('azael_ui-diving:snorkellingDiving', playerId)
        else
            TriggerClientEvent('azael_ui-diving:snorkellingCheckPedInWater',
                               playerId)
        end
    
end)
