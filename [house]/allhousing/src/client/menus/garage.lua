

GetVehiclesAtHouse = function(house)
  local data = Callback("Allhousing:GetVehicles",house)
  return data
end

GetVehicleLabel = function(model)
  return (GetLabelText(GetDisplayNameFromVehicleModel(model)))
end

SpawnVehicle = function(pos,model,props)  
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end

  RequestModel(model)
  while not HasModelLoaded(model) do Wait(0); end

  local veh = CreateVehicle(model,pos.x,pos.y,pos.z,true,true)
  while not DoesEntityExist(veh) do Wait(0); end

  SetEntityAsMissionEntity(veh,true,true)
  SetEntityHeading(veh,pos.w)
  SetVehicleOnGroundProperly(veh)
    
  while not NetworkHasControlOfEntity(veh) do NetworkRequestControlOfEntity(veh); Wait(0); end
  while not NetworkGetEntityIsNetworked(veh) do NetworkRegisterEntityAsNetworked(veh); Wait(0); end

  local netId = NetworkGetNetworkIdFromEntity(veh)
  TriggerServerEvent('VehicleSecurity:VehicleSpawned',netId,props.plate)
  Wait(500)
  
  SetVehicleProperties(veh, props)
  SetVehRadioStation(veh, "OFF")
  SetVehicleEngineOn(veh,true)
  TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)

  SetModelAsNoLongerNeeded(model)
end


LeaveGarage = function(d)
  LeavingHouse = true
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end

  DoScreenFadeOut(500)
  TriggerEvent("Allhousing:Leave")
  
  Wait(1000)

  local plyPed = GetPlayerPed(-1)

  SetEntityCoordsNoOffset(plyPed, InsideGarage.Entry.x,InsideGarage.Entry.y,InsideGarage.Entry.z)
  SetEntityHeading(plyPed, InsideGarage.Entry.w - 180.0)

  Wait(500)
  DoScreenFadeIn(500)

  SetEntityAsMissionEntity(InsideGarage.Object,true,true)
  DeleteObject(InsideGarage.Object)
  DeleteEntity(InsideGarage.Object)

  if InsideGarage and InsideGarage.Extras then
    for k,v in pairs(InsideGarage.Extras) do
      SetEntityAsMissionEntity(v,true,true)
      DeleteObject(v)
    end
  end

  InsideGarage = false
  SetWeatherAndTime(true)
  LeavingHouse = false
end

SpawnGarage = function(d)
  for k,v in pairs(d) do
  print(k,v)
  end
  local model = ShellModels[d.ShellGarage]
  local hash  = GetHashKey(model)

  local start = GetGameTimer()
  RequestModel(hash)
  while not HasModelLoaded(hash) and GetGameTimer() - start < 30000 do Wait(0); end
  if not HasModelLoaded(hash) then
    ShowNotification(string.format(Labels["InvalidShell"],model))
    return false,false
  end

  local shell = CreateObject(hash, d.Entry.x + Config.SpawnOffset.x,d.Entry.y + Config.SpawnOffset.y,d.Entry.z - 30.0 + Config.SpawnOffset.z,false,false)
  FreezeEntityPosition(shell,true)

  start = GetGameTimer()
  while not DoesEntityExist(shell) and GetGameTimer() - start < 30000 do Wait(0); end
  if not DoesEntityExist(shell) then
    ShowNotification(string.format(Labels["ShellNotLoaded"],model))
    return false,false
  end

  SetEntityAsMissionEntity(shell,true,true)
  SetModelAsNoLongerNeeded(hash)

  local extras = {}
  if ShellExtras[d.Shell] then
    for objHash,data in pairs(ShellExtras[d.Shell]) do
      RequestModel(objHash)
      start = GetGameTimer()
      while not HasModelLoaded(objHash) and GetGameTimer() - start < 10000 do Wait(0); end
      if HasModelLoaded(objHash) then
        local pos = d.Entry.xyz + data.offset + Config.SpawnOffset
        local rot = data.rotation
        local obj = CreateObject(objHash, pos.x,pos.y,pos.z - 30.0, false,false)
        FreezeEntityPosition(obj,true)
        if rot then SetEntityRotation(obj,rot.x,rot.y,rot.z,2) end
        SetEntityAsMissionEntity(obj,true,true)
        SetModelAsNoLongerNeeded(objHash)
        table.insert(extras,obj)
      end
    end
  end

  -- local furni = Callback("Allhousing:GetFurniture",d.Id)
  -- local pos   = vector3(d.Entry.x,d.Entry.y,d.Entry.z)

  -- for k,v in pairs(furni) do
    -- local objHash = GetHashKey(v.model)
    -- RequestModel(objHash)
    -- start = GetGameTimer()
    -- while not HasModelLoaded(objHash) and GetGameTimer() - start < 10000 do Wait(0); end
    -- if HasModelLoaded(objHash) then
      -- local obj = CreateObject(objHash, pos.x + v.pos.x, pos.y + v.pos.y, pos.z + v.pos.z, false,false,false)
      -- FreezeEntityPosition(obj, true)
      -- SetEntityCoordsNoOffset(obj, pos.x + v.pos.x, pos.y + v.pos.y, pos.z + v.pos.z)
      -- SetEntityRotation(obj, v.rot.x, v.rot.y, v.rot.z, 2)

      -- SetModelAsNoLongerNeeded(objHash)

      -- table.insert(extras,obj)
    -- end
  -- end

  return shell,extras
end

TeleportInsideGarage = function(d,v)  
  local exitOffset = vector4(ShellOffsets[d.ShellGarage]["exit"].x - Config.SpawnOffset.x,ShellOffsets[d.ShellGarage]["exit"].y - Config.SpawnOffset.y,ShellOffsets[d.ShellGarage]["exit"].z - Config.SpawnOffset.z,ShellOffsets[d.ShellGarage]["exit"].w)
  if type(exitOffset) ~= "vector4" or exitOffset.w == nil then
    ShowNotification(string.format(Labels["BrokenOffset"],d.Id))
    return
  end

  local plyPed = GetPlayerPed(-1)
  FreezeEntityPosition(plyPed,true)

  DoScreenFadeOut(1000)
  Wait(1500)

  ClearPedTasksImmediately(plyPed)

  local shell,extras = SpawnGarage(d)
  if shell and extras then
    SetEntityCoordsNoOffset(plyPed, d.Entry.x - exitOffset.x,d.Entry.y - exitOffset.y,d.Entry.z - exitOffset.z)
    SetEntityHeading(plyPed, exitOffset.w)

    local start_time = GetGameTimer()
    while (not HasCollisionLoadedAroundEntity(plyPed) and GetGameTimer() - start_time < 5000) do Wait(0); end
    FreezeEntityPosition(plyPed,false)

    DoScreenFadeIn(500)

    InsideGarage = d
    InsideGarage.Extras    = extras
    InsideGarage.Object    = shell
    InsideGarage.Visiting  = v  
  else
    FreezeEntityPosition(plyPed,false)
    DoScreenFadeIn(500)
  end
end


EnterGarage = function(d,visiting)
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then    
    ESX.UI.Menu.CloseAll()
  end

  TriggerEvent("Allhousing:Enter",d)
  TeleportInsideGarage(d,visiting)
  SetWeatherAndTime(false)
end


MenuThread = function()
  while true do      
    if _Pool and _Pool:IsAnyMenuOpen() then
      _Pool:ControlDisablingEnabled(false)
      _Pool:MouseControlsEnabled(false)
      _Pool:ProcessMenus()
    end
    Wait(0)
  end
end

Citizen.CreateThread(MenuThread)

