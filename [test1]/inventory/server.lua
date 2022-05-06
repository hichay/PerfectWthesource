ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('server-inventory-request-identifier')
AddEventHandler('server-inventory-request-identifier', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local steam = xPlayer.identifier
    TriggerClientEvent('inventory-client-identifier', src, steam)
end)

RegisterCommand('evidence', function(source, args)
    -- local src = source
    -- local xPlayer = ESX.GetPlayerFromId(src)
    -- local boxID = args[1]

    -- if xPlayer.job.name == 'police' and boxID and type(tonumber(boxID)) == 'number' then
        -- TriggerClientEvent("server-inventory-open", src, "1", "evidence-" .. boxID)
    -- end
	--exports['moons_skin']:OpenSkinMenu()
	--exports.moons_skin:OpenSkinMenu()
	TriggerEvent('hello:event')
end)


RegisterCommand('additem', function(source, args)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(args[1])
	local item    = args[2]
    	local count   = (args[3] == nil and 1 or tonumber(args[3]))
	local returnData= args[4]
	if count ~= nil then
		if xPlayer ~= nil then
            TriggerClientEvent('player:receiveItem', xPlayer.source, ""..item.."", count,returnData)
		else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Item'})
		end
	else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Amount'})
	end
end)

-- RegisterCommand('InvItem', function(source, args, raw)
--     local target = --ESX.GetPlayerFromId(tonumber(args[1]))
--     local item = args[2]
--     local amount = tonumber(args[3])

--     if target ~= nil then
--         if item ~= nil then
--             if amount ~= nil then
--                 TriggerClientEvent('player:receiveItem', target, ""..item.."", amount)
--             else
--                 TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Amount'})
--             end
--         else
--             TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Item'})
--         end
--     else
--         TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'This player is not online'})
--     end
-- end)



RegisterServerEvent('cash:remove')
AddEventHandler('cash:remove', function(source, cash)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeMoney(cash)
end)



RegisterServerEvent('people-search')
AddEventHandler('people-search', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(target)
    local identifier = xPlayer.identifier
	TriggerClientEvent("server-inventory-open", source, "1", identifier)

end)

RegisterServerEvent("server-item-quality-update")
AddEventHandler("server-item-quality-update", function(player, data)
	local quality = data.quality
	local slot = data.slot
	local itemid = data.item_id

    exports.ghmattimysql:execute("UPDATE user_inventory2 SET `quality` = @quality WHERE name = @name AND slot = @slot AND item_id = @item_id", {['quality'] = quality, ['name'] = player, ['slot'] = slot, ['item_id'] = itemid})
  
end)


RegisterServerEvent('inentory:removecash')
AddEventHandler('inentory:removecash', function(source,cash)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeMoney(cash)
end)

