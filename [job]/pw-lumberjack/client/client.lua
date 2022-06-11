local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }

ESX = nil

local mining = false
local textDel = Config.textDel
local canve = Config.canve
local textgar = Config.textgar
local ClosestBerth = 1
local ShowingNotification = false
isWorking = false
blipCreated = false


 RegisterCommand("lumbercheck", function(source, args, rawCommand)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    isWorking = not isWorking
    end, false)
 
RegisterNetEvent('pw-lumberjack:client:kichhoat')
AddEventHandler('pw-lumberjack:client:kichhoat', function()
    isWorking = not isWorking
    if isWorking then 
        TriggerEvent("ESX:Notify","Bắt đầu công việc","info")
    else 
        TriggerEvent("ESX:Notify","Kết thúc công việc","info")      
    end     
end)


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
   
    local data = {
        id = "lumber_jackdanpc",
        position = {coords = Config.NPC, heading = 158.20},
        pedType = 4,
        model = "mp_m_counterfeit_01",
        networked = false,
        distance = 25.0,
        settings = {{ mode = 'invincible', active = true }, { mode = 'ignore', active = true }, { mode = 'freeze', active = true }},
        flags = { ["isNPC"] = true, },
    }

    local npc = exports["pw-npcs"]:RegisterNPC(data, "lumb_jacknpc")

    local Interact = {
      data = {
        {
          id = 'lumb_interact',
          label = 'Bắt đầu/Kết thúc công việc',
          icon = 'hand-holding',
          event = 'pw-lumberjack:client:kichhoat',
          parameters = {},
        },
      },
      options = {
        distance = { radius = 2.5 },
        npcIds = { 'lumber_jackdanpc' },
        --[[ isEnabled = function(pEntity, pContext)
          return isOnDeliveryTask()
        end, ]]
      },
    }
    
    exports["pw-interact"]:AddPeekEntryByFlag({'isNPC'}, Interact.data, Interact.options)
	
	
	local datamenu = {
        id = "lumber_jacksell",
        position = {coords = Config.Sell, heading = 158.20},
        pedType = 4,
        model = "mp_m_counterfeit_01",
        networked = false,
        distance = 25.0,
        settings = {{ mode = 'invincible', active = true }, { mode = 'ignore', active = true }, { mode = 'freeze', active = true }},
        flags = { ["isNPC"] = true, },
    }

    local npc2 = exports["pw-npcs"]:RegisterNPC(datamenu, "lumb_jacknpcsell")

    local InteractNPC = {
      data = {
        {
          id = 'lumb_interactsell',
          label = 'Bán thành phẩm',
          icon = 'hand-holding',
          event = 'pw-lumberjack:makeSales',
          parameters = {},
        },
      },
      options = {
        distance = { radius = 2.5 },
        npcIds = { 'lumber_jacksell' },
        --[[ isEnabled = function(pEntity, pContext)
          return isOnDeliveryTask()
        end, ]]
      },
    }
    
    exports["pw-interact"]:AddPeekEntryByFlag({'isNPC'}, InteractNPC.data, InteractNPC.options)

    while true do
        Citizen.Wait(15)
        local pos = GetEntityCoords(PlayerPedId())

        local closeTo = 0
        local xp ,yp ,zp

        for k, v in pairs(Config.WoodPosition) do
            --if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true) <= 2.5 then
            if #(pos - v.coords) <= 2.5 and isWorking then 
                closeTo = v
                xp = v.coords.x
                yp = v.coords.y
                zp = v.coords.z
                break
            end
        end
        if type(closeTo) == 'table' then
            --while #(pos - closeTo.coords) <= 2.5 and isWorking do
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), closeTo.coords, true) <= 2.5 and isWorking do
                Wait(0)
               
                DrawText3D2(xp, yp, zp+0.97, ''..textDel..'')
               
                if IsControlJustReleased(0, 38) then
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance == -1 or distance >= 4.0 then
                        cutting = true
                        SetEntityCoords(PlayerPedId(), closeTo.coords)
                        SetEntityHeading(PlayerPedId(), closeTo.heading)
                        FreezeEntityPosition(PlayerPedId(), true)
						local model = loadModel(GetHashKey(Config.Objects['pickaxe']))
                        local axe = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
                        AttachEntityToEntity(axe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)

                        while cutting do
                            Wait(0)
                            SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'))
                            --helpText(Strings['wood_info'])
							if not ShowingNotification then
								ShowingNotification = true
								exports["pw-interaction"]:showInteraction("[RMB] Chặt [BACKSPACE] Dừng làm")
							end
                            DisableControlAction(0, 24, true)
                            if IsDisabledControlJustReleased(0, 24) then
								exports["pw-interaction"]:hideInteraction()
								ShowingNotification = false
                                local dict = loadDict('melee@hatchet@streamed_core')
                                TaskPlayAnim(PlayerPedId(), dict, 'plyr_rear_takedown_b', 8.0, -8.0, -1, 2, 0, false, false, false)
                                local timer = GetGameTimer() + 800
                                while GetGameTimer() <= timer do Wait(0) DisableControlAction(0, 24, true) end
                                ClearPedTasks(PlayerPedId())
                                --TriggerServerEvent('wood:getItem')
                                local godau = exports["pw-inventory"]:hasEnoughOfItem("fishinglog",20,false)
                                if math.random(1,100) <= Config.ChanceToGetItem then
                                    if godau then 
                                        --ESX.Notify("Túi đồ đã đầy không thể chứa thêm","error")
                                    else
                                        TriggerEvent("player:receiveItem","fishinglog",1)     
                                        
                                    end                           

                                end

                            elseif IsControlJustReleased(0, 194) then
								exports["pw-interaction"]:hideInteraction()
								ShowingNotification = false
                                break
                            end
                        end
                        cutting = false
                        DeleteObject(axe)
                        FreezeEntityPosition(PlayerPedId(), false)
                    else
                    end
                end
            end
        end
        Wait(250)
    end
end)


Citizen.CreateThread(function()
  
	
        while true do
            Citizen.Wait(1000)
            if isWorking and not blipCreated then
                for k, v in pairs(Config.WoodPosition) do
                    addBlip(v.coords, 79, 0.5, 25, Strings['wood'])
                end
                addBlip(Config.Process, 238, 0.7, 5, Strings['process'])
                addBlip(Config.Sell, 207, 0.6, 11, Strings['sell_wood'])
                blipCreated = true
            end
              
        end
        
end) 

function SellWood()
    local veh = GetVehiclePedIsIn(PlayerPedId())
    if veh and veh ~= 0 then
      local vehModel = GetEntityModel(veh)
      if IsThisModelABike(vehModel) or IsThisModelAQuadbike(vehModel) or IsThisModelABicycle(vehModel) then
        DeleteEntity(veh)
      end
      return
    end
    local totalCash = 0

    local qty = exports["pw-inventory"]:getQuantity('refinedwood', true)

    if qty > 0 then
        totalCash = totalCash + (math.random(30,35) * qty)
        TriggerEvent("inventory:removeItem", 'refinedwood', qty)      
    end

    if totalCash == 0 then
		TriggerEvent("ESX:Notify","Không có gì để bán","error")
    end

    if totalCash > 0 then
        TriggerServerEvent("pw-lumber:Payout",totalCash)
    end
end

RegisterNetEvent("pw-lumberjack:makeSales")
AddEventHandler("pw-lumberjack:makeSales", SellWood)

local procesX = -590.84
local procesY = 5291.30
local procesZ = 70.21
------------------------------------
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(7)
	local plyCoords = GetEntityCoords(PlayerPedId(), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, procesX, procesY, procesZ)
	
	if dist <= 20.0 and isWorking then
	    DrawMarker(27, procesX, procesY, procesZ-0.96, 0, 0, 0, 0, 0, 0, 5.20, 5.20, 5.20, 255, 255, 255, 200, 0, 0, 0, 0)
	else
	    Citizen.Wait(1000)
	end
	local hasBagd7 = false
	local s1d7 = false
	if dist <= 6.0 and isWorking then
		if not ShowingNotification then
			ShowingNotification = true
			exports["pw-interaction"]:showInteraction("[E] Chuẩn bị gỗ")
		end
		if IsControlJustPressed(0, Keys['E']) then 
			ShowingNotification = false
			exports["pw-interaction"]:hideInteraction()
            local hasBagd7 = exports["pw-inventory"]:hasEnoughOfItem("fishinglog",1,false)
		
			if (hasBagd7) then
		        Catgo()
		    else
		        ESX.Notify('Không đủ gỗ để làm việc này.', 'error')
		    end
		end	
	else 
		if ShowingNotification then
			ShowingNotification = false
			exports["pw-interaction"]:hideInteraction()
		end
	end
	
end
end)
function Catgo()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local count = 0
    
    if(count == 0) then
    ESX.Progressbar("search_register", "Chuẩn bị gỗ..", 15000, false, true, {disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
            disableInventory = true,
        }, {}, {}, {}, function()end, function()
                        
    end)
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.9, -0.98))
    prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z,  true,  true, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    LoadDict('amb@medic@standing@tendtodead@idle_a')
    TaskPlayAnim(PlayerPedId(), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
    Citizen.Wait(15000)
    LoadDict('amb@medic@standing@tendtodead@exit')
    TaskPlayAnim(PlayerPedId(), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
    ClearPedTasks(PlayerPedId())
    DeleteEntity(prop)
    TriggerServerEvent('wood_weed:processweed2')
        
    else
    
    
    end
end

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

---load dict and model
loadModel = function(model)
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    return model
end

loadDict = function(dict, anim)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
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
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("CUSTOM_TEXT")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end


----TEXT 3D
function DrawText3D2(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("CUSTOM_TEXT1")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end


local CurrentDock = nil
local currentFuel

