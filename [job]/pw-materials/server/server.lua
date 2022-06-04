ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Code

ESX.RegisterServerCallback('pw-materials:server:is:vehicle:owned', function(source, cb, plate)
    exports['ghmattimysql']:execute("SELECT * FROM `owned_vehicles` WHERE `plate` = '"..plate.."'", function(result)
        if result[1] ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(10000, CountCops)
end

CountCops()

RegisterServerEvent('pw-materials:server:policeAlert')
AddEventHandler('pw-materials:server:policeAlert', function(data, customcoords)
    if customcoords ~= nil then data.coords = customcoords end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job = 'police', 
        coords = data.coords,
        title = 'Cạy máy đỗ xe công cộng',
        message = 'Đối tượng đang hiện ở '..data.street_1..', '..data.street_2 ..''  , 
        flash = 0, 
        blip = {
            sprite = 431, 
            scale = 1.2, 
            colour = 3,
            flashes = false, 
            text = 'Ăn trộm đỗ xe',
            time = (1*60*1000),
            sound = 1,
        }
    })
end)

RegisterServerEvent('pw-materials:server:crackget:reward')
AddEventHandler('pw-materials:server:crackget:reward', function()
	local Player = ESX.GetPlayerFromId(source)
	local RandomValue = math.random(1, 100)
	if CopsConnected >= 2 then
		--if RandomValue <= 55 then 
		TriggerClientEvent("player:receiveItem",source,"cashroll",math.random(1,1))
		--else
			--TriggerClientEvent("ESX:Notify",source,"Không có gì ở trong","error")
		--end
	else
		TriggerClientEvent("ESX:Notify",src,"Đang không có đủ 2 cảnh sát online")
	end
end)


RegisterServerEvent('pw-materials:server:get:reward')
AddEventHandler('pw-materials:server:get:reward', function()
    local Player = ESX.GetPlayerFromId(source)
    local RandomValue = math.random(1, 100)
    local RandomItems = Config.BinItems[math.random(#Config.BinItems)]
    if RandomValue <= 55 then
     --Player.Functions.AddItem(RandomItems, math.random(8, 20))
	 TriggerClientEvent("player:receiveItem",source,RandomItems,math.random(1, 3))
     --TriggerClientEvent('fw-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items[RandomItems], 'add')
    -- elseif RandomValue >= 87 and RandomValue <= 89 then
        -- local SubValue = math.random(1, 3)
        -- if SubValue == 1 then
            -- --Player.Functions.AddItem('knife-part-1', 1)
            -- --TriggerClientEvent('fw-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['knife-part-1'], 'add')
        -- elseif SubValue == 2 then
            -- --Player.Functions.AddItem('switch-part-1', 1)
            -- --TriggerClientEvent('fw-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['switch-part-1'], 'add')
        -- else
            -- --Player.Functions.AddItem('rifle-clip', 1)
            -- --TriggerClientEvent('fw-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['rifle-clip'], 'add')
        -- end
    else
        TriggerClientEvent('ESX:Notify', source, 'Không có gì!', 'error')
    end
end)

RegisterServerEvent('pw-materials:server:recycle:reward')
AddEventHandler('pw-materials:server:recycle:reward', function()
  local Player = ESX.GetPlayerFromId(source)
  for i = 1, math.random(2, 5), 1 do
      local Items = Config.CarItems[math.random(1, #Config.CarItems)]
      local RandomNum = math.random(10, 15)
      --Player.Functions.AddItem(Items, RandomNum)
      --TriggerClientEvent('fw-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items[Items], 'add')
      Citizen.Wait(500)
  end
  if math.random(1, 100) <= 20 then
    --Player.Functions.AddItem('rubber', math.random(20, 30))
    --TriggerClientEvent('fw-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['rubber'], 'add')
  end
end)

