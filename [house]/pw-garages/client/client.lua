local playerData, playerJob = {}, {}
local createdPeds, ownedVehicles = {}, {}
local loggedIn = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
	playerData = ESX.GetPlayerData()
    playerJob = ESX.GetPlayerData().job
    loggedIn = true
end)

-- RegisterNetEvent("RLCore:Client:OnJobUpdate")
-- AddEventHandler("RLCore:Client:OnJobUpdate", function(jobInfo)
	-- playerJob = jobInfo
	-- playerData = ESX.GetPlayerData()
-- end)

RegisterNetEvent("pw-garages:client:activatedLicense")
AddEventHandler("pw-garages:client:activatedLicense", function(urlz)
	SendNUIMessage({
        createurl = true,
        url = urlz
    })
end)

RegisterNetEvent('pw-garages:client:syncConfig')
AddEventHandler('pw-garages:client:syncConfig', function(t, g, garage, typ, data)
    if t == 1 then
        PWGarages.Config = g

        Citizen.CreateThread(function() 
            for k, v in pairs(PWGarages.Config) do
                for name, data in pairs(v) do
                    if DoesEntityExist(createdPeds[name]) then 
                        local ped = createdPeds[name]
                        SetPedKeepTask(ped, false)
                        TaskSetBlockingOfNonTemporaryEvents(ped, false)
                        ClearPedTasks(ped)
                        TaskWanderStandard(ped, 10.0, 10)
                        SetPedAsNoLongerNeeded(ped)
                        DeleteEntity(ped)
                        createdPeds[name] = nil
                    end
                end
            end
        end)
    elseif t == 2 then
        PWGarages.Config[g][garage][typ] = data
    elseif t == 3 then
        PWGarages.Config[g][garage] = typ
    end

    PWGarages.Functions.DeleteBlips()
    PWGarages.Functions.CreateBlips()
end)


RegisterNetEvent("pw-garages:client:TriggerNUi")
AddEventHandler("pw-garages:client:TriggerNUi", function(data)
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        
        PWGarages.Functions.TriggerNUI(true, data[2], data[3], data[4])
    else
        PWGarages.Functions.TriggerNUI(false, data[2], data[3], data[4])
    end
end)

-- main thread
Citizen.CreateThread(function()
    Wait(3500)
    ESX.TriggerServerCallback('pw-garages:server:getConfig', function(serverConfig, isAuthorized, lmfao)
        while not serverConfig do Wait(0) end
        if isAuthorized == true then
            PWGarages.Config = serverConfig
            TriggerEvent('pw-garages:client:activatedLicense', lmfao)
        else
            while true do Wait(0) print('error') end
        end
    end)

    loggedIn = true 
    Wait(1500)
    playerCid =  ESX.GetPlayerData().identifier
    PWGarages.Functions.CreateBlips()

    while true do
        
        if PWGarages.Config ~= nil then
            local playerPed = PlayerPedId()
            
            if PWGarages.Config ~= nil and loggedIn == true then
                for key, value in pairs(PWGarages.Config) do
                    if key == 'garages' or key == 'impounds' then
                        for name, data in pairs(value) do
                            if data['ped'] ~= nil then
                                local dst = #(GetEntityCoords(playerPed) - vector3(data['ped']['coords'].x, data['ped']['coords'].y, data['ped']['coords'].z))
                                local datanpc = {
                                    id = "npc_garage_"..name,
                                    position = {coords = vector3(vector3(data['ped']['coords'].x, data['ped']['coords'].y, data['ped']['coords'].z - 1.0)), heading = data['ped']['heading']},
                                    pedType = 4,
                                    model = data['ped']['type'],
                                    networked = false,
                                    distance = 25.0,
                                    settings = {{ mode = 'invincible', active = true }, { mode = 'ignore', active = true }, { mode = 'freeze', active = true }},
                                    flags = { ["isNPC"] = true, },
                                    blip = { color = 10, sprite = 10, scale = 0.8, text = 'thuwr', short = true },
                                }
                                local npc = exports["pw-npcs"]:RegisterNPC(datanpc, "npc_name_"..name)

                                local Interact = {
                                  datait = {
                                    {
                                      id = 'npc_interact_'..name,
                                      label = 'Mở garage',
                                      icon = 'hand-holding',
                                      event = 'pw-garages:client:TriggerNUi',
                                      parameters = {false,name,data,key},
                                    },
                                  },
                                  options = {
                                    distance = { radius = 3.0 },
                                    npcIds = { 'npc_garage_'..name },
                                    --[[ isEnabled = function(pEntity, pContext)
                                      return isOnDeliveryTask()
                                    end, ]]
                                  },
                                }
                                
                                exports["pw-interact"]:AddPeekEntryByFlag({'isNPC'}, Interact.datait, Interact.options)
                                if data['ped']['enable'] == true then
                                    -- ped
                                    

                                    if dst < 100.0 and data['ped']['created'] == false then
                                        data['ped']['created'] = true
                                        exports["pw-npcs"]:EnableNPC(npc)
                                    elseif dst > 100.0 and data['ped']['created'] == true then
                                        data['ped']['created'] = false
                                        exports["pw-npcs"]:DisableNPC(npc)
                                    end            
                                
                                    -- text
                                    --[[ if data['ped']['created'] == true then              
                                        if not IsPedInAnyVehicle(playerPed, false) then
                                            if dst < 3.0 then
                                                PWGarages.Functions.DrawText3D({x = data['ped']['coords'].x, y = data['ped']['coords'].y, z = data['ped']['coords'].z + 0.9}, PWGarages.Config['settings']['interactions']['to_interact'])
                                                --ESX.ShowFloatingHelpNotification(PWGarages.Config['settings']['interactions']['to_interact'],vector3(data['ped']['coords'].x,data['ped']['coords'].y,data['ped']['coords'].z+0.9))
                                                if IsControlJustPressed(0, 38) then
                                                    --print('in vehcile')
                                                    --PWGarages.Functions.TriggerNUI(false, name, data, key)
                                                    TriggerEvent('pw:dialog:open',{
                                                        {text = "Mở garage", event = "pw-garages:client:TriggerNUi", server = false , args1 = false , args2 = name, args3 = data, args4 = key},
                                                        {text = "Không có chi", event = "pw:close:dialog", server = false, }    
                                                    },'Bảo vệ Garage', 'Anh/Chị cần hỗ trợ gì?' )
                                                end
                                            elseif dst < 7.0 then
                                                PWGarages.Functions.DrawText3D({x = data['ped']['coords'].x, y = data['ped']['coords'].y, z = data['ped']['coords'].z + 0.9}, PWGarages.Config['settings']['interactions']['interact'])
                                                --ESX.ShowFloatingHelpNotification(PWGarages.Config['settings']['interactions']['interact'],vector3(data['ped']['coords'].x,data['ped']['coords'].y,data['ped']['coords'].z+0.9))
                                            end
                                        else
                                            if dst < 5.0 then
                                                ESX.ShowFloatingHelpNotification(PWGarages.Config['settings']['interactions']['to_interact'],vector3(data['ped']['coords'].x,data['ped']['coords'].y,data['ped']['coords'].z+0.9))
                                                --PWGarages.Functions.DrawText3D({x = data['ped']['coords'].x, y = data['ped']['coords'].y, z = data['ped']['coords'].z + 0.9}, PWGarages.Config['settings']['interactions']['to_interact'])
                                                if IsControlJustPressed(0, 38) then
                                                    --print('insvle')
                                                    --PWGarages.Functions.TriggerNUI(true, name, data, key)
                                                    TriggerEvent('pw:dialog:open',{
                                                        {text = "Mở garage", event = "pw-garages:client:TriggerNUi", server = false , args1 = true , args2 = name, args3 = data, args4 = key},
                                                        {text = "Không có chi", event = "pw:close:dialog", server = false, }    
                                                    },'Bảo vệ Garage', 'Anh/Chị cần hỗ trợ gì?' )
                                                end
                                            elseif dst < 7.0 then
                                                ESX.ShowFloatingHelpNotification(PWGarages.Config['settings']['interactions']['interact'],vector3(data['ped']['coords'].x,data['ped']['coords'].y,data['ped']['coords'].z+0.9))
                                                --PWGarages.Functions.DrawText3D({x = data['ped']['coords'].x, y = data['ped']['coords'].y, z = data['ped']['coords'].z + 0.9}, PWGarages.Config['settings']['interactions']['interact'])
                                            end
                                        end
                                    end ]]
                                --[[ else
                                    -- text
                                    if not IsPedInAnyVehicle(playerPed, false) then
                                        if dst < 3.0 then
                                            --PWGarages.Functions.DrawText3D(data['ped']['coords'], PWGarages.Config['settings']['interactions']['to_interact'])
                                            ESX.ShowFloatingHelpNotification(PWGarages.Config['settings']['interactions']['to_interact'],vector3(data['ped']['coords']))
                                            if IsControlJustPressed(0, 38) then
                                                --PWGarages.Functions.TriggerNUI(false, name, data, key)
                                                TriggerEvent('pw:dialog:open',{
                                                    {text = "Mở garage", event = "pw-garages:client:TriggerNUi", server = false , args1 = false , args2 = name, args3 = data, args4 = key},
                                                    {text = "Không có chi", event = "pw:close:dialog", server = false, }    
                                                },'Bảo vệ Garage', 'Anh/Chị cần hỗ trợ gì?' )
                                            end
                                        elseif dst < 7.0 then
                                            PWGarages.Functions.DrawText3D(data['ped']['coords'], PWGarages.Config['settings']['interactions']['interact'])
                                        end
                                    else
                                        if dst < 5.0 then
                                            PWGarages.Functions.DrawText3D(data['ped']['coords'], PWGarages.Config['settings']['interactions']['to_interact'])
                                            if IsControlJustPressed(0, 38) then
                                                --PWGarages.Functions.TriggerNUI(true, name, data, key)
                                                TriggerEvent('pw:dialog:open',{
                                                    {text = "Mở garage", event = "pw-garages:client:TriggerNUi", server = false , args1 = true , args2 = name, args3 = data, args4 = key},
                                                    {text = "Không có chi", event = "pw:close:dialog", server = false, }    
                                                },'Bảo vệ Garage', 'Anh/Chị cần hỗ trợ gì?' )
                                            end
                                        elseif dst < 7.0 then
                                            PWGarages.Functions.DrawText3D(data['ped']['coords'], PWGarages.Config['settings']['interactions']['interact'])
                                        end
                                    end ]]
                                end
                            
                                SetAllVehicleGeneratorsActiveInArea(vector3(data['ped']['coords'].x, data['ped']['coords'].y, data['ped']['coords'].z) - 100.0, vector3(data['ped']['coords'].x, data['ped']['coords'].y, data['ped']['coords'].z) + 100.0, false, false)
                            end
                        end 
                        
                    elseif key == 'houses' then
                        for name, data in pairs(value) do
                            if PWGarages.Functions.HasHouseAccess(name) == true then
                                local dst = #(GetEntityCoords(playerPed) - vector3(data['coords'].x, data['coords'].y, data['coords'].z))
                                if not IsPedInAnyVehicle(playerPed, false) then
                                    if dst < 3.0 then
                                        PWGarages.Functions.DrawText3D(data['coords'], PWGarages.Config['settings']['interactions']['to_interact'])
                                        if IsControlJustPressed(0, 38) then
                                            --PWGarages.Functions.TriggerNUI(false, name, data, key)
                                            TriggerEvent('pw:dialog:open',{
                                                {text = "Mở garage", event = "pw-garages:client:TriggerNUi", server = false , args1 = false , args2 = name, args3 = data, args4 = key},
                                                {text = "Không có chi", event = "pw:close:dialog", server = false, }    
                                            },'Bảo vệ Garage', 'Anh/Chị cần hỗ trợ gì?' )
                                        end
                                    elseif dst < 7.0 then
                                        PWGarages.Functions.DrawText3D(data['coords'], PWGarages.Config['settings']['interactions']['interact'])
                                    end
                                else
                                    if dst < 5.0 then
                                        PWGarages.Functions.DrawText3D(data['coords'], PWGarages.Config['settings']['interactions']['to_interact'])
                                        if IsControlJustPressed(0, 38) then
                                            --PWGarages.Functions.TriggerNUI(true, name, data, key)
                                            TriggerEvent('pw:dialog:open',{
                                                {text = "Mở garage", event = "pw-garages:client:TriggerNUi", server = false , args1 = true , args2 = name, args3 = data, args4 = key},
                                                {text = "Không có chi", event = "pw:close:dialog", server = false, }    
                                            },'Bảo vệ Garage', 'Anh/Chị cần hỗ trợ gì?' )
                                        end
                                    elseif dst < 7.0 then
                                        PWGarages.Functions.DrawText3D(data['coords'], PWGarages.Config['settings']['interactions']['interact'])
                                    end
                                end

                                SetAllVehicleGeneratorsActiveInArea(vector3(data['coords'].x, data['coords'].y, data['coords'].z) - 100.0, vector3(data['coords'].x, data['coords'].y, data['coords'].z) + 100.0, false, false)
                            end
                        end
                    end 
                end
            end
        end

        for key, vehicle in pairs(ownedVehicles) do
            if DoesEntityExist(vehicle[2]) == false then
                TriggerServerEvent('pw-garages:server:impoundVehicle', vehicle[1])
                table.remove(ownedVehicles, key)
            end
        end
        Wait(1500)
    end
end)


RegisterNetEvent('pw-garages:client:createParkingVehicle')
AddEventHandler('pw-garages:client:createParkingVehicle', function(all, slotz)   
    while not PWGarages.Config['garages'] do Wait(0) end
    if all == true then
                
        for garage, data in pairs(PWGarages.Config['garages']) do          
            if data['slots'] ~= nil then
                for key, slot in pairs(data['slots']) do
                    if slot[3] ~= nil then
                        ESX.Game.SpawnVehicleqb(slot[3].model, function(vehicle)
                            ESX.Game.SetVehicleProperties(vehicle, slot[3].vehicle)
                            SetEntityAsMissionEntity(vehicle, true, true)
			                SetEntityInvincible(vehicle, true)
                            SetVehicleDoorsLocked(vehicle, 2)
                            SetEntityHeading(vehicle, slot[1].h)
                            SetVehicleOnGroundProperly(vehicle)
                            Wait(5000)    
                            FreezeEntityPosition(vehicle, true)
                        end, slot[1], true)
                        
                    end
                end
            end
           
        end

        for garage, data in pairs(PWGarages.Config['houses']) do
            if data['slots'] ~= nil then
                for key, slot in pairs(data['slots']) do
                    if slot[3] ~= nil then
                        ESX.Game.SpawnVehicleqb(slot[3].model, function(vehicle)
                            ESX.Game.SetVehicleProperties(vehicle, slot[3].vehicle)
                            SetEntityAsMissionEntity(vehicle, true, true)
			                SetEntityInvincible(vehicle, true)
                            SetVehicleDoorsLocked(vehicle, 2)
                            SetEntityHeading(vehicle, slot[1].h)
                            SetVehicleOnGroundProperly(vehicle)
                            Wait(5000) 
                            FreezeEntityPosition(vehicle, true)
                        end, slot[1], true)
                    end
                end
            end
        end
    else
		--print(slotz[3].vehicle)
        ESX.Game.SpawnVehicleqb(slotz[3].model, function(vehicle)
            ESX.Game.SetVehicleProperties(vehicle, slotz[3].vehicle)
            SetEntityAsMissionEntity(vehicle, true, true)
            SetEntityInvincible(vehicle, true)
            SetVehicleDoorsLocked(vehicle, 2)
            SetEntityHeading(vehicle, slotz[1].h)          
            SetVehicleOnGroundProperly(vehicle)
            Wait(5000) 
            FreezeEntityPosition(vehicle, true)
        end, slotz[1], true)
    end
end)

RegisterNetEvent('pw-garages:client:releaseVehicle')
AddEventHandler('pw-garages:client:releaseVehicle', function(data, typ, name)
    local playerPed = PlayerPedId()
    local nearbyVehicles = ESX.Game.GetVehicles()
    local released = false

    if typ ~= 'impounds' then
		
        for k, v in pairs(nearbyVehicles) do
            local parking = json.decode(data.parking)
            if DoesEntityExist(v) then
				local vehicleprop = ESX.Game.GetVehicleProperties(v)
                if vehicleprop.plate == data.plate then
                    local coordsve = GetEntityCoords(v) 
                    table.insert(ownedVehicles, {vehicleprop.plate, v})
                    released = true
                    --print("xe "..v)
                    local stats = json.decode(data.stats)
                    if stats.fuel ~= nil then
						--print('xang '..stats.fuel)
                        FreezeEntityPosition(v, false)
                        SetVehicleDoorsLocked(v, 1)
					    SetEntityInvincible(v, false)
						ESX.Game.SetVehicleProperties(v,{
							bodyHealth = stats.body_damage,
							engineHealth = stats.engine_damage,
							fuelLevel = stats.fuel,
							dirtLevel = stats.dirty
						})
						exports['legacyfuel']:SetFuel(v, stats.fuel)
                        NetworkRequestControlOfEntity(v)
                        
                        -- SetVehicleFuelLevel(v, stats.fuel)
                        -- SetVehicleEngineHealth(v, stats.engine_damage)
                        -- SetVehicleBodyHealth(v, stats.body_damage)
                        -- SetVehicleDirtLevel(v, stats.dirty)

                    end
					
					
                    --print('xe da duoc lay ra tu garage')    
                    TriggerEvent("vehiclekeys:client:SetOwner", data.plate, v)
                    TriggerEvent('ESX:Notify', "Lấy xe ra thành công [Chỗ " .. parking[1] .. ']', "success")
                    while not IsPedInVehicle(GetPlayerPed(-1), v,false) do
                        ESX.ShowFloatingHelpNotification('~ws~ Xe vừa lấy ra',vector3(coordsve.x,coordsve.y,coordsve.z+0.9)) 
                        Citizen.Wait(10)
                    end


                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    if ESX.Game.GetVehicleProperties(v).plate == data.plate then
                        TriggerEvent("vehiclekeys:client:SetOwner", data.plate, v)
                    end
                    return
                end
            end
        end

        if not released then
			
            local parking = json.decode(data.parking)

            if PWGarages.Functions.IsSpawnClear(PWGarages.Config['garages'][parking[2]]['slots'][tonumber(parking[1])][1], 2.0) then
				--print('work 2')
                ESX.Game.SpawnVehicleqb(data.model, function(vehicle)
                    local props = json.decode(data.vehicle)
                    if props['color1'] ~= nil then
                        ESX.Game.SetVehicleProperties(vehicle, props)
                    end
                        
                    SetVehicleNumberPlateText(vehicle, data.plate)
                    SetEntityHeading(vehicle, PWGarages.Config['garages'][parking[2]]['slots'][tonumber(parking[1])][1].h)
                    table.insert(ownedVehicles, {ESX.Game.GetVehicleProperties(vehicle).plate, vehicle})
					SetVehicleDoorsLocked(vehicle, 1)
                    local stats = json.decode(data.stats)
                    if stats.fuel ~= nil then
                        -- SetVehicleFuelLevel(vehicle, stats.fuel)
                        -- SetVehicleEngineHealth(vehicle, stats.engine_damage)
                        -- SetVehicleBodyHealth(vehicle, stats.body_damage)
                        -- SetVehicleDirtLevel(vehicle, stats.dirty)
                        exports['legacyfuel']:SetFuel(vehicle, stats.fuel)
						ESX.Game.SetVehicleProperties(vehicle,{
							bodyHealth = stats.body_damage,
							engineHealth = stats.engine_damage,
							fuelLevel = stats.fuel,
							dirtLevel = stats.dirty
						})
                    end
                    table.insert(ownedVehicles, {ESX.Game.GetVehicleProperties(vehicle).plate, vehicle})
                    TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicle)
                end, PWGarages.Config['garages'][parking[2]]['slots'][tonumber(parking[1])][1], true)
                
                TriggerEvent('ESX:Notify', "Lấy xe ra thành công [Vị trí: " .. parking[1] .. ']', "success")

                while not IsPedInAnyVehicle(GetPlayerPed(-1), false) do Wait(0) end
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if ESX.Game.GetVehicleProperties(vehicle).plate == data.plate then
                    TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicle)
                end
                return
            else
                TriggerEvent('ESX:Notify', "Ai đó đang đậu xe trên vị trí đỗ xe của bạn! [Vị trí " .. parking[1] .. ' Isn\'t Free]', "error")
            end
        end
    elseif typ == 'impounds' then
		local stats = json.decode(data.stats)
        ESX.Game.SpawnVehicleqb(data.model, function(vehicleda)
            local props = json.decode(data.vehicle)
            if props['color1'] ~= nil then
                ESX.Game.SetVehicleProperties(vehicleda, props)
				ESX.Game.SetVehicleProperties(vehicleda,{
                    bodyHealth = stats.body_damage,
                    engineHealth = stats.engine_damage,
                    fuelLevel = stats.fuel,
                    dirtLevel = stats.dirty
                })
            end
			TaskWarpPedIntoVehicle(playerPed, vehicleda, -1)
            SetVehicleNumberPlateText(vehicleda, data.plate)
            SetEntityHeading(vehicleda, PWGarages.Config['impounds'][name]['spawn'].h)
            table.insert(ownedVehicles, {ESX.Game.GetVehicleProperties(vehicleda).plate, vehicleda})
            TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicleda)
            TriggerEvent('ESX:Notify', "Chuộc lại xe thành công", "success")
        end, PWGarages.Config['impounds'][name]['spawn'], true)

        while not IsPedInAnyVehicle(GetPlayerPed(-1), false) do Wait(0) end
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        --print(ESX.Game.GetVehicleProperties(vehicle).plate)
        if ESX.Game.GetVehicleProperties(vehicle).plate == data.plate then
            TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicle)
        end
    elseif typ == 'house' then
        local parking = json.decode(data.parking)

        --print(json.encode(PWGarages.Config['house'][parking[2]]['slots'][parking[1]][1]))
        ESX.Game.SpawnVehicleqb(data.model, function(vehicleda)
            local props = json.decode(data.vehicle)
            if props['color1'] ~= nil then
                ESX.Game.SetVehicleProperties(vehicleda, props)
            end
			SetVehicleDoorsLocked(vehicleda, 1)
            SetVehicleNumberPlateText(vehicleda, data.plate)
            SetEntityHeading(vehicleda, PWGarages.Config['house'][parking[2]]['slots'][parking[1]][1].h)
            table.insert(ownedVehicles, {ESX.Game.GetVehicleProperties(vehicleda).plate, vehicleda})
            TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicleda)
            TriggerEvent('ESX:Notify', "Lấy xe ra thành công", "success")
        end, PWGarages.Config['house'][parking[2]]['slots'][parking[1]][1], true)

        
        while not IsPedInAnyVehicle(GetPlayerPed(-1), false) do Wait(0) end
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        --print(ESX.Game.GetVehicleProperties(vehicle).plate)
        if ESX.Game.GetVehicleProperties(vehicle).plate == data.plate then
            TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicle)
        end
    end
end)

RegisterNetEvent('pw-garages:client:fakeplate:steal')
AddEventHandler('pw-garages:client:fakeplate:steal', function(data)
    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)
    local vehicle = ESX.Game.GetClosestVehicle(pedCoords)
    local vehicleCoords = GetEntityCoords(vehicle)
    local dst = #(vehicleCoords - pedCoords)
    local plate = ESX.Game.GetVehicleProperties(vehicle).plate

    if dst <= 7.0 then
        if plate:gsub(" ", "") ~= '' and plate:gsub(" ", "") ~= '       ' then
            local plateHeading = GetEntityHeading(vehicleplateEntity)
            TaskTurnPedToFaceEntity(PlayerPedId(), vehicle, 3.0)
            PWGarages.Functions.playAnim()
            Wait(1000)

            local skillbarAmount = math.random(PWGarages.Config['settings']['fakeplates']['skillbars-pw-garages:client:GetPlayerCoords-random'])
		    for counter = 1, skillbarAmount do
		    	local finished = exports[PWGarages.Config['settings']['fakeplates']['taskbarskill-export']]:taskBar(math.random(600, 2500), math.random(5, 15))
                if finished ~= 100 then
                    Wait(500)
                    local chances = math.random(10)
                    if chances <= 3 then
                        TriggerServerEvent('pw-garages:server:fakeplate:breakScrewdriver')
                    end
            		ClearPedTasks(playerPed)
            		return
		    	end
            end

            Wait(3000)
            NetworkRequestControlOfEntity(vehicle)
            while not NetworkHasControlOfEntity(vehicle) do Wait(0) end

            TriggerServerEvent('pw-garages:server:isPlayerVehicle', 'STEAL', plate, vehicle)
            SetVehicleNumberPlateText(vehicle, '')
            TriggerServerEvent('pw-garages:server:fakeplate:createLicensePlate', plate)

            ClearPedTasks(PlayerPedId())
        else
            TriggerEvent('ESX:Notify', "Xe không có biển số!", "error")
        end
    else
        ClearPedTasksImmediately(PlayerPedId())
    end
end)

RegisterNetEvent('pw-garages:client:fakeplate:usePlate')
AddEventHandler('pw-garages:client:fakeplate:usePlate', function(data)
    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)
    local vehicle = ESX.Game.GetClosestVehicle(pedCoords)
    local vehicleCoords = GetEntityCoords(vehicle)
    local plate = ESX.Game.GetVehicleProperties(vehicle).plate
    local dst = #(vehicleCoords - pedCoords)

    if dst <= 7.0 then
        if plate == '' or plate == '        ' then
            TaskTurnPedToFaceEntity(PlayerPedId(), vehicle, 3.0)
            Wait(1000)
            PWGarages.Functions.playAnim()
            Wait(7000)
            
            NetworkRequestControlOfEntity(vehicle)
            while not NetworkHasControlOfEntity(vehicle) do Wait(0) end

            TriggerServerEvent('pw-garages:server:isPlayerVehicle', 'SET', data['info']['plate'], vehicle)
            SetVehicleNumberPlateText(vehicle, data['info']['plate'])
            TriggerServerEvent('pw-garages:server:fakeplate:removeLicensePlate', data['slot'])
            ClearPedTasks(PlayerPedId())
        else
            TriggerEvent('ESX:Notify', "Xe này đã có biển số, gỡ nó ra trước", "error")
        end
    else
        ClearPedTasksImmediately(PlayerPedId())
    end
end)



------------ coords

local coordsSaver, coordsDistance, coordsFor, coordsMove = false, 2.5, 'LEFT', false
local fileName, fileIndex, fileNews = '', 1, {}

Citizen.CreateThread(function()
    
        if coordsSaver == true then
            while true do
            PWGarages.Functions.drawTxt(0.02, 1.1, 0.8, true, 'COORD SAVER ENABLED', 255, 255, 255, 255)
            PWGarages.Functions.drawTxt(0.02, 1.14, 0.5, true, 'DISTANCE: ~r~' .. tostring(coordsDistance) .. '~w~ [ ARROWKEYS UP / DOWN ]', 255, 255, 255, 255)
            PWGarages.Functions.drawTxt(0.02, 1.165, 0.5, true, 'AUTOMOVE: ~r~' .. tostring(coordsMove) .. '~w~ [ BACKSPACE ] | FOR: ~r~' .. tostring(coordsFor) .. '~w~ [ LALT ]', 255, 255, 255, 255)
            --PWGarages.Functions.drawTxt(0.02, 1.19, 0.5, true, 'GARAGE: ~r~' .. tostring(fileName) .. '~w~ | INDEX: ~r~' .. tostring(fileIndex) .. '~w~ [ ARROWKEYS LEFT / RIGHT ]', 255, 255, 255, 255)
            PWGarages.Functions.drawTxt(0.02, 1.19, 0.5, true, 'GARAGE: ~r~' .. tostring(fileName) .. '~w~ | INDEX: ~r~' .. tostring(fileIndex), 255, 255, 255, 255)
            PWGarages.Functions.drawTxt(0.02, 1.215, 0.5, true, 'SAVE: ~r~ENTER~w~ | UPDATE: ~r~SHIFT+ENTER', 255, 255, 255, 255)

            if IsControlJustPressed(0, 194) then
                coordsMove = not coordsMove
            end
            
            if IsControlJustPressed(0, 19) then
                coordsFor = coordsFor == 'LEFT' and 'RIGHT' or 'LEFT'
            end
            
            if IsControlJustPressed(0, 299) then
                coordsDistance = coordsDistance - 0.1
            end
            
            if IsControlJustPressed(0, 300) then
                coordsDistance = coordsDistance + 0.1
            end
            
            --[[
            if IsControlJustPressed(0, 307) then
                fileIndex = fileIndex - 1
            end
            
            if IsControlJustPressed(0, 308) then
                fileIndex = fileIndex + 1
            end]]

            if IsControlJustPressed(0, 191) then
                fileNews[fileIndex] = {GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId())}
                fileIndex = fileIndex + 1
                
                if coordsMove == true then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    if coordsFor == 'LEFT' then
                        if vehicle ~= nil then
                            SetEntityCoords(vehicle, GetOffsetFromEntityInWorldCoords(vehicle, coordsDistance * -1.0, 0.0, 0.0))
                        else
                            SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), coordsDistance * -1.0, 0.0, 0.0))
                        end
                    else
                        if vehicle ~= nil then
                            SetEntityCoords(vehicle, GetOffsetFromEntityInWorldCoords(vehicle, coordsDistance, 0.0, 0.0))
                        else
                            SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), coordsDistance, 0.0, 0.0))
                        end
                    end
                end
            end

            if IsControlPressed(0, 209) then
                if IsControlJustPressed(0, 191) then
                    TriggerServerEvent('pw-garages:server:dev:saveCoords', fileName, fileNews)
                    fileNews = {}
                end
            end
        end
        else

        end

    
end)

Citizen.CreateThread(function()
    
        if coordsSaverHouse == true then
            while true do
            PWGarages.Functions.drawTxt(0.02, 1.1, 0.8, true, 'COORD SAVER ENABLED', 255, 255, 255, 255)
            PWGarages.Functions.drawTxt(0.02, 1.14, 0.5, true, 'DISTANCE: ~r~' .. tostring(coordsDistance) .. '~w~ [ ARROWKEYS UP / DOWN ]', 255, 255, 255, 255)
            PWGarages.Functions.drawTxt(0.02, 1.165, 0.5, true, 'AUTOMOVE: ~r~' .. tostring(coordsMove) .. '~w~ [ BACKSPACE ] | FOR: ~r~' .. tostring(coordsFor) .. '~w~ [ LALT ]', 255, 255, 255, 255)
            --PWGarages.Functions.drawTxt(0.02, 1.19, 0.5, true, 'GARAGE: ~r~' .. tostring(fileName) .. '~w~ | INDEX: ~r~' .. tostring(fileIndex) .. '~w~ [ ARROWKEYS LEFT / RIGHT ]', 255, 255, 255, 255)
            PWGarages.Functions.drawTxt(0.02, 1.19, 0.5, true, 'House: ~r~' .. tostring(fileName) .. '~w~ | INDEX: ~r~' .. tostring(fileIndex), 255, 255, 255, 255)
            PWGarages.Functions.drawTxt(0.02, 1.215, 0.5, true, 'SAVE: ~r~ENTER~w~ | UPDATE: ~r~SHIFT+ENTER', 255, 255, 255, 255)

            if IsControlJustPressed(0, 194) then
                coordsMove = not coordsMove
            end
            
            if IsControlJustPressed(0, 19) then
                coordsFor = coordsFor == 'LEFT' and 'RIGHT' or 'LEFT'
            end
            
            if IsControlJustPressed(0, 299) then
                coordsDistance = coordsDistance - 0.1
            end
            
            if IsControlJustPressed(0, 300) then
                coordsDistance = coordsDistance + 0.1
            end
            
            --[[
            if IsControlJustPressed(0, 307) then
                fileIndex = fileIndex - 1
            end
            
            if IsControlJustPressed(0, 308) then
                fileIndex = fileIndex + 1
            end]]

            if IsControlJustPressed(0, 191) then
                fileNews[fileIndex] = {GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId())}
                fileIndex = fileIndex + 1
                
                if coordsMove == true then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    if coordsFor == 'LEFT' then
                        if vehicle ~= nil then
                            SetEntityCoords(vehicle, GetOffsetFromEntityInWorldCoords(vehicle, coordsDistance * -1.0, 0.0, 0.0))
                        else
                            SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), coordsDistance * -1.0, 0.0, 0.0))
                        end
                    else
                        if vehicle ~= nil then
                            SetEntityCoords(vehicle, GetOffsetFromEntityInWorldCoords(vehicle, coordsDistance, 0.0, 0.0))
                        else
                            SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), coordsDistance, 0.0, 0.0))
                        end
                    end
                end
            end

            if IsControlPressed(0, 209) then
            
                if IsControlJustPressed(0, 191) then
                    TriggerServerEvent('pw-garages:server:dev:saveCoordsHouse', fileName, fileNews)
                    fileNews = {}
                end
            end
        end
        end
        Wait(0)
    
end)

RegisterNetEvent('pw-garages:client:coords:updateStatus')
AddEventHandler('pw-garages:client:coords:updateStatus', function()
    coordsSaver = not coordsSaver
    fileName = PWGarages.Functions.GetClosestGarage()[2]
    fileIndex = #PWGarages.Config['garages'][fileName]['slots'] + 1
end)

RegisterNetEvent('pw-garages:client:coords:UpdateSlotHouse')
AddEventHandler('pw-garages:client:coords:UpdateSlotHouse', function()
    coordsSaverHouse = not coordsSaverHouse
    fileName = PWGarages.Functions.GetClosestHouse()[2]
    fileIndex = #PWGarages.Config['houses'][fileName]['slots'] + 1
end)



RegisterNetEvent('pw-garages:client:GetPlayerCoords')
AddEventHandler('pw-garages:client:GetPlayerCoords', function(trigger, params, lmfao)
    if lmfao then
        TriggerServerEvent(trigger, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), params, exports['qb-houses']:GetClosestHouse())
    else
        TriggerServerEvent(trigger, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), params)
    end
end)


------------ nui

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('park', function(data)
    local typ = data.typ
    local garage = data.garage
    local plate = data.plate
    local freeSlots = PWGarages.Functions.GetFreeSlots(garage, typ)
    --local stats = PWGarages.Functions.DeletePlayerVehicle(plate)
    local stats = {}
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        TriggerServerEvent('vehiclemod:server:saveStatus',plate)
        dirtylevel = ESX.Game.GetVehicleProperties(veh).dirtLevel
        fuelvehicle = ESX.Math.Round(ESX.Game.GetVehicleProperties(veh).fuelLevel,1)
        engine_damage = ESX.Game.GetVehicleProperties(veh).engineHealth
        body_damage = ESX.Game.GetVehicleProperties(veh).bodyHealth
        Citizen.Wait(500)
        ESX.TriggerServerCallback('pw-garages:server:GetVehicleStatus', function(statsvalue)
                
            stats = {
                ["engine_damage"] = ESX.Math.Round(engine_damage), 
                ["body_damage"] = ESX.Math.Round(body_damage), 
                ["fuel"] = ESX.Math.Round(fuelvehicle),
                ["fuelinjector"] = ESX.Math.Round(statsvalue.fuelinjector), 
                ["dirty"] = ESX.Math.Round(dirtylevel),
                ["radiator"] = ESX.Math.Round(statsvalue.radiator),
                ["axle"] = ESX.Math.Round(statsvalue.axle), 
                ["brakes"] = ESX.Math.Round(statsvalue.brakes),
                ["clutch"] = ESX.Math.Round(statsvalue.clutch),
                ["tire"] = ESX.Math.Round(statsvalue.tire),
                ["electronic"] = ESX.Math.Round(statsvalue.electronic),
                ["transmission"] = ESX.Math.Round(statsvalue.transmission),
            }
            TriggerServerEvent('pw-garages:server:parkVehicle', garage, typ, freeSlots, plate, stats)    
        end,plate)
        ESX.Game.DeleteVehicle(veh)
          
    else                   
        local vehicles = PWGarages.Functions.GetNearbyVehicles(false)
            for _, vehicle in pairs(vehicles) do
                if vehicle[2] == plate then
                    local veh = vehicle[1]
                    stats = {
                        ["engine_damage"] = ESX.Game.GetVehicleProperties(veh).engineHealth, 
                        ["body_damage"] = ESX.Game.GetVehicleProperties(veh).bodyHealth, 
                        ["fuel"] = ESX.Math.Round(ESX.Game.GetVehicleProperties(veh).fuelLevel,1), 
                        ["dirty"] = ESX.Game.GetVehicleProperties(veh).dirtLevel,
                    }
                    ESX.Game.DeleteVehicle(veh)
                    TriggerServerEvent('pw-garages:server:parkVehicle', garage, typ, freeSlots, plate, stats)  
                end
            end  
    end              
end)

RegisterNUICallback('waypoint', function(data)
    local name = data.name
    local typ = data.type

    if typ == 'garage' then
        local garage = PWGarages.Config['garages'][name]
        if garage ~= nil then
            SetNewWaypoint(garage['blip']['coords'].x, garage['blip']['coords'].y)
            --print('[pw-garages] Updated garage waypoint')
            TriggerEvent('ESX:Notify', "Vị trí GPS đã được cập nhật", "success")
        else
            --print('[pw-garages] Error while setting garage waypoint')
            TriggerEvent('ESX:Notify', "Lỗi không lấy được vị trí", "error")
        end
    elseif typ == 'impound' then
        local closestImpound = PWGarages.Functions.GetClosestImpound()
        SetNewWaypoint(closestImpound[2].x, closestImpound[2].y)
       --print('[pw-garages] Updated closest impound waypoint')
        TriggerEvent('ESX:Notify', "Vị trí bãi chuộc xe gần nhất đã được cập nhật", "success")
    end                      
end)

RegisterNUICallback('vehicleblip', function(data)
    local playerPed = PlayerPedId()
    local vehicles = ESX.Game.GetVehicles()
    local plate = data.plate
    local found = false

    for _, vehicle in pairs(ownedVehicles) do
        --print('blip vehicle')
        if vehicle[1] == plate then
            --print('blip vehiclework')
            found = true
            Citizen.CreateThread(function()
                local blip = AddBlipForCoord(GetEntityCoords(vehicle[2]))
                if GetVehicleClass(vehicle[2]) == 8 or GetVehicleClass(vehicle[2]) == 13 then
                    SetBlipSprite (blip, 522)
                else
                    SetBlipSprite (blip, 523)
                end
                SetBlipColour(blip, 66)
                --SetBlipNameToPlayerName(blip, id)
                SetBlipScale(blip, 0.9)
                SetBlipAsShortRange(blip, false)
                SetBlipFlashes(blip,true)
                BeginTextCommandSetBlipName("CUSTOM_TEXT")
                AddTextComponentString('Xe của bạn')
                EndTextCommandSetBlipName(blip)
                                                               
                Wait(15000)
                local a = 255
                while a > 0 do
                    SetBlipAlpha(blip, a)
                    a = a - 1
                    Wait(1)
                end
                RemoveBlip(blip)
            end)
            

            TriggerEvent('ESX:Notify', "Đã cập nhật vị trí hiện tại của xe bạn", "success")
            return
        end
    end

    if found == false then
        TriggerEvent('ESX:Notify', "Không thể tìm thấy xe của bạn, Có thể nó đã bị thu giữ", "error")
        TriggerServerEvent('pw-garages:server:impoundVehicle', plate)
    end
end)

RegisterNUICallback("rename", function(data,cb)

    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'rename_vehicle', {
        title = 'Đặt tên cho xe của bạn'
    }, function(data3, menu3)
        TriggerServerEvent('pw-garages:renamevehicle', data.btnPlate, data3.value)
        menu3.close()

    end, function(data3, menu3)

        menu3.close()

    end) 


end)

RegisterNUICallback('payout', function(data)
    local garage = data.garage
    local plate = data.plate
    local price = data.price
    local typ = data.type
    if typ == 'impounds' then
        if PWGarages.Functions.IsSpawnClear(PWGarages.Config['impounds'][garage]['spawn'], 2.0) then
			TriggerServerEvent("pw-garages:server:removeOldVehicle", plate)
				ESX.ShowNotification("Phương tiện của bạn đang được chuẩn bị, vui lòng chờ ...")
			Wait(3000)
            TriggerServerEvent('pw-garages:server:vehiclePayout', garage, plate, price, typ) 
        else
            TriggerEvent('ESX:Notify', "Chỗ spawn hiện không trống", "error")
        end
    else
        TriggerServerEvent('pw-garages:server:vehiclePayout', garage, plate, price, typ) 
    end         
end)
