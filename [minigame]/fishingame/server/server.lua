ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('fishingGame:Banca')
AddEventHandler('fishingGame:Banca', function(price)
	local _source 	= source
	local xPlayer		= ESX.GetPlayerFromId(_source)
	

	xPlayer.addMoney(price)
end)

RegisterServerEvent('fishingGame:trathuyen')
AddEventHandler('fishingGame:trathuyen', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local Payout = 200
	
	xPlayer.addAccountMoney('money', Payout)
end)


RegisterServerEvent('fishingame:sendlog')
AddEventHandler('fishingame:sendlog', function(fishid,price)
	local _source 	= source
	local xPlayer		= ESX.GetPlayerFromId(_source)
	local sendToDiscord = "Người chơi "..xPlayer.getName(source).." vừa bán "..fishid.." và nhận được "..price.."$"
	
	TriggerEvent('moon_discordlogs:sendToDiscord','BanCa', sendToDiscord, source, '^1') 
end)


RegisterServerEvent('fishingame:sendlogcauduoc')
AddEventHandler('fishingame:sendlogcauduoc', function(fishname)
	local _source 	= source
	local xPlayer		= ESX.GetPlayerFromId(_source)
	local sendToDiscord = "Người chơi vừa câu được "..xPlayer.getName(source).." vừa nhận được "..fishname..""
	TriggerEvent('moon_discordlogs:sendToDiscord','Logca', sendToDiscord, source, '^1') 
end)