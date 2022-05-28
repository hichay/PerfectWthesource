
clothingshop = {
	{1693.69, 4822.86, 42.06},
	{-709.85, -153.08, 37.41},
	{-1192.81, -768.41, 17.31},
    {424.96, -806.24, 29.49},
    {-162.63, -303.03, 39.73},
	{75.43, -1392.95, 29.37},
	{-822.35, -1073.73, 11.32},
	{-1450.57, -237.63, 49.81},
	{4.39, 6512.80, 31.87},
	{614.29, 2762.54, 42.08},
	{1196.47, 2710.16, 38.22},
	{-3170.60, 1043.77, 20.86},
	{-1101.52, 2710.40, 19.10},
	{125.69, -223.86, 54.55},
	}

Citizen.CreateThread(function()
	exports["pw-polyzone"]:AddBoxZone("clothing_shop", vector3(1693.69, 4822.86, 42.06), 5.2, 4.4, {
		heading=8,
		minZ=40.06,
		maxZ=43.06
	})

	exports["pw-polyzone"]:AddBoxZone("clothing_shop", vector3(-709.85, -153.08, 37.41), 5.2, 4.4, {
		heading=30,
		minZ=36.41,
		maxZ=38.41 
	})

	exports["pw-polyzone"]:AddBoxZone("clothing_shop", vector3(-1192.81, -768.41, 17.31), 5.2, 4.4, {
		heading=35,
		minZ=16.31,
		maxZ=18.31 
	})

	exports["pw-polyzone"]:AddBoxZone("clothing_shop", vector3(424.96, -806.24, 29.49), 5.2, 4.4, {
		heading=0,
		minZ=28.49,
		maxZ=30.49
	})

	exports["pw-polyzone"]:AddBoxZone("clothing_shop", vector3(-162.63, -303.03, 39.73), 5.2, 4.4, {
		heading=340,
		minZ=38.73,
		maxZ=40.73
	})

	exports["pw-polyzone"]:AddBoxZone("clothing_shop", vector3(75.43, -1392.95, 29.37), 5.2, 4.4, {
		heading=0,
		minZ=28.37,
		maxZ=30.37
	})

	exports["pw-polyzone"]:AddBoxZone("clothing_shop", vector3(-822.35, -1073.73, 11.32), 5.2, 4.4, {
		heading=30,
		minZ=10.32,
		maxZ=12.32
	})

	exports["pw-polyzone"]:AddBoxZone("clothing_shop", vector3(-1450.57, -237.63, 49.81), 5.2, 4.4, {
		heading=319,
		minZ=48.81,
		maxZ=50.81
	})

	exports["pw-polyzone"]:AddBoxZone("clothing_shop", vector3(4.39, 6512.80, 31.87), 5.2, 4.4, {
		heading=315,
		minZ=30.87,
		maxZ=32.87
	})

	exports["pw-polyzone"]:AddBoxZone("clothing_shop", vector3(614.29, 2762.54, 42.08), 5.2, 4.4, {
		heading=3,
		minZ=41.08,
		maxZ=43.08
	})

	exports["pw-polyzone"]:AddBoxZone("clothing_shop", vector3(1196.47, 2710.16, 38.22), 5.2, 4.4, {
		heading=0,
		minZ=36.22,
		maxZ=39.22
	})

	exports["pw-polyzone"]:AddBoxZone("clothing_shop", vector3(-3170.60, 1043.77, 20.86), 5.2, 4.4, {
		heading=335,
		minZ=19.86,
		maxZ=21.86
	})

	exports["pw-polyzone"]:AddBoxZone("clothing_shop", vector3(-1101.52, 2710.40, 19.10), 5.2, 4.4, {
		heading=43,
		minZ=18.10,
		maxZ=20.10
	})

	exports["pw-polyzone"]:AddBoxZone("clothing_shop", vector3(125.69, -223.86, 54.55), 5.2, 4.4, {
		heading=340,
		minZ=53.55,
		maxZ=55.55
	})
	end)
