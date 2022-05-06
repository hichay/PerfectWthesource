ESX = nil
local playersHealing, deadPlayers = {}, {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

RegisterServerEvent('esx_ambulancejob:svsearch')
AddEventHandler('esx_ambulancejob:svsearch', function()
  TriggerClientEvent('esx_ambulancejob:clsearch', -1, source)
end)


RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(playerId)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer and xPlayer.job.name == 'ambulance' then
		local xTarget = ESX.GetPlayerFromId(playerId)

		if xTarget then
			if deadPlayers[playerId] then
				xPlayer.showNotification(_U('revive_complete_award', xTarget.name, Config.ReviveReward))
				xPlayer.addMoney(Config.ReviveReward)
				xTarget.triggerEvent('esx_ambulancejob:revive')
				deadPlayers[playerId] = nil
			else
				xPlayer.showNotification(_U('player_not_unconscious'))
			end
		else
			xPlayer.showNotification(_U('revive_fail_offline'))
		end
	end
end)

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	deadPlayers[source] = 'dead'
	TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
end)

RegisterNetEvent('esx_ambulancejob:onPlayerDistress')
AddEventHandler('esx_ambulancejob:onPlayerDistress', function()
	if deadPlayers[source] then
		deadPlayers[source] = 'distress'
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)


RegisterServerEvent('esx_ambulancejob:NoticeDeadPlayer')
AddEventHandler('esx_ambulancejob:NoticeDeadPlayer', function(data, customcoords)
    if customcoords ~= nil then
        data.coords = customcoords
    end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job = 'ambulance', 
        coords = data.coords,
        title = 'Người bị thương',
        message = 'Một người đã bị thương tại'..data.coords, 
        flash = 0, 
        blip = {
            sprite = 431, 
            scale = 1.2, 
            colour = 3,
            flashes = false, 
            text = 'Người bị thương',
            time = (5*60*1000),
            sound = 1,
        }
    })
end)


RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	if deadPlayers[source] then
		deadPlayers[source] = nil
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
	local _source = source
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'ambulance' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
		end
	end		
end)

RegisterServerEvent('esx_ambulancejob:spawned')
AddEventHandler('esx_ambulancejob:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'ambulance' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
	end
end)

RegisterServerEvent('esx_ambulancejob:forceBlip')
AddEventHandler('esx_ambulancejob:forceBlip', function()
	TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'ambulance')
	end
end)

RegisterServerEvent('esx_ambulancejob:message')
AddEventHandler('esx_ambulancejob:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end) 

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:heal', target, type)
	end
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end
	end

	if Config.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	local playerLoadout = {}
	if Config.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)

	RegisterNetEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount

		xPlayer.showNotification(_U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('esx_ambulancejob:buyJobVehicle', function(source, cb, vehicleProps, stat, model, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)

			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, stats, plate, type, job, model) VALUES (@owner, @vehicle, @stats, @plate, @type, @job, @job)', {
				['@owner'] = xPlayer.identifier,
				['@vehicle'] = json.encode(vehicleProps),
				['@plate'] = vehicleProps.plate,
				['@type'] = type,
				['@stats'] = json.encode(stat),
				['@job'] = xPlayer.job.name,
				['@model'] = model,

			}, function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end
end)

function getPriceFromHash(vehicleHash, jobGrade, type)
	local vehicles = Config.AuthorizedVehicles[type][jobGrade]

	for k,v in ipairs(vehicles) do
		if GetHashKey(v.model) == vehicleHash then
			return v.price
		end
	end

	return 0
end

RegisterNetEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		xPlayer.showNotification(_U('used_bandage'))
	elseif item == 'medikit' then
		xPlayer.showNotification(_U('used_medikit'))
	end
end)

RegisterNetEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		print(('[esx_ambulancejob] [^2INFO^7] "%s" attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage') then
		print(('[esx_ambulancejob] [^2INFO^7] "%s" attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	if xPlayer.canCarryItem(itemName, amount) then
		xPlayer.addInventoryItem(itemName, amount)
	else
		xPlayer.showNotification(_U('max_item'))
	end
end)

ESX.RegisterCommand('revive', 'moderator', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_ambulancejob:revive')
end, true, {help = _U('revive_help'), validate = true, arguments = {
	{name = 'playerId', help = 'The player id', type = 'idcard'}
}})

-- ESX.RegisterUsableItem('medikit', function(source)
	-- if not playersHealing[source] then
		-- local xPlayer = ESX.GetPlayerFromId(source)
		-- xPlayer.removeInventoryItem('medikit', 1)

		-- playersHealing[source] = true
		-- TriggerClientEvent('esx_ambulancejob:useItem', source, 'medikit')

		-- Citizen.Wait(10000)
		-- playersHealing[source] = nil
	-- end
-- end)

ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'bandage')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(isDead)
		if isDead then
			print(('[esx_ambulancejob] [^2INFO^7] "%s" attempted combat logging'):format(xPlayer.identifier))
		end

		cb(isDead)
	end)
end)


ESX.RegisterServerCallback('esx_ambulancejob:GetListDeadPlayers', function(source, cb, name)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    

    MySQL.Async.fetchScalar("SELECT reciverstatus, recivername, identifier FROM `users` WHERE identifier = @", function(player)
        function payButton(plate)
            return "<a id='button' btn-type='pay' btn-id='" .. plate .. "' href=\"#\" data-toggle=\"modal\" data-target=\"#payModal\" class=\"btn btn-warning btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-money-check-alt\"></i></span><span class=\"text\">Trả tiền</span></a>"
        end
        
        local PlayerList = {}
        if vehicles[1] ~= nil and isAuthorized == true then
            for k, v in pairs(player) do
                table.insert(PlayerList, {v.model, v.plate, v.name, payButton(v.plate), serverConfig['impounds'][name]['price']})
            end
        end

        cb(PlayerList)
    end)
end)

RegisterNetEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(isDead) == 'boolean' then
		MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@isDead'] = isDead
		})
	end
end)

-- ESX.RegisterServerCallback('esx_ambulancejob:getPlayerName', function(source,cb, playerArray)
	-- local cacheName = {}
	-- for i = 1, #playerArray, 1 do 
		-- local xPlayer = ESX.GetPlayerFromId(playerArray[i])
		-- local name = xPlayer.getName()
		-- table.insert(cacheName, {name = name, serverId = playerArray[i]})
	-- end 
	
	
	
	-- cb(cacheName)
-- end)

ESX.RegisterServerCallback('esx_ambulancejob:getPlayerName321', function(source,cb, data)
	local cacheName = {}
	--local playerlist = MySQL.Sync.fetchAll('SELECT * FROM users')
	print(data)
	function Accept(id)
		return "<a id='button' btn-type='accept' btn-id="..id.." href=\"#\" data-toggle=\"modal\" data-target=\"#payModal\" class=\"btn btn-warning btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-money-check-alt\"></i></span><span class=\"text\">Trả tiền</span></a>"
	end 

	function Getback(id)
		return "<a id='button' btn-type='accept' btn-id="..id.." href=\"#\" data-toggle=\"modal\" data-target=\"#payModal\" class=\"btn btn-danger btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-money-check-alt\"></i></span><span class=\"text\">Nhận</span></a>"
	end
	
	function Getback(id)
		return "<a id='button' btn-type='accept' btn-id="..id.." href=\"#\" data-toggle=\"modal\" data-target=\"#payModal\" class=\"btn btn-danger btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-money-check-alt\"></i></span><span class=\"text\">Nhận</span></a>"
	end 

		for j = 1, #data do
			
			local xPlayer = ESX.GetPlayerFromId(data[j])
			local Player = ESX.GetPlayerFromId(source)
			local sourceplayername = GetPlayerName(source)
			local name = xPlayer.getName()

		local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE is_dead = @is_dead AND identifier = @identifier', {
			['@is_dead'] = 0,
			['@identifier'] = xPlayer.identifier
		})
			for n,m in pairs(result) do 
				if m.recivername == NULL then
					table.insert(cacheName, {name = name,status = m.reciverstatus,reciver =  "Chưa có ai nhận",playerid = data[j] ,accept = Accept(data[j])})	
				else
					if sourceplayername == m.recivername then 
						print('thisline')
						table.insert(cacheName, {name = name,status = m.reciverstatus,reciver =  m.recivername,playerid = data[j] ,accept = Accept(data[j]),getback = Getback(data[j])})	
					else 
						table.insert(cacheName, {name = name,status = m.reciverstatus,reciver =  m.recivername,playerid = data[j] ,accept = Accept(data[j])})   
					end
					
				end	
			end
			

		--[[ MySQL.Async.fetchAll('SELECT * FROM users WHERE is_dead = @is_dead AND identifier = @identifier' , {
			['@is_dead'] = 0,
			['@identifier'] = xPlayer.identifier
		}, function (result)
			
			print(result)
			--for i = 1, #result do 
				
				for n,m in pairs(result) do 
					--print(m.firstname)
					table.insert(cacheName, {name = name, status = result[i].reciverstatus, revicer = result[i].recivername, Idplayer = data[j]})
			end	
			
				
				
		end) ]]
		cb(cacheName)
			
		
		end 
		
		--[[ for i = 1, #data, 1 do 
			 local xPlayer = ESX.GetPlayerFromId(data[i])
			 local name = xPlayer.getName()
			 table.insert(cacheName, {name = name, Idplayer = data[i]})
		end
		
		
		MySQL.Async.fetchAll('SELECT * FROM users WHERE is_dead = @is_dead AND identifier = @identifier' , {
			['@is_dead'] = 0,
		}, function (result)
			
			print(result)
			--for i = 1, #result do 
				
				for n,m in pairs(result) do 
					print(m.firstname)
					table.insert(cacheName, {status = m.reciverstatus, revicer = m.recivername})
				end	
			
				
				
		end) ]]
		
		
end)
	

ESX.RegisterServerCallback('esx_ambulancejob:getPlayerName', function(source,cb, data)
	local cacheName = {}
	--local playerlist = MySQL.Sync.fetchAll('SELECT * FROM users')
	--print(data)
	 
	for j = 1, #data do
		local xPlayer = ESX.GetPlayerFromId(data[j])
		--print(xPlayer.identifier)
		MySQL.Async.fetchAll('SELECT * FROM users WHERE is_dead = @is_dead AND identifier = @identifier' , {
			['@is_dead'] = 0,
			['@identifier'] = xPlayer.identifier
			
		}, function (result)
			local cacheName = {}
			print(result)
			for k,v in pairs(result) do
				print(k,v)
			end
			if result[1] ~= nil then	
				for j = 1, #data do
					for n,m in pairs(result) do 
					
						local xPlayer = ESX.GetPlayerFromId(data[j])
						local Player = ESX.GetPlayerFromId(source)
						local sourceplayername = xPlayer.getName(source)
						local name = xPlayer.getName()
						function Accept(id)
							return "<a id='button' btn-type='accept' btn-id="..id.." href=\"#\" data-toggle=\"modal\" data-target=\"#payModal\" class=\"btn btn-warning btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-money-check-alt\"></i></span><span class=\"text\">Trả tiền</span></a> " 
						end 

						function Getback(id)
							return "<a></a>"
						end

						function GetLocationorCancel(id)
							return "<a id='button' btn-type='accept' btn-id="..id.." href=\"#\" data-toggle=\"modal\" data-target=\"#payModal\" class=\"btn btn-warning btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-money-check-alt\"></i></span><span class=\"text\">Nhận lại</span></a> <a id='button' btn-type='canceltextt' btn-id="..id.." href=\"#\" data-toggle=\"modal\" data-target=\"#payModal\" class=\"btn btn-danger btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-money-check-alt\"></i></span><span class=\"text\">Hủy</span></a>"
						end  


						
						--[[ if Player.identifier == m.recivername then 
							print('người nhận là:'..Player.identifier)
						end ]] 
						
						if m.recivername == NULL then
								table.insert(cacheName, {name = m.firstname.." "..m.lastname,status = m.reciverstatus,reciver =  "Chưa có ai nhận",playerid = data[j] ,button = Accept(data[j])})	
						else
							if sourceplayername == m.recivername then 
								--[[ Người nhận hiển thị thông tin vị trí và hủy ]]
							   	table.insert(cacheName, {name = m.firstname.." "..m.lastname,status = m.reciverstatus,reciver =  m.recivername,playerid = data[j] ,button = GetLocationorCancel(data[j])})	
							else  

								--[[ không hiển thị gì cả ]]
								table.insert(cacheName, {name = m.firstname.." "..m.lastname,status = m.reciverstatus,reciver =  m.recivername,playerid = data[j] ,button = Getback(data[j])})   

							end
							
						end	
							
						
					end
					
				end	
			
			end	
				cb(cacheName)	
		end)	
	end	
end)


-- RegisterNetEvent('esx_ambulancejob:setReciverStatus')
-- AddEventHandler('esx_ambulancejob:setReciverStatus', function()
	-- local xPlayer = ESX.GetPlayerFromId(source)

	
		-- MySQL.Sync.execute('UPDATE users SET reciverstatus = @reciverstatus WHERE identifier = @identifier', {
			-- ['@identifier'] = xPlayer.identifier,
			-- ['@reciverstatus'] = 1
		-- })
	
-- end)


RegisterServerEvent("esx_ambulancejob:setReciverStatus")
AddEventHandler("esx_ambulancejob:setReciverStatus", function(iddeadplayer)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(iddeadplayer)
	local name = GetPlayerName(_source)
	--print("id người chết.." ..deadplayerid)
	
		-- playerAccepted = GetCharacterName(_source)
		-- Deadname = GetDaedName(deadplayerid)
		playerAccepted = xPlayer.getName(_source)
		--Deadname = GetPlayerName(deadplayerid)
	--print(iddeadplayer)
		
	--TriggerClientEvent("ui_ambulanceAlert:ReceiveAccepted", -1, number, playerAccepted, street)
	
	--TriggerClientEvent("ui_ambulanceAlert:ReceiveAcceptedNotifyAll", -1, 'black', playerAccepted .. ' Nhận trường hợp của' , Deadname)
	MySQL.Sync.execute('UPDATE users SET reciverstatus = @reciverstatus , recivername = @recivername WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@reciverstatus'] = 1,
			['@recivername'] = playerAccepted
	})
end)


RegisterServerEvent("esx_ambulancejob:SetNull")
AddEventHandler("esx_ambulancejob:SetNull", function(iddeadplayer)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(iddeadplayer)
	local name = GetPlayerName(_source)
	--print("id người chết.." ..deadplayerid)
	
		-- playerAccepted = GetCharacterName(_source)
		-- Deadname = GetDaedName(deadplayerid)
		
		--Deadname = GetPlayerName(deadplayerid)
	--print(iddeadplayer)
		
	--TriggerClientEvent("ui_ambulanceAlert:ReceiveAccepted", -1, number, playerAccepted, street)
	
	--TriggerClientEvent("ui_ambulanceAlert:ReceiveAcceptedNotifyAll", -1, 'black', playerAccepted .. ' Nhận trường hợp của' , Deadname)
	MySQL.Sync.execute('UPDATE users SET reciverstatus = @reciverstatus , recivername = @recivername WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@reciverstatus'] = 0,
			['@recivername'] = NULL
	})
end)


function CountMedic()

	local xPlayers = ESX.GetPlayers()

	MedicConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'ambulance' then
			MedicConnected = MedicConnected + 1
		end
	end

	SetTimeout(5000, CountMedic)

end

CountMedic()


RegisterServerEvent("esx_ambulancejob:hoisinh")
AddEventHandler("esx_ambulancejob:hoisinh", function()
	
    if MedicConnected >= 1 then 
		TriggerClientEvent('esx:showNotification', -1, "Đang có bác sĩ online")
	else
		for i,data in pairs(deadPlayers) do
			local xPlayer = ESX.GetPlayerFromId(i)
			if xPlayer.getAccount('money').money > Config.Hoisinhcommand then
				xPlayer.removeAccountMoney('money', Config.Hoisinhcommand)
				TriggerEvent("pw-bossmenu:server:addAccountMoney", 'ambulance' , Config.Hoisinhcommand)
				TriggerClientEvent('esx:showNotification', i, "Bạn đã bị trừ "..Config.Hoisinhcommand.."$ để hồi sinh",'info')

				TriggerClientEvent('esx_ambulancejob:revive', i)
				
			elseif xPlayer.getAccount('bank').money > Config.Hoisinhcommand then
				xPlayer.removeAccountMoney('bank', Config.Hoisinhcommand)
				TriggerEvent("pw-bossmenu:server:addAccountMoney", 'ambulance' , Config.Hoisinhcommand)
				TriggerClientEvent('esx:showNotification', i, "Bạn đã bị trừ "..Config.Hoisinhcommand.."$ để hồi sinh",'info')
				TriggerClientEvent('esx_ambulancejob:revive', i)
			else
				TriggerClientEvent('esx:showNotification', i, "Bạn không có "..Config.Hoisinhcommand.."$ để hồi sinh")
			end
			
		end	
		
	end
end)


