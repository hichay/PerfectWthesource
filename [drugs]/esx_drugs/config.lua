Config = {}

Config.Locale = 'en'

Config.RequiredCops = 0


Config.Delays = {
	WeedProcessing = 1000 * 10,
	CoralProcessing = 1000 * 10,
	MushProcessing = 1500 * 10
}

Config.DrugDealerItems = {
	marijuana = math.random(2500,3500),
	weed = math.random(1000,1500),
	cokemush = math.random(3500,4800),
	coralsade = math.random(5000,6000),
	
	gold_nugget = math.random(100,300),
	gold_o = math.random(100,300),
	rough_diamond = math.random(30000,60000),
	raw_ore = math.random(50,100),
	coal = math.random(100,150),
	gold_bar = math.random(500,800),
	wood_rag = math.random(10,50)
}

Config.LicenseEnable = false -- enable processing licenses? The player will be required to buy a license in order to process drugs. Requires esx_license

Config.LicensePrices = {
	weed_processing = {label = _U('license_weed'), price = 15000}
}

Config.GiveBlack = true -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	WeedField = {coords = vector3(310.91, 4290.87, 45.15), name = _U('blip_weedfield'), color = 25, sprite = 496, radius = 100.0},
	--WeedField1 = {coords = vector3(-427.05, 1575.25, 357), name = _U('blip_weedfield1'), color = 25, sprite = 496, radius = 100.0},
	--WeedField2 = {coords = vector3(2213.05, 5576.25, 53), name = _U('blip_weedfield2'), color = 25, sprite = 496, radius = 100.0},
	
	MushField = {coords = vector3(3674.06, 4950.41, 17.21), name = _U('blip_mushfield'), color = 59, sprite = 514, radius = 75.0},
	
	
	-- WeedProcessing = {coords = vector3(2329.02, 2571.29, 46.68), name = _U('blip_weedprocessing'), color = 25, sprite = 496, radius = 100.0},
	-- MushProcessing = {coords = vector3(1093.82, -3196.67, -38.99), radius = 3.0},
	-- MushProcessing1 = {coords = vector3(1552.55, 2189.53,78.85), name = _U('blip_mushprocessing'), color = 59, sprite = 514, radius = 75.0},
	
	CoralField = {coords = vector3(51.16, 7434.79, -6.97), name = _U('blip_coralfield'), color = 50, sprite = 84, radius = 100.0},
	-- CoralProcessing1 = {coords = vector3(-1111.21, 4937.24, 218.39), name = _U('blip_coralprocessing'), color = 50, sprite = 84, radius = 75.0},
	-- CoralProcessing = {coords = vector3(1007.68, -3149.82, -38.99), radius = 3.0},

	--Coke
	--CokeField = {coords = vector3(-310.43, 2496.34, 76.60), name = _U('blip_CokeFarm'), color = 25, sprite = 496, radius = 20.0},	
	DrugDealer = {coords = vector3(-1172.02, -1571.98, 4.66), name = _U('blip_drugdealer'), color = 6, sprite = 378, radius = 25.0},
}