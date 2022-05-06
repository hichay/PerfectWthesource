ESX = nil
local mining = false
local textDel = Config.textDel
isWorking = false
blipCreated = false

RegisterNetEvent('pw-mine:client:kichhoat')
AddEventHandler('pw-mine:client:kichhoat', function()
    isWorking = not isWorking
    if isWorking then 
        TriggerEvent("ESX:Notify","Bắt đầu công việc","info")
    else 
        TriggerEvent("ESX:Notify","Kết thúc công việc","info")      
    end     
end)

--[[ RegisterCommand("lamviec", function(source, args, rawCommand)
    isWorking = not isWorking
    if isWorking then 
        TriggerEvent("ESX:Notify","Bắt đầu công việc","info")
    else 
        TriggerEvent("ESX:Notify","Kết thúc công việc","info")      
    end
end, false) ]]



Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
        
	ESX.PlayerData = ESX.GetPlayerData()
	addBlip(Config.NPC, 318, 0.8, 5, Strings['npc'])
    local playerPed = PlayerPedId()


    local createdPeds = {}

    local playerPed = PlayerPedId()
    local pedcreated = false

    while true do
        Citizen.Wait(15)
        local xp ,yp ,zp
        local closeTo = 0
        local pos = GetEntityCoords(PlayerPedId())
        if #(pos - Config.NPC) <= 50 and pedcreated == false then 
            
            pedcreated = true
            local pedModel = "g_m_importexport_01"
            RequestModel(pedModel)
            while not HasModelLoaded(pedModel) do
                RequestModel(pedModel)
                Wait(100)
            end
        
            local createdPed1 = CreatePed(5, pedModel, Config.NPC - 1.0, 158.19, false, false)
            ClearPedTasks(createdPed1)
            ClearPedSecondaryTask(createdPed1)
            TaskSetBlockingOfNonTemporaryEvents(createdPed1, true)
            SetPedFleeAttributes(createdPed1, 0, 0)
            SetPedCombatAttributes(createdPed1, 17, 1)
        
            SetPedSeeingRange(createdPed1, 0.0)
            SetPedHearingRange(createdPed1, 0.0)
            SetPedAlertness(createdPed1, 0)
            SetPedKeepTask(createdPed1, true)
            Wait(1000) -- for better freeze (not in air)
            FreezeEntityPosition(createdPed1, true)
            SetEntityInvincible(createdPed1, true)
            
            createdPeds[1] = createdPed1
        elseif #(pos - Config.NPC) > 50 and pedcreated == true then
            pedcreated = false
            if DoesEntityExist(createdPeds[1]) then 
                local ped = createdPeds[1]
                SetPedKeepTask(ped, false)
                TaskSetBlockingOfNonTemporaryEvents(ped, false)
                ClearPedTasks(ped)
                TaskWanderStandard(ped, 10.0, 10)
                SetPedAsNoLongerNeeded(ped)
                DeleteEntity(ped)
                createdPeds[1] = nil
            end
        end

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
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), closeTo.coords, true) <= 2.5 and isWorking do
                Wait(0)
                --helpText(Strings['press_mine'])
                DrawText3D2(xp, yp, zp+0.97, ''..textDel..'')
                if IsControlJustReleased(0, 38) then
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance == -1 or distance >= 4.0 then
                        mining = true
                        SetEntityCoords(PlayerPedId(), closeTo.coords)
                        SetEntityHeading(PlayerPedId(), closeTo.heading)
                        FreezeEntityPosition(PlayerPedId(), true)

                        local model = loadModel(GetHashKey(Config.Objects['pickaxe']))
                        local axe = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
                        AttachEntityToEntity(axe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)

                        while mining do
                            Wait(0)
                            SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'))
                            helpText(Strings['mining_info'])
                            DisableControlAction(0, 24, true)
                            if IsDisabledControlJustReleased(0, 18) then
                                local da = exports["pw-inventory"]:hasEnoughOfItem("rock",20,false,true)
                                if da then
                                    TriggerEvent("ESX:Notify","Số lượng đá trên người đã quá nhiều","info")  
                                else
                                    local dict = loadDict('melee@hatchet@streamed_core')
                                    TaskPlayAnim(PlayerPedId(), dict, 'plyr_rear_takedown_b', 8.0, -8.0, -1, 2, 0, false, false, false)
                                    local timer = GetGameTimer() + 800
                                    while GetGameTimer() <= timer do Wait(0) DisableControlAction(0, 24, true) end
                                    ClearPedTasks(PlayerPedId())
                                    TriggerServerEvent('pepe-mine:getItem')
                                end     
                            elseif IsControlJustReleased(0, 194) then
                                break
                            end
                        end
                        mining = false
                        DeleteObject(axe)
                        FreezeEntityPosition(PlayerPedId(), false)
                    else
                        helpText(Strings['someone_close'])

                    end                         
                end
            end
        end
        Wait(250)
    end
end)

local materialslist = {
    { name = "coal", price = 5},
    { name = "goldmate", price = 15},
    { name = "ironmate", price = 10,},
    { name = "mercury", price = 10},
    { name = "aluminiummate", price = 30},
    { name = "jadeite", price = 800},
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
    SetTextEntry("CUSTOM_TEXT1")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end

helpText = function(msg)
    BeginTextCommandDisplayHelp('CUSTOM_TEXT1')
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

