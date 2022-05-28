Config = {}

Config.webhook = "SEU_WEBHOOK"					-- Webhook para enviar logs para o Discord
Config.lang = "br"								-- Defina o idioma do arquivo [en/br]
Config.ESXSHAREDOBJECT = "esx:getSharedObject" 	-- Altere seu evento de objeto gethared aqui, caso você esteja usando anti-cheat

Config.formatacao = {
	['moeda'] = 'BRL',			-- Este é o formato da moeda, para que o símbolo da sua moeda apareça corretamente [Exemplos: BRL, USD]
	['location'] = 'pt-BR'		-- Esta é a localização do seu país, para formatar as casas decimais de acordo com seu padrão [Exemplos: pt-BR, en-US]
}

-- Aqui estão os locais onde a pessoa pode abrir o menu do caminhoneiro
-- Você pode adicionar quantos locais quiser, basta usar o local já criado como exemplo
Config.empresas = {
	["trucker_1"] = {															-- ID
		['nome'] = "Porto",														-- Nome
		['coordenada'] = {1208.7689208984,-3114.9829101562,5.5403342247009},	-- Coordenadas para abrir o menu
		['coordenada_garagem'] = {												-- Coordenadas de garagem, onde os caminhões irão spawnar (coordenadas compostas por x, y, z, h)
			{1204.2672119141,-3098.9084472656,5.8497104644775,358.9},
			{1196.4533691406,-3100.08984375,5.8681297302246,358.9},
		},
		['coordenada_cargas'] = {												-- Coordenadas do trailer, onde os trailers irão spawnar (coordenadas compostas por x, y, z, h)
			{1188.9841308594,-3101.6787109375,5.8936386108398,358.9},
			{1181.0998535156,-3102.5339355469,6.0280232429504,358.9},
		}
	}
}

-- Aqui está a definição dos contratos que são gerados para que os jogadores entreguem
Config.contratos = {
	['cancel_contrato'] = 167,					-- Tecla para cancelar o trabalho atual (167 = F6) [Segurar a tecla durante 2 segundos]
	['cooldown'] = 10, 							-- Tempo de espera (em minutos) para gerar um novo contrato
	['preco_por_km_min'] = 500,					-- Preço mínimo por quilômetro do contrato
	['preco_por_km_max'] = 800,					-- Preço máximo por quilômetro do contrato
	['probabilidade_ser_carga_urgente'] = 25,	-- A carga urgente é gerada aleatoriamente, aqui você pode configurar a probabilidade (%)
	['max_contratos_ativos'] = 25,				-- Máximo de contratos que podem estar ativos, isso significa que ao gerar um contato que ultrapasse este número, o contrato mais antigo será excluído
	['caminhoes'] = {							-- Lista de caminhões que são gerados em contratos
		"actros","man","daf","t680","vnl780","w900"
	},
	['cargas'] = {
		--[[ 
			Lista de cargas que são geradas nos contratos.
			carga: é o nome do trailer
			nome: é o nome que aparecerá na lista para o jogador selecionar
			def: são as definições de carga, para configurar se é um certificado ADR, carga frágil ou valiosa
			Def é composto por 3 valores
			def = {
				0, [Primeiro valor]: Tipo de certificado ADR. 0 = Nenhum, 1 = Explosivos, 2 = Gases inflamáveis, 3 = Líquidos inflamáveis, 4 = Sólidos inflamáveis, 5 = Substâncias tóxicas, 6 = Substâncias corrosivas
				0, [Segundo valor]:  Carga frágil: 0 = Não frágil, 1 = É frágil
				0  [Terceiro valor]: Carga valiosa: 0 = Não tem valor, 1 = É valioso
			}
		]]
		{ carga = "armytanker", nome = "Tanque de combustível do exército", def = {3,0,0}},
		{ carga = "armytanker", nome = "Abastecimento de água do exército", def = {0,0,0}},
		{ carga = "armytanker", nome = "Tanque de materiais corrosivos do exército", def = {6,0,1}},
		{ carga = "armytanker", nome = "Tanque de gases inflamáveis do exército", def = {2,0,0}},
		{ carga = "armytanker", nome = "Tanque de gases tóxicos do exército", def = {5,0,0}},
		{ carga = "armytanker", nome = "Materiais secretos do exército", def = {0,0,1}},

		{ carga = "liquide1", nome = "Hidróxido de potássio", def = {6,0,0}},
		{ carga = "liquide1", nome = "Nitrogênio", def = {2,0,1}},
		{ carga = "liquide1", nome = "Cloreto de potássio", def = {5,0,0}},
		{ carga = "liquide1", nome = "Veneno", def = {5,0,0}},
		{ carga = "liquide1", nome = "Pesticida", def = {5,0,0}},

		{ carga = "armytrailer", nome = "Trailer vazio do exército", def = {0,0,0}},

		{ carga = "armytrailer2", nome = "Transporte de máquinário pesado", def = {0,1,1}},
		{ carga = "armytrailer2", nome = "Transporte de tuneladora", def = {0,1,1}},

		{ carga = "docktrailer", nome = "Transporte de móveis", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Transporte de geladeiras", def = {0,1,0}},
		{ carga = "docktrailer", nome = "Transporte de tijolos", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Transporte de produtos importados", def = {0,0,1}},
		{ carga = "docktrailer", nome = "Transporte de plásticos", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Transporte de roupas", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Transporte de cadeiras", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Transporte de eletrodomésticos", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Transporte de materiais de limpeza", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Transporte de madeira refinada", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Transporte de pedras", def = {0,0,0}},
		{ carga = "docktrailer", nome = "Transporte de jóias", def = {0,1,1}},
		{ carga = "docktrailer", nome = "Transporte de vidros", def = {0,1,0}},
		{ carga = "docktrailer", nome = "Transporte de munição", def = {1,0,0}},

		{ carga = "freighttrailer", nome = "Trailer vazio", def = {0,0,0}},

		{ carga = "tr2", nome = "Trailer de carros vazio", def = {0,0,0}},

		{ carga = "trailers4", nome = "Trailer de artigos navais", def = {0,0,0}},
		{ carga = "trailers4", nome = "Trailer de barco", def = {0,1,1}},

		{ carga = "tr4", nome = "Cegonheira", def = {0,1,1}},
		
		{ carga = "tvtrailer", nome = "Transporte de materiais para shows", def = {0,0,1}},
		{ carga = "tvtrailer", nome = "Transporte de materiais de eventos", def = {0,1,1}},

		{ carga = "tanker", nome = "Tanque de combustível aditivado", def = {3,0,0}},
		{ carga = "tanker2", nome = "Tanque de combustível comum", def = {3,0,0}},
		{ carga = "tanker2", nome = "Tanque de querosene", def = {3,0,0}},
		{ carga = "tanker2", nome = "Tanque de óleo", def = {3,0,0}},

		{ carga = "docktrailer", nome = "Transporte de materiais exóticos", def = {0,1,1}},
		{ carga = "docktrailer", nome = "Transporte de materiais raros", def = {0,1,1}},
		{ carga = "docktrailer", nome = "Transporte de armamentos", def = {0,0,1}},

		{ carga = "trailerlogs", nome = "Transporte de toras de madeira", def = {0,0,0}},

		{ carga = "trailers", nome = "Transporte de materiais de construção", def = {0,0,0}},
		{ carga = "trailers", nome = "Transporte de borracha", def = {0,0,0}},
		{ carga = "trailers", nome = "Transporte de eletrodomésticos", def = {0,1,0}},
		{ carga = "trailers", nome = "Transporte de vacinas", def = {0,1,0}},
		{ carga = "trailers", nome = "Transporte de explosivos", def = {1,1,0}},
		{ carga = "trailers", nome = "Transporte de serragem", def = {0,0,0}},

		{ carga = "trailers2", nome = "Transporte de uvas", def = {0,0,0}},
		{ carga = "trailers2", nome = "Transporte de carne de porco", def = {0,0,0}},
		{ carga = "trailers2", nome = "Transporte de carne de boi", def = {0,0,0}},
		{ carga = "trailers2", nome = "Transporte de cenouras", def = {0,0,0}},
		{ carga = "trailers2", nome = "Transporte de batatas", def = {0,0,0}},
		{ carga = "trailers2", nome = "Transporte de leite", def = {0,0,0}},
		{ carga = "trailers2", nome = "Transporte de produtos enlatados", def = {0,0,0}},
		{ carga = "trailers2", nome = "Transporte de carne congelada", def = {0,0,0}},
		{ carga = "trailers2", nome = "Transporte de feijão", def = {0,0,0}},
		{ carga = "trailers2", nome = "Transporte de vinagre", def = {0,0,0}},
		{ carga = "trailers2", nome = "Transporte de limonada", def = {0,0,0}},
		{ carga = "trailers2", nome = "Transporte de agua engarrafada", def = {0,0,0}},
		{ carga = "trailers2", nome = "Transporte de queijo", def = {0,0,0}},

		{ carga = "trailers3", nome = "Transporte de telhas", def = {0,0,0}},
		{ carga = "trailers3", nome = "Transporte de calhas", def = {0,0,0}},
		{ carga = "trailers3", nome = "Transporte de embalagens usadas", def = {0,0,0}},
		{ carga = "trailers3", nome = "Transporte de placas de piso", def = {0,0,0}},
		{ carga = "trailers3", nome = "Transporte de cerâmica", def = {0,1,0}},
		{ carga = "trailers3", nome = "Transporte de sucata", def = {0,0,0}},

		{ carga = "trailers4", nome = "Transporte de fogos de artifício", def = {1,1,0}},
		{ carga = "trailers4", nome = "Transporte de explosivos", def = {1,1,0}},
		{ carga = "trailers4", nome = "Transporte de dinamite", def = {1,1,0}},
		{ carga = "trailers4", nome = "Transporte de fósforo branco", def = {4,1,0}},

		{ carga = "heli1", nome = "Transporte de Helicóptero", def = {0,1,1}},
		{ carga = "militaire1", nome = "Transporte de viatura do exercito", def = {0,1,1}},
	}
}

-- Aqui está a definição dos motoristas que são gerados para os jogadores contratarem
Config.motoristas = {
	['cooldown'] = 10,							-- Tempo de espera (em minutos) para gerar um novo motorista
	['preco_por_km_min'] = 50,					-- Preço mínimo inicial por KM do motorista (no final de cada entrega)
	['preco_por_km_max'] = 60,					-- Preço máximo inicial por KM do motorista (no final de cada entrega)
	['preco_min'] = 500,						-- Preço mínimo inicial do motorista (no final de cada entrega)
	['preco_max'] = 600,						-- Preço máximo inicial do motorista (no final de cada entrega)
	['porcentagem_bonus_habilidades'] = 5,		-- Este é o custo em % que cada habilidade aumentará no salário do motorista. Ou seja, para cada habilidade que ele possui, o preço inicial aumentará 5%
	['nomes'] = {
		-- Lista de motoristas que são gerados aleatoriamente para serem contratados
		{img = "https://bootdey.com/img/Content/avatar/avatar8.png", nomes = {"Pedro Aquino","Jorge Fernandes","Lucas Silva","Cochran Hicks","Shirley Austin","Grimes Williamson","Kirk Cook","Davis Guerrero","Rocha Good","Hatfield Clarke","Norton Anthony","Parks Dale","Ellison Harrison","Rojas Boyd","Moon Acevedo","Carole Rivas","Wells Wyatt","Beasley Griffith","Jordan Hyde","Holman Dixon","Holden Lynch","Mckenzie Wilkerson","Chapman Preston","Christian Green","Blake Stuart","Paulette Atkinson","Dollie Lane","Castaneda Browning","Baldwin Blankenship","Russell Bowen","Madge Boyle","Nanette Cummings","Brooke Spence","Whitfield Berg","Angie Gonzales","Johanna Mercer","Terrell Mcmillan","Gilmore Quinn","Kenya Pittman","Hurley Black","Shanna Ortega","Logan Sharpe","Mari Brady","Mendoza Wilkinson","Stacie Sanford","Polly Acosta","Stone Robinson","Claudette Bartlett","Young Hines","Potter Wagner","Reilly Callahan","Kerr Kemp","Goff Raymond"}},
		{img = "https://bootdey.com/img/Content/avatar/avatar7.png", nomes = {"Ivan Noleto Sequeira","Kim Wolfe","Laura Logan","Bruce Craft","Compton Luna","Randolph Callahan","Mccray Brock","Sybil Miles","Hendricks Henry","Tina Compton","Phelps Hunter","Jones Russo","Esmeralda Banks","Reid Dean","Parrish Cole","Carlson Gilbert","Jackie Macias","Liza Morse","Mclean Warner","Winnie Lopez","Katheryn Valenzuela","Wade Mccoy","Acosta Mays","Valeria Witt","Elnora Howard","Bernadette Dawson","Rivera Casey","Little Sanford","Deanna Petty","Leonard Blackwell","Payne Leblanc","Tammy Murphy","Sargent Donaldson","Colon Carey","Janis Roth","Lidia Higgins","Lakisha Whitaker","Adrian Mcbride","Maria Forbes","Daisy Mason","Pittman Curtis","Ladonna Bryan","Gaines Hogan","Powers Rodriquez","Donna Hopper","Kristi Livingston","Chelsea Bauer","Gray Fleming","Contreras Mcdonald","Vilma Potts","Guadalupe Mullins"}},
		{img = "https://bootdey.com/img/Content/avatar/avatar6.png", nomes = {"Kenya Mullen","Castaneda Colon","Judy Mckay","Taylor Kerr","Hurst Roy","Owens Vaughan","Vanessa Cline","Bertie Edwards","Flynn Frank","Burks Sutton","Randi Meadows","Tessa Gentry","Lowery Wooten","Acosta Harper","Georgette Cooley","Candice Patterson","Kirsten Daniels","Blake West","Alexandria Pope","Lena Forbes","Morton Snyder","Tara Bradford","Selena Sykes","Tameka Atkinson","Fowler Walker","Gena Ortega","Sheppard Navarro","Imelda Duncan","Christina Bowers","Aline Haynes","Benita Bright","Boyd Mccall","Sandra Weaver","Melissa Wells","Graham Gilmore","Katrina Oliver","Ginger Larson","Griffith Bishop","Barbara Washington","Iris Christensen","Bauer Gay","Hays Vega","Valarie Booth","Kitty Crane","Carmella Torres","Angelina Puckett","Stone Cabrera","Brock Humphrey","Hillary Houston","Callie Robles"}},
		{img = "https://bootdey.com/img/Content/avatar/avatar5.png", nomes = {"Rocha Harrell","Gilliam Thomas","Osborne Blevins","Elba Chambers","Heath Price","Melinda Maynard","Ashlee Johns","Shelton Petty","Carey Mcclain","Blackwell Horne","Deborah Gonzalez","Buck Faulkner","Celina Chang","Kennedy Patrick","Atkinson Sherman","Janelle Tyson","Noelle Vincent","Leah Barron","Angeline Sellers","Trudy Murray","Contreras Hardy","Fletcher Todd","Benson Singleton","Sanford Dean","Hartman Wilkinson","Harriet Robinson","Vivian Osborn","Ida Simmons","Tamara Merrill","Esmeralda Baird","Maynard Oneal","Brianna Greene","Pat Stewart","Tate Wood","French Farrell","Jolene Calderon","Irene Roth","Dina Waller","Gonzalez Alvarez","Leigh Durham","Eve Moody","Lydia Hewitt","Price Summers","Duran Schultz","Rena Williamson","Meagan Shaffer","Angelique Dennis","Graham Love","Sheree Lynn","Church Golden"}},
		{img = "https://bootdey.com/img/Content/avatar/avatar4.png", nomes = {"Cecelia Carson","Rivas Kelly","Green Johnson","Jill Buck","Maddox Leblanc","Hope Aguirre","Aguilar Diaz","Valerie Wiggins","Crystal Sweeney","Sharlene Davidson","Ruthie Valdez","Allyson Haney","Bridgett Wright","Cooke Vargas","Hopkins Neal","Deloris Curry","Alba Warren","Lynette Preston","Candace Britt","Phyllis Mayer","Bailey Stephenson","Meredith Harrell","Conner Heath","Kelly Lynch","Kelli Salinas","Tamara Tran","Boone Sosa","Cora Barrera","John Francis","Tammi Parsons","Natalie Travis","Ivy Mccoy","William Nash","Reba Dillon","Kimberley Whitney","Karen Ellis","Alison Padilla","Spencer Camacho","Blackwell Mccray","Mcgowan Castaneda","Kent Thomas","Lauri Wiley","Atkins Lowery","Janell Hancock","Mosley Carney","Mason Clay","Pat Mercer","Frances Oneal","Brandy Strong","Elvira Houston"}},
		{img = "https://bootdey.com/img/Content/avatar/avatar3.png", nomes = {"Joice Campos","Mélanie Rebotim","Berenice Holanda","Maitê Lage","Eduarda Barbosa","Livia Martins","Melissa Fernandes","Isabela Castro","Leila Fernandes","Letícia Correia","Melissa Cunha","Gabriela Azevedo"}},
		{img = "https://bootdey.com/img/Content/avatar/avatar2.png", nomes = {"Howell Dickerson","Carlson Kerr","Kitty Moody","Malinda Richards","Craig Watts","Alana Ratliff","Mindy Patton","Kelly Stone","Beasley Stark","Perez Mercer","Janell Norris","Angela Mayer","Opal Orr","Charity Lamb","Ford Castaneda","Mitzi Nelson","Corrine Morris","Nanette Cervantes","Evelyn Burton","Giles Fletcher","Franklin Hahn","Ruiz Simmons","Selena Murphy","Mccoy Clarke","Skinner Sanford","Lea Oneill","Williamson Rosales","Katharine Hendricks","Dillon Nguyen","Cannon Fulton","Sharp Mccray","Billie Schultz","Flora Griffith","Russell Beasley","Sampson Forbes","Duran Moore","Leach Todd","Henrietta Bowman","Margie Solomon","Mcdonald Collins","Willis Pratt","Britney Dixon","Mcleod Mejia","Salinas Albert","Padilla Lynn","Natalia Garrett","Lynnette Savage","Fleming Keith","Johnston Carrillo","Whitney Gomez"}},
		{img = "https://bootdey.com/img/Content/avatar/avatar1.png", nomes = {"Bennett Stevens","Mcmillan Calhoun","Paula Blanchard","Roberson Holman","Frost Woods","Drake Boyd","Maricela Long","Hess Guerrero","Martha Adams","Simmons Ramsey","Medina Pitts","Hazel Tyson","Mia Nguyen","Clare Shannon","Kristy Dorsey","Hilda Cochran","Sandy Zimmerman","Petra Lowery","Opal Collier","Velez Terry","Mccormick Hewitt","Weeks Garner","Ashley Byers","Guzman Blackburn","Ramona Stanley","Delia Ratliff","Talley Rodriquez","Ochoa Hayden","Thelma Stout","Lloyd Clarke","Gordon Gould","Aida Noel","Corinne Richmond","Malone Walls","Shields Bowen","Howell Harper","Figueroa Schwartz","Rachel Delgado","Debora Chaney","Chen Avery","Kidd Fitzgerald","Aguirre Park","Combs Cruz","Huff Thompson","Munoz Crosby","Whitaker Mason","Oneil York","Francis Houston","Prince White","Cornelia Bell"}}
	},
	['max_motoristas_ativos'] = 20,				-- Número máximo de motoristas que podem estar ativos, isso significa que ao gerar um driver que ultrapasse este número, o driver mais antigo será excluído
	['max_motoristas_por_player'] = 5			-- Número máximo de motoristas que cada player pode ter
}

-- Aqui está a definição dos contratos que são gerados para os motoristas realizarem
Config.trabalhos = {
	['cooldown'] = 1,						-- Tempo de espera (em minutos) para que os motoristas façam contratos e gerem dinheiro para a empresa

	-- Recomenda-se manter o lucro inicial e a porcentagem maior que os valores configurados para motoristas na configuração acima
	['valor_inicial_min'] = 500,			-- Lucro mínimo do contrato inicial
	['valor_inicial_max'] = 700,			-- Lucro máximo do contrato inicial
	['porcentagem_bonus_habilidades'] = 7,	-- Porcentagem que será gerada a partir do lucro para cada habilidade que o motorista possui
}

Config.multiplicador_venda = 0.8	-- Valor que você recebe ao vender o caminhão usado
Config.concessionaria = {			-- Veículos de concessionária de caminhões
	-- Aqui você pode configurar os veículos da concessionária
	['actros'] = { 								-- Este deve ser o nome de spawn do veículo
		['name'] = 'Mercedes-Benz Actros',		-- Nome do caminhão
		['price'] = 180000,						-- Preço
		['engine'] = "12.0 L MB OM 457 LA I6",	-- Configuração do motor
		['transmission'] = "12-Speed",			-- Configuração do motor
		['hp'] = '401',							-- Potência
		['img'] = 'img/actros.jpg'				-- Imagem do veículo
	},
	-- Os outros veículos seguem o mesmo padrão do veículo acima
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
Config.valor_reparo = { -- Valor a reparar 1% de cada peça (Exemplo: se 40% da peça estiver danificada, o valor a reparar será multiplicado por 40)
	['engine'] = 50,
	['body'] = 30,
	['transmission'] = 40,
	['wheels'] = 20
}

--[[
	Quantidade de exp que você precisa para alcançar cada nível
	Exemplo:
	[1] = 100,
	[2] = 200,
	Isso significa que para alcançar o nível 1 você precisa de 100 EXP, para chegar ao nível 2 você precisa de 200 EXP
	Ao subir de nível, o jogador recebe 1 ponto de habilidade
	O nível 30 é o máximo
]]
Config.exp_por_level = {
	[1] = 100,
	[2] = 200,
	[3] = 300,
	[4] = 400,
	[5] = 500,
	[6] = 600,
	[7] = 700,
	[8] = 800,
	[9] = 900,
	[10] = 1000,
	[11] = 1100,
	[12] = 1200,
	[13] = 1300,
	[14] = 1400,
	[15] = 1500,
	[16] = 1600,
	[17] = 1700,
	[18] = 1800,
	[19] = 1900,
	[20] = 2000,
	[21] = 2100,
	[22] = 2200,
	[23] = 2300,
	[24] = 2400,
	[25] = 2500,
	[26] = 2600,
	[27] = 2700,
	[28] = 2800,
	[29] = 2900,
	[30] = 3000 -- Max
}

--[[
	Montante máximo do empréstimo que uma pessoa pode tomar por nível (quanto mais alto o nível, maior o empréstimo)
	Exemplo:
	[0] = 20.000,
	[10] = 50000,
	[20] = 200.000
	Isso significa que do nível 0 ao nível 10, você pode obter um empréstimo de 20 mil. Do nível 10 ao 20, você pode levar no máximo 50 mil ....
]]
Config.max_emprestimo_por_level = {
	[0] = 20000,
	[10] = 50000,
	[20] = 200000,
	[30] = 500000
}

-- Valores do empréstimo e valor cobrado por dia
Config.emprestimos = {
	['cooldown'] = 86400, -- Tempo (em segundos) que o empréstimo será cobrado do jogador (86400 = 24 horas)
	['valores'] = {
		--[[
			É possível configurar 4 valores de empréstimo e cada empréstimo tem suas próprias configurações
			Exemplo:
			[1] = {
				20.000, [valor do empréstimo]: 20.000
				240, 	[Valor que o jogador paga por dia]: Este valor deve ser maior que o valor abaixo, portanto, neste caso, ao finalizar o pagamento de todas as parcelas, o jogador pagará 24 mil (4 mil de juros)
				200 	[valor base para calcular juros]: O valor acima subtraído deste (240 - 200) será o valor dos juros: 40 juros por dia
			},
		]]
		[1] = {20000,240,200},
		[2] = {50000,570,500},
		[3] = {100000,1120,1000},
		[4] = {400000,4400,4000}
	}
}

--[[
	Nível de habilidade e km que você pode perceorrer em cada nível
	Exemplo:
	[0] = 4,
	[1] = 5,
	Isso significa que no nível 0 o jogador pode iniciar contratos de no máximo 4 km, no nível 1 ele pode fazer contratos de 5 km
	O nível 6 é o máximo
]]
Config.habilidade_distancia = {
	[0] = 4,
	[1] = 5,
	[2] = 6,
	[3] = 8,
	[4] = 10,
	[5] = 12,
	[6] = 99 -- Max
}

--[[
	Ganho de EXP em %
	XP é calculado com base no valor da entrega, então se ele receber 1000 em uma entrega, ele ganhará 50 XP
	Este XP será aumentado com base nos bônus configurados abaixo
]]
Config.exp = 5

-- Bônus EXP e dinheiro que cada habilidade dá
Config.bonus = {
	-- Este bônus será aplicado de acordo com o nível e requisitos da carga. Então, ao transportar uma carga frágil, ele receberá o bônus de carga frágil (esses valores estão em %)
	['distance'] = {
		['dinheiro'] = {
			[1] = 5,
			[2] = 10,
			[3] = 15,
			[4] = 20,
			[5] = 25,
			[6] = 30
		},
		['exp'] = {
			[1] = 10,
			[2] = 10,
			[3] = 10,
			[4] = 10,
			[5] = 10,
			[6] = 10
		}
	},
	['valuable'] = {
		['dinheiro'] = {
			[1] = 5,
			[2] = 10,
			[3] = 15,
			[4] = 20,
			[5] = 25,
			[6] = 30
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
	['fragile'] = {
		['dinheiro'] = {
			[1] = 5,
			[2] = 10,
			[3] = 15,
			[4] = 20,
			[5] = 25,
			[6] = 30
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
			[3] = 15,
			[4] = 20,
			[5] = 25,
			[6] = 30
		},
		['exp'] = {
			[1] = 20,
			[2] = 20,
			[3] = 20,
			[4] = 20,
			[5] = 20,
			[6] = 20
		}
	}
}

-- Locais de entrega de carga
Config.locais_entrega = {
	{-1792.01,3097.43,32.85,239.61},
	{-968.32,-3043.02,13.95,149.11},
	{-3052.34,603.17,7.53,107.35},
	{-2312.81,431.94,174.71,174.25},
	{-1821.18,781.97,138.07,41.47},
	{-442.8,6144.61,31.74,46.58},
	{2449.78,-376.47,93.24,181.11},
	{683.01,670.43,129.17,9.87},
	{473.09,-3353.47,6.32,90.93},
	{786.73,1292.54,360.55,35.28},
	{-524.04,-2871.31,6.25,224.84},
	{964.38,-2247.11,30.81,84.61},
	{1733.72,-1536.72,112.96,71.08},
	{-883.59,-1487.33,5.28,288.35},

	{3486.690,3686.905,34.142,263.330}, 
	{2743.115,1433.920,24.747,345.973}, 
	{211.726,2803.361,45.906,281.661}, 
	{1026.959,2657.273,39.805,181.776}, 
	{-264.318,2189.407,130.091,39.559}, 
	{-2537.107,2346.067,33.318,31.918}, 
	{-1617.207,3099.605,32.680,2.830}, 
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
}

Config.blips = {
	{1208.7109375,-3114.9431152344,5.7480750083923,478,4,"Caminhoneiro",0.5 },
}