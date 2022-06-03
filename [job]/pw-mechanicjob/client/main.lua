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


ModdedVehicles = {}
VehicleStatus = {}
ClosestPlate = nil
isLoggedIn = true
PlayerJob = {}

local onDuty = false

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("CUSTOM_TEXT")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        if isLoggedIn then
            SetClosestPlate()
        end
        Citizen.Wait(1000)
    end
end)

function SetClosestPlate()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for id,_ in pairs(Config.Plates) do
        if current ~= nil then
            if #(pos - vector3(Config.Plates[id].coords.x, Config.Plates[id].coords.y, Config.Plates[id].coords.z)) < dist then
                current = id
                dist = #(pos - vector3(Config.Plates[id].coords.x, Config.Plates[id].coords.y, Config.Plates[id].coords.z))
            end
        else
            dist = #(pos - vector3(Config.Plates[id].coords.x, Config.Plates[id].coords.y, Config.Plates[id].coords.z))
            current = id
        end
    end
    ClosestPlate = current
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    -- ESX.GetPlayerData(function(PlayerData)
        -- PlayerJob = PlayerData.job
        -- if PlayerData.job.onduty then
            -- if PlayerData.job.name == "mechanic" then
                -- TriggerServerEvent("QBCore:ToggleDuty")
            -- end
        -- end
    -- end)
    isLoggedIn = true
    ESX.TriggerServerCallback('pw-mechanicjob:server:GetAttachedVehicle', function(plates)
        for k, v in pairs(plates) do
            Config.Plates[k].AttachedVehicle = v.AttachedVehicle
        end
    end)

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerJob = ESX.PlayerData.job 
end)

-- RegisterNetEvent('QBCore:Client:SetDuty')
-- AddEventHandler('QBCore:Client:SetDuty', function(duty)
    -- onDuty = duty
-- end)

Citizen.CreateThread(function()
    local c = Config.Locations["blip"]
    local Blip = AddBlipForCoord(c.x, c.y, c.z)

    SetBlipSprite (Blip, 446)
    SetBlipDisplay(Blip, 4)
    SetBlipScale  (Blip, 1.0)
    SetBlipAsShortRange(Blip, true)
    SetBlipColour(Blip, 46)
    SetBlipAlpha(Blip, 0.7)

    BeginTextCommandSetBlipName("CUSTOM_TEXT")
    AddTextComponentSubstringPlayerName("~r~DC Mechanic")
    EndTextCommandSetBlipName(Blip)
end)

Citizen.CreateThread(function()
    while true do
        local inRange = false

        if isLoggedIn then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
                local pos = GetEntityCoords(PlayerPedId())
                local StashDistance = #(pos - vector3(Config.Locations["stash"].x, Config.Locations["stash"].y, Config.Locations["stash"].z))
                local OnDutyDistance = #(pos - vector3(Config.Locations["duty"].x, Config.Locations["duty"].y, Config.Locations["duty"].z))
                local VehicleDistance = #(pos - vector3(Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z))
				local BossActionDistance = #(pos - vector3(Config.Locations["boss"].x, Config.Locations["boss"].y, Config.Locations["boss"].z))
                local CraftStation = #(pos - vector3(Config.Locations["craft"].x, Config.Locations["craft"].y, Config.Locations["craft"].z))

                if true then
                    if CraftStation < 20 then
                        inRange = true
                        DrawMarker(2, Config.Locations["craft"].x, Config.Locations["craft"].y, Config.Locations["craft"].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)

                        if CraftStation < 1 then
                            DrawText3Ds(Config.Locations["craft"].x, Config.Locations["craft"].y, Config.Locations["craft"].z, "[E] Bàn chế tạo")
                            if IsControlJustReleased(0, 38) then

								TriggerEvent("server-inventory-open", "27", "Craft")							
                            end
                        end
                    end
                end
				
				if true then
                    if OnDutyDistance < 20 then
                        inRange = true
                        DrawMarker(2, Config.Locations["duty"].x, Config.Locations["duty"].y, Config.Locations["duty"].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)

                        if OnDutyDistance < 1 then
                            DrawText3Ds(Config.Locations["duty"].x, Config.Locations["duty"].y, Config.Locations["duty"].z, "[E] Tủ đồ")
                            if IsControlJustReleased(0, 38) then

								GardrobeMenu()					
                            end
                        end
                    end
                end

                if true then
                    if StashDistance < 20 then
                        inRange = true
                        DrawMarker(2, Config.Locations["stash"].x, Config.Locations["stash"].y, Config.Locations["stash"].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)

                        if StashDistance < 1 then
                            DrawText3Ds(Config.Locations["stash"].x, Config.Locations["stash"].y, Config.Locations["stash"].z, "[E] Mở kho đồ")
                            if IsControlJustReleased(0, 38) then
                                -- TriggerEvent("inventory:client:SetCurrentStash", "mechanicstash")
                                -- TriggerServerEvent("inventory:server:OpenInventory", "stash", "mechanicstash", {
                                    -- maxweight = 4000000,
                                    -- slots = 500,
                                -- })
								TriggerEvent("server-inventory-open", "1", "MechanicBox")
                            end
                        end
                    end
                end

                if true then
                    if VehicleDistance < 20 then
                        inRange = true
                        DrawMarker(2, Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)
                        if VehicleDistance < 1 then
                            local InVehicle = IsPedInAnyVehicle(PlayerPedId())

                            if InVehicle then
                                DrawText3Ds(Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z, '[E] Cất phương tiện')
                                if IsControlJustPressed(0, 38) then
                                    DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                                end
                            else
                                DrawText3Ds(Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z, '[E] Lấy phương tiện')
                                if IsControlJustPressed(0, 38) then
                                    if IsControlJustPressed(0, 38) then
										TriggerEvent('pw-mechanicjob:VehicleList')                                       
                                    end
                                end
                         
                            end
                        end
                    end
                end

				if BossActionDistance < 20 and ESX.PlayerData.job.grade_name == 'boss' then
					inRange = true
					DrawMarker(2, Config.Locations["boss"].x, Config.Locations["boss"].y, Config.Locations["boss"].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)
					
					if BossActionDistance < 1 then
						DrawText3Ds(Config.Locations["boss"].x, Config.Locations["boss"].y, Config.Locations["boss"].z, "[E] Quản lý")
						if IsControlJustReleased(0, 38) then
                            --TriggerServerEvent("QBCore:ToggleDuty")
							TriggerServerEvent("pw-bossmenu:server:openMenu")
                        end
					end
					
				end
					
                if true then
                    for k, v in pairs(Config.Plates) do
                        if v.AttachedVehicle == nil then
                            local PlateDistance = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                            if PlateDistance < 20 then
                                inRange = true
                                DrawMarker(2, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
                                if PlateDistance < 2 then
                                    local veh = GetVehiclePedIsIn(PlayerPedId())
                                    if IsPedInAnyVehicle(PlayerPedId()) then
                                        if not IsThisModelABicycle(GetEntityModel(veh)) then
                                            DrawText3Ds(v.coords.x, v.coords.y, v.coords.z + 0.3, "[E] Đưa xe vào vị trí")
                                            if IsControlJustPressed(0, 38) then
                                                DoScreenFadeOut(150)
                                                Wait(150)
                                                Config.Plates[ClosestPlate].AttachedVehicle = veh
                                                SetEntityCoords(veh, v.coords.x, v.coords.y, v.coords.z)
                                                SetEntityHeading(veh, v.coords.h)
                                                FreezeEntityPosition(veh, true)
                                                Wait(500)
                                                DoScreenFadeIn(250)
                                                TriggerServerEvent('pw-mechanicjob:server:SetAttachedVehicle', veh, k)
                                            end
                                        else
											
                                            ESX.Notify("Không thể đặt xe đạp lên đây!", "error")
											Wait(3000)
                                        end
                                    end
                                end
                            end
                        else
                            local PlateDistance = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                            if PlateDistance < 3 then
                                inRange = true
                                DrawText3Ds(v.coords.x, v.coords.y, v.coords.z, "[E] Mở menu kiểm tra")
                                if IsControlJustPressed(0, 38) then
									TriggerEvent("pw-mechanicjob:MainMenu")
                                end
                            end
                        end
                    end
                end

                if not inRange then
                    Citizen.Wait(1500)
                end
            else
                Citizen.Wait(1500)
            end
        else
            Citizen.Wait(1500)
        end

        Citizen.Wait(3)
    end
end)



RegisterNetEvent('pw-mechanicjob:SpawnListVehicle')
AddEventHandler('pw-mechanicjob:SpawnListVehicle', function(data)
    local model = data.model

    local coords = {
        x = Config.Locations["vehicle"].x,
        y = Config.Locations["vehicle"].y,
        z = Config.Locations["vehicle"].z,
        h = Config.Locations["vehicle"].h,
    }
    local plate = "AC"..math.random(1111, 9999)
    ESX.Game.SpawnVehicleqb(model, function(veh)
        SetVehicleNumberPlateText(veh, "ACBV"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.h)
        exports['pw-fuel']:SetFuel(veh, 100.0)
        --Menu.hidden = true
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end)




RegisterCommand("statusveh", function(source, args, rawCommand)
	-- local a = exports["pw-inventory"]:GetInfoForFirstItemOfName("plastic")
	-- print(a)
	--local veh = GetVehiclePedIsIn(PlayerPedId())
	--SetVehicleReduceGrip(veh,true) --trans
	
	  --SetVehicleHighGear(veh,1)
	  --SetVehicleReduceGrip(veh,false)
	--SetVehicleCurrentRpm(veh,10000)
	
	--SetVehicleEngineTemperature(veh,1000)
	--SetVehicleHighGear(veh,1) --transmiision
	--SetVehicleAlarm(veh,true)
	--SetVehicleFullbeam(veh,true)
	--SetVehicleCanBreak(veh,false) --cho phep thang hay khong
	--SetVehicleForwardSpeed(veh,100) --tang toc
    CheckStatus()
end, false) 
function CheckStatus()
	local veh = GetVehiclePedIsIn(PlayerPedId())
    local plate = GetVehicleNumberPlateText(veh)
	print(VehicleStatus[plate])

	for k,v in pairs(VehicleStatus[plate]) do
		print(k,v)
	end
    --SendStatusMessage(VehicleStatus[plate])
end

RegisterNetEvent('pw-mechanicjob:RepairPart')
AddEventHandler('pw-mechanicjob:RepairPart', function(type)
    print(data.namethis)
    local part = data.namethis	

    local plate = GetVehicleNumberPlateText(Config.Plates[ClosestPlate].AttachedVehicle)
	local veh = GetVehiclePedIsIn(PlayerPedId())
	classvehicle = GetVehicleClass(veh)
	if classvehicle == 0 or classvehicle == 8 or classvehicle == 11 then
		classvehicle = "A"
	elseif classvehicle == 1 or classvehicle == 3 then
		classvehicle = "B"
	elseif classvehicle == 4 or classvehicle == 9 or classvehicle == 18 then
		classvehicle = "C"
	elseif classvehicle == 2 or classvehicle == 12 then
		classvehicle = "D"
	elseif classvehicle == 5 or classvehicle == 6 or classvehicle == 7 then
		classvehicle = "S"
	else
		classvehicle = "All"
	end		
    local PartData = Config.RepairCostAmount[part][classvehicle]

	if exports["pw-inventory"]:hasEnoughOfItem(PartData.item,PartData.costs,false) then
		TriggerEvent("inventory:removeItem",PartData.item,PartData.costs)
		ESX.Progressbar("repair_part", Config.ValuesLabels[part].." Đang được sửa chữa", math.random(20000, 50000), false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, {}, function() -- Done
					TriggerEvent('pw-mechanicjob:client:RepaireeePart', part)
		end, function()	
			ESX.Notify("Hủy sửa chữa", "error")
		end)
	else
		ESX.Notify('Không có nguyên liệu như yêu cầu để sửa chữa', 'error')
	end	

end)

--

RegisterNetEvent('pw-mechanicjob:client:RepaireeePart')
AddEventHandler('pw-mechanicjob:client:RepaireeePart', function(part)
    local veh = Config.Plates[ClosestPlate].AttachedVehicle
    local plate = GetVehicleNumberPlateText(veh)
    if part == "engine_damage" then
        SetVehicleEngineHealth(veh, Config.MaxStatusValues[part])
        TriggerServerEvent("vehiclemod:server:updatePart", plate, "engine_damage", Config.MaxStatusValues[part])
    elseif part == "body_damage" then
		local enhealth = GetVehicleEngineHealth(veh)
		local fuel = GetVehicleFuelLevel(veh)
        SetVehicleBodyHealth(veh, Config.MaxStatusValues[part])
        TriggerServerEvent("vehiclemod:server:updatePart", plate, "body_damage", Config.MaxStatusValues[part])
        SetVehicleFixed(veh)
		SetVehicleEngineHealth(veh, enhealth)
		SetVehicleFuelLevel(veh, fuel)
    else
        TriggerServerEvent("vehiclemod:server:updatePart", plate, part, Config.MaxStatusValues[part])
    end
    ESX.Notify("Bộ phận "..Config.ValuesLabels[part].." đã được sửa chữa!")
end)

RegisterUICallback('pw-vehicles:repairVehicle', function (data, cb)
	cb({ data = {}, meta = { ok = true, message = '' } })
    local coords = Config.Locations["exit"]
    DoScreenFadeOut(150)
    Wait(150)
    FreezeEntityPosition(Config.Plates[ClosestPlate].AttachedVehicle, false)
    SetEntityCoords(Config.Plates[ClosestPlate].AttachedVehicle, Config.Plates[ClosestPlate].coords.x, Config.Plates[ClosestPlate].coords.y, Config.Plates[ClosestPlate].coords.z)
    SetEntityHeading(Config.Plates[ClosestPlate].AttachedVehicle, Config.Plates[ClosestPlate].coords.h)
    TaskWarpPedIntoVehicle(PlayerPedId(), Config.Plates[ClosestPlate].AttachedVehicle, -1)
    Wait(500)
    DoScreenFadeIn(250)
    Config.Plates[ClosestPlate].AttachedVehicle = nil
    TriggerServerEvent('pw-mechanicjob:server:SetAttachedVehicle', false, ClosestPlate)
end)

RegisterNetEvent('pw-mechanicjob:DetachVehicle')
AddEventHandler('pw-mechanicjob:DetachVehicle', function()
    local coords = Config.Locations["exit"]
    DoScreenFadeOut(150)
    Wait(150)
    FreezeEntityPosition(Config.Plates[ClosestPlate].AttachedVehicle, false)
    SetEntityCoords(Config.Plates[ClosestPlate].AttachedVehicle, Config.Plates[ClosestPlate].coords.x, Config.Plates[ClosestPlate].coords.y, Config.Plates[ClosestPlate].coords.z)
    SetEntityHeading(Config.Plates[ClosestPlate].AttachedVehicle, Config.Plates[ClosestPlate].coords.h)
    TaskWarpPedIntoVehicle(PlayerPedId(), Config.Plates[ClosestPlate].AttachedVehicle, -1)
    Wait(500)
    DoScreenFadeIn(250)
    Config.Plates[ClosestPlate].AttachedVehicle = nil
    TriggerServerEvent('pw-mechanicjob:server:SetAttachedVehicle', false, ClosestPlate)
end)

RegisterNetEvent('pw-mechanicjob:client:SetAttachedVehicle')
AddEventHandler('pw-mechanicjob:client:SetAttachedVehicle', function(veh, key)
    if veh ~= false then
        Config.Plates[key].AttachedVehicle = veh
    else
        Config.Plates[key].AttachedVehicle = nil
    end
end)


local effectTimer = 0
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000)
        if (IsPedInAnyVehicle(PlayerPedId(), false)) then
            local veh = GetVehiclePedIsIn(PlayerPedId(),false)
            if not IsThisModelABicycle(GetEntityModel(veh)) and GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
                local engineHealth = GetVehicleEngineHealth(veh)
                local bodyHealth = GetVehicleBodyHealth(veh)
                local plate = GetVehicleNumberPlateText(veh)
                if VehicleStatus[plate] == nil then 
                    TriggerServerEvent("vehiclemod:server:setupVehicleStatus", plate, engineHealth, bodyHealth)
                else
                    TriggerServerEvent("vehiclemod:server:updatePart", plate, "engine_damage", engineHealth)
                    TriggerServerEvent("vehiclemod:server:updatePart", plate, "body_damage", bodyHealth)
                    effectTimer = effectTimer + 1
                    if effectTimer >= math.random(10, 15) then
                        ApplyEffects(veh)
                        effectTimer = 0
                    end
                end
            else
                effectTimer = 0
                Citizen.Wait(1000)
            end
        else
            effectTimer = 0
            Citizen.Wait(2000)
        end
    end
end)

RegisterNetEvent('vehiclemod:client:setVehicleStatus')
AddEventHandler('vehiclemod:client:setVehicleStatus', function(plate, status)
    VehicleStatus[plate] = status
end)

RegisterNetEvent('vehiclemod:client:getVehicleStatus')
AddEventHandler('vehiclemod:client:getVehicleStatus', function(plate, status)
    if not (IsPedInAnyVehicle(PlayerPedId(), false)) then
        local veh = GetVehiclePedIsIn(PlayerPedId(), true)
        if veh ~= nil and veh ~= 0 then
            local vehpos = GetEntityCoords(veh)
            local pos = GetEntityCoords(PlayerPedId())
            if #(pos - vehpos) < 5.0 then
                if not IsThisModelABicycle(GetEntityModel(veh)) then
                    local plate = GetVehicleNumberPlateText(veh)
                    if VehicleStatus[plate] ~= nil then 
                        SendStatusMessage(VehicleStatus[plate])
                    else
                        ESX.Notify("Status Unknown", "error")
                    end
                else
                    ESX.Notify("Not A Valid Vehicle", "error")
                end
            else
                ESX.Notify("Không đúng đủ gần xe để kiểm tra", "error")
            end
        else
            ESX.Notify("Phải ở trong xe mới có thể kiểm tra", "error")
        end
    else
        ESX.Notify("Bạn phải đứng ngoài xe", "error")
    end
end)

RegisterNetEvent('vehiclemod:client:fixEverything')
AddEventHandler('vehiclemod:client:fixEverything', function()
    if (IsPedInAnyVehicle(PlayerPedId(), false)) then
        local veh = GetVehiclePedIsIn(PlayerPedId(),false)
        if not IsThisModelABicycle(GetEntityModel(veh)) and GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
            local plate = GetVehicleNumberPlateText(veh)
            TriggerServerEvent("vehiclemod:server:fixEverything", plate)
        else
            ESX.Notify("You Are Not The Driver Or On A Bicycle", "error")
        end
    else
        ESX.Notify("You Are Not In A Vehicle", "error")
    end
end)

RegisterNetEvent('pw-mechanicjob:server:SetPartLevel')
AddEventHandler('pw-mechanicjob:server:SetPartLevel', function(part, level)
    if (IsPedInAnyVehicle(PlayerPedId(), false)) then
        local veh = GetVehiclePedIsIn(PlayerPedId(),false)
        if not IsThisModelABicycle(GetEntityModel(veh)) and GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
            local plate = GetVehicleNumberPlateText(veh)
            if part == "engine_damage" then
                SetVehicleEngineHealth(veh, level)
                TriggerServerEvent("vehiclemod:server:updatePart", plate, "engine_damage", GetVehicleEngineHealth(veh))
            elseif part == "body_damage" then
                SetVehicleBodyHealth(veh, level)
                TriggerServerEvent("vehiclemod:server:updatePart", plate, "body_damage", GetVehicleBodyHealth(veh))
            else
                TriggerServerEvent("vehiclemod:server:updatePart", plate, part, level)
            end
        else
            ESX.Notify("Bạn không phải là người đang ngồi ở ghế lái", "error")
        end
    else
        ESX.Notify("Bạn không phải là người đang ngồi ở ghế lái", "error")
    end
end)
local openingDoor = false

-- RegisterNetEvent('vehiclemod:client:repairPart')
-- AddEventHandler('vehiclemod:client:repairPart', function(part, level, needAmount)
    -- -- if CanReapair() then
        -- if not IsPedInAnyVehicle(PlayerPedId(), false) then
            -- local veh = GetVehiclePedIsIn(PlayerPedId(), true)
            -- if veh ~= nil and veh ~= 0 then
                -- local vehpos = GetEntityCoords(veh)
                -- local pos = GetEntityCoords(PlayerPedId())
                -- if #(pos - vehpos) < 5.0 then
                    -- if not IsThisModelABicycle(GetEntityModel(veh)) then
                        -- local plate = GetVehicleNumberPlateText(veh)
                        -- if VehicleStatus[plate] ~= nil and VehicleStatus[plate][part] ~= nil then
                            -- local lockpickTime = (1000 * level)
                            -- if part == "body_damage" then
                                -- lockpickTime = lockpickTime / 10
                            -- end
                            -- ScrapAnim(lockpickTime)
                            -- ESX.Progressbar("repair_advanced", "Repair Vehicle", lockpickTime, false, true, {
                                -- disableMovement = true,
                                -- disableCarMovement = true,
                                -- disableMouse = false,
                                -- disableCombat = true,
                            -- }, {
                                -- animDict = "mp_car_bomb",
                                -- anim = "car_bomb_mechanic",
                                -- flags = 16,
                            -- }, {}, {}, function() -- Done
                                -- openingDoor = false
                                -- ClearPedTasks(PlayerPedId())
                                -- if part == "body_damage" then
                                    -- SetVehicleBodyHealth(veh, GetVehicleBodyHealth(veh) + level)
                                    -- SetVehicleFixed(veh)
                                    -- TriggerServerEvent("vehiclemod:server:updatePart", plate, part, GetVehicleBodyHealth(veh))
                                    -- TriggerServerEvent("QBCore:Server:RemoveItem", Config.RepairCost[part], needAmount)
                                    -- TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.RepairCost[part]], "remove")
                                -- elseif part ~= "engine_damage" then
                                    -- TriggerServerEvent("vehiclemod:server:updatePart", plate, part, GetVehicleStatus(plate, part) + level)
                                    -- TriggerServerEvent("QBCore:Server:RemoveItem", Config.RepairCost[part], level)
                                    -- TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.RepairCost[part]], "remove")
                                -- end
                            -- end, function() -- Cancel
                                -- openingDoor = false
                                -- ClearPedTasks(PlayerPedId())
                                -- ESX.Notify("Process Canceled", "error")
                            -- end)
                        -- else
                            -- ESX.Notify("Not A Valid Part", "error")
                        -- end
                    -- else
                        -- ESX.Notify("Not A Valid Vehicle", "error")
                    -- end
                -- else
                    -- ESX.Notify("You Are Not Close Enough To The Vehicle", "error")
                -- end
            -- else
                -- ESX.Notify("You Must Be In The Vehicle First", "error")
            -- end
        -- else
            -- ESX.Notify("Youre Not In a Vehicle", "error")
        -- end
    -- -- end
-- end)

function ScrapAnim(time)
    local time = time / 1000
    loadAnimDict("mp_car_bomb")
    TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    Citizen.CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(2000)
            time = time - 2
            if time <= 0 then
                openingDoor = false
                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
            end
        end
    end)
end

-- function CanReapair()
    -- local retval = false
    -- for k, v in pairs(Config.Businesses) do
        -- retval = exports['qb-companies']:IsEmployee(v)
    -- end
    -- return retval
-- end

function ApplyEffects(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    if GetVehicleClass(vehicle) ~= 13 and GetVehicleClass(vehicle) ~= 21 and GetVehicleClass(vehicle) ~= 16 and GetVehicleClass(vehicle) ~= 15 and GetVehicleClass(vehicle) ~= 14 then
        if VehicleStatus[plate] ~= nil then 
            local chance = math.random(1, 100)
            if VehicleStatus[plate]["radiator"] <= 80 and (chance >= 1 and chance <= 30) then
                local engineHealth = GetVehicleEngineHealth(vehicle)
                if VehicleStatus[plate]["radiator"] <= 80 and VehicleStatus[plate]["radiator"] >= 60 then
                    SetVehicleEngineHealth(vehicle, engineHealth - math.random(10, 15))
                elseif VehicleStatus[plate]["radiator"] <= 59 and VehicleStatus[plate]["radiator"] >= 40 then
                    SetVehicleEngineHealth(vehicle, engineHealth - math.random(15, 20))
                elseif VehicleStatus[plate]["radiator"] <= 39 and VehicleStatus[plate]["radiator"] >= 20 then
                    SetVehicleEngineHealth(vehicle, engineHealth - math.random(20, 30))
                elseif VehicleStatus[plate]["radiator"] <= 19 and VehicleStatus[plate]["radiator"] >= 6 then
                    SetVehicleEngineHealth(vehicle, engineHealth - math.random(30, 40))
                else
                    SetVehicleEngineHealth(vehicle, engineHealth - math.random(40, 50))
                end
            end

            if VehicleStatus[plate]["axle"] <= 80 and (chance >= 21 and chance <= 40) then
                if VehicleStatus[plate]["axle"] <= 80 and VehicleStatus[plate]["axle"] >= 60 then
                    for i=0,360 do					
                        SetVehicleSteeringScale(vehicle,i)
                        Citizen.Wait(5)
                    end
                elseif VehicleStatus[plate]["axle"] <= 59 and VehicleStatus[plate]["axle"] >= 40 then
                    for i=0,360 do	
                        Citizen.Wait(10)
                        SetVehicleSteeringScale(vehicle,i)
                    end
                elseif VehicleStatus[plate]["axle"] <= 39 and VehicleStatus[plate]["axle"] >= 20 then
                    for i=0,360 do
                        Citizen.Wait(15)
                        SetVehicleSteeringScale(vehicle,i)
                    end
                elseif VehicleStatus[plate]["axle"] <= 19 and VehicleStatus[plate]["axle"] >= 6 then
                    for i=0,360 do
                        Citizen.Wait(20)
                        SetVehicleSteeringScale(vehicle,i)
                    end
                else
                    for i=0,360 do
                        Citizen.Wait(25)
                        SetVehicleSteeringScale(vehicle,i)
                    end
                end
            end

            if VehicleStatus[plate]["brakes"] <= 80 and (chance >= 41 and chance <= 60) then
                if VehicleStatus[plate]["brakes"] <= 80 and VehicleStatus[plate]["brakes"] >= 60 then
                    SetVehicleHandbrake(vehicle, true)
                    Citizen.Wait(1000)
                    SetVehicleHandbrake(vehicle, false)
                elseif VehicleStatus[plate]["brakes"] <= 59 and VehicleStatus[plate]["brakes"] >= 40 then
                    SetVehicleHandbrake(vehicle, true)
                    Citizen.Wait(3000)
                    SetVehicleHandbrake(vehicle, false)
                elseif VehicleStatus[plate]["brakes"] <= 39 and VehicleStatus[plate]["brakes"] >= 20 then
                    SetVehicleHandbrake(vehicle, true)
                    Citizen.Wait(5000)
                    SetVehicleHandbrake(vehicle, false)
                elseif VehicleStatus[plate]["brakes"] <= 19 and VehicleStatus[plate]["brakes"] >= 6 then
                    SetVehicleHandbrake(vehicle, true)
                    Citizen.Wait(7000)
                    SetVehicleHandbrake(vehicle, false)
                else
                    SetVehicleHandbrake(vehicle, true)
                    Citizen.Wait(9000)
                    SetVehicleHandbrake(vehicle, false)
                end
            end

            if VehicleStatus[plate]["clutch"] <= 80 and (chance >= 61 and chance <= 80) then
                if VehicleStatus[plate]["clutch"] <= 80 and VehicleStatus[plate]["clutch"] >= 60 then
                    SetVehicleHandbrake(vehicle, true)
                    SetVehicleEngineOn(vehicle,0,0,1)
                    SetVehicleUndriveable(vehicle,true)
                    Citizen.Wait(50)
                    SetVehicleEngineOn(vehicle,1,0,1)
                    SetVehicleUndriveable(vehicle,false)
                    for i=1,360 do
                        SetVehicleSteeringScale(vehicle, i)
                        Citizen.Wait(5)
                    end
                    Citizen.Wait(500)
                    SetVehicleHandbrake(vehicle, false)
                elseif VehicleStatus[plate]["clutch"] <= 59 and VehicleStatus[plate]["clutch"] >= 40 then
                    SetVehicleHandbrake(vehicle, true)
                    SetVehicleEngineOn(vehicle,0,0,1)
                    SetVehicleUndriveable(vehicle,true)
                    Citizen.Wait(100)
                    SetVehicleEngineOn(vehicle,1,0,1)
                    SetVehicleUndriveable(vehicle,false)
                    for i=1,360 do
                        SetVehicleSteeringScale(vehicle, i)
                        Citizen.Wait(5)
                    end
                    Citizen.Wait(750)
                    SetVehicleHandbrake(vehicle, false)
                elseif VehicleStatus[plate]["clutch"] <= 39 and VehicleStatus[plate]["clutch"] >= 20 then
                    SetVehicleHandbrake(vehicle, true)
                    SetVehicleEngineOn(vehicle,0,0,1)
                    SetVehicleUndriveable(vehicle,true)
                    Citizen.Wait(150)
                    SetVehicleEngineOn(vehicle,1,0,1)
                    SetVehicleUndriveable(vehicle,false)
                    for i=1,360 do
                        SetVehicleSteeringScale(vehicle, i)
                        Citizen.Wait(5)
                    end
                    Citizen.Wait(1000)
                    SetVehicleHandbrake(vehicle, false)
                elseif VehicleStatus[plate]["clutch"] <= 19 and VehicleStatus[plate]["clutch"] >= 6 then
                    SetVehicleHandbrake(vehicle, true)
                    SetVehicleEngineOn(vehicle,0,0,1)
                    SetVehicleUndriveable(vehicle,true)
                    Citizen.Wait(200)
                    SetVehicleEngineOn(vehicle,1,0,1)
                    SetVehicleUndriveable(vehicle,false)
                    for i=1,360 do
                        SetVehicleSteeringScale(vehicle, i)
                        Citizen.Wait(5)
                    end
                    Citizen.Wait(1250)
                    SetVehicleHandbrake(vehicle, false)
                else
                    SetVehicleHandbrake(vehicle, true)
                    SetVehicleEngineOn(vehicle,0,0,1)
                    SetVehicleUndriveable(vehicle,true)
                    Citizen.Wait(250)
                    SetVehicleEngineOn(vehicle,1,0,1)
                    SetVehicleUndriveable(vehicle,false)
                    for i=1,360 do
                        SetVehicleSteeringScale(vehicle, i)
                        Citizen.Wait(5)
                    end
                    Citizen.Wait(1500)
                    SetVehicleHandbrake(vehicle, false)
                end
            end

            if VehicleStatus[plate]["fuelinjector"] <= 80 and (chance >= 60 and chance <= 100) then
                local fuel = exports['pw-fuel']:GetFuel(vehicle)
                if VehicleStatus[plate]["fuelinjector"] <= 80 and VehicleStatus[plate]["fuelinjector"] >= 60 then
                    exports['pw-fuel']:SetFuel(vehicle, fuel - 2.0)
                elseif VehicleStatus[plate]["fuelinjector"] <= 59 and VehicleStatus[plate]["fuelinjector"] >= 40 then
                    exports['pw-fuel']:SetFuel(vehicle, fuel - 4.0)
                elseif VehicleStatus[plate]["fuelinjector"] <= 39 and VehicleStatus[plate]["fuelinjector"] >= 20 then
                    exports['pw-fuel']:SetFuel(vehicle, fuel - 6.0)
                elseif VehicleStatus[plate]["fuelinjector"] <= 19 and VehicleStatus[plate]["fuelinjector"] >= 6 then
                    exports['pw-fuel']:SetFuel(vehicle, fuel - 8.0)
                else
                    exports['pw-fuel']:SetFuel(vehicle, fuel - 10.0)
                end
            end
			
			if VehicleStatus[plate]["tire"] <= 80 then
                local tireBurstMaxNumber = 500
				tireBurstLuckyNumber = math.random(tireBurstMaxNumber)
				tireBurstNumber = math.random(tireBurstMaxNumber)
				if tireBurstNumber == tireBurstLuckyNumber then
					if GetVehicleTyresCanBurst(vehicle) == false then return end
					local numWheels = GetVehicleNumberOfWheels(vehicle)
					local affectedTire
					if numWheels == 2 then
						affectedTire = (math.random(2)-1)*4		-- wheel 0 or 4
					elseif numWheels == 4 then
						affectedTire = (math.random(4)-1)
						if affectedTire > 1 then affectedTire = affectedTire + 2 end
					elseif numWheels == 6 then
						affectedTire = (math.random(6)-1)
					else
						affectedTire = 0
					end
					SetVehicleTyreBurst(vehicle, affectedTire, false, 1000.0)
					tireBurstLuckyNumber = math.random(tireBurstMaxNumber)		
				end
				
                if VehicleStatus[plate]["tire"] <= 80 and VehicleStatus[plate]["tire"] >= 60 then
                    tireBurstMaxNumber = 300
					tireBurstLuckyNumber = math.random(tireBurstMaxNumber)
					tireBurstNumber = math.random(tireBurstMaxNumber)
					if tireBurstNumber == tireBurstLuckyNumber then
						if GetVehicleTyresCanBurst(vehicle) == false then return end
						local numWheels = GetVehicleNumberOfWheels(vehicle)
						local affectedTire
						if numWheels == 2 then
							affectedTire = (math.random(2)-1)*4		-- wheel 0 or 4
						elseif numWheels == 4 then
							affectedTire = (math.random(4)-1)
							if affectedTire > 1 then affectedTire = affectedTire + 2 end
						elseif numWheels == 6 then
							affectedTire = (math.random(6)-1)
						else
							affectedTire = 0
						end
						SetVehicleTyreBurst(vehicle, affectedTire, false, 1000.0)
						tireBurstLuckyNumber = math.random(tireBurstMaxNumber)		
					end
					
                elseif VehicleStatus[plate]["tire"] <= 59 and VehicleStatus[plate]["tire"] >= 40 then
				
                    tireBurstMaxNumber = 200
					tireBurstLuckyNumber = math.random(tireBurstMaxNumber)
					tireBurstNumber = math.random(tireBurstMaxNumber)
					if tireBurstNumber == tireBurstLuckyNumber then
						if GetVehicleTyresCanBurst(vehicle) == false then return end
						local numWheels = GetVehicleNumberOfWheels(vehicle)
						local affectedTire
						if numWheels == 2 then
							affectedTire = (math.random(2)-1)*4		-- wheel 0 or 4
						elseif numWheels == 4 then
							affectedTire = (math.random(4)-1)
							if affectedTire > 1 then affectedTire = affectedTire + 2 end
						elseif numWheels == 6 then
							affectedTire = (math.random(6)-1)
						else
							affectedTire = 0
						end
						SetVehicleTyreBurst(vehicle, affectedTire, false, 1000.0)
						tireBurstLuckyNumber = math.random(tireBurstMaxNumber)		
					end
					
                elseif VehicleStatus[plate]["tire"] <= 39 and VehicleStatus[plate]["tire"] >= 20 then
				
                    tireBurstMaxNumber = 100
					tireBurstLuckyNumber = math.random(tireBurstMaxNumber)
					tireBurstNumber = math.random(tireBurstMaxNumber)
					if tireBurstNumber == tireBurstLuckyNumber then
						if GetVehicleTyresCanBurst(vehicle) == false then return end
						local numWheels = GetVehicleNumberOfWheels(vehicle)
						local affectedTire
						if numWheels == 2 then
							affectedTire = (math.random(2)-1)*4		-- wheel 0 or 4
						elseif numWheels == 4 then
							affectedTire = (math.random(4)-1)
							if affectedTire > 1 then affectedTire = affectedTire + 2 end
						elseif numWheels == 6 then
							affectedTire = (math.random(6)-1)
						else
							affectedTire = 0
						end
						SetVehicleTyreBurst(vehicle, affectedTire, false, 1000.0)
						tireBurstLuckyNumber = math.random(tireBurstMaxNumber)		
					end
					
                elseif VehicleStatus[plate]["tire"] <= 19 and VehicleStatus[plate]["tire"] >= 6 then
				
                    tireBurstMaxNumber = 50
					tireBurstLuckyNumber = math.random(tireBurstMaxNumber)
					tireBurstNumber = math.random(tireBurstMaxNumber)
					if tireBurstNumber == tireBurstLuckyNumber then
						if GetVehicleTyresCanBurst(vehicle) == false then return end
						local numWheels = GetVehicleNumberOfWheels(vehicle)
						local affectedTire
						if numWheels == 2 then
							affectedTire = (math.random(2)-1)*4		-- wheel 0 or 4
						elseif numWheels == 4 then
							affectedTire = (math.random(4)-1)
							if affectedTire > 1 then affectedTire = affectedTire + 2 end
						elseif numWheels == 6 then
							affectedTire = (math.random(6)-1)
						else
							affectedTire = 0
						end
						SetVehicleTyreBurst(vehicle, affectedTire, false, 1000.0)
						tireBurstLuckyNumber = math.random(tireBurstMaxNumber)		
					end
                else
                    local tireBurstMaxNumber = 1
					tireBurstNumber = math.random(tireBurstMaxNumber)
					tireBurstLuckyNumber = math.random(tireBurstMaxNumber)
					if tireBurstNumber == tireBurstLuckyNumber then
						if GetVehicleTyresCanBurst(vehicle) == false then return end
						local numWheels = GetVehicleNumberOfWheels(vehicle)
						local affectedTire
						if numWheels == 2 then
							affectedTire = (math.random(2)-1)*4		-- wheel 0 or 4
						elseif numWheels == 4 then
							affectedTire = (math.random(4)-1)
							if affectedTire > 1 then affectedTire = affectedTire + 2 end
						elseif numWheels == 6 then
							affectedTire = (math.random(6)-1)
						else
							affectedTire = 0
						end
						SetVehicleTyreBurst(vehicle, affectedTire, false, 1000.0)
						tireBurstLuckyNumber = math.random(tireBurstMaxNumber)		
					end
                end
				
				
				if VehicleStatus[plate]["transmission"] <= 80 and (chance >= 70 and chance <= 100) then
					SetVehicleReduceGrip(vehicle,true)
					SetVehicleCurrentRpm(vehicle,10)
					Citizen.Wait(300)
					SetVehicleReduceGrip(vehicle,false)
					if VehicleStatus[plate]["transmission"] <= 80 and VehicleStatus[plate]["transmission"] >= 60 then
						SetVehicleReduceGrip(vehicle,true)
						SetVehicleCurrentRpm(vehicle,10)
						Citizen.Wait(500)
						SetVehicleReduceGrip(vehicle,false)
					elseif VehicleStatus[plate]["transmission"] <= 59 and VehicleStatus[plate]["transmission"] >= 40 then
						SetVehicleReduceGrip(vehicle,true)
						SetVehicleCurrentRpm(vehicle,10)
						Citizen.Wait(800)
						SetVehicleReduceGrip(vehicle,false)
					elseif VehicleStatus[plate]["transmission"] <= 39 and VehicleStatus[plate]["transmission"] >= 20 then
						SetVehicleReduceGrip(vehicle,true)
						SetVehicleCurrentRpm(vehicle,10)
						Citizen.Wait(1000)
						SetVehicleReduceGrip(vehicle,false)
					elseif VehicleStatus[plate]["transmission"] <= 19 and VehicleStatus[plate]["transmission"] >= 6 then
						SetVehicleReduceGrip(vehicle,true)
						SetVehicleCurrentRpm(vehicle,10)
						Citizen.Wait(2000)
						SetVehicleReduceGrip(vehicle,false)
					else
						SetVehicleReduceGrip(vehicle,true)
						SetVehicleCurrentRpm(vehicle,10)
						Citizen.Wait(3000)
						SetVehicleReduceGrip(vehicle,false)
					end
				end
				
								
				
            end
        end
    end
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function GetVehicleStatusList(plate)
    local retval = nil
    if VehicleStatus[plate] ~= nil then 
        retval = VehicleStatus[plate]
    end
    return retval
end

function GetVehicleStatus(plate, part)
    local retval = nil
    if VehicleStatus[plate] ~= nil then 
        retval = VehicleStatus[plate][part]
    end
    return retval
end

function SetVehicleStatus(plate, part, level)
    TriggerServerEvent("vehiclemod:server:updatePart", plate, part, level)
end

function SendStatusMessage(statusList)
    if statusList ~= nil then 
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message normal"><div class="chat-message-body"><strong>{0}:</strong><br><br> <strong>'.. Config.ValuesLabels["engine_damage"] ..' (engine):</strong> {1} <br><strong>'.. Config.ValuesLabels["body_damage"] ..' (body):</strong> {2} <br><strong>'.. Config.ValuesLabels["radiator"] ..' (radiator):</strong> {3} <br><strong>'.. Config.ValuesLabels["axle"] ..' (axle):</strong> {4}<br><strong>'.. Config.ValuesLabels["brakes"] ..' (brakes):</strong> {5}<br><strong>'.. Config.ValuesLabels["clutch"] ..' (clutch):</strong> {6}<br><strong>'.. Config.ValuesLabels["fuelinjector"] ..' (fuel):</strong> {7}</div></div>',
            args = {'Vehicle Status', round(statusList["engine_damage"]) .. "/" .. Config.MaxStatusValues["engine_damage"] .. " ("..QBCore.Shared.Items["advancedrepairkit"]["label"]..")", round(statusList["body_damage"]) .. "/" .. Config.MaxStatusValues["body_damage"] .. " ("..QBCore.Shared.Items[Config.RepairCost["body_damage"]]["label"]..")", round(statusList["radiator"]) .. "/" .. Config.MaxStatusValues["radiator"] .. ".0 ("..QBCore.Shared.Items[Config.RepairCost["radiator"]]["label"]..")", round(statusList["axle"]) .. "/" .. Config.MaxStatusValues["axle"] .. ".0 ("..QBCore.Shared.Items[Config.RepairCost["axle"]]["label"]..")", round(statusList["brakes"]) .. "/" .. Config.MaxStatusValues["brakes"] .. ".0 ("..QBCore.Shared.Items[Config.RepairCost["brakes"]]["label"]..")", round(statusList["clutch"]) .. "/" .. Config.MaxStatusValues["clutch"] .. ".0 ("..QBCore.Shared.Items[Config.RepairCost["clutch"]]["label"]..")", round(statusList["fuelinjector"]) .. "/" .. Config.MaxStatusValues["fuelinjector"] .. ".0 ("..QBCore.Shared.Items[Config.RepairCost["fuelinjector"]]["label"]..")"}
        })
    end
end

function round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 1) .. "f", num))
end

-- Menu Functions

-- CloseMenu = function()
    -- Menu.hidden = true
    -- currentGarage = nil
    -- ClearMenu()
-- end

-- ClearMenu = function()
	-- --Menu = {}
	-- Menu.GUI = {}
	-- Menu.buttonCount = 0
	-- Menu.selection = 0
-- end

function noSpace(str)
    local normalisedString = string.gsub(str, "%s+", "")
    return normalisedString
end