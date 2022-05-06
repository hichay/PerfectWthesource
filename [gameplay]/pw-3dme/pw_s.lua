ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('do', function(source,args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	TriggerClientEvent('u7x!A%D*', -1, source, args, "do")
end, false)

RegisterCommand('me', function(source ,args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	TriggerClientEvent('u7x!A%D*', -1, source, args, "me")
end, false)

