ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

Keys = {
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

WeaponGroups = {
    [-1609580060] = "unarmed",
    [-728555052] = "melee",
    [416676503] = "pistol",
    [-957766203] = "subgun",
    [860033945] = "shootgun",
    [970310034] = "rifle",
    [-1212426201] = "snip"
}

local isNearDeadAnimal = false
local search = {}
local isFirstTime = true
local pedsNear = {}
local pedCoords = 0
local dist = 0
local pedsAlive = {}
local HuntCar = nil
local pedInZone = 0
lamthit = false
local hasTakeVehicle = false
local stockVeh = nil

local propSpawned = {}

local isAttach = false

local cam = nil

local pedIsOnPlayer = nil

local leatherToGive = nil
local meatToGive = nil
local leatherIsBad = false
local specialItem = nil
local dimension = nil
local bad = nil
local good = nil
local perfect = nil
local WasPedShootedInHead = false

local nearestCampfire = nil
local campfireIndex = nil

local animalModels = {}
local animalsSpawnedCount = 0

local animalFleeing = {}
local fleeFound = false
local targetedEntity = nil
isWorking = false
player = nil
coords = {}

------------------------------------------------------------[HARVEST]------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
		player = PlayerPedId(-1)
		coords = GetEntityCoords(player)
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()

    local data = {
        id = "hunterthenpc",
        position = {coords = vector3(-674.0231, 5834.8413, 16.340139), heading = 42.58},
        pedType = 4,
        model = "cs_josef",
        networked = false,
        distance = 40.0,
        settings = {{ mode = 'invincible', active = true }, { mode = 'ignore', active = true }, { mode = 'freeze', active = true }},
        flags = { ["isHuntingShopKeeper"] = true },
        scenario = "WORLD_HUMAN_TOURIST_MOBILE",
    }
    local npc = exports["pw-npcs"]:RegisterNPC(data, "hunter_shopkeepr")

    local Interact = {
      data = {
        {
          id = 'hunter_interact',
          label = 'Bắt đầu/kết thúc đi săn',
          icon = 'person-rifle',
          event = 'pw-hunting:client:kichhoat',
          parameters = {},
        },
        {
            id = 'hunter_interact_shop',
            label = 'Mở cửa hàng',
            icon = 'basket-shopping',
            event = 'pw-shops:openHuntingShop',
            parameters = {},
        },
        {
            id = 'hunter_interact_sell',
            label = 'Bán đồ đã săn được',
            icon = 'hand-holding-dollar',
            event = 'pw-hunting:makeSales',
            parameters = {},
        },
      },
      options = {
        distance = { radius = 3.5 },
      },
    }
    
    exports["pw-interact"]:AddPeekEntryByFlag({'isHuntingShopKeeper'}, Interact.data, Interact.options)

    local AnimalInteract = {
        data = {
          {
            id = 'lamthi_animal',
            label = 'Làm thịt',
            icon = 'hand-holding',
            event = 'pw-hunting:client:lamthit',
            parameters = {},
          },
        },
        options = {
          distance = { radius = 2.5 },
          isEnabled = function(pEntity, pContext)
            return IsEntityDead(pEntity)
          end, 
        },
      }
      
      exports["pw-interact"]:AddPeekEntryByFlag({'isAnimal'}, AnimalInteract.data, AnimalInteract.options) 
end)

RegisterNetEvent('pw-shops:openHuntingShop')
AddEventHandler('pw-shops:openHuntingShop', function()
	TriggerEvent("server-inventory-open", "12", "Shop")
end)

Citizen.CreateThread(function()
    if Config.NativeAnimal then
        while true do
            Citizen.Wait(1000)
            pedsNear = ESX.Game.GetPeds()
            for i=1, #pedsNear, 1 do
                if IsEntityAPed(pedsNear[i]) and not IsPedAPlayer(pedsNear[i]) and not IsPedHuman(pedsNear[i]) then
                    if (getDistance(pedsNear[i]) < 50) then
                        if not animalExists(pedsNear[i]) and animalModelExists(pedsNear[i]) then
                            table.insert(search, pedsNear[i])
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    if Config.EnableFootprints then
        SetForcePedFootstepsTracks(true)
    end

    while true do
        Citizen.Wait(400)
        if #search > 0 then
            for i, ped in pairs(search) do
                local distancePedPlayer = getDistance(ped)
                if not Config.NativeAnimal and distancePedPlayer < Config.PNearAnimalToEscape and not IsPedStill(player) then
                    for i,pedFlee in pairs(animalFleeing) do
                        if ped == pedFlee then
                            fleeFound = true
                        else
                            fleeFound = false
                        end
                    end
                    if not fleeFound then
                        ClearPedTasksImmediately(ped)
                        TaskSmartFleePed(ped, player, 150.0, 30.0, false, false)
                        table.insert(animalFleeing, ped)
                    end
                elseif distancePedPlayer > 200.0 and Config.NativeAnimal then
                    deletePed(ped, i)
                end
            end
        end
    end
end)


function dimensionLeather(small, medium, medBig, big)
    if dimension == "small" then
        categoryLeather(small)
    elseif dimension == "medium" then
        categoryLeather(medium)
    elseif dimension == "medBig" then
        categoryLeather(medBig)
    elseif dimension == "big" then
        categoryLeather(big)
    end
end

function categoryLeather(quality)
    if quality == "bad" then
        leatherToGive = bad
        leatherIsBad = true
    elseif quality == "good" then
        leatherToGive = good
    elseif quality == "perfect" then
        if Config.HeadshotForPerfect then
            if WasPedShootedInHead then
                leatherToGive = perfect
            else
                leatherToGive = good
            end
        else
            leatherToGive = perfect
        end
    end
end

function dimensionMeat(smallmeat, mediummeat, medBigmeat, bigmeat)
    if dimension == "small" then
        categoryMeat(smallmeat)
    elseif dimension == "medium" then
        categoryMeat(mediummeat)
    elseif dimension == "medBig" then
        categoryMeat(medBigmeat)
    elseif dimension == "big" then
        categoryMeat(bigmeat)
    end
end

function categoryMeat(quality)
    if quality == "badmeat" then
        meatToGive = badmeat
    elseif quality == "goodmeat" then
        meatToGive = goodmeat
    elseif quality == "perfectmeat" then
        if Config.HeadshotForPerfect then
            if WasPedShootedInHead then
                meatToGive = perfectmeat
            else
                meatToGive = goodmeat
            end
        else
            meatToGive = perfectmeat
        end
    end
end

function DropSpecialItem(specialItem)
    local specialProbability = math.random(1, 100)
    if specialProbability >= Config.SpecialProb then
        if specialItem ~= "" then
            --exports["mythic_notify"]:DoHudText("inform", Config.Text['special_item'], 10000)
			TriggerEvent("ESX:Notify",Config.Text['special_item'],"info")
            TriggerServerEvent('pw-hunting:server:giveReward', specialItem, 1)
        end
    end
end

function deletePed(entity, i)
    local model = GetEntityModel(entity)
    SetEntityAsNoLongerNeeded(entity)
    SetModelAsNoLongerNeeded(model)
    Sync.DeleteEntity(entity)
    table.remove(search, i)
    animalsSpawnedCount = animalsSpawnedCount - 1
end

function animalExists(entity)
    for i, ped in pairs(search) do
        if ped == entity then
            return true 
        end
    end
    return false
end

function animalModelExists(entity)
    for i, ped in pairs(Config.Animals) do
        if ped.hash == GetEntityModel(entity) then
            return true
        end
    end
    return false
end

function StartAnimCam()
    ClearFocus()
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords, 0, 0, 0, GetGameplayCamFov())
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1000, true, false)
end

function EndAnimCam()
    ClearFocus()
    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam, false)
    cam = nil
end

function ProcessCamControls(ped)
    local playerCoords = coords
    local entityCoords = GetEntityCoords(ped)
    DisableFirstPersonCamThisFrame()
    
    SetCamCoord(cam, entityCoords.x + 3, entityCoords.y + 3, entityCoords.z)
    PointCamAtCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z + 0.9)
end

function SecondProcessCamControls(ped)
    local playerCoords = coords
    local entityCoords = GetEntityCoords(ped)
    DisableFirstPersonCamThisFrame()
    
    SetCamCoord(cam, entityCoords.x, entityCoords.y, entityCoords.z + 6.0)
    PointCamAtCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z)
end

function getAnimalMatch(hash)
    for _, v in pairs(Config.Animals) do 
        if (v.hash == hash) then 
            return v.model
        end 
    end
end

function ensureAnimDict(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(100)
        end        
    end
    return animDict
end
RegisterCommand("disan", function(source, args, rawCommand)
    TriggerEvent('pw-hunting:client:kichhoat')
end, false)
RegisterNetEvent('pw-hunting:client:kichhoat')
AddEventHandler('pw-hunting:client:kichhoat', function()
    isWorking = not isWorking
    if isWorking then 
        TriggerEvent("ESX:Notify","Bạn đã bắt đầu chuyến đi săn","info")
    else 
        TriggerEvent("ESX:Notify","Bạn kết thúc chuyến đi săn","info")      
    end     
end)

RegisterCommand("bait", function(source, args, rawCommand)
    TriggerEvent('pw-hunting:client:bait')
end, false)

Citizen.CreateThread(function()
    if not Config.NativeAnimal then
        for i, animal in pairs(Config.Animals) do
            table.insert(animalModels, animal.model)
        end
        while true do
		 Citizen.Wait(100)
		if isWorking then
            Citizen.Wait(100)
            local pos = coords
            local land = false
            local X,Y,ZLoc = 0

            if IsInSpawnAnimalZone(pos) then
                if animalsSpawnedCount < Config.SpawnAnimalNumber then
                    for k, v in pairs(Config.huntPoint) do
                        if GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < Config.huntRadious then
                            X = v.x
                            Y = v.y
                            ZLoc = v.z
                        end
                    end
                    local r = math.random(1, #animalModels)
                    local pedModel = GetHashKey(animalModels[r])
                    RequestModel(pedModel)
                    while not HasModelLoaded(pedModel) or not HasCollisionForModelLoaded(pedModel) do
                        Wait(100)
                    end
                    posX = X + math.random(-Config.huntRadious,Config.huntRadious)
                    posY = Y + math.random(-Config.huntRadious,Config.huntRadious)
                    Z = ZLoc + 999.0
                    land,posZ = GetGroundZFor_3dCoord(posX + .0, posY + .0, Z, 1)
                    if land then
                        entity = CreatePed(5, pedModel, posX, posY, posZ, 0.0, true, false)
                        DecorSetBool(entity, "HuntingMySpawn", true)
                        animalsSpawnedCount = animalsSpawnedCount + 1
                        TaskWanderStandard(entity, true, true)
                        SetEntityAsMissionEntity(entity, true, true)
						SetPedHearingRange(entity, 150)
						GetPedCombatRange(entity)
						SetPedCombatMovement(entity,3)
						SetPedCombatAbility(entity,2)
						
                        table.insert(search, entity)
                        if Config.BlipOnEntity then
                            local blip = AddBlipForEntity(entity)
                            SetBlipSprite(blip,442)
                            SetBlipColour(blip,1)
                            SetBlipScale(blip, 0.8)
                            BeginTextCommandSetBlipName("STRING")
                            AddTextComponentString("Thú")
                            EndTextCommandSetBlipName(blip)
                        end

                    end
                end
            else
                for i, entity in pairs(search) do
                    deletePed(entity, i)
                end
                animalsSpawnedCount = 0
            end

            for i, entity in pairs(search) do
                if IsEntityInWater(entity) then
                    deletePed(entity, i)
                end
            end
        end
		end
    end
end)
------------------------------------------------------------[LOCATIONS]------------------------------------------------------------

 Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if #propSpawned > 0 then
            for i, prop in pairs(propSpawned) do
                if GetDistanceBetweenCoords(coords, GetEntityCoords(prop), true) < 3 and not IsPedInAnyVehicle(player, false) then
                    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(prop))
                    DrawText3Ds(x, y, z + 0.5, Config.Text['campfire'])
                    if IsControlJustReleased(0, Keys[Config.KeyCampfireMenu]) then
                        --OpenCampfireMenu()
                        TriggerEvent("server-inventory-open", "102", "Craft");	
                    elseif IsControlJustReleased(0, Keys[Config.KeyDestroyCampfire]) then
                        nearestCampfire = prop
                        campfireIndex = i
                        deleteCampfire(coords)
                    end
                end
            end
        end

    end
end) 

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local scale = 0.3
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextEntry("CUSTOM_TEXT")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function IsInSpawnAnimalZone(coords)
    for k, v in pairs(Config.huntPoint) do
        if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.huntRadious then
            return true
        end
    end
    return false
end

function IsInSellZone(coords)
    local SellZone = Config.Locations.SellZone
    if GetDistanceBetweenCoords(coords, SellZone.x, SellZone.y, SellZone.z, true) < 3 then
        return true
    end
    return false
end

function getDistance(pedToGetCoords)
    pedCoords = GetEntityCoords(pedToGetCoords, true)
    local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, pedCoords.x, pedCoords.y, pedCoords.z)
    return dist
end

function IsNearIllegalNPC(coords)
    local illegalNPC = Config.Locations.IllegalNPC
    if GetDistanceBetweenCoords(coords, illegalNPC.x, illegalNPC.y, illegalNPC.z, true) < 3 then
        return true
    end
    return false
end



-----------------------------------------------------------[CAMPFIRE]------------------------------------------------------------

if Config.EnableCampfire then
    RegisterCommand(Config.CampfireCommand, function(source, args, rawCommand)
        if not IsNearNOCampfire(coords) and not IsEntityInWater(player) and not IsPedInAnyVehicle(player) and isWorking then
            if exports["pw-inventory"]:hasEnoughOfItem("fishinglog",5,false) then
                TriggerEvent("inventory:removeItem", "fishinglog", 5)
                local land = false
                local Z = nil
                TaskStartScenarioInPlace(player, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
                local finished = exports["pw-taskbar"]:taskBar(Config.CampPlacingTime, "Đang đốt lửa", false, true, false, false, nil, 5.0)
                if finished then
                    ClearPedTasksImmediately(player)
                    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1),0.0,3.0,5.0))
                    repeat 
                        Citizen.Wait(100)
                        land,NewZ = GetGroundZFor_3dCoord(x,y,z,1)
                    until land
                    
                    --print(land) --don't delete
                
                    if land then
                        prop = CreateObjectNoOffset(GetHashKey(Config.CampfireProp),x,y,NewZ+.15, true, true, true)
                        table.insert(propSpawned, prop)
                    end
                end    
     
            end
        else
			TriggerEvent("ESX:Notify",Config.Text['cant_place_camp'],"error")
        end
        
    end, false)
end

function IsNearCampfire(coords)
    for i, prop in pairs(propSpawned) do
        if GetDistanceBetweenCoords(coords, GetEntityCoords(prop), true) < 3 then
            nearestCampfire = prop
            campfireIndex = i
            return true
        end
    end
    return false
end

function IsNearNOCampfire(coords)
    for k, v in pairs(Config.noCampfireZone) do
        if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.noCampfireZoneRadious then
            return true
        end
    end
    return false
end

function deleteCampfire(coords)
    if GetDistanceBetweenCoords(coords, GetEntityCoords(nearestCampfire), true) < 3.0 then
        TaskStartScenarioInPlace(player, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
        local finished = exports["pw-taskbar"]:taskBar(Config.CampPlacingTime, "Đang dập lửa", false, true, false, false, nil, 5.0)
        if finished then
            ClearPedTasksImmediately(player) 
            DeleteObject(nearestCampfire)
            table.remove(propSpawned, campfireIndex)
        end
    end
end


-----------------------------------------------------------[BAITS]------------------------------------------------------------
AddEventHandler("pw:target:changed", function(pEntity)
    targetedEntity = pEntity
end)

--[[ RegisterCommand("spawn1", function(source, args, rawCommand)
	RequestModel('a_c_deer')
    while not HasModelLoaded('a_c_deer') do
        Citizen.Wait(0)
    end
    CreatePed(28, 'a_c_deer', -1213.069, 5175.1337, 103.13581, 256.76654, false, false)
end, false) ]]




RegisterNetEvent('pw-hunting:client:lamthit')
AddEventHandler('pw-hunting:client:lamthit', function()
        --local currentTarget = exports['pw-interact'].GetCurrentEntity()
        local isAnimal = GetPedType(targetedEntity) == 5
		local model = GetEntityModel(targetedEntity)
        local myAnimal = targetedEntity
        local animal = getAnimalMatch(model)
		
        --if GetPedSourceOfDeath(targetedEntity) == player then  
			for k, v in pairs(Config.Animals) do
				if v.model == animal then
					specialItem = v.specialItem
					dimension = v.dimension
					bad = v.bad
					good = v.good
					perfect = v.perfect
					badmeat = v.badmeat
					goodmeat = v.goodmeat
					perfectmeat = v.perfectmeat
				end
			end
			local a, b = GetPedLastDamageBone(targetedEntity)
			if b == 31086 then
				WasPedShootedInHead = true
			else
				WasPedShootedInHead = false
			end
			local groupH = GetWeapontypeGroup(GetPedCauseOfDeath(targetedEntity))
			local groupName = WeaponGroups[groupH]
			for k, v in pairs(Config.WeaponDamages) do
				if v.category == groupName then
					dimensionLeather(v.small, v.medium, v.medBig, v.big)
				end
			end

			--table.remove(search, model123)
			animalsSpawnedCount = animalsSpawnedCount - 1

			local r = math.random(Config.MinLeather,Config.MaxLeather)
			if leatherToGive ~= nil and groupName ~= nil and not lamthit then
					
					lamthit = true
					SetCurrentPedWeapon(PlayerPedId(), -1569615261, true)
					TaskTurnPedToFaceEntity(PlayerPedId(), targetedEntity, -1)
					ensureAnimDict("amb@medic@standing@kneel@base")
					TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base", "base", 1.0, -1.0, -1, 1, 0, false, false, false)
					ensureAnimDict("anim@gangops@facility@servers@bodysearch@")
					TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@", "player_search" ,1.0, -1.0, -1, 1, 0, false, false, false)
					FreezeEntityPosition(PlayerPedId(), true)		

					local finished = exports["pw-taskbar"]:taskBar(Config.TimeToHarvest, "Đang làm thịt", false, true, false, false, nil, 5.0)

					
					--Citizen.Wait(Config.TimeToHarvest)
						if finished == 100 then
							ClearPedTasksImmediately(PlayerPedId())
							FreezeEntityPosition(PlayerPedId(), false)
							SetEntityCoords(myAnimal, -7763.0, 8610.0, -100.0)
							DecorRemove(myAnimal,"HuntingMySpawn")
							
							Sync.DeleteEntity(myAnimal)
							SetEntityAsNoLongerNeeded(myAnimal)
							SetModelAsNoLongerNeeded(myAnimal)
							lamthit = false
							
						end	
				
				TriggerServerEvent('pw-hunting:server:giveReward', leatherToGive, r)
				if Config.CanDropSpecial and not leatherIsBad then
					DropSpecialItem(specialItem)
				end
				if Config.CanDropMeat then
					for k, v in pairs(Config.WeaponDamages) do
						if v.category == groupName then
							dimensionMeat(v.smallmeat, v.mediummeat, v.medBigmeat, v.bigmeat)
						end
					end
					local rMeat = math.random(Config.MinMeat,Config.MaxMeat)
					TriggerServerEvent('pw-hunting:server:giveReward', meatToGive, 1)
				end
			elseif leatherToGive == nil or groupName == nil then
				TriggerEvent("ESX:Notify",Config.Text['ruined_leather'],"error")
				Citizen.Wait(2000)
			end

		--else 
			--TriggerEvent("ESX:Notify","Không phải là người giết","error")
		--end
		
end)


local trapSpawned = nil
RegisterNetEvent('pw-hunting:client:canPlaceBait')
AddEventHandler('pw-hunting:client:canPlaceBait', function()
    if IsEntityInWater(player) then
        TriggerServerEvent('pw-hunting:server:canPlaceBaitS', true)
    elseif not Config.huntAllMap and not IsInSpawnAnimalZone(GetEntityCoords(player)) then
        TriggerServerEvent('pw-hunting:server:canPlaceBaitS', true)
    else
        TriggerServerEvent('pw-hunting:server:canPlaceBaitS', false)
    end
end)

RegisterNetEvent('pw-hunting:client:bait')
AddEventHandler('pw-hunting:client:bait', function()
    --exports['progressBars']:startUI(Config.BaitPlacingTime, Config.Text['placing_bait'])
    exports["pw-taskbar"]:taskBar(Config.BaitPlacingTime, "Đang đặt mồi", false, true, false, false, nil, 5.0)
    TaskStartScenarioInPlace(player, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
    Citizen.Wait(Config.BaitPlacingTime)
    ClearPedTasksImmediately(player)
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(player, 0.0, 0.5, 0))
    local prop = CreateObject(GetHashKey("prop_food_burg1"), x, y, z, true, false, true)
    PlaceObjectOnGroundProperly(prop)
    trapSpawned = prop
    TrapPlaced(x, y, z)
end)

function TrapPlaced(x,y,z)
    local pos = coords
    local land = false
    local blipBait = nil

    local r = math.random(1, #Config.BaitAnimals)
    local pedModel = GetHashKey(Config.BaitAnimals[r])
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) or not HasCollisionForModelLoaded(pedModel) do
        Citizen.Wait(10)
    end

    while true do
        Citizen.Wait(5)
        baitRandX = math.random(-Config.BaitSpawnRadious, Config.BaitSpawnRadious)
        baitRandY = math.random(-Config.BaitSpawnRadious, Config.BaitSpawnRadious)
        if baitRandX > (Config.BaitSpawnRadious / 2) or baitRandX < (-Config.BaitSpawnRadious / 2) then
            if baitRandY > (Config.BaitSpawnRadious / 2) or baitRandY < (-Config.BaitSpawnRadious / 2) then
                break
            end
        end
    end

    X = pos.x + baitRandX
    Y = pos.y + baitRandY
    Z = pos.z + 999.0
    land, spawnZ = GetGroundZFor_3dCoord(X + .0, Y + .0, Z, 1)
    
    if land then
        trapEntity = CreatePed(28, pedModel, X, Y, spawnZ, 0.0, true, false)
        TaskWanderStandard(trapEntity, true, true)
        SetEntityAsMissionEntity(trapEntity, true, true)
        table.insert(search, trapEntity)
        TaskGoToEntity(trapEntity, trapSpawned, -1, 1.0, 1.0, 0, 0)
        if Config.BlipOnBaitAnimal then
            blipBait = AddBlipForEntity(trapEntity)
            SetBlipSprite(blipBait,442)
            SetBlipColour(blipBait,1)
            SetBlipScale(blipBait, 0.8)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Bait animal")
            EndTextCommandSetBlipName(blipBait)
        end
        while true do 
            if not IsPedDeadOrDying(trapEntity, true) then
                Citizen.Wait(200)
                if getTrapDistance(trapEntity, x, y, z) < 1.5 then
                    ensureAnimDict("amb@lo_res_idles@")
                    TaskPlayAnim(trapEntity, "amb@lo_res_idles@", "creatures_world_deer_grazing_lo_res_base", 1.0, -1.0, -1, 1, 0, false, false, false)
                    Citizen.Wait(Config.TimeForAnimalToLeave)
                    ClearPedTasksImmediately(trapEntity)
                    TaskWanderStandard(trapEntity, true, true)
                    break
                elseif getDistance(trapEntity) < Config.PNearAnimalToEscape and not IsPedStill(player) then
                    ClearPedTasksImmediately(trapEntity)
                    TaskSmartFleePed(trapEntity, player, 150.0, 20.0, false, false)
                    break
                end
            else
                if not IsPedAPlayer(GetPedCauseOfDeath(trapEntity)) and not IsPedHuman(GetPedCauseOfDeath(trapEntity)) and GetWeapontypeGroup(GetPedCauseOfDeath(ped)) == nil then
                    Citizen.Wait(10000)
                    --exports["mythic_notify"]:DoHudText("error", Config.Text['no_effects_bait'], 5000)
					TriggerEvent("ESX:Notify",Config.Text['no_effects_bait'],"error")
                end    
                break
            end
        end
        if Config.BlipOnBaitAnimal then
            RemoveBlip(blipBait)
        end
        Sync.DeleteEntity(trapSpawned)
        trapSpawned = nil
    end
end

function getTrapDistance(pedToGetCoords, x, y, z)
    return GetDistanceBetweenCoords(x, y, z, GetEntityCoords(pedToGetCoords, true))
end

----------------------------------------------------------[SELL]------------------------------------------------------------
local leatherElements = {}
local illegalLeatherElements = {}

RegisterNetEvent('pw-hunting:client:addElement')
AddEventHandler('pw-hunting:client:addElement', function(element, illegalMarket)
    if illegalMarket then
        table.insert(illegalLeatherElements, element)
    else
        table.insert(leatherElements, element)
    end
end)


