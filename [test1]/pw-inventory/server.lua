ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


Citizen.CreateThread(function()
    TriggerEvent("inv:playerSpawned");
end)

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


RegisterServerEvent("cash:remove")
AddEventHandler("cash:remove",function(src,amount)
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeMoney(amount)
end)



RegisterServerEvent('people-search')
AddEventHandler('people-search', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(target)
    local identifier = xPlayer.identifier
	TriggerClientEvent("ESX:Notify",target,"Cảnh sát đang kiểm tra người bạn","info")
	TriggerClientEvent("server-inventory-open", source, "1", identifier)

end)

RegisterServerEvent("server-item-quality-update")
AddEventHandler("server-item-quality-update", function(player, data)
	local quality = data.quality
	local slot = data.slot
	local itemid = data.item_id

    exports.ghmattimysql:execute("UPDATE user_inventory2 SET `quality` = @quality WHERE name = @name AND slot = @slot AND item_id = @item_id", {['quality'] = quality, ['name'] = player, ['slot'] = slot, ['item_id'] = itemid})
  
end)



RegisterServerEvent("inventory:save:settings")
AddEventHandler("inventory:save:settings", function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
	local indentifer = xPlayer.identifier
    local insert = {
        ["holdToDrag"] = data.holdToDrag,
        ["closeOnClick"] = data.closeOnClick,
        ["ctrlMovesHalf"] = data.ctrlMovesHalf,
        ["showTooltips"] = data.showTooltips,
        ["enableBlur"] = data.enableBlur
    }
    local encode = json.encode(insert)
    exports.ghmattimysql:execute('UPDATE users SET `inventory_settings` = @setting WHERE identifier = @identifier', {['setting'] = encode, ['identifier'] = indentifer})
end)

RegisterServerEvent("inventory:RetreiveSettings")
AddEventHandler("inventory:RetreiveSettings", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
	local indentifer = xPlayer.identifier
	--print('ok thiss already load success')
    exports.ghmattimysql:execute("SELECT `inventory_settings` FROM users WHERE identifier = @hex_id", {['hex_id'] = indentifer}, function(result)
        if (result[1]) then
            TriggerClientEvent('inventory:update:settings', src, result[1].inventory_settings)
        end
    end)
end)


RegisterServerEvent('lockpick:vehicle')
AddEventHandler('lockpick:vehicle', function(data, customcoords)
    if customcoords ~= nil then data.coords = customcoords end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job = 'police', 
        coords = data.coords,
        title = 'Cướp phương tiện',
        message = 'Một đối tượng đã cướp xe tại khu vực đường '..data.street_1..', '..data.street_2 ..' Thông tin ghi nhận: '..data.vehicle_label..' '..data.vehicle_plate..''  , 
        flash = 0, 
        blip = {
            sprite = 431, 
            scale = 1.2, 
            colour = 3,
            flashes = false, 
            text = 'Xe bị trộm cắp',
            time = (1*60*1000),
            sound = 1,
        }
    })
end)


RegisterServerEvent('vehicle:lamban')
AddEventHandler('vehicle:lamban', function(data, customcoords)
    if customcoords ~= nil then data.coords = customcoords end
	Citizen.Wait(15000)
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job = 'police', 
        coords = data.coords,
        title = 'Đối tượng làm bẩn',
        message = 'Đang sử dụng xe ăn cắp '..data.street_1..', '..data.street_2 ..''  , 
        flash = 0, 
        blip = {
            sprite = 431, 
            scale = 1.2, 
            colour = 3,
            flashes = false, 
            text = 'Xe rửa tiền',
            time = (1*60*1000),
            sound = 1,
        }
    })
end)




