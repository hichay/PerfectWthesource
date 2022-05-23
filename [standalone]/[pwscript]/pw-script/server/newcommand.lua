ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



-- ESX.RegisterCommand('duatien', 'user', function(xPlayer, args, showError)
	-- local _source = source
	-- TriggerClientEvent("pw-scripts:client:Duatien",xPlayer.source , args.playerId, args.amount)
-- end, true, {help = 'Lệnh đưa tiền mặt', validate = true, arguments = {
	-- {name = 'playerId', help = 'Id người nhận', type = 'idcard'},
	-- {name = 'amount', help = "Số tiền", type = 'number'}
-- }})
RegisterCommand('duatien', function(source, args, rawCommand)
    
    TriggerClientEvent("pw-scripts:client:Duatien",source , args[1], args[2])
end)


ESX.RegisterCommand('duatien1', 'user', function(xPlayer, args)
	TriggerClientEvent("pw-scripts:client:Duatien",source, args.id, args.money)
end, false, {help = "add thêm garage nhà", validate = true, arguments = {
    {name = 'id', help = "Id người chơi", type = 'idcard'},
    {name = 'money', help = "số tiền", type = 'number'}
}})



RegisterServerEvent('pw-scripts:server:Duatien')
AddEventHandler('pw-scripts:server:Duatien', function(amount,playerId)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)

	local Target = ESX.GetPlayerFromId(playerId)
	if (Target == nil or Target == -1 )then
		TriggerEvent("ESX:Notify",source,"Không tồn tại người này","error")
	else
		sourcemoney = sourceXPlayer.getAccounts('money').money
			if sourcemoney > ammount then
				sourceXPlayer.removeAccountMoney('money', tonumber(ammount))
				Target.addAccountMoney('money', tonumber(ammount))
				TriggerClientEvent('ESX:Notify',source,"Bạn vừa đưa cho "..Target.getName().." số tiền là: "..ammount.."$","info")
				TriggerClientEvent('ESX:Notify',Target.source,"Bạn vừa nhận tiền từ "..sourceXPlayer.getName().." với số tiền là: "..ammount.."$","info")
			else
				TriggerEvent("ESX:Notify",source,"Không đủ tiền mặt trên người","error")
			end
	end
end)