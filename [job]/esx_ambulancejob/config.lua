Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}

Config.ReviveReward               = 100  -- revive reward, set to 0 if you don't want it enabled
Config.Hoisinhcommand               = 500
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

Config.EarlyRespawnTimer          = 60000 * 60 -- time til respawn is available
Config.BleedoutTimer              = 60000 * 60 -- time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true
Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society
Config.EnableESXService           = false -- enable esx service?

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = {coords = vector3(312.31, -591.6, 43.28), heading = 60.74}

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(298.84, -584.7, 43.26),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(299.08, -598.21, 42.28)
		},

		Pharmacies = {
			vector3(310.39, -566.35, 42.28)
		},

		Vehicles = {
			{
				Spawner = vector3(292.96, -600.38, 43.3),
				InsideShop = vector3(295.08, -621.23, 47.9),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(295.32, -605.68, 43.1), heading = 70.19, radius = 4.0},
					{coords = vector3(293.77, -610.5, 43.14), heading = 70.19, radius = 4.0},
					{coords = vector3(292.31, -614.55, 43.18), heading = 70.19, radius = 6.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(340.5, -588.85, 74.17),
				InsideShop = vector3(314.73, -576.33, 94.48),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(356.35, -585.6, 75.18), heading = 35.82, radius = 10.0},
					{coords = vector3(349.59, -594.5, 75.18), heading = 226.78, radius = 10.0}
				}
			}
		},

		FastTravels = {
			
			{
				From = vector3(247.3, -1371.5, 23.5),
				To = {coords = vector3(333.1, -1434.9, 45.5), heading = 138.6},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(335.5, -1432.0, 45.50),
				To = {coords = vector3(249.1, -1369.6, 23.5), heading = 0.0},
				Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(234.5, -1373.7, 20.9),
				To = {coords = vector3(320.9, -1478.6, 28.8), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(317.9, -1476.1, 28.9),
				To = {coords = vector3(238.6, -1368.4, 23.5), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false}
			}
		},

		FastTravelsPrompt = {
			{
				From = vector3(331.62, -595.54, 42.28), -- len
				To = {coords = vector3(340.03, -584.27, 73.17), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(340.03, -584.27, 73.17), -- xuong
				To = {coords = vector3(331.62, -595.54, 42.28), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = _U('fast_travel')
			}
		}

	},
	
	SandyEMS = {

		Blip = {
			coords = vector3(1824.8369, 3671.7902, 34.271053),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},
		
		AmbulanceActions = {
			vector3(1834.3771, 3690.937, 34.270637)
		},

		Pharmacies = {
			vector3(1825.5255, 3667.279, 34.271049)
		},

		Vehicles = {
			{
				Spawner = vector3(1844.3243, 3672.6337, 33.679733),
				InsideShop = vector3(295.08, -621.23, 47.9),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(1836.7448, 3662.4667, 33.662857), heading = 210.39, radius = 4.0},
					{coords = vector3(1833.2552, 3660.5144, 33.715946), heading = 210.39, radius = 4.0},
					{coords = vector3(1829.8278, 3658.2255, 33.770534), heading = 210.39, radius = 6.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(340.5, -588.85, 74.17),
				InsideShop = vector3(314.73, -576.33, 94.48),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(356.35, -585.6, 75.18), heading = 35.82, radius = 10.0},
					{coords = vector3(349.59, -594.5, 75.18), heading = 226.78, radius = 10.0}
				}
			}
		},

		FastTravels = {
			
			{
				From = vector3(247.3, -1371.5, 23.5),
				To = {coords = vector3(333.1, -1434.9, 45.5), heading = 138.6},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(335.5, -1432.0, 45.50),
				To = {coords = vector3(249.1, -1369.6, 23.5), heading = 0.0},
				Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(234.5, -1373.7, 20.9),
				To = {coords = vector3(320.9, -1478.6, 28.8), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(317.9, -1476.1, 28.9),
				To = {coords = vector3(238.6, -1368.4, 23.5), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false}
			}
		},

		FastTravelsPrompt = {
			{
				From = vector3(331.62, -595.54, 42.28), -- len
				To = {coords = vector3(340.03, -584.27, 73.17), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(340.03, -584.27, 73.17), -- xuong
				To = {coords = vector3(331.62, -595.54, 42.28), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = _U('fast_travel')
			}
		}

	}
}

Config.AuthorizedVehicles = {
	car = {
		rank1 = {
			{model = 'ambulance', price = 100},
			{model = '20ramambo', price = 100}
		},

		rank2 = {
			{model = 'ambulance', price = 100},
			{model = '20ramambo', price = 100}
		},

		rank3 = {
			{model = 'ambulance', price = 100},
			{model = '20ramambo', price = 100}
		},

		rank4 = {
			{model = 'ambulance', price = 100},
			{model = '20ramambo', price = 100}
		},
		
		rank5 = {
			{model = 'ambulance', price = 100},
			{model = '20ramambo', price = 100}
		},

		rank6 = {
			{model = 'ambulance', price = 100},
			{model = '20ramambo', price = 100}
		},

		rank7 = {
			{model = 'ambulance', price = 100},
			{model = '20ramambo', price = 100}
		},

		boss = {
			{model = 'ambulance', price = 100},
			{model = '20ramambo', price = 100}
		}
	},

	helicopter = {
		
		boss = {
			{model = 'buzzard2', price = 1500000},
			{model = 'seasparrow', price = 3000000}
		}
	}
}
