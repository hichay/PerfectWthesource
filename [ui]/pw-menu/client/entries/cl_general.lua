local GeneralEntries = MenuEntries["general"]

-- GeneralEntries[#GeneralEntries+1] = {
    -- data = {
        -- id = "scenes",
        -- title = "Scense",
        -- icon = "#general-scenes",
        -- event = "place-scenes"
    -- },
    -- isEnabled = function(pEntity, pContext)
        -- return true
    -- end
-- }

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "emotes:openmenu",
      title = "Emotes",
      icon = "#general-emotes",
      event = "emotes:OpenMenu"
  },
  isEnabled = function(pEntity, pContext)
      return not isDead and not IsPedInAnyVehicle(PlayerPedId(), false)
  end
}


GeneralEntries[#GeneralEntries+1] = {
    data = {
      id = "mdw",
      title = "MDT",
      icon = "#mdt",
      event = "pw-mdt:open"
    },
    isEnabled = function()
        return not IsDisabled() and not isDead and (isPolice or isDoc or isMedic) and (IsPedInAnyVehicle(PlayerPedId(), false) and (GetVehicleClass(GetVehiclePedIsIn(PlayerPedId(),false)) == 18))
    end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "vehicles",
    title = "Phương tiện",
    icon = "#vehicle-options-vehicle",
    event = "veh:options"
  },
  isEnabled = function(pEntity, pContext)
      return not IsDisabled() and IsPedInAnyVehicle(PlayerPedId(), false)
  end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "peds-escort",
        title = "Hủy áp giải",
        icon = "#general-escort",
        event = "pw-police:escort"
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and DecorGetInt(PlayerPedId(), "escorting") ~= 0
    end
}


GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "bennys:enter",
      title = "Enter Bennys",
      icon = "#general-check-vehicle",
      event = "bennys:enter"
  },
  isEnabled = function(pEntity, pContext)
      return not IsDisabled() and polyChecks.bennys.isInside and IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()
  end
}

-- GeneralEntries[#GeneralEntries+1] = {
    -- data = {
        -- id = "car-radio",
        -- title = "Radio",
        -- icon = "#car-radio",
        -- event = "pw-radiocar:openRadial"
    -- },
    -- isEnabled = function(pEntity, pContext)
        -- return not IsDisabled() and IsPedInAnyVehicle(PlayerPedId(), false) and (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() or GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), 0) == PlayerPedId())
    -- end
-- }

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "lock-unlock-carveh",
        title = "Khóa/Mở xe",
        icon = "#general-keys-give",
        event = "pw-garage:LockVehicle",
        parameters = {}
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and IsPedInAnyVehicle(PlayerPedId(), false)
    end
} 

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "vehicles-keysgive",
        title = "Đưa chìa khóa",
        icon = "#general-keys-give",
        event = "vehiclekeys:client:GiveKeys"
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and exports["pw-garages"]:HasVehicleKey(GetVehiclePedIsIn(PlayerPedId(), false))
    end
}



GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "policeDeadA",
    title = "10-13A",
    icon = "#police-dead",
    event = "police:tenThirteenA",
  },
  isEnabled = function(pEntity, pContext)
      return isDead and (isPolice or isDoc)
  end
}


GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "policeDeadB",
    title = "10-13B",
    icon = "#police-dead",
    event = "police:tenThirteenB",
  },
  isEnabled = function(pEntity, pContext)
    return isDead and (isPolice or isDoc)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "emsDeadA",
    title = "10-14A",
    icon = "#ems-dead",
    event = "police:tenForteenA",
  },
  isEnabled = function(pEntity, pContext)
    return isDead and isMedic
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "playerDead",
    title = "Gửi tín hiệu",
    icon = "#player-dead",
    event = "alert:AlertDeath",
  },
  isEnabled = function(pEntity, pContext)
    return isDead and not (isPolice or isMedic) and MedicOnline() > 0
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "npccall",
    title = "Gọi NPC",
    icon = "#player-dead",
    event = "pw-death:medicNPC",
  },
  isEnabled = function(pEntity, pContext)
    return isDead and not (isPolice or isMedic) and MedicOnline() == 0
  end
}


GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "unseat",
    title = "Đứng dậy",
    icon = "#obj-chair",
    event = "pw-emotes:sitOnChair"
  },
  isEnabled = function(pEntity, pContext)
    return not isDead and exports["pw-flags"]:HasPedFlag(PlayerPedId(), "isSittingOnChair")
  end
}



GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "dispatch:openDispatch",
      title = "Dispatch Noti",
      icon = "#general-check-over-target",
      event = "pw-dispatch:ManageNotifycation"
  },
  isEnabled = function()
      return not isDead and (isPolice or isMedic) 
  end
}

local hasDrugs = function()
    return exports["pw-inventory"]:hasEnoughOfItem("joint", 1, false) or
        exports["pw-inventory"]:hasEnoughOfItem("1gcocaine", 1, false) or
        exports["pw-inventory"]:hasEnoughOfItem("1gmeta", 1, false) or
        exports["pw-inventory"]:hasEnoughOfItem("lean", 1, false) or exports["pw-inventory"]:hasEnoughOfItem("joint2", 1, false)
end
GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "drugs-selling",
        title = "Chào hàng quanh",
        icon = "#weed-cultivation",
        event = "pw-drugs:startSell"
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and hasDrugs() and not exports["pw-localselldrugs"]:isSelling() and not (isPolice or isDoc)
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "drugs-selling",
        title = "Ngưng chào hàng",
        icon = "#weed-cultivation",
        event = "pw-drugs:startSell"
    },
    isEnabled = function(pEntity, pContext)
        return exports["pw-localselldrugs"]:isSelling()
    end
}



GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "poledance:toggle",
        title = "Poledance",
        icon = "#poledance-toggle",
        event = "poledance:toggle"
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and polyChecks.vanillaUnicorn.isInside and not exports["pw-flags"]:HasPedFlag(PlayerPedId(), "isPoledancing")
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "poledance:toggle",
        title = "Parar poledancing",
        icon = "#poledance-toggle",
        event = "poledance:toggle"
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and polyChecks.vanillaUnicorn.isInside and exports["pw-flags"]:HasPedFlag(PlayerPedId(), "isPoledancing")
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "oxygentank",
        title = "Remover Tanque de O2",
        icon = "#oxygen-mask",
        event = "RemoveOxyTank"
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and hasOxygenTankOn
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "vehicle-vehicleList",
        title = "Mở Garage",
        icon = "#vehicle-vehicleList",
        event = "pw-vehicles:garage",
        parameters = { nearby = true, radius = 4.0 }
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and not IsPedInAnyVehicle(PlayerPedId()) and (pEntity and pContext.flags["isVehicleSpawner"] or not pEntity and exports["pw-vehicles"]:IsOnParkingSpot(PlayerPedId(), true, 4.0))
    end
}


AddEventHandler("place-scenes", function()
    ExecuteCommand("+startScene")
end)

-- GeneralEntries[#GeneralEntries+1] = {
    -- data = {
        -- id = "check_jail",
        -- title = "Jail Time",
        -- icon = "#general-keys-give",
        -- event = "checkjailtime"
    -- },
    -- isEnabled = function(pEntity, pContext)
        -- return not IsDisabled() and exports["pw-base"]:getChar("jail") > 0
    -- end
-- }

-- AddEventHandler("checkjailtime", function()
    -- TriggerEvent("chatMessage", "DOC: " , { 33, 118, 255 }, "Você tem " .. exports["pw-base"]:getChar("jail") .. " meses restantes")
-- end)





local currentJob = nil
local policeModels = {
    [`npolvic`] = true,
    [`npolexp`] = true,
    [`npolstang`] = true,
    [`npolchar`] = true,
    [`npolchal`] = true,
    [`npolvette`] = true,
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "open-rifle-rack",
        title = "Kho xe",
        icon = "#vehicle-plate-remove",
        event = "vehicle:openRifleRack"
    },
    isEnabled = function(pEntity)
        if not ESX.GetPlayerData().job.name == 'police' then return false end
        local veh = GetVehiclePedIsIn(PlayerPedId())
        if veh == 0 then return false end
        local model = GetEntityModel(veh)
        if policeModels[model] == nil then return false end
        return true
    end
}

AddEventHandler("vehicle:openRifleRack", function()
    local finished = exports["pw-taskbar"]:taskBar(2500, "Mở kho")
    if finished ~= 100 then return end
    local veh = GetVehiclePedIsIn(PlayerPedId())
    if veh == 0 then return end
    local veh = GetVehiclePedIsIn(PlayerPedId())
    local plate = GetVehicleNumberPlateText(veh)
    TriggerEvent("server-inventory-open", "1", "rifle-rack-" .. plate)
end)

