ESX = nil
local playersProcessingCannabis = {}
local playersProcessingMushroom = {}
local playersProcessingCoral = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(5000, CountCops)

end

CountCops()


RegisterServerEvent('esx_drugs:sellDrug')
AddEventHandler('esx_drugs:sellDrug', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config.DrugDealerItems[itemName]
	local xItem = xPlayer.getInventoryItem(itemName)
    
	if CopsConnected < Config.RequiredCops then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police') .. CopsConnected .. '/' .. Config.RequiredCops)
		return
	end
	
	if not price then
		print(('esx_drugs: %s attempted to sell an invalid drug!'):format(xPlayer.identifier))
		return
	end

	if xItem.count < amount then
		TriggerClientEvent('esx:showNotification', source, _U('dealer_notenough'))
		return
	end

	price = ESX.Math.Round(price * amount)

	if Config.GiveBlack then
		xPlayer.addAccountMoney('black_money', price)
	else
		xPlayer.addMoney(price)
	end

	xPlayer.removeInventoryItem(xItem.name, amount)

	TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', amount, xItem.label, ESX.Math.GroupDigits(price)))
end)

ESX.RegisterServerCallback('esx_drugs:buyLicense', function(source, cb, licenseName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local license = Config.LicensePrices[licenseName]

	if license == nil then
		print(('esx_drugs: %s attempted to buy an invalid license!'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.getMoney() >= license.price then
		xPlayer.removeMoney(license.price)

		TriggerEvent('esx_license:addLicense', source, licenseName, function()
			cb(true)
		end)
	else
		cb(false)
	end
end)


RegisterServerEvent('esx_drugs:pickedUpCannabis1')
AddEventHandler('esx_drugs:pickedUpCannabis1', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.canCarryItem('cannabis', 1) then
		xPlayer.addInventoryItem('cannabis', 1)
	else
		xPlayer.showNotification(_U('weed_inventoryfull'))
	end
end)


RegisterServerEvent('esx_drugs:pickedUpMushroom')
AddEventHandler('esx_drugs:pickedUpMushroom', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.canCarryItem('mushroom', 1) then
		xPlayer.addInventoryItem('mushroom', 1)
	else
		xPlayer.showNotification(_U('mush_inventoryfull'))
	end
end)



RegisterServerEvent('esx_drugs:pickedUpCoral')
AddEventHandler('esx_drugs:pickedUpCoral', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent("player:receiveItem",source,"coral",1)
	-- if xPlayer.canCarryItem('coral', 1) then
		-- xPlayer.addInventoryItem('coral', 1)
	-- else
		-- xPlayer.showNotification(_U('coral_inventoryfull'))
	-- end
end)

RegisterServerEvent('esx_drugs:pickedUpCoke')
AddEventHandler('esx_drugs:pickedUpCoke', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.canCarryItem('coca_leaf', 1) then
		xPlayer.addInventoryItem('coca_leaf', 1)
	else
		xPlayer.showNotification(_U('coral_inventoryfull'))
	end
end)


ESX.RegisterServerCallback('esx_drugs:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(xPlayer.canCarryItem(item, 1))
end)


-- RegisterServerEvent('esx_drugs:processCannabis1')
-- AddEventHandler('esx_drugs:processCannabis1', function()
	-- if not playersProcessingCannabis[source] then
		-- local _source = source

		-- playersProcessingCannabis[_source] = ESX.SetTimeout(Config.Delays.WeedProcessing, function()
			-- local xPlayer = ESX.GetPlayerFromId(_source)
			-- local xCannabis, xMarijuana = xPlayer.getInventoryItem('cannabis'), xPlayer.getInventoryItem('marijuana')

			-- if xMarijuana.limit ~= 20 and (xMarijuana.count + 1) >= xMarijuana.limit then
				-- TriggerClientEvent('esx:showNotification', _source, _U('weed_processingfull'))
			-- elseif xCannabis.count < 5 then
				-- TriggerClientEvent('esx:showNotification', _source, _U('weed_processingenough'))
			-- else
				-- xPlayer.removeInventoryItem('cannabis', 5)
				-- xPlayer.addInventoryItem('marijuana', 1)

				-- TriggerClientEvent('esx:showNotification', _source, _U('weed_processed'))
			-- end

			-- playersProcessingCannabis[_source] = nil
		-- end)
	-- else
		-- print(('esx_drugs: %s attempted to exploit weed processing!'):format(GetPlayerIdentifiers(source)[1]))
	-- end
-- end)


-- RegisterServerEvent('esx_drugs:processMushroom')
-- AddEventHandler('esx_drugs:processMushroom', function()
	-- if not playersProcessingMushroom[source] then
		-- local _source = source

		-- playersProcessingMushroom[_source] = ESX.SetTimeout(Config.Delays.MushProcessing, function()
			-- local xPlayer = ESX.GetPlayerFromId(_source)
			-- local xMushroom, xCokemush = xPlayer.getInventoryItem('mushroom'), xPlayer.getInventoryItem('cokemush')

			-- if xCokemush.limit ~= 20 and (xCokemush.count + 1) >= xCokemush.limit then
				-- TriggerClientEvent('esx:showNotification', _source, _U('mush_processingfull'))
			-- elseif xMushroom.count < 5 then
				-- TriggerClientEvent('esx:showNotification', _source, _U('mush_processingenough'))
			-- else
				-- xPlayer.removeInventoryItem('mushroom', 5)
				-- xPlayer.addInventoryItem('cokemush', 1)

				-- TriggerClientEvent('esx:showNotification', _source, _U('mush_processed'))
			-- end

			-- playersProcessingMushroom[_source] = nil
		-- end)
	-- else
		-- print(('esx_drugs: %s attempted to exploit weed processing!'):format(GetPlayerIdentifiers(source)[1]))
	-- end
-- end)

-- RegisterServerEvent('esx_drugs:processCoral')
-- AddEventHandler('esx_drugs:processCoral', function()
	-- if not playersProcessingCoral[source] then
		-- local _source = source

		-- playersProcessingCoral[_source] = ESX.SetTimeout(Config.Delays.WeedProcessing, function()
			-- local xPlayer = ESX.GetPlayerFromId(_source)
			-- local xCoral, xCoralsade = xPlayer.getInventoryItem('coral'), xPlayer.getInventoryItem('coralsade')

			-- if xCoralsade.limit ~= 20 and (xCoralsade.count + 1) >= xCoralsade.limit then
				-- TriggerClientEvent('esx:showNotification', _source, _U('coral_processingfull'))
			-- elseif xCoral.count < 5 then
				-- TriggerClientEvent('esx:showNotification', _source, _U('coral_processingenough'))
			-- else
				-- xPlayer.removeInventoryItem('coral', 5)
				-- xPlayer.addInventoryItem('coralsade', 1)

				-- TriggerClientEvent('esx:showNotification', _source, _U('coral_processed'))
			-- end

			-- playersProcessingCoral[_source] = nil
		-- end)
	-- else
		-- print(('esx_drugs: %s attempted to exploit weed processing!'):format(GetPlayerIdentifiers(source)[1]))
	-- end
-- end)





