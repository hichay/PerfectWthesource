

ESX = nil

TriggerEvent(Config.SharedObject, function(obj) ESX = obj end)

ESX.RegisterServerCallback('moon_advancedweapons:getPlayerLoadout', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	local data = {
      name       = GetPlayerName(source),
      job        = xPlayer.job,
      inventory  = xPlayer.inventory,
      accounts   = xPlayer.accounts,
      weapons    = xPlayer.loadout
    }
	
	cb(data)
end)

ESX.RegisterServerCallback('moon_advancedweapons:UseAttachment', function(source, cb , componentNum, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local weaponNum, weaponData = ESX.GetWeapon(weaponName)
	local _comInfo = Config.attachments[componentNum].key
	local comhash = GetHashKey(_comInfo) 	
	local result1 = {}
	local check = xPlayer.hasWeaponComponent(weaponName, composname)
	
	for k,v in ipairs(weaponData.components) do 
	   if v.hash == comhash then
	     name = v.label
		 composname = v.name
	   end
	   
    end	  

    	
	xPlayer.addWeaponComponent(weaponName, composname)
	removeInventoryItem(source,componentNum)
	table.insert(result1, {name , code = 0})
	cb(result1)
	  
end) 

ESX.RegisterServerCallback('moon_advancedweapons:RemoveAttachment', function(source, cb, componentNum, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local weaponNum, weaponData = ESX.GetWeapon(weaponName)
	local _comInfo = Config.attachments[componentNum].key
	local comhash = GetHashKey(_comInfo) 	
	local result1 = {}
	
	for k,v in ipairs(weaponData.components) do 
	   if v.hash == comhash then
	     name = v.label
		 composname = v.name
	   end
	   
    end	 
	
	local check = xPlayer.hasWeaponComponent(weaponName, composname)
	
	if check then 	
       xPlayer.removeWeaponComponent(weaponName, composname)	
       addInventoryItem(source,componentNum)
	   table.insert(result1, {name , code = 0})
	   
	else
	   table.insert(result1, {name , code = 1})
	end
	cb(result1)
end)




RegisterServerEvent('moon_advancedweapons:updateLoadout')
AddEventHandler('moon_advancedweapons:updateLoadout', function(loadout)
	local xPlayer   = ESX.GetPlayerFromId(source)
	xPlayer.loadout = loadout
end)

function removeInventoryItem(source, _item_name)
	local xPlayer = ESX.GetPlayerFromId(source)
	if _item_name ~= nil and _item_name ~= "" then
		xPlayer.removeInventoryItem(_item_name, 1)
	end
end

function addInventoryItem(source, _item_name)
	local xPlayer = ESX.GetPlayerFromId(source)
	if _item_name ~= nil and _item_name ~= "" then
		xPlayer.addInventoryItem(_item_name, 1)
	end
end


ESX.RegisterUsableItem('attach_at_scope_medium', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    removeInventoryItem(source,'attach_at_scope_medium')
end)

ESX.RegisterUsableItem('attach_at_scope_macro', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    	removeInventoryItem(source,'attach_at_scope_macro')
end)

ESX.RegisterUsableItem('attach_at_ar_afgrip', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    removeInventoryItem(source,'attach_at_ar_afgrip')
end)

ESX.RegisterUsableItem('attach_at_ar_supp02', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    removeInventoryItem(source,'attach_at_ar_supp02')
end)

ESX.RegisterUsableItem('attach_at_ar_flsh', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    removeInventoryItem(source,'attach_at_ar_flsh')
end)

ESX.RegisterUsableItem('attach_at_pi_flsh', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    removeInventoryItem(source,'attach_at_pi_flsh')
end)

ESX.RegisterUsableItem('attach_at_pi_flsh', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    removeInventoryItem(source,'attach_at_pi_flsh')
end)

ESX.RegisterUsableItem('attach_at_pi_supp', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    removeInventoryItem(source,'attach_at_pi_supp')
end)

ESX.RegisterUsableItem('attach_at_pi_supp02', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    removeInventoryItem(source,'attach_at_pi_supp02')
end)

ESX.RegisterUsableItem('attach_at_scope_small', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    removeInventoryItem(source,'attach_at_scope_small')
end)

ESX.RegisterUsableItem('attach_at_scope_large', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    removeInventoryItem(source,'attach_at_scope_large')
end)

ESX.RegisterUsableItem('attach_at_scope_large', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    removeInventoryItem(source,'attach_at_scope_large')
end)

