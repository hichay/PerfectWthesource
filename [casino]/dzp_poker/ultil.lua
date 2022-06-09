local isPlacing = false
local object = nil
local objectCoords = nil
local chairsSpawned = false
local Chairs = {}
local tablespawned
local isOwner = false
function placeObject(pObject, cb)
  local objectHash, playerPed = GetHashKey(pObject), PlayerPedId()
  local minV, maxV = GetModelDimensions(objectHash)
  
  local objectHeading = GetEntityHeading(playerPed)
  local objectCoords = centerCoords

  object = CreateObject(objectHash, centerCoords, 1, 0, 0)
  SetEntityCollision(object, false)
  LoadEntityModel(objectHash)

  local placed = false
  local isInvisible = false
  local canPlace = false

  isPlacing = true

  CreateThread(function()
    while isPlacing do
      local centerCoords = GetEntityCoords(playerPed) + (GetEntityForwardVector(playerPed) * 1.5)

      DisablePlayerFiring(PlayerPedId(), true)
      DisableControlAction(0, 24, true) -- Attack
      DisableControlAction(0, 142, true) -- MeleeAttackAlternate
      DisableControlAction(1, 38, true) --Key: E
      DisableControlAction(0, 44, true) --Key: Q

      if IsDisabledControlJustPressed(0, 177) then -- Escape
        stopPlacing()
      end

      if IsDisabledControlJustPressed(0, 174) then -- Right arrow key
          objectHeading = objectHeading + 5
          if objectHeading > 360 then objectHeading = 0.0 end
      end

      if IsDisabledControlJustPressed(0, 175) then
          objectHeading = objectHeading - 5 -- Left arrow key
          if objectHeading < 0 then objectHeading = 360.0 end
      end

      SetEntityCoords(object, centerCoords.x, centerCoords.y, centerCoords.z, 0.0, 0.0, 0.0, false)
      PlaceObjectOnGroundProperly_2(object)
      SetEntityHeading(object, objectHeading)

      local rayHandle = StartShapeTestBox(
        centerCoords,
        maxV - minV,
        GetEntityRotation(playerPed, 2),
        2,
        339,
        playerPed,
        4
      )
      local retval, hit, endCoords, _, materialHash, _ = GetShapeTestResultIncludingMaterial(rayHandle)
      if hit == 1 then
        canPlace = false
        if not isInvisible then
          SetObjectVisibilityState(object, true, function(pState)
            isInvisible = pState
          end)
        end
      else
        local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(centerCoords.x, centerCoords.y, centerCoords.z, centerCoords.x, centerCoords.y, centerCoords.z - 2, 1, 0, 4)
        local retval, hit, endCoords, _, materialHash, _ = GetShapeTestResultIncludingMaterial(rayHandle)
        canPlace = true
        --[[ local properMaterial = MaterialHashes[tostring(materialHash)]
        canPlace = properMaterial
        if properMaterial and isInvisible then
          SetObjectVisibilityState(object, false, function(pState)
            isInvisible = pState
          end)
        elseif not properMaterial and not isInvisible then
          SetObjectVisibilityState(object, true, function(pState)
            isInvisible = pState
          end)
        end ]]
        SetObjectVisibilityState(object, false, function(pState)
            isInvisible = pState
          end)
      end

      if canPlace and IsControlJustPressed(0, 191) then -- Enter
        objectCoords = GetEntityCoords(object)
        objectHeading = GetEntityHeading(object)
        isPlacing = false
        placed = true
        if true then
          DeleteObject(object)
          Wait(500)
            local objectx,objecty,objectz = table.unpack(objectCoords)
            TriggerEvent("dzp_poker:updateState",true)
            ESX.Game.SpawnObject(Config.TableHash, vector3(objectx,objecty,objectz-0.35), function(table)
                tablespawned = table
                FreezeEntityPosition(table, true)
                SetEntityAsMissionEntity(table, true, false)
                SetEntityCollision(table, true, true)
            end, true)
            
           for i = 1, #Config.ChairsData do
            local coords = nil
            if Config.SetChairsByOffset then
                local x = objectx.x + Config.ChairsData[i].xOffset
                local y = objecty + Config.ChairsData[i].yOffset
                coords = vector3(x, y, objectz-0.35)
            else
                coords = vector3(Config.ChairsData[i].x, Config.ChairsData[i].y, Config.ChairsData[i].z)
            end
            ESX.Game.SpawnObject(Config.ChairHash, coords, function(chair)
                Chairs[i] = chair
                FreezeEntityPosition(chair, true)
                SetEntityAsMissionEntity(chair, true, false)
                SetEntityCollision(chair, true, true)
                SetEntityHeading(chair, Config.ChairsData[i].h)
    
                -- print(GetEntityHeading(chair))
            end, true)
        end
        chairsSpawned = true
        end
      end
      Wait(0)
    end
    cb(placed, objectCoords, objectHeading)
  end)
end

function stopPlacing()
  if object then
    DeleteObject(object)
  end
  isPlacing = false
  placed = false
end

function LoadEntityModel(pModelHash)
  RequestModel(pModelHash)
  while not HasModelLoaded(pModelHash) do
      Wait(0)
  end
end

function SetObjectVisibilityState(pObject, pState, cb)
  if pState then
    SetEntityAlpha(pObject, 0, true)
  else
    ResetEntityAlpha(pObject)
  end
  cb(pState)
end

AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  if object then
    DeleteObject(object)
    DeleteObject(tablespawned)
    DeleteObject(Chairs[1])
    DeleteObject(Chairs[2])
    DeleteObject(Chairs[3])
    DeleteObject(Chairs[4])
    DeleteObject(Chairs[5])
    DeleteObject(Chairs[6])
  end
  TriggerEvent("dzp_poker:updateState",false)
end)

RegisterNetEvent('dzp_poker:takeTableBack')
AddEventHandler('dzp_poker:takeTableBack', function()
    if object then
        DeleteObject(object)
        DeleteObject(tablespawned)
        DeleteObject(Chairs[1])
        DeleteObject(Chairs[2])
        DeleteObject(Chairs[3])
        DeleteObject(Chairs[4])
        DeleteObject(Chairs[5])
        DeleteObject(Chairs[6])
      end
    TriggerEvent("player:receiveItem","ace",1) 
    TriggerEvent("dzp_poker:updateState",false)
end)






-- Adds player to poker table
-- slot         -   slot at which player is seated.
RegisterNetEvent('dzp_poker:rotateChairs')
AddEventHandler('dzp_poker:rotateChairs', function()
    local temp = Chairs[1]
    table.remove(Chairs, 1)
    table.insert(Chairs, 6, temp)
    -- print(json.encode(Chairs))
end)

RegisterNetEvent('dzp_poker:addToPoker')
AddEventHandler('dzp_poker:addToPoker', function(slot, timesRotated)
    if timesRotated > 0 then
        for i = 1, timesRotated do
            local temp = Chairs[1]
            table.remove(Chairs, 1)
            table.insert(Chairs, 6, temp)
        end
    end
    if slot then
        SetNuiFocus(true, true)
        --sit(Chairs[slot])
        joinGame()
    else
        ShowNotificationMsg(Config.Strings[Config.Language]['no_space'])
    end
end)

-- Leaves poker table
RegisterNetEvent('dzp_poker:leavePoker')
AddEventHandler('dzp_poker:leavePoker', function()
    --leaveSit()
    leaveGame()
    hideCards()
    ShowNotificationMsg(Config.Strings[Config.Language]['leave_table'])
end)