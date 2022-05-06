ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

local validHuntingZones = nil
local animals = nil
local baitDistanceInUnits = nil
local spawnDistanceRadius = nil

local baitLocation = nil
local baitLastPlaced = 0
local targetedEntity = nil

local animalList = {
    { name = "Boar", hash = `a_c_boar` },
    { name = "Cat", hash = `a_c_cat_01` },
    { name = "Chicken", hash = `a_c_chickenhawk` },
    { name = "Chimp", hash = `a_c_chimp` },
    { name = "Chop", hash = `a_c_chop` },
    { name = "Cormorant", hash = `a_c_cormorant` },
    { name = "Cow", hash = `a_c_cow` },
    { name = "Coyote", hash = `a_c_coyote` },
    { name = "Crow", hash = `a_c_crow` },
    { name = "Deer", hash = `a_c_deer` },
    { name = "Hen", hash = `a_c_hen` },
    { name = "Husky", hash = `a_c_husky` },
    { name = "Mountain-Lion", hash = `a_c_mtlion` },
    { name = "Pig", hash = `a_c_pig` },
    { name = "Pigeon", hash = `a_c_pigeon` },
    { name = "Poodle", hash = `a_c_poodle` },
    { name = "Pug", hash = `a_c_pug` },
    { name = "Rabbit", hash = `a_c_rabbit_01` },
    { name = "Rat", hash = `a_c_rat` },
    { name = "Retriever", hash = `a_c_retriever` },
    { name = "Chimp", hash = `a_c_rhesus` },
    { name = "Rottweiler", hash = `a_c_rottweiler` },
    { name = "Seagull", hash = `a_c_seagull` },
    { name = "Shepherd", hash = `a_c_shepherd` },
    { name = "Westy", hash = `a_c_westy` },
    { name = "Panther", hash = `a_c_panther` },
}

DecorRegister("HuntingMySpawn", 2)
DecorRegister("HuntingIllegal", 2)

local buffStartTime = 0
local buffItems = {
  ["beefdish"] = true,
  ["beefdishc"] = true,
}
AddEventHandler("buffs:triggerBuff", function(item)
  if not buffItems[item] then return end
  if buffStartTime ~= 0 then return end
  buffStartTime = GetGameTimer()
  Citizen.CreateThread(function()
    Citizen.Wait(60000 * 60) -- 1hr
    buffStartTime = 0
  end)
end)

Citizen.CreateThread(function()
   local playerPed = PlayerPedId()
   
   local createdPeds = {}
   local pedcreated = false
    while true do
	local pos = GetEntityCoords(PlayerPedId())
	local dst = #(pos - vector3(-679.1514, 5839.5791, 17.33142))
	Citizen.Wait(15)	    
		-- if dst <= 5 then	
			-- if IsControlJustPressed(1, 38) and IsPedInAnyVehicle(GetPlayerPed(-1), false) ~= 1 then
				
				-- TriggerEvent('pw:dialog:open',{
					-- {text = "Bán cá", event = "fishingame:banca", server = false ,},
					-- {text = "Mua đồ", event = 'server-inventory-open', server = false, args1 = "101", args2 = "Shop"  },
					-- {text = "Thuê thuyền", event = 'fishingame:spawnboat', server = false  },
					-- {text = "Không có việc gì", event = "pw:close:dialog", server = false, },    
				-- },'Ngư dân', 'Với chúng tôi, biển cả là nhà.' )
				
					
			-- end
		-- end
		if dst <= 50 and pedcreated == false then
				pedcreated = true
				local pedModel = "cs_josef"
			
				RequestModel(pedModel)
				while not HasModelLoaded(pedModel) do
					RequestModel(pedModel)
					Wait(100)
				end
			
				local createdPed1 = CreatePed(5, pedModel, -679.1514, 5839.5791, 17.33142 - 1.0, 221.446, false, false)
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
			
				

		elseif dst > 50 and pedcreated == true then
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
	end
end)

AddEventHandler("np:target:changed", function(pEntity)
    targetedEntity = pEntity
end)


function isValidZone()
    local zoneInH = GetNameOfZone(GetEntityCoords(PlayerPedId()))
	
    for _, zone in pairs(Config.HuntingZones) do
        if zoneInH == zone then
            return true
        end
    end
end

RegisterCommand("spawn1", function(source, args, rawCommand)
	RequestModel(0xE71D5E68)
    while not HasModelLoaded(0xE71D5E68) do
        Citizen.Wait(0)
    end
    CreatePed(28, 0xE71D5E68, -604.3114, 5674.976, 37.71714, 326.64, false, false)
end, false)

local function getSpawnLoc()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local spawnCoords = nil
    while spawnCoords == nil do
        local spawnX = math.random(-100, 100)
        local spawnY = math.random(-100, 100)
        local spawnZ = baitLocation.z
        local vec = vector3(baitLocation.x + spawnX, baitLocation.y + spawnY, spawnZ)
        if #(playerCoords - vec) > 20 then
            spawnCoords = vec
        end
    end
    local worked, groundZ, normal = GetGroundZAndNormalFor_3dCoord(spawnCoords.x, spawnCoords.y, 1023.9)
    spawnCoords = vector3(spawnCoords.x, spawnCoords.y, groundZ)
    return spawnCoords
end

function spawnAnimal(loc)
    
    local foundAnimal = 0
	local foundRepeat = false
	repeat 
	local rnd = math.random(15)
		if math.random(100) >= Config.AnimalList[rnd].chance then
			if rnd == 3 or rnd == 4 then
				if math.random(100) < 90 then
					foundAnimal = rnd
					foundRepeat = true	
					
				end
			else
				foundAnimal = rnd
				foundRepeat = true
			end
		end	
	
    -- for _, animal in pairs(Config.AnimalList) do
		
		
        -- if foundAnimal == false and animal.chance > chance then
            -- foundAnimal = animal
			-- print('true')
        -- end
    -- end
	until foundRepeat
	--foundAnimal.hash
    modelName = Config.AnimalList[foundAnimal].hash
	RequestModel(modelName)
    while not HasModelLoaded(tonumber(modelName)) do
        Citizen.Wait(0)
		RequestModel(tonumber(modelName))
    end
	--CreatePed(28, -664053099, -604.3114, 5674.976, 37.71714, 326.64, false, false)
    local spawnLoc = getSpawnLoc()
    spawnedAnimal = CreatePed(28, tonumber(modelName), spawnLoc,true, true, false)
    DecorSetBool(spawnedAnimal, "HuntingMySpawn", true)
    DecorSetBool(spawnedAnimal, "HuntingIllegal", Config.AnimalList[foundAnimal].illegal)
    
    if Config.AnimalList[foundAnimal].illegal then
        --TriggerEvent("civilian:alertPolice",50.0,"hunt-illegal",0,false,false)
		
    end
    
    SetModelAsNoLongerNeeded(tonumber(modelName))
    TaskGoStraightToCoord(spawnedAnimal, loc, 2.0, -1, 0.0, 0.0)
    Citizen.CreateThread(function()
        local finished = false
        while not IsPedDeadOrDying(spawnedAnimal) and not finished do
            local spawnedAnimalCoords = GetEntityCoords(spawnedAnimal)
            if #(loc - spawnedAnimalCoords) < 0.5 then
                ClearPedTasks(spawnedAnimal)
                Citizen.Wait(1500)
                TaskStartScenarioInPlace(spawnedAnimal, "WORLD_DEER_GRAZING", 0, true)
                Citizen.SetTimeout(7500, function()
                    finished = true
                end)
            end
            if #(spawnedAnimalCoords - GetEntityCoords(PlayerPedId())) < 15.0 then
                ClearPedTasks(spawnedAnimal)
                TaskSmartFleePed(spawnedAnimal, PlayerPedId(), 600.0, -1)
                finished = true
            end
            Citizen.Wait(1000)
        end
        if not IsPedDeadOrDying(spawnedAnimal) then
            TaskSmartFleePed(spawnedAnimal, PlayerPedId(), 600.0, -1)
        end
    end)
end

local function baitDown()
    Citizen.CreateThread(function()
        while baitLocation ~= nil do
            local coords = GetEntityCoords(PlayerPedId())
            if #(baitLocation - coords) > 20 then
				
                 if math.random() < Config.ChanceToSpawnAnimal then
					TriggerEvent("ESX:Notify", "Hình như có động tĩnh gì đó","info")
                    spawnAnimal(baitLocation)
                    baitLocation = nil
                end
            end
            Citizen.Wait(15000)
        end
    end)
end

local skinnedHumans = {}
AddEventHandler("pw-inventory:itemUsed", function(item)
    if item == "huntingbait" then
        if not isValidZone() then
            TriggerEvent("ESX:Notify", "Chỗ này không phải chỗ để săn bắt","error")
            return
        end
        if baitLastPlaced ~= 0 and GetGameTimer() < (baitLastPlaced + (60000 * 2)) then -- 10 minutes
            TriggerEvent("ESX:Notify", "Bãi mồi vẫn còn đó. Xin hãy di chuyển sang khu vực khác","error")
            return
        end
        baitLocation = nil
        --TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
        local finished = exports["np-taskbar"]:taskBar(1500, "Placing Bait", false, true, false, false, nil, 5.0, PlayerPedId())
        ClearPedTasks(PlayerPedId())
        if finished ~= 100 then
            baitLocation = nil
            TriggerEvent("DoLongHudText", "Placement Cancelled", 2)
            return
        end
        --TriggerEvent("evidence:dna","Animal-Bait")
        baitLastPlaced = GetGameTimer()
        baitLocation = GetEntityCoords(PlayerPedId())
        TriggerEvent("inventory:removeItem", item, 1)
		TriggerEvent("ESX:Notify","Đã đặt mồi nhử thành công. Giờ hãy tìm chỗ để chờ","info")
        baitDown()
    end
	if item == "huntingknife" then
		local isAnimal = GetPedType(targetedEntity) == 28
		
		if not isAnimal then
            TriggerEvent("DoLongHudText", "Không tìm thấy con thú này", 2)
            return
        end
		
		local myAnimal = targetedEntity
		local animalName = GetAnimalName(myAnimal)
		if animalName == 'Seagull' then
			TaskTurnPedToFaceEntity(PlayerPedId(), myAnimal, -1)
			DeleteEntity(targetedEntity)
			Citizen.Wait(1500)
			ClearPedTasksImmediately(PlayerPedId())
			TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
			local finished = exports["np-taskbar"]:taskBar(30000, text, false, true, false, false, nil, 5.0, targetedEntity)
			if finished ~= 100 then
				ClearPedTasksImmediately(PlayerPedId())
				TriggerEvent("DoLongHudText", "Preparing Cancelled", 2)
				return
			end
			
			TriggerServerEvent("hunting:GetItem",NetworkGetNetworkIdFromEntity(myAnimal),illegalSpawn,animalName)
		else
			TriggerEvent('ESX:Notify',"Chỉ có thể dùng cái này để vợt mòng biển bị rớt","error")
		end	
		
	end	
	
    if item == "huntingknife" then
        local isAnimal = GetPedType(targetedEntity) == 28
        local isHuman = GetPedType(targetedEntity) == 4 or GetPedType(targetedEntity) == 5
        if (not isAnimal and not isHuman) or not IsPedDeadOrDying(targetedEntity) then
            TriggerEvent("DoLongHudText", "Không tìm thấy con thú này", 2)
            return
        end
        local myAnimal = targetedEntity
        TaskTurnPedToFaceEntity(PlayerPedId(), myAnimal, -1)
		DeleteEntity(targetedEntity)
        Citizen.Wait(1500)
        ClearPedTasksImmediately(PlayerPedId())
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
        local text = isAnimal and "Preparing Animal" or "Preparing"
        local finished = exports["np-taskbar"]:taskBar(30000, text, false, true, false, false, nil, 5.0, targetedEntity)
        if finished ~= 100 then
            ClearPedTasksImmediately(PlayerPedId())
            TriggerEvent("DoLongHudText", "Preparing Cancelled", 2)
            return
        end

        if isHuman and not isAnimal then
            if skinnedHumans[targetedEntity] then
                return
            end

            skinnedHumans[targetedEntity] = true
            ClearPedTasks(PlayerPedId())
            ClearPedSecondaryTask(PlayerPedId())
            TriggerEvent("client:newStress", true, 150)
            TriggerEvent("evidence:dna","Human remains")
            TriggerEvent("Evidence:StateSet",28,1200)
            TriggerEvent("player:receiveItem", "questionablemeat", 1)
            if math.random() < 0.2 then
              TriggerServerEvent('loot:useItem', "deadhuman")
            end
            return
        end

        -- this is a model to leave it up the 
        local animalName = GetAnimalName(myAnimal)
        ClearPedTasks(PlayerPedId())
        ClearPedSecondaryTask(PlayerPedId())
        local mySpawn = DecorExistOn(myAnimal, "HuntingMySpawn") and DecorGetBool(myAnimal, "HuntingMySpawn")
        local illegalSpawn = DecorExistOn(myAnimal, "HuntingIllegal") and DecorGetBool(myAnimal, "HuntingIllegal")
        --RPC.execute("np-hunting:getSkinnedItem", NetworkGetNetworkIdFromEntity(myAnimal), mySpawn, illegalSpawn, animalName, buffStartTime ~= 0)
		TriggerServerEvent("hunting:GetItem",NetworkGetNetworkIdFromEntity(myAnimal),illegalSpawn,animalName)
		DecorRemove(myAnimal,"HuntingIllegal")
		DecorRemove(myAnimal,"HuntingMySpawn")
        TriggerEvent("client:newStress", true, 150)
    end
end)


function GetAnimalName(myAnimal)
    local animalHash = GetEntityModel(myAnimal)
    local animalDNA = "Unknown-Animal"
    for i,v in ipairs(animalList) do
        if v.hash == animalHash then
            animalDNA = v.name
        end
    end
    return animalDNA
end
