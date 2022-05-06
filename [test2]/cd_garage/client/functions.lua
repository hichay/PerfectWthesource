function GetUpgradeStats(props)
    local stats = {}
    stats.engine = props.modEngine+1
    stats.brakes = props.modBrakes+1
    stats.transmission = props.modTransmission+1
    stats.suspension = props.modSuspension+1
    if props.modTurbo == 1 then
        stats.turbo = 1
    elseif props.modTurbo == false then
        stats.turbo = 0
    end
    return stats
end

function GetPerformanceStats(vehicle)
    local data = {}
    data.acceleration = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDriveForce')
    data.brakes = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fBrakeForce')
    local topspeed1 = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel')
    local topspeed2 = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDragCoeff')
    data.topspeed = math.ceil(CalculateTopSpeed(topspeed1, topspeed2))
    local handling1 = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionBiasFront')
    local handling2 = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveMax')
    local handling3 = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveMin')
    data.handling = CalculateHandling(handling1, handling2, handling3)
    return data
end

function CalculateTopSpeed(topspeed1, topspeed2)
    local calc
    if topspeed2 >= 1.5 then
        calc = 0.9
    elseif topspeed2 >= 1.0 then
        calc = 1.0 
    elseif topspeed2 >= 0.5 then
        calc = 1.1 
    elseif topspeed2 >= 0.1 then
        calc = 1.2
    end
    return ((topspeed1*calc)*1.1)
end

function CalculateHandling(handling1, handling2, handling3)
    local calc = (handling1+handling2)
    return (calc*handling3)
end

function GetHealthStats(props)
    local data = {}
    data.engine_health = math.ceil(props.engineHealth)
    data.body_health = math.ceil(props.bodyHealth)
    data.fuel_level = math.ceil(props.fuelLevel)
    return data
end

function SetVehicleProperties(vehicle, props)
    if Config.UseESX then
        ESX.Game.SetVehicleProperties(vehicle, props)
    else
        SetVehicleProps_NONESX(vehicle, props)
    end
    
    if Config.SaveCarHealth then
        if props.tyres then
            for t = 1, 7 do
                if props.tyres[t] ~= false then
                    SetVehicleTyreBurst(vehicle, t, true, 1000)
                end
            end
        end
        if props.doors then
            for id = 0, 5, 1 do
                if props.doors[id] ~= false then
                    SetVehicleDoorBroken(vehicle, id-1, true)
                end
            end
        end
    end
end

function GetVehicleProperties(vehicle)
    if DoesEntityExist(vehicle) then
        local props
        if Config.UseESX then
            props = ESX.Game.GetVehicleProperties(vehicle)
        else
            props = GetVehicleProps_NONESX(vehicle)
        end
        props.plate = tostring(GetVehicleNumberPlateText(vehicle))
        if not Config.SaveCarHealth then
            return props
        end
        props.tyres = {}
        props.doors = {}
        for t = 1, 7 do
            local tyre1 = IsVehicleTyreBurst(vehicle, t, true)
            local tyre2 = IsVehicleTyreBurst(vehicle, t, false)
            if tyre1 or tyre2 then
                props.tyres[t] = true
            else
                props.tyres[t] = false
            end
        end
        Wait(100)
        for t = 0, 5 do
            local door = IsVehicleDoorDamaged(vehicle, t)
            if door then
                props.doors[#props.doors+1] = door
            else
                props.doors[#props.doors+1] = false
            end
        end
        Wait(500)
        return props
    end
end

local TimerTable = {
    {time = 20},
    {time = 40},
    {time = 60},
    {time = 80},
    {time = 100},
    {time = 120},
    {time = 140},
    {time = 160},
    {time = 180},
    {time = 200},
    {time = 220},
    {time = 240},
    {time = 260},
    {time = 280},
    {time = 300},
    {time = 320},
    {time = 340},
    {time = 360},
    {time = 380},
    {time = 400},
}

local TimerTable2 = {
    {time = 10},
    {time = 20},
    {time = 40},
    {time = 30},
    {time = 40},
    {time = 50},
    {time = 60},
    {time = 70},
    {time = 80},
    {time = 90},
    {time = 100},
    {time = 110},
    {time = 120},
    {time = 130},
    {time = 140},
    {time = 150},
    {time = 160},
    {time = 170},
    {time = 180},
    {time = 190},
    {time = 200},
    {time = 210},
    {time = 220},
    {time = 230},
    {time = 240},
    {time = 250},
    {time = 260},
    {time = 270},
    {time = 280},
    {time = 290},
    {time = 300},
    {time = 310},
    {time = 320},
    {time = 330},
    {time = 340},
    {time = 350},
    {time = 360},
    {time = 370},
    {time = 380},
    {time = 390},
    {time = 400},
}

function LoadModel(model)
    if not HasModelLoaded(model) and IsModelInCdimage(model) then
        RequestModel(model)
        local timeout = 0
        local dots = '.'
        while not HasModelLoaded(model) do
            Wait(5)
            if timeout <= 400 then
                timeout = timeout + 1
                for k, v in pairs (TimerTable2) do
                    if timeout == v.time then
                        dots = DotMe(dots)
                        break
                    end
                end
                Draw2DText(Locales[Config.Language]['loading_model']..' : '..GetDisplayNameFromVehicleModel(model)..' '..dots)
            else
                print('garage - failed to load car in time')
                break
            end
        end
    end
end

function RegisterEntity(vehicle)
    local timeout = 0
    local finaltimer = 0
    local dots = '.'
    while not DoesEntityExist(vehicle) and timeout <= 400 do 
        Wait(5)
        timeout = timeout + 1
        for k, v in pairs (TimerTable) do
            if timeout == v.time then
                finaltimer = finaltimer + 1
                dots = DotMe(dots)
                break
            end
        end
        Draw2DText(Locales[Config.Language]['registering_entity']..' '..finaltimer..'/20'..' '..dots)
    end
    if not DoesEntityExist(vehicle) then
        CD_DeleteVehicle(vehicle)
        Error_Notification(Locales[Config.Language]['registering_entity_failed'])
    end
end

function RequestNetworkControl(vehicle)
    local timeout = 0
    local finaltimer = 0
    local dots = '.'
    while not NetworkHasControlOfEntity(vehicle) and timeout <= 400 do 
        Wait(5)
        timeout = timeout + 1
        for k, v in pairs (TimerTable) do
            if timeout == v.time then
                finaltimer = finaltimer + 1
                dots = DotMe(dots)
                break
            end
        end
        NetworkRequestControlOfEntity(vehicle)
        Draw2DText(Locales[Config.Language]['registering_network']..' '..finaltimer..'/20'..' '..dots)
    end
    if not NetworkHasControlOfEntity(vehicle) then
        CD_DeleteVehicle(vehicle)
        Error_Notification(Locales[Config.Language]['registering_network_failed'])
    end
end

function RegisterEntityNetworked(vehicle)
    local timeout = 0
    local finaltimer = 0
    local dots = '.'
    while not NetworkGetEntityIsNetworked(vehicle) and timeout <= 400 do 
        Wait(5)
        timeout = timeout + 1
        for k, v in pairs (TimerTable) do
            if timeout == v.time then
                finaltimer = finaltimer + 1
                dots = DotMe(dots)
                break
            end
        end
        NetworkRegisterEntityAsNetworked(vehicle)
        Draw2DText(Locales[Config.Language]['registering_entitynetwork']..' '..finaltimer..'/20'..' '..dots)
    end
    if not NetworkGetEntityIsNetworked(vehicle) then
        CD_DeleteVehicle(vehicle)
        Error_Notification(Locales[Config.Language]['registering_entitynetwork_failed'])
    end     
end

function RequestNetworkId(vehicle)
    local timeout = 0
    local finaltimer = 0
    local dots = '.'
    local netID = NetworkGetNetworkIdFromEntity(vehicle)
    while not NetworkHasControlOfNetworkId(netID) and timeout <= 400 do 
        Wait(5)
        timeout = timeout + 1
        for k, v in pairs (TimerTable) do
            if timeout == v.time then
                finaltimer = finaltimer + 1
                dots = DotMe(dots)
                break
            end
        end
        NetworkRequestControlOfNetworkId(netID)
        Draw2DText(Locales[Config.Language]['requesting_netid']..' '..finaltimer..'/20'..' '..dots)
    end
end
function RequestCollision(coords, vehicle)
    RequestCollisionAtCoord(coords.x, coords.y, coords.z)
    while not HasCollisionLoadedAroundEntity(vehicle) do
        RequestCollisionAtCoord(coords.x, coords.y, coords.z)
        Citizen.Wait(0)
    end
end

function DotMe(dots)
    if dots == '.' then
        dots = '..'
    elseif dots == '..' then
        dots = '...'
    elseif dots == '...' then
        dots = '.'
    end
    return dots
end

function Draw2DText(text)
    SetTextFont(4)
    SetTextScale(0.0, 0.4)
    SetTextColour(255, 255, 255, 150)
    SetTextCentre(true)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.5, 0.9)
end

function GetVehicleLabel(vehicle)
    local vehicleLabel = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
        
    if vehicleLabel == 'null' or vehicleLabel == 'carnotfound' or vehicleLabel == 'NULL' then
        vehicleLabel = 'vehicle'
    end
    if vehicleLabel ~= 'null' or vehicleLabel ~= 'carnotfound' or vehicleLabel ~= 'NULL'then
        local text = GetLabelText(vehicleLabel)
        if text == nil or text == 'null' or text == 'NULL' then
            vehicleLabel = vehicleLabel
        else
            vehicleLabel = text
        end
    end
    return vehicleLabel
end

function GetVehicleLabel_model(model)
    local vehicleLabel = string.lower(GetDisplayNameFromVehicleModel(model))
        
    if vehicleLabel == 'null' or vehicleLabel == 'carnotfound' or vehicleLabel == 'NULL' then
        vehicleLabel = 'vehicle'
    end
    if vehicleLabel ~= 'null' or vehicleLabel ~= 'carnotfound' or vehicleLabel ~= 'NULL'then
        local text = GetLabelText(vehicleLabel)
        if text == nil or text == 'null' or text == 'NULL' then
            vehicleLabel = vehicleLabel
        else
            vehicleLabel = text
        end
    end
    return vehicleLabel
end

function CreateGarage()
    local ped = GetPlayerPed(-1)
    shell_coords = GetEntityCoords(ped)-vector3(0,0,Config.Shell_Zaxis)
    local model = GetHashKey('10cargarage_shell')
    shell = CreateObject(model, shell_coords.x, shell_coords.y, shell_coords.z, false, false, false)
    while not DoesEntityExist(shell) do Wait(0) end
    FreezeEntityPosition(shell, true)
    SetEntityAsMissionEntity(shell, true, true)
    SetModelAsNoLongerNeeded(model)
    shell_door_coords = vector3(shell_coords.x+7, shell_coords.y-19, shell_coords.z)
    Teleport(ped, shell_door_coords.x, shell_door_coords.y, shell_door_coords.z, 82.0, true)
    ToggleShellTime('enter')
    TriggerEvent('cd_garage:cam')
    TriggerEvent('cd_garage:CancelCamOption')
    SetPlayerInvisibleLocally(ped, true)
end

function DeleteGarage()
    DeleteObject(shell)
    DeleteEntity(shell)
    SetPlayerInvisibleLocally(GetPlayerPed(-1), false)
end

RegisterNetEvent('cd_garage:CancelCamOption')
AddEventHandler('cd_garage:CancelCamOption', function()
    DrawTextUI('show', '<b>'..Locales[Config.Language]['garage']..'<b/></p>'..Locales[Config.Language]['cancel_cam'])
    while cam ~= nil do
        Wait(5)
        if IsControlJustReleased(0, 18) then
            cam = nil
            DisableCam()
        end
    end
    DrawTextUI('hide')
end)

RegisterNetEvent('cd_garage:cam')
AddEventHandler('cd_garage:cam', function()
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
    SetCamActive(cam, true)
    SetCamParams(cam, shell_door_coords.x-7, shell_door_coords.y+1, shell_door_coords.z+1,     5.27, 0.5186, 300.0,    70.0,       0, 1, 1, 2) --start cam location
    SetCamParams(cam, shell_door_coords.x-8, shell_door_coords.y+27, shell_door_coords.z+1,     5.27, 0.5186, 200.0,   70.0,      6000, 0, 0, 2) --end cam location
    RenderScriptCams(true, false, 3000, 1, 1)
    if cam == nil then return end
    Wait(5500)
    if cam == nil then return end
    DoScreenFadeOut(500)
    Wait(500)
    if cam == nil then return end
    stage2()
end)

function stage2()
    DoScreenFadeIn(500)
    if cam == nil then return end
    SetCamParams(cam, shell_door_coords.x-9, shell_door_coords.y+27, shell_door_coords.z+1,     5.27, 0.5186, 100.0,       70.0,       0, 1, 1, 2) --start cam location
    SetCamParams(cam, shell_door_coords.x-8, shell_door_coords.y+1, shell_door_coords.z+1,    5.27, 0.5186, 0.0,         70.0,      6000, 0, 0, 2) --end cam location
    RenderScriptCams(true, false, 3000, 1, 1)
    if cam == nil then return end
    Wait(7000)
    DisableCam()
end

function DisableCam()
    in_cam = false
    SetCamActive(cam, false)
    DestroyCam(cam, false)
    RenderScriptCams(false, true, 500, true, true)
    FreezeEntityPosition(PlayerPedId(), false)
end

function GetGarageType(vehicle)
    local hash = GetEntityModel(vehicle)
    local garage_type = 'car'
    if IsThisModelAHeli(hash) or IsThisModelAPlane(hash) then
        garage_type = 'air'
    elseif IsThisModelABoat(hash) or IsThisModelAJetski(hash) then
        garage_type = 'boat'
    end
    return garage_type
end

function CheckCorrectImpound(garage_type, impound)
    if string.find(impound, 'air') then
        if garage_type == 'air' then
            return true
        else
            return false
        end
    elseif string.find(impound, 'boat') then
        if garage_type == 'boat' then
            return true
        else
            return false
        end
    elseif string.find(impound, 'car') then
       if garage_type == 'car' then
            return true
        else
            return false
        end
    else
        return false
    end
end

function GetPlayers()
    local players = {}

    for _, i in ipairs(GetActivePlayers()) do
        table.insert(players, i)
    end

    return players
end

function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    if closestDistance <= radius then
        return closestPlayer
    else
        return nil
    end
end

function CheckSpawnArea(veh, coords)
    local new_coords = coords
    local closestPlayer = GetClosestPlayer(3)
    if closestPlayer ~= nil and closestPlayer ~= -1 then
        new_coords = new_coords + GetEntityForwardVector(veh) * 6.0
        SetEntityCoords(veh, new_coords.x, new_coords.y, new_coords.z)
    else
        new_coords = nil
        return
    end

    local closestPlayer = GetClosestPlayer(3)
    if closestPlayer ~= nil and closestPlayer ~= -1 then
        new_coords = new_coords + GetEntityForwardVector(veh) * 6.0
        SetEntityCoords(veh, new_coords.x, new_coords.y, new_coords.z)
    else
        new_coords = nil
        return
    end

    local closestPlayer = GetClosestPlayer(3)
    if closestPlayer ~= nil and closestPlayer ~= -1 then
        new_coords = new_coords + GetEntityForwardVector(veh) * 6.0
        SetEntityCoords(veh, new_coords.x, new_coords.y, new_coords.z)
    else
        new_coords = nil
        return
    end

    local closestPlayer = GetClosestPlayer(3)
    if closestPlayer ~= nil and closestPlayer ~= -1 then
        new_coords = new_coords + GetEntityForwardVector(veh) * 6.0
        SetEntityCoords(veh, new_coords.x, new_coords.y, new_coords.z)
    else
        new_coords = nil
        return
    end

    new_coords = nil
end

function CheckVehicleOnStreets(plate, in_garage)
    local result = nil
    local gameVehicles = GetVehicles()
    for g = 1, #gameVehicles do
        local vehicle = gameVehicles[g]
        if DoesEntityExist(vehicle) then
            if tostring(GetVehicleNumberPlateText(vehicle)) == tostring(plate) then
                local coords = GetEntityCoords(vehicle, 1)
                if shell_coords ~= nil then
                    local dist = #(vector3(coords.x, coords.y, coords.z)-vector3(shell_coords.x, shell_coords.y, shell_coords.z))
                    if dist > 30 then
                        SetNewWaypoint(coords.x, coords.y)
                        result = 'onstreets'
                        return {result = result, message = Locales[Config.Language]['vehicle_onstreets']}
                    end
                else
                    SetNewWaypoint(coords.x, coords.y)
                    result = 'onstreets'
                    return {result = result, message = Locales[Config.Language]['vehicle_onstreets']}
                end
            end
        end
    end
    if result == nil then
        if not in_garage then
            result = 'outbutnotonstreets'
            return {result = result, message = Locales[Config.Language]['return_vehicle']..''..Config.ReturnVehiclePrice}
        else
            return {result = 'canspawn'}
        end
    end
end

function GetImpoundName(impound)
    for k, v in pairs (Config.Impound) do
        if v.ImpoundID == impound then
            return v.blip.name
        end
    end
end

function roundDecimals(num, decimals)
    local mult = math.pow(10, decimals or 0)
    return math.floor(num * mult + 0.5) / 100
end

function Teleport(ped, x, y, z, h, freeze)
    RequestCollisionAtCoord(x, y, z)
    while not HasCollisionLoadedAroundEntity(ped) do
        RequestCollisionAtCoord(x, y, z)
        Citizen.Wait(1)
    end
    DoScreenFadeOut(950)
    Wait(1000)                            
    SetEntityCoords(ped, x, y, z)
    SetEntityHeading(ped, h)
    if freeze then
        FreezeEntityPosition(ped, true)
    end
    Wait(1000)
    DoScreenFadeIn(3000)
end

function GetClosestVehicle(coords, distance)
    local t = {}
    t.dist = distance
    t.state = false
    for vehicle in EnumerateVehicles() do
        local vehcoords = GetEntityCoords(vehicle)
        local dist = #(coords-vehcoords)
        if dist < t.dist then
            t.dist = dist
            t.vehicle = vehicle
            t.coords = vehcoords
            t.state = true
        end
    end
    t.dist = nil
    return t
end

function GetVehicles()
    local vehicles = {}

    for vehicle in EnumerateVehicles() do
        table.insert(vehicles, vehicle)
    end

    return vehicles
end

local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end

        enum.destructor = nil
        enum.handle = nil
    end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end

        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)

        local next = true
        repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
        until not next

        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function DrawSpotlight(pos)
    local lightPos = vector3(pos.x,pos.y,pos.z + 5.0)
    local direction = pos - lightPos
    local normal = Normalize(direction)
    DrawSpotLight(lightPos.x,lightPos.y,lightPos.z, normal.x,normal.y,normal.z, 255,255,255, 100.0, 10.0, 0.0, 25.0, 1.0)
end
  
function Normalize(v)
    local len = Length(v)
    return vector3(v.x / len, v.y / len, v.z / len)
end
  
function Length(v)
    return math.sqrt( (v.x * v.x)+(v.y * v.y)+(v.z * v.z) )
end

function Round( n )
    return math.floor( n + 0.5 )
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function SetVehicleProps_NONESX(vehicle, props)
    if DoesEntityExist(vehicle) then
        SetVehicleModKit(vehicle, 0)

        if props.plate then SetVehicleNumberPlateText(vehicle, props.plate) end
        if props.plateIndex then SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex) end
        if props.bodyHealth then SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0) end
        if props.engineHealth then SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0) end
        if props.fuelLevel then SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0) end
        if props.dirtLevel then SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0) end
        if props.color1 then SetVehicleColours(vehicle, props.color1, props.color2) end
        if props.color2 then SetVehicleColours(vehicle, props.color1, props.color2) end
        if props.pearlescentColor then SetVehicleExtraColours(vehicle, props.pearlescentColor, props.wheelColor) end
        if props.wheelColor then SetVehicleExtraColours(vehicle, pearlescentColor, props.wheelColor) end
        if props.wheels then SetVehicleWheelType(vehicle, props.wheels) end
        if props.windowTint then SetVehicleWindowTint(vehicle, props.windowTint) end

        if props.neonEnabled then
            SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
            SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
            SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
            SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
        end

        if props.extras then
            for id,enabled in pairs(props.extras) do
                if enabled then
                    SetVehicleExtra(vehicle, tonumber(id), 0)
                else
                    SetVehicleExtra(vehicle, tonumber(id), 1)
                end
            end
        end
        
        if props.neonColor then SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3]) end
        if props.xenonColor then SetVehicleXenonLightsColour(vehicle, props.xenonColor) end
        if props.modSmokeEnabled then ToggleVehicleMod(vehicle, 20, true) end
        if props.tyreSmokeColor then SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3]) end
        if props.modSpoilers then SetVehicleMod(vehicle, 0, props.modSpoilers, false) end
        if props.modFrontBumper then SetVehicleMod(vehicle, 1, props.modFrontBumper, false) end
        if props.modRearBumper then SetVehicleMod(vehicle, 2, props.modRearBumper, false) end
        if props.modSideSkirt then SetVehicleMod(vehicle, 3, props.modSideSkirt, false) end
        if props.modExhaust then SetVehicleMod(vehicle, 4, props.modExhaust, false) end
        if props.modFrame then SetVehicleMod(vehicle, 5, props.modFrame, false) end
        if props.modGrille then SetVehicleMod(vehicle, 6, props.modGrille, false) end
        if props.modHood then SetVehicleMod(vehicle, 7, props.modHood, false) end
        if props.modFender then SetVehicleMod(vehicle, 8, props.modFender, false) end
        if props.modRightFender then SetVehicleMod(vehicle, 9, props.modRightFender, false) end
        if props.modRoof then SetVehicleMod(vehicle, 10, props.modRoof, false) end
        if props.modEngine then SetVehicleMod(vehicle, 11, props.modEngine, false) end
        if props.modBrakes then SetVehicleMod(vehicle, 12, props.modBrakes, false) end
        if props.modTransmission then SetVehicleMod(vehicle, 13, props.modTransmission, false) end
        if props.modHorns then SetVehicleMod(vehicle, 14, props.modHorns, false) end
        if props.modSuspension then SetVehicleMod(vehicle, 15, props.modSuspension, false) end
        if props.modArmor then SetVehicleMod(vehicle, 16, props.modArmor, false) end
        if props.modTurbo then ToggleVehicleMod(vehicle,  18, props.modTurbo) end
        if props.modXenon then ToggleVehicleMod(vehicle,  22, props.modXenon) end
        if props.modFrontWheels then SetVehicleMod(vehicle, 23, props.modFrontWheels, false) end
        if props.modBackWheels then SetVehicleMod(vehicle, 24, props.modBackWheels, false) end
        if props.modPlateHolder then SetVehicleMod(vehicle, 25, props.modPlateHolder, false) end
        if props.modVanityPlate then SetVehicleMod(vehicle, 26, props.modVanityPlate, false) end
        if props.modTrimA then SetVehicleMod(vehicle, 27, props.modTrimA, false) end
        if props.modOrnaments then SetVehicleMod(vehicle, 28, props.modOrnaments, false) end
        if props.modDashboard then SetVehicleMod(vehicle, 29, props.modDashboard, false) end
        if props.modDial then SetVehicleMod(vehicle, 30, props.modDial, false) end
        if props.modDoorSpeaker then SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false) end
        if props.modSeats then SetVehicleMod(vehicle, 32, props.modSeats, false) end
        if props.modSteeringWheel then SetVehicleMod(vehicle, 33, props.modSteeringWheel, false) end
        if props.modShifterLeavers then SetVehicleMod(vehicle, 34, props.modShifterLeavers, false) end
        if props.modAPlate then SetVehicleMod(vehicle, 35, props.modAPlate, false) end
        if props.modSpeakers then SetVehicleMod(vehicle, 36, props.modSpeakers, false) end
        if props.modTrunk then SetVehicleMod(vehicle, 37, props.modTrunk, false) end
        if props.modHydrolic then SetVehicleMod(vehicle, 38, props.modHydrolic, false) end
        if props.modEngineBlock then SetVehicleMod(vehicle, 39, props.modEngineBlock, false) end
        if props.modAirFilter then SetVehicleMod(vehicle, 40, props.modAirFilter, false) end
        if props.modStruts then SetVehicleMod(vehicle, 41, props.modStruts, false) end
        if props.modArchCover then SetVehicleMod(vehicle, 42, props.modArchCover, false) end
        if props.modAerials then SetVehicleMod(vehicle, 43, props.modAerials, false) end
        if props.modTrimB then SetVehicleMod(vehicle, 44, props.modTrimB, false) end
        if props.modTank then SetVehicleMod(vehicle, 45, props.modTank, false) end
        if props.modWindows then SetVehicleMod(vehicle, 46, props.modWindows, false) end

        if props.modLivery then SetVehicleMod(vehicle, 48, props.modLivery, false) end
        if props.modLivery2 then SetVehicleLivery(vehicle, props.modLivery2) end
    end
end

function GetVehicleProps_NONESX(vehicle)
    if DoesEntityExist(vehicle) then
        local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
        local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
        local extras = {}
        r,g,b = GetVehicleNeonLightsColour(vehicle)
        

        for id=0, 12 do
            if DoesExtraExist(vehicle, id) then
                local state = IsVehicleExtraTurnedOn(vehicle, id) == 1
                extras[tostring(id)] = state
            end
        end

        return {
            model             = GetEntityModel(vehicle),

            plate             = tostring(GetVehicleNumberPlateText(vehicle)),   
            plateIndex        = GetVehicleNumberPlateTextIndex(vehicle),

            bodyHealth        = Round(GetVehicleBodyHealth(vehicle)),
            engineHealth      = Round(GetVehicleEngineHealth(vehicle)),
            fuelLevel         = Round(GetVehicleFuelLedvel(vehicle), 1),
            dirtLevel         = Round(GetVehicleDirtLevel(vehicle), 1),
            color1            = colorPrimary,
            color2            = colorSecondary,

            pearlescentColor  = pearlescentColor,
            wheelColor        = wheelColor,

            wheels            = GetVehicleWheelType(vehicle),
            windowTint        = GetVehicleWindowTint(vehicle),
            xenonColor        = GetVehicleXenonLightsColour(vehicle),

            neonEnabled       = {
                IsVehicleNeonLightEnabled(vehicle, 0),
                IsVehicleNeonLightEnabled(vehicle, 1),
                IsVehicleNeonLightEnabled(vehicle, 2),
                IsVehicleNeonLightEnabled(vehicle, 3)
            },

            neonColor = {
                r,
                g,
                b
            },

            extras            = extras,
            tyreSmokeColor    = table.pack(GetVehicleTyreSmokeColor(vehicle)),

            modSpoilers       = GetVehicleMod(vehicle, 0),
            modFrontBumper    = GetVehicleMod(vehicle, 1),
            modRearBumper     = GetVehicleMod(vehicle, 2),
            modSideSkirt      = GetVehicleMod(vehicle, 3),
            modExhaust        = GetVehicleMod(vehicle, 4),
            modFrame          = GetVehicleMod(vehicle, 5),
            modGrille         = GetVehicleMod(vehicle, 6),
            modHood           = GetVehicleMod(vehicle, 7),
            modFender         = GetVehicleMod(vehicle, 8),
            modRightFender    = GetVehicleMod(vehicle, 9),
            modRoof           = GetVehicleMod(vehicle, 10),

            modEngine         = GetVehicleMod(vehicle, 11),
            modBrakes         = GetVehicleMod(vehicle, 12),
            modTransmission   = GetVehicleMod(vehicle, 13),
            modHorns          = GetVehicleMod(vehicle, 14),
            modSuspension     = GetVehicleMod(vehicle, 15),
            modArmor          = GetVehicleMod(vehicle, 16),

            modTurbo          = IsToggleModOn(vehicle, 18),

            modSmokeEnabled   = IsToggleModOn(vehicle, 20),
            modXenon          = IsToggleModOn(vehicle, 22),

            modFrontWheels    = GetVehicleMod(vehicle, 23),
            modBackWheels     = GetVehicleMod(vehicle, 24),

            modPlateHolder    = GetVehicleMod(vehicle, 25),
            modVanityPlate    = GetVehicleMod(vehicle, 26),
            modTrimA          = GetVehicleMod(vehicle, 27),
            modOrnaments      = GetVehicleMod(vehicle, 28),
            modDashboard      = GetVehicleMod(vehicle, 29),
            modDial           = GetVehicleMod(vehicle, 30),
            modDoorSpeaker    = GetVehicleMod(vehicle, 31),
            modSeats          = GetVehicleMod(vehicle, 32),
            modSteeringWheel  = GetVehicleMod(vehicle, 33),
            modShifterLeavers = GetVehicleMod(vehicle, 34),
            modAPlate         = GetVehicleMod(vehicle, 35),
            modSpeakers       = GetVehicleMod(vehicle, 36),
            modTrunk          = GetVehicleMod(vehicle, 37),
            modHydrolic       = GetVehicleMod(vehicle, 38),
            modEngineBlock    = GetVehicleMod(vehicle, 39),
            modAirFilter      = GetVehicleMod(vehicle, 40),
            modStruts         = GetVehicleMod(vehicle, 41),
            modArchCover      = GetVehicleMod(vehicle, 42),
            modAerials        = GetVehicleMod(vehicle, 43),
            modTrimB          = GetVehicleMod(vehicle, 44),
            modTank           = GetVehicleMod(vehicle, 45),
            modWindows        = GetVehicleMod(vehicle, 46),
            modLivery         = GetVehicleMod(vehicle, 48),
            modLivery2        = GetVehicleLivery(vehicle)
        }
    else
        return
    end
end

function CD_DeleteVehicle(vehicle)
    if vehicle ~= nil then
        if not DoesEntityExist(vehicle) then
            TriggerEvent('cd_garage:Error_Notification', Locales[Config.Language]['entity_doesnot_exist'])
            return
        end
        RequestNetworkControl(vehicle)
        RequestNetworkId(vehicle)
        if NetworkHasControlOfEntity(vehicle) then
            SetEntityAsMissionEntity(vehicle)
            SetVehicleHasBeenOwnedByPlayer(vehicle, true)
            Citizen.Wait(100)
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
            SetEntityAsNoLongerNeeded(vehicle)
            DeleteEntity(vehicle)
            DeleteVehicle(vehicle)
        else
            local net = NetworkGetNetworkIdFromEntity(vehicle)
            TriggerServerEvent('cd_garage:DeleteVehicleADV', net)
        end
    end
end

RegisterNetEvent('cd_garage:DeleteVehicleADV')
AddEventHandler('cd_garage:DeleteVehicleADV', function(net)
    local entity = NetworkGetEntityFromNetworkId(net)
    if NetworkHasControlOfEntity(entity) then
        SetEntityAsNoLongerNeeded(entity)
        Citizen.Wait(100)
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity))
        DeleteEntity(entity)
        DeleteVehicle(entity)
    else
        TriggerEvent('cd_garage:Error_Notification', Locales[Config.Language]['no_control_netid'])
    end
end)

RegisterNetEvent('cd_garage:ToggleNUIFocus')
AddEventHandler('cd_garage:ToggleNUIFocus', function()
    NUI_status = true
    while NUI_status do
        Citizen.Wait(5)
        SetNuiFocus(NUI_status, NUI_status)
    end
    SetNuiFocus(false, false)
end)

function SpawnVehicle(data)
    InGarage = false
    TriggerEvent('cd_garage:Exit', false)
    Wait(200)
    local ped = GetPlayerPed(-1)
    local props = data.vehicle
    local model = props.model
    local plate = data.plate
    local adv_stats
    if Config.UseMileage then
        adv_stats = data.adv_stats
    end

    if not IsModelValid(model) then
        return TriggerEvent('cd_garage:Error_Notification', Locales[Config.Language]['invalid_model'])
    end

    LoadModel(model)
    if HasModelLoaded(model) then
        local vehicle = CreateVehicle(model, ExitLocation.x, ExitLocation.y, ExitLocation.z, ExitLocation.h, true, false)
        RegisterEntity(vehicle)

        NetworkFadeInEntity(vehicle, true, true)
        SetVehicleOnGroundProperly(vehicle)
		TriggerServerEvent("vehiclekeys:server:SetVehicleOwner",plate)

        RequestNetworkControl(vehicle)
        RegisterEntityNetworked(vehicle)

        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
        SetVehicleNeedsToBeHotwired(vehicle, false)
        SetEntityAsMissionEntity(vehicle, true, false)
        local netID = NetworkGetNetworkIdFromEntity(vehicle)
        SetNetworkIdCanMigrate(netID, true)
        SetNetworkIdExistsOnAllMachines(netID, true)
        SetPedIntoVehicle(ped, vehicle, -1)
        SetVehicleDirtLevel(vehicle)
        WashDecalsFromVehicle(vehicle, 1.0)
        NetworkRequestControlOfEntity(vehicle)
        SetModelAsNoLongerNeeded(model)

        RequestCollision(ExitLocation, vehicle)

        SetVehRadioStation(vehicle, 'OFF')
        NetworkFadeInEntity(vehicle, true, true)

        if props.fuelLevel == nil then
            props.fuelLevel = 100.0
        end
        SetVehicleProperties(vehicle, props)

        if Config.UseMileage then
            if adv_stats.mileage == nil then
                adv_stats.mileage = 0
            end
            if adv_stats.maxhealth == nil then
                adv_stats.maxhealth = 1000.0
            end
            if adv_stats.plate == nil then
                adv_stats.plate = plate
            end

            local max_health = GetMaxHealth(adv_stats.mileage)

            AdvStatsFunction(plate, adv_stats.mileage, max_health)

            if GetVehicleEngineHealth(vehicle) > max_health then
                SetVehicleEngineHealth(vehicle, max_health)
            end
        end

        CheckSpawnArea(vehicle, vector3(ExitLocation.x, ExitLocation.y, ExitLocation.z))
        Wait(500)
        SetVehicleExtraColours(vehicle, props.pearlescentColor, props.wheelColor)

        if Config.UseMileage then
            TriggerServerEvent('cd_garage:ChangeInGarageState', plate, 0, AdvStatsTable[plate])
        else
            TriggerServerEvent('cd_garage:ChangeInGarageState', plate, 0)
        end
    else
        print('model failed to load, please try again')
        CloseAllNUI()
    end
end

RegisterNetEvent('cd_garage:StartThread_1')
AddEventHandler('cd_garage:StartThread_1', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5)
            if InGarage and MyCars ~= nil then
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped, 1)
                local vehicle = GetClosestVehicle(coords, 5.1)
                if vehicle.state then
                    for g = 1, #MyCars do
                        if MyCars[g] ~= nil then
                            if MyCars[g].vehicle == vehicle.vehicle then
                                if Config.UseSpotlight then
                                    DrawSpotlight(vehicle.coords)
                                end
                                if IsControlJustReleased(0, Config.QuickChoose_Key) then
                                    if not Config.Impound or GarageInfo[g].impound == 0 then
                                        if not Config.UniqueGarages or CurrentGarage == GarageInfo[g].garage_id then
                                            local streetscheck = CheckVehicleOnStreets(GarageInfo[g].plate, GarageInfo[g].in_garage)
                                            if streetscheck.result == 'onstreets' then
                                                InsideAction(streetscheck.message)
                                            elseif streetscheck.result == 'outbutnotonstreets' then
                                                InsideAction(streetscheck.message)
                                            elseif streetscheck.result == 'canspawn' then
                                                SpawnVehicle(GarageInfo[g])
                                            end
                                        else
                                            InsideAction(Locales[Config.Language]['vehicle_is_in']..' <b>'..Locales[Config.Language]['garage']..' '..GarageInfo[g].garage_id..'</b>')
                                        end
                                    else
                                        InsideAction(Locales[Config.Language]['vehicle_is_in_the']..' <b>'..GetImpoundName(GarageInfo[g].impound)..'</b>')
                                    end
                                end
                            end
                        end
                    end
                end
                for i = 1, #BlackListText do
                    local dist = #(vector3(coords.x, coords.y, coords.z)-vector3(BlackListText[i].coords.x, BlackListText[i].coords.y, BlackListText[i].coords.z))
                    if dist <= 5.0 then
                        DrawText3Ds(BlackListText[i].coords.x, BlackListText[i].coords.y, BlackListText[i].coords.z, Locales[Config.Language]['vehicle_toolarge']..''..BlackListText[i].label)
                    end
                end
            else
                break
            end
        end
    end)
end)

RegisterNetEvent('cd_garage:StartThread_2')
AddEventHandler('cd_garage:StartThread_2', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(Config.InsideLoopWait)
            if InGarage and MyCars ~= nil then
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped, 1)
                local vehicle = GetClosestVehicle(coords, 5.1)
                if vehicle.state then
                    for g = 1, #MyCars do
                        if MyCars[g] ~= nil then
                            if MyCars[g].vehicle == vehicle.vehicle and lastvehicle ~= vehicle.vehicle then
                                ShowInsideGarage_UI(MyCars[g])
                            end
                        end
                    end
                else
                    HideInsideGarage_UI()
                end
                lastvehicle = vehicle.vehicle

                local dist2 = #(vector3(coords.x, coords.y, coords.z)-vector3(shell_coords.x, shell_coords.y, shell_coords.z))
                if dist2 > 30 then
                    InGarage = false
                    TriggerEvent('cd_garage:Exit', true)
                    DrawTextUI('hide')
                end
            else
                break
            end
        end
    end)
end)