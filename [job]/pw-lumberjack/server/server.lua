ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--[[ RegisterServerEvent('wood:getItem')
AddEventHandler('wood:getItem', function()
	local xPlayer, randomItem = Framework.Functions.GetPlayer(source), Config.Items[math.random(1, #Config.Items)]
	
	if math.random(0, 100) <= Config.ChanceToGetItem then
		local Item = xPlayer.Functions.GetItemByName('wood_cut')
		if Item == nil then
			xPlayer.Functions.AddItem(randomItem, 1)
			TriggerClientEvent("pepe-inventory:client:ItemBox", source, Framework.Shared.Items[randomItem], "add")
		else	
			if Item.amount < 20 then
				xPlayer.Functions.AddItem(randomItem, 1)
				TriggerClientEvent("pepe-inventory:client:ItemBox", source, Framework.Shared.Items[randomItem], "add")
			else
				TriggerClientEvent('Framework:Notify', source, 'Inventory full, you can not carry more!', "error")  
			end
	    end
    end
end) ]]

RegisterServerEvent('wood_weed:processweed2')
AddEventHandler('wood_weed:processweed2', function()
	local src = source
	TriggerClientEvent("inventory:removeItem",source,"fishinglog",1)
	TriggerClientEvent("player:receiveItem",source,"refinedwood",1)
	--Player.Functions.RemoveItem('wood_cut', 1)
	--Player.Functions.AddItem('wood_proc', 1)
	--TriggerClientEvent("pepe-inventory:client:ItemBox", source, Framework.Shared.Items['wood_cut'], "remove")
	--TriggerClientEvent("pepe-inventory:client:ItemBox", source, Framework.Shared.Items['wood_proc'], "add")
	TriggerClientEvent('ESX:Notify', src, 'Gỗ đã được bào thành công', "success")
			  
		
end)


RegisterServerEvent('wood:sell')
AddEventHandler('wood:sell', function()

    local xPlayer = ESX.GetPlayerFromId(source)
	--local Item = xPlayer.Functions.GetItemByName('wood_proc')
	
	TriggerClientEvent("inventory:removeItem",source,"refinedwood",5)
	xPlayer.addAccountMoney("money", math.random(120,155))

	
	
end)

RegisterServerEvent('pw-lumber:Payout')
AddEventHandler('pw-lumber:Payout', function(cash)	
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addMoney(cash)
end)


