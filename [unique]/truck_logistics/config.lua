Config = {}

Config.webhook = "SEU_WEBHOOK"					-- Webhook to send logs to discord
Config.lang = "en"								-- Set the file language [en/br]
Config.ESXSHAREDOBJECT = "esx:getSharedObject" 	-- Change your getshared object event here, in case you are using anti-cheat

Config.formatacao = {
	['moeda'] = 'USD',			-- This is the format of the currency, so that your currency sign appears correctly [Examples: BRL, USD]
	['location'] = 'en-US'		-- This is the location of your country, to format the decimal places according to your standard [Examples: pt-BR, en-US]
}

-- Here are the places where the person can open the trucker menu
-- You can add as many locations as you like, just use the location already created as an example
Config.empresas = {
	["trucker_1"] = {															-- ID
		['nome'] = "Porto",														-- Name
		['coordenada'] = {1196.5606, -3253.733, 7.0951867, 0.4700595},	-- Coordinate to open the menu
		['coordenada_garagem'] = {												-- Garage coordinates, where the trucks will spawn (coordinates composed of x, y, z, h)
			{1152.4681, -3253.581, 6.1161599, 272.55871},
			{1151.904, -3263.6, 6.1161599, 266.55407},
			{1152.0083, -3272, 5.9892702, 267.88775},
			{1151.8552, -3281.388, 5.9889702, 267.61999},
			{1151.8071, -3289.604, 5.9903216, 270.99139},


		},
		['coordenada_cargas'] = {												-- Trailer coordinates, where the trailers will spawn (coordinates composed of x, y, z, h)
			{1134.4731, -3256.846, 5.9902992, 269.33959},
			{1133.7442, -3263.665, 5.9875183, 273.06323},
			{1133.8094, -3272.525, 5.9878172, 269.1109},
			{1134.0882, -3281.193, 5.9867653, 270.11505},
			{1133.0778, -3289.951, 5.98777, 271.06994},

		}
	}
}

-- Here is the definition of the contracts that are generated for the players to deliver
Config.contratos = {
	['cancel_contrato'] = 167,					-- Key to cancel the active job (178 = DEL) [Hold key 2 seconds]
	['cooldown'] = 0.2, 							-- Cooldown time (in minutes) to generate a new contract
	['preco_por_km_min'] = 40,					-- Minimum price per kilometer of the contract
	['preco_por_km_max'] = 55,					-- Maximum price per kilometer of the contract
	['probabilidade_ser_carga_urgente'] = 30,	-- The urgent load is generated randomly, here you can configure the probability (%)
	['max_contratos_ativos'] = 100,				-- Maximum of contracts that can be active, this means that when generating a contact that exceeds this number, the oldest contract will be deleted
	['caminhoes'] = {							-- List of trucks that are generated in contracts
		"actros","man","daf","t680","vnl780","w900"
		
	},
	['cargas'] = {
		--[[ 
			List of loads that are generated in the contracts.
			carga: is the trailer spawn name
			nome: is the name that will appear in the list for the player to select
			def: are the load definitions, to configure if it is an ADR certificate, fragile or valuable load
			Def is composed of 3 values
			def = {
				0, [First value]:  Type of ADR certificate. 0 = None, 1 = Explosives, 2 = Flammable gases, 3 = Flammable liquids, 4 = Flammable solids, 5 = Toxic substances, 6 = Corrosive substances
				0, [Second value]: Fragile load: 0 = Not fragile, 1 = It is fragile
				0  [Third value]:  Valuable cargo: 0 = Not valuable, 1 = It is valuable
			}
		]]
		{ carga = "armytanker", nome = "Thùng nhiên liệu quân đội", def = {3,0,0}},
		{ carga = "armytanker", nome = "Cấp nước quân đội", def = {0,0,0}},
		{ carga = "armytanker", nome = "Xe tăng vật liệu ăn mòn quân đội", def = {6,0,1}},
		{ carga = "armytanker", nome = "Thùng gas dễ cháy quân đội", def = {2,0,0}},
		{ carga = "armytanker", nome = "Bình khí độc quân đội", def = {5,0,0}},
		{ carga = "armytanker", nome = "Tài liệu bí mật quân đội", def = {0,0,1}},
		{ carga = "armytanker", nome = "Tài liệu bí mật quân đội", def = {1,1,1}},
		{ carga = "armytanker", nome = "Tài liệu bí mật quân đội", def = {3,1,1}},
		{ carga = "armytanker", nome = "Tài liệu bí mật quân đội", def = {4,1,1}},
		{ carga = "armytanker", nome = "Tài liệu bí mật quân đội", def = {5,1,1}},
		
		{ carga = "liquide1", nome = "Potassium hydroxide", def = {6,0,0}},
		{ carga = "liquide1", nome = "Nitrogen", def = {2,0,1}},
		{ carga = "liquide1", nome = "Potassium chloride", def = {5,0,0}},
		{ carga = "liquide1", nome = "Thuốc độc", def = {5,0,0}},
		{ carga = "liquide1", nome = "Pesticide", def = {5,0,0}},

		{ carga = "armytrailer", nome = "xe kéo quân đội trống", def = {0,0,0}},

		{ carga = "armytrailer2", nome = "Vận chuyển máy móc hạng nặng", def = {0,1,1}},
		{ carga = "armytrailer2", nome = "Vận chuyển máy đào hầm", def = {0,1,1}},
		
		{ carga = "docktrailer", nome = "Vận chuyển đồ đạc", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Vận chuyển tủ lạnh", def = {0,1,0}},
		{ carga = "docktrailer", nome = "Vận chuyển gạch", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Vận chuyển các sản phẩm nhập khẩu", def = {0,0,1}},
		{ carga = "docktrailer", nome = "Vận chuyển nhựa", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Vận chuyển quần áo", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Vận chuyển ghế", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Vận chuyển thiết bị", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Vận chuyển vật tư làm sạch", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Vận chuyển gỗ tinh chế", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Vận chuyển đá", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Vận chuyển đồ trang sức", def = {0,1,1}},
		{ carga = "docktrailer", nome = "Vận chuyển kính", def = {0,1,0}},
		{ carga = "docktrailer", nome = "Vận chuyển đạn", def = {1,0,0}},
		
		{ carga = "freighttrailer", nome = "Xe đầu kéo rỗng", def = {0,0,0}},

		{ carga = "freighttrailer", nome = "Xe mooc rỗng", def = {0,0,0}},
		
		{ carga = "trailers4", nome = "Vận chuyển đồ cho Hải Quân", def = {0,0,0}},
		{ carga = "trailers4", nome = "Xe kéo thuyền", def = {0,1,1}},
		
		{ carga = "tr4", nome = "Stork", def = {0,1,1}},
		
		{ carga = "tvtrailer", nome = "Vận chuyển vật liệu cho các buổi biểu diễn", def = {0,0,1}},
		{ carga = "tvtrailer", nome = "Vận chuyển tài liệu sự kiện", def = {0,1,1}},
		
		{ carga = "tanker", nome = "Thùng nhiên liệu có phụ gia", def = {3,0,0}},
		{ carga = "tanker2", nome = "Bình xăng thông thường", def = {3,0,0}},
		{ carga = "tanker2", nome = "Bồn chứa dầu hỏa", def = {3,0,0}},
		{ carga = "tanker2", nome = "Thùng dầu", def = {3,0,0}},
		
		{ carga = "docktrailer", nome = "Vận chuyển vật liệu lạ", def = {0,1,1}},
		{ carga = "docktrailer", nome = "Vận chuyển vật liệu quý hiếm", def = {0,1,1}},
		{ carga = "docktrailer", nome = "Vận chuyển vũ khí", def = {0,0,1}},
		
		{ carga = "trailerlogs", nome = "Ghi nhật ký vận chuyển", def = {0,0,0}},
		
		{ carga = "trailers", nome = "Vận chuyển vật liệu xây dựng", def = {0,0,0}},
		{ carga = "trailers", nome = "Vận chuyển cao su", def = {0,0,0}},
		{ carga = "trailers", nome = "Vận chuyển thiết bị", def = {0,1,0}},
		{ carga = "trailers", nome = "Vận chuyển vắc xin", def = {0,1,0}},
		{ carga = "trailers", nome = "Vận chuyển chất nổ", def = {1,1,0}},
		{ carga = "trailers", nome = "Vận chuyển mùn cưa", def = {0,0,0}},

		{ carga = "trailers2", nome = "Vận chuyển nho", def = {0,0,0}},
		{ carga = "trailers2", nome = "Vận chuyển thịt lợn", def = {1,1,0}},
		{ carga = "trailers2", nome = "Vận chuyển thịt bò", def = {0,0,0}},
		{ carga = "trailers2", nome = "Vận chuyển cà rốt", def = {0,2,0}},
		{ carga = "trailers2", nome = "Vận chuyển khoai tây", def = {0,0,0}},
		{ carga = "trailers2", nome = "Vận chuyển sữa", def = {0,1,1}},
		{ carga = "trailers2", nome = "Vận chuyển đồ hộp", def = {0,0,0}},
		{ carga = "trailers2", nome = "Vận chuyển thịt đông lạnh", def = {0,0,0}},
		{ carga = "trailers2", nome = "Vận chuyển đậu", def = {0,0,0}},
		{ carga = "trailers2", nome = "Vận chuyển giấm", def = {0,0,0}},
		{ carga = "trailers2", nome = "Vận chuyển nước chanh", def = {0,0,0}},
		{ carga = "trailers2", nome = "Vận chuyển nước đóng chai", def = {0,0,0}},
		{ carga = "trailers2", nome = "Vận chuyển pho mát", def = {0,0,0}},
		{ carga = "trailers2", nome = "Vận chuyển cá", def = {0,0,0}},
		{ carga = "trailers2", nome = "Vận chuyển đồ khô", def = {0,0,0}},	
		{ carga = "trailers2", nome = "Vận chuyển bánh kẹo", def = {1,2,0}},
        { carga = "trailers2", nome = "Vận chuyển tôm hùm", def = {2,1,3}},
		{ carga = "trailers2", nome = "Vận chuyển mực đông lạnh", def = {0,1,1}},	

		{ carga = "trailers3", nome = "Vận chuyển ngói", def = {0,0,0}},
		{ carga = "trailers3", nome = "Vận chuyển đường sắt", def = {0,0,0}},
		{ carga = "trailers3", nome = "Vận chuyển bao bì đã qua sử dụng", def = {0,0,0}},
		{ carga = "trailers3", nome = "Vận chuyển tấm sàn", def = {0,0,0}},
		{ carga = "trailers3", nome = "Vận chuyển gốm sứ", def = {0,0,0}},
		{ carga = "trailers3", nome = "Vận chuyển phế liệu", def = {0,0,0}},

		{ carga = "trailers4", nome = "Vận chuyển pháo hoa", def = {1,1,0}},
		{ carga = "trailers4", nome = "Vận chuyển chất nổ", def = {1,0,0}},
		{ carga = "trailers4", nome = "Vận chuyển chất nổ", def = {0,0,1}},
		{ carga = "trailers4", nome = "Vận chuyển chất nổ", def = {3,1,0}},
		{ carga = "trailers4", nome = "Vận chuyển chất nổ", def = {4,1,0}},
		{ carga = "trailers4", nome = "Vận chuyển thuốc nổ", def = {1,1,0}},
		{ carga = "trailers4", nome = "Vận chuyển phốt pho trắng", def = {4,1,0}},

		{ carga = "heli1", nome = "Vận chuyển trực thăng", def = {0,1,1}},
		{ carga = "militaire1", nome = "Vận chuyển xe quân đội", def = {0,1,1}},
	}
}

-- Here is the definition of the drivers that are generated for the players to hire
Config.motoristas = {
	['cooldown'] = 10,							-- Cooldown time (in minutes) to generate a new driver
	['preco_por_km_min'] = 8,					-- Minimum starting price per KM of the driver (at the end of each delivery)
	['preco_por_km_max'] = 15,					-- Maximum initial price per KM of the driver (at the end of each delivery)
	['preco_min'] = 20,						-- Minimum initial price of the driver (at the end of each delivery)
	['preco_max'] = 35,						-- Maximum initial price of the driver (at the end of each delivery)
	['porcentagem_bonus_habilidades'] = 10,		-- This is the cost in % that each skill will increase in the driver's salary. That is, for each ability he has, the starting price will increase by 5%
	['nomes'] = {
		-- List of drivers that are randomly generated to be hired
		{img = "https://bootdey.com/img/Content/avatar/avatar8.png", nomes = {"Pedro Aquino","Jorge Fernandes","Lucas Silva","Cochran Hicks","Shirley Austin","Grimes Williamson","Kirk Cook","Davis Guerrero","Rocha Good","Hatfield Clarke","Norton Anthony","Parks Dale","Ellison Harrison","Rojas Boyd","Moon Acevedo","Carole Rivas","Wells Wyatt","Beasley Griffith","Jordan Hyde","Holman Dixon","Holden Lynch","Mckenzie Wilkerson","Chapman Preston","Christian Green","Blake Stuart","Paulette Atkinson","Dollie Lane","Castaneda Browning","Baldwin Blankenship","Russell Bowen","Madge Boyle","Nanette Cummings","Brooke Spence","Whitfield Berg","Angie Gonzales","Johanna Mercer","Terrell Mcmillan","Gilmore Quinn","Kenya Pittman","Hurley Black","Shanna Ortega","Logan Sharpe","Mari Brady","Mendoza Wilkinson","Stacie Sanford","Polly Acosta","Stone Robinson","Claudette Bartlett","Young Hines","Potter Wagner","Reilly Callahan","Kerr Kemp","Goff Raymond"}},
		{img = "https://bootdey.com/img/Content/avatar/avatar7.png", nomes = {"Ivan Noleto Sequeira","Kim Wolfe","Laura Logan","Bruce Craft","Compton Luna","Randolph Callahan","Mccray Brock","Sybil Miles","Hendricks Henry","Tina Compton","Phelps Hunter","Jones Russo","Esmeralda Banks","Reid Dean","Parrish Cole","Carlson Gilbert","Jackie Macias","Liza Morse","Mclean Warner","Winnie Lopez","Katheryn Valenzuela","Wade Mccoy","Acosta Mays","Valeria Witt","Elnora Howard","Bernadette Dawson","Rivera Casey","Little Sanford","Deanna Petty","Leonard Blackwell","Payne Leblanc","Tammy Murphy","Sargent Donaldson","Colon Carey","Janis Roth","Lidia Higgins","Lakisha Whitaker","Adrian Mcbride","Maria Forbes","Daisy Mason","Pittman Curtis","Ladonna Bryan","Gaines Hogan","Powers Rodriquez","Donna Hopper","Kristi Livingston","Chelsea Bauer","Gray Fleming","Contreras Mcdonald","Vilma Potts","Guadalupe Mullins"}},
		{img = "https://bootdey.com/img/Content/avatar/avatar6.png", nomes = {"Kenya Mullen","Castaneda Colon","Judy Mckay","Taylor Kerr","Hurst Roy","Owens Vaughan","Vanessa Cline","Bertie Edwards","Flynn Frank","Burks Sutton","Randi Meadows","Tessa Gentry","Lowery Wooten","Acosta Harper","Georgette Cooley","Candice Patterson","Kirsten Daniels","Blake West","Alexandria Pope","Lena Forbes","Morton Snyder","Tara Bradford","Selena Sykes","Tameka Atkinson","Fowler Walker","Gena Ortega","Sheppard Navarro","Imelda Duncan","Christina Bowers","Aline Haynes","Benita Bright","Boyd Mccall","Sandra Weaver","Melissa Wells","Graham Gilmore","Katrina Oliver","Ginger Larson","Griffith Bishop","Barbara Washington","Iris Christensen","Bauer Gay","Hays Vega","Valarie Booth","Kitty Crane","Carmella Torres","Angelina Puckett","Stone Cabrera","Brock Humphrey","Hillary Houston","Callie Robles"}},
		{img = "https://bootdey.com/img/Content/avatar/avatar5.png", nomes = {"Rocha Harrell","Gilliam Thomas","Osborne Blevins","Elba Chambers","Heath Price","Melinda Maynard","Ashlee Johns","Shelton Petty","Carey Mcclain","Blackwell Horne","Deborah Gonzalez","Buck Faulkner","Celina Chang","Kennedy Patrick","Atkinson Sherman","Janelle Tyson","Noelle Vincent","Leah Barron","Angeline Sellers","Trudy Murray","Contreras Hardy","Fletcher Todd","Benson Singleton","Sanford Dean","Hartman Wilkinson","Harriet Robinson","Vivian Osborn","Ida Simmons","Tamara Merrill","Esmeralda Baird","Maynard Oneal","Brianna Greene","Pat Stewart","Tate Wood","French Farrell","Jolene Calderon","Irene Roth","Dina Waller","Gonzalez Alvarez","Leigh Durham","Eve Moody","Lydia Hewitt","Price Summers","Duran Schultz","Rena Williamson","Meagan Shaffer","Angelique Dennis","Graham Love","Sheree Lynn","Church Golden"}},
		{img = "https://bootdey.com/img/Content/avatar/avatar4.png", nomes = {"Cecelia Carson","Rivas Kelly","Green Johnson","Jill Buck","Maddox Leblanc","Hope Aguirre","Aguilar Diaz","Valerie Wiggins","Crystal Sweeney","Sharlene Davidson","Ruthie Valdez","Allyson Haney","Bridgett Wright","Cooke Vargas","Hopkins Neal","Deloris Curry","Alba Warren","Lynette Preston","Candace Britt","Phyllis Mayer","Bailey Stephenson","Meredith Harrell","Conner Heath","Kelly Lynch","Kelli Salinas","Tamara Tran","Boone Sosa","Cora Barrera","John Francis","Tammi Parsons","Natalie Travis","Ivy Mccoy","William Nash","Reba Dillon","Kimberley Whitney","Karen Ellis","Alison Padilla","Spencer Camacho","Blackwell Mccray","Mcgowan Castaneda","Kent Thomas","Lauri Wiley","Atkins Lowery","Janell Hancock","Mosley Carney","Mason Clay","Pat Mercer","Frances Oneal","Brandy Strong","Elvira Houston"}},
		{img = "https://bootdey.com/img/Content/avatar/avatar3.png", nomes = {"Joice Campos","Mélanie Rebotim","Berenice Holanda","Maitê Lage","Eduarda Barbosa","Livia Martins","Melissa Fernandes","Isabela Castro","Leila Fernandes","Letícia Correia","Melissa Cunha","Gabriela Azevedo"}},
		{img = "https://bootdey.com/img/Content/avatar/avatar2.png", nomes = {"Howell Dickerson","Carlson Kerr","Kitty Moody","Malinda Richards","Craig Watts","Alana Ratliff","Mindy Patton","Kelly Stone","Beasley Stark","Perez Mercer","Janell Norris","Angela Mayer","Opal Orr","Charity Lamb","Ford Castaneda","Mitzi Nelson","Corrine Morris","Nanette Cervantes","Evelyn Burton","Giles Fletcher","Franklin Hahn","Ruiz Simmons","Selena Murphy","Mccoy Clarke","Skinner Sanford","Lea Oneill","Williamson Rosales","Katharine Hendricks","Dillon Nguyen","Cannon Fulton","Sharp Mccray","Billie Schultz","Flora Griffith","Russell Beasley","Sampson Forbes","Duran Moore","Leach Todd","Henrietta Bowman","Margie Solomon","Mcdonald Collins","Willis Pratt","Britney Dixon","Mcleod Mejia","Salinas Albert","Padilla Lynn","Natalia Garrett","Lynnette Savage","Fleming Keith","Johnston Carrillo","Whitney Gomez"}},
		{img = "https://bootdey.com/img/Content/avatar/avatar1.png", nomes = {"Bennett Stevens","Mcmillan Calhoun","Paula Blanchard","Roberson Holman","Frost Woods","Drake Boyd","Maricela Long","Hess Guerrero","Martha Adams","Simmons Ramsey","Medina Pitts","Hazel Tyson","Mia Nguyen","Clare Shannon","Kristy Dorsey","Hilda Cochran","Sandy Zimmerman","Petra Lowery","Opal Collier","Velez Terry","Mccormick Hewitt","Weeks Garner","Ashley Byers","Guzman Blackburn","Ramona Stanley","Delia Ratliff","Talley Rodriquez","Ochoa Hayden","Thelma Stout","Lloyd Clarke","Gordon Gould","Aida Noel","Corinne Richmond","Malone Walls","Shields Bowen","Howell Harper","Figueroa Schwartz","Rachel Delgado","Debora Chaney","Chen Avery","Kidd Fitzgerald","Aguirre Park","Combs Cruz","Huff Thompson","Munoz Crosby","Whitaker Mason","Oneil York","Francis Houston","Prince White","Cornelia Bell"}}
	},
	['max_motoristas_ativos'] = 30,				-- Maximum number of drivers that can be active, this means that when generating a driver that exceeds this number, the oldest driver will be deleted
	['max_motoristas_por_player'] = 1			-- Maximum number of drivers the player can hire
}

-- Here is the definition of the contracts that are generated for drivers to carry out
Config.trabalhos = {
	['cooldown'] = 30,						-- Cooldown time (in minutes) for drivers to make contracts and generate money for the company

	-- It is recommended to keep the initial profit and the percentage higher than the values ​​configured for drivers in the above config
	['valor_inicial_min'] = 100,			-- Minimum initial contract profit
	['valor_inicial_max'] = 150,			-- Maximum initial contract profit
	['porcentagem_bonus_habilidades'] = 7,	-- Percentage that will be generated from profit for each skill that the driver has
}

Config.multiplicador_venda = 0.7	-- Value you receive when selling the used truck
Config.concessionaria = {			-- Truck dealership vehicles
	-- Here you can configure the vehicles of the dealership
	['actros'] = { 								-- This must be the vehicle's spawn name
		['name'] = 'Mercedes-Benz Actros',		-- Truck name
		['price'] = 180000,						-- Value
		['engine'] = "12.0 L MB OM 457 LA I6",	-- Engine configuration
		['transmission'] = "12-Speed",			-- Transmission configuration
		['hp'] = '401',							-- Horsepower
		['img'] = 'img/actros.jpg'				-- Vehicle image
	},
	-- The other vehicles follow the same pattern as the vehicle above
	['man'] = {
		['name'] = 'MAN TGX',
		['price'] = 280000,
		['engine'] = "16.2 L D2868 V8",
		['transmission'] = "12-Speed",
		['hp'] = '680',
		['img'] = 'img/man.jpg'
	},
	['t680'] = {
		['name'] = 'Kenworth T680',
		['price'] = 300000,
		['engine'] = "12.9 PACCAR MX-13 I6",
		['transmission'] = "10-Speed",
		['hp'] = '480',
		['img'] = 'img/t680.jpg'
	},
	['w900'] = {
		['name'] = 'Kenworth W900 6x2',
		['price'] = 400000,
		['engine'] = "15.0 Cummins ISX I6",
		['transmission'] = "18-Speed",
		['hp'] = '550',
		['img'] = 'img/w900.jpg'
	},
	['vnl780'] = {
		['name'] = 'Volvo VNL 780',
		['price'] = 350000,
		['engine'] = "13.0 D13TC I6",
		['transmission'] = "12-Speed",
		['hp'] = '455',
		['img'] = 'img/vnl780.jpg'
	},
	['daf'] = {
		['name'] = 'DAF XF Euro 6',
		['price'] = 240000,
		['engine'] = "12.9 PACCAR MX-13 I6",
		['transmission'] = "12-Speed",
		['hp'] = '530',
		['img'] = 'img/daf.jpg'
	}
}
Config.valor_reparo = { -- Value to repair 1% of each part (Example: if 40% of the part is damaged, the value to repair will be multiplied by 40)
	['engine'] = 200,
	['body'] = 100,
	['transmission'] = 50,
	['wheels'] = 80
}

--[[
	Amount of exp you need to reach each level
	Example:
	[1] = 100,
	[2] = 200,
	This means that to reach level 1 you need 100 EXP, to reach level 2 you need 200 EXP
	When leveling up, the player receives 1 skill point
	Level 30 is the maximum
]]
Config.exp_por_level = {
	[1] = 100,
	[2] = 350,
	[3] = 600,
	[4] = 850,
	[5] = 1100,
	[6] = 1600,
	[7] = 2100,
	[8] = 2600,
	[9] = 3100,
	[10] = 3500,
	[11] = 4500,
	[12] = 5500,
	[13] = 6500,
	[14] = 7500,
	[15] = 8500,
	[16] = 9500,
	[17] = 10500,
	[18] = 11500,
	[19] = 12500,
	[20] = 13500,
	[21] = 14500,
	[22] = 15500,
	[23] = 16500,
	[24] = 17500,
	[25] = 18500,
	[26] = 19500,
	[27] = 20500,
	[28] = 31500,
	[29] = 32500,
	[30] = 33500, -- Max
}

--[[
	Maximum loan amount a person can take per level (the higher the level, the bigger the loan)
	Example:
	[0] = 20000,
	[10] = 50000,
	[20] = 200000
	This means that at level 0 to level 10, you can get a loan of 20 thousand. From level 10 to 20, you can take a maximum of 50 thousand ....
]]
Config.max_emprestimo_por_level = {
	[0] = 50000,
	[10] = 100000,
	[20] = 150000,
	[30] = 400000
}

-- Loan amounts and amount that is charged per day
Config.emprestimos = {
	['cooldown'] = 86400, -- Time (in seconds) that the loan will be charged to the player (86400 = 24 hours)
	['valores'] = {
		--[[
			It is possible to configure 4 loan values ​​and each loan has its own settings
			Example:
			[1] = {
				20000,	[Loan amount]: 20,000
				240, 	[Amount that the player pays each day]: This amount must be greater than the amount below, so in this case, when finalizing the payment of all installments, the player will pay 24 thousand (4 thousand of interest)
				200 	[Base amount to calculate interest]: The above value subtracted from this (240 - 200) will be the amount of interest: 40 interest per day
			},
		]]
		[1] = {50000,790,700},
		[2] = {100000,8500,7400},
		[3] = {150000,12000,11000},
		[4] = {400000,30000,25000}
	}
}

--[[
	Skill level and kms you can travel at each level
	Example:
	[0] = 4,
	[1] = 5,
	This means that at level 0 the player can initiate contracts of a maximum of 4 km, at level 1, he can take contracts of 5 km
	Level 6 is the maximum
]]
Config.habilidade_distancia = {
	[0] = 7.5,
	[1] = 8.5,
	[2] = 10,
	[3] = 13,
	[4] = 15,
	[5] = 19,
	[6] = 99 -- Max
}

--[[
	EXP gain in %
	XP is calculated based on the value of the delivery, so if he receive 1000 in one delivery, he will earn 50 XP
	This XP will be increased based on the bonuses configured below
]]
Config.exp = 5

-- EXP bonuses and money each skill gives
Config.bonus = {
	-- This bonus will be applied according to the level and requirements of the load. Then, when transporting a fragile cargo, he will receive the fragile cargo bonus (these values ​​are in%)
	['distance'] = {
		['dinheiro'] = {
			[1] = 5,
			[2] = 5,
			[3] = 10,
			[4] = 15,
			[5] = 15,
			[6] = 50
		},
		['exp'] = {
			[1] = 10,
			[2] = 10,
			[3] = 15,
			[4] = 15,
			[5] = 20,
			[6] = 20
		}
	},
	['valuable'] = {
		['dinheiro'] = {
			[1] = 5,
			[2] = 10,
			[3] = 10,
			[4] = 15,
			[5] = 15,
			[6] = 50
		},
		['exp'] = {
			[1] = 5,
			[2] = 10,
			[3] = 10,
			[4] = 15,
			[5] = 15,
			[6] = 20
		}
	},
	['fragile'] = {
		['dinheiro'] = {
			[1] = 5,
			[2] = 10,
			[3] = 10,
			[4] = 15,
			[5] = 15,
			[6] = 50
		},
		['exp'] = {
			[1] = 20,
			[2] = 20,
			[3] = 20,
			[4] = 20,
			[5] = 20,
			[6] = 20
		}
	},
	['fast'] = {
		['dinheiro'] = {
			[1] = 5,
			[2] = 10,
			[3] = 10,
			[4] = 15,
			[5] = 15,
			[6] = 50
		},
		['exp'] = {
			[1] = 5,
			[2] = 10,
			[3] = 10,
			[4] = 15,
			[5] = 15,
			[6] = 20
		}
	}
}

-- Cargo delivery locations
Config.locais_entrega = {
	{-1792.01,3097.43,32.85,239.61},
	{-968.32,-3043.02,13.95,149.11},
	{-3052.34,603.17,7.53,107.35},
	{-2312.81,431.94,174.71,174.25},
	{-1821.18,781.97,138.07,41.47},
	{-442.8,6144.61,31.74,46.58},
	{2449.78,-376.47,93.24,181.11},
	{683.01,670.43,129.17,9.87},
	{1731.1572, 2609.625, 45.564853, 86.440277},
	{786.73,1292.54,360.55,35.28},
	{3330.0092, 5152.4223, 18.288873, 325.87191},
	{3486.690,3686.905,34.142,263.330}, 
	{2743.115,1433.920,24.747,345.973}, 
	{211.726,2803.361,45.906,281.661}, 
	{1026.959,2657.273,39.805,181.776}, 
	{-264.318,2189.407,130.091,39.559}, 
	{-2537.107,2346.067,33.318,31.918}, 
	{-186.8515, 6552.6806, 11.097853, 313.91912}, 
	{2205.9631, 5602.1088, 53.730636, 355.32479}, 
	{-691.903, 5768.9062, 17.330951, 238.96449},
	{-390.5007, 4350.4042, 57.485347, 9.6905765},

	{1372.186,3618.715,35.141,15.930}, 
	{2006.530,4729.575,41.530,119.142}, 
	{2533.847,2577.926,38.191,169.542}, 
	{236.275,3111.351,42.643,5.897}, 
	{2674.260,3459.789,55.962,66.257}, 
	{1687.774,3268.127,41.115,105.087}, 

	{2004.329,4988.590,41.661,52.739}, 
	{-601.439,5316.849,70.648,1.013}, 
	{3809.001,4472.068,4.450,296.663}, 
	{205.556,6382.305,31.680,209.944}, 
	{-1581.105,5164.470,19.792,15.660}, 
	{1718.476,6423.122,33.522,336.694}, 
	{1529.753,6331.846,24.530,248.464}, 
	{714.865,4177.058,40.957,103.427}, 
	{1643.981,4823.611,42.264,97.422}, 
	{-97.212,6397.223,31.696,219.997},
	{-379.9602, 2815.1564, 45.308158, 322.66949},

	
	{-498.38, -2197.3, 6.5596628, 226.34635}, 	
	{-124.4537, 6215.0468, 31.20181, 228.41818},
	{421.91098, 6498.1206, 27.755144, 354.20578},
	{-768.5321, 5589.4594, 33.485713, 354.2611},
	{2754.0581, 3455.5563, 55.924274, 334.82409},
	{-1146.608, 4923.8647, 220.94647, 89.917526},
	{3806.259, 4461.4721, 4.4914293, 279.03948},
	{-1910.28, 2056.2067, 140.73796, 11.536472},
	{866.54388, 2338.9687, 51.668857, 91.268074},
	{401.34027, 6641.4331, 28.316982, 0.2025156},
	{-193.4497, 6283.4125, 31.489265, 161.61509},
	{-433.2887, 6136.9604, 31.478321, 46.346233},
	{-276.7421, 6035.3691, 31.551378, 224.7028},
	{1718.7333, 6421.4291, 33.370429, 331.17587},
	{-212.2534, 6461.2211, 30.753614, 49.815631},
	{107.58162, 6641.6909, 31.018922, 317.88742},
	{-272.9425, 6330.4467, 32.001609, 136.15022},
	{-32.36394, 6442.2583, 30.987724, 136.84292},
	{1709.0958, 4804.4208, 41.374622, 273.26849},
	{2111.311, 4769.8461, 40.77605, 283.56356},
	{1722.3431, 4705.6059, 42.079864, 289.66436},
	{1775.5627, 4594.7207, 37.310649, 4.9572734},


}

Config.blips = {
	{1188.9656, -3251.356, 6.0287666,478,2,"Công ty vận chuyển",0.8 },

}