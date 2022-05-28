barberShops = {
	{1932.07, 3729.67, 32.84},
	{-278.19, 6228.36, 31.69},
	{1211.99, -472.77, 66.20},
	{-33.22, -152.62, 57.07},
	{136.71, -1708.26, 29.29},
	{-815.18, -184.53, 37.56},
	{-1283.28, -1117.32, 6.99}
}

Citizen.CreateThread(function()
	exports["pw-polyzone"]:AddBoxZone("barber_shop", vector3(1932.07, 3729.67, 32.84), 5.2, 4.4, {
		heading=30,
		minZ=31.84,
		maxZ=33.84
	})

	exports["pw-polyzone"]:AddBoxZone("barber_shop", vector3(-278.19, 6228.36, 31.69), 5.2, 4.4, {
		heading=45,
		minZ=30.69,
		maxZ=32.69
	})

	exports["pw-polyzone"]:AddBoxZone("barber_shop", vector3(1211.99, -472.77, 66.20), 5.2, 4.4, {
		heading=75,
		minZ=65.20,
		maxZ=67.20
	})

	exports["pw-polyzone"]:AddBoxZone("barber_shop", vector3(-33.22, -152.62, 57.07), 5.2, 4.4, {
		heading=70,
		minZ=56.07,
		maxZ=58.07
	})

	exports["pw-polyzone"]:AddBoxZone("barber_shop", vector3(136.71, -1708.26, 29.29), 5.2, 4.4, {
		heading=50,
		minZ=28.29,
		maxZ=30.29
	})

	exports["pw-polyzone"]:AddBoxZone("barber_shop", vector3(-815.18, -184.53, 37.56), 5.2, 4.4, {
		heading=30,
		minZ=36.56,
		maxZ=38.56
	})

	exports["pw-polyzone"]:AddBoxZone("barber_shop", vector3(-1283.28, -1117.32, 6.99), 5.2, 4.4, {
		heading=0,
		minZ=5.99,
		maxZ=7.99
	})
end)
