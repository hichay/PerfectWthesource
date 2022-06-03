ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('duatien', function(source, args, rawCommand)

    TriggerClientEvent("pw-scripts:client:Duatien",source , args[1], args[2])
end)


ESX.RegisterCommand('duatien1', 'user', function(xPlayer, args)
	xPlayer.triggerEvent('pw-scripts:client:Duatien', args.id, args.money)
end, false, {help = "add thêm garage nhà", validate = true, arguments = {
    {name = 'id', help = "Id người chơi", type = 'idcard'},
    {name = 'money', help = "số tiền", type = 'number'}
}})



RegisterServerEvent('pw-scripts:server:Duatien')
AddEventHandler('pw-scripts:server:Duatien', function(playerId,amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local Target = ESX.GetPlayerFromIdCard(playerId)
	if (Target == nil or Target == -1 )then
		TriggerEvent("ESX:Notify",source,"Không tồn tại người này","error")
	else
		sourcemoney = sourceXPlayer.getAccounts('money').money
			if sourcemoney >= tonumber(amount) then
				sourceXPlayer.removeAccountMoney('money', tonumber(amount))
				Target.addAccountMoney('money', tonumber(amount))
				TriggerClientEvent('ESX:Notify',source,"Bạn vừa đưa cho "..Target.getName().." số tiền là: "..amount.."$","info")
				TriggerClientEvent('ESX:Notify',Target.source,"Bạn vừa nhận tiền từ "..sourceXPlayer.getName().." với số tiền là: "..amount.."$","info")
			else
				TriggerEvent("ESX:Notify",source,"Không đủ tiền mặt trên người","error")
			end
	end
end)
