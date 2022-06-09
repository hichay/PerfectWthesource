
	ESX = nil
    
	RegisterFontFile("font")
    fontId = RegisterFontId("Oswald")
	
	Citizen.CreateThread(function()
		while not ESX do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(100)
		end
	end)


local fuelSynced = false

function ManageFuelUsage(vehicle)
	if not DecorExistOn(vehicle, Config.FuelDecor) then
		SetFuel(vehicle, math.random(200, 800) / 10)
	elseif not fuelSynced then
		SetFuel(vehicle, GetFuel(vehicle))
		fuelSynced = true
	end
	if IsVehicleEngineOn(vehicle) then
		SetFuel(vehicle, GetVehicleFuelLevel(vehicle) - Config.FuelUsage[Round(GetVehicleCurrentRpm(vehicle), 1)] * (Config.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
		SetVehicleEngineOn(veh, true, true, true)
	else
		SetVehicleEngineOn(veh, true, true, true)
	end
end



RegisterNetEvent('pw-gasSations:buyPetrolCan')
AddEventHandler('pw-gasSations:buyPetrolCan', function()
    local refuel = RPC.execute("pw-gasSations:refuel", 200, 10)
    if not refuel then return end

    TriggerEvent("player:receiveItem","883325847",1) 
end)

RegisterNetEvent('pw-gasSations:RefillPetrolCan')
AddEventHandler("pw-gasSations:RefillPetrolCan",function(params)
    local refuel = RPC.execute("pw-gasSations:refuel", params.price, params.tax)
    if not refuel then return end

    LoadAnimDict("weapon@w_sp_jerrycan")
    TaskPlayAnim(PlayerPedId(), "weapon@w_sp_jerrycan", "fire", 8.0, 1.0, -1, 1, 0, 0, 0, 0)
    local finished = exports["pw-taskbar"]:taskBar(10000, "Đổ xăng vào thùng")
    TriggerEvent("actionbar:ammo", -899475295, 4500, true)

    ClearPedTasksImmediately(PlayerPedId())
end)

AddEventHandler("pw-vehicles:refuel",function(data)
    local vehicle = nil
    if not data.isJerryCan then 
        local target = exports["pw-interact"]:GetCurrentEntity()
        if DoesEntityExist(target) and GetEntityType(target) == 2 and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(target)) < 5 then
            vehicle = target
        end

        if not vehicle then return end

        local curFuel = GetVehicleFuelLevel(vehicle)
        if not curFuel or curFuel == 100 then return end

        local price = (100 - curFuel) * 3
        local tax = RPC.execute("pw-balance:priceWithTax", price, "Services")
        local data = {
            {
                icon = "gas-pump",
                title = "Trạm xăng",
                description = "$" .. tax.total .. " Bao gồm:. " .. tax.percent .. "% thuế",
                action = "pw-vehicles:refuelVehicle",
                key = {
                    price = tax.total,
                    tax = tax.tax,
                    vehicle = VehToNet(vehicle),
                },
            }
        }

        exports["pw-context"]:showContextMenu(data)
    else
        local price = 200
        local tax = RPC.execute("pw-balance:priceWithTax", price, "Services")
        local data = {
            {
                icon = "gas-pump",
                title = "Trạm xăng",
                description = "$" .. tax.total .. " Bao gồm: " .. tax.percent .. "% thuế",
                action = "pw-gasSations:RefillPetrolCan",
                key = {
                    price = tax.total,
                    tax = tax.tax
                },
            }
        }

        exports["pw-context"]:showContextMenu(data)
    end
end)


AddEventHandler("pw-vehicles:refuelVehicle",function(params)
    local gasProp = 0
	local gasNozzle = "prop_cs_fuel_nozle"
    
    if not params.isJerryCan then 
        local vehicle = NetToVeh(params.vehicle)
        local vehicleCoords = GetEntityCoords(vehicle)
        if not vehicle or not DoesEntityExist(vehicle) or GetEntityType(vehicle) ~= 2 or #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(vehicle)) > 5 then
            return
        end

        local curFuel = math.floor(GetFuel(vehicle))
        if not curFuel or curFuel == 100 then return end

        local refuel = RPC.execute("pw-gasSations:refuel", params.price, params.tax)

        if not refuel then return end

        ClearPedSecondaryTask(PlayerPedId())

        RequestAnimDict("amb@world_human_security_shine_torch@male@base")
		while not HasAnimDictLoaded('amb@world_human_security_shine_torch@male@base') do Wait(100) end
		TaskPlayAnim(PlayerPedId(), "amb@world_human_security_shine_torch@male@base", "base", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
        gasProp = CreateObject(gasNozzle, 1.0, 1.0, 1.0, 1, 1, 0)
		local bone = GetPedBoneIndex(PlayerPedId(), 60309)
		AttachEntityToEntity(gasProp, PlayerPedId(), bone, 0.0, 0.0, 0.05, 350.0, 350.0, 250.0, 1, 1, 0, 0, 2, 1)

        local finished = exports["pw-taskbar"]:taskBar((100 - curFuel) * 200, "Đổ xăng")
        if GetIsVehicleEngineRunning(vehicle) and Config.VehicleBlowUp then
            local Chance = math.random(1, 100)
            if Chance <= Config.BlowUpChance then
                AddExplosion(vehicleCoords, 5, 50.0, true, false, true)
                return
            end
        end

        if finished == 100 then
            SetFuel(vehicle, 100)
            PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
            DeleteObject(gasProp)
        else
            local curFuel = GetVehicleFuelLevel(vehicle)
            local endFuel = (100 - curFuel)
            endFuel = math.ceil(endFuel * (finished / 100) + curFuel)

            SetFuel(vehicle, endFuel)
            PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
            DeleteObject(gasProp)
        end

        ClearPedTasksImmediately(PlayerPedId())
    else 

        local target = exports["pw-interact"]:GetCurrentEntity()
        vehicle = target
        if not vehicle or not DoesEntityExist(vehicle) or GetEntityType(vehicle) ~= 2 or #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(vehicle)) > 5 then
            return
        end
        local curFuel = math.floor(GetFuel(vehicle))
        local ammo = math.floor(GetPedAmmoByType(PlayerPedId(),-899475295)/45)

        if not curFuel or curFuel == 100 then return end
        if ammo >= (100 - curFuel) then
            ClearPedSecondaryTask(PlayerPedId())
            LoadAnimDict("weapon@w_sp_jerrycan")
            TaskPlayAnim(PlayerPedId(), "weapon@w_sp_jerrycan", "fire", 8.0, 1.0, -1, 1, 0, 0, 0, 0)

            local finished = exports["pw-taskbar"]:taskBar(10000, "Đổ xăng vào xe")

            if GetIsVehicleEngineRunning(vehicle) and Config.VehicleBlowUp then
                local Chance = math.random(1, 100)
            if Chance <= Config.BlowUpChance then
                AddExplosion(vehicleCoords, 5, 50.0, true, false, true)
                    return
                end
            end
            local decrease = (100 - curFuel) * 45
            if finished == 100 then
                SetFuel(vehicle, 100)
                TriggerEvent("actionbar:ammo", -899475295, decrease, false)
            end

            ClearPedTasksImmediately(PlayerPedId())
        else
            ClearPedSecondaryTask(PlayerPedId())
            LoadAnimDict("weapon@w_sp_jerrycan")
            TaskPlayAnim(PlayerPedId(), "weapon@w_sp_jerrycan", "fire", 8.0, 1.0, -1, 1, 0, 0, 0, 0)
            TriggerEvent("actionbar:ammo", -899475295, GetPedAmmoByType(PlayerPedId(),-899475295), false)
            local finished = exports["pw-taskbar"]:taskBar(10000, "Đổ xăng vào xe")

            if GetIsVehicleEngineRunning(vehicle) and Config.VehicleBlowUp then
                local Chance = math.random(1, 100)
                if Chance <= Config.BlowUpChance then
                    AddExplosion(vehicleCoords, 5, 50.0, true, false, true)
                    return
                end
            end
            if finished == 100 then
                SetFuel(vehicle, curFuel + ammo)
            end

            ClearPedTasksImmediately(PlayerPedId())
            
        end
    end
end)


CreateThread(function()
	DecorRegister(Config.FuelDecor, 1)
	for index = 1, #Config.Blacklist do
		if type(Config.Blacklist[index]) == 'string' then
			Config.Blacklist[GetHashKey(Config.Blacklist[index])] = true
		else
			Config.Blacklist[Config.Blacklist[index]] = true
		end
	end
	for index = #Config.Blacklist, 1, -1 do
		Config.Blacklist[index] = nil
	end
	while true do
		Wait(1000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
			if Config.Blacklist[GetEntityModel(vehicle)] then
				inBlacklisted = true
			else
				inBlacklisted = false
			end
			if not inBlacklisted and GetPedInVehicleSeat(vehicle, -1) == ped then
				ManageFuelUsage(vehicle)
			end
		else
			if fuelSynced then
				fuelSynced = false
			end
			if inBlacklisted then
				inBlacklisted = false
			end
		end
	end
end)

if Config.LeaveEngineRunning then
	CreateThread(function()
		while true do
			Wait(100)
			local ped = GetPlayerPed(-1)
			if DoesEntityExist(ped) and IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) and not IsPauseMenuActive() then
				local engineWasRunning = GetIsVehicleEngineRunning(GetVehiclePedIsIn(ped, true))
				Wait(1000)
				if DoesEntityExist(ped) and not IsPedInAnyVehicle(ped, false) and not IsEntityDead(ped) and not IsPauseMenuActive() then
					local veh = GetVehiclePedIsIn(ped, true)
					if engineWasRunning then
						SetVehicleEngineOn(veh, true, true, true)
					end
				end
			end
		end
	end)
end

if Config.ShowNearestGasStationOnly then
    CreateThread(function()
	    local currentGasBlip = 0
        while true do
            local coords = GetEntityCoords(PlayerPedId())
            local closest = 1000
            local closestCoords

            for _, gasStationCoords in pairs(Config.GasStationsBlips) do
                local dstcheck = #(coords - gasStationCoords)
                if dstcheck < closest then
                    closest = dstcheck
                    closestCoords = gasStationCoords
                end
            end
            if DoesBlipExist(currentGasBlip) then
                RemoveBlip(currentGasBlip)
            end
            currentGasBlip = CreateBlip(closestCoords)
            Wait(10000)
        end
    end)
end