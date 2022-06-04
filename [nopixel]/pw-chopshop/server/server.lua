ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RPC.register('pw-chopshop:chopTheVehicle',function(src, netId, vehicleModel, boneType)
	local randomnumber = math.random(100)
	if boneType == 'tyre' then 
		if randomnumber >= 1 and randomnumber <= 45 then 
			TriggerClientEvent("player:receiveItem",source,"rubber",1)
		elseif randomnumber >= 46 and randomnumber <= 90 then 
			TriggerClientEvent("player:receiveItem",source,"plastic",1)
		elseif randomnumber >= 91 and randomnumber <= 100 then 
			TriggerClientEvent("player:receiveItem",source,"aluminium",1)
		end
	elseif boneType == 'door' then 
		if randomnumber >= 1 and randomnumber <= 45 then 
			TriggerClientEvent("player:receiveItem",source,"glass",1)
		elseif randomnumber >= 46 and randomnumber <= 90 then 	
			TriggerClientEvent("player:receiveItem",source,"scrapmetal",1)
		elseif randomnumber >= 91 and randomnumber <= 100 then 
			TriggerClientEvent("player:receiveItem",source,"steel",1)
		end

	elseif boneType == 'remains' then
		if randomnumber >= 1 and randomnumber <= 70 then 
			TriggerClientEvent("player:receiveItem",source,"copper",1)
			TriggerClientEvent("player:receiveItem",source,"plastic",1)
			TriggerClientEvent("player:receiveItem",source,"rubber",1)
			TriggerClientEvent("player:receiveItem",source,"scrapmetal",1)
			TriggerClientEvent("player:receiveItem",source,"glass",1)
		elseif randomnumber >= 71 and randomnumber <= 80 then 
			TriggerClientEvent("player:receiveItem",source,"aluminium",1)
		elseif randomnumber >= 81 and randomnumber <= 90 then 	
			TriggerClientEvent("player:receiveItem",source,"steel",1)
		elseif randomnumber >= 91 and randomnumber <= 100 then 
			TriggerClientEvent("player:receiveItem",source,"electronics",1)

		end

	end


end)