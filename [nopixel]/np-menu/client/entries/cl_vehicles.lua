local VehicleEntries = MenuEntries["vehicles"]

VehicleEntries[#VehicleEntries+1] = {
    data = {
        id = "vehicle-parkvehicle",
        title = "Cất xe",
        icon = "#vehicle-parkvehicle",
        event = "caue-vehicles:storeVehicle"
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and exports["pw-garages"]:HasVehicleKey(pEntity) and exports["pw-vehicles"]:IsOnParkingSpot(pEntity, false) and not IsPedInAnyVehicle(PlayerPedId(), false)
    end
}

-- VehicleEntries[#VehicleEntries+1] = {
    -- data = {
        -- id = "247goods",
        -- title = "Pegar pertences",
        -- icon = "#obj-box",
        -- event = "caue-jobs:247delivery:takeGoods"
    -- },
    -- isEnabled = function(pEntity, pContext)
        -- return not IsDisabled() and GetEntityModel(pEntity) == `benson` and CurrentJob == "247_deliveries" and isCloseToTrunk(pEntity, PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId(), false)
    -- end
-- }

-- VehicleEntries[#VehicleEntries+1] = {
  -- data = {
      -- id = "impound-vehicle",
      -- title = "Impound Request",
      -- icon = "#vehicle-impound",
      -- event = "np-jobs:impound:openImpoundRequestMenu",
      -- parameters = {}
  -- },
  -- isEnabled = function(pEntity, pContext)
    -- return not IsDisabled() and pContext.distance <= 2.5 and not IsPedInAnyVehicle(PlayerPedId(), false)
  -- end
-- }

VehicleEntries[#VehicleEntries+1] = {
    data = {
        id = "impound-vehicle",
        title = "Impound Vehicle",
        icon = "#vehicle-impound",
        event = "np-jobs:impound:openImpoundMenu",
    },
    isEnabled = function(pEntity, pContext)
      return not IsDisabled() and pContext.distance <= 2.5 and (CurrentJob == 'impound' or CurrentJob == 'pd_impound') and IsImpoundDropOff and not IsPedInAnyVehicle(PlayerPedId(), false)
    end
  }
  
VehicleEntries[#VehicleEntries+1] = {
    data = {
        id = "impound-vehicle",
        title = "Giam xe",
        icon = "#vehicle-impound",
        event = "pw-police:impound",
        parameters = {}
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and pContext.distance <= 2.5 and not IsPedInAnyVehicle(PlayerPedId(), false) and isPolice 
    end
}  


VehicleEntries[#VehicleEntries+1] = {
    data = {
        id = "lock-unlock-car",
        title = "Khóa/Mở xe",
        icon = "#general-keys-give",
        event = "pw-garage:LockVehicle",
        parameters = {}
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and pContext.distance <= 2.5 and not IsPedInAnyVehicle(PlayerPedId(), false)
    end
} 