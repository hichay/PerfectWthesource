Config = {}

--[[ Config.Plates = {
    [1] = {
        coords = {x = 548.59448, y = -198.6144, z = 54.069728, h = 180.90824, r = 1.0},
        AttachedVehicle = nil,
    },
    [2] = {
        coords = {x = 541.38464, y = -189.2236, z = 54.069728, h = 90.910232, r = 1.0}, 
        AttachedVehicle = nil,
    },
    [3] = {
        coords = {x = 541.76208, y = -179.0891, z = 54.069728, h = 90.912063, r = 1.0}, 
        AttachedVehicle = nil,
    },
}
 ]]

Config.Locations = {
    --[[ ["exit"] = {x = 945.13, y = -975.84, z = 39.49, h = 181.5, r = 1.0}, ]]
    ["blip"] = {x = 545.58117, y = -185.6654, z = 54.477371, h = 6.1376714, r = 1.0},
    ["craft"] = {x = 546.38812, y = -166.7559, z = 54.493217, h = 6.1376714, r = 1.0},
    ["stash"] = {x = 549.289, y = -168.8657, z = 54.493202, h = 303.12374, r = 1.0},
	["duty"] = {x = 550.24755, y = -182.2433, z = 54.493213, h = 356.65, r = 1.0},
    ["vehicle"] = {x = 542.17059, y = -208.7623, z = 53.803546, h = 178.25463, r = 1.0}, 
	["boss"] = {x = 544.07586, y = -200.2357, z = 54.493202, h = 137.32397, r = 1.0},
}

Config.Customs = { -- Multiple Shop Start
	['DC Mechanic'] = { -- Shop id -- Custom Map Tuner Garage (2372 Build only, canary and release) IPL and Int https://forum.cfx.re/t/free-mlo-tuner-auto-shop/4247145
		job = 'mechanic', -- job name permmision for this shop
		min_grade = 0, -- min grade to access the whole shop feature
		radius = 50, -- radius for whole shop
		craft1 = {coord = vector3(-585.2318, -939.3886, 23.886636), grade = 0, radius = 1.50, options = {useZ = true}, invid = 28},
        craft2 = {coord = vector3(-582.988, -939.4266, 23.886636), grade = 0, radius = 1.50, options = {useZ = true}, invid = 27},
        bossmenu = {coord = vector3(-604.3624, -919.5223, 24.086611), grade = 3, radius= 2.00, options = {useZ = true}},
        stashinventory = {coord = vector3(-590.0542, -938.658, 28.803863), grade = 1, radius= 1.50, options = {useZ = true}},
        vehiclespawn = {coord = vector3(-557.9152, -895.6645, 24.571266), heading = 186.27},
		shopcoord = vector3(-585.9445, -928.9171, 23.886632),
		attachvehicle = {
			{coord = vector4(-582.9814, -931.7739, 23.514331, 89.509414), AttachedVehicle = false},
			{coord = vector4(-582.9095, -924.6557, 23.51313, 89.566967), AttachedVehicle = false},
			{coord = vector4(-582.5108, -917.5194, 23.577745, 271.07107), AttachedVehicle = false},
		},
		Blips = {sprite = 446, color = 46, scale = 1.0},
    },

}

Config.Vehicles = {
    ["flatbed"] = "Flatbed",
    ["towtruck"] = "Towtruck"
}


