ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj 
	TriggerClientEvent('chat:addMessage', -1, _U('me_prefix', name), args, { 255, 0, 0 })
end)
local playerarray = {}


AddEventHandler('playerArray',function(phonenumber)
		playerarray = phonenumber
end)
function HasRole(jobName)
	for k, v in pairs(Config.Job) do 
		if jobName == k then 
			return v 
		end 
	end
	return false
end
-- AddEventHandler('chatMessage', function(source,name, message)
	-- if string.sub(message, 1, string.len('/')) ~= '/' then
		-- CancelEvent()
		-- if Config.EnableESXIdentity then
			-- name = GetCharacterName(source)
		-- end			
		-- local xPlayer = ESX.GetPlayerFromId(source)
		-- local name = xPlayer.getName()
		-- local jobName = xPlayer.job.name
		-- --local jobName2 = xPlayer.gang.name
		-- local jobLabel = HasRole(jobName)
		-- local jobLabel2 = HasRole(jobName2)
		-- if jobLabel ~= false then
			-- TriggerClientEvent('chat:addMessage', -1, { 
				-- template = jobLabel.template,
				-- args = { jobLabel.label .. name, message }, color = { 255, 255, 255 } 
			-- })
		-- else
			-- -- if jobLabel2 ~= false then
				-- -- TriggerClientEvent('chat:addMessage', -1, { 
					-- -- --template = jobLabel.template,
					-- -- args = { jobLabel2.label .. name, message }, color = { 255, 255, 255 } 
				-- -- })
			-- -- else
				-- TriggerClientEvent('chat:addMessage', -1, { 
					-- --template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(153, 51, 0, 0.5); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',
					-- args = {  " Cư Dân | ^2" .. name, message }, color = { 255, 255, 255 } 
				-- })
			-- --end
		-- end
	-- end
-- end)

RegisterCommand('ooc', function(source, args, rawCommand)
  if source == 0 then
    print('esx_rpchat: you CancelEvent\'t use this command from rcon!')
    return
  end
  
  args = table.concat(args, ' ')
  local name = GetPlayerName(source)
	
	if string.sub(args, 1, string.len('/')) ~= '/' then
		CancelEvent()
		if Config.EnableESXIdentity then
			name = GetCharacterName(source)
		end			
		local xPlayer = ESX.GetPlayerFromId(source)
		local name = xPlayer.getName()
		local jobName = xPlayer.job.name
		--local jobName2 = xPlayer.gang.name
		local jobLabel = HasRole(jobName)
		local jobLabel2 = HasRole(jobName2)
		if jobLabel ~= false then
			TriggerClientEvent('chat:addMessage', -1, { 
				template = jobLabel.template,
				args = { jobLabel.label .. name, args }, color = { 255, 255, 255 } 
			})
		else
			-- if jobLabel2 ~= false then
				-- TriggerClientEvent('chat:addMessage', -1, { 
					-- --template = jobLabel.template,
					-- args = { jobLabel2.label .. name, message }, color = { 255, 255, 255 } 
				-- })
			-- else
				
				TriggerClientEvent('chat:addMessage', -1, { 
					template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(153, 51, 0, 0.5); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',
					args = {  " Cư Dân | ^2" .. name, args }, color = { 255, 255, 255 } 
				})
			--end
		end
	end
	
  
  
  print(('CHAT: %s: %s'):format(name, args))
end, false)




 AddEventHandler('chatMessageP', function(source,name, message)
	if string.sub(message, 1, string.len('/')) ~= '/' then
		CancelEvent()
		
		if Config.EnableESXIdentity then
			name = GetCharacterName(source)
		end			
			local xPlayer = ESX.GetPlayerFromId(source)
			local name = xPlayer.getName()
			str = xPlayer.job.name
			str = str:gsub("^%l", string.upper)
			--str2 = xPlayer.job2.name
			--str2 = str2:gsub("^%l", string.upper)
			if(str == 'Police') then
				local xPlayers = ESX.GetPlayers()
				for i=1, #xPlayers, 1 do
					local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer2.job.name == 'police' then 
						xPlayer2.triggerEvent('chat:addMessageP', { 
							template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(64, 101, 243, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',
							args = {  "Cảnh Sát | " .. name, message }, color = { 255, 255, 255 } 
						})
					end
				end
			end		
	end
end)

AddEventHandler('chatMessageM', function(source,name, message)
	if string.sub(message, 1, string.len('/')) ~= '/' then
		CancelEvent()
		
		if Config.EnableESXIdentity then
			name = GetCharacterName(source)
		end			
			local xPlayer = ESX.GetPlayerFromId(source)
			local name = xPlayer.getName()
			str = xPlayer.job.name
			str = str:gsub("^%l", string.upper)
			--str2 = xPlayer.job2.name
			--str2 = str2:gsub("^%l", string.upper)
			if(str == 'Ambulance') then
				local xPlayers = ESX.GetPlayers()
				for i=1, #xPlayers, 1 do
					local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer2.job.name == 'ambulance' then 
						xPlayer2.triggerEvent('chat:addMessageM', { 
							template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(255, 5, 171, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',		
							args = {"Bác Sĩ | " .. name, message }, color = { 255, 255, 255 } 
						})
					end
				end
			end
	end
end)

AddEventHandler('chatMessageG', function(source,name, message)
	if string.sub(message, 1, string.len('/')) ~= '/' then
		CancelEvent()
		
		if Config.EnableESXIdentity then
			name = GetCharacterName(source)
		end			
			local xPlayer = ESX.GetPlayerFromId(source)
			local name = xPlayer.getName()
			str = xPlayer.job.name
			str = str:gsub("^%l", string.upper)
			--str2 = xPlayer.job2.name
			--str2 = str2:gsub("^%l", string.upper)
			if str2 ~= 'Unemployed2' then
				local xPlayers = ESX.GetPlayers()
				for i=1, #xPlayers, 1 do
					local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer2.job.name == 'mechanic' then 
						xPlayer2.triggerEvent('chat:addMessageG', { 
							template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(255, 5, 171, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',		
							args = {"Cứu hộ | " .. name, message }, color = { 255, 255, 255 } 
						})
					end
				end
			end
	end
end)

-- AddEventHandler('chatMessageP', function(source,name, message)
	-- if string.sub(message, 1, string.len('/')) ~= '/' then
		-- CancelEvent()
		
		-- if Config.EnableESXIdentity then
			-- name = GetCharacterName(source)
		-- end			
			-- local xPlayer = ESX.GetPlayerFromId(source)
			-- local name = xPlayer.getName()
			-- str = xPlayer.job.name
			-- str = str:gsub("^%l", string.upper)
			-- --str2 = xPlayer.job2.name
			-- --str2 = str2:gsub("^%l", string.upper)
			-- if(str == 'Police') then
				-- local xPlayers = ESX.GetPlayers()
				-- for i=1, #xPlayers, 1 do
					-- local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])
					-- if xPlayer2.job.name == 'police' then 
						-- xPlayer2.triggerEvent('chat:addMessageP', { 
							-- template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(64, 101, 243, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',
							-- args = {  "Cảnh Sát | " .. name, message }, color = { 255, 255, 255 } 
						-- })
					-- end
				-- end
			-- end
	-- end
-- end) 

RegisterCommand('twt', function(args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.3vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}:<br> {1}</div>',
		args = { _U('twt_prefix', name), args }, color = { 0, 153, 204 } })
	--print(('%s: %s'):format(name, args))
end, false)







function GetCharacterName(source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})

	if result[1] and result[1].firstname and result[1].lastname then
		if Config.OnlyFirstname then
			return result[1].firstname
		else
			return ('%s %s'):format(result[1].firstname, result[1].lastname)
		end
	else
		return GetPlayerName(source)
	end
end
