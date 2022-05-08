ESX = nil

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
local currentVehicle = 0
local blockedClasses = { 13, 14, 15, 16, 21 }
local enteredVehicle = false
local oldPos = nil


function ShowFloatingHelpNotification(msg, coords)
    AddTextEntry("FloatingHelpNotification", msg)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp("FloatingHelpNotification")
    EndTextCommandDisplayHelp(2, false, false, -1)
end

-- function updateVehicleHealth()
	-- local invehicle = IsPedInAnyVehicle(PlayerPedId(), true)
	-- local currentVehicle = GetVehiclePedIsIn(PlayerPedId())
	-- if currentVehicle == 0 or IsEntityDead(currentVehicle) then return end
	
    -- local plate = GetVehicleNumberPlateText(currentVehicle)
	-- local degHealth = json.decode(RPC.execute("pw-vehicles:getDegradation", plate))
    -- local body = math.ceil(GetVehicleBodyHealth(currentVehicle))
    -- local engine = math.ceil(GetVehicleEngineHealth(currentVehicle))

    -- TriggerServerEvent("pw-vehicles:updateVehicleHealth", plate, body, engine)
	
	
-- end

-- exports('updateVehicleHealth', updateVehicleHealth)

function getDegredation()
	local invehicle = IsPedInAnyVehicle(PlayerPedId(), true)
	local currentVehicle = GetVehiclePedIsIn(PlayerPedId())
		
    --if currentVehicle == 0 or has_value(blockedClasses, GetVehicleClass(currentVehicle)) then return end
	local plate = GetVehicleNumberPlateText(currentVehicle)
	local degHealth = json.decode(RPC.execute("pw-vehicles:getDegradation", plate))
	--TriggerEvent("table",json.decode(degHealth))
    


    if degHealth.injector <= 45 then
        local decayChance = math.random(10,100)
        if degHealth.injector <= 45 and degHealth.injector >= 25 then
            if decayChance > 99 then
                fuelInjector(currentVehicle,50)
            end
        elseif degHealth.injector <= 24 and degHealth.injector >= 15 then
            if decayChance > 98 then
                fuelInjector(currentVehicle,400)
            end
        elseif degHealth.injector <= 14 and degHealth.injector >= 9 then
            if decayChance > 97 then
                fuelInjector(currentVehicle,600)
            end
        elseif  degHealth.injector <= 8 and degHealth.injector >= 0 then
            if decayChance > 90 then
                fuelInjector(currentVehicle,1000)
            end
        end
    end

    if degHealth.radiator <= 35 then
        local engineHealth = GetVehicleEngineHealth(currentVehicle)
        if degHealth.radiator <= 35 and degHealth.radiator >= 20 then
            if engineHealth <= 1000 and engineHealth >= 700 then
                SetVehicleEngineHealth(currentVehicle, engineHealth-10)
            end
        elseif degHealth.radiator <= 19 and degHealth.radiator >= 10 then
            if engineHealth <= 1000 and engineHealth >= 500 then
                SetVehicleEngineHealth(currentVehicle, engineHealth-20)
            end
        elseif degHealth.radiator <= 9 and degHealth.radiator >= 0 then
            if engineHealth <= 1000 and engineHealth >= 200 then
                SetVehicleEngineHealth(currentVehicle, engineHealth-30)
            end
        end
    end

    if degHealth.axle <= 35 then
        local Chance = math.random(1,100)
        if degHealth.axle <= 35 and degHealth.axle >= 20 and Chance > 90 then
            for i=0,360 do
                SetVehicleSteeringScale(currentVehicle,i)
                Citizen.Wait(5)
            end
        elseif degHealth.axle <= 19 and degHealth.axle >= 10 and Chance > 70 then
            for i=0,360 do
                Citizen.Wait(10)
                SetVehicleSteeringScale(currentVehicle,i)
            end
        elseif degHealth.axle <= 9 and degHealth.axle >= 0 and Chance > 50 then
            for i=0,360 do
                Citizen.Wait(15)
                SetVehicleSteeringScale(currentVehicle,i)
            end
        end
    end

    if degHealth.transmission <= 35 then
        local speed = GetEntitySpeed(currentVehicle)
        local Chance = math.random(1,100)
        if degHealth.transmission <= 35 and degHealth.transmission >= 20 and Chance > 90 then
            for i=0,3 do
                if not IsPedInVehicle(PlayerPedId(),currentVehicle,false) then
                    return
                end
                Citizen.Wait(5)
                SetVehicleHandbrake(currentVehicle,true)
                Citizen.Wait(math.random(1000))
                SetVehicleHandbrake(currentVehicle,false)
            end
        elseif degHealth.transmission <= 19 and degHealth.transmission >= 10 and Chance > 70 then
            for i=0,5 do
                if not IsPedInVehicle(PlayerPedId(),currentVehicle,false) then
                    return
                end
                Citizen.Wait(10)
                SetVehicleHandbrake(currentVehicle,true)
                Citizen.Wait(math.random(1000))
                SetVehicleHandbrake(currentVehicle,false)
            end
        elseif degHealth.transmission <= 9 and degHealth.transmission >= 0 and Chance > 50 then
            for i=0,11 do
                if not IsPedInVehicle(PlayerPedId(),currentVehicle,false) then
                    return
                end
                Citizen.Wait(20)
                SetVehicleHandbrake(currentVehicle,true)
                Citizen.Wait(math.random(1000))
                SetVehicleHandbrake(currentVehicle,false)
            end
        end
    end

    if degHealth.electronics <= 35 then
        local Chance = math.random(1,100)
        if degHealth.electronics <= 35 and degHealth.electronics >= 20 and Chance > 90 then
            for i=0,10 do
                Citizen.Wait(50)
                electronics(currentVehicle)
            end
        elseif degHealth.electronics <= 19 and degHealth.electronics >= 10 and Chance > 70 then
            for i=0,10 do
                Citizen.Wait(100)
                electronics(currentVehicle)
            end
        elseif degHealth.electronics <= 9 and degHealth.electronics >= 0 and Chance > 50 then
            for i=0,10 do
                Citizen.Wait(200)
                electronics(currentVehicle)
            end
        end
    end

    if degHealth.brake <= 35 then
        local Chance = math.random(1,100)
        if degHealth.brake <= 35 and degHealth.brake >= 20 and Chance > 90 then
            SetVehicleHandbrake(currentVehicle,true)
            Citizen.Wait(1000)
            SetVehicleHandbrake(currentVehicle,false)
        elseif degHealth.brake <= 19 and degHealth.brake >= 10 and Chance > 70 then
            SetVehicleHandbrake(currentVehicle,true)
            Citizen.Wait(4500)
            SetVehicleHandbrake(currentVehicle,false)
        elseif degHealth.brake <= 9 and degHealth.brake >= 0 and Chance > 50 then
            SetVehicleHandbrake(currentVehicle,true)
            Citizen.Wait(7000)
            SetVehicleHandbrake(currentVehicle,false)
        end
    else
        SetVehicleHandbrake(currentVehicle,false)
    end

    if degHealth.clutch <= 35 then
        local Chance = math.random(1,100)
        if degHealth.clutch <= 35 and degHealth.clutch >= 20 and Chance > 90 then
            SetVehicleHandbrake(currentVehicle,true)
            fuelInjector(currentVehicle,50)
            for i=1,360 do
                SetVehicleSteeringScale(currentVehicle,i)
                Citizen.Wait(5)
            end
            Citizen.Wait(2000)
            SetVehicleHandbrake(currentVehicle,false)
        elseif degHealth.clutch <= 19 and degHealth.clutch >= 10 and Chance > 70 then
            SetVehicleHandbrake(currentVehicle,true)
            fuelInjector(currentVehicle,100)
            for i=1,360 do
                SetVehicleSteeringScale(currentVehicle,i)
                Citizen.Wait(5)
            end
            Citizen.Wait(5000)
            SetVehicleHandbrake(currentVehicle,false)
        elseif degHealth.clutch <= 9 and degHealth.clutch >= 0 and Chance > 50 then
            SetVehicleHandbrake(currentVehicle,true)
            fuelInjector(currentVehicle,200)
            for i=1,360 do
                SetVehicleSteeringScale(currentVehicle,i)
                Citizen.Wait(5)
            end
            Citizen.Wait(7000)
            SetVehicleHandbrake(currentVehicle,false)
        end
    end

    if degHealth.tire <= 35 then
        local Chance = math.random(1, 100)
        if degHealth.tire <= 35 and degHealth.tire >= 20 and Chance > 90 then
            tires(currentVehicle)
        elseif degHealth.tire <= 19 and degHealth.tire >= 10 and Chance > 70 then
            tires(currentVehicle)
        elseif degHealth.tire <= 9 and degHealth.tire >= 0 and Chance > 50 then
            tires(currentVehicle)
        end
    end
end

function fuelInjector(vehicle, wait)
	Sync.SetVehicleEngineOn(vehicle, 0, 0, 1)
	Sync.SetVehicleUndriveable(vehicle, true)
	Citizen.Wait(wait)
	Sync.SetVehicleEngineOn(vehicle, 1, 0, 1)
	Sync.SetVehicleUndriveable(vehicle, false)
end

function electronics(vehicle)
	SetVehicleLights(vehicle, 1)
	Citizen.Wait(600)
	SetVehicleLights(vehicle, 0)
end

function tires(vehicle)
    local wheels = { 0, 1, 4, 5 }
    local random = math.random(4)

    local tyre = -1
    for i = 1, 4 do
        local wheel = wheels[math.random(#wheels)]
        if IsVehicleTyreBurst(vehicle, wheel) then
            wheels[wheel] = nil
        else
            tyre = wheel
            break
        end
    end

    if tyre ~= -1 then
        SetVehicleTyreBurst(vehicle, tyre, true, 1000)
    end
end

function SetVehicleDamage(vehicle, body, engine)
	if not vehicle or not body or not engine then return end

    local smash = false
	local damageOutside = false
	local damageOutside2 = false

    body = body + 0.0
    engine = engine + 0.0

    if body < 950.0 then
        smash = true

        if body < 920.0 then
            damageOutside = true

            if body < 900.0 then
                body = 900.0
            end
        end
    end

    if engine < 200.0 then
        engine = 200.0
    end

    if smash then
        SmashVehicleWindow(vehicle, 0)
        SmashVehicleWindow(vehicle, 1)
        SmashVehicleWindow(vehicle, 2)
        SmashVehicleWindow(vehicle, 3)
        SmashVehicleWindow(vehicle, 4)
    end

    if damageOutside then
        SetVehicleDoorBroken(vehicle, 1, true)
        SetVehicleDoorBroken(vehicle, 6, true)
        SetVehicleDoorBroken(vehicle, 4, true)
    end

    SetVehicleBodyHealth(vehicle, body)
    SetVehicleEngineHealth(vehicle, engine)
end

function SetVehicleMileage(vehicle, value)
	if not DoesEntityExist(vehicle) then return end

	if value and type(value) == "number" then
		Sync.DecorSetInt(vehicle, "Vehicle-Mileage", value)
	end
end

function GetVehicleMileage(vehicle)
    if not DoesEntityExist(vehicle) then
		return
	end

	if not DecorExistOn(vehicle, "Vehicle-Mileage") then
		return
	end

	return DecorGetInt(vehicle, "Vehicle-Mileage")
end

--[[

    Events

]]

RegisterNetEvent("pw-vehicles:randomDegredation")
AddEventHandler("pw-vehicles:randomDegredation", function(vehicle, upperLimit, spinAmount)
	
    if not vehicle or not DoesEntityExist(vehicle) or has_value(blockedClasses, GetVehicleClass(vehicle)) then return end

    --local vid = GetVehicleIdentifier(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
	ESX.TriggerServerCallback('pw-mechanicjob:server:IsVehicleOwned', function(IsOwned)
		if IsOwned then 
			local degHealth = json.decode(RPC.execute("pw-vehicles:getDegradation", plate))

			local br = degHealth.brake
			local ax = degHealth.axle
			local rad = degHealth.radiator
			local cl = degHealth.clutch
			local tra = degHealth.transmission
			local elec = degHealth.electronics
			local fi = degHealth.injector
			local tire = degHealth.tire
			for i = 1, spinAmount do
				local chance =  math.random(0, 150)

				if chance <= 10 and chance >= 0 then
					br = br - math.random(0, upperLimit)
				elseif chance <= 20 and chance >= 11 then
					ax = ax - math.random(0, upperLimit)
				elseif chance <= 30 and chance >= 21 then
					rad = rad - math.random(0, upperLimit)
				elseif chance <= 40 and chance >= 31 then
					cl = cl - math.random(0, upperLimit)
				elseif chance <= 50 and chance >= 41 then
					tra = tra - math.random(0, upperLimit)
				elseif chance <= 60 and chance >= 51 then
					elec = elec - math.random(0, upperLimit)
				elseif chance <= 70 and chance >= 61 then
					fi = fi - math.random(0, upperLimit)
				elseif chance <= 80 and chance >= 71 then
					tire = tire - math.random(0, upperLimit)
				end
			end

			if br < 0 then br = 0 end
			if ax < 0 then ax = 0 end
			if rad < 0 then rad = 0 end
			if cl < 0 then cl = 0 end
			if tra < 0 then tra = 0 end
			if elec < 0 then elec = 0 end
			if fi < 0 then fi = 0 end
			if tire < 0 then tire = 0 end

			local degradations = {
				["brake"] = br,
				["axle"] = ax,
				["radiator"] = rad,
				["clutch"] = cl,
				["transmission"] = tra,
				["electronics"] = elec,
				["injector"] = fi,
				["tire"] = tire,
				["engine_damage"] = GetVehicleEngineHealth(vehicle), 
				["body_damage"] = GetVehicleBodyHealth(vehicle), 
				["fuel"] = math.floor(GetVehicleFuelLevel(vehicle)), 
				["dirty"] = math.floor(GetVehicleDirtLevel(vehicle)),
			}
			

			TriggerServerEvent("pw-vehicles:updateVehicleDegradation", plate, degradations)
		end
	end, plate)	
end)

RegisterNetEvent("pw-vehicles:examineVehicle")
AddEventHandler("pw-vehicles:examineVehicle", function(degradation)
    local vehicle = nil

    local target = exports["np-interact"]:GetCurrentEntity()
    if DoesEntityExist(target) and GetEntityType(target) == 2 and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(target)) < 5 then
        vehicle = target
    end

    if not vehicle then return end

    local vid = GetVehicleIdentifier(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)

    local tier = GetVehicleTier(vehicle)
    local mileage = RPC.execute("pw-vehicles:getMileage", plate)
    local degHealth = RPC.execute("pw-vehicles:getDegradation", plate)
    degHealth["body"] = round(GetVehicleBodyHealth(vehicle) / 10)
    degHealth["engine"] = round(GetVehicleEngineHealth(vehicle) / 10)

    local data = {
        {
            title = "Vehicle Information",
            description = "Class: " .. tier .. " | Mileage: " .. roundDecimals(mileage, 2),
        },
        {
            title = "Vehicle Diagnostics",
            children = {
                {
                    title = "Axle Tree",
                    description = "Current State: " .. degHealth.axle .. "% | Parts Required: " .. 0,
                },
                {
                    title = "Body",
                    description = "Current State: " .. degHealth.body .. "% | Parts Required: " .. 0,
                },
                {
                    title = "Brake Discs",
                    description = "Current State: " .. degHealth.brake .. "% | Parts Required: " .. 0,
                },
                {
                    title = "Clutch",
                    description = "Current State: " .. degHealth.clutch .. "% | Parts Required: " .. 0,
                },
                {
                    title = "Eletronics",
                    description = "Current State: " .. degHealth.electronics .. "% | Parts Required: " .. 0,
                },
                {
                    title = "Engine Block",
                    description = "Current State: " .. degHealth.engine .. "% | Parts Required: " .. 0,
                },
                {
                    title = "Engine Radiator",
                    description = "Current State: " .. degHealth.radiator .. "% | Parts Required: " .. 0,
                },
                {
                    title = "Fuel Injectors",
                    description = "Current State: " .. degHealth.injector .. "% | Parts Required: " .. 0,
                },
                {
                    title = "Transmission",
                    description = "Current State: " .. degHealth.transmission .. "% | Parts Required: " .. 0,
                },
                {
                    title = "Tyres",
                    description = "Current State: " .. degHealth.tire .. "% | Parts Required: " .. 0,
                },
            },
        },
    }

    exports["pw-context"]:showContextMenu(data)
end)

RegisterNetEvent("pw-vehicles:repairVehicle")
AddEventHandler("pw-vehicles:repairVehicle", function(type)
    local vehicle = nil

    local target = exports["np-interact"]:GetCurrentEntity()
    if DoesEntityExist(target) and GetEntityType(target) == 2 and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(target)) < 5 then
        vehicle = target
    end

    if not vehicle then return end

    local vid = GetVehicleIdentifier(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    local degHealth = RPC.execute("pw-vehicles:getDegradation", plate)
    local bodyHealth = GetVehicleBodyHealth(vehicle)
    local engineHealth = GetVehicleEngineHealth(vehicle)
    local tier = GetVehicleTier(vehicle)

    if tier == "X" then
        tier = "S"
    end

    local item = string.lower(tier) .. "fix" .. type
    if not exports["pw-inventory"]:hasEnoughOfItem(item, 1, true) then return end

    TriggerEvent("inventory:removeItem", item, 1)

    Citizen.Wait(100)

    RequestAnimDict("mp_car_bomb")
	TaskPlayAnim(PlayerPedId(), "mp_car_bomb","car_bomb_mechanic", 8.0, -8, -1, 49, 0, 0, 0, 0)
	Citizen.Wait(100)
	TaskPlayAnim(PlayerPedId(), "mp_car_bomb","car_bomb_mechanic", 8.0, -8, -1, 49, 0, 0, 0, 0)

	local finished = exports["np-taskbar"]:taskBar(15000, "Repairing")
    if finished then
        if type == "body" then
            SetVehicleBodyHealth(vehicle, 1000.0)
            SetVehicleFixed(vehicle)
			SetVehiclePetrolTankHealth(vehicle, 4000.0)

            for i = 0, 4 do
                SetVehicleTyreFixed(vehicle, i)
            end

            --updateVehicleHealth()
        elseif type == "engine" then
            SetVehicleEngineHealth(vehicle, 1000.0)
            SetVehicleFixed(vehicle)
			SetVehiclePetrolTankHealth(vehicle, 4000.0)

            --updateVehicleHealth()
        else
            if type == "tire" then
                for i = 0, 4 do
                    SetVehicleTyreFixed(vehicle, i)
                end
            end

            degHealth[type] = 100
            TriggerServerEvent("pw-vehicles:updateVehicleDegradation", plate, degHealth)
        end
    end

    ClearPedTasks(PlayerPedId())
end)

AddEventHandler("pw-vehicles:repairKitbennys", function(pItemDBID)
    local vehicle = nil

    local target = exports["pw-target"]:GetCurrentEntity()
    if DoesEntityExist(target) and GetEntityType(target) == 2 and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(target)) < 5 then
        vehicle = target
    end

    if not vehicle then return end

    local d1, d2 = GetModelDimensions(GetEntityModel(vehicle))
    local moveto = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, d2.y + 0.5, 0.0)
    local dist = #(vector3(moveto.x, moveto.y, moveto.z) - GetEntityCoords(PlayerPedId()))

    for i=1, 1000 do
        dist = #(vector3(moveto.x, moveto.y, moveto.z) - GetEntityCoords(PlayerPedId()))

        if dist < 1.0 then
            break
        end

        ShowFloatingHelpNotification("Mova-se até aqui para reparar", vector3(moveto.x, moveto.y, moveto.z))

        Citizen.Wait(1)
    end

    if fixingvehicle or dist >= 1.0 then return end

    fixingvehicle = true

    TriggerEvent("animation:repair", vehicle)

    for i = 1, 5 do
        local skill = {50000, 20}

        if i == 2 then
            skill = {40000, 20}
        elseif i == 3 then
            skill = {30000, 18}
        elseif i == 4 then
            skill = {20000, 18}
        elseif i == 5 then
            skill = {10000, 15}
        end

        local finished = exports["pw-taskbarskill"]:taskBarSkill(skill[1],  skill[2])
        if finished ~= 100 then
            ClearPedTasks(PlayerPedId())
            fixingvehicle = false
            return
        end
    end

    TriggerServerEvent("inventory:degItem", pItemDBID, 50, "repairkitbennys", exports["pw-base"]:getChar("id"))

    if GetVehicleEngineHealth(vehicle) < 1000.0 then
        SetVehicleEngineHealth(vehicle, 1000.0)
        SetVehicleBodyHealth(vehicle, 1000.0)
        SetVehicleFixed(vehicle)
        SetVehiclePetrolTankHealth(vehicle, 4000.0)
    end

    for i = 0, 5 do
        SetVehicleTyreFixed(vehicle, i)
    end
    --updateVehicleHealth()
    ClearPedTasks(PlayerPedId())

    fixingvehicle = false
end)

AddEventHandler("animation:repair", function(pVehicle)
    Sync.SetVehicleDoorOpen(pVehicle, 4, 0, 0)

    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end

    TaskTurnPedToFaceEntity(PlayerPedId(), pVehicle, 1.0)

    Citizen.Wait(1000)

    while fixingvehicle do
        local anim = IsEntityPlayingAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 3)
        if not anim then
            TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end

    Sync.SetVehicleDoorShut(pVehicle, 4, 1, 1)
end)

AddEventHandler("pw-inventory:itemUsed", function(item, info, inventory, slot, dbid)
    if item == "repairkit" then
        TriggerEvent("pw-vehicles:repairKit", dbid)
    end
end)

AddEventHandler("pw-inventory:itemUsed", function(item, info, inventory, slot, dbid)
    if item == "repairkitbennys" then
        TriggerEvent("pw-vehicles:repairKitbennys", dbid)
    end
end)

AddEventHandler("baseevents:enteredVehicle", function(pCurrentVehicle, pCurrentSeat, vehicleDisplayName)
    if pCurrentSeat == -1 then
        currentVehicle = pCurrentVehicle
        enteredVehicle = true
    end
end)

AddEventHandler("baseevents:leftVehicle", function(pCurrentVehicle, pCurrentSeat, vehicleDisplayName)
    currentVehicle = 0
    enteredVehicle = false
    oldPos = nil
end)

AddEventHandler("baseevents:vehicleChangedSeat", function(pCurrentVehicle, pCurrentSeat, previousSeat)
    if pCurrentSeat == -1 then
        currentVehicle = pCurrentVehicle
        enteredVehicle = true
    else
        currentVehicle = 0
        enteredVehicle = false
        oldPos = nil
    end
end)

--[[

    Threads

]]


AddEventHandler("pw-vehicles:repairKit", function(pItemDBID)
    local vehicle = nil

    local target = exports["pw-interact"]:GetCurrentEntity()
    if DoesEntityExist(target) and GetEntityType(target) == 2 and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(target)) < 5 then
        vehicle = target
    end

    if not vehicle then return end

    local d1, d2 = GetModelDimensions(GetEntityModel(vehicle))
    local moveto = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, d2.y + 0.5, 0.0)
    local dist = #(vector3(moveto.x, moveto.y, moveto.z) - GetEntityCoords(PlayerPedId()))

    for i=1, 1000 do
        dist = #(vector3(moveto.x, moveto.y, moveto.z) - GetEntityCoords(PlayerPedId()))

        if dist < 1.0 then
            break
        end

        ShowFloatingHelpNotification("Mova-se até aqui para reparar", vector3(moveto.x, moveto.y, moveto.z))

        Citizen.Wait(1)
    end

    if fixingvehicle or dist >= 1.0 then return end

    fixingvehicle = true

    TriggerEvent("animation:repair", vehicle)

    for i = 1, 5 do
        local skill = {50000, 20}

        if i == 2 then
            skill = {40000, 20}
        elseif i == 3 then
            skill = {30000, 18}
        elseif i == 4 then
            skill = {20000, 18}
        elseif i == 5 then
            skill = {10000, 15}
        end

        local finished = exports["pw-taskbarskill"]:taskBarSkill(skill[1],  skill[2])
        if finished ~= 100 then
            ClearPedTasks(PlayerPedId())
            fixingvehicle = false
            return
        end
    end

    TriggerServerEvent("inventory:degItem", pItemDBID, 50, "repairkit", exports["pw-base"]:getChar("id"))

    if GetVehicleEngineHealth(vehicle) < 1000.0 then
        SetVehicleEngineHealth(vehicle, 1000.0)
    end

    for i = 0, 5 do
        SetVehicleTyreFixed(vehicle, i)
    end

    ClearPedTasks(PlayerPedId())

    fixingvehicle = false
end)

AddEventHandler("animation:repair", function(pVehicle)
    Sync.SetVehicleDoorOpen(pVehicle, 4, 0, 0)

    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end

    TaskTurnPedToFaceEntity(PlayerPedId(), pVehicle, 1.0)

    Citizen.Wait(1000)

    while fixingvehicle do
        local anim = IsEntityPlayingAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 3)
        if not anim then
            TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end

    Sync.SetVehicleDoorShut(pVehicle, 4, 1, 1)
end)

AddEventHandler("pw-inventory:itemUsed", function(item, info, inventory, slot, dbid)
    if item == "repairkit" then
        TriggerEvent("pw-vehicles:repairKit", dbid)
    end
end)

AddEventHandler("baseevents:enteredVehicle", function(pCurrentVehicle, pCurrentSeat, vehicleDisplayName)
    if pCurrentSeat == -1 then
        currentVehicle = pCurrentVehicle
        enteredVehicle = true
    end
end)

AddEventHandler("baseevents:leftVehicle", function(pCurrentVehicle, pCurrentSeat, vehicleDisplayName)
    currentVehicle = 0
    enteredVehicle = false
    oldPos = nil
end)

AddEventHandler("baseevents:vehicleChangedSeat", function(pCurrentVehicle, pCurrentSeat, previousSeat)
    if pCurrentSeat == -1 then
        currentVehicle = pCurrentVehicle
        enteredVehicle = true
    else
        currentVehicle = 0
        enteredVehicle = false
        oldPos = nil
    end
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    local tick = 0
	local rTick = 0

    while true do
		local invehicle = IsPedInAnyVehicle(PlayerPedId(), true)
		
		
        if invehicle then
			currentVehicle = GetVehiclePedIsIn(PlayerPedId())
            tick = tick + 1
			rTick = rTick + 1
			

            if tick >= 5 then
				getDegredation()
				--updateVehicleHealth()
				tick = 0
			end
			
			if rTick >= 5 then
				TriggerEvent("pw-vehicles:randomDegredation", currentVehicle, 1, 3)
				rTick = 0
			end
        else

        end

        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)

        if currentVehicle ~= 0 then
			
            local vid = GetVehicleIdentifier(currentVehicle)
            local plate = GetVehicleNumberPlateText(currentVehicle)

            if plate then
                local newPos = GetEntityCoords(PlayerPedId())

                if oldPos == nil then
                    oldPos = newPos
                end

                if #(newPos - oldPos) > 10.0 then
                    oldPos = newPos

                    local update = GetEntitySpeed(currentVehicle) * 1.0 / 100
					print(update)
                    TriggerServerEvent("pw-vehicles:updateVehicleMileage", plate, update)
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)