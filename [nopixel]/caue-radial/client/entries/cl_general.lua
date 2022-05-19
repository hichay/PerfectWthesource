local GeneralEntries = MenuEntries["general"]

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "scenes",
        title = "Cenas",
        icon = "#general-scenes",
        event = "place-scenes"
    },
    isEnabled = function(pEntity, pContext)
        return true
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
        -- return not isDisabled() and exports["caue-base"]:getChar("jail") > 0
    -- end
-- }

-- AddEventHandler("checkjailtime", function()
    -- TriggerEvent("chatMessage", "DOC: " , { 33, 118, 255 }, "Você tem " .. exports["caue-base"]:getChar("jail") .. " meses restantes")
-- end)

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "vehicles",
        title = "Vehicle",
        icon = "#vehicle-options-vehicle",
        event = "veh:options"
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and IsPedInAnyVehicle(PlayerPedId(), false)
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
        return not isDisabled() and IsPedInAnyVehicle(PlayerPedId(), false) and (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() or GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), 0) == PlayerPedId())
    end
}

AddEventHandler("caue-radiocar:openRadial", function()
    ExecuteCommand("radiocar")
end)

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "vehicles-keysgive",
        title = "Dar chaves",
        icon = "#general-keys-give",
        event = "vehicle:giveKey"
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and IsPedInAnyVehicle(PlayerPedId(), false) and exports["caue-vehicles"]:HasVehicleKey(GetVehiclePedIsIn(PlayerPedId(), false))
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "peds-escort",
        title = "Parar escolta",
        icon = "#general-escort",
        event = "caue-police:escort"
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and DecorGetInt(PlayerPedId(), "escorting") ~= 0
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
        return not isDisabled() and polyChecks.vanillaUnicorn.isInside and not exports["pw-flags"]:HasPedFlag(PlayerPedId(), "isPoledancing")
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
        return not isDisabled() and polyChecks.vanillaUnicorn.isInside and exports["pw-flags"]:HasPedFlag(PlayerPedId(), "isPoledancing")
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
        return not isDisabled() and hasOxygenTankOn
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
        id = "unseat",
        title = "Levantar",
        icon = "#obj-chair",
        event = "caue-emotes:sitOnChair"
    },
    isEnabled = function(pEntity, pContext)
        return not exports["esx_ambulancejob"]:GetPlayerDead() and exports["pw-flags"]:HasPedFlag(PlayerPedId(), "isSittingOnChair")
    end
}

-- GeneralEntries[#GeneralEntries+1] = {
    -- data = {
        -- id = "property-rent",
        -- title = "Alugar propriedade",
        -- icon = "#real-estate-sell",
        -- event = "caue-housing:rent"
    -- },
    -- isEnabled = function(pEntity, pContext)
        -- return not exports["esx_ambulancejob"]:GetPlayerDead() and exports["caue-housing"]:canRent()
    -- end
-- }

-- GeneralEntries[#GeneralEntries+1] = {
    -- data = {
        -- id = "property-enter",
        -- title = "Entrar propriedade",
        -- icon = "#property-enter",
        -- event = "housing:interactionTriggered",
        -- parameters = false,
    -- },
    -- isEnabled = function(pEntity, pContext)
        -- local isNear, propertyId = exports["caue-housing"]:isNearProperty()
        -- return not exports["esx_ambulancejob"]:GetPlayerDead() and isNear
    -- end
-- }

-- GeneralEntries[#GeneralEntries+1] = {
    -- data = {
        -- id = "property-lock",
        -- title = "Trancar/Destrancar propriedade",
        -- icon = "#property-lock",
        -- event = "housing:toggleClosestLock"
    -- },
    -- isEnabled = function(pEntity, pContext)
        -- return not exports["esx_ambulancejob"]:GetPlayerDead() and exports["caue-housing"]:canEdit()
    -- end
-- }

-- GeneralEntries[#GeneralEntries+1] = {
    -- data = {
        -- id = "property-invade",
        -- title = "Invadir propriedade",
        -- icon = "#property-enter",
        -- event = "housing:interactionTriggered",
        -- parameters = true,
    -- },
    -- isEnabled = function(pEntity, pContext)
        -- local isNear, propertyId = exports["caue-housing"]:isNearProperty()
        -- return not exports["esx_ambulancejob"]:GetPlayerDead() and isNear and exports["caue-housing"]:isBeingRobbed(propertyId)
    -- end
-- }

-- GeneralEntries[#GeneralEntries+1] = {
    -- data = {
        -- id = "property-edit",
        -- title = "Editar propriedade",
        -- icon = "#property-edit",
        -- event = "caue-housing:edit"
    -- },
    -- isEnabled = function(pEntity, pContext)
        -- return not exports["esx_ambulancejob"]:GetPlayerDead() and exports["caue-housing"]:canEdit()
    -- end
-- }

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "vehicle-vehicleList",
        title = "Lista de veiculos",
        icon = "#vehicle-vehicleList",
        event = "caue-vehicles:garage",
        parameters = { nearby = true, radius = 4.0 }
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and not IsPedInAnyVehicle(PlayerPedId()) and (pEntity and pContext.flags["isVehicleSpawner"] or not pEntity and exports["pw-vehicles"]:IsOnParkingSpot(PlayerPedId(), true, 4.0))
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "fishing-borrowBoat",
        title = "Borrow Fishing Boat",
        icon = "#vehicle-vehicleList",
        event = "caue-fishing:rentBoat",
        parameters = { nearby = true, radius = 4.0 }
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and not IsPedInAnyVehicle(PlayerPedId()) and (pEntity and pContext.flags["isBoatRenter"])
    end
}

local hasDrugs = function()
    return exports["pw-inventory"]:hasEnoughOfItem("joint", 1, false) or
        exports["pw-inventory"]:hasEnoughOfItem("1gcocaine", 1, false) or
        exports["pw-inventory"]:hasEnoughOfItem("1gmeta", 1, false) or
        exports["pw-inventory"]:hasEnoughOfItem("lean", 1, false)
end

-- GeneralEntries[#GeneralEntries+1] = {
    -- data = {
        -- id = "drugs-selling",
        -- title = "Vender Drogas",
        -- icon = "#weed-cultivation",
        -- event = "caue-drugs:startSell"
    -- },
    -- isEnabled = function(pEntity, pContext)
        -- return not isDisabled() and hasDrugs() and not exports["caue-drugs"]:isSelling() and not ESX.GetPlayerData().job.name == 'police'
    -- end
-- }

-- GeneralEntries[#GeneralEntries+1] = {
    -- data = {
        -- id = "drugs-selling",
        -- title = "Parar Vendas",
        -- icon = "#weed-cultivation",
        -- event = "caue-drugs:startSell"
    -- },
    -- isEnabled = function(pEntity, pContext)
        -- return exports["caue-drugs"]:isSelling()
    -- end
-- }


GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "emotes:openmenu",
        title = "Emotes",
        icon = "#general-emotes",
        event = "dpemotes:emotes"
    },
    isEnabled = function(pEntity, pContext)
        return not exports["esx_ambulancejob"]:GetPlayerDead()
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "drivingInstructor:testToggle",
        title = "Driving Test",
        icon = "#drivinginstructor-drivingtest",
        event = "drivingInstructor:testToggle"
    },
    isEnabled = function(pEntity, pContext)
        return not exports["esx_ambulancejob"]:GetPlayerDead() and isInstructorMode
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "drivingInstructor:submitTest",
        title = "Submit Test",
        icon = "#drivinginstructor-submittest",
        event = "drivingInstructor:submitTest"
    },
    isEnabled = function(pEntity, pContext)
        return not exports["esx_ambulancejob"]:GetPlayerDead() and isInstructorMode
    end
}

--GeneralEntries[#GeneralEntries+1] = {
--     data = {
--         id = "general:checkoverself",
--         title = "Se examinar",
--         icon = "#general-check-over-self",
--         event = "Evidence:CurrentDamageList"
--     },
--     isEnabled = function(pEntity, pContext)
--         return not exports["esx_ambulancejob"]:GetPlayerDead()
--     end
-- }

-- GeneralEntries[#GeneralEntries+1] = {
--     data = {
--         id = "bennys:enter",
--         title = "Enter Bennys",
--         icon = "#general-check-vehicle",
--         event = "bennys:enter"
--     },
--     isEnabled = function(pEntity, pContext)
--         return not isDisabled() and polyChecks.bennys.isInside and IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()
--     end
-- }

GeneralEntries[#GeneralEntries+1] = {
    data = {
      id = "toggle-anchor",
      title = "Toggle Anchor",
      icon = "#vehicle-anchor",
      event = "client:anchor"
    },
    isEnabled = function(pEntity, pContext)
        local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local boatModel = GetEntityModel(currentVehicle)
        return not isDisabled() and currentVehicle ~= 0 and (IsThisModelABoat(boatModel) or IsThisModelAJetski(boatModel) or IsThisModelAnAmphibiousCar(boatModel) or IsThisModelAnAmphibiousQuadbike(boatModel))
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
      id = "mdw",
      title = "MDT",
      icon = "#mdt",
      event = "caue-mdt:open"
    },
    isEnabled = function()
        return not exports["esx_ambulancejob"]:GetPlayerDead() and (ESX.GetPlayerData().job.name == 'police' or ESX.GetPlayerData().job.name == 'ambulance')
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "prepare-boat-mount",
        title = "Montar no trailer",
        icon = "#vehicle-plate-remove",
        event = "vehicle:mountBoatOnTrailer"
    },
    isEnabled = function()
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
        if veh == 0 then
            return false
        end
        local seat = GetPedInVehicleSeat(veh, -1)
        if seat ~= ped then
            return false
        end
        local model = GetEntityModel(veh)
        if isDisabled() or not (IsThisModelABoat(model) or IsThisModelAJetski(model) or IsThisModelAnAmphibiousCar(model)) then
            return false
        end
        local left, right = GetModelDimensions(model)
        return #(vector3(0, left.y, 0) - vector3(0, right.y, 0)) < 15
    end
}

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
        title = "Suporte de Armas",
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
    local finished = exports["caue-taskbar"]:taskBar(2500, "Destrancando")
    if finished ~= 100 then return end
    local veh = GetVehiclePedIsIn(PlayerPedId())
    if veh == 0 then return end
    local vehId = exports["caue-vehicles"]:GetVehicleIdentifier(veh)
    TriggerEvent("server-inventory-open", "1", "rifle-rack-" .. vehId)
end)

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "open-documents",
        title = "Documentos",
        icon = "#general-documents",
        event = "caue-documents:openDocuments"
    },
    isEnabled = function()
        return not exports["esx_ambulancejob"]:GetPlayerDead()
    end
}