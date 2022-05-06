ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('burgerGame:PayCheck')
AddEventHandler('burgerGame:PayCheck', function(price)
	local _source 	= source
	local xPlayer		= ESX.GetPlayerFromId(_source)
	
	TriggerClientEvent('ESX:Notify',source,"Bạn vừa nhận được tiền công hôm nay là $"..price,"info")
	xPlayer.addMoney(price)
end)