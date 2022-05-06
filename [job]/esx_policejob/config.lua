Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for cops on duty, requires esx_society
Config.EnableCustomPeds           = true -- enable custom peds in cloak room? See Config.CustomPeds below to customize peds

Config.EnableESXService           = false -- enable esx service?
Config.MaxInService               = 15

Config.Locale                     = 'en'

Config.PoliceStations = {

	LSPD = {
		Name = "Trụ sở Los Santos",
		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(462.45, -999.02, 30.6)
		},

		Armories = {
			
			vector3(482.23, -995.32, 30.69)
		},
		
		Cctv = {
			
			vector3(444.84753, -998.2514, 34.970169)
		},

		Vehicles = {
			{
				Spawner = vector3(454.6, -1017.4, 28.4),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0},
					{coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0},
					{coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0},
					{coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0}
				}
			},

			{
				Spawner = vector3(473.3, -1018.8, 28.0),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0},
					{coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(461.1, -981.5, 43.6),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0}
				}
			}
		},

		BossActions = {
			vector3(448.4, -973.2, 30.6)
		}

	},
	LSPD1 = {
		Name = "Trụ sở thứ Sa mạc",
		Blip = {
			Coords  = vector3(1854.4951, 3686.8623, 34.259334),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(462.45, -999.02, 30.6)
		},

		Armories = {
			
			vector3(1841.9234, 3691.8989, 34.257984)
		},
		
		Cctv = {
			
			vector3(1852.3562, 3691.1037, 34.257862)
		},

		Vehicles = {
			{
				Spawner = vector3(1865.9847, 3685.0476, 33.801101),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{coords = vector3(1870.6972, 3691.0869, 33.638725), heading = 186.0, radius = 6.0},
					{coords = vector3(1876.746, 3691.8129, 33.394943), heading = 214.0, radius = 6.0},
					{coords = vector3(1862.4062, 3705.5017, 33.379261), heading = 209.0, radius = 6.0}
				}
			},

			{
				Spawner = vector3(473.3, -1018.8, 28.0),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0},
					{coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(461.1, -981.5, 43.6),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0}
				}
			}
		},
		
		BossActions = {
			vector3(448.4, -973.2, 30.6)
		}


	}
	


}

Config.AuthorizedWeapons = {
	rank1 = {
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 10 },
		{ weapon = 'WEAPON_MACHINEPISTOL', price = 10000 },		
		{ weapon = '3219281620', price = 5000 }
	},

	rank2 = {
		
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 10 },
		{ weapon = '3219281620', price = 5000 }, 
		{ weapon = 'WEAPON_MACHINEPISTOL', price = 10000 },
		{ weapon = 'WEAPON_MICROSMG', price = 15000 }
		
		
	},

	rank3 = {
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 10 },
		{ weapon = '3219281620', price = 5000 }, 
		{ weapon = 'WEAPON_MACHINEPISTOL', price = 10000 },
		{ weapon = 'WEAPON_MICROSMG', price = 15000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 15000 }
	},


	rank4 = {
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 10 },
		{ weapon = '3219281620', price = 5000 }, 
		{ weapon = 'WEAPON_MACHINEPISTOL', price = 10000 },
		{ weapon = 'WEAPON_MICROSMG', price = 15000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 15000 },
		{ weapon = 'WEAPON_HEAVYPISTOL', price = 15000 }
	},

	rank5 = {
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 10 },
		{ weapon = '3219281620', price = 5000 }, 
		{ weapon = 'WEAPON_MACHINEPISTOL', price = 10000 },
		{ weapon = 'WEAPON_MICROSMG', price = 15000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 15000 },
		{ weapon = '487013001', price = 10000 } 
	},
	
	rank6 = {
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 10 },
		{ weapon = '3219281620', price = 5000 }, 
		{ weapon = 'WEAPON_MACHINEPISTOL', price = 10000 },
		{ weapon = 'WEAPON_MICROSMG', price = 15000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 15000 },
		{ weapon = '487013001', price = 10000 } , 
		{ weapon = 'WEAPON_CARBINERIFLE', price = 50000 },
		{ weapon = 'WEAPON_SMG', price = 30000 }
	},
	
	rank7 = {
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 10 },
		{ weapon = '3219281620', price = 5000 }, 
		{ weapon = 'WEAPON_MACHINEPISTOL', price = 10000 },
		{ weapon = 'WEAPON_MICROSMG', price = 15000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 15000 },
		{ weapon = '487013001', price = 10000 } , 
		{ weapon = 'WEAPON_SMG', price = 30000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', price = 60000 },
		{ weapon = 'WEAPON_CARBINERIFLE', price = 50000 },
		{ weapon = 'WEAPON_SAWNOFFSHOTGUN', price = 15000 },
		{ weapon = 'WEAPON_MG', price = 100000 }
	},
	
	rank8 = {
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 10 },
		{ weapon = '3219281620', price = 5000 }, 
		{ weapon = 'WEAPON_MACHINEPISTOL', price = 10000 },
		{ weapon = 'WEAPON_MICROSMG', price = 15000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 15000 },
		{ weapon = '487013001', price = 10000 } , 
		{ weapon = 'WEAPON_SMG', price = 30000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', price = 60000 },
		{ weapon = 'WEAPON_CARBINERIFLE', price = 50000 },
		{ weapon = 'WEAPON_SAWNOFFSHOTGUN', price = 15000 },
		{ weapon = 'WEAPON_COMBATMG', price = 150000 }

	},
	
	rank9 = {
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 10 },
		{ weapon = '3219281620', price = 5000 }, 
		{ weapon = 'WEAPON_MACHINEPISTOL', price = 10000 },
		{ weapon = 'WEAPON_MICROSMG', price = 15000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 15000 },
		{ weapon = '487013001', price = 10000 } , 
		{ weapon = 'WEAPON_SMG', price = 30000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', price = 60000 },
		{ weapon = 'WEAPON_CARBINERIFLE', price = 50000 },
		{ weapon = 'WEAPON_SAWNOFFSHOTGUN', price = 15000 },
		{ weapon = 'WEAPON_COMBATMG', price = 150000 }
	},
	
	rank10 = {
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 10 },
		{ weapon = '3219281620', price = 5000 }, 
		{ weapon = 'WEAPON_MACHINEPISTOL', price = 10000 },
		{ weapon = 'WEAPON_MICROSMG', price = 15000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 15000 },
		{ weapon = '487013001', price = 10000 } , 
		{ weapon = 'WEAPON_SMG', price = 30000 },
		{ weapon = 'WEAPON_SAWNOFFSHOTGUN', price = 15000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', price = 60000 },
		{ weapon = 'WEAPON_CARBINERIFLE', price = 50000 },
		{ weapon = 'WEAPON_ASSAULTSMG', price = 80000 },
		{ weapon = 'WEAPON_AUTOSHOTGUN', price = 80000 },
		{ weapon = 'WEAPON_SNIPERRIFLE', price = 500000 },
		{ weapon = 'WEAPON_BULLPUPSHOTGUN', price = 30000 }
	},
	
	rank11 = {
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 10 },
		{ weapon = '3219281620', price = 5000 }, 
		{ weapon = 'WEAPON_MACHINEPISTOL', price = 10000 },
		{ weapon = 'WEAPON_MICROSMG', price = 15000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 15000 },
		{ weapon = '487013001', price = 10000 } , 
		{ weapon = 'WEAPON_SMG', price = 30000 },
		{ weapon = 'WEAPON_SAWNOFFSHOTGUN', price = 15000 },
		{ weapon = 'WEAPON_ASSAULTSMG', price = 80000 },
		{ weapon = 'WEAPON_AUTOSHOTGUN', price = 80000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', price = 60000 },
		{ weapon = 'WEAPON_CARBINERIFLE', price = 50000 },
		{ weapon = 'WEAPON_MARKSMANRIFLE', price = 700000 },
		{ weapon = 'WEAPON_BULLPUPSHOTGUN', price = 30000 }
	},

	boss = {
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 10 },
		{ weapon = '3219281620', price = 5000 }, 
		{ weapon = 'WEAPON_BULLPUPSHOTGUN', price = 30000 },
		{ weapon = 'WEAPON_MACHINEPISTOL', price = 10000 },
		{ weapon = 'WEAPON_MICROSMG', price = 15000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 15000 },
		{ weapon = '487013001', price = 10000 } , 
		{ weapon = 'WEAPON_SMG', price = 30000 },
		{ weapon = 'WEAPON_SAWNOFFSHOTGUN', price = 15000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', price = 60000 },
		{ weapon = 'WEAPON_CARBINERIFLE', price = 50000 },
		{ weapon = 'WEAPON_ASSAULTSMG', price = 80000 },
		{ weapon = 'WEAPON_AUTOSHOTGUN', price = 80000 },
		{ weapon = 'WEAPON_HEAVYSNIPER', price = 2000000 }
		
	}
}

Config.AuthorizedVehicles = {
	car = {
		
		rank1 = {
			-- { model = 'police', label = 'Police Cruiser', price = 1 },
			-- { model = 'police2', label = 'Police Bike', price = 1 },
			-- { model = 'police3', label = 'Police Bike', price = 1 },
			{ model = 'policeb', label = 'Police Bike 2', price = 100 },
			{ model = 'v14charger', label = 'Police Cruise 3', price = 200 },
			{ model = 'v16explorer', label = 'Police SUV', price = 200 },
			{ model = 'police', label = 'Police Cruise', price = 100 }
		},
		rank2 = {
			-- { model = 'police', label = 'Police Cruiser', price = 1 },
			-- { model = 'police2', label = 'Police Bike', price = 1 },
			-- { model = 'police3', label = 'Police Bike', price = 1 },
			{ model = 'policeb', label = 'Police Bike 2', price = 100 }
		},
		rank3 = {
			-- { model = 'police', label = 'Police Cruiser', price = 1 },
			-- { model = 'police2', label = 'Police Bike', price = 1 },
			-- { model = 'police3', label = 'Police Bike', price = 1 },
			{ model = 'policeb', label = 'Police Bike 2', price = 100 }
		},
		rank4 = {
			-- { model = 'police', label = 'Police Cruiser', price = 1 },
			-- { model = 'police2', label = 'Police Bike', price = 1 },
			-- { model = 'police3', label = 'Police Bike', price = 1 },
			{ model = 'policeb', label = 'Police Bike 2', price = 100 }
		},
		rank5 = {
			-- { model = 'police', label = 'Police Cruiser', price = 1 },
			-- { model = 'police2', label = 'Police Bike', price = 1 },
			-- { model = 'police3', label = 'Police Bike', price = 1 },
			{ model = 'policeb', label = 'Police Bike 2', price = 100 }
		},

		rank7 = {
			-- { model = 'police', label = 'Police Cruiser', price = 1 },
			-- { model = 'police2', label = 'Police Bike', price = 1 },
			-- { model = 'police3', label = 'Police Bike', price = 1 },
			{ model = 'policeb', label = 'Police Bike 2', price = 100 }
		},
		rank8 = {
			-- { model = 'police', label = 'Police Cruiser', price = 1 },
			-- { model = 'police2', label = 'Police Bike', price = 1 },
			-- { model = 'police3', label = 'Police Bike', price = 1 },
			{ model = 'policeb', label = 'Police Bike 2', price = 100 }
		},
		rank9 = {
		
			{ model = 'policeb', label = 'Police Bike 2', price = 100 }
		},
		rank10 = {
		
			{ model = 'policeb', label = 'Police Bike 2', price = 100 }
		},
		rank11 = {
		
			{ model = 'policeb', label = 'Police Bike 2', price = 100 }
		},

		rank6 = {
			{ model = 'policeb', label = 'Police Bike 2', price = 100 }
		},

		rank7 = {
			{ model = 'policeb', label = 'Police Bike 2', price = 100 }
		},

		boss = {
			{ model = 'policeb', label = 'Police Bike 2', price = 100 }
		}
	},

	helicopter = {
		rank1 = {},

		rank2 = {},

		rank3 = {},
		
		rank4 = {},
		
		rank5 = {},
		
		rank6 = {},
		
		rank7 = {},
		
		rank8 = {},
		
		rank9 = {},

		rank10 = {
			{model = 'polmav', props = {modLivery = 0}, price = 1500000}
		},
		
		rank11 = {
			{model = 'polmav', props = {modLivery = 0}, price = 1500000}
		},

		boss = {
			{model = 'polmav', props = {modLivery = 0}, price = 1500000}
		}
	}
}

Config.CustomPeds = {
	shared = {
		-- {label = 'Công an phường', maleModel = 'conganphuong', femaleModel = 'conganphuong'},
		-- {label = 'Cảnh sát giao thông', maleModel = 'csgt', femaleModel = 'csgt'},
		-- {label = 'Cảnh sát cơ động', maleModel = 'cscd', femaleModel = 'cscd'},
		-- {label = 'Cyber Cop', maleModel = 'cybercop', femaleModel = 'cybercop'},
		-- {label = 'Detroit Cop', maleModel = 'detroitcop', femaleModel = 'detroitcop'}
	},

	rank1 = {},

	rank2 = {},

	rank3 = {},

	rank4 = {},
	
	rank5 = {},
	
	rank6 = {},
	
	rank7 = {},
	
	rank8 = {},
	
	rank9 = {},
	
	rank10 = {},
	
	rank11 = {},
	

	boss = {
		{label = 'SWAT Ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'}
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
	rank1 = {
		male = {
			['tshirt_1'] = 59, ['tshirt_2'] = 1,
			['torso_1'] = 55, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25, ['pants_2'] = 2,
			['shoes_1'] = 25, ['shoes_2'] = 0,
			['helmet_1'] = 46, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = 2, ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36, ['tshirt_2'] = 1,
			['torso_1'] = 48, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34, ['pants_2'] = 0,
			['shoes_1'] = 27, ['shoes_2'] = 0,
			['helmet_1'] = 45, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = 2, ['ears_2'] = 0
		}
	},
	
	rank2 = {
		male = {
			['tshirt_1'] = 59, ['tshirt_2'] = 1,
			['torso_1'] = 55, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25, ['pants_2'] = 2,
			['shoes_1'] = 25, ['shoes_2'] = 0,
			['helmet_1'] = 46, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = 2, ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36, ['tshirt_2'] = 1,
			['torso_1'] = 48, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34, ['pants_2'] = 0,
			['shoes_1'] = 27, ['shoes_2'] = 0,
			['helmet_1'] = 45, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = 2, ['ears_2'] = 0
		}
	},
	
	rank3 = {
		male = {
			['tshirt_1'] = 59, ['tshirt_2'] = 1,
			['torso_1'] = 55, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25, ['pants_2'] = 2,
			['shoes_1'] = 25, ['shoes_2'] = 0,
			['helmet_1'] = 46, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = 2, ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36, ['tshirt_2'] = 1,
			['torso_1'] = 48, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34, ['pants_2'] = 0,
			['shoes_1'] = 27, ['shoes_2'] = 0,
			['helmet_1'] = 45, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = 2, ['ears_2'] = 0
		}
	},
	
	rank4 = {
		male = {
			['tshirt_1'] = 59, ['tshirt_2'] = 1,
			['torso_1'] = 55, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25, ['pants_2'] = 2,
			['shoes_1'] = 25, ['shoes_2'] = 0,
			['helmet_1'] = 46, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = 2, ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36, ['tshirt_2'] = 1,
			['torso_1'] = 48, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34, ['pants_2'] = 0,
			['shoes_1'] = 27, ['shoes_2'] = 0,
			['helmet_1'] = 45, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = 2, ['ears_2'] = 0
		}
	},
	rank5 = {
		male = {
			['tshirt_1'] = 59, ['tshirt_2'] = 1,
			['torso_1'] = 55, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25, ['pants_2'] = 2,
			['shoes_1'] = 25, ['shoes_2'] = 0,
			['helmet_1'] = 46, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = 2, ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36, ['tshirt_2'] = 1,
			['torso_1'] = 48, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34, ['pants_2'] = 0,
			['shoes_1'] = 27, ['shoes_2'] = 0,
			['helmet_1'] = 45, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = 2, ['ears_2'] = 0
		}
	},
	rank6	= {
		male = {
			['tshirt_1'] = 59, ['tshirt_2'] = 1,
			['torso_1'] = 55, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25, ['pants_2'] = 2,
			['shoes_1'] = 25, ['shoes_2'] = 0,
			['helmet_1'] = 46, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = 2, ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36, ['tshirt_2'] = 1,
			['torso_1'] = 48, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34, ['pants_2'] = 0,
			['shoes_1'] = 27, ['shoes_2'] = 0,
			['helmet_1'] = 45, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = 2, ['ears_2'] = 0
		}
	},
	rank7 = {
		male = {
			['tshirt_1'] = 59, ['tshirt_2'] = 1,
			['torso_1'] = 55, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25, ['pants_2'] = 2,
			['shoes_1'] = 25, ['shoes_2'] = 0,
			['helmet_1'] = 46, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = 2, ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36, ['tshirt_2'] = 1,
			['torso_1'] = 48, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34, ['pants_2'] = 0,
			['shoes_1'] = 27, ['shoes_2'] = 0,
			['helmet_1'] = 45, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = 2, ['ears_2'] = 0
		}
	},
	rank8 = {
		male = {
			['tshirt_1'] = 59, ['tshirt_2'] = 1,
			['torso_1'] = 55, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25, ['pants_2'] = 2,
			['shoes_1'] = 25, ['shoes_2'] = 0,
			['helmet_1'] = 46, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = 2, ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36, ['tshirt_2'] = 1,
			['torso_1'] = 48, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34, ['pants_2'] = 0,
			['shoes_1'] = 27, ['shoes_2'] = 0,
			['helmet_1'] = 45, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = 2, ['ears_2'] = 0
		}
	},

	rank9 = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	rank10 = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 1,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 1,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	rank11 = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 2,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	boss = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 3,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	bullet_wear = {
		male = {
			bproof_1 = 11,  bproof_2 = 1
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},

	gilet_wear = {
		male = {
			tshirt_1 = 59,  tshirt_2 = 1
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1
		}
	}
}
