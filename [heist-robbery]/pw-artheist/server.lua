ESX = nil
local lastrob = 0

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

ESX.RegisterServerCallback('artheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = ESX.GetPlayers()
    local policeCount = 0

    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['ArtHeist']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        TriggerClientEvent("ESX:Notify",source,Strings['need_police'],"info")
    end
end)

ESX.RegisterServerCallback('artheist:server:checkRobTime', function(source, cb)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    
    if (os.time() - lastrob) < Config['ArtHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['ArtHeist']['nextRob'] - (os.time() - lastrob)
        player.showNotification(Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'])
        cb(false)
    else
        lastrob = os.time()
        cb(true)
    end
end)



--[[ RegisterNetEvent('artheist:server:policeAlert')
AddEventHandler('artheist:server:policeAlert', function(coords)
    local players = ESX.GetPlayers()
    
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            TriggerClientEvent('artheist:client:policeAlert', players[i], coords)
        end
    end
end) ]]

RegisterServerEvent('artheist:server:policeAlert')
AddEventHandler('artheist:server:policeAlert', function(data, customcoords)
    if customcoords ~= nil then data.coords = customcoords end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job = 'police', 
        coords = data.coords,
        title = 'Ăn cắp các bức tranh quý',
        message = 'Đối tượng đang hiện ở '..data.street_1..', '..data.street_2 ..''  , 
        flash = 0, 
        blip = {
            sprite = 431, 
            scale = 1.2, 
            colour = 3,
            flashes = false, 
            text = 'Ăn Cắp Tranh',
            time = (1*60*1000),
            sound = 1,
        }
    })
end)

RegisterServerEvent('artheist:server:syncHeistStart')
AddEventHandler('artheist:server:syncHeistStart', function()
    TriggerClientEvent('artheist:client:syncHeistStart', -1)
end)

RegisterServerEvent('artheist:server:syncPainting')
AddEventHandler('artheist:server:syncPainting', function(x)
    TriggerClientEvent('artheist:client:syncPainting', -1, x)
end)

RegisterServerEvent('artheist:server:syncAllPainting')
AddEventHandler('artheist:server:syncAllPainting', function()
    TriggerClientEvent('artheist:client:syncAllPainting', -1)
end)

RegisterServerEvent('artheist:server:rewardItem')
AddEventHandler('artheist:server:rewardItem', function(scene)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local item = scene['rewardItem']

    if player then
        --player.addInventoryItem(item, 1)
        TriggerClientEvent("player:receiveItem",source,item,1)
    end
end)


RegisterServerEvent('artheist:server:finishHeist')
AddEventHandler('artheist:server:finishHeist', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if player then
        for k, v in pairs(Config['ArtHeist']['painting']) do
            local count = player.getInventoryItem(v['rewardItem']).count
            if count > 0 then
                player.removeInventoryItem(v['rewardItem'], 1)
                TriggerClientEvent("inventory:removeItem",source,"cashroll",1)
                player.addMoney(v['paintingPrice'])
            end
        end
    end
end)