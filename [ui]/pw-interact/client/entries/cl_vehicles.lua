local Entries = {}

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "vehicle_flip",
            label = "Lật lại xe",
            icon = "car-crash",
            event = "FlipVehicle",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 },
        isEnabled = function(pEntity, pContext)
            return not IsDisabled() and not IsVehicleOnAllWheels(pEntity)
        end
    }
}

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "carry_bike",
            label = "Carry Bike",
            icon = "spinner",
            event = "carryEntity",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 },
        isEnabled = function(pEntity, pContext)
            return IsThisModelABicycle(pContext.model) and not IsEntityAttachedToAnyPed(pEntity) and not IsEntityAttachedToAnyPed(PlayerPedId())
        end
    }
}

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "vehicle_getintrunk",
            label = "Chui cốp",
            icon = "user-secret",
            event = "vehicle:getInTrunk",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 4.0 },
        isEnabled = function(pEntity, pContext)
            local lockStatus = GetVehicleDoorLockStatus(pEntity)
            return not IsDisabled() and DoesVehicleHaveDoor(pEntity, 5) and isCloseToBoot(pEntity, PlayerPedId(), 2.0, pContext.model) and (lockStatus == 1 or lockStatus == 0 or lockStatus == 4) and not isEscorting
        end
    }
}

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "vehicle_putintrunk",
            label = "Put in trunk",
            icon = "user-secret",
            event = "pw-police:vehicle:forceTrunkCheck",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 4.0 },
        isEnabled = function(pEntity, pContext)
            local lockStatus = GetVehicleDoorLockStatus(pEntity)
            return DoesVehicleHaveDoor(pEntity, 5) and isCloseToBoot(pEntity, PlayerPedId(), 2.0, pContext.model) and (lockStatus == 1 or lockStatus == 0 or lockStatus == 4) and isEscorting
        end
    }
}

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "vehicle_runplate",
            label =  "Run Plate",
            icon = "money-check",
            event = "clientcheckLicensePlate",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 7.0 },
        isEnabled = function(pEntity, pContext)
            return isPolice and (isCloseToHood(pEntity, PlayerPedId(), 2.0) or isCloseToBoot(pEntity, PlayerPedId(), 2.0, pContext.model)) and not IsPedInAnyVehicle(PlayerPedId(), false)
        end
    }
}

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "vehicle_inspectvin",
            label = "Check VIN",
            icon = "sim-card",
            event = "vehicle:checkVIN",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 },
        isEnabled = function(pEntity, pContext)
            return isCloseToHood(pEntity, PlayerPedId(), 2.0) and (isPolice or isMedic) and not IsPedInAnyVehicle(PlayerPedId(), false)
        end
    }
}

-- Entries[#Entries + 1] = {
    -- type = 'entity',
    -- group = { 2 },
    -- data = {
        -- {
            -- id = "vehicle_add_fakeplate",
            -- label = "Add Fakeplate",
            -- icon = "screwdriver",
            -- event = "vehicle:addFakePlate",
            -- parameters = {}
        -- }
    -- },
    -- options = {
        -- distance = { radius = 3.0 },
        -- isEnabled = function(pEntity, pContext)
            -- return (isCloseToHood(pEntity, PlayerPedId(), 2.0) or isCloseToBoot(pEntity, PlayerPedId(), 2.0, pContext.model)) and not IsPedInAnyVehicle(PlayerPedId(), false)
            -- and hasKeys(pEntity) and exports["pw-inventory"]:hasEnoughOfItem("fakeplate", 1, false, true)
            -- and not exports["pw-vehicles"]:GetVehicleMetadata(pEntity, 'fakePlate')
        -- end
    -- }
-- }



Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "inventory_open_hidden",
            label = "Open Compartment",
            icon = "screwdriver",
            event = "inventory:open_hidden",
            parameters = {
            }
        }
    },
    options = {
        distance = { radius = 3.0 },
        isEnabled = function(pEntity, pContext)
            return (not IsPedInAnyVehicle(PlayerPedId(), false) and GetBoneDistance(pEntity, 2, 'wheel_rf') <= 1.7 and pContext.model == GetHashKey("mule") and exports["pw-inventory"]:hasEnoughOfItem("homemadekey", 1, false)  )
        end
    }
}

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "inventory_hidden_scratches",
            label = "Loose Bolt",
            icon = "screwdriver",
            event = "inventory:open_hidden_fail",
            parameters = {
            }
        }
    },
    options = {
        distance = { radius = 3.0 },
        isEnabled = function(pEntity, pContext)
            return (not IsPedInAnyVehicle(PlayerPedId(), false) and GetBoneDistance(pEntity, 2, 'wheel_rf') <= 1.7 and pContext.model == GetHashKey("mule") and not exports["pw-inventory"]:hasEnoughOfItem("homemadekey", 1, false)  )
        end
    }
}

-- Entries[#Entries + 1] = {
    -- type = 'entity',
    -- group = { 2 },
    -- data = {
        -- {
            -- id = "vehicle_remove_fakeplate",
            -- label = "Remove Fakeplate",
            -- icon = "ban",
            -- event = "vehicle:removeFakePlate",
            -- parameters = {}
        -- }
    -- },
    -- options = {
        -- distance = { radius = 3.0 },
        -- isEnabled = function(pEntity, pContext)
            -- return (isCloseToBoot(pEntity, PlayerPedId(), 1.8, pContext.model) or pContext.model == `esv`) and not IsPedInAnyVehicle(PlayerPedId(), false)
            -- and hasKeys(pEntity) and exports["pw-vehicles"]:GetVehicleMetadata(pEntity, 'fakePlate')
        -- end
    -- }
-- }

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "vehicle_examine",
            label = "Kiểm tra tình trạng",
            icon = "wrench",
            event = "pw-mechanicjob:Check",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0, boneId = "engine" },
        isEnabled = function(pEntity, pContext)
            return isCloseToEngine(pEntity, PlayerPedId(), 3.0, pContext.model) and not bypassedNetVehicles[VehToNet(pEntity)]
        end
    }
}

					

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "vehicle_refuel_station",
            label = "Đổ xăng",
            icon = "gas-pump",
            event = "pw-vehicles:refuel",
            parameters = {}
        }
    },
    options = {
        isEnabled = function(pEntity, pContext)
            return not IsDisabled() and polyChecks.gasStation.isInside and canRefuelHere(pEntity, polyChecks.gasStation.polyData) and not bypassedNetVehicles[VehToNet(pEntity)]
        end
    }
}

Entries[#Entries + 1] = {
  type = 'entity',
  group = { 2 },
  data = {
      {
          id = "vehicle_refuel_station_plane",
          label = "Đổ xăng",
          icon = "gas-pump",
          event = "pw-vehicles:refuel",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 2.0 },
      isEnabled = function(pEntity, pContext)
          local vehicleClass = GetVehicleClass(pEntity)
          if vehicleClass ~= 16 then return false end
          return polyChecks.gasStation.isInside
      end
  }
}

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "vehicle_refuel_station_boat",
            label = "Đổ xăng",
            icon = "gas-pump",
            event = "pw-vehicles:refuel",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 5.0 },
        isEnabled = function(pEntity, pContext)
            local vehicleClass = GetVehicleClass(pEntity)
            if vehicleClass ~= 14 then return false end
            return polyChecks.gasStation.isInside
        end
    }
}

Entries[#Entries + 1] = {
  type = 'entity',
  group = { 2 },
  data = {
      {
          id = "vehicle_refuel_station_chopter",
          label = "Đổ xăng",
          icon = "gas-pump",
          event = "pw-vehicles:refuel",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 5.0 },
      isEnabled = function(pEntity, pContext)
          local vehicleClass = GetVehicleClass(pEntity)
          if vehicleClass ~= 15 then return false end
          return polyChecks.gasStation.isInside
      end
  }
}

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "vehicle_refuel_jerrycan",
            label = "Đổ xăng từ bình",
            icon = "gas-pump",
            event = "pw-vehicles:refuelVehicle",
            parameters = {isJerryCan = true}
        }
    },
    options = {
        distance = { radius = 1.2, boneId = 'wheel_lr' },
        isEnabled = function(pEntity, pContext)
            return HasWeaponEquipped(883325847) -- WEAPON_PetrolCan
        end
    }
}

-- Entries[#Entries + 1] = {
    -- type = 'entity',
    -- group = { 2 },
    -- data = {
        -- {
            -- id = "vehicle_putinvehicle",
            -- label = "seat in vehicle",
            -- icon = "chevron-circle-left",
            -- event = "pw-police:vehicle:seat",
            -- parameters = {}
        -- },
        -- {
            -- id = "vehicle_unseatnearest",
            -- label = "unseat from vehicle",
            -- icon = "chevron-circle-right",
            -- event = "pw-police:vehicle:unseat",
            -- parameters = {}
        -- }
    -- },
    -- options = {
        -- distance = { radius = 4.0 },
        -- isEnabled = function(pEntity, pContext)
            -- return (not (isCloseToHood(pEntity, PlayerPedId()) or isCloseToBoot(pEntity, PlayerPedId(), 2.0, pContext.model))
              -- or pContext.model == GetHashKey("emsnspeedo"))
              -- and not IsPedInAnyVehicle(PlayerPedId(), false)
              -- and NetworkGetEntityIsNetworked(pEntity)
              -- and not bypassedNetVehicles[VehToNet(pEntity)]
        -- end
    -- }
-- }

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "vehicle_keysgive",
            label = "Đưa chìa khóa xe",
            icon = "key",
            event = "vehiclekeys:client:GiveKeys",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.8 },
        isEnabled = function(pEntity, pContext)
            return not IsDisabled() and hasKeys(pEntity) and not bypassedNetVehicles[VehToNet(pEntity)]
        end
    }
}

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "vehicle_vinscratch",
            label = "scratch vin",
            icon = "eye-slash",
            event = "pw-boosting:scratchVehicleVin",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 4 },
        isEnabled = function(pEntity, pContext)
            return pContext.meta ~= nil and pContext.meta.boostingInfo ~= nil and pContext.meta.boostingInfo.vinScratch
        end
    }
}

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "vehicle_methdisturbdrop",
            label = "Intercept goods",
            icon = "eye-slash",
            event = "pw-meth:dropoff:cancelDropOff",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 4 },
        isEnabled = function(pEntity, pContext)
            return isCloseToTrunk(pEntity, PlayerPedId(), 1.1, false) and pContext.meta ~= nil and pContext.meta.dropoffInfo and pContext.meta.dropoffInfo.uuid and isPolice
        end
    }
}

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "vehicle_methdrop",
            label = "Drop off goods",
            icon = "cubes",
            event = "pw-meth:dropoff:doDropoff",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 4 },
        isEnabled = function(pEntity, pContext)
            return isCloseToTrunk(pEntity, PlayerPedId(), 1.1, false) and pContext.meta ~= nil and pContext.meta.dropoffInfo and pContext.meta.dropoffInfo.uuid
        end
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isWheelchair' },
    data = {
        {
            id = "wheelchair",
            label = "Xe lăn",
            icon = "wheelchair",
            event = "pw:vehicle:wheelchair:control",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.9, boneId = 'misc_a' }
    }
}


-- Entries[#Entries + 1] = {
    -- type = 'flag',
    -- group = { 'isTowTruck' },
    -- data = {
        -- {
            -- id = "towtruck_tow",
            -- label = "tow vehicle",
            -- icon = "trailer",
            -- event = "jobs:towVehicle",
            -- parameters = {}
        -- }
    -- },
    -- options = {
        -- job = { 'impound', 'pd_impound' },
        -- distance = { radius = 2.5, boneId = 'wheel_lr' },
        -- isEnabled = function (pEntity, pContext)
            -- return not pContext.flags['isTowingVehicle']
        -- end
    -- }
-- }

-- Entries[#Entries + 1] = {
    -- type = 'flag',
    -- group = { 'isTowTruck' },
    -- data = {
        -- {
            -- id = "towtruck_untow",
            -- label = "untow vehicle",
            -- icon = "trailer",
            -- event = "jobs:untowVehicle",
            -- parameters = {}
        -- }
    -- },
    -- options = {
        -- job = { 'impound', 'pd_impound' },
        -- distance = { radius = 2.5, boneId = 'wheel_lr' },
        -- isEnabled = function (pEntity, pContext)
            -- return pContext.flags['isTowingVehicle']
        -- end
    -- }
-- }

Entries[#Entries + 1] = {
    type = 'model',
    group = { GetHashKey('trash2') },
    data = {
        {
            id = "sanitation_worker_throw_trash",
            label = "throw in trash",
            icon = "trash-restore-alt",
            event = "pw-jobs:sanitationWorker:vehicleTrash",
            parameters = {}
        }
    },
    options = {
        job = { 'sanitation_worker' },
        distance = { radius = 3.8, boneId = 'wheel_lr' },
        isEnabled = function (pEntity, pContext)
            return isCloseToTrunk(pEntity, PlayerPedId(), 1.1, true)
        end
    }
}

-- Entries[#Entries + 1] = {
    -- type = 'model',
    -- group = { GetHashKey('boxville7'), GetHashKey('pounder') },
    -- data = {
        -- {
            -- id = "dodo_deliveries_take_goods",
            -- label = "Grab goods",
            -- icon = "box",
            -- event = "pw-jobs:dodo:takeGoods",
            -- parameters = {}
        -- }
    -- },
    -- options = {
        -- job = { 'dodo_deliveries' },
        -- distance = { radius = 5.0, boneId = 'wheel_lr' },
        -- isEnabled = function (pEntity, pContext)
            -- return isCloseToTrunk(pEntity, PlayerPedId())
        -- end
    -- }
-- }

-- Entries[#Entries + 1] = {
  -- type = 'entity',
  -- group = { 2 },
  -- data = {
      -- {
          -- id = "vehicle_buy_vehicle",
          -- label = "sell vehicle",
          -- icon = "money-check-alt",
          -- NPXEvent = "pw-ottosauto:vehicle:transaction",
          -- parameters = {
            -- action = "sell"
          -- }
      -- }
  -- },
  -- options = {
      -- distance = { radius = 1.8 },
      -- isEnabled = function(pEntity, pContext)
          -- return polyChecks.ottosAuto.isInside and hasJobPermission("ottos_auto") and CanSellOrBuyCar(pEntity, true)
      -- end
  -- }
-- }

-- Entries[#Entries + 1] = {
  -- type = 'entity',
  -- group = { 2 },
  -- data = {
      -- {
          -- id = "vehicle_sell_vehicle",
          -- label = "buy vehicle",
          -- icon = "shopping-cart",
          -- NPXEvent = "pw-ottosauto:vehicle:transaction",
          -- parameters = {
            -- action = "buy"
          -- }
      -- }
  -- },
  -- options = {
      -- distance = { radius = 1.8 },
      -- isEnabled = function(pEntity, pContext)
          -- return polyChecks.ottosAuto.isInside and hasJobPermission("ottos_auto", "buy_car") and CanSellOrBuyCar(pEntity, false)
      -- end
  -- }
-- }

-- Entries[#Entries + 1] = {
    -- type = 'entity',
    -- group = { 2 },
    -- data = {
        -- {
            -- id = "vehicle_tamperedwith",
            -- label = "check for tampering signs",
            -- icon = "unlink",
            -- event = "pw-vehicles:checkTampering",
            -- parameters = {}
        -- }
    -- },
    -- options = {
        -- distance = { radius = 1.8 },
        -- job = { 'police' },
        -- isEnabled = function(pEntity, pContext)
            -- return isCloseToDriverDoor(pEntity, PlayerPedId(), 1.5)
        -- end
    -- }
-- }

-- Entries[#Entries + 1] = {
    -- type = 'model',
    -- group = { GetHashKey('bcat') },
    -- data = {
        -- {
            -- id = "rhino-open-armory",
            -- label = "open armory",
            -- icon = "shopping-cart",
            -- event = "pw-police:client:openRhinoArmoy",
            -- parameters = {}
        -- }
    -- },
    -- options = {
        -- distance = { radius = 7.0 },
        -- isEnabled = function (pEntity, pContext)
            -- return isPolice and (isCloseToHood(pEntity, PlayerPedId(), 2.0) or isCloseToBoot(pEntity, PlayerPedId(), 2.0, pContext.model)) and not IsPedInAnyVehicle(PlayerPedId(), false)
        -- end
    -- }
-- }

-- Entries[#Entries + 1] = {
    -- type = 'entity',
    -- group = { 2 },
    -- data = {
        -- {
            -- id = "vehicle_defusebomb",
            -- label = "Defuse Car Bomb",
            -- icon = "cut",
            -- event = "pw-miscscripts:carBombs:removeBomb",
            -- parameters = {}
        -- },
    -- },
    -- options = {
        -- distance = { radius = 1.8 },
        -- isEnabled = function(pEntity, pContext)
            -- return
            -- pContext.meta ~= nil and
            -- pContext.meta.carBombData ~= nil and
            -- pContext.meta.carBombData.found
        -- end
    -- }
-- }

-- Entries[#Entries + 1] = {
    -- type = 'entity',
    -- group = { 2 },
    -- data = {
        -- {
            -- id = "vehicle_pickup_rc",
            -- label = "pickup",
            -- icon = "people-carry",
            -- event = "pw-rcvehicles:pickupCar",
            -- parameters = {}
        -- }
    -- },
    -- options = {
        -- distance = { radius = 1.8 },
        -- isEnabled = function(pEntity, pContext)
            -- return pContext.model == `rcbandito` and #GetEntityVelocity(pEntity) < 0.2 and bypassedNetVehicles[VehToNet(pEntity)]
        -- end
    -- }
-- }

-- custom car clothing
local inClothingShop = false
AddEventHandler("pw-polyzone:enter", function(pName)
  if pName ~= "custom_car_clothing" then return end
  inClothingShop = true
end)
AddEventHandler("pw-polyzone:exit", function(pName)
  if pName ~= "custom_car_clothing" then return end
  inClothingShop = false
end)
Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "vehicle_clothing_save",
            label = "Save Current Outfit",
            icon = "plus",
            event = "pw-car-clothing:saveCurrentOutfit",
            parameters = {},
        },
        {
            id = "vehicle_clothing_swap",
            label = "Swap Current Outfit",
            icon = "redo",
            event = "pw-car-clothing:swapCurrentOutfit",
            parameters = {},
        },
    },
    options = {
        distance = { radius = 2.5 },
        isEnabled = function(pEntity, pContext)
            return inClothingShop
        end
    }
}






-- local stockadeHash = `STOCKADE`
-- Entries[#Entries + 1] = {
--   type = 'entity',
--   group = { 2 },
--   data = {
--       {
--           id = "moneytruckthermite",
--           label = "Use Thermite",
--           icon = "circle",
--           event = "pw-heists:bobcatThermiteMoneyTruckDoor",
--           parameters = {}
--       }
--   },
--   options = {
--       distance = { radius = 8.0 },
--       isEnabled = function(pEntity, pContext)
--           return pContext.model == stockadeHash
--             and isCloseToBoot(pEntity, PlayerPedId(), 2.0, pContext.model)
--             and not DecorGetBool(pEntity, "BobcatMoneyTruck")
--             and exports["pw-inventory"]:hasEnoughOfItem("thermitecharge", 1, false, true)
--       end
--   }
-- }

-- Entries[#Entries + 1] = {
--   type = 'entity',
--   group = { 2 },
--   data = {
--       {
--           id = "moneytruckloot",
--           label = "Take Goods",
--           icon = "circle",
--           event = "pw-heists:bobcatMoneyTruckTakeGoods",
--           parameters = {}
--       }
--   },
--   options = {
--       distance = { radius = 8.0 },
--       isEnabled = function(pEntity, pContext)
--           return pContext.model == stockadeHash
--             and isCloseToBoot(pEntity, PlayerPedId(), 2.0, pContext.model)
--             and DecorGetBool(pEntity, "BobcatMoneyTruck")
--       end
--   }
-- }

Citizen.CreateThread(function()
    for _, entry in ipairs(Entries) do
        if entry.type == 'flag' then
            AddPeekEntryByFlag(entry.group, entry.data, entry.options)
        elseif entry.type == 'model' then
            AddPeekEntryByModel(entry.group, entry.data, entry.options)
        elseif entry.type == 'entity' then
            AddPeekEntryByEntityType(entry.group, entry.data, entry.options)
        elseif entry.type == 'polytarget' then
            AddPeekEntryByPolyTarget(entry.group, entry.data, entry.options)
        end
    end
end)
