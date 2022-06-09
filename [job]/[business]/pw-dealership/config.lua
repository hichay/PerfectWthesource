Config = {}

Config.webhook = ""						-- Webhook to send logs to discord
Config.lang = "en"								-- Set the file language [en/br]

Config.Framework = {									-- ESX/QB settings, if you are using vRP just ignore
	['SHAREDOBJECT'] = "Framework:GetObject",	-- Change your getshared object event here, in case you are using anti-cheat
	['account_dealership'] = 'bank',			-- Change here the account that should be used with dealership expenses
	['account_customers'] = 'bank',				-- Change here the account that the money should be debited when buying vehicles in the dealership
}

Config.format = {
	['currency'] = 'USD',						-- This is the currency format, so that your currency symbol appears correctly [Examples: BRL, USD]
	['location'] = 'en-US'						-- This is the location of your country, to format the decimal places according to your standard [Examples: pt-BR, en-US]
}
Config.default_stock = 10						-- Stock when the dealership has no owner (set as false to use the values from dealership_stock, if this is not false the dealership_stock table is useless)
Config.max_dealerships_per_player = 1			-- Maximum number of dealerships that each player can have
Config.PlateFormat = 'xxxxxxxx'					-- Plate generation format (n = number | l = letter | x = any)

Config.sell_vehicles = {
	['sell_without_owner'] = true,				-- true: will allow players to intantly sell vehicles to a dealership that has no owner | false: players will only be able to sell vehicle when has owner
	['percentage'] = 0.7						-- Percentage of the vehicle sell value (0.7 = 70%)
}

-- Here are the places where the person can open the dealership menu
-- You can add as many locations as you want, just use the location already created as an example
Config.dealership_locations = {
	["dealer_1"] = {															-- ID
		['buy_price'] = 10,													-- Price to buy this dealership
		['sell_price'] = 0,												-- Price to sell this dealership
		['coord'] = {-782.833, -211.0625, 37.152732},									-- Coordinate to open the menu
		['truck_coord'] = {-780.39,-195.95,37.28,212.62},				-- Garage coordinates, where the trucks will spawn (coordinates composed of x, y, z, h)
		['trailer_coord'] = {-792.12,-175.69,37.28,206.94},						-- Garage coordinates, where the trailers will spawn (coordinates composed of x, y, z, h)
		['test_drive'] = {
			['teleport'] = true,												-- If set true, when starting a test drive you'll be teleported to the coord below. Else, the car will just be unfreezed
			['test_drive_coord'] = {-758.09,-235.68,37.28,208.64},				-- Coordinates where player will teleport when start a test drive
			['test_drive_time'] = 35											-- Time in seconds the test drive will last
		},
		['truck_name'] = "hauler",												-- Truck spawn name
		['trailer'] = {															-- Trailers spawn name
			['empty'] = "tr2",
			['full'] = "tr4",
		},
		['cutomers_garage_coord'] = {-773.96,-234.34,37.15,209.38},				-- Customers garage coordinates, where the bought vehicles will spawn (coordinates composed of x, y, z, h)
		['sell_blip_coords'] = {												-- The coordinates where customers will buy things on this dealership (coordinates composed of x, y, z)
			{
				['dealer'] = {-789.51, -210.61, 37.0}, --- vi tri doi xe
				['preview'] = {-788.01, -207.28, 37.117, 119.26}  --- vi tri xe xuat hien de xem
			},
			{
				['dealer'] = {-799.50, -217.1016, 37.0}, --- vi tri doi xe
				['preview'] = {-803.64, -214.42, 37.05}  --- vi tri xe xuat hien de xem
			},
			
			{
				['dealer'] = {-795.191, -224.5611, 37.0},
				['preview'] = {-795.47, -228.51, 37.07} 
			},
			
			{
				['dealer'] = {-791.2497, -231.4036, 37.0},
				['preview'] = {-791.06, -235.97, 37.07} 
			},

			{
				['dealer'] = {-786.8943, -238.8792, 37.0},
				['preview'] = {-786.73, -242.72, 37.07}
			}
		},
		['type'] = 'cpg_dealer',			 									-- Insert here the dealership type ID
	},
	--[[ ["dealer_2"] = {
		['buy_price'] = 100000000000000000,
		['sell_price'] = 0,
		['coord'] = {1221.03, 2738.74, 38.01},
		['truck_coord'] = {1241.96,2705.5,38.01,181.3},
		['trailer_coord'] = {1248.68,2708.2,38.01,181.22},
		['test_drive'] = {
			['teleport'] = true,
			['test_drive_coord'] = {1249.53,2706.27,38.01,184.25},
			['test_drive_time'] = 15
		},
		['truck_name'] = "hauler",
		['trailer'] = {
			['empty'] = "tr2",
			['full'] = "tr4",
		},
		['cutomers_garage_coord'] = {1243.7,2715.81,38.01,187.22},
		['sell_blip_coords'] = {
			{
				['dealer'] = {1220.51, 2715.75, 38.01},
				['preview'] = {1216.21,2710.88,38.02,270.58}
			},
			{
				['dealer'] = {1230.6, 2715.54, 38.01},
				['preview'] = {1234.72,2711.05,38.02,90.73}
			}
		},
		['type'] = 'Xe_thung',
	},
	["dealer_3"] = {
		['buy_price'] = 100000000000000000,
		['sell_price'] = 0,
		['coord'] = {-30.86, -1106.64, 26.42}, --
		['truck_coord'] = {-17.91,-1109.77,26.67,157.12}, --
		['trailer_coord'] = {-13.57,-1091.29,26.67,159.63}, --
		['test_drive'] = {
			['teleport'] = true,
			['test_drive_coord'] = {-30.91,-1090.46,26.42,339.49}, --
			['test_drive_time'] = 30
		},
		['truck_name'] = "hauler",
		['trailer'] = {
			['empty'] = "tr2",
			['full'] = "tr4",
		},
		['cutomers_garage_coord'] = {-54.65,-1109.08,26.44,69.24},
		['sell_blip_coords'] = {
			{
				['dealer'] = {-46.25, -1095.28, 26.42},
				['preview'] = {-50.69,-1093.64,26.02,148.24}
			},
			{
				['dealer'] = {-38.7, -1097.83, 26.42},
				['preview'] = {-41.71,-1099.58,26.42,96.79}
			}
		},
		['type'] = 'main_dealer',
	},
	["dealer_4"] = {
		['buy_price'] = 100000000000000000,
		['sell_price'] = 0,
		['coord'] = {-913.74, -226.88, 39.91},
		['truck_coord'] = {-865.81,-233.5,39.55,204.08},
		['trailer_coord'] = {-875.56,-214.78,39.24,205.58},
		['test_drive'] = {
			['teleport'] = true,
			['test_drive_coord'] = {-900.15,-235.14,39.91,153.61},
			['test_drive_time'] = 20
		},
		['truck_name'] = "hauler",
		['trailer'] = {
			['empty'] = "tr2",
			['full'] = "tr4",
		},
		['cutomers_garage_coord'] = {-900.15,-235.14,39.91,153.61},
		['sell_blip_coords'] = {
			{
				['dealer'] = {-906.83, -230.6, 39.91},
				['preview'] = {-904.91,-227.45,39.95,146.36}
			},
			{
				['dealer'] = {-899.25, -234.75, 39.91},
				['preview'] = {-896.74,-232.74,39.95,126.55}
			},
			{
				['dealer'] = {-902.7, -232.56, 39.91},
				['preview'] = {-901.34,-229.81,39.95,150.81}
			}
		},
		['type'] = 'Bikes_dealer',
	}, ]]
}

-- Here you configure each type of dealership available to buy
Config.dealership_types = {
	['cpg_dealer'] = {								-- Dealership type ID
		['stock_capacity'] = 150,					-- Max stock capacity
		['max_employees'] = 5,						-- Max employees
		['vehicles'] = 										-- Here you configure the vehicles on this dealership
			--SUV
			{
			['patriot'] = {							-- Tên gọi xe
				['name'] = "Patriot",					-- Tên xe
				['price_to_customer'] = 36750,		-- Giá khách hàng mua xe
				['price_to_owner'] = 35000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974678502123143198/patriot.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 0						-- Set on which page this vehicle will appear
			},
			['dubsta'] = {							-- Tên gọi xe
				['name'] = "Dubsta Luxuary",					-- Tên xe
				['price_to_customer'] = 58800,		-- Giá khách hàng mua xe
				['price_to_owner'] = 56,000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 80000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://www.gtabase.com/images/jch-optimize/ng/images_gta-5_vehicles_suvs_main_dubsta.webp',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 0						-- Set on which page this vehicle will appear
			},	
			['toros'] = {							-- Tên gọi xe
				['name'] = "Toros",					-- Tên xe
				['price_to_customer'] = 70000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 66500,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 80000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://www.gtabase.com/images/jch-optimize/ng/images_gta-5_vehicles_suvs_main_toros.webp',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 0						-- Set on which page this vehicle will appear
			},	
			['contender'] = {							-- Tên gọi xe
				['name'] = "Contender",					-- Tên xe
				['price_to_customer'] = 68800,		-- Giá khách hàng mua xe
				['price_to_owner'] = 56000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 80000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://www.gtabase.com/images/jch-optimize/ng/images_gta-5_vehicles_suvs_main_contender.webp',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 0						-- Set on which page this vehicle will appear
			},				
			--motocycle
			['sanchez2'] = {
				['name'] = "Sanchez",
	 			['price_to_customer'] = 24500,
	 			['price_to_owner'] = 23000,
				['price_to_export'] = 5000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974710145252728852/sanchez2.png',
	 			['page'] = 1
	 		},
			 ['bf400'] = {
				['name'] = "Nagasaki BF400",
	 			['price_to_customer'] = 31500,
	 			['price_to_owner'] = 29000,
				['price_to_export'] = 5000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://www.gtabase.com/images/gta-5/vehicles/motorcycles/main/bf400.jpg',
	 			['page'] = 1
	 		},
			 --Vans
			['bison'] = {							-- Tên gọi xe
				['name'] = "Bison",					-- Tên xe
				['price_to_customer'] = 35000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 315000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974706453824831529/bison.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 2						-- Set on which page this vehicle will appear
			},	
			['bison'] = {							-- Tên gọi xe
				['name'] = "Bison",					-- Tên xe
				['price_to_customer'] = 42000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 39000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://www.gtabase.com/images/jch-optimize/ng/images_gta-5_vehicles_vans_main_bison.webp',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 2						-- Set on which page this vehicle will appear
			},	
		 	--Off Road
			['everon'] = {							-- Tên gọi xe
				['name'] = "Everon",					-- Tên xe
				['price_to_customer'] = 49000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 46000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://www.gtabase.com/images/jch-optimize/ng/images_gta-5_vehicles_off-road_main_everon.webp',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 3						-- Set on which page this vehicle will appear
			},	
			['kamacho'] = {							-- Tên gọi xe
				['name'] = "Kamacho",					-- Tên xe
				['price_to_customer'] = 56000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 53000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://www.gtabase.com/images/jch-optimize/ng/images_gta-5_vehicles_off-road_main_kamacho.webp',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 3						-- Set on which page this vehicle will appear
			},	
			['caracara2'] = {							-- Tên gọi xe
				['name'] = "Caracara2",					-- Tên xe
				['price_to_customer'] = 70000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 66500,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://www.gtabase.com/images/jch-optimize/ng/images_gta-5_vehicles_off-road_main_caracara-4x4.webp',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 3						-- Set on which page this vehicle will appear
			},
			['reaper'] = {
				['name'] = "Pegassi Reaper",
	 			['price_to_customer'] = 105000,
	 			['price_to_owner'] = 98000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://www.gtabase.com/images/jch-optimize/ng/images_gta-5_vehicles_super_main_reaper.webp',
	 			['page'] = 3
	 		},	
			 --sport
			['coquette4'] = {							-- Tên gọi xe
				['name'] = "Coquette D10",					-- Tên xe
				['price_to_customer'] = 105000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 98000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://www.gtabase.com/images/jch-optimize/ng/images_gta-5_vehicles_sports_main_coquette-d10.webp',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 4						-- Set on which page this vehicle will appear
			},	
			['neon'] = {
				['name'] = "Neon",
	 			['price_to_customer'] = 129000,
	 			['price_to_owner'] = 122000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974695747129856010/neon.png',
	 			['page'] = 4
	 		},
			['ruston'] = {
				['name'] = "Ruston",
	 			['price_to_customer'] = 115000,
	 			['price_to_owner'] = 105000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974690502387585057/ruston.png',
	 			['page'] = 4
	 		},
			['cypher'] = {
				['name'] = "Übermacht Cypher",
	 			['price_to_customer'] = 91000,
	 			['price_to_owner'] = 85000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://www.gtabase.com/images/jch-optimize/ng/images_gta-5_vehicles_sports_main_cypher.webp',
	 			['page'] = 4
	 		},
			 --super
			['italirsx'] = {
				['name'] = "Itali RSX",
	 			['price_to_customer'] = 210000,
	 			['price_to_owner'] = 199000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://www.gtabase.com/images/jch-optimize/ng/images_gta-5_vehicles_sports_main_itali-rsx.webp',
	 			['page'] = 5
	 		},
			['tyrant'] = {
				['name'] = "Overflod Tyrant",
	 			['price_to_customer'] = 245000,
	 			['price_to_owner'] = 230000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://www.gtabase.com/images/jch-optimize/ng/images_gta-5_vehicles_super_main_tyrant.webp',
	 			['page'] = 5
	 		},
			['emerus'] = {
				['name'] = "Progen Emerus",
	 			['price_to_customer'] = 280000,
	 			['price_to_owner'] = 266000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://www.gtabase.com/images/jch-optimize/ng/images_gta-5_vehicles_super_main_emerus.webp',
	 			['page'] = 5
	 		},
			['furia'] = {
				['name'] = "Grotti Furia",
	 			['price_to_customer'] = 210000,
	 			['price_to_owner'] = 199000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://www.gtabase.com/images/jch-optimize/ng/images_gta-5_vehicles_super_main_furia.webp',
	 			['page'] = 5
	 		},
			['nero2'] = {
				['name'] = "Truffade Nero Custom",
	 			['price_to_customer'] = 336000,
	 			['price_to_owner'] = 315000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://www.gtabase.com/images/jch-optimize/ng/images_gta-5_vehicles_super_main_nero-custom.webp',
	 			['page'] = 5
	 		},
	},	
	['pagination'] = {
		[0] = "SUV",
		[1] = "Motorcycles",
		[2] = "Vans",
		[3] = "Off-road",
		[4] = "Sports", 
		[5] = "Super",

	},
	['blips'] = {
		['id'] = 669,
		['name'] = "~r~Cypher Gang",
		['color'] = 3,
		['scale'] = 1.0,
	}
},	
	
	['main_dealer'] = {								-- Dealership type ID
		['stock_capacity'] = 150,					-- Max stock capacity
		['max_employees'] = 5,						-- Max employees
		['vehicles'] = {							-- Here you configure the vehicles on this dealership
			['panto'] = {							-- Tên gọi xe
				['name'] = "Panto",					-- Tên xe
				['price_to_customer'] = 8500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 3000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974667436911648828/panto.png',	-- Thay hình = tên gọi xe trước .png
				['page'] = 4						-- Set on which page this vehicle will appear
			},	
			['blade'] = {							-- Tên gọi xe
				['name'] = "Blade",					-- Tên xe
				['price_to_customer'] = 19500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 10000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974667992006787152/blade.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['buccaneer'] = {							-- Tên gọi xe
				['name'] = "buccaneer",					-- Tên xe
				['price_to_customer'] = 19500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 10000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 5000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974668424972234783/buccaneer.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['buccaneer2'] = {							-- Tên gọi xe
				['name'] = "Buccaneer Rider",					-- Tên xe
				['price_to_customer'] = 22500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 10000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 5000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974668849926516806/buccaneer2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['chino'] = {							-- Tên gọi xe
				['name'] = "Chino",					-- Tên xe
				['price_to_customer'] = 20000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 10000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 5000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974669027899236362/chino.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['chino2'] = {							-- Tên gọi xe
				['name'] = "Chino Luxe",					-- Tên xe
				['price_to_customer'] = 35000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 28000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 25000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974669176415342652/chino2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['coquette3'] = {							-- Tên gọi xe
				['name'] = "Coquette BlackFin",					-- Tên xe
				['price_to_customer'] = 45000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 35000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 25000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974669384989671464/coquette3.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['dominator'] = {							-- Tên gọi xe
				['name'] = "Dominator",					-- Tên xe
				['price_to_customer'] = 53000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 45000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 25000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974669727689498664/dominator.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['dukes'] = {							-- Tên gọi xe
				['name'] = "Dukes",					-- Tên xe
				['price_to_customer'] = 15000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 9000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 1000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974669915657216030/dukes.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['gauntlet'] = {							-- Tên gọi xe
				['name'] = "Gauntlet",					-- Tên xe
				['price_to_customer'] = 39500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 28000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 25000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974670127050129438/gauntlet.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['hotknife'] = {							-- Tên gọi xe
				['name'] = "Hotknife",					-- Tên xe
				['price_to_customer'] = 95000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 85000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 80000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974670320248184892/Hotknife.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['faction'] = {							-- Tên gọi xe
				['name'] = "Faction",					-- Tên xe
				['price_to_customer'] = 20000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 10000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 5000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974670542516924417/faction.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['faction2'] = {							-- Tên gọi xe
				['name'] = "Faction Rider",					-- Tên xe
				['price_to_customer'] = 22500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 10000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 5000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974670685077127168/faction2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['nightshade'] = {							-- Tên gọi xe
				['name'] = "Nightshade",					-- Tên xe
				['price_to_customer'] = 84000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 75000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 60000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974670897396977684/nightshade.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['phoenix'] = {							-- Tên gọi xe
				['name'] = "Phoenix",					-- Tên xe
				['price_to_customer'] = 25000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 12000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974671093178703953/phoenix.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['picador'] = {							-- Tên gọi xe
				['name'] = "Picador",					-- Tên xe
				['price_to_customer'] = 18000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 8000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 800,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974671242105876480/picador.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['sabregt'] = {							-- Tên gọi xe
				['name'] = "Sabre GT",					-- Tên xe
				['price_to_customer'] = 29500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 20000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 10000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974671429792583710/sabregt.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['slamvan3'] = {							-- Tên gọi xe
				['name'] = "Slam Van",					-- Tên xe
				['price_to_customer'] = 35000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 25000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974671684483301446/slamvan3.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['tampa'] = {							-- Tên gọi xe
				['name'] = "Tampa",					-- Tên xe
				['price_to_customer'] = 27500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 15000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974671989346287626/tampa.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['tampa2'] = {							-- Tên gọi xe
				['name'] = "Drift Tampa",					-- Tên xe
				['price_to_customer'] = 50500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 40000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974672192237342790/tampa2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['virgo'] = {							-- Tên gọi xe
				['name'] = "Virgo",					-- Tên xe
				['price_to_customer'] = 19700,		-- Giá khách hàng mua xe
				['price_to_owner'] = 10000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974672395585601636/virgo.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['vigero'] = {							-- Tên gọi xe
				['name'] = "Vigero",					-- Tên xe
				['price_to_customer'] = 16500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 9000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974672944666128485/Vigero.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['voodoo'] = {							-- Tên gọi xe
				['name'] = "Voodoo",					-- Tên xe
				['price_to_customer'] = 21000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 15000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974673167329153084/voodoo.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6						-- Set on which page this vehicle will appear
			},			
			['blista'] = {							-- Tên gọi xe
				['name'] = "Blista",					-- Tên xe
				['price_to_customer'] = 8000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 3000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974673440458039356/blista.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 4						-- Set on which page this vehicle will appear
			},			
			['brioso'] = {							-- Tên gọi xe
				['name'] = "Brioso R/A",					-- Tên xe
				['price_to_customer'] = 14500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 9000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974673704401387592/brioso.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 4					-- Set on which page this vehicle will appear
			},			
			['issi2'] = {							-- Tên gọi xe
				['name'] = "issi",					-- Tên xe
				['price_to_customer'] = 12000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 8000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 3000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974673926431068200/issi2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 4						-- Set on which page this vehicle will appear
			},			
			['prairie'] = {							-- Tên gọi xe
				['name'] = "Prairie",					-- Tên xe
				['price_to_customer'] = 15000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 8000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 5000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974674167620309033/prairie.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 4						-- Set on which page this vehicle will appear
			},			
					
			['asea'] = {							-- Tên gọi xe
				['name'] = "Asea",					-- Tên xe
				['price_to_customer'] = 13000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 8000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 7000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974674330984284200/asea.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 3						-- Set on which page this vehicle will appear
			},			
			['cognoscenti'] = {							-- Tên gọi xe
				['name'] = "Cognoscenti",					-- Tên xe
				['price_to_customer'] = 40000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 30000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974674550178586674/cognoscenti.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 3						-- Set on which page this vehicle will appear
			},			
			['emperor'] = {							-- Tên gọi xe
				['name'] = "Emperor",					-- Tên xe
				['price_to_customer'] = 14500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 8000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 7000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974674739819864104/emperor.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 3						-- Set on which page this vehicle will appear
			},			
			['fugitive'] = {							-- Tên gọi xe
				['name'] = "Fugitive",					-- Tên xe
				['price_to_customer'] = 22500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 15000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974675083576635432/fugitive.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 3						-- Set on which page this vehicle will appear
			},			
			['glendale'] = {							-- Tên gọi xe
				['name'] = "Glendale",					-- Tên xe
				['price_to_customer'] = 11500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 5000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 4000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974675280209784882/glendale.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 3						-- Set on which page this vehicle will appear
			},			
			['intruder'] = {							-- Tên gọi xe
				['name'] = "Intruder",					-- Tên xe
				['price_to_customer'] = 15000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 10000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 9000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974675590420508702/intruder.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 3						-- Set on which page this vehicle will appear
			},			
			['premier'] = {							-- Tên gọi xe
				['name'] = "Premier",					-- Tên xe
				['price_to_customer'] = 16500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 8000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 7000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974675824286511124/premier.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 3						-- Set on which page this vehicle will appear
			},			
			['primo2'] = {							-- Tên gọi xe
				['name'] = "Primo Custom",					-- Tên xe
				['price_to_customer'] = 14500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 8000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 7000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974676024891703386/primo2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 3						-- Set on which page this vehicle will appear
			},			
			['regina'] = {							-- Tên gọi xe
				['name'] = "Regina",					-- Tên xe
				['price_to_customer'] = 10000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 8000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 7000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974676180500353104/regina.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 3						-- Set on which page this vehicle will appear
			},			
			['schafter2'] = {							-- Tên gọi xe
				['name'] = "Schafter",					-- Tên xe
				['price_to_customer'] = 32000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 25000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974676358724747294/schafter2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 3						-- Set on which page this vehicle will appear
			},			
			['tailgater'] = {							-- Tên gọi xe
				['name'] = "Tailgater",					-- Tên xe
				['price_to_customer'] = 45000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 35000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974676614514368542/tailgater.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 3						-- Set on which page this vehicle will appear
			},			
			['washington'] = {							-- Tên gọi xe
				['name'] = "Washington",					-- Tên xe
				['price_to_customer'] = 19000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 9000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974676774791282789/washington.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 3						-- Set on which page this vehicle will appear
			},			
			['baller2'] = {							-- Tên gọi xe
				['name'] = "Baller",					-- Tên xe
				['price_to_customer'] = 79000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 69000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974676967557304370/baller2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 2						-- Set on which page this vehicle will appear
			},			
			['cavalcade2'] = {							-- Tên gọi xe
				['name'] = "Cavalcade",					-- Tên xe
				['price_to_customer'] = 45000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 35000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974677166371532850/cavalcade2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 2						-- Set on which page this vehicle will appear
			},			
			['dubsta2'] = {							-- Tên gọi xe
				['name'] = "Dubsta Luxuary",					-- Tên xe
				['price_to_customer'] = 165000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 150000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 80000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974677359829610536/dubsta2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 2						-- Set on which page this vehicle will appear
			},			
			['fq2'] = {							-- Tên gọi xe
				['name'] = "FQ2",					-- Tên xe
				['price_to_customer'] = 38000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 25000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974677582622625802/fq2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 2						-- Set on which page this vehicle will appear
			},			
			['granger'] = {							-- Tên gọi xe
				['name'] = "Granger",					-- Tên xe
				['price_to_customer'] = 43500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 35000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974677735148486676/granger.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 2						-- Set on which page this vehicle will appear
			},			
			['gresley'] = {							-- Tên gọi xe
				['name'] = "Gresley",					-- Tên xe
				['price_to_customer'] = 47000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 30000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974677960672026677/gresley.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 2						-- Set on which page this vehicle will appear
			},			
			['huntley'] = {							-- Tên gọi xe
				['name'] = "Huntley S",					-- Tên xe
				['price_to_customer'] = 85000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 75000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974678098756923473/huntley.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 2						-- Set on which page this vehicle will appear
			},			
			['landstalker'] = {							-- Tên gọi xe
				['name'] = "Landstalker",					-- Tên xe
				['price_to_customer'] = 27000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 18000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974678341506433104/landstalker.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 2						-- Set on which page this vehicle will appear
			},			
			['patriot'] = {							-- Tên gọi xe
				['name'] = "Patriot",					-- Tên xe
				['price_to_customer'] = 32000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 15000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974678502123143198/patriot.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 2						-- Set on which page this vehicle will appear
			},			
			['radi'] = {							-- Tên gọi xe
				['name'] = "Radius",					-- Tên xe
				['price_to_customer'] = 24000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 15000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974678637792088124/radi.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 2						-- Set on which page this vehicle will appear
			},			
			['rocoto'] = {							-- Tên gọi xe
				['name'] = "Rocoto",					-- Tên xe
				['price_to_customer'] = 48500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 35000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974678919624130610/rocoto.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 2						-- Set on which page this vehicle will appear
			},			
			['seminole'] = {							-- Tên gọi xe
				['name'] = "Seminole",					-- Tên xe
				['price_to_customer'] = 29500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 18000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974679074620465182/seminole.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 2						-- Set on which page this vehicle will appear
			},			
			['xls'] = {							-- Tên gọi xe
				['name'] = "XLS",					-- Tên xe
				['price_to_customer'] = 75000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 65000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974679195735191593/Xls.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 2						-- Set on which page this vehicle will appear
			},		
			['btype'] = {							-- Tên gọi xe
				['name'] = "Roosevelt",					-- Tên xe
				['price_to_customer'] = 325000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 250000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 80000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974679728785084416/btype.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1						-- Set on which page this vehicle will appear
			},				
			['btype3'] = {							-- Tên gọi xe
				['name'] = "Roosevelt Valor",					-- Tên xe
				['price_to_customer'] = 375000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 270000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 80000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974679850948366396/btype3.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1						-- Set on which page this vehicle will appear
			},				
			['btype2'] = {							-- Tên gọi xe
				['name'] = "Franken Stange",					-- Tên xe
				['price_to_customer'] = 350000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 250000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 80000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974679939985080370/btype2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1						-- Set on which page this vehicle will appear
			},				
			['casco'] = {							-- Tên gọi xe
				['name'] = "Casco",					-- Tên xe
				['price_to_customer'] = 102000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 82000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 70000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974680092062146580/casco.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1						-- Set on which page this vehicle will appear
			},				
			['coquette2'] = {							-- Tên gọi xe
				['name'] = "Coquette Classic",					-- Tên xe
				['price_to_customer'] = 125000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 100000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 80000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974680238879547483/coquette2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1						-- Set on which page this vehicle will appear
			},				
			['monroe'] = {							-- Tên gọi xe
				['name'] = "Monroe",					-- Tên xe
				['price_to_customer'] = 98500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 70000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 50000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974680552609304576/monroe.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1						-- Set on which page this vehicle will appear
			},				
			['pigalle'] = {							-- Tên gọi xe
				['name'] = "Pigalle",					-- Tên xe
				['price_to_customer'] = 135000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 110000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 80000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974680731546701904/pigalle.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1						-- Set on which page this vehicle will appear
			},				
			['stingergt'] = {							-- Tên gọi xe
				['name'] = "Stingergt GT",					-- Tên xe
				['price_to_customer'] = 184000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 160000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 80000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974680912577048616/stingergt.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1						-- Set on which page this vehicle will appear
			},				
			['feltzer3'] = {							-- Tên gọi xe
				['name'] = "Stirling GT",					-- Tên xe
				['price_to_customer'] = 195000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 170000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 80000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974681054847840276/feltzer3.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1						-- Set on which page this vehicle will appear
			},				
			['ztype'] = {							-- Tên gọi xe
				['name'] = "Z-Type",					-- Tên xe
				['price_to_customer'] = 2500000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 1800000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 80000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974681215208685568/ztype.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1						-- Set on which page this vehicle will appear
			},				
			['cogcabrio'] = {							-- Tên gọi xe
				['name'] = "Cognoscenti Cabrio",					-- Tên xe
				['price_to_customer'] = 45500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 30000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974681494717075476/cogcabrio.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 5						-- Set on which page this vehicle will appear
			},				
			['exemplar'] = {							-- Tên gọi xe
				['name'] = "Exemplar",					-- Tên xe
				['price_to_customer'] = 65000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 40000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974681706927894568/exemplar.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 5						-- Set on which page this vehicle will appear
			},				
			['f620'] = {							-- Tên gọi xe
				['name'] = "F620",					-- Tên xe
				['price_to_customer'] = 37500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 25000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974682302514864159/f620.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 5						-- Set on which page this vehicle will appear
			},				
			['felon'] = {							-- Tên gọi xe
				['name'] = "Felon",					-- Tên xe
				['price_to_customer'] = 31000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 20000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974682552822558720/felon.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 5						-- Set on which page this vehicle will appear
			},		
			['felon2'] = {							-- Tên gọi xe
				['name'] = "Felon GT",					-- Tên xe
				['price_to_customer'] = 37000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 20000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974683227006582885/felon2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 5						-- Set on which page this vehicle will appear
			},				
			['jackal'] = {							-- Tên gọi xe
				['name'] = "Jackal",					-- Tên xe
				['price_to_customer'] = 29000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 20000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974683482926231552/jackal.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 5						-- Set on which page this vehicle will appear
			},				
			['oracle2'] = {							-- Tên gọi xe
				['name'] = "Oracle XS",					-- Tên xe
				['price_to_customer'] = 28000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 18000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974683659359645716/oracle2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 5						-- Set on which page this vehicle will appear
			},				
			['sentinel'] = {							-- Tên gọi xe
				['name'] = "Sentinel",					-- Tên xe
				['price_to_customer'] = 30000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 20000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974683822786482226/sentinel.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 5						-- Set on which page this vehicle will appear
			},				
			['sentinel2'] = {							-- Tên gọi xe
				['name'] = "Sentinel XS",					-- Tên xe
				['price_to_customer'] = 36500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 25000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974683943318192228/sentinel2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 5						-- Set on which page this vehicle will appear
			},				
			['windsor'] = {							-- Tên gọi xe
				['name'] = "Windsor",					-- Tên xe
				['price_to_customer'] = 325000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 250000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974684356289380413/windsor.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 5						-- Set on which page this vehicle will appear
			},				
			['windsor2'] = {							-- Tên gọi xe
				['name'] = "Windsor Drop",					-- Tên xe
				['price_to_customer'] = 355000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 200000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974684478096179270/windsor2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 5						-- Set on which page this vehicle will appear
			},				
			['zion'] = {							-- Tên gọi xe
				['name'] = "Zion",					-- Tên xe
				['price_to_customer'] = 25500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 12000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974684630789795970/zion.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 5						-- Set on which page this vehicle will appear
			},				
			['zion2'] = {							-- Tên gọi xe
				['name'] = "Zion Cabrio",					-- Tên xe
				['price_to_customer'] = 27000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 17000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974684755016712192/zion2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 5						-- Set on which page this vehicle will appear
			},				
			['futo'] = {							-- Tên gọi xe
				['name'] = "Futo",					-- Tên xe
				['price_to_customer'] = 20000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 10000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974684888227778560/futo.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 5						-- Set on which page this vehicle will appear
			},				
			['mamba'] = {							-- Tên gọi xe
				['name'] = "Mamba",					-- Tên xe
				['price_to_customer'] = 86000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 70000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974685025226358865/mamba.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1						-- Set on which page this vehicle will appear
			},				
			
			['tractor2'] = {							-- Tên gọi xe
				['name'] = "Tractor ",					-- Tên xe
				['price_to_customer'] = 6000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 3000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974685863604785202/tractor2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 2					-- Set on which page this vehicle will appear
			},				
			['clique'] = {							-- Tên gọi xe
				['name'] = "Clique ",					-- Tên xe
				['price_to_customer'] = 12300,		-- Giá khách hàng mua xe
				['price_to_owner'] = 5000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974685968709869588/clique.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6					-- Set on which page this vehicle will appear
			},				
			['gt500'] = {							-- Tên gọi xe
				['name'] = "GT500 ",					-- Tên xe
				['price_to_customer'] = 255000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 220000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974686076025340014/gt500.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1					-- Set on which page this vehicle will appear
			},				
			['rapidgt3'] = {							-- Tên gọi xe
				['name'] = "Rapid GT ",					-- Tên xe
				['price_to_customer'] = 445000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 400000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974686257617719446/rapidgt3.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1					-- Set on which page this vehicle will appear
			},				
			['hustler'] = {							-- Tên gọi xe
				['name'] = "Hustler ",					-- Tên xe
				['price_to_customer'] = 75500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 50000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 20000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974686404237983794/hustler.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6					-- Set on which page this vehicle will appear
			},				
			['yosemite'] = {							-- Tên gọi xe
				['name'] = "Yosemite ",					-- Tên xe
				['price_to_customer'] = 19500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 12000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974686675403931658/yosemite.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6					-- Set on which page this vehicle will appear
			},				
			['z190'] = {							-- Tên gọi xe
				['name'] = "190Z ",					-- Tên xe
				['price_to_customer'] = 330000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 300000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 20000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974686850604236830/z190.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1					-- Set on which page this vehicle will appear
			},				
			['blista2'] = {							-- Tên gọi xe
				['name'] = "Blista Compact",					-- Tên xe
				['price_to_customer'] = 12500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 5000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974686962432765982/blista2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 4					-- Set on which page this vehicle will appear
			},				
			['issi3'] = {							-- Tên gọi xe
				['name'] = "Issi Classic",					-- Tên xe
				['price_to_customer'] = 11000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 5000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974687063934918696/issi3.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 4					-- Set on which page this vehicle will appear
			},				
			['dilettante'] = {							-- Tên gọi xe
				['name'] = "Dilettante",					-- Tên xe
				['price_to_customer'] = 13000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 5000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974687361973755914/dilettante.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 4					-- Set on which page this vehicle will appear
			},				
			['rhapsody'] = {							-- Tên gọi xe
				['name'] = "Rhapsody",					-- Tên xe
				['price_to_customer'] = 10000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 5000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974687528470872064/rhapsody.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 4					-- Set on which page this vehicle will appear
			},				
			['stalion'] = {							-- Tên gọi xe
				['name'] = "Stalion",					-- Tên xe
				['price_to_customer'] = 23500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 18000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974687662772465734/stalion.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6					-- Set on which page this vehicle will appear
			},				
			['infernus2'] = {							-- Tên gọi xe
				['name'] = "Infernus Classic",					-- Tên xe
				['price_to_customer'] = 200000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 150000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974687916267806860/infernus2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1					-- Set on which page this vehicle will appear
			},				
			['torero'] = {							-- Tên gọi xe
				['name'] = "Torero",					-- Tên xe
				['price_to_customer'] = 285500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 230000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974688165401079828/torero.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1					-- Set on which page this vehicle will appear
			},				
			['dominator3'] = {							-- Tên gọi xe
				['name'] = "Dominator GTX",					-- Tên xe
				['price_to_customer'] = 87500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 50000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974688289703493662/dominator3.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6					-- Set on which page this vehicle will appear
			},				
			['surge'] = {							-- Tên gọi xe
				['name'] = "Surge",					-- Tên xe
				['price_to_customer'] = 28500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 10000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974688440778121226/surge.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 3					-- Set on which page this vehicle will appear
			},				
			['ellie'] = {							-- Tên gọi xe
				['name'] = "Ellie",					-- Tên xe
				['price_to_customer'] = 50000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 30000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974688582805651486/ellie.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 6					-- Set on which page this vehicle will appear
			},				
			['bjxl'] = {							-- Tên gọi xe
				['name'] = "BeeJay XL",					-- Tên xe
				['price_to_customer'] = 47000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 30000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 2000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974688859667447808/bjxl.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 2					-- Set on which page this vehicle will appear
			},				
					
						
	 	},
	 	['pagination'] = {
	 		[0] = "Xe tải",
			[1] = "Thể thao thường", -- sportsclassic
	 		[2] = "SUV",
	 		[3] = "Sedan",
	 		[4] = "Xe hạng nhỏ", -- compact
	 		[5] = "Xe hai cửa", -- coupes
	 		[6] = "Xe cơ bắp", -- muscle

	 	},
	 	['blips'] = {
	 		['id'] = 225,
			['name'] = "Cửa hàng xe thường",
	 		['color'] = 3,
	 		['scale'] = 0.8,
	 	}
	},
	
	['Super_dealer'] = {
	 	['stock_capacity'] = 300,
		['max_employees'] = 5,
		['vehicles'] = {
	 		['ninef'] = {
				['name'] = "9F",
	 			['price_to_customer'] = 135000,
	 			['price_to_owner'] = 120000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974689948181614682/ninef.png',
	 			['page'] = 1
	 		},
			['ninef2'] = {
				['name'] = "9F Cabrio",
	 			['price_to_customer'] = 142000,
	 			['price_to_owner'] = 120000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974690102762668112/ninef2.png',
	 			['page'] = 1
	 		},
					
			 ['ruston'] = {
				['name'] = "Ruston",
	 			['price_to_customer'] = 165000,
	 			['price_to_owner'] = 120000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974690502387585057/ruston.png',
	 			['page'] = 1
	 		},
			 ['tezeract'] = {
				['name'] = "Tezeract",
	 			['price_to_customer'] = 2350000,
	 			['price_to_owner'] = 1900000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974690916113743882/tezeract.png',
	 			['page'] = 1
	 		},
			 ['entity2'] = {
				['name'] = "Entity XXR",
	 			['price_to_customer'] = 1532000,
	 			['price_to_owner'] = 1000000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974691125363367996/entity2.png',
	 			['page'] = 1
	 		},
			 ['nero'] = {
				['name'] = "Nero",
	 			['price_to_customer'] = 2352000,
	 			['price_to_owner'] = 2000000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974691404553011282/nero.png',
	 			['page'] = 1
	 		},
			 ['comet3'] = {
				['name'] = "Comet Retro Custom",
	 			['price_to_customer'] = 125000,
	 			['price_to_owner'] = 80000,
				['price_to_export'] = 70000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974691666000773200/comet3.png',
	 			['page'] = 1
	 		},
			 ['comet4'] = {
				['name'] = "Comet Pfister",
	 			['price_to_customer'] = 125000,
	 			['price_to_owner'] = 90000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974691831222788106/comet4.png',
	 			['page'] = 1
	 		},
			 ['taipan'] = {
				['name'] = "Taipan	",
	 			['price_to_customer'] = 1650000,
	 			['price_to_owner'] = 1200000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974692127223205939/taipan.png',
	 			['page'] = 1
	 		},
			 ['tyrant'] = {
				['name'] = "Tyrant",
	 			['price_to_customer'] = 2100000,
	 			['price_to_owner'] = 1800000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974692278037786634/tyrant.png',
	 			['page'] = 1
	 		},
			 ['osiris'] = {
				['name'] = "Osiris",
	 			['price_to_customer'] = 1400000,
	 			['price_to_owner'] = 1000000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974692711695269978/osiris.png',
	 			['page'] = 1
	 		},
			 ['flashgt'] = {
				['name'] = "Flashgt GT",
	 			['price_to_customer'] = 111000,
	 			['price_to_owner'] = 80000,
				['price_to_export'] = 50000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974692863206129684/flashgt.png',
	 			['page'] = 1
	 		},
			 ['specter2'] = {
				['name'] = "Specter Custom",
	 			['price_to_customer'] = 178000,
	 			['price_to_owner'] = 120000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974693221584232458/specter2.png',
	 			['page'] = 1
	 		},
			 ['sc1'] = {
				['name'] = "SC1",
	 			['price_to_customer'] = 750000,
	 			['price_to_owner'] = 650000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974693446566682654/sc1.png',
	 			['page'] = 1
	 		},
			['streiter'] = {
				['name'] = "Streiter",
	 			['price_to_customer'] = 98000,
	 			['price_to_owner'] = 70000,
				['price_to_export'] = 50000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974693630893776976/streiter.png',
	 			['page'] = 1
	 		},
			 ['specter'] = {
				['name'] = "Specter",
	 			['price_to_customer'] = 155000,
	 			['price_to_owner'] = 120000,
				['price_to_export'] = 50000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974693866399731752/specter.png',
	 			['page'] = 1
	 		},
			 ['penetrator'] = {
				['name'] = "Penetrator",
	 			['price_to_customer'] = 567000,
	 			['price_to_owner'] = 500000,
				['price_to_export'] = 50000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974694014051811409/penetrator.png',
	 			['page'] = 1
	 		},
			['tempesta'] = {
				['name'] = "Tempesta",
	 			['price_to_customer'] = 400000,
	 			['price_to_owner'] = 300000,
				['price_to_export'] = 50000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974694181077409842/tempesta.png',
	 			['page'] = 1
	 		},
			 ['vagner'] = {
				['name'] = "Vagner",
	 			['price_to_customer'] = 1460000,
	 			['price_to_owner'] = 1000000,
				['price_to_export'] = 50000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974694346962116688/vagner.png',
	 			['page'] = 1
	 		},
			 ['italigtb'] = {
				['name'] = "Itali GTB",
	 			['price_to_customer'] = 1200000,
	 			['price_to_owner'] = 900000,
				['price_to_export'] = 50000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974694586347831326/italigtb.png',
	 			['page'] = 1
	 		},
			 ['xa21'] = {
				['name'] = "XA-21",
	 			['price_to_customer'] = 2150000,
	 			['price_to_owner'] = 1800000,
				['price_to_export'] = 50000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974694696968400916/xa21.png',
	 			['page'] = 1
	 		},
			 ['jester3'] = {
				['name'] = "Jester Classic",
	 			['price_to_customer'] = 70000,
	 			['price_to_owner'] = 50000,
				['price_to_export'] = 40000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974694834449317968/jester3.png',
	 			['page'] = 1
	 		},
			 ['elegy'] = {
				['name'] = "Elegy Retro Custom",
	 			['price_to_customer'] = 60000,
	 			['price_to_owner'] = 30000,
				['price_to_export'] = 5000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974694971053588530/elegy.png',
	 			['page'] = 1
	 		},
			['cheetah2'] = {
				['name'] = "Cheetah Classic",
	 			['price_to_customer'] = 220000,
	 			['price_to_owner'] = 180000,
				['price_to_export'] = 50000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974695149412171866/cheetah2.png',
	 			['page'] = 1
	 		},
			 ['gp1'] = {
				['name'] = "GP1",
	 			['price_to_customer'] = 462000,
	 			['price_to_owner'] = 430000,
				['price_to_export'] = 50000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974695273181876264/gp1.png',
	 			['page'] = 1
	 		},
			['pariah'] = {
				['name'] = "Pariah",
	 			['price_to_customer'] = 395000,
	 			['price_to_owner'] = 350000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974695500668366868/pariah.png',
	 			['page'] = 1
	 		},
			['visione'] = {
				['name'] = "Visione",
	 			['price_to_customer'] = 1750000,
	 			['price_to_owner'] = 1500000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974695629391540255/visione.png',
	 			['page'] = 1
	 		},
			['neon'] = {
				['name'] = "Neon",
	 			['price_to_customer'] = 185000,
	 			['price_to_owner'] = 150000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974695747129856010/neon.png',
	 			['page'] = 1
	 		},
			 ['autarch'] = {
				['name'] = "Autarch",
	 			['price_to_customer'] = 1800000,
	 			['price_to_owner'] = 1500000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974696009789743124/autarch.png',
	 			['page'] = 1
	 		},
			['raiden'] = {
				['name'] = "Raiden",
	 			['price_to_customer'] = 150000,
	 			['price_to_owner'] = 120000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974696136982007818/raiden.png',
	 			['page'] = 1
	 		},
			 ['cyclone'] = {
				['name'] = "Cyclone",
	 			['price_to_customer'] = 1200000,
	 			['price_to_owner'] = 1000000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974696419753590844/cyclone.png',
	 			['page'] = 1
	 		},
			 ['comet5'] = {
				['name'] = "Comet SR",
	 			['price_to_customer'] = 252000,
	 			['price_to_owner'] = 200000,
				['price_to_export'] = 80000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974696546505474048/comet5.png',
	 			['page'] = 1
	 		},
			
			
			['alpha'] = {
				['name'] = "Alpha",
	 			['price_to_customer'] = 38000,
	 			['price_to_owner'] = 25000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974696687815761980/alpha.png',
	 			['page'] = 1
	 		},
			 ['banshee'] = {
				['name'] = "Banshee",
	 			['price_to_customer'] = 98000,
	 			['price_to_owner'] = 80000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974696844275875920/banshee.png',
	 			['page'] = 1
	 		},
			 ['bestiagts'] = {
				['name'] = "Bestia GTS",
	 			['price_to_customer'] = 197000,
	 			['price_to_owner'] = 170000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974697128003788810/bestiagts.png',
	 			['page'] = 1
	 		},
			 ['buffalo'] = {
				['name'] = "Buffalo",
	 			['price_to_customer'] = 32000,
	 			['price_to_owner'] = 25000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974697295318757466/buffalo.png',
	 			['page'] = 1
	 		},
			 ['buffalo2'] = {
				['name'] = "Buffalo S",
	 			['price_to_customer'] = 39500,
	 			['price_to_owner'] = 25000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974697413149347860/buffalo2.png',
	 			['page'] = 1
	 		},
			 ['carbonizzare'] = {
				['name'] = "Carbonizzare",
	 			['price_to_customer'] = 219000,
	 			['price_to_owner'] = 200000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974697573354971186/carbonizzare.png',
	 			['page'] = 1
	 		},
			 ['comet2'] = {
				['name'] = "Comet",
	 			['price_to_customer'] = 142000,
	 			['price_to_owner'] = 120000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974697718146551808/comet2.png',
	 			['page'] = 1
	 		},
			 ['coquette'] = {
				['name'] = "Coquette",
	 			['price_to_customer'] = 97000,
	 			['price_to_owner'] = 80000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974697970249367582/Coquette.png',
	 			['page'] = 1
	 		},
			 ['elegy2'] = {
				['name'] = "Elegy RH8",
	 			['price_to_customer'] = 68500,
	 			['price_to_owner'] = 50000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974698132225011742/elegy2.png',
	 			['page'] = 1
	 		},
			 ['feltzer2'] = {
				['name'] = "Feltzer2",
	 			['price_to_customer'] = 83500,
	 			['price_to_owner'] = 70000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974698325397897217/feltzer2.png',
	 			['page'] = 1
	 		},
			 ['furoregt'] = {
				['name'] = "Furore GT",
	 			['price_to_customer'] = 115000,
	 			['price_to_owner'] = 95000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974698603098538084/furoregt.png',
	 			['page'] = 1
	 		},
			 ['fusilade'] = {
				['name'] = "Fusilade",
	 			['price_to_customer'] = 50000,
	 			['price_to_owner'] = 35000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974698888218955776/fusilade.png',
	 			['page'] = 1
	 		},
			 ['jester'] = {
				['name'] = "Jester",
	 			['price_to_customer'] = 265000,
	 			['price_to_owner'] = 220000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974699068192354334/jester.png',
	 			['page'] = 1
	 		},
			['khamelion'] = {
				['name'] = "Khamelion",
	 			['price_to_customer'] = 202000,
	 			['price_to_owner'] = 180000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974699210995822592/khamelion.png',
	 			['page'] = 1
	 		},
			['kuruma'] = {
				['name'] = "Kuruma",
	 			['price_to_customer'] = 59500,
	 			['price_to_owner'] = 40000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974699430592794714/kuruma.png',
	 			['page'] = 1
	 		},
			 ['lynx'] = {
				['name'] = "Lynx",
	 			['price_to_customer'] = 68500,
	 			['price_to_owner'] = 50000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974699584108507236/lynx.png',
	 			['page'] = 1
	 		},
			['massacro'] = {
				['name'] = "Massacro",
	 			['price_to_customer'] = 165000,
	 			['price_to_owner'] = 130000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974699849813491712/massacro.png',
	 			['page'] = 1
	 		},
			 ['rapidgt'] = {
				['name'] = "Rapid GT",
	 			['price_to_customer'] = 60000,
	 			['price_to_owner'] = 45000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974700058194886686/rapidgt.png',
	 			['page'] = 1
	 		},
			 ['rapidgt2'] = {
				['name'] = "Rapid GT Convertible",
	 			['price_to_customer'] = 65000,
	 			['price_to_owner'] = 50000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974700188432220160/rapidgt2.png',
	 			['page'] = 1
	 		},
			 ['schafter3'] = {
				['name'] = "Schafter V12",
	 			['price_to_customer'] = 69000,
	 			['price_to_owner'] = 50000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974700997983240222/schafter3.png',
	 			['page'] = 1
	 		},
			 ['seven70'] = {
				['name'] = "Seven-70",
	 			['price_to_customer'] = 85000,
	 			['price_to_owner'] = 70000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974701130426777610/seven70.png',
	 			['page'] = 1
	 		},
			 ['sultan'] = {
				['name'] = "Sultan",
	 			['price_to_customer'] = 56500,
	 			['price_to_owner'] = 40000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974701289520910366/sultan.png',
	 			['page'] = 1
	 		},
			 ['surano'] = {
				['name'] = "Surano",
	 			['price_to_customer'] = 89000,
	 			['price_to_owner'] = 75000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974701473332068482/surano.png',
	 			['page'] = 1
	 		},
			 ['verlierer2'] = {
				['name'] = "Verlierer",
	 			['price_to_customer'] = 90500,
	 			['price_to_owner'] = 80000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974702019384311818/verlierer2.png',
	 			['page'] = 1
	 		},
			 ['adder'] = {
				['name'] = "Adder",
	 			['price_to_customer'] = 1000000,
	 			['price_to_owner'] = 800000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974702144823377990/adder.png',
	 			['page'] = 1
	 		},
			['banshee2'] = {
				['name'] = "Banshee 900R",
	 			['price_to_customer'] = 178000,
	 			['price_to_owner'] = 151000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974702266110062592/banshee2.png',
	 			['page'] = 1
	 		},
			['bullet'] = {
				['name'] = "Bullet",
	 			['price_to_customer'] = 190000,
	 			['price_to_owner'] = 160000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974702382845943838/bullet.png',
	 			['page'] = 1
	 		},
			['cheetah'] = {
				['name'] = "Cheetah",
	 			['price_to_customer'] = 395000,
	 			['price_to_owner'] = 370000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974702580309573632/cheetah.png',
	 			['page'] = 1
	 		},
			 ['entityxf'] = {
				['name'] = "Entity XF",
	 			['price_to_customer'] = 825000,
	 			['price_to_owner'] = 700000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974702719526907945/entityxf.png',
	 			['page'] = 1
	 		}, 
			 ['fmj'] = {
				['name'] = "FMJ",
	 			['price_to_customer'] = 335000,
	 			['price_to_owner'] = 300000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974702857024602173/fmj.png',
	 			['page'] = 1
	 		}, 
			 ['cheburek'] = {
				['name'] = "Cheburek",
	 			['price_to_customer'] = 15000,
	 			['price_to_owner'] = 10000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974703365890129960/cheburek.png',
	 			['page'] = 1
	 		}, 
			 ['infernus'] = {
				['name'] = "Infernus",
	 			['price_to_customer'] = 285000,
	 			['price_to_owner'] = 250000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974703762444800070/infernus.png',
	 			['page'] = 1
	 		}, 
			 ['pfister811'] = {
				['name'] = "811",
	 			['price_to_customer'] = 583000,
	 			['price_to_owner'] = 550000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974703550317854780/pfister811.png',
	 			['page'] = 1
	 		}, 
			 ['reaper'] = {
				['name'] = "Reaper",
	 			['price_to_customer'] = 365000,
	 			['price_to_owner'] = 340000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974703946570539088/reaper.png',
	 			['page'] = 1
	 		}, 
			 ['t20'] = {
				['name'] = "T20",
	 			['price_to_customer'] = 1680000,
	 			['price_to_owner'] = 1500000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974704195326328882/t20.png',
	 			['page'] = 1
	 		}, 
			 ['turismor'] = {
				['name'] = "Turismor R",
	 			['price_to_customer'] = 750000,
	 			['price_to_owner'] = 700000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974704568757813258/turismor.png',
	 			['page'] = 1
	 		}, 
			 ['vacca'] = {
				['name'] = "Vacca",
	 			['price_to_customer'] = 255000,
	 			['price_to_owner'] = 230000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974704711364128778/vacca.png',
	 			['page'] = 1
	 		},  
			 ['voltic'] = {
				['name'] = "Voltic",
	 			['price_to_customer'] = 120000,
	 			['price_to_owner'] = 100000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974704861763473418/voltic.png',
	 			['page'] = 1
	 		},  
			 ['prototipo'] = {
				['name'] = "X80 Proto",
	 			['price_to_customer'] = 1430000,
	 			['price_to_owner'] = 1200000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974704983989686392/prototipo.png',
	 			['page'] = 1
	 		},  
			 ['zentorno'] = {
				['name'] = "Zentorno",
	 			['price_to_customer'] = 1250000,
	 			['price_to_owner'] = 1000000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974705179352002580/Zentorno.png',
	 			['page'] = 1
	 		},  
			
			 ['sultanrs'] = {
				['name'] = "Sultan RS",
	 			['price_to_customer'] = 76500,
	 			['price_to_owner'] = 50000,
				['price_to_export'] = 8000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974705299426512986/sultanrs.png',
	 			['page'] = 1
	 		},  
	 	},
	 	['pagination'] = {
			[0] = "Super",
			[1] = "Sports",
	 	},
	 	['blips'] = {
	 		['id'] = 225,
			['name'] = "Cửa hàng xe xịn",
	 		['color'] = 8,
	 		['scale'] = 0.8,
	 	}
	},
	['Xe_thung'] = {
		['stock_capacity'] = 300,
		['max_employees'] = 5,
	   ['vehicles'] = {
			['caracara2'] = {
			   ['name'] = "caracara2",
				['price_to_customer'] = 500000,
				['price_to_owner'] = 400000,
			   ['price_to_export'] = 80000,
				['amount_to_owner'] = 1,
			   ['max_stock'] = 10,
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974705752377819216/caracara2.png',
				['page'] = 0
			},
			['rumpo2'] = {							-- Tên gọi xe
				['name'] = "Rumpo 2",					-- Tên xe
				['price_to_customer'] = 20451,		-- Giá khách hàng mua xe
				['price_to_owner'] = 10000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974706060755611708/rumpo2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1						-- Set on which page this vehicle will appear
			},				
			['rumpo3'] = {							-- Tên gọi xe
				['name'] = "Rumpo 3",					-- Tên xe
				['price_to_customer'] = 30000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 15000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974706255224512562/rumpo3.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1						-- Set on which page this vehicle will appear
			},	
			['bison'] = {							-- Tên gọi xe
				['name'] = "Bison",					-- Tên xe
				['price_to_customer'] = 34000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 25000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974706453824831529/bison.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 0						-- Set on which page this vehicle will appear
			},			
			['bobcatxl'] = {							-- Tên gọi xe
				['name'] = "Bobcat XL Open",					-- Tên xe
				['price_to_customer'] = 23000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 15000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974706848018100535/bobcatxl.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 0						-- Set on which page this vehicle will appear
			},					
			['burrito3'] = {							-- Tên gọi xe
				['name'] = "Burrito",					-- Tên xe
				['price_to_customer'] = 38500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 25000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974707863815606332/burrito3.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 0						-- Set on which page this vehicle will appear
			},			
			['gburrito2'] = {							-- Tên gọi xe
				['name'] = "Burrito Custom",					-- Tên xe
				['price_to_customer'] = 65000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 50000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 40000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974708025342459944/gburrito2.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 0						-- Set on which page this vehicle will appear
			},			
			['moonbeam'] = {							-- Tên gọi xe
				['name'] = "Moonbeam",					-- Tên xe
				['price_to_customer'] = 29500,		-- Giá khách hàng mua xe
				['price_to_owner'] = 19000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974708166514327582/moonbeam.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 0						-- Set on which page this vehicle will appear
			},			
			['rumpo'] = {							-- Tên gọi xe
				['name'] = "Rumpo",					-- Tên xe
				['price_to_customer'] = 30000,		-- Giá khách hàng mua xe
				['price_to_owner'] = 20000,			-- Giá chủ sở hữu trả khi nhập xe về cửa hàng
				['price_to_export'] = 8000,			-- Giá phân hủy xe 
				['amount_to_owner'] = 1,			-- Số lượng 1 lần nhập
				['max_stock'] = 150,					-- Số lượng trữ trong kho 
				['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974708384551026789/rumpo.png',	-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 0						-- Set on which page this vehicle will appear
			},				
			['dubsta3'] = {
				['name'] = "dubsta3",
				 ['price_to_customer'] = 1000000,
				 ['price_to_owner'] = 900000,
				['price_to_export'] = 80000,
				 ['amount_to_owner'] = 1,
				['max_stock'] = 10,
				 ['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974708516688379954/dubsta3.png',
				 ['page'] = 0
			 },
			 ['brutus'] = {
				['name'] = "brutus",
				 ['price_to_customer'] = 500000,
				 ['price_to_owner'] = 400000,
				['price_to_export'] = 80000,
				 ['amount_to_owner'] = 1,
				['max_stock'] = 10,
				 ['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974708685001617458/brutus.png',
				 ['page'] = 0
			 },
			 ['riata'] = {
				['name'] = "riata",
				 ['price_to_customer'] = 500000,
				 ['price_to_owner'] = 400000,
				['price_to_export'] = 80000,
				 ['amount_to_owner'] = 1,
				['max_stock'] = 10,
				 ['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974708816455278652/riata.png',
				 ['page'] = 0
			 },
			 ['sandking'] = {
				['name'] = "sandking",
				 ['price_to_customer'] = 500000,
				 ['price_to_owner'] = 400000,
				['price_to_export'] = 80000,
				 ['amount_to_owner'] = 1,
				['max_stock'] = 10,
				 ['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974708952786935868/sandking.png',
				 ['page'] = 0
			 },
			 ['sandking2'] = {
				['name'] = "sandking2",
				 ['price_to_customer'] = 500000,
				 ['price_to_owner'] = 400000,
				['price_to_export'] = 80000,
				 ['amount_to_owner'] = 1,
				['max_stock'] = 10,
				 ['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974709084735570001/sandking2.png',
				 ['page'] = 0
			 },
		   
			 
		},
		['pagination'] = {
		   [0] = "Xe to",
		   [1] = "Xe vans",

		},
		['blips'] = {
			['id'] = 0,
		   ['name'] = "Cửa hàng xe to",
			['color'] = 4,
			['scale'] = 0.5,
		}
   },
	['Bikes_dealer'] = {
	 	['stock_capacity'] = 300,
		['max_employees'] = 5,
		['vehicles'] = {
	 		['sanchez'] = {
				['name'] = "Sanchez Livery",
	 			['price_to_customer'] = 14500,
	 			['price_to_owner'] = 9000,
				['price_to_export'] = 5000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974709334976110622/sanchez.png',
	 			['page'] = 0
	 		},
			['bmx'] = {
				['name'] = "bmx",
	 			['price_to_customer'] = 5000,
	 			['price_to_owner'] = 3000,
				['price_to_export'] = 500,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974709472150847568/bmx.png?width=784&height=468',
	 			['page'] = 0
	 		},
			['tribike2'] = {
				['name'] = "Xe Đạp",
	 			['price_to_customer'] = 20000,
	 			['price_to_owner'] = 10000,
				['price_to_export'] = 5000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974709595446607882/tribike2.png',
	 			['page'] = 0
	 		},
			['fixter'] = {
				['name'] = "Xe Đạp",
	 			['price_to_customer'] = 20000,
	 			['price_to_owner'] = 10000,
				['price_to_export'] = 5000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974709744411504740/fixter.png?width=886&height=468',
	 			['page'] = 0
	 		},
			 ['tribike3'] = {
				['name'] = "Xe Đạp",
	 			['price_to_customer'] = 20000,
	 			['price_to_owner'] = 10000,
				['price_to_export'] = 5000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974709887563079680/tribike3.png.png',
	 			['page'] = 0
	 		},
			 ['sanchez2'] = {
				['name'] = "Sanchez",
	 			['price_to_customer'] = 14500,
	 			['price_to_owner'] = 9000,
				['price_to_export'] = 5000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974710145252728852/sanchez2.png',
	 			['page'] = 0
	 		},
			 ['avarus'] = {
				['name'] = "Avarus",
	 			['price_to_customer'] = 6500,
	 			['price_to_owner'] = 3000,
				['price_to_export'] = 2000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974710266598137956/avarus.png',
	 			['page'] = 0
	 		},
			 ['bagger'] = {
				['name'] = "Bagger",
	 			['price_to_customer'] = 7000,
	 			['price_to_owner'] = 3500,
				['price_to_export'] = 2000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974710424379490304/bagger.png',
	 			['page'] = 0
	 		},
			 ['sovereign'] = {
				['name'] = "Sovereign",
	 			['price_to_customer'] = 27000,
	 			['price_to_owner'] = 20000,
				['price_to_export'] = 10000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974710697063755857/sovereign.png',
	 			['page'] = 0
	 		},
			 ['bati'] = {
				['name'] = "Bati 801",
	 			['price_to_customer'] = 17500,
	 			['price_to_owner'] = 10000,
				['price_to_export'] = 2000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974710846427107338/bati.png',
	 			['page'] = 0
	 		},
			 ['carbonrs'] = {
				['name'] = "Carbon RS",
	 			['price_to_customer'] = 14500,
	 			['price_to_owner'] = 9000,
				['price_to_export'] = 2000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974710955269296208/carbonrs.png',
	 			['page'] = 0
	 		},
			['chimera'] = {
				['name'] = "Chimera",
	 			['price_to_customer'] = 15000,
	 			['price_to_owner'] = 9000,
				['price_to_export'] = 2000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974711088149061672/chimera.png',
	 			['page'] = 0
	 		},
			['daemon'] = {
				['name'] = "Daemon",
	 			['price_to_customer'] = 12500,
	 			['price_to_owner'] = 8000,
				['price_to_export'] = 2000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974711406605787176/daemon.png',
	 			['page'] = 0
	 		},
			['defiler'] = {
				['name'] = "Defiler",
	 			['price_to_customer'] = 13500,
	 			['price_to_owner'] = 8000,
				['price_to_export'] = 2000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974711560616411157/defiler.png',
	 			['page'] = 0
	 		},
			['esskey'] = {
				['name'] = "Esskey",
	 			['price_to_customer'] = 6000,
	 			['price_to_owner'] = 3000,
				['price_to_export'] = 2000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974711683866042378/esskey.png',
	 			['page'] = 0
	 		},
			['faggio'] = {
				['name'] = "Faggio Sport ",
	 			['price_to_customer'] = 5000,
	 			['price_to_owner'] = 3000,
				['price_to_export'] = 2000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974711954260238397/faggio.png',
	 			['page'] = 0
	 		},
			 ['hakuchou'] = {
				['name'] = "Hakuchou",
	 			['price_to_customer'] = 16000,
	 			['price_to_owner'] = 10000,
				['price_to_export'] = 5000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974712113425694790/hakuchou.png',
	 			['page'] = 0
	 		},
			 ['hakuchou2'] = {
				['name'] = "Hakuchou Drag",
	 			['price_to_customer'] = 50000,
	 			['price_to_owner'] = 40000,
				['price_to_export'] = 20000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974712312395092028/hakuchou2.png',
	 			['page'] = 0
	 		},
			 ['cliffhanger'] = {
				['name'] = "Cliffhanger",
	 			['price_to_customer'] = 18230,
	 			['price_to_owner'] = 10000,
				['price_to_export'] = 2000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974712606038310932/cliffhanger.png',
	 			['page'] = 0
	 		},
			['hexer'] = {
				['name'] = "Hexer",
	 			['price_to_customer'] = 7500,
	 			['price_to_owner'] = 3000,
				['price_to_export'] = 2000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974713064039518299/hexer.png',
	 			['page'] = 0
	 		},
			 ['nightblade'] = {
				['name'] = "Nightblade",
	 			['price_to_customer'] = 14500,
	 			['price_to_owner'] = 10000,
				['price_to_export'] = 2000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974713327127265340/nightblade.png',
	 			['page'] = 0
	 		},
			 ['pcj'] = {
				['name'] = "PCJ-600",
	 			['price_to_customer'] = 13500,
	 			['price_to_owner'] = 8000,
				['price_to_export'] = 5000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974713516051279892/pcj.png',
	 			['page'] = 0
	 		},
			 ['ruffian'] = {
				['name'] = "Ruffian",
	 			['price_to_customer'] = 14000,
	 			['price_to_owner'] = 7000,
				['price_to_export'] = 5000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974713682351235093/ruffian.png',
	 			['page'] = 0
	 		},
			 ['sanctus'] = {
				['name'] = "Sanctus",
	 			['price_to_customer'] = 23000,
	 			['price_to_owner'] = 15000,
				['price_to_export'] = 5000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974714169364455474/sanctus.png',
	 			['page'] = 0
	 		},
			 ['thrust'] = {
				['name'] = "Thrust",
	 			['price_to_customer'] = 16000,
	 			['price_to_owner'] = 8000,
				['price_to_export'] = 5000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974714708701622332/thrust.png',
	 			['page'] = 0
	 		},
			 ['faggio3'] = {
				['name'] = "Faggio Mod",
	 			['price_to_customer'] = 5000,
	 			['price_to_owner'] = 4000,
				['price_to_export'] = 3000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974714855879753738/faggio3.png',
	 			['page'] = 0
	 		},
			 ['nemesis'] = {
				['name'] = "Nemesis",
	 			['price_to_customer'] = 12000,
	 			['price_to_owner'] = 6000,
				['price_to_export'] = 2000,
	 			['amount_to_owner'] = 1,
				['max_stock'] = 10,
	 			['img'] = 'https://media.discordapp.net/attachments/974185293982879755/974715001334009856/nemesis.png',
	 			['page'] = 0
	 		},
	 	},
	 	['pagination'] = {
	 		[0] = "Xe Máy",
	 	},
	 	['blips'] = {
	 		['id'] = 226,
			['name'] = "Cửa hàng xe mô tô",
	 		['color'] = 1,
	 		['scale'] = 0.8,
	 	}
	},
}

-- Cargo delivery locations
Config.delivery_locations = {
	[1] = { 1014.62, -3132.29, 5.91 },
	-- [1] = {1224.64, 2731.88, 37.98},
	-- [2] = { -978.23, -1108.09, 2.16 },
	-- [3] = { -1024.49, -1139.6, 2.75 }, 
	-- [4] = { -1063.76, -1159.88, 2.56 }, 
	-- [5] = { -1001.68, -1218.78, 5.75 }, 
	-- [6] = { -1171.54, -1575.61, 4.51 }, 
	-- [7] = { -1097.94, -1673.36, 8.4 }, 
	-- [8] = { -1286.17, -1267.12, 4.52 }, 
	-- [9] = { -1335.75, -1146.55, 6.74 }, 
	-- [10] = { -1750.47, -697.09, 10.18 }, 
	-- [11] = { -1876.84, -584.39, 11.86 }, 
	-- [12] = { -1772.23, -378.12, 46.49 }, 
	-- [13] = { -1821.38, -404.97, 46.65 }, 
	-- [14] = { -1965.33, -296.96, 41.1 }, 
	-- [15] = { -3089.24, 221.49, 14.07 }, 
	-- [16] = { -3088.62, 392.3, 11.45 },
	-- [17] = { -3077.98, 658.9, 11.67 }, 
	-- [18] = { -3243.07, 931.84, 17.23 },
	-- [19] = { 1230.8, -1590.97, 53.77 }, 
	-- [20] = { 1286.53, -1604.26, 54.83 }, 
	-- [21] = { 1379.38, -1515.23, 58.24 }, 
	-- [22] = { 1379.38, -1515.23, 58.24 }, 
	-- [23] = { 1437.37, -1492.53, 63.63 }, 
	-- [24] = { 450.04, -1863.49, 27.77 },
	-- [25] = { 403.75, -1929.72, 24.75 }, 
	-- [26] = { 430.16, -1559.31, 32.8 }, 
	-- [27] = { 446.06, -1242.17, 30.29 },
	-- [28] = { 322.39, -1284.7, 30.57 }, 
	-- [29] = { 369.65, -1194.79, 31.34 },
	-- [30] = { 474.27, -635.05, 25.65 }, 
	-- [31] = { 158.87, -1215.65, 29.3 }, 
	-- [32] = { 154.68, -1335.62, 29.21 }, 
	-- [33] = { 215.54, -1461.67, 29.19 },
	-- [34] = { 167.46, -1709.3, 29.3 },
	-- [35] = { -444.47, 287.68, 83.3 }, 
	-- [36] = { -179.56, 314.25, 97.88 }, 
	-- [37] = { -16.07, 216.7, 106.75 }, 
	-- [38] = { 164.02, 151.87, 105.18 },
	-- [39] = { 840.2, -181.93, 74.19 }, 
	-- [40] = { 952.27, -252.17, 67.77 },
	-- [41] = { 1105.27, -778.84, 58.27 }, 
	-- [42] = { 1099.59, -345.68, 67.19 }, 
	-- [43] = { -1211.12, -401.56, 38.1 }, 
	-- [44] = { -1302.69, -271.32, 40.0 }, 
	-- [45] = { -1468.65, -197.3, 48.84 }, 
	-- [46] = { -1583.18, -265.78, 48.28 }, 
	-- [47] = { -603.96, -774.54, 25.02 },
	-- [48] = { -805.14, -959.54, 18.13 }, 
	-- [49] = { -325.07, -1356.35, 31.3 }, 
	-- [50] = { -321.94, -1545.74, 31.02 }, 
	-- [51] = { -428.95, -1728.13, 19.79 }, 
	-- [52] = { -582.38, -1743.65, 22.44 }, 
	-- [53] = { -670.43, -889.09, 24.5 },
	
	-- [54] = { 1691.4, 3866.21, 34.91 }, 
	-- [55] = { 1837.93, 3907.12, 33.26 },
	-- [56] = { 1937.08, 3890.89, 32.47}, 
	-- [57] = { 2439.7, 4068.45, 38.07 },
	-- [58] = { 2592.26, 4668.98, 34.08 }, 
	-- [59] = { 1961.53, 5184.91, 47.98 },
	-- [60] = { 2258.59, 5165.84, 59.12 }, 
	-- [61] = { 1652.7, 4746.1, 42.03 },
	-- [62] = { -359.09, 6062.05, 31.51 }, 
	-- [63] = { -160.13, 6432.2, 31.92 },
	-- [64] = { 33.33, 6673.27, 32.19 }, 
	-- [65] = { 175.03, 6643.14, 31.57 },
	-- [66] = { 22.8, 6488.44, 31.43 }, 
	-- [67] = { 64.39, 6309.17, 31.38 },
	-- [68] = { 122.42, 6406.02, 31.37 }, 
	-- [69] = { 1681.2, 6429.11, 32.18 },
	-- [70] = { 2928.01, 4474.74, 48.04 }, 
	-- [71] = { 2709.92, 3454.83, 56.32 },
	-- [72] = { -688.75, 5788.9, 17.34 }, 
	-- [73] = { -436.13, 6154.93, 31.48 },
	-- [74] = { -291.09, 6185.0, 31.49 }, 
	-- [75] = { 405.31, 6526.38, 27.69 },
	-- [76] = { -20.38, 6567.13, 31.88 }, 
	-- [77] = { -368.06, 6341.4, 29.85 },
	-- [78] = { 1842.89, 3777.72, 33.16 }, 
	-- [79] = { 1424.82, 3671.73, 34.18 },
	-- [80] = { 996.54, 3575.55, 34.62 }, 
	-- [81] = { 1697.52, 3596.14, 35.56 },
	-- [82] = { 2415.05, 5005.35, 46.68 }, 
	-- [83] = { 2336.21, 4859.41, 41.81},
	-- [84] = { 1800.9, 4616.07, 37.23 },
	-- [85] = { -453.3, 6336.9, 13.11 },
	-- [86] = { -425.4, 6356.43, 13.33 },
	-- [87] = { -481.9, 6276.47, 13.42 },
	-- [88] = { -693.92, 5761.95, 17.52 },
	-- [89] = { -682.03, 5770.96, 17.52 },
	-- [90] = { -379.44, 6062.07, 31.51 },
	-- [91] = { -105.68, 6528.7, 30.17 },
	-- [92] = { 35.02, 6662.61, 32.2 },
	-- [93] = { 126.41, 6353.64, 31.38 },
	-- [94] = { 48.15, 6305.99, 31.37 },
	-- [95] = { 1417.68, 6343.83, 24.01 },
	-- [96] = { 1510.21, 6326.28, 24.61 },
	-- [97] = { 1698.22, 6425.66, 32.77 },
	-- [98] = { 2434.69, 5011.7, 46.84 },
	-- [99] = { 1718.88, 4677.32, 43.66 },
	-- [100] = { 1673.21, 4958.09, 42.35 },
	-- [101] = { 1364.33, 4315.43, 37.67 },
	-- [102] = { -1043.6, 5326.84, 44.58 },
	-- [103] = { -329.63, 6150.58, 32.32 },
	-- [104] = { -374.41, 6191.04, 31.73 },
	-- [105] = { -356.63, 6207.34, 31.85 },
	-- [106] = { -347.15, 6224.69, 31.7 },
	-- [107] = { -315.61, 6194.0, 31.57 },
	-- [108] = { -33.3, 6455.87, 31.48 },
	-- [109] = { 405.52, 6526.59, 27.7 },
	-- [110] = { 1470.41, 6513.71, 21.23 },
	-- [111] = { 1593.73, 6460.56, 25.32 },
	-- [112] = { 1741.31, 6420.19, 35.05 },
}

-- Setting to remove inactive dealerships
Config.clear_dealerships = {
	['active'] = true,				-- Set to false to disable this function
	['min_stock_amount'] = 30,		-- Minimum percentage of stock to consider an inactive dealerships. Dealerships that have been inactive for a long time will be removed
	['min_stock_variety'] = 70,		-- Minimum percentage of variety of products in stock to consider an inactive dealerships. Dealerships that have been inactive for a long time will be removed
	['cooldown'] = 72				-- Time (in hours) that the dealerships needs to be below the minimum amount of stock to be removed
}

Config.hotkeys = {
	['openNui'] = 38,		-- E
	['testDrive'] = 38,		-- E
	['buyVehicle'] = 29,	-- B
	['unlockTruck'] = 182 	-- L
}

Config.createTable = true

Config.vehList = {
	{ ['name'] = "blista", ['hash'] = -344943009 },
	{ ['name'] = "brioso", ['hash'] = 1549126457 },
	{ ['name'] = "dilettante", ['hash'] = -1130810103 },
	{ ['name'] = "issi2", ['hash'] = -1177863319 },
	{ ['name'] = "issi5", ['hash'] = 1537277726 },
	{ ['name'] = "panto", ['hash'] = -431692672 },
	{ ['name'] = "dune2", ['hash'] = 534258863 },
	{ ['name'] = "prairie", ['hash'] = -1450650718 },
	{ ['name'] = "rhapsody", ['hash'] = 841808271 },
	{ ['name'] = "cogcabrio", ['hash'] = 330661258 },
	{ ['name'] = "emperor", ['hash'] = -685276541 },
	{ ['name'] = "emperor2", ['hash'] = -1883002148 },
	{ ['name'] = "phoenix", ['hash'] = -2095439403 },
	{ ['name'] = "premier", ['hash'] = -1883869285 },
	{ ['name'] = "glendale", ['hash'] = 75131841 },
	{ ['name'] = "intruder", ['hash'] = 886934177 },
	{ ['name'] = "exemplar", ['hash'] = -5153954 },
	{ ['name'] = "f620", ['hash'] = -591610296 },
	{ ['name'] = "felon", ['hash'] = -391594584 },
	{ ['name'] = "ingot", ['hash'] = -1289722222 },
	{ ['name'] = "felon2", ['hash'] = -89291282 },
	{ ['name'] = "stockade", ['hash'] = 1747439474 },	
	{ ['name'] = "jackal", ['hash'] = -624529134 },
	{ ['name'] = "oracle", ['hash'] = 1348744438 },
	{ ['name'] = "oracle2", ['hash'] = -511601230 },
	{ ['name'] = "sentinel", ['hash'] = 1349725314 },
	{ ['name'] = "sentinel2", ['hash'] = 873639469 },
	{ ['name'] = "rmodbentleygt", ['hash'] = -750067359 },
	{ ['name'] = "gcmx32016", ['hash'] = -1427245835 },
	{ ['name'] = "gcmm5cs", ['hash'] = 982729522 },
	{ ['name'] = "gcmaccord21", ['hash'] = -1479639341 },
	{ ['name'] = "gcmexplorer19", ['hash'] = -759525278 },

	{ ['name'] = "windsor", ['hash'] = 1581459400 },
	{ ['name'] = "windsor2", ['hash'] = -1930048799 },
	{ ['name'] = "zion", ['hash'] = -1122289213 },
	{ ['name'] = "zion2", ['hash'] = -1193103848 },
	{ ['name'] = "blade", ['hash'] = -1205801634 },
	{ ['name'] = "buccaneer", ['hash'] = -682211828 },
	{ ['name'] = "buccaneer2", ['hash'] = -1013450936 },
	{ ['name'] = "primo", ['hash'] = -1150599089 },
	{ ['name'] = "primo2", ['hash'] = -2040426790 },
	{ ['name'] = "chino", ['hash'] = 349605904 },
	{ ['name'] = "chino2", ['hash'] = -1361687965 },
	{ ['name'] = "coquette3", ['hash'] = 784565758 },
	{ ['name'] = "dominator", ['hash'] = 80636076 },
	{ ['name'] = "dominator2", ['hash'] = 915704871 },
	{ ['name'] = "dukes", ['hash'] = 723973206 },
	{ ['name'] = "faction", ['hash'] = -2119578145 },
	{ ['name'] = "faction2", ['hash'] = -1790546981 },
	{ ['name'] = "faction3", ['hash'] = -2039755226 },
	{ ['name'] = "gauntlet", ['hash'] = -1800170043 },
	{ ['name'] = "gauntlet2", ['hash'] = 349315417 },
	{ ['name'] = "hermes", ['hash'] = 15219735 },
	{ ['name'] = "emerus", ['hash'] = 1323778901 },
	{ ['name'] = "moonbeam2", ['hash'] = 1896491931 },
	{ ['name'] = "dynasty", ['hash'] = 310284501 },
	{ ['name'] = "yosemite3", ['hash'] = 67753863 },
	{ ['name'] = "rebla", ['hash'] = 83136452 },
	{ ['name'] = "coquette4 ", ['hash'] = -1728685474 },
	{ ['name'] = "hotknife", ['hash'] = 37348240 },
	{ ['name'] = "moonbeam", ['hash'] = 525509695 },
	{ ['name'] = "moonbeam2", ['hash'] = 1896491931 },
	{ ['name'] = "nightshade", ['hash'] = -1943285540 },
	{ ['name'] = "picador", ['hash'] = 1507916787 },
	{ ['name'] = "ruiner", ['hash'] = -227741703 },
	{ ['name'] = "sabregt", ['hash'] = -1685021548 },
	{ ['name'] = "sabregt2", ['hash'] = 223258115 },
	{ ['name'] = "gburrito", ['hash'] = -1745203402 },
	{ ['name'] = "slamvan", ['hash'] = 729783779 },
	{ ['name'] = "slamvan2", ['hash'] = 833469436 },
	{ ['name'] = "slamvan3", ['hash'] = 1119641113 },
	{ ['name'] = "stalion", ['hash'] = 1923400478 },
	{ ['name'] = "stalion2", ['hash'] = -401643538 },
	{ ['name'] = "tampa", ['hash'] = 972671128 },
	{ ['name'] = "vigero", ['hash'] = -825837129 },
	{ ['name'] = "vagrant", ['hash'] = 740289177 },
	{ ['name'] = "krieger", ['hash'] = -664141241 },
	{ ['name'] = "virgo", ['hash'] = -498054846 },
	{ ['name'] = "virgo2", ['hash'] = -899509638 },
	{ ['name'] = "virgo3", ['hash'] = 16646064 },
	{ ['name'] = "voodoo", ['hash'] = 2006667053 },
	{ ['name'] = "voodoo2", ['hash'] = 523724515 },
	{ ['name'] = "yosemite", ['hash'] = 1871995513 },
	{ ['name'] = "bfinjection", ['hash'] = 1126868326 },
	{ ['name'] = "bifta", ['hash'] = -349601129 },
	{ ['name'] = "bodhi2", ['hash'] = -1435919434 },
	{ ['name'] = "brawler", ['hash'] = -1479664699 },
	{ ['name'] = "trophytruck", ['hash'] = 101905590 },
	{ ['name'] = "trophytruck2", ['hash'] = -663299102 },
	{ ['name'] = "dubsta3", ['hash'] = -1237253773 },
	{ ['name'] = "mesa3", ['hash'] = -2064372143 },
	{ ['name'] = "rancherxl", ['hash'] = 1645267888 },
	{ ['name'] = "rebel", ['hash'] = -1207771834 },
	{ ['name'] = "rebel2", ['hash'] = -2045594037 },
	{ ['name'] = "riata", ['hash'] = -1532697517 },
	{ ['name'] = "dloader", ['hash'] = 1770332643 },
	{ ['name'] = "ratloader", ['hash'] = -667151410 },
	{ ['name'] = "sandking", ['hash'] = -1189015600 },
	{ ['name'] = "sandking2", ['hash'] = 989381445 },
	{ ['name'] = "baller", ['hash'] = -808831384 },
	{ ['name'] = "baller2", ['hash'] = 142944341 },
	{ ['name'] = "baller3", ['hash'] = 1878062887 },
	{ ['name'] = "baller4", ['hash'] = 634118882 },
	{ ['name'] = "baller5", ['hash'] = 470404958 },
	{ ['name'] = "baller6", ['hash'] = 666166960 },
	{ ['name'] = "bjxl", ['hash'] = 850565707 },
	{ ['name'] = "cavalcade", ['hash'] = 2006918058 },
	{ ['name'] = "cavalcade2", ['hash'] = -789894171 },
	{ ['name'] = "contender", ['hash'] = 683047626 },
	{ ['name'] = "dubsta", ['hash'] = 1177543287 },
	{ ['name'] = "dubsta2", ['hash'] = -394074634 },
	{ ['name'] = "fq2", ['hash'] = -1137532101 },
	{ ['name'] = "granger", ['hash'] = -1775728740 },
	{ ['name'] = "gresley", ['hash'] = -1543762099 },
	{ ['name'] = "habanero", ['hash'] = 884422927 },
	{ ['name'] = "seminole", ['hash'] = 1221512915 },
	{ ['name'] = "serrano", ['hash'] = 1337041428 },
	{ ['name'] = "xls", ['hash'] = 1203490606 },
	{ ['name'] = "xls2", ['hash'] = -432008408 },
	{ ['name'] = "asea", ['hash'] = -1809822327 },
	{ ['name'] = "asterope", ['hash'] = -1903012613 },
	{ ['name'] = "cog55", ['hash'] = 906642318 },
	{ ['name'] = "cog552", ['hash'] = 704435172 },
	{ ['name'] = "cognoscenti", ['hash'] = -2030171296 },
	{ ['name'] = "cognoscenti2", ['hash'] = -604842630 },
	{ ['name'] = "stanier", ['hash'] = -1477580979 },
	{ ['name'] = "stratum", ['hash'] = 1723137093 },
	{ ['name'] = "superd", ['hash'] = 1123216662 },
	{ ['name'] = "surge", ['hash'] = -1894894188 },
	{ ['name'] = "tailgater", ['hash'] = -1008861746 },
	{ ['name'] = "warrener", ['hash'] = 1373123368 },
	{ ['name'] = "washington", ['hash'] = 1777363799 },
	{ ['name'] = "dinghy2", ['hash'] = 1033245328 },
	{ ['name'] = "alpha", ['hash'] = 767087018 },
	{ ['name'] = "banshee", ['hash'] = -1041692462 },
	{ ['name'] = "bestiagts", ['hash'] = 1274868363 },
	{ ['name'] = "blista2", ['hash'] = 1039032026 },
	{ ['name'] = "blista3", ['hash'] = -591651781 },
	{ ['name'] = "buffalo", ['hash'] = -304802106 },
	{ ['name'] = "buffalo2", ['hash'] = 736902334 },
	{ ['name'] = "buffalo3", ['hash'] = 237764926 },
	{ ['name'] = "carbonizzare", ['hash'] = 2072687711 },
	{ ['name'] = "comet2", ['hash'] = -1045541610 },
	{ ['name'] = "comet3", ['hash'] = -2022483795 },
	{ ['name'] = "comet5", ['hash'] = 661493923 },
	{ ['name'] = "coquette", ['hash'] = 108773431 },
	{ ['name'] = "elegy", ['hash'] = 196747873 },
	{ ['name'] = "elegy2", ['hash'] = -566387422 },
	{ ['name'] = "feltzer2", ['hash'] = -1995326987 },
	{ ['name'] = "furoregt", ['hash'] = -1089039904 },
	{ ['name'] = "fusilade", ['hash'] = 499169875 },
	{ ['name'] = "futo", ['hash'] = 2016857647 },
	{ ['name'] = "jester", ['hash'] = -1297672541 },
	{ ['name'] = "khamelion", ['hash'] = 544021352 },
	{ ['name'] = "kuruma", ['hash'] = -1372848492 },
	{ ['name'] = "kuruma2", ['hash'] = 410882957 },
	{ ['name'] = "massacro", ['hash'] = -142942670 },
	{ ['name'] = "massacro2", ['hash'] = -631760477 },
	{ ['name'] = "ninef", ['hash'] = 1032823388 },
	{ ['name'] = "ninef2", ['hash'] = -1461482751 },
	{ ['name'] = "omnis", ['hash'] = -777172681 },
	{ ['name'] = "pariah", ['hash'] = 867799010 },
	{ ['name'] = "penumbra", ['hash'] = -377465520 },
	{ ['name'] = "gauntlet4", ['hash'] = 1934384720 },
	{ ['name'] = "raiden", ['hash'] = -1529242755 },
	{ ['name'] = "rapidgt", ['hash'] = -1934452204 },
	{ ['name'] = "rapidgt2", ['hash'] = 1737773231 },
	{ ['name'] = "ruston", ['hash'] = 719660200 },
	{ ['name'] = "schafter3", ['hash'] = -1485523546 },
	{ ['name'] = "schafter4", ['hash'] = 1489967196 },
	{ ['name'] = "schafter5", ['hash'] = -888242983 },
	{ ['name'] = "schwarzer", ['hash'] = -746882698 },
	{ ['name'] = "sentinel3", ['hash'] = 1104234922 },
	{ ['name'] = "seven70", ['hash'] = -1757836725 },
	{ ['name'] = "specter", ['hash'] = 1886268224 },
	{ ['name'] = "specter2", ['hash'] = 1074745671 },
	{ ['name'] = "streiter", ['hash'] = 1741861769 },
	{ ['name'] = "sultan", ['hash'] = 970598228 },
	{ ['name'] = "sultan2", ['hash'] = 872704284 },
	{ ['name'] = "surano", ['hash'] = 384071873 },
	{ ['name'] = "tampa2", ['hash'] = -1071380347 },
	{ ['name'] = "tropos", ['hash'] = 1887331236 },
	{ ['name'] = "verlierer2", ['hash'] = 1102544804 },
	{ ['name'] = "btype", ['hash'] = 117401876 },
	{ ['name'] = "btype2", ['hash'] = -831834716 },
	{ ['name'] = "btype3", ['hash'] = -602287871 },
	{ ['name'] = "casco", ['hash'] = 941800958 },
	{ ['name'] = "cheetah", ['hash'] = -1311154784 },
	{ ['name'] = "coquette2", ['hash'] = 1011753235 },
	{ ['name'] = "feltzer3", ['hash'] = -1566741232 },
	{ ['name'] = "gt500", ['hash'] = -2079788230 },
	{ ['name'] = "jugular", ['hash'] = -208911803 },
	{ ['name'] = "italirsx", ['hash'] = -1149725334 },
	{ ['name'] = "infernus2", ['hash'] = -1405937764 },
	{ ['name'] = "jb700", ['hash'] = 1051415893 },
	{ ['name'] = "mamba", ['hash'] = -1660945322 },
	{ ['name'] = "manana", ['hash'] = -2124201592 },
	{ ['name'] = "monroe", ['hash'] = -433375717 },
	{ ['name'] = "peyote", ['hash'] = 1830407356 },
	{ ['name'] = "pigalle", ['hash'] = 1078682497 },
	{ ['name'] = "rapidgt3", ['hash'] = 2049897956 },
	{ ['name'] = "retinue", ['hash'] = 1841130506 },
	{ ['name'] = "stinger", ['hash'] = 1545842587 },
	{ ['name'] = "stingergt", ['hash'] = -2098947590 },
	{ ['name'] = "torero", ['hash'] = 1504306544 },
	{ ['name'] = "tornado", ['hash'] = 464687292 },
	{ ['name'] = "tornado2", ['hash'] = 1531094468 },
	{ ['name'] = "tornado5", ['hash'] = -1797613329 },
	{ ['name'] = "tornado6", ['hash'] = -1558399629 },
	{ ['name'] = "turismo2", ['hash'] = -982130927 },
	{ ['name'] = "ztype", ['hash'] = 758895617 },
	{ ['name'] = "adder", ['hash'] = -1216765807 },
	{ ['name'] = "autarch", ['hash'] = -313185164 },
	{ ['name'] = "banshee2", ['hash'] = 633712403 },
	{ ['name'] = "bullet", ['hash'] = -1696146015 },
	{ ['name'] = "cheetah2", ['hash'] = 223240013 },
	{ ['name'] = "entityxf", ['hash'] = -1291952903 },
	{ ['name'] = "fmj", ['hash'] = 1426219628 },
	{ ['name'] = "gp1", ['hash'] = 1234311532 },
	{ ['name'] = "infernus", ['hash'] = 418536135 },
	{ ['name'] = "nero", ['hash'] = 1034187331 },
	{ ['name'] = "nero2", ['hash'] = 1093792632 },
	{ ['name'] = "osiris", ['hash'] = 1987142870 },
	{ ['name'] = "penetrator", ['hash'] = -1758137366 },
	{ ['name'] = "pfister811", ['hash'] = -1829802492 },
	{ ['name'] = "reaper", ['hash'] = 234062309 },
	{ ['name'] = "sc1", ['hash'] = 1352136073 },
	{ ['name'] = "sultanrs", ['hash'] = -295689028 },
	{ ['name'] = "t20", ['hash'] = 1663218586 },
	{ ['name'] = "tempesta", ['hash'] = 272929391 },
	{ ['name'] = "turismor", ['hash'] = 408192225 },
	{ ['name'] = "tyrus", ['hash'] = 2067820283 },
	{ ['name'] = "vacca", ['hash'] = 338562499 },
	{ ['name'] = "visione", ['hash'] = -998177792 },
	{ ['name'] = "voltic", ['hash'] = -1622444098 },
	{ ['name'] = "zentorno", ['hash'] = -1403128555 },
	{ ['name'] = "sadler", ['hash'] = -599568815 },
	{ ['name'] = "bison", ['hash'] = -16948145 },
	{ ['name'] = "bison2", ['hash'] = 2072156101 },
	{ ['name'] = "bobcatxl", ['hash'] = 1069929536 },
	{ ['name'] = "burrito", ['hash'] = -1346687836 },
	{ ['name'] = "burrito2", ['hash'] = -907477130 },
	{ ['name'] = "burrito3", ['hash'] = -1743316013 },
	{ ['name'] = "burrito4", ['hash'] = 893081117 },
	{ ['name'] = "minivan", ['hash'] = -310465116 },
	{ ['name'] = "minivan2", ['hash'] = -1126264336 },
	{ ['name'] = "paradise", ['hash'] = 1488164764 },
	{ ['name'] = "pony", ['hash'] = -119658072 },
	{ ['name'] = "pony2", ['hash'] = 943752001 },
	{ ['name'] = "rumpo", ['hash'] = 1162065741 },
	{ ['name'] = "rumpo2", ['hash'] = -1776615689 },
	{ ['name'] = "rumpo3", ['hash'] = 1475773103 },
	{ ['name'] = "terbyte", ['hash'] = -1988428699 },
	{ ['name'] = "speedo", ['hash'] = -810318068 },
	{ ['name'] = "surfer", ['hash'] = 699456151 },
	{ ['name'] = "youga", ['hash'] = 65402552 },
	{ ['name'] = "youga2", ['hash'] = 1026149675 },
	{ ['name'] = "rebel", ['hash'] = -1207771834 },
	{ ['name'] = "tractor2", ['hash'] = -2076478498 },
	{ ['name'] = "huntley", ['hash'] = 486987393 },
	{ ['name'] = "landstalker", ['hash'] = 1269098716 },
	{ ['name'] = "mesa", ['hash'] = 914654722 },
	{ ['name'] = "patriot", ['hash'] = -808457413 },
	{ ['name'] = "radi", ['hash'] = -1651067813 },
	{ ['name'] = "rocoto", ['hash'] = 2136773105 },
	{ ['name'] = "tyrant", ['hash'] = -376434238 },
	{ ['name'] = "entity2", ['hash'] = -2120700196 },
	{ ['name'] = "cheburek", ['hash'] = -988501280 },
	{ ['name'] = "hotring", ['hash'] = 1115909093 },
	{ ['name'] = "jester3", ['hash'] = -214906006 },
	{ ['name'] = "flashgt", ['hash'] = -1259134696 },
	{ ['name'] = "ellie", ['hash'] = -1267543371 },
	{ ['name'] = "outlaw", ['hash'] = 408825843 },
	{ ['name'] = "everon", ['hash'] = -1756021720 },
	{ ['name'] = "michelli", ['hash'] = 1046206681 },
	{ ['name'] = "fagaloa", ['hash'] = 1617472902 },
	{ ['name'] = "dominator2", ['hash'] = -915704871 },
	{ ['name'] = "dominator3", ['hash'] = -986944621 },
	{ ['name'] = "issi3", ['hash'] = 931280609 },
	{ ['name'] = "taipan", ['hash'] = -1134706562 },
	{ ['name'] = "gb200", ['hash'] = 1909189272 },
	{ ['name'] = "stretch", ['hash'] = -1961627517 },
	{ ['name'] = "guardian", ['hash'] = -2107990196 },
	{ ['name'] = "insurgent2", ['hash'] = 2071877360 },
	{ ['name'] = "kamacho", ['hash'] = -121446169 },
	{ ['name'] = "neon", ['hash'] = -1848994066 },
	{ ['name'] = "cyclone", ['hash'] = 1392481335 },
	{ ['name'] = "italigtb", ['hash'] = -2048333973 },
	{ ['name'] = "italigtb2", ['hash'] = -482719877 },
	{ ['name'] = "winky", ['hash'] = -210308634 },
	{ ['name'] = "btype3", ['hash'] = -602287871 },
	{ ['name'] = "furia", ['hash'] = 960812448 },
	{ ['name'] = "caracara2", ['hash'] = -1349095620 },
	{ ['name'] = "vagner", ['hash'] = 1939284556 },
	{ ['name'] = "xa21", ['hash'] = 917809321 },
	{ ['name'] = "tezeract", ['hash'] = 1031562256 },
	{ ['name'] = "prototipo", ['hash'] = 2123327359 },
	{ ['name'] = "patriot2", ['hash'] = -420911112 },
	{ ['name'] = "stafford", ['hash'] = 321186144 },
	{ ['name'] = "swinger", ['hash'] = 500482303 },
	{ ['name'] = "clique", ['hash'] = -1566607184 },
	{ ['name'] = "deveste", ['hash'] = 1591739866 },
	{ ['name'] = "deviant", ['hash'] = 1279262537 },
	{ ['name'] = "impaler", ['hash'] = -2096690334 },
	{ ['name'] = "italigto", ['hash'] = -331467772 },
	{ ['name'] = "schlagen", ['hash'] = -507495760 },
	{ ['name'] = "toros", ['hash'] = -1168952148 },
	{ ['name'] = "tulip", ['hash'] = 1456744817 },
	{ ['name'] = "vamos", ['hash'] = -49115651 },
	{ ['name'] = "freecrawler", ['hash'] = -54332285 },	
	{ ['name'] = "fugitive", ['hash'] = 1909141499 },
	{ ['name'] = "le7b", ['hash'] = -1232836011 },
	{ ['name'] = "lurcher", ['hash'] = 2068293287 },
	{ ['name'] = "lynx", ['hash'] = 482197771 },
	{ ['name'] = "raptor", ['hash'] = -674927303 },
	{ ['name'] = "sheava", ['hash'] = 819197656 },
	{ ['name'] = "z190", ['hash'] = 838982985 },
	{ ['name'] = "akuma", ['hash'] = 1672195559 },
	{ ['name'] = "blazer3", ['hash'] = -1269889662 },
	{ ['name'] = "avarus", ['hash'] = -2115793025 },
	{ ['name'] = "bagger", ['hash'] = -2140431165 },
	{ ['name'] = "bati", ['hash'] = -114291515 },
	{ ['name'] = "bati2", ['hash'] = -891462355 },
	{ ['name'] = "bf400", ['hash'] = 86520421 },
	{ ['name'] = "carbonrs", ['hash'] = 11251904 },
	{ ['name'] = "chimera", ['hash'] = 6774487 },
	{ ['name'] = "cliffhanger", ['hash'] = 390201602 },
	{ ['name'] = "daemon", ['hash'] = 2006142190 },
	{ ['name'] = "daemon2", ['hash'] = -1404136503 },
	{ ['name'] = "defiler", ['hash'] = 822018448 },
	{ ['name'] = "diablous", ['hash'] = -239841468 },
	{ ['name'] = "diablous2", ['hash'] = 1790834270 },
	{ ['name'] = "double", ['hash'] = -1670998136 },
	{ ['name'] = "enduro", ['hash'] = 1753414259 },
	{ ['name'] = "esskey", ['hash'] = 2035069708 },
	{ ['name'] = "faggio", ['hash'] = -1842748181 },
	{ ['name'] = "faggio2", ['hash'] = 55628203 },
	{ ['name'] = "faggio3", ['hash'] = -1289178744 },
	{ ['name'] = "fcr", ['hash'] = 627535535 },
	{ ['name'] = "fcr2", ['hash'] = -757735410 },
	{ ['name'] = "gargoyle", ['hash'] = 741090084 },
	{ ['name'] = "hakuchou", ['hash'] = 1265391242 },
	{ ['name'] = "hakuchou2", ['hash'] = -255678177 },
	{ ['name'] = "hexer", ['hash'] = 301427732 },
	{ ['name'] = "innovation", ['hash'] = -159126838 },
	{ ['name'] = "lectro", ['hash'] = 640818791 },
	{ ['name'] = "manchez", ['hash'] = -1523428744 },
	{ ['name'] = "manchez2", ['hash'] = 1086534307 },
	{ ['name'] = "nemesis", ['hash'] = -634879114 },
	{ ['name'] = "nightblade", ['hash'] = -1606187161 },
	{ ['name'] = "pcj", ['hash'] = -909201658 },
	{ ['name'] = "ruffian", ['hash'] = -893578776 },
	{ ['name'] = "sanchez", ['hash'] = 788045382 },
	{ ['name'] = "sanchez2", ['hash'] = -1453280962 },
	{ ['name'] = "sanctus", ['hash'] = 1491277511 },
	{ ['name'] = "sovereign", ['hash'] = 743478836 },
	{ ['name'] = "thrust", ['hash'] = 1836027715 },
	{ ['name'] = "vader", ['hash'] = -140902153 },
	{ ['name'] = "vindicator", ['hash'] = -1353081087 },
	{ ['name'] = "vortex", ['hash'] = -609625092 },
	{ ['name'] = "wolfsbane", ['hash'] = -618617997 },
	{ ['name'] = "zombiea", ['hash'] = -1009268949 },
	{ ['name'] = "zombieb", ['hash'] = -570033273 },
	{ ['name'] = "blazer", ['hash'] = -2128233223 },
	{ ['name'] = "blazer4", ['hash'] = -440768424 },
	{ ['name'] = "shotaro", ['hash'] = -405626514 },
	{ ['name'] = "ratbike", ['hash'] = 1873600305 },
	{ ['name'] = "deathbike", ['hash'] = -27326686 },
	{ ['name'] = "tug", ['hash'] = -2100640717 },
	{ ['name'] = "charger", ['hash'] = -85613452 },
	{ ['name'] = "policiamustanggt", ['hash'] = 796154746 },
	{ ['name'] = "tigerpolicia", ['hash'] = -505049932 },	
	{ ['name'] = "policiacapricesid", ['hash'] = 81717913 },
	{ ['name'] = "policiaschaftersid", ['hash'] = 589099944 },
	{ ['name'] = "durango", ['hash'] = 194589788 },
	{ ['name'] = "tahoe", ['hash'] = 509544490 },
	{ ['name'] = "explorer", ['hash'] = -1940163430 },
	{ ['name'] = "taurus", ['hash'] = 1836948589 },
	{ ['name'] = "crownvic", ['hash'] = -676381631 },
	{ ['name'] = "policiabmwr1200", ['hash'] = -1624991916 },
	{ ['name'] = "caprice", ['hash'] = 114566537 },
	{ ['name'] = "policiabike", ['hash'] = 1276340033 },
	{ ['name'] = "policiaheli", ['hash'] = -875050963 },
	{ ['name'] = "ghispo2", ['hash'] = -304857564 },
	{ ['name'] = "polgs350", ['hash'] = 831758577 },
	
	{ ['name'] = "amarokpolicia", ['hash'] = -137337379 },
	{ ['name'] = "s10rota", ['hash'] = -1699089028 },
	{ ['name'] = "policiaheli", ['hash'] = -875050963 },
	{ ['name'] = "trhawk", ['hash'] = 231217483 },
	{ ['name'] = "atv", ['hash'] = 1479424764 },
	{ ['name'] = "bccaprice", ['hash'] = 898553168 },
	{ ['name'] = "trailgarra", ['hash'] = -926863247 },
	
	{ ['name'] = "camaro", ['hash'] = 584407536 },
	{ ['name'] = "demon", ['hash'] = 885421525 },
	{ ['name'] = "pdbmw", ['hash'] = 1337706268 },
	{ ['name'] = "trailbc", ['hash'] = -282934583 },
	{ ['name'] = "chevypolicia", ['hash'] = -1878793377 },
	{ ['name'] = "trailpc", ['hash'] = -282934583 },
	{ ['name'] = "trailsamu", ['hash'] = 589296660 },
	{ ['name'] = "trailpe", ['hash'] = 336348411 },
	{ ['name'] = "amarokpe", ['hash'] = 1211727809 },
	{ ['name'] = "cargoplane", ['hash'] = 368211810 },
	{ ['name'] = "sato", ['hash'] = 268992244 },
	{ ['name'] = "barracks3", ['hash'] = 630371791 },
	{ ['name'] = "e29bstat", ['hash'] = 63593995 },
	{ ['name'] = "pantera", ['hash'] = -483799841 },
	{ ['name'] = "lazer", ['hash'] = -1281684762 },
	{ ['name'] = "20blazer2", ['hash'] = -654604359 },
	{ ['name'] = "17fusionrb", ['hash'] = -2025100203 },
	{ ['name'] = "tigerrocam", ['hash'] = -1569874267 },
	{ ['name'] = "xtpc", ['hash'] = -1569874267 },
	{ ['name'] = "xtprf", ['hash'] = 1031373599 },
	{ ['name'] = "policiaranger", ['hash'] = -1684910073 },
	{ ['name'] = "amarokgrr", ['hash'] = 918849802 },
	{ ['name'] = "330policia", ['hash'] = -61352894 },
	{ ['name'] = "samumav", ['hash'] = 1084099044 },
	{ ['name'] = "newsmav", ['hash'] = -1470089635 },
    { ['name'] = "jornal1", ['hash'] = -176473001 },
	{ ['name'] = "M5RB_VV", ['hash'] = 1761696027 },
    { ['name'] = "ambu", ['hash'] = -2116140153 },
	{ ['name'] = "sw4garra", ['hash'] = 1976159286 },
	{ ['name'] = "caplib9", ['hash'] = -782626446 },
	{ ['name'] = "charglib", ['hash'] = -316891276 },
	{ ['name'] = "durlib", ['hash'] = -877083412 },
	{ ['name'] = "explib", ['hash'] = -1297014906 },
	{ ['name'] = "sierralib", ['hash'] = -552302267 },
	{ ['name'] = "taholib", ['hash'] = -631081134 },
	{ ['name'] = "tarlib", ['hash'] = 1679221312 },	

	{ ['name'] = "newsvan", ['hash'] = -74027062 },
	{ ['name'] = "newsheli", ['hash'] = -1571566901 },

	{ ['name'] = "fbi2", ['hash'] = -1647941228 },
	{ ['name'] = "policeb", ['hash'] = -34623805 },
	{ ['name'] = "paramedicoambu", ['hash'] = -792745162 },
	{ ['name'] = "paramedicocharger2014", ['hash'] = 108063727 },
	{ ['name'] = "paramedicoheli", ['hash'] = 2020690903 },
	{ ['name'] = "pbus", ['hash'] = -2007026063 },
	{ ['name'] = "mule4", ['hash'] = 1945374990 },
	{ ['name'] = "rallytruck", ['hash'] = -2103821244 },
	{ ['name'] = "riot", ['hash'] = -1205689942 },
	{ ['name'] = "coach", ['hash'] = -2072933068 },
	{ ['name'] = "bus", ['hash'] = -713569950 },
	{ ['name'] = "flatbed", ['hash'] = 1353720154 },
	{ ['name'] = "towtruck", ['hash'] = -1323100960 },
	{ ['name'] = "towtruck2", ['hash'] = -442313018 },
	{ ['name'] = "ratloader", ['hash'] = -667151410 },
	{ ['name'] = "ratloader2", ['hash'] = -589178377 },
	{ ['name'] = "rubble", ['hash'] = -1705304628 },
	{ ['name'] = "taxi", ['hash'] = -956048545 },
	{ ['name'] = "priustaxi", ['hash'] = -956048545 },
	{ ['name'] = "boxville4", ['hash'] = 444171386 },
	{ ['name'] = "boxville", ['hash'] = -1987130134 },
	{ ['name'] = "boxville2", ['hash'] = -233098306 },
	{ ['name'] = "trash2", ['hash'] = -1255698084 },
	{ ['name'] = "trash", ['hash'] = 1917016601 },
	{ ['name'] = "tiptruck", ['hash'] = 48339065 },
	{ ['name'] = "scorcher", ['hash'] = -186537451 },
	{ ['name'] = "tribike", ['hash'] = 1127861609 },
	{ ['name'] = "tribike2", ['hash'] = -1233807380 },
	{ ['name'] = "tribike3", ['hash'] = -400295096 },
	{ ['name'] = "fixter", ['hash'] = -836512833 },
	{ ['name'] = "cruiser", ['hash'] = 448402357 },
	{ ['name'] = "bmx", ['hash'] = 1131912276 },
	{ ['name'] = "dinghy", ['hash'] = 276773164 },
	{ ['name'] = "jetmax", ['hash'] = 861409633 },
	{ ['name'] = "marquis", ['hash'] = -1043459709 },
	{ ['name'] = "seashark", ['hash'] = -1030275036 },
	{ ['name'] = "speeder", ['hash'] = 231083307 },
	{ ['name'] = "speeder2", ['hash'] = 437538602 },
	{ ['name'] = "squalo", ['hash'] = 400514754 },
	{ ['name'] = "suntrap", ['hash'] = -282946103 },
	{ ['name'] = "toro", ['hash'] = 1070967343 },
	{ ['name'] = "toro2", ['hash'] = 908897389 },
	{ ['name'] = "tropic", ['hash'] = 290013743 },
	{ ['name'] = "tropic2", ['hash'] = 1448677353 },
	{ ['name'] = "phantom", ['hash'] = -2137348917 },
	{ ['name'] = "packer", ['hash'] = 569305213 },
	{ ['name'] = "supervolito", ['hash'] = 710198397 },
	{ ['name'] = "supervolito2", ['hash'] = -1671539132 },
	{ ['name'] = "seasparrow", ['hash'] = -726768679 },
	{ ['name'] = "cuban800", ['hash'] = -644710429 },
	{ ['name'] = "mammatus", ['hash'] = -1746576111 },
	{ ['name'] = "vestra", ['hash'] = 1341619767 },
	{ ['name'] = "luxor2", ['hash'] = -1214293858 },
	{ ['name'] = "dodo", ['hash'] = -901163259 },
	{ ['name'] = "duster", ['hash'] = 970356638 },
	{ ['name'] = "velum2", ['hash'] = 1077420264 },
	{ ['name'] = "buzzard2", ['hash'] = 745926877 },
	{ ['name'] = "swift", ['hash'] = -339587598 },
	{ ['name'] = "frogger", ['hash'] = 744705981 },
	{ ['name'] = "maverick", ['hash'] = -1660661558 },
	{ ['name'] = "avenger", ['hash'] = -2118308144 },
	{ ['name'] = "tanker2", ['hash'] = 1956216962 },
	{ ['name'] = "armytanker", ['hash'] = -1207431159 },
	{ ['name'] = "tvtrailer", ['hash'] = -1770643266 },
	{ ['name'] = "trailerlogs", ['hash'] = 2016027501 },
	{ ['name'] = "tr4", ['hash'] = 2091594960 },
	{ ['name'] = "nissangtr", ['hash'] = -60313827 },
	{ ['name'] = "dodgechargersrt", ['hash'] = 1601422646 },
	{ ['name'] = "audirs6", ['hash'] = 1676738519 },
	{ ['name'] = "bmwm3f80", ['hash'] = -157095615 },
	{ ['name'] = "fordmustang", ['hash'] = -1573350092 },
	{ ['name'] = "lamborghinihuracan", ['hash'] = 1114244595 },
	{ ['name'] = "lancerevolutionx", ['hash'] = 1978088379 },
	{ ['name'] = "mazdarx7", ['hash'] = 2034235290 },
	{ ['name'] = "bnr34", ['hash'] = -1430138530 },
	{ ['name'] = "asbo", ['hash'] = 1118611807 },
	{ ['name'] = "komoda", ['hash'] = -834353991 },
	{ ['name'] = "i8", ['hash'] = 1718441594 },
	{ ['name'] = "r8v10abt", ['hash'] = 1836728757 },
	{ ['name'] = "MCJCW20", ['hash'] = 1261261722 },
	{ ['name'] = "asbo", ['hash'] = -682108547 },
	{ ['name'] = "havok", ['hash'] = -1984275979 },
	{ ['name'] = "asbo", ['hash'] = -682108547 },
	{ ['name'] = "club", ['hash'] = -2098954619 },
	{ ['name'] = "kanjo", ['hash'] = 409049982 },
	{ ['name'] = "paganihuayra", ['hash'] = -1683569033 },
	{ ['name'] = "teslaprior", ['hash'] = 351980252 },
	{ ['name'] = "toyotasupra", ['hash'] = 723779872 },
	{ ['name'] = "mercedesa45", ['hash'] = -740742391 },
	{ ['name'] = "lancerevolution9", ['hash'] = -133349447 },
	{ ['name'] = "lwhuracan", ['hash'] = 1028745873 },
	{ ['name'] = "p1", ['hash'] = -189438188 },
	{ ['name'] = "bme6tun", ['hash'] = -380714779 },
	{ ['name'] = "rmodx6", ['hash'] = 2045784380 },
	{ ['name'] = "amarok", ['hash'] = 493030188 },
	{ ['name'] = "g65amg", ['hash'] = 104532066 },
	{ ['name'] = "celta", ['hash'] = 1995020435 },
	{ ['name'] = "bmws", ['hash'] = 2047166283 },
	{ ['name'] = "cb500x", ['hash'] = 494265960 },
	{ ['name'] = "weevil", ['hash'] = 1644055914 },
	{ ['name'] = "500x", ['hash'] = -1165155784 },
	{ ['name'] = "s1000rr", ['hash'] = 436874758 },
	{ ['name'] = "hornet", ['hash'] = -1761239425 },
	{ ['name'] = "vario150", ['hash'] = -1759343884 },
	
	
	{ ['name'] = "fc15", ['hash'] = 580861919 },
	{ ['name'] = "africat", ['hash'] = 1047274985 },
	{ ['name'] = "pista", ['hash'] = 468395564 },	
	{ ['name'] = "17m760i", ['hash'] = -532475078 },
	{ ['name'] = "amggtrr20", ['hash'] = -1394302834 },
	{ ['name'] = "foxbentley", ['hash'] = 892322320 },
	{ ['name'] = "c7", ['hash'] = 874739883 },
	{ ['name'] = "foxc8", ['hash'] = 1592796651 },
	{ ['name'] = "fox720s", ['hash'] = -1645882639 },
	{ ['name'] = "foxrover1", ['hash'] = -911584466 },
	{ ['name'] = "foxsupra", ['hash'] = 16473409 },
	{ ['name'] = "foxsupra", ['hash'] = 16473409 },
	{ ['name'] = "x6m", ['hash'] = -506359117 },
	{ ['name'] = "488gtb", ['hash'] = -1593808613 },
	{ ['name'] = "defiant", ['hash'] = 233681897 },
	{ ['name'] = "porsche992", ['hash'] = 859592619 },
	{ ['name'] = "audirs7", ['hash'] = -192929549 },
	{ ['name'] = "hondafk8", ['hash'] = 653510754 },
	{ ['name'] = "mustangmach1", ['hash'] = -148915999 },
	{ ['name'] = "porsche930", ['hash'] = 2009693397 },
	{ ['name'] = "2018zl1", ['hash'] = -1671973728 },
	{ ['name'] = "lp700", ['hash'] = -724045038 },
	{ ['name'] = "fe86", ['hash'] = 1649254367 },
	{ ['name'] = "type263", ['hash'] = -251450019 },
	{ ['name'] = "flatbed3", ['hash'] = 2037834373 },
	{ ['name'] = "volatus", ['hash'] = -1845487887 },
	{ ['name'] = "swift2", ['hash'] = 1075432268 },
	{ ['name'] = "cargobob2", ['hash'] = 16211617168 },
	{ ['name'] = "fox600lt", ['hash'] = 1257756827 },
	{ ['name'] = "foxleggera", ['hash'] = 1720228960 },
	{ ['name'] = "foxshelby", ['hash'] = 69730216 },
	{ ['name'] = "z1000", ['hash'] = 1744543800 },
	{ ['name'] = "db11", ['hash'] = 765170133 },
	{ ['name'] = "r6", ['hash'] = -188978926 },
	{ ['name'] = "hcbr17", ['hash'] = -1265899455 },
	{ ['name'] = "firetruk", ['hash'] = 1938952078 },
	{ ['name'] = "ambulance", ['hash'] = 1171614426 },
	{ ['name'] = "xt700", ['hash'] = -1714769119 },
	{ ['name'] = "z4bmw", ['hash'] = 745393879 },
	{ ['name'] = "btsupra94", ['hash'] = 1828026872 },
	{ ['name'] = "rmodmi8lb", ['hash'] = -1476696782 },
	{ ['name'] = "gle63c", ['hash'] = -1347202580 },
	{ ['name'] = "hilux2019", ['hash'] = -1270846222 },
	{ ['name'] = "amggtrr20", ['hash'] = -1394302834 },
	{ ['name'] = "fe86", ['hash'] = 1649254367 },
	{ ['name'] = "911r", ['hash'] =144259586 },
	{ ['name'] = "rc", ['hash'] = -2049243343 },
	{ ['name'] = "eclipse", ['hash'] = 1603211447 },
	{ ['name'] = "eleanor", ['hash'] = 137494285 },
	{ ['name'] = "palameila", ['hash'] = -1315334327 },
	{ ['name'] = "lamtmc", ['hash'] = -264618235 },
	{ ['name'] = "r8ppi", ['hash'] = -1385753106 },
	{ ['name'] = "nissangtrnismo", ['hash'] = 670022011 },
	{ ['name'] = "urus", ['hash'] = -520214134 },
	{ ['name'] = "tiger", ['hash'] = -1156537658 },
	{ ['name'] = "hayabusa", ['hash'] = -688419137 },
    { ['name'] = "bmwg20", ['hash'] = 1879538617 },
    { ['name'] = "bmwm4gts", ['hash'] = -13524981 },
	{ ['name'] = "polo2018", ['hash'] = 210550081 },
	{ ['name'] = "ram2500", ['hash'] = -301519603 },
	{ ['name'] = "clio", ['hash'] = -1721911377 },
	{ ['name'] = "ftoro", ['hash'] = -252643265 },
	{ ['name'] = "evo9", ['hash'] = -228528329 },
	{ ['name'] = "718b", ['hash'] = -1528734685 },
	{ ['name'] = "passat", ['hash'] = -1773424714 },
	{ ['name'] = "velar", ['hash'] = 542147885 },
	{ ['name'] = "20cor", ['hash'] = 1727001605 },
	{ ['name'] = "fusion18", ['hash'] = 1689655332 },
	{ ['name'] = "type262", ['hash'] = -1280527695 },
	{ ['name'] = "rmodm5e34", ['hash'] = 1934093517 },
	{ ['name'] = "r1250", ['hash'] = 991407206 },
	{ ['name'] = "mt03", ['hash'] = 1301770299 },
	{ ['name'] = "hornet2014", ['hash'] = -1194399245 },
	{ ['name'] = "xt660", ['hash'] = -842094945 },
	{ ['name'] = "xj6", ['hash'] = 342059638 },
	{ ['name'] = "zx10r", ['hash'] = -714386060 },
	{ ['name'] = "cg160", ['hash'] = 1088829493 },
	{ ['name'] = "sxr", ['hash'] = -1990820579 },
	{ ['name'] = "2f2fs2000", ['hash'] = 352729897 },
	
	{ ['name'] = "rmode63s", ['hash'] = -1497128181 },
	{ ['name'] = "rmodrs6", ['hash'] = 422090481 },
	{ ['name'] = "rmodchiron300", ['hash'] = 1191498149 },
	{ ['name'] = "rmodcamaro", ['hash'] = 1734939441 },
	{ ['name'] = "rmodzl1police", ['hash'] = 1082699033 },
	{ ['name'] = "rmodmk7", ['hash'] = -1222347999 },
	{ ['name'] = "fd", ['hash'] = -1589129298 },
	{ ['name'] = "rmodjesko", ['hash'] = 1784428761 },
	{ ['name'] = "rmodbentley1", ['hash'] = 404106581 },
	{ ['name'] = "rmodbmwm8", ['hash'] = 242156012 },
	{ ['name'] = "rmodf12tdf", ['hash'] = 29976887 },
	{ ['name'] = "rmodfordpolice", ['hash'] = 15164328 }, 
	{ ['name'] = "rmodskyline34", ['hash'] = -1835937232 },
	{ ['name'] = "rmodx6police", ['hash'] = 962552330 },
	{ ['name'] = "rmodjeep", ['hash'] = -2098155976 },
	{ ['name'] = "rmodcharger69", ['hash'] = 8880015 },
	{ ['name'] = "rmodf40", ['hash'] = -1637862878 },
	{ ['name'] = "rmodc63amg", ['hash'] = -1518551484 },
	{ ['name'] = "nissantitan17", ['hash'] = 1221510024 },
	{ ['name'] = "squaddie", ['hash'] = -102335483 },
	{ ['name'] = "rmodgt63", ['hash'] = 980885719 },
	{ ['name'] = "mbhome", ['hash'] = -2016497769 },
	{ ['name'] = "r35", ['hash'] = -980169995 },
	{ ['name'] = "raptor2017", ['hash'] = 624514487 },
	{ ['name'] = "ferrariitalia", ['hash'] = -1173768715 },
	{ ['name'] = "senna", ['hash'] = -433961724 },

	{ ['name'] = "mule2", ['hash'] = -1050465301 },
	{ ['name'] = "pounder", ['hash'] = 2112052861 },
	{ ['name'] = "rallytruck", ['hash'] = -2103821244 },
	{ ['name'] = "brickade", ['hash'] = -305727417 },
	{ ['name'] = "benson", ['hash'] = 2053223216 },

	{ ['name'] = "16challenger", ['hash'] = -216150906 },
}