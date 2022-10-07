local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local isBusy, deadPlayers, deadPlayerBlips, isOnDuty = false, {}, {}, false
isInShopMenu = false

local blipsEms               = {}
local Nameplayer = {}
function OpenAmbulanceActionsMenu()
	local elements = {{label = _U('cloakroom'), value = 'cloakroom'}}

	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenCloakroomMenu()
		elseif data.current.value == 'boss_actions' then
			-- TriggerEvent('esx_societymk:openBossMenu', 'ambulance', function(data, menu)
				-- menu.close()
			-- end, {wash = false})
			TriggerServerEvent("pw-bossmenu:server:openMenu")
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenMobileAmbulanceActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-right',
		elements = {
			{label = _U('ems_menu'), value = 'citizen_interaction'}
	}}, function(data, menu)
		if data.current.value == 'citizen_interaction' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('ems_menu_title'),
				align    = 'top-right',
				elements = {
					{label = 'Ghi bill',       value = 'billing'},
					{label = _U('ems_menu_revive'), value = 'revive'},
					--{label = _U('ems_menu_small'), value = 'small'},
					--{label = _U('ems_menu_big'), value = 'big'},
					--{label = _U('ems_menu_putincar'), value = 'put_in_vehicle'},
					{label = _U('unpaid_bills'), value = 'unpaid_bills'},
					--{label = "người chết", value = 'deadplayer'},
					{label = 'Tìm kiếm người quanh đây', value = 'search'}
			}}, function(data, menu)
				if isBusy then return end

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if data.current.value == 'search' then
					TriggerServerEvent('esx_ambulancejob:svsearch')
				elseif data.current.value == 'deadplayer' then
					deadPlayerMenu()
					
				else
					if closestPlayer == -1 or closestDistance > 1.0 then
					ESX.ShowNotification(_U('no_players'))
					
					elseif data.current.value == 'billing' then
						GhiBill()
					
					elseif data.current.value == 'revive' then
						
						revivePlayer(closestPlayer)
					elseif data.current.value == 'small' then
						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									isBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									isBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_bandage'))
							end
						end, 'bandage')

					elseif data.current.value == 'big' then

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									isBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									isBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end
						end, 'medikit')

					elseif data.current.value == 'put_in_vehicle' then
						TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))	
					elseif data.current.value == 'unpaid_bills' then
						OpenUnpaidBillsMenu(closestPlayer)	
						
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end

	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent("pw-ambulancejob:RevivePlayer")
AddEventHandler("pw-ambulancejob:RevivePlayer", function(closestPlayer)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestDistance ~= -1 and closestDistance < 2 and not IsPedRagdoll(PlayerPedId()) then
			if exports["pw-inventory"]:hasEnoughOfItem("MedicalBag",1,false) then
				local closestPlayerPed = GetPlayerPed(closestPlayer)
				
				if IsPedDeadOrDying(closestPlayerPed, 1) then
					local playerPed = PlayerPedId()
					local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
					ESX.ShowNotification(_U('revive_inprogress'))
		
					for i=1, 15 do
						Citizen.Wait(900)
		
						ESX.Streaming.RequestAnimDict(lib, function()
							TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
						end)
					end
		
					--TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
					TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
					TriggerEvent('DoLongHudText', 'Cứu chữa thành công',1)
					--TriggerServerEvent('esx_billingmk:sendBill', GetPlayerServerId(closestPlayer), 'ambulance', 'Tiền viện phí', Config.InvoicePrice)
					
				else
					TriggerEvent('DoLongHudText', 'Người này không bất tỉnh',1)
				end
			end
		end	
end)
Citizen.CreateThread(function()
    RegisterCommand("+emsrevive", revivePlayer, false)
	RegisterCommand("-emsrevive", function() end, false)
	exports["pw-keybinds"]:registerKeyMapping("", "EMS", "Revive", "+emsrevive", "-emsrevive", "UP")

	RegisterCommand("+examineTarget", function()
		TriggerEvent("requestWounds")
	end, false)
	RegisterCommand("-examineTarget", function() end, false)
	exports["pw-keybinds"]:registerKeyMapping("", "EMS", "Examine Target", "+examineTarget", "-examineTarget", "DOWN")

end)

function revivePlayer()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestDistance ~= -1 and closestDistance < 2 and not IsPedRagdoll(PlayerPedId()) then
			if exports["pw-inventory"]:hasEnoughOfItem("MedicalBag",1,false) then
				local closestPlayerPed = GetPlayerPed(closestPlayer)
				
				if IsPedDeadOrDying(closestPlayerPed, 1) then
					local playerPed = PlayerPedId()
					local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
					ESX.ShowNotification(_U('revive_inprogress'))
		
					for i=1, 15 do
						Citizen.Wait(900)
		
						ESX.Streaming.RequestAnimDict(lib, function()
							TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
						end)
					end
		
					--TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
					TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
					ESX.ShowNotification(_U('revive_complete', GetPlayerName(closestPlayer)))
					TriggerEvent('DoLongHudText', 'Cứu chữa thành công',1)
					--TriggerServerEvent('esx_billingmk:sendBill', GetPlayerServerId(closestPlayer), 'ambulance', 'Tiền viện phí', Config.InvoicePrice)
					
				else
					TriggerEvent('DoLongHudText', 'Người này không bất tỉnh',1)
				end
			end
		end	
end



-- function Ghibill()
    -- ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
        -- title = _U('invoice_amount')
        -- }, function(data, menu)
        -- local amount = tonumber(data.value)

        -- if amount == nil or amount < 0 then
            -- ESX.ShowNotification('Số bị sai')
        -- else
            -- local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            -- if closestPlayer == -1 or closestDistance > 3.0 then
                -- ESX.ShowNotification('Không có ai ơ gần')
            -- else
                -- menu.close()
                -- TriggerServerEvent('esx_billingmk:sendBill', GetPlayerServerId(closestPlayer), 'society_ambulance', 'cứu thương', amount)
            -- end
        -- end
    -- end, function(data, menu)
    -- menu.close()
-- end



function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - <span style="color:red;">%s</span>'):format(bill.label, _U('armory_item', ESX.Math.GroupDigits(bill.amount))),
				billId = bill.id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
			title    = _U('unpaid_bills'),
			align    = 'top-right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end



RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end
		end
	end
end)


-- Create blip for colleagues
function createBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipAsShortRange(blip, true)

		table.insert(blipsEMS, blip) -- add blip to array so we can remove it later
	end
end

RegisterNetEvent('esx_ambulancejob:updateBlip')
AddEventHandler('esx_ambulancejob:updateBlip', function()
	
	-- Clean the blip table
	blipsEMS = {}
	
	-- Refresh all blips
	for k, existingBlip in pairs(blipsEMS) do
		RemoveBlip(existingBlip)
	end

	

	-- Enable blip?
	if Config.EnableESXService and not isOnDuty then
		return
	end

	if not Config.EnableJobBlip then
		return
	end

	-- Is the player a cop? In that case show all the blips for other cops
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		ESX.TriggerServerCallback('esx_societymk:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'ambulance' then
				
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end

end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if isOnDuty and job ~= 'ambulance' then
		for playerId,v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end
		TriggerServerEvent('esx_ambulancejob:forceBlip')
		isOnDuty = false
	end
end)



function createBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipAsShortRange(blip, true)
		SetBlipColour(blip,1)
		table.insert(blipsEms, blip) -- add blip to array so we can remove it later
	end
end



RegisterNetEvent('esx_ambulancejob:setDeadPlayers')
AddEventHandler('esx_ambulancejob:setDeadPlayers', function(_deadPlayers)
	deadPlayers = _deadPlayers

	if isOnDuty then
		for playerId,v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end

		for playerId,status in pairs(deadPlayers) do
			if status == 'distress' then
				local player = GetPlayerFromServerId(playerId)
				local playerPed = GetPlayerPed(player)
				local blip = AddBlipForEntity(playerPed)

				SetBlipSprite(blip, 303)
				SetBlipColour(blip, 1)
				SetBlipFlashes(blip, true)
				SetBlipCategory(blip, 7)

				BeginTextCommandSetBlipName('CUSTOM_TEXT')
				AddTextComponentSubstringPlayerName(_U('blip_dead'))
				EndTextCommandSetBlipName(blip)

				deadPlayerBlips[playerId] = blip
			end
		end
	end
end)


function deadPlayerMenu1()
	local elements = {}
	local cachePlayer = {}
	local status = 0
	for _, player in ipairs(GetActivePlayers()) do
		if not IsPlayerDead(player) then 
			local ped = GetPlayerPed(player)
			local serverId = GetPlayerServerId(player)
			table.insert(cachePlayer, serverId)
		end 
	end 
	ESX.TriggerServerCallback('esx_ambulancejob:getPlayerName', function(result)
		for k, v in ipairs(result) do 
			table.insert(elements, {label = v.name.." | "..status.."|ID: "..v.serverId, name = v.name, ped = GetPlayerPed(GetPlayerFromServerId(v.serverId))})
		end 
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dead_player', {
			title    = 'Danh sách người chơi đang bất tỉnh',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local coords = GetEntityCoords(data.current.ped)
			SetNewWaypoint(coords.x, coords.y)
			--print(coords.x, coords.y)
			ESX.ShowNotification('~g~Đã lấy GPS người chết')
			TriggerServerEvent('esx_ambulancejob:ReceivePlayerDeadNotification', data.current.name)
			menu.close()
		end, function(data, menu)
			menu.close()
		end)
	end, cachePlayer)
end


function deadPlayerMenu()
	local cachePlayer = {}
	local src = source
	for _, player in ipairs(GetActivePlayers()) do
		print(_,player)
		if true then 
			local ped = GetPlayerPed(player)
			local serverId = GetPlayerServerId(player)
			table.insert(cachePlayer, serverId)
		end 
	end 

	ESX.TriggerServerCallback('esx_ambulancejob:getPlayerName', function(result)
		for k, v in ipairs(result) do 
			print('result value')
			print(k,v)
			--[[ function Accept()
				return "<a id='button' btn-type='accept' btn-plate="" href=\"#\" data-toggle=\"modal\" data-target=\"#payModal\" class=\"btn btn-warning btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-money-check-alt\"></i></span><span class=\"text\">Trả tiền</span></a>"
			end ]]
			local Playerped = GetPlayerPed(GetPlayerFromServerId(tonumber(v.playerid)))
			local Sourped = GetPlayerPed(GetPlayerFromServerId(src))
			
			local deadcoords = GetEntityCoords(Playerped)
			local playercoords = GetEntityCoords(src)

			local distanceplayer = playercoords - deadcoords
			--table.insert(v,{distance = distanceplayer})
			--table.insert(Nameplayer,{v.name, v.status, v.revicer,Accept(v.Idplayer),'border-left-success'}) 
			

		end	


		SendNUIMessage({
			open = true,
			playerlist = result,
		})
		SetNuiFocus(true, true)


	end,cachePlayer)	

end
function deadPlayerMenu22()
	
	local cachePlayer = {}
	for _, player in ipairs(GetActivePlayers()) do
		print(_,player)
		if true then 
			local ped = GetPlayerPed(player)
			local PlayerData = GetPlayerServerId(player)
			table.insert(cachePlayer, PlayerData)
		end 
	end 

	
	ESX.TriggerServerCallback('esx_ambulancejob:getPlayerName', function(result)
		
		--[[ for k, v in ipairs(result) do 
			table.insert(elements, {label = v.name.." | ID: "..v.serverId, name = v.name, ped = GetPlayerPed(GetPlayerFromServerId(v.serverId))})
        end  ]]
       -- Vehicles1 = cachePlayer
	   --Nameplayer = result
	   --table.insert(Nameplayer,a)
	   --Nameplayer = result
	   	
		
		
		-- function Delete(id)
            -- return "<a id='button' btn-type='pay' btn-plate='" .. plate .. "' href=\"#\" data-toggle=\"modal\" data-target=\"#payModal\" class=\"btn btn-warning btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-money-check-alt\"></i></span><span class=\"text\">Trả tiền</span></a>"
        -- end
		
		for k, v in ipairs(result) do 
			for _, player in ipairs(GetActivePlayers()) do
				if true then 

					 
					 
					local sourcecoords = GetEntityCoords(PlayerPedId())
					
					local ped = GetPlayerPed(player)
					local myid = GetPlayerServerId(source)
					
					local serverId = GetPlayerServerId(player)
					local player = GetPlayerFromServerId(serverId)
					local coords = GetEntityCoords(ped)
					local distance = GetDistanceBetweenCoords(sourcecoords,coords)				
					local PlayerNameAccepted = GetPlayerName(GetPlayerFromServerId(myid))

					function Accept(id)
						return "<a id='button' btn-type='accept' btn-plate='" .. serverId .. "' href=\"#\" data-toggle=\"modal\" data-target=\"#payModal\" class=\"btn btn-warning btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-money-check-alt\"></i></span><span class=\"text\">Trả tiền</span></a>"
					end

					function delete(id)
						return "<a id='button' btn-type='delete' btn-plate='" .. serverId .. "' href=\"#\" data-toggle=\"modal\" data-target=\"#payModal\" class=\"btn btn-warning btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-money-check-alt\"></i></span><span class=\"text\">DDeso</span></a>"
					end

					
						



					--table.insert(result,distance)

					--[[ if v.status == 1 and v.playeraccepted == PlayerNameAccepted then
						table.insert(Nameplayer,{v.firstname.."  "..v.lastname, v.status, serverId, distance, v.playeraccepted, PlayerNameAccepted,delete(serverId) })
					else
						table.insert(Nameplayer,{v.firstname.."  "..v.lastname, v.status, serverId, distance, v.playeraccepted, PlayerNameAccepted,Accept(serverId) })
					end ]]
					
				end
			end	 
		end  
		   
		    
		  
		   -- --table.insert(Vehicles1,cachePlayer)
		   -- --Vehicles1 = cachePlayer
		--print(Nameplayer)
		

			SendNUIMessage({
				open = true,
				playerlist = result,
			})
			SetNuiFocus(true, true)
		
    end,cachePlayer)
	
	
    -- if not IsInShopMenu then
		-- IsInShopMenu = true
		-- SetNuiFocus(true, true)
		
		-- SendNUIMessage({
            -- show = true,
			-- playerslist = table.concat(Nameplayer)
			
        -- })
	-- end
	
	
end





RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
	table.remove(Nameplayer)
end)



RegisterNUICallback('accept', function(data)
	local Id = data.btnId
	local playerid = GetPlayerPed(GetPlayerFromServerId(tonumber(Id)))
	local coords = GetEntityCoords(playerid)
	TriggerServerEvent("esx_ambulancejob:setReciverStatus",tonumber(Id))
	SetNewWaypoint(coords.x, coords.y)
	ESX.ShowNotification('~g~Đã lấy GPS người chết')
                 
end)

RegisterNUICallback('cancel', function(data)
	local Id = data.idPlayer
	local playerid = GetPlayerPed(GetPlayerFromServerId(tonumber(Id)))
	TriggerServerEvent("esx_ambulancejob:SetNull",tonumber(Id))
	ESX.ShowNotification('~g~Đã hủy thành công')
                 
end)


function deadPlayerMenu1()
	local elements = {}
	local cachePlayer = {}
	local status = 0
	for _, player in ipairs(GetActivePlayers()) do
		if not IsPlayerDead(player) then 
			local ped = GetPlayerPed(player)
			local serverId = GetPlayerServerId(player)
			table.insert(cachePlayer, serverId)
		end 
	end 
	ESX.TriggerServerCallback('esx_ambulancejob:getPlayerName', function(result)
		for k, v in ipairs(result) do 
			table.insert(elements, {label = v.name.." | "..status.."|ID: "..v.serverId, name = v.name, ped = GetPlayerPed(GetPlayerFromServerId(v.serverId))})
		end 
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dead_player', {
			title    = 'Danh sách người chơi đang bất tỉnh',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local coords = GetEntityCoords(data.current.ped)
			SetNewWaypoint(coords.x, coords.y)
			--print(coords.x, coords.y)
			ESX.ShowNotification('~g~Đã lấy GPS người chết')
			TriggerServerEvent('esx_ambulancejob:ReceivePlayerDeadNotification', data.current.name)
			menu.close()
		end, function(data, menu)
			menu.close()
		end)
	end, cachePlayer)
end
RegisterNUICallback('SetLocation', function(data, cb)
    SetNuiFocus(false, false)
	IsInShopMenu = false
    local id = data.id
	local playerPed = PlayerPedId()
	local ped = GetPlayerPed(GetPlayerFromServerId(id))
	local coords = GetEntityCoords(ped)
	table.remove(Nameplayer, id)
	TriggerServerEvent('esx_ambulancejob:setReciverStatus', id)
	ESX.ShowNotification('~g~Đã lấy GPS người chết')
	SetNewWaypoint(coords.x, coords.y)
	
	
end)



RegisterNUICallback("toggle", function(data,cb)

    toggle(data.state,false)
	

end)

function toggle(state,send)

    SetNuiFocus(state, state)

    if send then

        SendNUIMessage({

            type = "toggle",

            state = state

        })

    end

end

RegisterCommand("nuidebug",function(a,b,c) SetNuiFocus(false,false) end, false)


RegisterNetEvent('esx_ambulancejob:Ghibill')
AddEventHandler('esx_ambulancejob:Ghibill', function()
	Ghibill()
end)


RegisterNetEvent('esx_ambulancejob:rivieplayer')
AddEventHandler('esx_ambulancejob:rivieplayer', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	revivePlayer(closestPlayer)
end)

RegisterNetEvent('esx_ambulancejob:OpenUnpaidBillsMenu')
AddEventHandler('esx_ambulancejob:OpenUnpaidBillsMenu', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	OpenUnpaidBillsMenu(closestPlayer)
end)


RegisterNetEvent('esx_ambulancejob:deadPlayerMenu')
AddEventHandler('esx_ambulancejob:deadPlayerMenu', function()
	deadPlayerMenu()
end)


-- RegisterCommand('ghibill', function(source, args, rawCommand)
	-- local text
    -- if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		-- text = "Tiền viện phí"
	-- elseif ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then 
		-- text = "phạt vi phạm"
	-- end
   	
	-- --TriggerServerEvent('pw_script:sendBillplayer', args[1], ESX.PlayerData.job.name, text, args[2])
	-- TriggerServerEvent('esx_billingmk:sendBill', args[1], ESX.PlayerData.job.name, text, args[2])
-- end)

