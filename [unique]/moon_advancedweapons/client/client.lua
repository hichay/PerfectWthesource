
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.SharedObject, function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNUICallback('closeEquipment', function(data, cb)
	SetNuiFocus(false)
	-- cb("ok")
end)

RegisterNUICallback('useAttachment', function(data, cb)
	local _playerPed = PlayerPedId()
	local _comInfo = Config.attachments[data.com_name]
	
	if _comInfo ~= nil then
		
		local resultCode = checkCanAttachmentEquip(data.weapon_name, _comInfo)
		
		if resultCode == 0 then
		
			ESX.TriggerServerCallback('moon_advancedweapons:UseAttachment', function(result)
			    
			    for i,v in ipairs(result) do
				if v.code == 0 then
					
					ESX.ShowNotification(_U('sucess'))
					loadPlayerInventory()
					cb("ok")
				elseif v.code == 1 then					
					ESX.ShowNotification(_U('no_item'))
					cb("error")
				else
					ESX.ShowNotification(_U('unkownerror'))
					
					cb("error")
				end
				end
			end, data.com_name, data.weapon_name)
			
		elseif resultCode == 1 then			
			ESX.ShowNotification(_U('alreadyequip'))
			cb("error")
		elseif resultCode == 2 then		
			ESX.ShowNotification(_U('removeoldattach'))
			cb("error")
		elseif resultCode == 3 then
			ESX.ShowNotification(_U('cannotequip'))
			cb("error")
		else
			ESX.ShowNotification(_U('unkownerror'))
			cb("error")
		end	
	else
		cb("error")
	end
	
end)

RegisterNUICallback('removeAttachment', function(data, cb)
	local _playerPed = PlayerPedId()
	local _comInfo = Config.attachments[data.com_name]
	local _isRemovingAttachment = false
	if not _isRemovingAttachment and _comInfo ~= nil then
	    local resultCode = checkRemoveAttachmentEquip(data.weapon_name, _comInfo)
	 if resultCode == 0 then
		_isRemovingAttachment = true
		
		ESX.TriggerServerCallback('moon_advancedweapons:RemoveAttachment', function(result)
			for i,v in ipairs(result) do
			if v.code == 0 then
				ESX.ShowNotification(_U('removeattachsuccess'))
				loadPlayerInventory()
				cb("ok")
				
			elseif v.code == 1 then
				ESX.ShowNotification(_U('noattachtoremove'))
				cb("error")
			else
				ESX.ShowNotification(_U('no_item'))
				loadPlayerInventory()
				cb("error")
			
			end
			end
			_isRemovingAttachment = false
			
			loadPlayerInventory()
			
			
		end, data.com_name, data.weapon_name)
	
	 else
	    ESX.ShowNotification(_U('noattachonweapon'))	
	 end	
	else 
		cb("error")
	end
	
end)


RegisterNetEvent('moon_advancedweapons:showEquipment')
AddEventHandler('moon_advancedweapons:showEquipment', function()
	loadPlayerInventory()
	SendNUIMessage({
		type = "show_wp_equipment"
	})
	SetNuiFocus(true, true)
end)

RegisterNetEvent("moon_advancedweapons:updateUILive")
AddEventHandler("moon_advancedweapons:updateUILive", function()
	loadPlayerInventory()
end)


function loadPlayerInventory()
    ESX.TriggerServerCallback('moon_advancedweapons:getPlayerLoadout', function(data)
		items = {}
		weapons = data.weapons
		inventory = data.inventory

		if weapons ~= nil then
			for key, value in pairs(weapons) do
				local weaponHash = GetHashKey(weapons[key].name)
				local compsHash = GetHashKey(weapons[key].components)
				local playerPed = PlayerPedId()
				if HasPedGotWeapon(playerPed, weaponHash, false) and weapons[key].name ~= "WEAPON_UNARMED" then
					local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
					 --print("Show key " .. weapons[key].name)
					 
					local _comListitem = getComponentInWeapon(weapons[key].name, weapons[key].components)
					table.insert(
						items,
						{
							label = weapons[key].label,
							count = ammo,
							limit = -1,
							type = "item_weapon",
							name = weapons[key].name,
							usable = true,
							rare = false,
							canRemove = true,
							componentList = _comListitem
						}
					)
				end
			end
		end

		if inventory ~= nil then
			for key, value in pairs(inventory) do
				if inventory[key].count <= 0 then
					inventory[key] = nil
				else
					inventory[key].type = "item_standard"
					table.insert(items, inventory[key])
				end
			end
		end

		SendNUIMessage({
			type = "set_items",
			itemList = items
		})
	end, GetPlayerServerId(PlayerId())
	)
end

function getItemNameFromHash(hash)
	
	for key_j, item_j in pairs(Config.attachments) do 
		if GetHashKey(item_j.key) == hash then
			return key_j
		end
	end	
	return nil	
end

function getComponentInWeapon(weapon_name, comps_equip)

	local _playerPed = PlayerPedId()
	component_list = {}
	
	for i=1, #comps_equip, 1 do
		
		local compInfo = ESX.GetWeaponComponent(weapon_name, comps_equip[i])
		
		if compInfo ~= nil then		
			local itemName = getItemNameFromHash(compInfo.hash)
			if itemName ~= nil then
				table.insert(component_list, itemName)
			end
		end
	end
	
	return component_list
end



function checkComponentInsideWeapon(weapon_name, comps_equip)

	local _playerPed = PlayerPedId()
	
	component_list = {}
	
	for i=1, #ESX.PlayerData.loadout, 1 do
		local weaponName = ESX.PlayerData.loadout[i].name
		local weaponHash = GetHashKey(weaponName)
		
		for j=1, #ESX.PlayerData.loadout[i].components, 1 do
			local weaponComponent = ESX.PlayerData.loadout[i].components[j]
			local compInfo = ESX.GetWeaponComponent(weaponName, weaponComponent).hash
		
		if compInfo ~= nil then
				table.insert(component_list, compInfo)
		    end
		end
	end
	
	--for i,v in ipairs(component_list) do print(i,v) end
	return component_list
	
end

---
--- Component
---

function useAttachment(weapon_name, attachment_name)
	local _playerPed = PlayerPedId()
	GiveWeaponComponentToPed(_playerPed, GetHashKey(weapon_name), GetHashKey(attachment_name))
	TriggerEvent('esx:updateLoadOutNow')
end

function removeAttachment(weapon_name, attachment_name)
	local _playerPed = PlayerPedId()
	RemoveWeaponComponentFromPed(_playerPed, GetHashKey(weapon_name), GetHashKey(attachment_name))
	TriggerEvent("esx:updateLoadOutNow")
end

function pedHaveWeaponComponent(weapon_name, attachment_name)
	local _playerPed = PlayerPedId()
	return HasPedGotWeaponComponent(_playerPed, GetHashKey(weapon_name), GetHashKey(attachment_name))
end

function checkRemoveAttachmentEquip(weapon_name, attachData)

	local _playerPed = PlayerPedId()
	
	local weaponHash = GetHashKey(weapon_name)
	local attachHash = GetHashKey(attachData.key)
	
	if HasPedGotWeaponComponent(_playerPed, weaponHash, attachHash) then
	 return 0
	else
     return 1
    end
end	

function checkCanAttachmentEquip(weapon_name, attachData)

	local _playerPed = PlayerPedId()	
	local weaponHash = GetHashKey(weapon_name)
	local attachHash = GetHashKey(attachData.key)
	
	-- check attach can equip?
	if HasPedGotWeaponComponent(_playerPed, weaponHash, attachHash) then
		return 1
	else
		
		-- check attachment is skin?
		local weaponCompData = ESX.GetWeaponComponentByHash(weapon_name, attachHash)
		
		if weaponCompData ~= nil then
			
			if weaponCompData.is_skin then
				
				-- comp is skin => check equip another skin or not
				local iw,weaponData = ESX.GetWeapon(weapon_name)
				for k,v in ipairs(weaponData.components) do					
					if v.is_skin and HasPedGotWeaponComponent(_playerPed, weaponHash, v.hash) then						
						return 2					
					end				
				end
				
			end
			
			-- check attach replace found
			for i=1, #attachData.replace do
				
				if HasPedGotWeaponComponent(_playerPed, weaponHash, GetHashKey(attachData.replace[i])) then
					return 2
				end	
			end		
		else
			return 3
		end		
	end
	return 0	
end
