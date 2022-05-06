if Config.UseESX then
	local ESX = nil

	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

	RegisterServerEvent('fuel:pay')
	AddEventHandler('fuel:pay', function(price)
		local xPlayer = ESX.GetPlayerFromId(source)
		local amount = ESX.Math.Round(price)
        -- if xPlayer.hasWeapon('WEAPON_PETROLCAN') then
		 -- TriggerClientEvent('esx:showNotification', source, 'đã sở hữu đồ này')
         -- else
		 
	     xPlayer.addWeapon("WEAPON_PETROLCAN",88332584)
		 xPlayer.removeMoney(amount)
		 TriggerClientEvent('esx:showNotification', source, 'mua thành công')
	    -- end
	end)
	
	

end