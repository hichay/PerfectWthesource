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

RegisterServerEvent('pw-materials:server:scrap:reward')
AddEventHandler('pw-materials:server:scrap:reward', function(class)
  local Player = ESX.GetPlayerFromId(source)
  if class == 'A' then
		randomnumb = math.random(1,100)
		if randomnumb >= 1 and randomnumb < 5 then 
			local randomnn = math.random(1,5)
			if randomnn == 1 then
				TriggerClientEvent("player:receiveItem",source,"axleparta",1)
			elseif randomnn == 2 then
				TriggerClientEvent("player:receiveItem",source,"bodypanela",1)
			elseif randomnn == 3 then
				TriggerClientEvent("player:receiveItem",source,"brakeparta",1)
			elseif randomnn == 4 then
				TriggerClientEvent("player:receiveItem",source,"clutchparta",1)
			elseif randomnn == 5 then
				TriggerClientEvent("player:receiveItem",source,"coolingparta",1)
			elseif randomnn == 6 then
				TriggerClientEvent("player:receiveItem",source,"electronicparta",1)
			elseif randomnn == 7 then
				TriggerClientEvent("player:receiveItem",source,"engineparta",1)	
			elseif randomnn == 8 then
				TriggerClientEvent("player:receiveItem",source,"fuelinjectora",1)	
			elseif randomnn == 9 then
				TriggerClientEvent("player:receiveItem",source,"tirekita",1)
			elseif randomnn == 10 then
				TriggerClientEvent("player:receiveItem",source,"transmissionparta",1)
			end
		end
				
		if randomnumb >= 5 and randomnumb < 20 then
			TriggerClientEvent("player:receiveItem",source,"scrapmetal",math.random(1,5))
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
			
		end
		
		if randomnumb >= 20 and randomnumb < 35 then
			TriggerClientEvent("player:receiveItem",source,"plastic",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
		
		if randomnumb >= 35 and randomnumb < 50 then
			TriggerClientEvent("player:receiveItem",source,"rubber",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
		
		if randomnumb >= 50 and randomnumb < 65 then
			TriggerClientEvent("player:receiveItem",source,"glass",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end

		if randomnumb >= 65 and randomnumb < 80 then
			TriggerClientEvent("player:receiveItem",source,"copper",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end

		if randomnumb >= 80 and randomnumb <= 100 then
			TriggerClientEvent("player:receiveItem",source,"electronics",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
	elseif class == 'B' then
	
		randomnumb = math.random(1,100)
		if randomnumb >= 1 and randomnumb < 5 then 
			local randomnn = math.random(1,5)
			if randomnn == 1 then
				TriggerClientEvent("player:receiveItem",source,"axlepartb",1)
			elseif randomnn == 2 then
				TriggerClientEvent("player:receiveItem",source,"bodypanelb",1)		
			elseif randomnn == 3 then
				TriggerClientEvent("player:receiveItem",source,"brakepartb",1)				
			elseif randomnn == 4 then
				TriggerClientEvent("player:receiveItem",source,"clutchpartb",1)	
			elseif randomnn == 5 then
				TriggerClientEvent("player:receiveItem",source,"coolingpartb",1)			
			elseif randomnn == 6 then
				TriggerClientEvent("player:receiveItem",source,"electronicpartb",1)			
			elseif randomnn == 7 then
				TriggerClientEvent("player:receiveItem",source,"enginepartb",1)			
			elseif randomnn == 8 then
				TriggerClientEvent("player:receiveItem",source,"fuelinjectorb",1)				
			elseif randomnn == 9 then
				TriggerClientEvent("player:receiveItem",source,"tirekitb",1)			
			elseif randomnn == 10 then
				TriggerClientEvent("player:receiveItem",source,"transmissionpartb",1)
			end
		end
		
		
		
		if randomnumb >= 5 and randomnumb < 20 then
			TriggerClientEvent("player:receiveItem",source,"scrapmetal",math.random(1,5))
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
		
		if randomnumb >= 20 and randomnumb < 35 then
			TriggerClientEvent("player:receiveItem",source,"plastic",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
		
		if randomnumb >= 35 and randomnumb < 50 then
			TriggerClientEvent("player:receiveItem",source,"rubber",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
		
		if randomnumb >= 50 and randomnumb < 65 then
			TriggerClientEvent("player:receiveItem",source,"glass",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
			
		end

		if randomnumb >= 65 and randomnumb < 80 then
			TriggerClientEvent("player:receiveItem",source,"copper",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end

		if randomnumb >= 80 and randomnumb <= 100 then
			TriggerClientEvent("player:receiveItem",source,"electronics",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
		
	elseif class == 'C' then
		
		randomnumb = math.random(1,100)
		if randomnumb >= 1 and randomnumb < 5 then 
			local randomnn = math.random(1,5)
			if randomnn == 1 then
				TriggerClientEvent("player:receiveItem",source,"axlepartc",1)
			elseif randomnn == 2 then
				TriggerClientEvent("player:receiveItem",source,"bodypanelc",1)		
			elseif randomnn == 3 then
				TriggerClientEvent("player:receiveItem",source,"brakepartc",1)				
			elseif randomnn == 4 then
				TriggerClientEvent("player:receiveItem",source,"clutchpartc",1)	
			elseif randomnn == 5 then
				TriggerClientEvent("player:receiveItem",source,"coolingpartc",1)			
			elseif randomnn == 6 then
				TriggerClientEvent("player:receiveItem",source,"electronicpartc",1)			
			elseif randomnn == 7 then
				TriggerClientEvent("player:receiveItem",source,"enginepartc",1)			
			elseif randomnn == 8 then
				TriggerClientEvent("player:receiveItem",source,"fuelinjectorc",1)				
			elseif randomnn == 9 then
				TriggerClientEvent("player:receiveItem",source,"tirekitc",1)			
			elseif randomnn == 10 then
				TriggerClientEvent("player:receiveItem",source,"transmissionpartc",1)
			end
		end
		
		if randomnumb >= 5 and randomnumb < 20 then
			TriggerClientEvent("player:receiveItem",source,"scrapmetal",math.random(1,5))
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
		
		if randomnumb >= 20 and randomnumb < 35 then
			TriggerClientEvent("player:receiveItem",source,"plastic",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
		
		if randomnumb >= 35 and randomnumb < 50 then
			TriggerClientEvent("player:receiveItem",source,"rubber",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
		
		if randomnumb >= 50 and randomnumb < 65 then
			TriggerClientEvent("player:receiveItem",source,"glass",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end

		if randomnumb >= 65 and randomnumb < 80 then
			TriggerClientEvent("player:receiveItem",source,"copper",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end

		if randomnumb >= 80 and randomnumb <= 100 then
			TriggerClientEvent("player:receiveItem",source,"electronics",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
		
	elseif class == 'D' then
	
		randomnumb = math.random(1,100)
		if randomnumb >= 1 and randomnumb < 5 then 
			local randomnn = math.random(1,5)
			if randomnn == 1 then
				TriggerClientEvent("player:receiveItem",source,"axlepartd",1)
			elseif randomnn == 2 then
				TriggerClientEvent("player:receiveItem",source,"bodypaneld",1)		
			elseif randomnn == 3 then
				TriggerClientEvent("player:receiveItem",source,"brakepartd",1)				
			elseif randomnn == 4 then
				TriggerClientEvent("player:receiveItem",source,"clutchpartd",1)	
			elseif randomnn == 5 then
				TriggerClientEvent("player:receiveItem",source,"coolingpartd",1)			
			elseif randomnn == 6 then
				TriggerClientEvent("player:receiveItem",source,"electronicpartd",1)			
			elseif randomnn == 7 then
				TriggerClientEvent("player:receiveItem",source,"enginepartd",1)			
			elseif randomnn == 8 then
				TriggerClientEvent("player:receiveItem",source,"fuelinjectord",1)				
			elseif randomnn == 9 then
				TriggerClientEvent("player:receiveItem",source,"tirekitd",1)			
			elseif randomnn == 10 then
				TriggerClientEvent("player:receiveItem",source,"transmissionpartd",1)
			end
		end
		
		if randomnumb >= 5 and randomnumb < 20 then
			TriggerClientEvent("player:receiveItem",source,"scrapmetal",math.random(1,5))
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
		
		if randomnumb >= 20 and randomnumb < 35 then
			TriggerClientEvent("player:receiveItem",source,"plastic",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
		
		if randomnumb >= 35 and randomnumb < 50 then
			TriggerClientEvent("player:receiveItem",source,"rubber",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
		
		if randomnumb >= 50 and randomnumb < 65 then
			TriggerClientEvent("player:receiveItem",source,"glass",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
			
		end

		if randomnumb >= 65 and randomnumb < 80 then
			TriggerClientEvent("player:receiveItem",source,"copper",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
			
		end

		if randomnumb >= 80 and randomnumb <= 100 then
			TriggerClientEvent("player:receiveItem",source,"electronics",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
			
		end
		
	elseif class == 'S' then
	
		randomnumb = math.random(1,100)
		if randomnumb >= 1 and randomnumb < 2 then 
			local randomnn = math.random(1,5)
			if randomnn == 1 then
				TriggerClientEvent("player:receiveItem",source,"axleparts",1)
			elseif randomnn == 2 then
				TriggerClientEvent("player:receiveItem",source,"bodypanels",1)		
			elseif randomnn == 3 then
				TriggerClientEvent("player:receiveItem",source,"brakeparts",1)				
			elseif randomnn == 4 then
				TriggerClientEvent("player:receiveItem",source,"clutchparts",1)	
			elseif randomnn == 5 then
				TriggerClientEvent("player:receiveItem",source,"coolingparts",1)			
			elseif randomnn == 6 then
				TriggerClientEvent("player:receiveItem",source,"electronicparts",1)			
			elseif randomnn == 7 then
				TriggerClientEvent("player:receiveItem",source,"engineparts",1)			
			elseif randomnn == 8 then
				TriggerClientEvent("player:receiveItem",source,"fuelinjectors",1)				
			elseif randomnn == 9 then
				TriggerClientEvent("player:receiveItem",source,"tirekits",1)			
			elseif randomnn == 10 then
				TriggerClientEvent("player:receiveItem",source,"transmissionparts",1)
			end
		end
		
		if randomnumb >= 2 and randomnumb < 20 then
			TriggerClientEvent("player:receiveItem",source,"scrapmetal",math.random(1,5))
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
		
		if randomnumb >= 20 and randomnumb < 35 then
			TriggerClientEvent("player:receiveItem",source,"plastic",math.random(1,5))
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
		
		if randomnumb >= 35 and randomnumb < 50 then
			TriggerClientEvent("player:receiveItem",source,"rubber",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
		
		if randomnumb >= 50 and randomnumb < 65 then
			TriggerClientEvent("player:receiveItem",source,"glass",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end

		if randomnumb >= 65 and randomnumb < 80 then
			TriggerClientEvent("player:receiveItem",source,"copper",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end

		if randomnumb >= 80 and randomnumb <= 100 then
			TriggerClientEvent("player:receiveItem",source,"electronics",math.random(1,5))
			
			local randonew = math.random(1,45)
			if randonew == 1 then 
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
			elseif randonew == 2 then 
				TriggerClientEvent("player:receiveItem",source,"sound",1)
			elseif randonew == 3 then 
				TriggerClientEvent("player:receiveItem",source,"carhood",1)
			elseif randonew == 4 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 5 then 
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 6 then 
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
			elseif randonew == 7 then 
				TriggerClientEvent("player:receiveItem",source,"seat",math.random(1,2))
			elseif randonew == 8 then 
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
			elseif randonew == 9 then 
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
			elseif randonew == 10 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 11 then 
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
			elseif randonew == 12 then 
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
			elseif randonew == 13 then 
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
			elseif randonew == 14 then 
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
			elseif randonew == 15 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
			elseif randonew == 16 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 17 then 
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",1)
				TriggerClientEvent("player:receiveItem",source,"spoiler",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 18 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 19 then 
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 20 then 
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"radiator",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 21 then
				TriggerClientEvent("player:receiveItem",source,"transmission",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"brakecar",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
			elseif randonew == 22 then
				TriggerClientEvent("player:receiveItem",source,"tire",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 23 then
				TriggerClientEvent("player:receiveItem",source,"axle",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fuelinjector",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"brakecar",1)
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"sound",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))	
			elseif randonew == 24 then
				TriggerClientEvent("player:receiveItem",source,"hlights",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"fbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"sskirts",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"rbumper",math.random(1,2))
				TriggerClientEvent("player:receiveItem",source,"spoiler",math.random(1,2))
			elseif randonew == 25 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
			elseif randonew == 26 then
				TriggerClientEvent("player:receiveItem",source,"engineblock",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			elseif randonew == 27 then
				TriggerClientEvent("player:receiveItem",source,"bodycar",1)
				TriggerClientEvent("player:receiveItem",source,"hlights",1)
				TriggerClientEvent("player:receiveItem",source,"sskirts",1)
				TriggerClientEvent("player:receiveItem",source,"rbumper",1)
				TriggerClientEvent("player:receiveItem",source,"fbumper",1)
			end
		end
	end	
end)