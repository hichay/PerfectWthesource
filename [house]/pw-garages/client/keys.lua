local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

ESX = nil

local HasKey = false
local LastVehicle = nil
local IsHotwiring = false
local IsRobbing = false
local isLoggedIn = false
local NeededAttempts = 0
local SucceededAttempts = 0
local FailedAttemps = 0
local AlertSend = false


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

        if ESX ~= nil then
            if IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), true), -1) == PlayerPedId() then
                --local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId()))
				local vehicle = GetVehiclePedIsIn(PlayerPedId())
				local plate = ESX.Game.GetVehicleProperties(vehicle).plate
				--print('check key vehicle')
                if LastVehicle ~= GetVehiclePedIsIn(PlayerPedId(), false) then
                    --print('check key vehicles 2')
                    ESX.TriggerServerCallback('vehiclekeys:CheckHasKey', function(result)
                        if result then
                            HasKey = true
                            SetVehicleEngineOn(vehicle, true, false, true)
                        else
                            HasKey = false
                            SetVehicleEngineOn(vehicle, false, false, true)
                        end
                        LastVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    end, plate)
                end
            else
                if SucceededAttempts ~= 0 then
                    SucceededAttempts = 0
                end
                if NeededAttempts ~= 0 then
                    NeededAttempts = 0
                end
                if FailedAttemps ~= 0 then
                    FailedAttemps = 0
                end
            end
        end
       
    
         if not HasKey and IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() and ESX ~= nil and not IsHotwiring  then
            --local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            --SetVehicleEngineOn(veh, false, false, true)

            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            local vehpos = GetOffsetFromEntityInWorldCoords(veh, 0, 1.5, 0.5)
            --ESX.Game.Utils.DrawText3D(vehpos, "~g~H~w~ - Hotwire")
            SetVehicleEngineOn(veh, false, false, true)

            --if IsControlJustPressed(0, Keys["H"]) then
               -- Hotwire()
            --end
        end  

        --[[ if IsControlJustPressed(1, Keys["L"]) then
            LockVehicle()
        end ]]
        
    end
end)

--[[ Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if not IsRobbing and ESX ~= nil then
            if GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= nil and GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= 0 then
                local vehicle = GetVehiclePedIsTryingToEnter(PlayerPedId())
                local driver = GetPedInVehicleSeat(vehicle, -1)
                
                if driver ~= 0 and not IsPedAPlayer(driver) then
                   
                    if IsEntityDead(driver) then
                        print('robs key')
                        IsRobbing = true
                        --ESX.Progressbar("rob_keys", "Grabing keysn..", 3000, false, true, {}, {}, {}, {}, function() -- Done
                            TriggerEvent("vehiclekeys:client:SetOwner", ESX.Game.GetVehicleProperties(vehicle).plate)
                            HasKey = true
                            IsRobbing = false
                        --end)
                        
                    end
                end
            end

             if true then
                local aiming, target = GetEntityPlayerIsFreeAimingAt(PlayerId())
                if aiming and (target ~= nil and target ~= 0) then
                    if DoesEntityExist(target) and not IsPedAPlayer(target) then
                        if IsPedInAnyVehicle(target, false) and not IsPedInAnyVehicle(PlayerPedId(), false ) then
                            if not IsBlacklistedWeapon() then
                                local pos = GetEntityCoords(PlayerPedId(), true)
                                local targetpos = GetEntityCoords(target, true)
                                local vehicle = GetVehiclePedIsIn(target, true)
                                if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, targetpos.x, targetpos.y, targetpos.z, true) < 13.0 then
                                    RobVehicle(target)
                                end
                            end
                        end
                    end
                end
            end 
        end
    end
end) ]]

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('vehiclekeys:client:SetOwner')
AddEventHandler('vehiclekeys:client:SetOwner', function(plate, vehicle)
    local VehPlate = plate
    if VehPlate == nil then
        --VehPlate = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), true)).plate
        VehPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), true))
    end
    TriggerServerEvent('vehiclekeys:server:SetVehicleOwner', VehPlate, vehicle)
    if IsPedInAnyVehicle(PlayerPedId()) and plate == GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), true)) then
        SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), true), true, false, true)
    end
    HasKey = true
    --QBCore.Functions.Notify('You picked the keys of the vehicle', 'success', 3500)
end)

--[[ RegisterNetEvent('vehiclekeys:client:GiveKeys')
AddEventHandler('vehiclekeys:client:GiveKeys', function(target)
    local plate = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), true)).plate
    TriggerServerEvent('vehiclekeys:server:GiveVehicleKeys', plate, target)
end) ]]

RegisterNetEvent('vehiclekeys:client:GiveKeys')
AddEventHandler('vehiclekeys:client:GiveKeys', function()
    local coordA = GetEntityCoords(PlayerPedId(), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
    local latestveh = getVehicleInDirection(coordA, coordB)
    
    if latestveh == nil or not DoesEntityExist(latestveh) then
        ESX.Notify("Không tìm được xe!", 'error')
        return
    end
    
    ESX.TriggerServerCallback('vehiclekeys:CheckHasKey', function(hasKey)
        if not hasKey then
            ESX.Notify("Không có chìa khóa!", 'error')
            return
        end

        if #(GetEntityCoords(latestveh) - GetEntityCoords(PlayerPedId(), 0)) > 5 then
            ESX.Notify("Bạn đang đứng ở quá xa chiếc xe!", 'error')
            return
        end
        
        t, distance = ESX.Game.GetClosestPlayer()
        if(distance ~= -1 and distance < 5) then
            TriggerServerEvent('vehiclekeys:server:GiveVehicleKeys', GetVehicleNumberPlateText(latestveh), GetPlayerServerId(t))
            TriggerEvent("debug", 'Keys: Give Vehicle Keys', 'success')
        else
           ESX.Notify("No player near you!", 'error')
            TriggerEvent("debug", 'Keys: No Player Nearby', 'error')
        end
    end, GetVehicleNumberPlateText(latestveh))
end)

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle
  
    for i = 0, 100 do
      rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0) 
      a, b, c, d, vehicle = GetRaycastResult(rayHandle)
      
      offset = offset - 1
  
      if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    
    if distance > 25 then vehicle = nil end
  
      return vehicle ~= nil and vehicle or 0
  end

RegisterNetEvent('vehiclekeys:client:ToggleEngine')
AddEventHandler('vehiclekeys:client:ToggleEngine', function()
    local EngineOn = IsVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()))
    local veh = GetVehiclePedIsIn(PlayerPedId(), true)
    if HasKey then
        if EngineOn then
            SetVehicleEngineOn(veh, true, true, true)
        else
            SetVehicleEngineOn(veh, true, false, true)
        end
    end
end)

RegisterNetEvent('lockpicks:UseLockpick')
AddEventHandler('lockpicks:UseLockpick', function(isAdvanced)
    if (IsPedInAnyVehicle(PlayerPedId())) then
        if not HasKey then
            LockpickIgnition(isAdvanced)
        end
    else
        LockpickDoor(isAdvanced)
    end
end)

function RobVehicle(target)
    IsRobbing = true
    Citizen.CreateThread(function()
        while IsRobbing do
            local RandWait = math.random(10000, 15000)
            loadAnimDict("random@mugging3")

            TaskLeaveVehicle(target, GetVehiclePedIsIn(target, true), 256)
            Citizen.Wait(2000)
            ClearPedTasksImmediately(target)

            TaskStandStill(target, RandWait)
            TaskHandsUp(target, RandWait, PlayerPedId(), 0, false)

            Citizen.Wait(RandWait)

            --TaskReactAndFleePed(target, PlayerPedId())
            IsRobbing = false
        end
    end)
end

RegisterNetEvent('pw-garage:LockVehicle')
AddEventHandler('pw-garage:LockVehicle', function()
    LockVehicle()
end)

function LockVehicle()
    --local veh = ESX.Game.GetClosestVehicle()
    local coordA = GetEntityCoords(PlayerPedId(), true)
    local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 255.0, 0.0)
    local veh = GetClosestVehicleInDirection(coordA, coordB)
    local pos = GetEntityCoords(PlayerPedId(), true)
    if IsPedInAnyVehicle(PlayerPedId()) then
        veh = GetVehiclePedIsIn(PlayerPedId())
    end
    local plate = ESX.Game.GetVehicleProperties(veh).plate
    local vehpos = GetEntityCoords(veh, false)
    if veh ~= nil and GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 7.5 then
        ESX.TriggerServerCallback('vehiclekeys:CheckHasKey', function(result)
            if result then
                if HasKey then
                    local vehLockStatus = GetVehicleDoorLockStatus(veh)
                    loadAnimDict("anim@mp_player_intmenu@key_fob@")
                    TaskPlayAnim(PlayerPedId(), 'anim@mp_player_intmenu@key_fob@', 'fob_click' ,3.0, 3.0, -1, 49, 0, false, false, false)
        
                    if vehLockStatus == 1 then
                        Citizen.Wait(750)
                        ClearPedTasks(PlayerPedId())
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "lock", 0.3)
                        SetVehicleDoorsLocked(veh, 2)
                        if(GetVehicleDoorLockStatus(veh) == 2)then
                            TriggerEvent("ESX:Notify", "Xe đã được khóa!","error")
                            
                        else
                            TriggerEvent("ESX:Notify", "Có lỗi xảy ra!","info")
                            
                        end
                    else
                        Citizen.Wait(750)
                        ClearPedTasks(PlayerPedId())
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.3)
                        SetVehicleDoorsLocked(veh, 1)
                        if(GetVehicleDoorLockStatus(veh) == 1) then
                            TriggerEvent("ESX:Notify", "Xe đã được mở khóa!","success")
                        else
                            TriggerEvent("ESX:Notify", "Có lỗi xảy ra!","info")
                        end
                    end
        
                    if not IsPedInAnyVehicle(PlayerPedId()) then
                        SetVehicleInteriorlight(veh, true)
                        SetVehicleIndicatorLights(veh, 0, true)
                        SetVehicleIndicatorLights(veh, 1, true)
                        Citizen.Wait(450)
                        SetVehicleIndicatorLights(veh, 0, false)
                        SetVehicleIndicatorLights(veh, 1, false)
                        Citizen.Wait(450)
                        SetVehicleInteriorlight(veh, true)
                        SetVehicleIndicatorLights(veh, 0, true)
                        SetVehicleIndicatorLights(veh, 1, true)
                        Citizen.Wait(450)
                        SetVehicleInteriorlight(veh, false)
                        SetVehicleIndicatorLights(veh, 0, false)
                        SetVehicleIndicatorLights(veh, 1, false)
                    end
                end
            else
                --QBCore.Functions.Notify('You dont have the keys of the vehicle..', 'error')
                TriggerEvent("ESX:Notify", "Bạn không có chìa khóa của xe này","info")
            end
        end, plate)
    end
end

local openingDoor = false
function LockpickDoor(isAdvanced)
    local vehicle = ESX.Game.GetClosestVehicle()
    if vehicle ~= nil and vehicle ~= 0 then
        local vehpos = GetEntityCoords(vehicle)
        local pos = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 1.5 then
            local vehLockStatus = GetVehicleDoorLockStatus(vehicle)
            if (vehLockStatus > 1) then
                local lockpickTime = math.random(15000, 30000)
                if isAdvanced then
                    lockpickTime = math.ceil(lockpickTime*0.5)
                end
                LockpickDoorAnim(lockpickTime)
                PoliceCall()
                IsHotwiring = true
                SetVehicleAlarm(vehicle, true)
                SetVehicleAlarmTimeLeft(vehicle, lockpickTime)
                ESX.Progressbar("lockpick_vehicledoor", "breaking the door open..", lockpickTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    openingDoor = false
                    StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
                    IsHotwiring = false
                    if math.random(1, 100) <= 90 then
                        --QBCore.Functions.Notify("Door open!")
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.3)
                        SetVehicleDoorsLocked(vehicle, 0)
                        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                    else
                        --QBCore.Functions.Notify("Failed!", "error")
                    end
                end, function() -- Cancel
                    openingDoor = false
                    StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
                    --QBCore.Functions.Notify("Failed!", "error")
                    IsHotwiring = false
                end)
            end
        end
    end
end

function LockpickDoorAnim(time)
    time = time / 1000
    loadAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    Citizen.CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(1000)
            time = time - 1
            if time <= 0 then
                openingDoor = false
                StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
    end)
end

function LockpickIgnition(isAdvanced)
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(2, 4)
    end
    if not HasKey then 
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
        if vehicle ~= nil and vehicle ~= 0 then
            if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                IsHotwiring = true
                SucceededAttempts = 0
                PoliceCall()

                if isAdvanced then
                    local maxwidth = 10
                    local maxduration = 1750
                    if FailedAttemps == 1 then
                        maxwidth = 10
                        maxduration = 1500
                    elseif FailedAttemps == 2 then
                        maxwidth = 9
                        maxduration = 1250
                    elseif FailedAttemps >= 3 then
                        maxwidth = 8
                        maxduration = 1000
                    end
                    widthAmount = math.random(5, maxwidth)
                    durationAmount = math.random(500, maxduration)
                else        
                    local maxwidth = 10
                    local maxduration = 1500
                    if FailedAttemps == 1 then
                        maxwidth = 9
                        maxduration = 1250
                    elseif FailedAttemps == 2 then
                        maxwidth = 8
                        maxduration = 1000
                    elseif FailedAttemps >= 3 then
                        maxwidth = 7
                        maxduration = 800
                    end
                    widthAmount = math.random(5, maxwidth)
                    durationAmount = math.random(500, maxduration)
                end

                local dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
                local anim = "machinic_loop_mechandplayer"

                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                    RequestAnimDict(dict)
                    Citizen.Wait(100)
                end

                Skillbar.Start({
                    duration = math.random(5000, 10000),
                    pos = math.random(10, 30),
                    width = math.random(10, 20),
                }, function()
                    if IsHotwiring then
                        if SucceededAttempts + 1 >= NeededAttempts then
                            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                            --QBCore.Functions.Notify("Lockpicking succeeded!")
                            HasKey = true
                            TriggerEvent("vehiclekeys:client:SetOwner", ESX.Game.GetVehicleProperties(vehicle).plate)
                            IsHotwiring = false
                            FailedAttemps = 0
                            SucceededAttempts = 0
                            NeededAttempts = 0
                            TriggerServerEvent('qb-hud:Server:GainStress', math.random(2, 4))
                        else
                            if vehicle ~= nil and vehicle ~= 0 then
                                TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 8.0, -1, 16, -1, false, false, false)
                                if isAdvanced then
                                    local maxwidth = 10
                                    local maxduration = 1750
                                    if FailedAttemps == 1 then
                                        maxwidth = 10
                                        maxduration = 1500
                                    elseif FailedAttemps == 2 then
                                        maxwidth = 9
                                        maxduration = 1250
                                    elseif FailedAttemps >= 3 then
                                        maxwidth = 8
                                        maxduration = 1000
                                    end
                                    widthAmount = math.random(5, maxwidth)
                                    durationAmount = math.random(400, maxduration)
                                else        
                                    local maxwidth = 10
                                    local maxduration = 1300
                                    if FailedAttemps == 1 then
                                        maxwidth = 9
                                        maxduration = 1150
                                    elseif FailedAttemps == 2 then
                                        maxwidth = 8
                                        maxduration = 900
                                    elseif FailedAttemps >= 3 then
                                        maxwidth = 7
                                        maxduration = 750
                                    end
                                    widthAmount = math.random(5, maxwidth)
                                    durationAmount = math.random(300, maxduration)
                                end

                                SucceededAttempts = SucceededAttempts + 1
                                Skillbar.Repeat({
                                    duration = durationAmount,
                                    pos = math.random(10, 50),
                                    width = widthAmount,
                                })
                            else
                                ClearPedTasksImmediately(PlayerPedId())
                                HasKey = false
                                SetVehicleEngineOn(vehicle, false, false, true)
                                QBCore.Functions.Notify("You have to be in the vehicle", "error")
                                IsHotwiring = false
                                FailedAttemps = FailedAttemps + 1
                                local c = math.random(2)
                                local o = math.random(2)
                                if c == o then
                                    TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 4))
                                end
                            end
                        end
                    end
                end, function()
                    if IsHotwiring then
                        StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                        HasKey = false
                        SetVehicleEngineOn(vehicle, false, false, true)
                        QBCore.Functions.Notify("Lockpicking failed!", "error")
                        IsHotwiring = false
                        FailedAttemps = FailedAttemps + 1
                        local c = math.random(2)
                        local o = math.random(2)
                        if c == o then
                            TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 4))
                        end
                    end
                end)
            end
        end
    end
end

function Hotwire()
    if not HasKey then 
        local player = PlayerPedId()
        local playerVeh = GetVehiclePedIsIn(player, false)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
        IsHotwiring = true
        local hotwireTime = math.random(1000, 10000)
        SetVehicleAlarm(vehicle, true)
        SetVehicleAlarmTimeLeft(vehicle, hotwireTime)
        PoliceCall()
        --exports['rprogress']:Start("Hello",10000)
        --[[ exports['rprogress']:Custom({
            Animation = {
                animationDictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                animationName = "machinic_loop_mechandplayer",
            },
            Duration = tonumber(1000),
            OnComplete = {Active()},         
        }) ]]   
        ESX.Progressbar("hotwire_vehicle", "Engaging the ignition switch", hotwireTime, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 16,
        }, {}, {}, 
        function() -- Done
            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            if (math.random(0, 100) < 50) then
                HasKey = true
                SetVehicleEngineOn(vehicle, true, true, true)
                --QBCore.Functions.Notify("Hotwire succeeded!")
            else
                HasKey = false
                SetVehicleEngineOn(vehicle, false, false, true)
                --QBCore.Functions.Notify("Hotwire failed!", "error")
            end
            IsHotwiring = false
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            HasKey = false
            SetVehicleEngineOn(vehicle, false, false, true)
            --QBCore.Functions.Notify("Hotwire failed!", "error")
            IsHotwiring = false
        end) 
    end
end


function Active()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
    if (math.random(0, 100) < 90) then
        HasKey = true
        SetVehicleEngineOn(vehicle, true, true, true)
        --QBCore.Functions.Notify("Hotwire succeeded!")
        print('a')
    else
        HasKey = false
        SetVehicleEngineOn(vehicle, false, false, true)
        --QBCore.Functions.Notify("Hotwire failed!", "error")
        print('b')
    end
end    
function PoliceCall()
    if not AlertSend then
        local pos = GetEntityCoords(PlayerPedId())
        local chance = 20
        if GetClockHours() >= 1 and GetClockHours() <= 6 then
            chance = 10
        end
        if math.random(1, 100) <= chance then
            local closestPed = GetNearbyPed()
            if closestPed ~= nil then
                local msg = ""
                local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
                local streetLabel = GetStreetNameFromHashKey(s1)
                local street2 = GetStreetNameFromHashKey(s2)
                if street2 ~= nil and street2 ~= "" then 
                    streetLabel = streetLabel .. " " .. street2
                end
                local alertTitle = ""
                if IsPedInAnyVehicle(PlayerPedId()) then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    local modelName = GetEntityModel(vehicle)
                    --if QBCore.Shared.VehicleModels[modelName] ~= nil then
                      --  Name = QBCore.Shared.Vehicles[QBCore.Shared.VehicleModels[modelName]["model"]]["brand"] .. ' ' .. QBCore.Shared.Vehicles[QBCore.Shared.VehicleModels[modelName]["model"]]["name"]
                    --else
                      --  Name = "Unknown"
                    --end 
                    local modelPlate = GetVehicleNumberPlateText(vehicle)
                    local msg = "Vehicle theft attempt at " ..streetLabel.. ". Vehicle: " .. Name .. ", Licensplate: " .. modelPlate
                    local alertTitle = "Vehicle theft attempt at"
                    TriggerServerEvent("police:server:VehicleCall", pos, msg, alertTitle, streetLabel, modelPlate, Name)
                else
                    local vehicle = ESX.Game.GetClosestVehicle()
                    
                    local modelName = GetEntityModel(vehicle)
                    local modelPlate = GetVehicleNumberPlateText(vehicle)
                    --if QBCore.Shared.VehicleModels[modelName] ~= nil then
                      --  Name = QBCore.Shared.Vehicles[QBCore.Shared.VehicleModels[modelName]["model"]]["brand"] .. ' ' .. QBCore.Shared.Vehicles[QBCore.Shared.VehicleModels[modelName]["model"]]["name"]
                    --else
                      --  Name = "Unknown"
                    --end
                    local msg = "Vehicle theft attempt at " ..streetLabel.. ". Vehicle: " .. Name .. ", Licenceplate: " .. modelPlate
                    local alertTitle = "Vehicle theft attempt at"
                    TriggerServerEvent("police:server:VehicleCall", pos, msg, alertTitle, streetLabel, modelPlate, Name)
                end
            end
        end
        AlertSend = true
        SetTimeout(2 * (60 * 1000), function()
            AlertSend = false
        end)
    end
end

function GetClosestVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 250 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

function GetNearbyPed()
	local retval = nil
	local PlayerPeds = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        --table.insert(PlayerPeds, ped)
		PlayerPeds[#PlayerPeds + 1] = ped
    end
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
	local closestPed, closestDistance = ESX.Game.GetClosestPed(coords, PlayerPeds)
	if not IsEntityDead(closestPed) and closestDistance < 30.0 then
		retval = closestPed
	end
	return retval
end

function IsBlacklistedWeapon()
    local weapon = GetSelectedPedWeapon(PlayerPedId())
    if weapon ~= nil then
        for _, v in pairs(BBGarages.Config['settings']['blacklistedWeapons']) do
            if weapon == GetHashKey(v) then
                return true
            end
        end
    end
    return false
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end