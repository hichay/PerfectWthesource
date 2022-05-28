ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('hunting:GetVaildZone', function(source, cb)
	local vailzone = {
		"Mount Chiliad",
		"Chiliad Mountain State Wilderness",
	}
	
		
    cb(vailzone)
end)

RegisterServerEvent("hunting:GetItem")
AddEventHandler("hunting:GetItem", function(id,animalname,illegal)
	--local chance = math.random(1,100)
	--print(id)
	if illegal == true then
		chance = math.random(1,100)
		
		if (animalname == "Panther" or animalname == "Mountain-Lion") and chance < 80 then 
			TriggerClientEvent("player:receiveItem",source,"huntingcarcass4",1)
			if chance < 10 then 
				TriggerClientEvent("player:receiveItem",source,"cpelt",1)
			elseif chance < 5 then
				TriggerClientEvent("player:receiveItem",source,"ctooth",1)
			end	
		elseif (animalname == "Panther" or animalname == "Mountain-Lion" ) then
			local chance = math.random(1,100)
			if chance > 90 then 
				TriggerClientEvent("player:receiveItem",source,"huntingcarcass3",1)
			end
			
			if chance < 90 and chance > 50 then
				
				TriggerClientEvent("player:receiveItem",source,"huntingcarcass2",1)
			else
				TriggerClientEvent("player:receiveItem",source,"huntingcarcass1",1)
			end
		end
		
	else
		chance = math.random(1,100)
		--print('true')
		if animalname == "Deer" and chance > 98 then
			print('flase')
			TriggerClientEvent("player:receiveItem",source,"huntingcarcass3",1)
			TriggerClientEvent("player:receiveItem",source,"antlers",1)
		elseif animalname == "Deer" and (chance < 95 and chance > 85) then
			TriggerClientEvent("player:receiveItem",source,"dhide",1)
			TriggerClientEvent("player:receiveItem",source,"huntingcarcass3",1)
		end
		
		if chance < 90 and chance > 70 then 
			TriggerClientEvent("player:receiveItem",source,"huntingcarcass3",1)
		elseif chance < 70 and chance > 40 then
			TriggerClientEvent("player:receiveItem",source,"huntingcarcass2",1)
		elseif chance < 40 and chance > 0 then
			TriggerClientEvent("player:receiveItem",source,"huntingcarcass1",1)
		end
		
		if animalname == "Boar" and chance > 90 then 
			TriggerClientEvent("player:receiveItem",source,"huntingcarcass3",1)
		elseif animalname == "Boar" and (chance < 90 and chance > 70) then 
			TriggerClientEvent("player:receiveItem",source,"huntingcarcass2",1)
		else
			TriggerClientEvent("player:receiveItem",source,"huntingcarcass1",1)
		end
		
		if animalname == "Rabbit"then 						
			TriggerClientEvent("player:receiveItem",source,"freshmeat",math.random(1,10))
			TriggerClientEvent("player:receiveItem",source,"rpelt",1)
		end
	end
	

end)


RegisterServerEvent('pw-hunting:Payout')
AddEventHandler('pw-hunting:Payout', function(cash)	
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addMoney(cash)
	TriggerEvent("ESX:Notify",source,"Bạn vừa kiếm được " ..cash.. "$","success")
end)