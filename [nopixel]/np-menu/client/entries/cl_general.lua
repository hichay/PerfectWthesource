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
      return not isDead
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
    title = "Stop escorting",
    icon = "#general-escort",
    event = "pw-police:unescort"
  },
  isEnabled = function(pEntity, pContext)
      return not IsDisabled() and isEscorting
  end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "car-radio",
        title = "Radio",
        icon = "#car-radio",
        event = "caue-radiocar:openRadial"
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and IsPedInAnyVehicle(PlayerPedId(), false) and (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() or GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), 0) == PlayerPedId())
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
        return not IsDisabled() and IsPedInAnyVehicle(PlayerPedId(), false) and exports["pw-garages"]:HasVehicleKey(GetVehiclePedIsIn(PlayerPedId(), false))
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
    id = "unseat",
    title = "Get up",
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
      title = "Dispatch",
      icon = "#general-check-over-target",
      event = "cd_dispatch:toggleDispatch"
  },
  isEnabled = function()
      return not isDead and (isPolice or isMedic) 
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
        id = "policeDeadA",
        title = "10-13A",
        icon = "#police-dead",
        event = "police:tenThirteenA",
    },
    isEnabled = function(pEntity, pContext)
        return exports["esx_ambulancejob"]:GetPlayerDead() and ESX.GetPlayerData().job.name == 'police' or CurrentJob == "doc"
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
        return exports["esx_ambulancejob"]:GetPlayerDead() and ESX.GetPlayerData().job.name == 'police' or CurrentJob == "doc"
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
        return exports["esx_ambulancejob"]:GetPlayerDead() and ESX.GetPlayerData().job.name == 'ambulance'
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "emsDeadB",
        title = "10-14B",
        icon = "#ems-dead",
        event = "police:tenForteenB",
    },
    isEnabled = function(pEntity, pContext)
        return exports["esx_ambulancejob"]:GetPlayerDead() and ESX.GetPlayerData().job.name == 'ambulance'
    end
}



GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "vehicle-vehicleList",
        title = "Mở Garage",
        icon = "#vehicle-vehicleList",
        event = "caue-vehicles:garage",
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
        -- return not IsDisabled() and exports["caue-base"]:getChar("jail") > 0
    -- end
-- }

-- AddEventHandler("checkjailtime", function()
    -- TriggerEvent("chatMessage", "DOC: " , { 33, 118, 255 }, "Você tem " .. exports["caue-base"]:getChar("jail") .. " meses restantes")
-- end)





AddEventHandler("caue-radiocar:openRadial", function()
    ExecuteCommand("radiocar")
end)


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
        title = "Mở tủ chứa vũ khí",
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
    local finished = exports["np-taskbar"]:taskBar(2500, "Mở kho")
    if finished ~= 100 then return end
    local veh = GetVehiclePedIsIn(PlayerPedId())
    if veh == 0 then return end
    local veh = GetVehiclePedIsIn(PlayerPedId())
    local plate = GetVehicleNumberPlateText(veh)
    TriggerEvent("server-inventory-open", "1", "rifle-rack-" .. plate)
end)

