ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('thugnhiena:checkMoney', function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
    local name = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 1000 then
        xPlayer.removeMoney(1000)
		cb(true)
    elseif xPlayer.getAccount('bank').money >= 1000 then
        xPlayer.removeAccountMoney('bank', 1000)
        cb(true)
	else
		cb(false)
	end
end)


ESX.RegisterServerCallback('layxe:checkMoney', function(source,price,cb)
	print(price)
	local xPlayer = ESX.GetPlayerFromId(source)
    local name = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 1000 then
        xPlayer.removeMoney(1000)
		cb(true)
    elseif xPlayer.getAccount('bank').money >= 1000 then
        xPlayer.removeAccountMoney('bank', 1000)
        cb(true)
	else
		cb(false)
	end
end)