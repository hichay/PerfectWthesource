
ESX = nil
TriggerEvent(Config.SharedObject, function(obj) ESX = obj end)



if Config.ESX12 then 
	ESX.RegisterCommand(Config.Command, 'admin', function(xPlayer, args, showError)
	if args.playerId.playerId and GetPlayerName(args.playerId.playerId) ~= nil and args.skin then		
		TriggerEvent('moons_skin:checkPlayerSkin', xPlayer, args.playerId.playerId, args.skin) 
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid player ID or actions count.' } } )
	end
	end, true, {help = '', validate = false, arguments = {
        {name = 'playerId', help = 'PlayerId', type = 'player'},
		{name = 'skin', help = 'Name of skin', type = 'any'}
 }})
else
	TriggerEvent('es:addGroupCommand', Config.Command, 'admin', function(source, args, user)
	if start then
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		if xPlayer then
			local id = tonumber(args[1])
			local skin = tostring(args[2])
			Citizen.Wait(100)
			if id == nil or id == '' then
				CancelEvent()
			else
				if GetPlayerName(id) == nil then
					CancelEvent()
					return
				else
					if skin == nil or skin == '' then
						CancelEvent()
					else
						TriggerEvent('moons_skin:checkPlayerSkin', _source ,id, skin)
					end

				end

			end
		end
	end

	end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
	end, {help = 'Add Player Skin', params = {{name = 'id', help = 'the ID of the player'}, {name = 'skin', help = 'Skin name'}}})
	
end
-- ESX.RegisterCommand(Config.Command, 'admin', function(xPlayer, args, showError)
	-- if args.playerId.playerId and GetPlayerName(args.playerId.playerId) ~= nil and args.skin then		
		-- TriggerEvent('moons_skin:checkPlayerSkin', xPlayer, args.playerId.playerId, args.skin) 
	-- else
		-- TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid player ID or actions count.' } } )
	-- end
-- end, true, {help = '', validate = false, arguments = {
        -- {name = 'playerId', help = 'PlayerId', type = 'player'},
		-- {name = 'skin', help = 'Name of skin', type = 'any'}
 -- }})


RegisterServerEvent('moons_skin:checkPlayerSkin')
AddEventHandler('moons_skin:checkPlayerSkin', function(source, id, skin)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(id)
		
	local identifier = xPlayer.identifier
	local user_skin = MySQL.Sync.fetchAll('SELECT COUNT(`skin`) AS `check` FROM `user_skin` WHERE `skin` = @skin AND `identifier` = @identifier', {
		['@skin'] = skin,
		['@identifier'] = identifier
	})

	if user_skin[1].check > 0 then
		if Config.Usepnotify then
			TriggerClientEvent('pNotify:SendNotification', _source, {
				text = _U('already_have'),
				type = 'info',
				queue = 'left',
				timeout = 2000,
				layout = 'centerLeft'
			})
		else
			xPlayer.showNotification(_U('already_have'))
		end
	else
		TriggerClientEvent('moons_skin:addskin', id, skin, 'add', _source, id)
	end	
end)

RegisterServerEvent('moons_skin:alert')
AddEventHandler('moons_skin:alert', function(adminid, message, stype)
	if adminid and message and stype then
		TriggerClientEvent('pNotify:SendNotification', adminid, {
			text = message,
			type = stype,
			queue = 'left',
			timeout = 2000,
			layout = 'centerLeft'
		})
	end
end)


RegisterServerEvent('moons_skin:saveskin')
AddEventHandler('moons_skin:saveskin', function(skin)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = xPlayer.identifier
	MySQL.Async.execute('UPDATE `users` SET `user_skin` = @skin WHERE `identifier` = @identifier', {
		['@skin'] = skin,
		['@identifier'] = identifier
	})
end)


RegisterServerEvent('moons_skin:addskins')
AddEventHandler('moons_skin:addskins', function(skin)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = xPlayer.identifier
	MySQL.Async.execute('INSERT INTO `user_skin` (`identifier`, `skin`) VALUES (@identifier, @skin)', {
		['@skin'] = skin,
		['@identifier'] = identifier
	})
end)

ESX.RegisterServerCallback('moons_skin:getskin', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local identifier = xPlayer.identifier
	local result = MySQL.Sync.fetchAll('SELECT `user_skin` FROM `users` WHERE `identifier` = @identifier', {
		['@identifier'] = identifier
	})
	if result then
		cb(result[1].user_skin)
	end
end)

ESX.RegisterServerCallback('moons_skin:getPlayerSkinList', function(source, cb)
	local _source = source
	local data = {}
	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = xPlayer.identifier
	local result = MySQL.Sync.fetchAll('SELECT * FROM `user_skin` WHERE `identifier` = @identifier', {
		['@identifier'] = identifier
	})
	if result then
		for i=1, #result, 1 do
			table.insert(data, {
				skin = result[i].skin
			})
		end
		cb(data)
	end
	
end)

ESX.RegisterServerCallback('moons_skin:checkPlayerHaveSkin', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = xPlayer.identifier
	local data = 0
	local result = MySQL.Sync.fetchAll('SELECT * FROM `user_skin` WHERE `identifier` = @identifier', {
		['@identifier'] = identifier
	})
	if result then
		for i=1, #result, 1 do
			data = data + 1
		end
		cb(data)
	end
end)


