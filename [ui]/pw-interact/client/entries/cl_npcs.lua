local Entries = {}
--Perfect World

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isWeedShopKeeper' },
  data = {
      {
          id = "weedshop_keeper",
          label = "Smoke on the Water",
          icon = "cannabis",
          event = "pw-npcs:ped:weedSales",
          parameters = {}
      },
	  
  },
  options = {
      distance = { radius = 2.5 }
  }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isRecycleExchange' },
    data = {
        {
            id = "recycle_exchange",
            label = "Exchange recyclables",
            icon = "circle",
            event = "pw-npcs:ped:exchangeRecycleMaterial",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
		
    }
}



Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isBankAccountManager' },
    data = {
        {
            id = "bank_paycheck_collect",
            label = "Collect paycheck",
            icon = "circle",
            event = "pw-npcs:ped:paycheckCollect",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isBankAccountManager' },
    data = {
        {
            id = "bank_receipt_collect",
            label = "trade in receipts",
            icon = "money-bill-wave",
            event = "pw-npcs:ped:receiptTradeIn",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 },
        isEnabled = function()
            local isEmployedAtBurgerShot = exports["pw-business"]:IsEmployedAt("burger_shot")
            local isEmployedAtRoosters = exports["pw-business"]:IsEmployedAt("rooster")
            local isEmployedAtMaldinis = exports["pw-business"]:IsEmployedAt("maldinis")
            local isEmployedAtUwu = exports["pw-business"]:IsEmployedAt("uwu_cafe")
            local publicTradeIn = exports["pw-config"]:GetMiscConfig("jobs.receipts.public")

            return isEmployedAtUwu or isEmployedAtMaldinis or isEmployedAtBurgerShot or isEmployedAtRoosters or isMechanic() or publicTradeIn
        end
    }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isBankAccountManager' },
  data = {
      {
          id = "bank_receipt_m_collect",
          label = "Trade in Market Receipts",
          icon = "money-bill-wave",
          event = "pw-npcs:ped:receiptTradeInMarket",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 2.5 },
      isEnabled = function()
          return exports["pw-inventory"]:getQuantity("farmersmarketreceipt", true) > 0
      end
  }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isBankAccountManager' },
    data = {
        {
            id = "bank_envelope_deposit",
            label = "deposit cash envelope",
            icon = "money-bill-wave",
            event = "pw-restaurants:tradeInCash",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 },
        isEnabled = function()
            local hasAccess = exports['pw-inventory']:hasEnoughOfItem('envelope', 1, false, true, {
                cashEnvelope = true
            })
            return hasAccess
        end
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isCommonJobProvider' },
    data = {
        {
            id = "common_job_signIn",
            label = "Sign in",
            icon = "circle",
            event = "pw-npcs:ped:signInJob",
            parameters = {}
        },
        {
            id = "common_job_signOut",
            label = "Sign out",
            icon = "circle",
            event = "pw-npcs:ped:signInJob",
            parameters = { "unemployed" }
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isJobEmployer' },
    data = {
        {
            id = "jobs_employer_checkIn",
            label = "Sign in",
            icon = "circle",
            event = "jobs:checkIn",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 },
        isEnabled = function()
            return CurrentJob == 'unemployed'
        end
    }
}

-- Entries[#Entries + 1] = {
--     type = 'flag',
--     group = { 'isJobEmployer' },
--     data = {
--         {
--             id = "fishing_borrow_boat",
--             label = "Borrow Fishing Boat",
--             icon = "circle",
--             event = "pw-fishing:rentBoat",
--             parameters = {}
--         }
--     },
--     options = {
--         distance = { radius = 2.5 },
--         isEnabled = function(pEntity, pContext)
--             return pContext.job.id == CurrentJob and not IsDisabled() and not IsPedInAnyVehicle(PlayerPedId()) and (pEntity and pContext.flags['isBoatRenter']) and (currentlyRentedBoat == nil or not DoesEntityExist(currentlyRentedBoat))
--         end
--     }
-- }

-- Entries[#Entries + 1] = {
--     type = 'flag',
--     group = { 'isJobEmployer' },
--     data = {
--         {
--             id = "fishing_return_boat",
--             label = "Return Fishing Boat",
--             icon = "circle",
--             event = "pw-fishing:returnBoat",
--             parameters = {}
--         }
--     },
--     options = {
--         distance = { radius = 2.5 },
--         isEnabled = function(pEntity, pContext)
--             return pContext.job.id == CurrentJob and not IsDisabled() and not IsPedInAnyVehicle(PlayerPedId()) and (pEntity and pContext.flags['isBoatRenter']) and (currentlyRentedBoat ~= nil and DoesEntityExist(currentlyRentedBoat))
--         end
--     }
-- }

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isJobEmployer' },
    data = {
        {
            id = "jobs_employer_paycheck",
            label = "Get paycheck",
            icon = "circle",
            event = "jobs:getPaycheck",
            parameters = {}
        },
        {
            id = "jobs_employer_checkOut",
            label = "Sign out",
            icon = "circle",
            event = "jobs:checkOut",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 },
        isEnabled = function(pEntity, pContext)
            return pContext.job.id == CurrentJob
        end
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isJobEmployer' },
    data = {
        {
            id = "jobs_employer_paycheck",
            label = "Tournament Status",
            icon = "circle",
            event = "pw-fishing:client:getTournamentStatus",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 2.5 },
        isEnabled = function(pEntity, pContext)
            return exports["pw-fishing"]:IsNearFisherGuy()
        end
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isJobEmployer' },
    data = {
        {
            id = "fishing_join_tournament",
            label = "Join Active Tournament",
            icon = "fish",
            event = "pw-fishing:client:joinTournament",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 2.5 },
        isEnabled = function(pEntity, pContext)
            return pContext.job.id == "fishing" and not exports["pw-fishing"]:IsPlayerInTournament() and exports["pw-fishing"]:IsNearFisherGuy()
        end
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isJobEmployer' },
    data = {
        {
            id = "fishing_leave_tournament",
            label = "Leave Active Tournament",
            icon = "fish",
            event = "pw-fishing:client:leaveTournament",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 2.5 },
        isEnabled = function(pEntity, pContext)
            return pContext.job.id == "fishing" and exports["pw-fishing"]:IsPlayerInTournament() and exports["pw-fishing"]:IsNearFisherGuy()
        end
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isJobEmployer' },
    data = {
        {
            id = "dodologistics_getpackage",
            label = "Get Packaging",
            icon = "circle",
            event = "pw-business:dodoLogisticsDisplayPackaging",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 2.5 },
        isEnabled = function(pEntity, pContext)
            local isEmployedAtDodoLogistics = exports["pw-business"]:IsEmployedAt("dodologistics")
            local hasCraftAccess = exports["pw-business"]:HasPermission("dodologistics", "craft_access")
            local pedCoords = GetEntityCoords(PlayerPedId())
            local guyCoords = vector3(-432.95, -2786.08, 6.01)
            return isEmployedAtDodoLogistics and hasCraftAccess and #(pedCoords - guyCoords) < 3.0
        end
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isShopKeeper' },
    data = {
        {
            id = "shopkeeper",
            label = "Mua đồ",
            icon = "circle",
            event = "pw-npcs:ped:keeper",
            parameters = { "2" }
        }
    },
    options = {
        distance = { radius = 6.5 }
    }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "liqourkeeper",
          label = "Purchase alcohol",
          icon = "circle",
          event = "pw-npcs:ped:keeperLiqour",
          parameters = { "42076" }
      }
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"liqourkeeper_1", "liqourkeeper_2", "liqourkeeper_3", "liqourkeeper_4", "liqourkeeper_5", "liqourkeeper_6","liqourkeeper_7", "liqourkeeper_8", "liqourkeeper_9", "liqourkeeper_10", "liqourkeeper_11"}
  }
}

-- local vaultDoorCids = {
--     [1004] = true,
--     [3503] = true,
-- }
-- Entries[#Entries + 1] = {
--     type = 'flag',
--     group = { 'isNPC' },
--     data = {
--         {
--             id = "vdpaleto",
--             label = _L("interact-vault-open", "Open door"),
--             icon = "circle",
--             event = "pw-heists:doors:vaultDoor",
--             parameters = { action = "open", door = "paleto" },
--         },
--     },
--     options = {
--         distance = { radius = 2.5 },
--         npcIds = {"vd_closer_paleto"},
--         isEnabled = function()
--             local cid = exports["isPed"]:isPed("cid")
--             return vaultDoorCids[cid]
--         end,
--     }
-- }

-- Entries[#Entries + 1] = {
--     type = 'flag',
--     group = { 'isNPC' },
--     data = {
--         {
--             id = "vdpaletoclose",
--             label = _L("interact-vault-close", "Close door"),
--             icon = "circle",
--             event = "pw-heists:doors:vaultDoor",
--             parameters = { action = "close", door = "paleto" },
--         },
--     },
--     options = {
--         distance = { radius = 2.5 },
--         npcIds = {"vd_closer_paleto"},
--         isEnabled = function()
--             local cid = exports["isPed"]:isPed("cid")
--             return vaultDoorCids[cid] or myJob == "police"
--         end,
--     }
-- }

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "getpaintballgun",
          label = "Pickup Paintball Gun",
          icon = "circle",
          event = "pw-paintball:getPaintballGun",
          parameters = {},
      },
      {
          id = "getpaintballsmoke",
          label = "Pickup Smoke Grenade",
          icon = "circle",
          event = "pw-paintball:getPaintballSmoke",
          parameters = {},
      },
      {
          id = "getpaintballammo",
          label = "Pickup Paintball Ammo",
          icon = "circle",
          event = "pw-paintball:getPaintballAmmo",
          parameters = {},
      },
      {
          id = "getpaintballmegaphone",
          label = "Pickup Megaphone",
          icon = "circle",
          event = "pw-paintball:getMegaphone",
          parameters = {},
      },
      {
          id = "getpaintballcaddy",
          label = "Pickup Caddy",
          icon = "circle",
          event = "pw-paintball:getCaddy",
          parameters = {},
      },
      {
          id = "getpaintballcart",
          label = "Pickup Go Kart",
          icon = "circle",
          event = "pw-paintball:getGoKart",
          parameters = {},
      },
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"paintball_vendor"}
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
    {
        id = "arenawasteland",
        label = "Enable 'Wasteland'",
        icon = "circle",
        event = "pw-paintball:setArenaType",
        parameters = { "wasteland" },
    },
    {
        id = "arenagokarts",
        label = "Enable 'Concrete Jungle'",
        icon = "circle",
        event = "pw-paintball:setArenaType",
        parameters = { "gokarts" },
    },
    {
        id = "arenagokarts2",
        label = "Enable 'Concrete Maze'",
        icon = "circle",
        event = "pw-paintball:setArenaType",
        parameters = { "gokarts2" },
    },
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"paintball_arena_map"}
  }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "arenagotomain",
            label = "Take me to The Arena!",
            icon = "circle",
            event = "pw-paintball:swapLocations",
            parameters = {},
        },
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"paintball_arena_grass_swapper_1", "paintball_arena_grass_swapper_2"}
    }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "casinoswapinterior",
          label = "Enable Betting Stations",
          icon = "circle",
          event = "pw-casino:betting:interiorSwap",
          parameters = { "bets" },
      },
      {
          id = "casinoswapinteriorpoker",
          label = "Enable Poker Tables",
          icon = "circle",
          event = "pw-casino:betting:interiorSwap",
          parameters = { "poker" },
      },
      {
        id = "casinoswapinteriorroulette",
        label = "Enable Roulette Tables",
        icon = "circle",
        event = "pw-casino:betting:interiorSwap",
        parameters = { "roulette" },
    },
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"casino_interior_swap"}
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "galleryinteriorcars",
          label = "Enable Auction Stand",
          icon = "circle",
          event = "pw-gallery:interiorSwap",
          parameters = { "cars" },
      },
      {
          id = "galleryinteriorfights",
          label = "Enable Fight Ring",
          icon = "circle",
          event = "pw-gallery:interiorSwap",
          parameters = { "fights" },
      },
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"gallery_interior_swap"}
  }
}
--[[ 
Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "paintballjoineastteam",
          label = _L("interact-paintball-join-east", "Join East Team"),
          icon = "circle",
          event = "pw-paintball:game:interact",
          parameters = { "join", "east" },
      },
      {
          id = "paintballjoinwestteam",
          label = _L("interact-paintball-join-west", "Join West Team"),
          icon = "circle",
          event = "pw-paintball:game:interact",
          parameters = { "join", "west" },
      },
      {
          id = "paintballjoinleaveteam",
          label = _L("interact-paintball-leave-team", "Leave Team"),
          icon = "circle",
          event = "pw-paintball:game:interact",
          parameters = { "leave" },
      },
      {
          id = "paintballjoinstartgame",
          label = _L("interact-paintball-start-game", "Start Game"),
          icon = "circle",
          event = "pw-paintball:game:interact",
          parameters = { "start" },
      },
      {
          id = "paintballjoinsendgame",
          label = _L("interact-paintball-end-game", "End Game"),
          icon = "circle",
          event = "pw-paintball:game:interact",
          parameters = { "end" },
      },
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"paintball_signup"}
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
        id = "getminingprobe",
        label = _L("interact-mining-get-probe", "Get Probe"),
        icon = "circle",
        event = "pw-mining:client:collectItem",
        parameters = {
            itemId = "miningprobe"
        }
    },
    {
        id = "getminingpickaxe",
        label = _L("interact-mining-get-pickaxe", "Get Pickaxe"),
        icon = "circle",
        event = "pw-mining:client:collectItem",
        parameters = {
            itemId = "miningpickaxe"
        }
    }
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"mining_vendor"}
  }
}

Entries[#Entries + 1] = {
	type = 'flag',
	group = { 'isNPC' },
	data = {
		{
			id = "hoimports_pickup_sticks_deposit_stick",
			label = _L("interact-hoi-open-storage", "Open Storage"),
			icon = "box-open",
			NPXEvent = "pw-hoimports:client:OpenDepositInventory",
			parameters = {
				id = "hoimports_pickup_sticks_deposit_stick"
			}
		},
		{
			id = "hoimports_pickup_sticks_confirm_delivery",
			label = _L("interact-hoi-deliver-sticks", "Deliver Sticks"),
			icon = "check",
			NPXEvent = "pw-hoimports:client:DepositSticks",
			parameters = {
				id = "hoimports_pickup_sticks_confirm_delivery"
			}
		},
		{
			id = "hoimports_pickup_sticks_claim_tax",
			label = _L("interact-hoi-claim-profits", "Claim Profits"),
			icon = "horse-head",
			NPXEvent = "pw-hoimports:client:ClaimTax",
			parameters = {
				id = "hoimports_pickup_sticks_claim_tax"
			}
		},
	},
	options = {
		distance = { radius = 2.5 },
		npcIds = {"hoimport_vendor"},
		isEnabled = function()
			local isEmployedAtHOImports = exports["pw-business"]:IsEmployedAt("hno_imports")
			local hasCraftAccess = exports["pw-business"]:HasPermission("hno_imports", "craft_access")
			return isEmployedAtHOImports and hasCraftAccess
		end,
	}
}

Entries[#Entries + 1] = {
	type = 'flag',
	group = { 'isNPC' },
	data = {
		{
			id = "hoimports_pickup_sticks_pickup_goods",
			label = _L("interact-fleeca-pickup-goods-vendor", "Pickup Goods"),
			icon = "hand-spock",
			NPXEvent = "pw-hoimports:client:PickupOrder",
			parameters = {
				id = "hoimports_pickup_sticks_pickup_goods"
			}
		},
	},
	options = {
		distance = { radius = 2.5 },
		npcIds = {"hoimport_vendor"},
		isEnabled = function()
			return true
		end,
	}
}

Entries[#Entries + 1] = {
	type = 'flag',
	group = { 'isNPC' },
	data = {
		{
			id = "hoimports_start_drifting",
			label = _L("interact-dw-buy-admin-ticket", "Grab Entrance Ticket"),
			icon = "hand-spock",
			event = "StartDriftPad",
			parameters = {
				id = "hoimports_start_drifting"
			}
		},
	},
	options = {
		distance = { radius = 2.5 },
		npcIds = {"hoimport_drift_vendor"},
		isEnabled = function()
			return true
		end,
	}
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "golfclubseller",
          label = _L("interact-golf-browse", "Browse Goods"),
          icon = "circle",
          event = "pw-inventory:openGolfStore",
          parameters = {},
      },
      {
          id = "golfclubcaddyseller",
          label = _L("interact-golf-get-caddy", "Get Caddy"),
          icon = "circle",
          event = "pw-golf:spawnCaddy",
          parameters = {},
      },
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"golfclubseller"}
  }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "casinovendorman",
            label = _L("interact-purchase-tools", "Purchase tools"),
            icon = "circle",
            event = "pw-casino:openMegaMallStore",
            parameters = {},
        },
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"casinovendor_1"}
    }
}



Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "licensekeeper_bank",
          label = _L("interact-purchase-license", "Purchase License ($500.00) (Bank)"),
          icon = "id-card-alt",
          event = "pw-npcs:ped:licenseKeeper",
          parameters = { type = "bank" },
      },
      {
        id = "licensekeeper_cash",
        label = _L("interact-purchase-license", "Purchase License ($1000.00) (Cash)"),
        icon = "id-card-alt",
        event = "pw-npcs:ped:licenseKeeper",
        parameters = { type = "cash" },
    }
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"npc_license_keeper_1", "npc_license_keeper_2"}
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "vendorlicensekeeper",
          label = _L("interact-get-vendor-license", "Get Vendor License"),
          icon = "id-card-alt",
          event = "pw-farmersmarket:generateVendorLicense",
      }
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"npc_license_keeper_1"},
      isEnabled = function()
        return myJob == "judge" or myJob == "mayor" or myJob == "police" or myJob == "deputy_mayor" or myJob == "county_clerk"
      end,
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "craftitemvendor",
          label = _L("interact-collect-fm-items", "Collect Farmers Market Items"),
          icon = "hand-holding",
          event = "pw-farmersmarket:craftItem",
      }
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"fm_craft_shopkeeper"}
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "fmregisterbanner",
          label = _L("interact-register-fm-banner", "Register Farmers Market Banner"),
          icon = "image",
          event = "pw-farmersmarket:registerBanner",
      }
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"fm_craft_shopkeeper"}
  }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "factoryshopopen",
            label = _L("interact-open-factory-shop", "Shop"),
            icon = "shopping-cart",
            event = "pw-shops:openFactoryShop",
        }
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"factory_craft_shop"}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "",
            label = _L("interact-open-factory-shop", "Shop"),
            icon = "shopping-cart",
            event = "pw-shops:openParsonsShop",
        }
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"parsons_food_vendor"}
    }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "dwfindloststuff",
          label = _L("interact-dw-find-lost-stuff", "Find Lost Stuff"),
          icon = "search",
          event = "pw-deanworld:findLostStuff",
      }
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"dw_drop_1"}
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "dwbuyshitfood",
          label = _L("interact-dw-shit-food", "Purchase Food"),
          icon = "hamburger",
          event = "pw-deanworld:buyShitFood",
      }
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"dw_food_1"}
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "dwbuybumperupgrades",
          label = _L("interact-dw-rl-purchase-upgrades", "Purchase Upgrades"),
          icon = "circle",
          event = "pw-deanworld:purchaseRLUpgrades",
      }
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"dw_bumper_1"}
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "dwdropoffstuff",
          label = _L("interact-dw-dropoff", "Drop Off"),
          icon = "handshake",
          event = "pw-deanworld:dropOffCases",
      }
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"dw_drop_1"}
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "dwadminentrance",
          label = _L("interact-dw-buy-admin-ticket", "Buy Entrance Ticket"),
          icon = "times-circle",
          event = "pw-deanworld:buyAdministrationTicket",
      }
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"dw_admin_1"}
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "fmregisteritem",
          label = _L("interact-fm-register-item", "Register Farmers Market Item"),
          icon = "hamburger",
          event = "pw-farmersmarket:registerItem",
      }
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"fm_craft_shopkeeper"}
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "pcagrader",
          label = _L("interact-pca-grade", "Grade Items"),
          icon = "circle",
          event = "pw-business:pcaGradeItems",
      }
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"dw_pca_grader_1"}
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "airxvendor",
          label = _L("interact-airx-parachute", "Collect Parachute"),
          icon = "parachute-box",
          event = "pw-business:collectAirXParachute",
      }
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"airx_1"}
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "laptopvendor1",
          label = _L("interact-purchase-equip", "Purchase Equipment"),
          icon = "laptop-code",
          event = "pw-heists:laptopPurchase",
      }
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"laptop_1"},
      isEnabled = function()
        return myJob ~= "police"
      end,
  }
}

-- Entries[#Entries + 1] = {
--   type = 'flag',
--   group = { 'isNPC' },
--   data = {
--       {
--           id = "laptopvendor2",
--           label = _L("interact-check-avail", "Check Availability"),
--           icon = "clock",
--           event = "pw-heists:banks:bankCheck",
--       }
--   },
--   options = {
--       distance = { radius = 2.5 },
--       npcIds = {"laptop_1"},
--       isEnabled = function()
--         return myJob ~= "police"
--       end,
--   }
-- }

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isWeaponShopKeeper' },
    data = {
        {
            id = "weaponshop_keeper",
            label = _L("interact-purchase-weapons", "Purchase weapons"),
            icon = "circle",
            event = "pw-npcs:ped:keeper",
            parameters = { "5" }
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isToolShopKeeper' },
    data = {
        {
            id = "toolshop_keeper",
            label = _L("interact-purchase-tools", "Purchase tools"),
            icon = "circle",
            event = "pw-npcs:ped:keeper",
            parameters = { "4" }
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isSportShopKeeper' },
    data = {
        {
            id = "sportshop_keeper",
            label = _L("interact-purchase-gear", "Purchase gear"),
            icon = "circle",
            event = "pw-npcs:ped:keeper",
            parameters = { "34" }
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}



Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isJobVehShopKeeper' },
  data = {
      {
          id = "jobveh_keeper",
          label = _L("interact-purchase-job-veh", "Purchase Job Vehicle"),
          icon = "car",
          event = "pw-showrooms:buyJobVehicles",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 2.5 }
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isWineryShopKeeper' },
  data = {
    {
        id = "winery_keeper_harvest",
        label = "Start Harvesting",
        icon = "shopping-basket",
        event = "pw-vineyard:npcManager",
        parameters = { id = "start_harvest" },
    },
    {
        id = "winery_keeper_atv",
        label = "Rent ATV",
        icon = "motorcycle",
        event = "pw-vineyard:npcManager",
        parameters = { id = "rent_atv" },
    },
    {
        id = "winery_keeper_store",
        label = "Buy Equipment",
        icon = "hand-holding-usd",
        event = "pw-vineyard:npcManager",
        parameters = { id = "buy_equipment" },
    },
  },
  options = {
      distance = { radius = 2.5 }
  }
}

-- Entries[#Entries + 1] = {
--   type = 'flag',
--   group = { 'isWineryShopKeeper' },
--   data = {
--       {
--           id = "winery_keeper_goods",
--           label = _L("interact-purchase-goods", "Purchase Goods"),
--           icon = "wine-glass-alt",
--           event = "pw-business:buyWineryGoods",
--           parameters = {}
--       }
--   },
--   options = {
--       distance = { radius = 2.5 }
--   }
-- }

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isCasinoChipSeller' },
    data = {
      {
          id = "casino_purchase_chips",
          label = _L("interact-purchase-chips", "Purchase Chips"),
          icon = "circle",
          event = "pw-casino:purchaseChipsAction",
          parameters = { "purchase" }
      },
      {
          id = "casino_withdraw_cash",
          label = _L("interact-cashout-cash", "Cashout (Cash)"),
          icon = "wallet",
          event = "pw-casino:purchaseChipsAction",
          parameters = { "withdraw:cash" }
      },
      {
          id = "casino_withdraw_bank",
          label = _L("interact-cashout-bank", "Cashout (Bank)"),
          icon = "university",
          event = "pw-casino:purchaseChipsAction",
          parameters = { "withdraw:bank" }
      },
      {
          id = "casino_transfer_chips",
          label = _L("interact-transfer-chips", "Transfer Chips"),
          icon = "circle",
          event = "pw-casino:purchaseChipsAction",
          parameters = { "transfer" }
      },
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
    {
        id = "casino_wheel_spin_npc_toggle",
        label = _L("interact-wheel-enable", "Toggle Wheel Enabled"),
        icon = "circle",
        event = "pw-casino:wheel:toggleEnable",
    },
    {
        id = "casino_wheel_spin_npc_spin",
        label = _L("interact-spin-wheel", "Spin Wheel! ($500)"),
        icon = "dollar-sign",
        event = "pw-casino:wheel:spinWheel",
    },
    {
        id = "casino_wheel_spin_npc_turbo",
        label = _L("interact-spin-wheel-turbo", "Turbo Spin! ($5,000)"),
        icon = "dollar-sign",
        event = "pw-casino:wheel:spinWheelTurbo",
    },
    {
        id = "casino_wheel_spin_npc_omega",
        label = _L("interact-spin-omega", "Omega Spin! ($20,000)"),
        icon = "dollar-sign",
        event = "pw-casino:wheel:spinWheelOmega",
    },
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"casino_wheel_spin_npc"}
  }
}

local wheelCid = 0
Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "casino_wheel_spin_npc_check",
            label = _L("interact-spin-check-spent", "Check Spent Amount"),
            icon = "dollar-sign",
            event = "pw-casino:wheel:checkSpentAmount",
        },
        {
            id = "casino_wheel_spin_pickup_cash",
            label = _L("interact-spin-check-spent", "Pickup Wheel Cash"),
            icon = "dollar-sign",
            event = "pw-casino:wheel:pickupWheelCash",
        },
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"casino_wheel_spin_npc"},
        isEnabled = function()
            if wheelCid == 0 then
                wheelCid = exports["pw-config"]:GetMiscConfig("casino.wheel.cash.pickup.cid")
            end
            return wheelCid == exports["isPed"]:isPed("cid")
        end,
    }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
    {
        id = "cgchaincraft",
        label = _L("interact-craft-chainz", "Craft Chainz"),
        icon = "circle",
        event = "pw-clothing:openCGChainCrafting",
    },
    {
        id = "cgchaininfuse",
        label = _L("interact-infuse-chain", "Infuse Chain"),
        icon = "gem",
        event = "pw-clothing:infuseChainWithGems",
    },
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"cgjvendor"}
  }
}


-- Entries[#Entries + 1] = {
--   type = 'flag',
--   group = { 'isCasinoChipSeller' },
--   data = {
--       {
--           id = "casino_purchase_chips_bands",
--           label = "Purchase Chips (Dirty)",
--           icon = "circle",
--           event = "pw-casino:purchaseChipsAction",
--           parameters = { "purchase:dirty" }
--       },
--   },
--   options = {
--       distance = { radius = 2.5 },
--       isEnabled = function()
--           return myJob == 'unemployed'
--             and (exports['pw-inventory']:hasEnoughOfItem("markedbills", 20, false, true)
--             or exports['pw-inventory']:hasEnoughOfItem("rollcash", 5, false, true)
--             or exports['pw-inventory']:hasEnoughOfItem("band", 5, false, true))
--       end
--   }
-- }

-- Entries[#Entries + 1] = {
--   type = 'flag',
--   group = { 'isCasinoMembershipGiver' },
--   data = {
--     {
--         id = "casino_membership_giver",
--         label = "Get Membership",
--         icon = "circle",
--         event = "pw-casino:purchaseMembership",
--         parameters = {}
--     },
--   },
--   options = {
--       distance = { radius = 2.5 }
--   }
-- }

-- Entries[#Entries + 1] = {
--   type = 'flag',
--   group = { 'isCasinoMembershipGiver' },
--   data = {
--     {
--         id = "casino_vip_membership_giver",
--         label = "Get VIP Membership",
--         icon = "circle",
--         event = "pw-casino:purchaseVipMembership",
--         parameters = {}
--     },
--   },
--   options = {
--       distance = { radius = 2.5 }
--   }
-- }

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isCasinoMembershipGiver' },
  data = {
    {
        id = "casino_membership_giver",
        label = _L("interact-casino-purchase-membership", "Purchase Membership ($250)"),
        icon = "circle",
        event = "pw-casino:purchaseMembershipCard",
        parameters = {}
    },
    {
        id = "casino_membership_giver_emp",
        label = _L("interact-casino-get-member-card", "Get Membership Card"),
        icon = "circle",
        event = "pw-casino:purchaseMembership",
        parameters = {}
    },
    {
        id = "casino_membership_loyalty",
        label = _L("interact-casino-get-loyality-card", "Get Loyalty Card"),
        icon = "circle",
        event = "pw-casino:getLoyaltyCard",
        parameters = {}
    },
    {
        id = "casino_membership_hotel_vip",
        label = _L("interact-casino-hotel-vip", "Get Hotel VIP Card"),
        icon = "circle",
        event = "pw-casino:getHotelVIPCard",
        parameters = {}
    },
  },
  options = {
      distance = { radius = 2.5 }
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isCasinoDrinkGiver' },
  data = {
    {
        id = "casino_drink_giver",
        label = _L("interact-casino-drinks", "Purchase Drinks"),
        icon = "circle",
        event = "pw-casino:purchaseDrinks",
        parameters = {}
    },
  },
  options = {
      distance = { radius = 2.5 }
  }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isPawnBuyer' },
    data = {
        {
            id = "pawn_give_items",
            label = _L("interact-pawn-give", "Give stolen items"),
            icon = "circle",
            event = "pw-npcs:ped:giveStolenItems",
            parameters = {}
        },
        {
            id = "pawn_sell_items",
            label = _L("interact-pawn-sell", "Sell given items"),
            icon = "circle",
            event = "pw-npcs:ped:sellStolenItems",
            parameters = {}
        }
    },
    options = {
        distance = {
            radius = 2.5
        }
    }
}

-- Pawnhub Buyer
Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "pawnhub_give_items",
            label = _L("interact-pawn-give", "Hand Goods..."),
            icon = "circle",
            event = "pw-business:client:pawnhub:giveStolenItems",
            parameters = {}
        },
        {
            id = "pawnhub_sell_items",
            label = _L("interact-pawn-sell", "Sell given goods..."),
            icon = "circle",
            event = "pw-business:client:pawnhub:sellStolenItems",
            parameters = {}
        },
        {
            id = "pawnhub_start_run",
            label = _L("interact-pawn-sell", "Start a run..."),
            icon = "circle",
            event = "pw-business:client:pawnhub:startRun",
            parameters = {}
        },
        {
            id = "pawnhub_get_balance",
            label = _L("interact-pawn-sell", "Get current balance..."),
            icon = "circle",
            event = "pw-business:client:pawnhub:getBalance",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"pawnhub_buyer"}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "vehicleshopkeeper",
            label = _L("interact-npc-shop-vehicle", "Purchase vehicle"),
            icon = "circle",
            event = "pw-npcs:ped:vehiclekeeper",
        }
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"npc_bike_shop", "npc_boat_shop", "npc_air_shop"}
    }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "vehiclerentalkeeper",
          label = _L("interact-rent-vehicle", "Rent vehicle"),
          icon = "circle",
          event = "pw-npcs:ped:vehiclekeeperrent",
      }
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"npc_air_shop"}
  }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "vehicleshoprenter",
            label = _L("interact-rent-vehicle", "Rent vehicle"),
            icon = "circle",
            event = "pw-npcs:ped:vehiclekeeper",
        }
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"npc_veh_rental"}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "vehicleshoprenter2",
            label = _L("interact-rent-vehicle", "Rent vehicle"),
            icon = "circle",
            event = "pw-npcs:ped:vehiclekeeper",
        }
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"npc_veh_rental2"}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "fish_market",
            label = _L("interact-sell-fish", "Sell fish"),
            icon = "dollar-sign",
            event = "pw-npcs:ped:sellFish",
        },
        {
            id = "fish_market_buy_net",
            label = _L("interact-buy-fish-net", "Purchase Gill Net ($300)"),
            icon = "fish",
            event = "pw-fishing:client:purchaseNet",
        },
        {
            id = "fish_market_buy_bucket",
            label = _L("interact-buy-fish-bucket", "Purchase Fishing Bucket ($300)"),
            icon = "fish",
            event = "pw-fishing:client:purchaseBucket",
        }
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"fish_market"}
    }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "hunting_market",
          label = _L("interact-sell-pelts", "Sell Pelts"),
          icon = "dollar-sign",
          event = "pw-hunting:makeSales",
      }
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"hunting_market"}
  }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "digital_den_npc",
            label = _L("interact-digital-den-shop", "Open Shop"),
            icon = "circle",
            event = "pw-npcs:ped:openDigitalDenShop",
        }
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"digital_den_npc"}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "cocaine_start",
            label = _L("interact-cokejob-start", "Pay me $100,000 :)"),
            icon = "circle",
            event = "heists:cocaine_payment",
        }
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"cocaine_start"}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isMethDude' },
    data = {
        {
            id = "purchasemethkey",
            label = _L("interact-methnpc-buy", "Purchase Information"),
            icon = "key",
            event = "pw-meth:purchaseMethInformation",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"purchasemethkey"}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isMethDude' },
    data = {
        {
            id = "meth-pickup-items",
            label = _L("interact-methnpc-pickup", "Pickup items"),
            icon = "key",
            event = "pw-meth:pickupItems",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"purchasemethkey"},
        isEnabled = function ()
            return exports["pw-meth"]:hasUnpickedItems()
        end
    }
}

local validPracCids = {
  [1062] = true, -- claire
  [1107] = true,
  [1363] = true, -- violet
  [1380] = true, -- lexi
  [3503] = true, 
}
Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isMethDude' },
  data = {
      {
          id = "purchasepraclaptop",
          label = _L("interact-purchase-prac-lap", "Purchase Practice Laptop"),
          icon = "laptop",
          event = "pw-heists:purchasePracticeLaptop",
          parameters = {}
      },
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"purchasemethkey"},
      isEnabled = function()
        local cid = exports["isPed"]:isPed("cid")
        local pracWhitelist = exports['pw-config']:GetMiscConfig("heists.prac.whitelist")
        return (pracWhitelist and validPracCids[cid]) or not pracWhitelist
      end,
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "sellgallerygem",
          label = _L("interact-sell-gems", "Sell Gems"),
          icon = "gem",
          event = "pw-gallery:sellGems",
          parameters = {}
      },
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"gemshop_1"}
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "nikezrollercoasterspawnride",
          label = _L("interact-summon-rollercoaster", "Summon roller coaster"),
          icon = "child",
          event = "nikez-rollercoaster:canSpawnCoaster",
          parameters = {}
      },
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"nikez_rollercoaster_worker"}
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "nikezfreefalltowerspawnride",
          label = _L("interact-summon-freefalltower", "Summon ride"),
          icon = "space-shuttle",
          event = "nikez-freefalltower:canSpawnRide",
          parameters = {}
      },
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"nikez_freefalltower_worker"}
  }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "pubtownhallbuylicense",
            label = _L("interact-purchase-licenses-pub", "purchase licenses"),
            icon = "id-card-alt",
            event = "pw-gov:purchaseLicenses",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 3.5 },
        npcIds = {"npc_pub_townhall"}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "pubbusinessbuylicense",
            label = _L("interact-purchase-business-license-pub", "purchase business license"),
            icon = "business-time",
            event = "pw-gov:purchaseBusiness",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 3.5 },
        npcIds = {"npc_pub_business"}
    }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "fruitstandvendor",
          label = _L("interact-fruitstandvendor", "Buy fruits & veggies"),
          icon = "lemon",
          event = "pw-distillery:fruitShop",
          parameters = {}
      },
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"fruitstand_vendor"}
  }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "xcoinvendor",
            label = _L("interact-xcoinvendor", "Stacks on Stacks"),
            icon = "circle",
            event = "pw-phone:getXCoin",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"xcoinredeem_1"}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "purchase_gang_spray",
            label = _L("interact-purchase-spray", "Purchase Gang Spray"),
            icon = "spray-can",
            NPXEvent = "pw-gangsystem:purchaseGangSpray",
            parameters = {}
        },
        {
            id = "purchase_normal_spray",
            label = _L("interact-purchase-normal-spray", "Purchase Normal Sprays ($5k)"),
            icon = "spray-can",
            event = "pw-graffiti:openSprayMenu",
            parameters = {}
        },
        {
            id = "pruchase_scrubbing_cloth",
            label = _L("interact-purchase-cloth", "Purchase Scrubbing Cloth ($50k)"),
            icon = "broom",
            NPXEvent = "pw-gangsystem:purchaseScrubbingCloth",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"gangspray_1"}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "hno_collect_rental",
            label = _L("interact-hno-rental-collect", "Collect Rental Vehicle"),
            icon = "car",
            NPXEvent = "pw-hoimports:collectRental",
            parameters = {}
        },
        {
            id = "hno_return_rental",
            label = _L("interact-hno-rental-return", "Return Rental Vehicle"),
            icon = "car",
            event = "pw-hoimports:returnRental",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"hno_rental_1"}
    }
}

function getHotelWorkerConfig(npcId, businessId, includeDiscount) 
  local hotelWorkerData = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "hotel_list_tenants_" .. businessId,
            label = _L("interact-list-tenants", "List tenants"),
            icon = "laptop-house",
            event = "pw-business:hotel:listTenantsPrompt",
            parameters = {
              biz = businessId
            }
        },
        {
            id = "hotel_add_tenant_" .. businessId,
            label = _L("interact-add-tenant", "Add tenant"),
            icon = "house-user",
            event = "pw-business:hotel:addTenantPrompt",
            parameters = {
              biz = businessId
            }
        },
        {
            id = "hotel_remove_tenant_" .. businessId,
            label = _L("interact-remove-tenant", "Remove tenant"),
            icon = "house-damage",
            event = "pw-business:hotel:removeTenantPrompt",
            parameters = {
              biz = businessId
            }
        },
        {
            id = "hotel_clear_tenants_" .. businessId,
            label = _L("interact-clear-tenant", "Clear tenants"),
            icon = "home",
            event = "pw-business:hotel:clearTenantsPrompt",
            parameters = {
              biz = businessId
            }
        }
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = { npcId }
    }
  }
  if includeDiscount then
    hotelWorkerData["data"][#hotelWorkerData["data"] + 1] = {
        id = "hotel_discount_card" .. businessId,
        label = _L("interact-discount-card", "Get discount card"),
        icon = "circle",
        event = "pw-casino:hotel:getDiscountCard",
        parameters = {
          biz = businessId
        }
    }
    hotelWorkerData["data"][#hotelWorkerData["data"] + 1] = {
        id = "hotel_soap" .. businessId,
        label = _L("interact-casino-soap", "Get Lucky Soap"),
        icon = "circle",
        event = "pw-casino:getSoap",
        parameters = {
          biz = businessId
        }
    }
    hotelWorkerData["data"][#hotelWorkerData["data"] + 1] = {
        id = "casino_bag" .. businessId,
        label = _L("interact-casino-bag", "Get Casino Bag"),
        icon = "circle",
        event = "pw-casino:getCasinoBag",
        parameters = {
          biz = businessId
        }
    }
    hotelWorkerData["data"][#hotelWorkerData["data"] + 1] = {
        id = "casino_coin_" .. businessId,
        label = _L("interact-casino-bag", "Diamond Hotel Krugerrand"),
        icon = "coins",
        event = "pw-casino:getCasinoCoin",
        parameters = {
          biz = businessId
        }
    }
  end
  return hotelWorkerData
end

Entries[#Entries + 1] = getHotelWorkerConfig("rr_hotel_worker", "rr_hotel")
Entries[#Entries + 1] = getHotelWorkerConfig("casino_hotel_worker", "casino_hotel", true)
Entries[#Entries + 1] = getHotelWorkerConfig("rtreat_hotel_worker", "roosterretreat")

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "icu_list_patients",
            label = "List Patients",
            icon = "laptop-house",
            event = "pw-healthcare:icu:listPatientsPrompt",
            parameters = {}
        },
        {
            id = "icu_add_patient",
            label = "Add Patient",
            icon = "house-user",
            event = "pw-healthcare:icu:addPatientPrompt",
            parameters = {}
        },
        {
            id = "icu_remove_patient",
            label = "Remove Patient",
            icon = "house-damage",
            event = "pw-healthcare:icu:removePatientPrompt",
            parameters = {}
        },
        {
            id = "icu_clear_patients",
            label = "Clear Patients",
            icon = "home",
            event = "pw-healthcare:icu:clearPatientsPrompt",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = { "pillbox_icu_worker" }
    }
}

local validAnimalModels = {
  [`a_c_chop`] = true,
  [`a_c_husky`] = true,
  [`a_c_husky_np`] = true,
  [`a_c_panther`] = true,
  [`a_c_cat_01`] = true,
  [`a_c_poodle`] = true,
  [`a_c_pug`] = true,
  [`a_c_retriever`] = true,
  [`a_c_retriever_np`] = true,
  [`a_c_shepherd`] = true,
  [`a_c_shepherd_np`] = true,
  [`a_c_pit_np`] = true,
  [`a_c_coyote`] = true,
  [`a_c_rottweiler`] = true,
  [`a_c_westy`] = true,
}
Entries[#Entries + 1] = {
  type = 'entity',
  group = { 1 },
  data = {
      {
          id = "petthebaby",
          label = _L("interact-pet-animal", "Pet"),
          icon = "circle",
          event = "pw-interact:doPettingAnimal",
          parameters = "petting",
      },
  },
  options = {
      distance = { radius = 2.5 },
      isEnabled = function(pEntity, pContext)
        -- -- Don't show options if this entity is dead 
        if pContext.isDead then
            return
        end

        return validAnimalModels[pContext.model]
      end,
  }
}
local lastStressTime = 0
AddEventHandler("pw-interact:doPettingAnimal", function()
  ClearPedTasksImmediately(PlayerPedId())
  TriggerEvent("animation:runtextanim", "petting")
  if lastStressTime == 0 or lastStressTime + (60000 * 15) < GetGameTimer() then
    lastStressTime = GetGameTimer()
    TriggerEvent("client:newStress", false, 250)
  end
end)

Entries[#Entries + 1] = {
  type = 'entity',
  group = { 1 },
  data = {
      {
          id = "bobcatblowc4",
          label = _L("interact-bobcat-blowdoor", "Blow the Door!"),
          icon = "circle",
          event = "pw-heists:interactBobcatC4Npc",
          parameters = {},
      },
  },
  options = {
      distance = { radius = 2.5 },
      isEnabled = function(pEntity)
        return DecorGetBool(pEntity, "BobcatC4Ped")
      end,
  }
}

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 1 },
    data = {
        {
            id = "bettalifenpc",
            label = _L("interact-bettalife-npc", "Get Items"),
            icon = "circle",
            event = "pw-business:interactBettaLifeNpc",
            parameters = {},
        },
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"betta_life_craft"},
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "comicstore-recycle-give",
            label = _L("interact-comicstore-turn-in", "Give toys and cards to recycle"),
            icon = "box",
            event = "pw-business:ped:comicRecycleGive",
            parameters = {}
        },
        {
            id = "comicstore-recycle-recycle",
            label = _L("interact-comicstore-recycle-given", "Recycle given items"),
            icon = "recycle",
            event = "pw-business:ped:comicRecycle",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 },
        npcIds = { "guild-toycrush" }
    }
}

function isCompanionOrPlayerAnimal(pEntity)
  local animalHash = GetEntityModel(pEntity)
  return (DecorGetInt(pEntity, "COMPANION_ID") ~= 0 or IsPedAPlayer(pEntity)) and (
    animalHash == `a_c_cow` or
    animalHash == `a_c_boar` or
    -- animalHash == `a_c_horse` or
    animalHash == `a_c_deer` or
    (GetEntityModel(PlayerPedId()) == `ratboy` and animalHash == `a_c_mtlion`)
  )
end

Entries[#Entries + 1] = {
  type = 'entity',
  group = { 1 },
  data = {
      {
          id = "companion_mount",
          label = _L("interact-companions-mount", "Mount"),
          icon = "circle",
          event = "pw-companions:client:mountCompanion",
          parameters = {},
      },
  },
  options = {
      distance = { radius = 2.5 },
      isEnabled = function(pEntity)
        if IsEntityAttachedToEntity(PlayerPedId(), pEntity) then
          return false
        end
        local nearbyPlayers = GetActivePlayers()
        for k, v in pairs(nearbyPlayers) do
          local playerPed = GetPlayerPed(v)
          if IsEntityAttachedToEntity(playerPed, pEntity) then
            return false
          end
        end
        return isCompanionOrPlayerAnimal(pEntity)
      end,
  }
}

Entries[#Entries + 1] = {
  type = 'entity',
  group = { 1 },
  data = {
      {
          id = "companion_unmount",
          label = _L("interact-companions-unmount", "Unmount"),
          icon = "circle",
          event = "pw-companions:client:unmountCompanion",
          parameters = {},
      },
  },
  options = {
      distance = { radius = 2.5 },
      isEnabled = function(pEntity)
        return isCompanionOrPlayerAnimal(pEntity) and IsEntityAttachedToEntity(PlayerPedId(), pEntity)
      end,
  }
} ]]

function isMechanic()
    local mechanic = false
    local mechanicShops = { "harmony_repairs", "ottos_auto", "hayes_autos", "tuner", "iron_hog" }

    for _, shop in ipairs(mechanicShops) do
        if exports["pw-business"]:IsEmployedAt(shop) then
            mechanic = true
            break
        end
    end

    return mechanic
end


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
