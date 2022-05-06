ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem("maleseed", function(source, item)
	local src = source
    --local Player = RLCore.Functions.GetPlayer(src)
  
	TriggerClientEvent("truckrobbery:gruppeCard", src)
end)

RegisterServerEvent('truckrobbery:addItem')
AddEventHandler('truckrobbery:addItem', function(item, count)
	local src = source
    --local Player = RLCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(item, count)  
    dclog(Player, 'Received the following from the bank truck. **Gain**: '..item.. ' x'.. count)
end)

RegisterServerEvent("truckrobbery:removeItem")
AddEventHandler("truckrobbery:removeItem", function(item, count) 
	local src = source
    --local Player = RLCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, count) 
end)

RegisterServerEvent('truckrobbery:addMoney')
AddEventHandler('truckrobbery:addMoney', function(count)
	local src = source
	print('add money')
    --local Player = RLCore.Functions.GetPlayer(src)
    --Player.Functions.AddMoney("cash", count)
    --TriggerClientEvent('RLCore:Notify', Player.src, "Cash added: $" ..count, "error")
    --dclog(Player, 'Cash recieved. **Gain**: '..count..'$')
end)

RegisterServerEvent('truckrobbery:PlateLog')
AddEventHandler('truckrobbery:PlateLog', function(plate) 
	local src = source
    --local Player = RLCore.Functions.GetPlayer(src)
	print('this log')
    --dclog(Player, 'Bank truck with the following plate has been robbed. **Plate**: '.. tostring(plate))
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
      ["username"] = "Brinks Vehicle Robbery Log",
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

function System(str)
    local replacements = {
        ['&' ] = '&amp;',
        ['<' ] = '&lt;',
        ['>' ] = '&gt;',
        ['\n'] = '<br/>'
    }

    return str
        :gsub('[&<>\n]', replacements)
        :gsub(' +', function(s)
            return ' '..('&nbsp;'):rep(#s-1)
    end)
end