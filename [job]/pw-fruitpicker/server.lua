ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('pw-fruitpicker:checkMoney', function(playerId, cb)
	local xPlayer = ESX.GetPlayerFromId(playerId)
    local name = ESX.GetPlayerFromId(playerId)

	if xPlayer.getMoney() >= Config.DepositPrice then
        xPlayer.removeMoney(Config.DepositPrice)
		cb(true)
    elseif xPlayer.getAccount('money').money >= Config.DepositPrice then
        xPlayer.removeAccountMoney('money', Config.DepositPrice)
        cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('pw-fruitpicker:depositBack')
AddEventHandler('pw-fruitpicker:depositBack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local Payout = Config.DepositPrice
	
	xPlayer.addAccountMoney('money', Config.DepositPrice)
end)

RegisterServerEvent('pw-fruitpicker:Payout')
AddEventHandler('pw-fruitpicker:Payout', function(arg)	
	local xPlayer = ESX.GetPlayerFromId(source)
	local Payout = Config.Payout * arg
	
	xPlayer.addMoney(Payout)
	TriggerEvent("ESX:Notify",src,"Bạn vừa kiếm được " ..Payout.. "$","success")
end)