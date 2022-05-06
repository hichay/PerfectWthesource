ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("fn_weaponshop:buyWeapon",function(source,cb,weapon)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.hasWeapon(weapon) then
		TriggerClientEvent('esx:showNotification', source, 'Bạn đã sở hữu súng này')
		cb(false)
	else
	
    for k,v in ipairs(Config.weapons) do
        if v.weapon==weapon then
               cb(xPlayer.getMoney()>=v.price)
            if xPlayer.getMoney()>=v.price then 
			   xPlayer.removeMoney(v.price) 
			   xPlayer.addWeapon(v.weapon,20)
		
			end
        end
    end
	end
end)

ESX.RegisterServerCallback("fn_weaponshop:buyWeaponTint",function(source,cb,weapon,tint)
    local xPlayer = ESX.GetPlayerFromId(source)
    for k,v in ipairs(Config.weapons) do
        if v.weapon==weapon then
            for kk,vv in ipairs(v.tints) do
                if vv.index==tint then
                    cb(xPlayer.getMoney()>=vv.price)
                    if xPlayer.getMoney()>=vv.price then 
					   xPlayer.removeMoney(vv.price) 
					   xPlayer.setWeaponTint(weapon, tint)
					   print(tint)
					   print(weapon)
					end
                end
            end
        end
    end
end)

ESX.RegisterServerCallback("fn_weaponshop:buyAmmo",function(PlayerId,cb,weapon,ammo)
    local xPlayer = ESX.GetPlayerFromId(PlayerId)
    for k,v in pairs(Config.weapons) do
        if v.weapon==weapon then
            
            if xPlayer.getMoney()>=v.ammo_price then 
				cb(true)
				xPlayer.removeMoney(tonumber(v.ammo_price))
				xPlayer.addWeaponAmmo(v.weapon,tonumber(ammo))
			else
				cb(false)
			end
        end
    end
end)


ESX.RegisterServerCallback("fn_weaponshop:buyWeaponComponent",function(source,cb,weapon,component)
    local xPlayer = ESX.GetPlayerFromId(source)
	local weaponNum, weaponData = ESX.GetWeapon(weapon)
	local comhash = GetHashKey(component)
	for m,n in ipairs(weaponData.components) do 
	   if n.hash == comhash then
	     name = n.label
		 composname = n.name
	   end
	   
    end	  
	
    for k,v in ipairs(Config.weapons) do
        if v.weapon==weapon then
            for kk,vv in ipairs(v.upgrades) do
                if vv.hash==component then
                    cb(xPlayer.getMoney()>=vv.price)
                    if xPlayer.getMoney()>=vv.price then 
					   xPlayer.removeMoney(vv.price) 
					   print(component)
					   print(composname)
					   xPlayer.addWeaponComponent(v.weapon,composname)
					end
                end
            end
        end
    end
end)