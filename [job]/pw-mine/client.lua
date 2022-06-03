ESX = nil
local mining = false
local exploded = false
local textDel = Config.textDel
isWorking = false
blipCreated = false

RegisterNetEvent('pw-mine:client:kichhoat')
AddEventHandler('pw-mine:client:kichhoat', function()
    isWorking = not isWorking
    if isWorking then 
        TriggerEvent("ESX:Notify","Bắt đầu công việc","info")
        iswashing = false
        exploded = false
        mining = false  
    else 
        TriggerEvent("ESX:Notify","Kết thúc công việc","info")
        iswashing = false
        exploded = false
        mining = false      
    end     
end)

RegisterCommand("lamviec", function(source, args, rawCommand)
    isWorking = not isWorking
    if isWorking then 
        print("Bắt đầu công việc")
    else 
        print("Kết thúc công việc")      
    end
end, false)



Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
        
	ESX.PlayerData = ESX.GetPlayerData()
    local playerPed = PlayerPedId()

    local createdPeds = {}

    local playerPed = PlayerPedId()

    local data = {
        id = "miner_jobempoly",
        position = {coords = Config.NPC, heading = 158.20},
        pedType = 4,
        model = "mp_m_counterfeit_01",
        networked = false,
        distance = 25.0,
        settings = {{ mode = 'invincible', active = true }, { mode = 'ignore', active = true }, { mode = 'freeze', active = true }},
        flags = { ["isNPC"] = true, },
    }

    local npc = exports["pw-npcs"]:RegisterNPC(data, "miner_emply")

    local Interact = {
      data = {
        {
          id = 'Miner_interact',
          label = 'Bắt đầu/Kết thúc công việc',
          icon = 'person-digging',
          event = 'pw-mine:client:kichhoat',
          parameters = {},
        },
        {
            id = 'Miner_sellitem',
            label = 'Bán đồ',
            icon = 'seal-exclamation',
            event = 'pw-mine:makeSales',
            parameters = {},
          },

      },
      options = {
        distance = { radius = 2.5 },
        npcIds = { 'miner_jobempoly' },
        --[[ isEnabled = function(pEntity, pContext)
          return isOnDeliveryTask()
        end, ]]
      },
    }
    
    exports["pw-interact"]:AddPeekEntryByFlag({'isNPC'}, Interact.data, Interact.options)

    while true do
        Citizen.Wait(15)
        local xp ,yp ,zp
        local closeTo = 0
        local pos = GetEntityCoords(PlayerPedId())
        for k, v in pairs(Config.MiningPositions) do
            if #(pos - v.coords) <= 2.5 and isWorking then 
                closeTo = v
                xp = v.coords.x
                yp = v.coords.y
                zp = v.coords.z
                break
            end
        end
        if type(closeTo) == 'table' then
            while #(GetEntityCoords(PlayerPedId() - closeTo.coords)) <= 2.5 and not exploded do
                local counter = 0
                Wait(0)
                helpText(Strings['press_mine'])
                if IsControlJustReleased(0, 38) then                 
					mining = true
					--GiveWeaponToPed(PlayerPedId(), GetHashKey("weapon_stickybomb"), 1, false, true)
					Citizen.Wait(1250)                                                                                      
					--TaskPlantBomb(PlayerPedId(), closeTo.coords, 218.5)
					TriggerEvent("DoLongHudText", "Bom đã đặt - Chạy ngay đi trước khi quá trễ",1)
					while mining and not exploded do
						-- Wait(1000)
						local time = 6
						while time > 0 do 
							Citizen.Wait(1000)
							time = time - 1
						end
						
						AddExplosion(closeTo.coords.x, closeTo.coords.y, closeTo.coords.z, EXPLOSION_STICKYBOMB, 2.0, true, false, 5.0)
						exploded = true
						local rock = GetHashKey("prop_rock_4_c")
						rock1 = CreateObject(rock, closeTo.coords.x, closeTo.coords.y , closeTo.coords.z + 3.5, true, true, true)                           
					end              
                end
            end
        end
        Wait(250)
    end
end)
Citizen.CreateThread(function()
    local sleep
    while true do
        sleep = 5
        local player = PlayerPedId()
        local pos = GetEntityCoords(player)
        if exploded then
            if #(GetEntityCoords(rock1) - GetEntityCoords(player)) <= 2.5 then
                sleep = 5
                local rpos = GetEntityCoords(rock1)
                DrawText3D2(rpos.x, rpos.y, rpos.z,'Bấm ~g~[ E ]~w~ để đào')
                if IsControlJustPressed(0, 38) then
                    
                    local model = loadModel(GetHashKey('prop_tool_jackham'))
                    local axe = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
                    AttachEntityToEntity(axe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)
                        Citizen.Wait(100)

                    FreezeEntityPosition(player, true)
                    local dict = loadDict('amb@world_human_const_drill@male@drill@base')
                    TaskPlayAnim(PlayerPedId(), dict, 'base', 8.0, -8.0, -1, 2, 0, false, false, false)

                    Citizen.Wait(5000)

                    ClearPedTasks(PlayerPedId())
                    FreezeEntityPosition(player, false)
                    DeleteObject(axe)
                    DeleteObject(rock1)

                    TriggerServerEvent('pepe-mine:getItem')

                    iswashing = false
                    exploded = false
                    mining = false
                end
            else
                sleep = 2500
            end
        else
            sleep = 3000
        end
        Citizen.Wait(sleep)
    end
end)

local materialslist = {
    { name = "coal", price = 5},
    { name = "goldmate", price = math.random(10,15)},
    { name = "ironmate", price = math.random(10,15),},
    { name = "mercury", price = math.random(10,15)},
    { name = "aluminiummate", price = math.random(30,50)},
    { name = "jadeite", price = math.random(800,1000)},
}

function SellMaterial()
    local veh = GetVehiclePedIsIn(PlayerPedId())
    if veh and veh ~= 0 then
      local vehModel = GetEntityModel(veh)
      if IsThisModelABike(vehModel) or IsThisModelAQuadbike(vehModel) or IsThisModelABicycle(vehModel) then
        DeleteEntity(veh)
      end
      return
    end
    local totalCash = 0

    for k, v in pairs(materialslist) do
        local qty = exports["pw-inventory"]:getQuantity(v.name, true)

        if qty > 0 then
            totalCash = totalCash + (v.price * qty)
            TriggerEvent("inventory:removeItem", v.name, qty)      
        end
    end

    if totalCash == 0 then
		TriggerEvent("ESX:Notify","Không có gì để bán","error")
    end

    if totalCash > 0 then
        TriggerServerEvent("pw-mine:Payout",totalCash)
    end
end

RegisterNetEvent("pw-mine:makeSales")
AddEventHandler("pw-mine:makeSales", SellMaterial)

RegisterCommand("putgood", function(source, args, rawCommand)
    TriggerEvent("server-inventory-open", "1", "Stolen-Goods-1-")
end, false)

RegisterCommand("sellgood", function(source, args, rawCommand)
    RPC.execute("pw-mine:sellStolenItems", false)
end, false)
    



--[[ Citizen.CreateThread(function()
    while true do
        local sleep = 250
        --if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.Sell, true) <= 3.0 then
        if #(GetEntityCoords(PlayerPedId()) - Config.Sell) <= 3.0 then
            sleep = 0
            helpText(Strings['e_sell'])
            if IsControlJustReleased(0, 38) then
                TriggerServerEvent('pepe-mine:sell')
                local ped = PlayerPedId()
                    local pid = PlayerPedId()
                    RequestAnimDict('amb@medic@standing@kneel@base')
                    RequestAnimDict('anim@gangops@facility@servers@bodysearch@')
                FreezeEntityPosition(pid, true)

                local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.9, -0.98))
                prop1 = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z,  true,  true, true)

                TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
                TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )

                Citizen.Wait(6000)
                DeleteObject(prop1)
                ClearPedTasksImmediately(PlayerPedId())
                FreezeEntityPosition(PlayerPedId(), false)
            end
        end
        Wait(sleep)
    end
end) ]]

Citizen.CreateThread(function()
    while true do
        local sleep = 250
        --if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.Sell, true) <= 3.0 then
        local pos = GetEntityCoords(PlayerPedId())
        for k, v in pairs(Config.WashLocation) do
            if #(pos - v.coords) <= 2.5 and isWorking then      
        --if #(GetEntityCoords(PlayerPedId()) - Config.WashLocation) <= 3.0 then
                sleep = 0
                helpText(Strings['e_wash'])
                DrawMarker(1, v.coords.x, v.coords.y, v.coords.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 210, 50, 9, 255, false, false, false, true, false, false, false)
                if IsControlJustReleased(0, 38) then
                    if exports["pw-inventory"]:hasEnoughOfItem("rock",1) then
						TriggerEvent("inventory:removeItem","rock",1)
                        ESX.Progressbar("search_register", "Rửa đá..", 6000, false, true, {disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                                disableInventory = true,
                            }, {}, {}, {}, function()end, function()
                                            
                        end)
                        --[[ local ped = PlayerPedId()
                            local pid = PlayerPedId()
                            RequestAnimDict('amb@medic@standing@kneel@base')
                            RequestAnimDict('anim@gangops@facility@servers@bodysearch@')
                        FreezeEntityPosition(pid, true) ]]

                        local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.9, -0.98))
                        prop1 = CreateObject(GetHashKey('prop_rock_5_a'), x, y, z,  true,  true, true)
                        SetEntityHeading(prop1, GetEntityHeading(PlayerPedId()))

                        LoadDict('amb@medic@standing@kneel@base')

                        TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
                        LoadDict('anim@gangops@facility@servers@bodysearch@')
                        TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )

                        Citizen.Wait(6000)
                        TriggerServerEvent('pw-mine:ruada')
                        ClearPedTasks(PlayerPedId())
                        DeleteEntity(prop1)
                        ClearPedTasksImmediately(PlayerPedId())
                        --[[ FreezeEntityPosition(PlayerPedId(), false) ]]
                    else
                        TriggerEvent("ESX:Notify","Không có đá thô để rửa đá","info")    
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

Citizen.CreateThread(function()
    --addBlip(Config.NPC, 318, 0.8, 5, Strings['npc'])
        while true do
            Citizen.Wait(1000)
            if isWorking and not blipCreated then
                for k, v in pairs(Config.MiningPositions) do
                    addBlip(v.coords, 153, 0.7, 5, Strings['mining'])
                end
                for k, v in pairs(Config.WashLocation) do
                    addBlip(v.coords, 306, 0.7, 5, Strings['washlocation'])
                end
                --addBlip(Config.Sell, 207, 0.7, 25, Strings['sell_mine'])
                blipCreated = true
            end
              
        end
end) 


loadModel = function(model)
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    return model
end

loadDict = function(dict, anim)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

----TEXT 3D
function DrawText3D2(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("CUSTOM_TEXT")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end

helpText = function(msg)
    BeginTextCommandDisplayHelp('CUSTOM_TEXT')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end


addBlip = function(coords, sprite, size, colour, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipScale  (blip, size)
    SetBlipColour (blip, colour)
    --SetBlipColour(blip, colour)
	SetBlipAlpha(blip, 0.7)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("CUSTOM_TEXT")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end

