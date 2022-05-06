if Config == nil then 
    print(script_name .. ": Config is nil") 
	return 
end 
do 
	local function html_safe(str) 
		local output, t = str:gsub("[^%w]", function(chr) 
			return string.format("%%%X", string.byte(chr)) 
		end) 
		return 
		output 
	end 

	local  function build_param(url, tbl) 
		local param = "?"
		for k, v in pairs(tbl) do 
			param = param..k.."="..html_safe(v).."&"
		end 
		param = string.sub(param, 0, #param - 1) 
		return 
		(url..param) 
	end

	local script_name = GetCurrentResourceName()
	local script_active = false 
	local MoonAcceptLoadScript

	if GetCurrentResourceName()  ~= script_name then 
		print("Moon's: Unauthorized resource name changed. Please change to "..script_name.." for the best performance.") 
		return 
	end 
	
	if Config["license_key"] == nil or Config["license_key"] == "" then 
    print("Failed to load "..script_name.." because of license key is empty") return 
	end

	local run_connect 

	Citizen.CreateThread(function() 
		if Config == nil then print("Failed to load "..script_name.." because of the config is nil") 
			return 
		end 
		Citizen.Wait(4000) 

		local hostname = GetConvar("sv_hostname", "Unknown")
		local auth_date = os.date("%d%m%Y")
		local url = build_param("https://gamexua.tv/ls/", {request = Config["license_key"], script_name = script_name, client_name = hostname, auth_date = auth_date}) 
		local sc = "\x1b[42m\x1b[30m"..script_name.."\x1b[0m"
		local attempt = 1 
		run_connect = function() 
			PerformHttpRequest(url, function(err, text, headers) 
				local st = json.decode(text or "") 
				if st then 
					local col = "\x1b[32m"
					if st.status ~= 200 then 
						col = "\x1b[31m"
					end 
					print(col.."[Moon's]\x1b[0m "..sc.." - "..(st.desc or "Unknown State")) 
					if st.status == 200 then 
						MoonAcceptLoadScript(st) 
						TriggerClientEvent("moon_template:client:failsafe_"..script_name, -1) 
					end 
					run_connect = nil
				else 
						print("\x1b[32m[Moon's]\x1b[0m "..sc.." - couldn't connect to server. Contact to: discord.gg/Hcj8uGwKkg, \x1b[31mAttempt "..attempt..".\x1b[0m") if attempt >= 5 then 
						print("\x1b[32m[Moon's]\x1b[0m "..sc.." - failed to connect license server after "..attempt.." attempts. ")
							
						run_connect = nil
						Citizen.Wait(10000)
						StopResource(script_name)
						return 
					end 
					attempt = attempt + 1 
					Citizen.Wait(5000) 
					run_connect() 
				end 
			end, 'GET', '', {["Content-Type"] = 'application/json'}) 
		end 
		run_connect() 
	end) 

	RegisterServerEvent("moon_template:server:license_"..script_name) 
	AddEventHandler("moon_template:server:license_"..script_name, function() 
		TriggerClientEvent("moon_template:client:license_"..script_name, source, script_active) 
	end) 

	MoonAcceptLoadScript = function(st) 
		if st == nil or st.auth == nil or st.auth_date == nil then 
			print("\x1b[33m["..script_name.."]\x1b[0m ".."couldn't load script.") 
			return
		end 

		local function bxor(a, b)
			local r, m, s = 0, 2 ^ 52 
			repeat 
				s, a, b = a + b + m, a % m, b % m 
				r, m = r + m * 3 % (s - a - b), m / 2 
			until m < 1
			return r 
		end 

		local valid = (st.auth_date.."."..script_name)
		local de = ""
		for l in string.gmatch(st.auth, "...") do
			local n = tonumber(l) or 0
			local bxo = bxor(n, 0x11)
			de = de..string.char(bxo)
		end
		if valid ~= de then 
			print("\x1b[33m["..script_name.."]\x1b[0m ".."authentication failed! (SCRIPT BYPASS DETECTED)") 
			return 
		end 
		script_active = true 
		print("\x1b[33m["..script_name.."]\x1b[0m ".."initiating splinter sequence.") 

		-- ///////////////////////////////////////////////////////////////// --
        --  ##########            Add detail Script below         ########## --
        --  ##########            Add detail Script below         ########## --
        --  ##########            Add detail Script below         ########## --
        --  ##########            Add detail Script below         ########## --
        --  ##########            Add detail Script below         ########## --
        --  ##########            Add detail Script below         ########## --
        -- ///////////////////////////////////////////////////////////////// --
    

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
	print(identifier)
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

end
end



