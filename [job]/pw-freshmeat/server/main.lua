ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('pw-freshmeat:reward')
AddEventHandler('pw-freshmeat:reward', function()

	TriggerClientEvent("player:receiveItem",source,"freshmeat",1,true,true)		
	
end)

