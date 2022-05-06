ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local timeOut = false
local isintimeout = false
local alarmTriggered = false

RegisterServerEvent('rl-jewellery:server:setVitrineState')
AddEventHandler('rl-jewellery:server:setVitrineState', function(stateType, state, k)
    Config.Locations[k][stateType] = state
    TriggerClientEvent('rl-jewellery:client:setVitrineState', -1, stateType, state, k)
end)

RegisterServerEvent('rl-jewellery:server:vitrineReward')
AddEventHandler('rl-jewellery:server:vitrineReward', function()
    local src = source
--    local Player = RLCore.Functions.GetPlayer(src)
	print('add rolex to player')
    -- if Player.Functions.AddItem("rolex", math.random(4, 6)) then
        -- TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items["rolex"], 'add')
		
    -- else
        -- TriggerClientEvent('RLCore:Notify', src, 'You dont have space on your bag', 'error')
    -- end
end)

RegisterServerEvent('rl-jewellery:server:setTimeout')
AddEventHandler('rl-jewellery:server:setTimeout', function()
    if not timeOut then
        timeOut = true
        Citizen.CreateThread(function()
            Citizen.Wait(Config.Timeout)

            for k, v in pairs(Config.Locations) do
                Config.Locations[k]["isOpened"] = false
                TriggerClientEvent('rl-jewellery:client:setVitrineState', -1, 'isOpened', false, k)
                TriggerClientEvent('rl-jewellery:client:setAlertState', -1, false)
                TriggerClientEvent('rl-jewellery:client:resetCameras', -1)
            end
            timeOut = false
            alarmTriggered = false
        end)
    end
end)

ESX.RegisterServerCallback('rl-jewellery:server:getCops', function(source, cb)
	local amount = 0
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			amount = amount + 1
		end
	end
	
    -- for k, v in pairs(RLCore.Functions.GetPlayers()) do
        -- local Player = RLCore.Functions.GetPlayer(v)
        -- if Player ~= nil then 
            -- if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                -- amount = amount + 1
            -- end
        -- end
	-- end
	cb(amount)
end)

RegisterServerEvent('rl-jewellery:server:startglobaltimeout')
AddEventHandler('rl-jewellery:server:startglobaltimeout', function()
    isintimeout = true
    TriggerClientEvent('lkjasdlksa:syncclientnoder', -1, true)
    CreateThread(function()
        Wait(60000 * 120) -- 2 hrs
        isintimeout = false
        TriggerClientEvent('lkjasdlksa:syncclientnoder', -1, false)
    end)
end)

ESX.RegisterServerCallback('rl-jewellery:gettimeoutstatus', function(source, cb)
	cb(isintimeout)
end)

function dclog(Player, text)
    local playerName = System(Player.getName())
   
    local discord_webhook = Config.DiscordWebhook
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "Jewelery Robbery Log",
      ["embeds"] = {{
        ["author"] = {
          ["name"] = playerName .. ' - ' .. Player.identifier
        },
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
      }}
    }
    data['embeds'][1]['description'] = text
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end