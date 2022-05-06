-- Vars or locals
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local isInVeh = false

local lastVeh
local lastModel
local lastPlate
local wasRunning
local nextUpdate = 0

local starting = false

local vehData = {}

vehData.ignition = 0
vehData.engine = 0
vehData.km = 0
vehData.engineCheck = 0
vehData.startCheck = 0
vehData.owned = false


local timeStart = 0.5

distance = 0
showKM = 0

-- Events
RegisterNetEvent('vehicle_system:fixengine')
AddEventHandler('vehicle_system:fixengine', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        local plate = GetVehicleNumberPlateText(vehicle)

        updateKms(plate)
        Citizen.Wait(500)
        TriggerServerEvent('vehicle_system:fixEngineCheck', plate)
        Citizen.Wait(500)
        TriggerServerEvent('vehicle_system:getVehInfo', plate, vehicle)
        checkEngineKms(vehicle)
    end
end)

RegisterNetEvent('vehicle_system:fixstart')
AddEventHandler('vehicle_system:fixstart', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        local plate = GetVehicleNumberPlateText(vehicle)

        updateKms(plate)
        Citizen.Wait(500)
        TriggerServerEvent('vehicle_system:fixStartCheck', plate)
        Citizen.Wait(500)
        TriggerServerEvent('vehicle_system:getVehInfo', plate, vehicle)
        checkEngineKms(vehicle)
    end
end)

RegisterNetEvent('vehicle_system:getVehInfoClient')
AddEventHandler('vehicle_system:getVehInfoClient', function(data, curCar)
    vehData = data
    updateVehicle(curCar)
    checkEngineKms(curCar)

    SendNUIMessage({
        value = round(vehData.km, 2),
        action = "showMessage"
    })

    isInVeh = true

end)

-- Functions
function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
  end

function ShowHelpNotification(name, msg)
        if not IsHelpMessageOnScreen() then
        AddTextEntry(name, msg)
                BeginTextCommandDisplayHelp(name)
                EndTextCommandDisplayHelp(0, false, true, -1)
        end
end

function checkEngineKms(vehUsing)
    local lastEngineCheck = vehData.km - vehData.engineCheck
    local lastStartCheck = vehData.km - vehData.startCheck
    local actualEngineDamage = GetVehicleEngineHealth(vehUsing)
    timeStart = 0.5
    for i, startCheck in ipairs(config.startCheck) do
        if lastStartCheck >= (startCheck.moreThan * 100) then
            timeStart = startCheck.time
        end
    end

    for i, engineCheck in ipairs(config.engineCheck) do
        if lastEngineCheck >= (engineCheck.moreThan * 100) then
            if actualEngineDamage > engineCheck.maxHealth then
                SetVehicleEngineHealth(vehUsing, engineCheck.maxHealth)
            end
        end
    end

    if timeStart < 0.5 then
        timeStart = 0.5
    end
end

function updateVehicle(vehUsing)

    if vehData.ignition == 1 then
        if vehData.engine == 1 then
            SetVehicleEngineOn(vehUsing, true, true, true)
            SetVehicleLights(vehUsing, 0)
            SetVehicleLightsMode(vehUsing, 0)

        else
            SetVehicleEngineOn(vehUsing, false, true, true)
            SetVehicleLights(vehUsing, 2)
            SetVehicleLightsMode(vehUsing, 2)
        end
    elseif vehData.ignition == 0 then
        SetVehicleLights(vehUsing, 0)
        SetVehicleLightsMode(vehUsing, 0)
        SetVehicleEngineOn(vehUsing, false, true, true)
    end
end

function setIgnition(vehUsing)
    if vehData.ignition == 0 and vehData.owned then
        vehData.ignition = 1
        SetVehicleLights(vehUsing, 2)
        SetVehicleLightsMode(vehUsing, 2)
        SetVehicleEngineOn(vehUsing, false, true, true)
    else
        vehData.ignition = 0
        SetVehicleLights(vehUsing, 0)
        SetVehicleLightsMode(vehUsing, 0)
        SetVehicleEngineOn(vehUsing, false, true, true)
    end
end

function setEngine(vehUsing)
    checkEngineKms(curCar)

    if vehData.engine == 0 and vehData.owned then
        vehData.engine = 1
        SetVehicleLights(vehUsing, 0)
        SetVehicleLightsMode(vehUsing, 0)
        SetVehicleEngineOn(vehUsing, true, false, true)
        SetVehicleEngineCanDegrade(vehUsing, true)
    else
        vehData.engine = 0
        SetVehicleEngineOn(vehUsing, false, true, true)
        local vehSpeed = GetEntitySpeed(vehUsing)
    end
end

function updateKms(vehUsing)
    TriggerServerEvent('vehicle_system:updateVehInfo', vehUsing, vehData)
end




Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, true) then
            local currentVehicle = GetVehiclePedIsUsing(ped)
            local currentModel = GetEntityModel(currentVehicle)
            local currentPlate = GetVehicleNumberPlateText(currentVehicle)
            if not isInVeh then
                if GetPedInVehicleSeat(currentVehicle, -1) == ped then
                    local plate = GetVehicleNumberPlateText(currentVehicle)
                    lastVeh = currentVehicle
                    lastModel = currentModel
                    lastPlate = plate
                    --TriggerServerEvent('vehicle_system:getVehInfo', plate, currentVehicle)
					
					ESX.TriggerServerCallback('vehicle_system:checkowner', function(have)
						if have then 
							TriggerServerEvent('vehicle_system:getVehInfo', plate, currentVehicle)
						else
						end

					end,plate)
                end
            end
            if isInVeh and (currentVehicle ~= lastVeh or currentModel ~= lastModel or currentPlate ~= lastPlate) then
                updateKms(lastPlate)
                isInVeh = false
            end
        elseif not IsPedInAnyVehicle(ped, true) and isInVeh then
            updateKms(lastPlate)
            SetVehicleEngineOn(lastVeh, wasRunning, false, false)
            vehData.ignition = 0
            vehData.engine = 0
            vehData.km = 0
            vehData.engineCheck = 0
            vehData.startCheck = 0
            vehData.owned = false
            isInVeh = false
            lastVeh = nil
            lastModel = nil
            lastPlate = nil
            wasRunning = nil

            SendNUIMessage({
                action = "hideMessage"
            })

        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if notif and vehData.engine == 0 and not starting and isInVeh then
            local ped = PlayerPedId()
            local crVeh = GetVehiclePedIsUsing(ped)
            if DoesEntityExist(crVeh) then
                if GetIsVehicleEngineRunning(crVeh) or IsVehicleEngineStarting(crVeh) then
                    SetVehicleEngineOn(crVeh, false, true, true)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) and isInVeh and next(vehData) then
            local crVeh = GetVehiclePedIsUsing(ped)
            if GetPedInVehicleSeat(crVeh, -1) == ped then
                if vehData.engine == 0 and vehData.ignition == 1 then
                    notif = config.lang.turnOnEngine .. "\n" .. config.lang.turnOffIgnition
                elseif vehData.ignition == 0 then
                    notif = config.lang.turnOnIgnition
                else
                    notif = nil
                end
                if notif and vehData.owned then
                    ShowHelpNotification("vehicle_system", notif)
                end
                if IsControlJustPressed(0, config.key) then
                    if vehData.engine == 0 and vehData.ignition == 1 then
                        timer = GetGameTimer()
                        time = -1
                        newtime = 250
                        status = true

                        while IsControlPressed(0, config.key) do
                            starting = true
                            time = GetGameTimer() - timer
                            if GetIsVehicleEngineRunning(crVeh) then
                                SetVehicleEngineOn(crVeh, false, true, true)
                            end
                            if newtime < time then
                                status = not status
                                SetVehicleEngineOn(crVeh, status, false, true)
                                newtime = time + 250
                            end
                            if time > timeStart*1000 then
                                SetVehicleEngineOn(crVeh, false, true, true)
                                setEngine(crVeh)
                                timer = nil
                                time = nil
                                newtime = nil
                                starting = false
                                break
                            end
                            Citizen.Wait(0)
                        end
                        while not IsControlPressed(0, config.key) do
                            if time ~= -1 and time < 1*1000 then
                                setIgnition(crVeh)
                                timer = nil
                                time = nil
                                newtime = nil
                                starting = false
                                break
                            else
                                starting = false
                            end
                            Citizen.Wait(0)
                        end
                    elseif vehData.engine == 0 and vehData.ignition == 0 then
                            setIgnition(crVeh)
                    elseif vehData.engine == 1 and vehData.ignition == 1 then
                        setEngine(crVeh)
                        setIgnition(crVeh)
                    end
                end
                if IsControlJustPressed(0, 75) then
                    wasRunning = GetIsVehicleEngineRunning(crVeh)
                end
            end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        if IsPedInAnyVehicle(PlayerPedId(), false) and vehData.engine == 1 then
            local veh = GetVehiclePedIsIn(PlayerPedId(),false)
            local driver = GetPedInVehicleSeat(veh, -1)
            if driver == PlayerPedId() and
                GetVehicleClass(veh) ~= 13 and
                GetVehicleClass(veh) ~= 14 and
                GetVehicleClass(veh) ~= 15 and
                GetVehicleClass(veh) ~= 16 and 
                GetVehicleClass(veh) ~= 17 and
                GetVehicleClass(veh) ~= 21 then

                vehPlate = GetVehicleNumberPlateText(veh)

                local oldPos = GetEntityCoords(PlayerPedId())

                Citizen.Wait(1000)
                local curPos = GetEntityCoords(PlayerPedId())

                if IsVehicleOnAllWheels(veh) then
                    dist = GetDistanceBetweenCoords(oldPos.x, oldPos.y, oldPos.z, curPos.x, curPos.y, curPos.z, true)
                else
                    dist = 0
                end

                if vehData.engine == 1 then
                    vehData.km = vehData.km + dist
                    SendNUIMessage({
                        value = round(vehData.km, 2),
                        action = "showMessage"
                    })
                end
            end

          end
          Citizen.Wait(500)
      end
  end)

  Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(PlayerPedId(), false) and vehData.engine == 1 then
            local GameTimer = GetGameTimer()
            if nextUpdate == nil or GameTimer >= nextUpdate then
                nextUpdate = GameTimer + (config.autoSaving*1000)
                local crVeh = GetVehiclePedIsUsing(ped)
                updateKms(GetVehicleNumberPlateText(crVeh))
                checkEngineKms(crVeh)
            end
        end
        Citizen.Wait(800)
    end
end)