local PedEntries = MenuEntries["peds"]


PedEntries[#PedEntries+1] = {
    data = {
        id = "peds-escort",
        title = "Escort",
        icon = "#general-escort",
        event = "pw-police:escort"
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and not isEscorting and pEntity and pContext.flags['isPlayer']
    end
}

PedEntries[#PedEntries+1] = {
    data = {
        id = "peds-cuff",
        title = "Cuff",
        icon = "#cuffs-cuff",
        event = "pw-police:cuffPlayer"
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and pEntity and pContext.flags['isPlayer'] and not pContext.flags['isCuffed'] and ((exports["pw-inventory"]:hasEnoughOfItem("cuffs",1,false) or (isPolice or isDoc))) and pContext.distance <= 2.0
    end
}


PedEntries[#PedEntries+1] = {
    data = {
        id = "peds-ucuff",
        title = "Uncuff",
        icon = "#cuffs-uncuff",
        event = "pw-police:uncuffPlayer"
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and pEntity and pContext.flags['isPlayer'] and pContext.flags['isCuffed'] and ((exports["np-inventory"]:hasEnoughOfItem("cuffs",1,false) or (isPolice or isDoc)))
    end
}

PedEntries[#PedEntries+1] = {
    data = {
        id = "peds-unblindfold",
        title = "Remover Venda",
        icon = "#blindfold",
        event = "blindfold:blindfold"
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and pEntity and pContext.flags["isPlayer"] and pContext.flags["isBlindfolded"]
    end
}


PedEntries[#PedEntries+1] = {
    data = {
        id = "peds-cuffActions",
        title = "Cuff Actions",
        icon = "#cuffs",
    },
    subMenus = {"cuffs:softcuff", "cuffs:remmask", "cuffs:beatmode", "cuffs:blindfold"},
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and pEntity and pContext.flags['isPlayer'] and pContext.flags['isCuffed'] and ((exports["pw-inventory"]:hasEnoughOfItem("cuffs",1,false) or (isPolice or isDoc)))
    end
}

PedEntries[#PedEntries+1] = {
    data = {
        id = "peds-revive",
        title = "Revive",
        icon = "#medic-revive",
        event = "revive",
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and pEntity and pContext.flags['isPlayer'] and pContext.flags['isDead'] and (isPolice or isDoc or isMedic or isDoctor)
    end
}

PedEntries[#PedEntries+1] = {
    data = {
        id = "peds-revive-var",
        title = "Revive",
        icon = "#medic-revive",
        event = "np-heists:serverroom:revivePlayer",
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled()
            and IN_SERVER_FARM
            and pEntity
            and pContext.flags['isPlayer']
            and pContext.flags['isDead']
            and exports["np-inventory"]:hasEnoughOfItem("varmedkit", 1, false, true)
    end
}


PedEntries[#PedEntries+1] = {
    data = {
        id = "peds-heal",
        title = "Heal",
        icon = "#medic-heal",
        event = "ems:heal",
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and pEntity and pContext.flags['isPlayer'] and not pContext.flags['isDead'] and (isMedic or isDoctor or isDoc)
    end
}

PedEntries[#PedEntries+1] = {
  data = {
    id = "police-action",
    title = "Police Actions",
    icon = "#police-action",
  },
  subMenus = {"police:frisk", "police:search"},
  isEnabled = function(pEntity, pContext)
    return not IsDisabled() and pEntity and pContext.flags['isPlayer'] and (isPolice or isDoc) and pContext.distance <= 2.0
  end
}

PedEntries[#PedEntries+1] = {
  data = {
    id = "steal",
    title = "Steal",
    icon = "#steal",
    event = "police:rob"
  },
  isEnabled = function(pEntity, pContext)
    return not IsDisabled() and not (isPolice or isDoc) and pEntity and pContext.flags['isPlayer'] and (isPersonBeingHeldUp(pEntity) or pContext.flags['isDead']) and not isOutbreakRunning
  end
}

PedEntries[#PedEntries+1] = {
  data = {
    id = "steal-shoes",
    title = "Steal shoes",
    icon = "#shoes",
    event = "shoes:steal"
  },
  isEnabled = function(pEntity, pContext)
    return not IsDisabled() and not (isPolice or isDoc) and pEntity and pContext.flags['isPlayer'] and (pContext.flags['isCuffed'] or pContext.flags['isDead'] or isPersonBeingHeldUp(pEntity))
  end
}

MenuItems['police:frisk'] = {
  data = {
      id = "peds-frisk",
      title = "Frisk",
      icon = "#police-action-frisk",
      event = "police:checkInventory",
      parameters = { true }
  }
}

MenuItems['police:search'] = {
  data = {
      id = "peds-search",
      title = "Search",
      icon = "#cuffs-check-inventory",
      event = "police:checkInventory"
  }
}

MenuItems["cuffs:softcuff"] = {
    data = {
        id = "cuffs:softcuff",
        title = "Còng tay nhẹ",
        icon = "#walking",
        event = "caue-police:softcuffPlayer"
    }
}

MenuItems['cuffs:remmask'] = {
    data = {
        id = "cuffs:remmask",
        title = "Remove Mask Hat",
        icon = "#cuffs-remove-mask",
        event = "police:remmask"
    }
}


MenuItems["cuffs:beatmode"] = {
    data = {
        id = "cuffs:beatmode",
        title = "Beat Mode",
        icon = "#cuffs-beatmode",
        event = "police:startPutInBeatMode"
    }
}

MenuItems["cuffs:blindfold"] = {
    data = {
        id = "cuffs:blindfold",
        title = "Bịt mặt",
        icon = "#blindfold",
        event = "blindfold:blindfold"
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and pEntity and pContext.flags["isCuffed"] and pContext.flags["isPlayer"] and not pContext.flags["isBlindfolded"] and ((exports["pw-inventory"]:hasEnoughOfItem("blindfold",1,false)))
    end
}


MenuItems["police:dnaSwab"] = {
    data = {
        id = "police:dnaSwab",
        icon = "#police-action-fingerprint",
        title = "Coletar DNA",
        event = "caue-evidence:dnaSwab"
    },
    isEnabled = function(pEntity, pContext)
        return not exports["esx_ambulancejob"]:GetPlayerDead() and pContext.flags and CurrentJob == "cid"
    end
}

MenuItems["police:checkBank"] = {
    data = {
        id = "police:checkBank",
        icon = "#police-check-bank",
        title = "Checar Banco",
        event = "police:checkBank"
    },
    isEnabled = function(pEntity, pContext)
        return not exports["esx_ambulancejob"]:GetPlayerDead() and pContext.flags and ESX.GetPlayerData().job.name == 'police'
    end
}

MenuItems["police:gsr"] = {
    data = {
        id = "police:gsr",
        icon = "#police-action-gsr",
        title = "Checar GSR",
        event = "police:gsr"
    },
    isEnabled = function(pEntity, pContext)
        return not exports["esx_ambulancejob"]:GetPlayerDead() and pContext.flags and ESX.GetPlayerData().job.name == 'police'
    end
}