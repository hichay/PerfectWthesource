Config                            = {}
Config.FishingZone = {'PALCOV', 'OCEANA', "ALAMO"} 


Config.ALAMO = {
	-- small fish 
	[1] = {["idname"] = "fishingherring",["name"] = "Cá trích",["sizeMin"] = 50,["sizeMax"] = 150,["chance"] = 20,["speed"] = math.random(1,2),["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	[2] = {["idname"] = "fishinghalibut",["name"] = "Cá bơn vĩ",["sizeMin"] = 50,["sizeMax"] = 150,["chance"] = 20,["speed"] = math.random(1,2),["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	[3] = {["idname"] = "fishingredfish",["name"] = "Cá da đỏ",["sizeMin"] = 50,["sizeMax"] = 150,["chance"] = 15,["speed"] = math.random(1,2),["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	[4] = {["idname"] = "fishingminnow",["name"] = "Cá tuế",["sizeMin"] = 50,["sizeMax"] = 150,["chance"] = 60,["speed"] = math.random(1,2),["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	[5] = {["idname"] = "fishingeel",["name"] = "Lươn biển",["sizeMin"] = 50,["sizeMax"] = 150,["chance"] = 60,["speed"] = math.random(1,2),["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	-- Noraml Sized Fish

	[6] = {["idname"] = "fishingsalmon",["name"] = "Cá hồi",["sizeMin"] = 100,["sizeMax"] = 200,["chance"] = 40,["speed"] = math.random(1,2),["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	[7] = {["idname"] = "fishingflounder",["name"] = "cá bơn",["sizeMin"] = 100,["sizeMax"] = 200,["chance"] = 55,["speed"] = math.random(1,2),["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	[8] = {["idname"] = "fishingcod",["name"] = "Cá tuyết",["sizeMin"] = 100,["sizeMax"] = 200,["chance"] = 50,["speed"] = math.random(1,2),["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	[9] = {["idname"] = "fishingmackerel",["name"] = "Cá ngừ chù",["sizeMin"] = 100,["sizeMax"] = 200,["chance"] = 60,["speed"] = math.random(1,2),["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	[10] = {["idname"] = "fishingbass",["name"] = "Cá vược",["sizeMin"] = 100,["sizeMax"] = 200,["chance"] = 65,["speed"] = math.random(1,2),["multiprice"] = 0.1, ["Zone"] = "ALAMO"},

}

Config.PALCOV = {
	-- Noraml Sized Fish

	[1] = {["idname"] = "fishingsalmon",["name"] = "Cá hồi",["sizeMin"] = 200,["sizeMax"] = 500,["chance"] = 40,["speed"] = math.random(1,3),["multiprice"] = 0.1, ["Zone"] = "PALCOV"},
	[2] = {["idname"] = "fishingflounder",["name"] = "cá bơn",["sizeMin"] = 200,["sizeMax"] = 500,["chance"] = 55,["speed"] = math.random(1,3),["multiprice"] = 0.1, ["Zone"] = "PALCOV"},
	[3] = {["idname"] = "fishingcod",["name"] = "Cá tuyết",["sizeMin"] = 200,["sizeMax"] = 500,["chance"] = 50,["speed"] = math.random(1,3),["multiprice"] = 0.1, ["Zone"] = "PALCOV"},
	[4] = {["idname"] = "fishingmackerel",["name"] = "Cá ngừ chù",["sizeMin"] = 200,["sizeMax"] = 500,["chance"] = 60,["speed"] = math.random(1,3),["multiprice"] = 0.1, ["Zone"] = "PALCOV"},
	[5] = {["idname"] = "fishingbass",["name"] = "Cá vược",["sizeMin"] = 200,["sizeMax"] = 500,["chance"] = 65,["speed"] = math.random(1,3),["multiprice"] = 0.1, ["Zone"] = "PALCOV"},

	-- Large Fish

	[6] = {["idname"] = "fishingbarbel",["name"] = "Cá râu",["sizeMin"] = 500,["sizeMax"] = 1000,["chance"] = 80,["speed"] = math.random(1,3),["multiprice"] = 0.1, ["Zone"] = "PALCOV"},
	[7] = {["idname"] = "fishingtigerfish",["name"] = "Cá hổ",["sizeMin"] = 500,["sizeMax"] = 1000,["chance"] = 74,["speed"] = math.random(1,3),["multiprice"] = 0.1, ["Zone"] = "PALCOV"},
	[8] = {["idname"] = "fishingmahseer",["name"] = "Cá chép rồng",["sizeMin"] = 500,["sizeMax"] = 1000,["chance"] = 78,["speed"] = math.random(1,3),["multiprice"] = 0.1, ["Zone"] = "PALCOV"},
	[9] = {["idname"] = "fishinghake",["name"] = "Cá mecluc",["sizeMin"] = 500,["sizeMax"] = 1000,["chance"] = 75,["speed"] = math.random(1,3),["multiprice"] = 0.1, ["Zone"] = "PALCOV"},
	[10] = {["idname"] = "fishingbillfish",["name"] = "Cá kiếm",["sizeMin"] = 500,["sizeMax"] = 1000,["chance"] = 78,["speed"] = math.random(1,3),["multiprice"] = 0.1, ["Zone"] = "PALCOV"},

}

Config.OCEANA = {
	-- Large Fish

	[1] = {["idname"] = "fishingbarbel",["name"] = "Cá râu",["sizeMin"] = 1000,["sizeMax"] = 2000,["chance"] = 80,["speed"] = math.random(2,3),["multiprice"] = 0.1, ["Zone"] = "OCEANA"},
	[2] = {["idname"] = "fishingtigerfish",["name"] = "Cá hổ",["sizeMin"] = 1000,["sizeMax"] = 2000,["chance"] = 74,["speed"] = math.random(2,3),["multiprice"] = 0.1, ["Zone"] = "OCEANA"},
	[3] = {["idname"] = "fishingmahseer",["name"] = "Cá chép rồng",["sizeMin"] = 1000,["sizeMax"] = 2000,["chance"] = 78,["speed"] = math.random(2,3),["multiprice"] = 0.1, ["Zone"] = "OCEANA"},
	[4] = {["idname"] = "fishinghake",["name"] = "Cá mecluc",["sizeMin"] = 1000,["sizeMax"] = 2000,["chance"] = 75,["speed"] = math.random(2,3),["multiprice"] = 0.1, ["Zone"] = "OCEANA"},
	[5] = {["idname"] = "fishingbillfish",["name"] = "Cá kiếm",["sizeMin"] = 1000,["sizeMax"] = 2000,["chance"] = 78,["speed"] = math.random(2,3),["multiprice"] = 0.1, ["Zone"] = "OCEANA"},
	

	-- Super Rare , Crazy Fish
	[6] = {["idname"] = "fishingredcod",["name"] = "Cá tuyết đỏ",["sizeMin"] = 2000,["sizeMax"] = 5000,["chance"] = 98,["speed"] = math.random(2,3),["multiprice"] = 0.1, ["Zone"] = "OCEANA"},
	[7] = {["idname"] = "fishingdolphin",["name"] = "Cá heo",["sizeMin"] = 2000,["sizeMax"] = 5000,["chance"] = 90,["speed"] = math.random(2,3),["multiprice"] = 0.1, ["Zone"] = "OCEANA"},
	[8] = {["idname"] = "fishingshark",["name"] = "Cá mập",["sizeMin"] = 2000,["sizeMax"] = 5000,["chance"] = 90,["speed"] = math.random(2,3),["multiprice"] = 0.1, ["Zone"] = "OCEANA"},
	[9] = {["idname"] = "fishingwhale",["name"] = "Cá voi",["sizeMin"] = 2000,["sizeMax"] = 5000,["chance"] = 95,["speed"] = math.random(2,3),["multiprice"] = 0.1, ["Zone"] = "OCEANA"},
	[10] = {["idname"] = "fishingtuna",["name"] = "Cá ngừ đại dương",["sizeMin"] = 2000,["sizeMax"] = 5000,["chance"] = 95,["speed"] = math.random(2,3),["multiprice"] = 0.1, ["Zone"] = "OCEANA"},
}

Config.fishTable = {
	-- small fish 
	[1] = {["idname"] = "fishingherring",["name"] = "Cá trích",["sizeMin"] = 50,["sizeMax"] = 150,["chance"] = 20,["baseprice"] = 37,["multiprice"] = 0.1},
	[2] = {["idname"] = "fishinghalibut",["name"] = "Cá bơn vĩ",["sizeMin"] = 50,["sizeMax"] = 150,["chance"] = 20,["baseprice"] = 37,["multiprice"] = 0.1},
	[3] = {["idname"] = "fishingredfish",["name"] = "Cá da đỏ",["sizeMin"] = 50,["sizeMax"] = 150,["chance"] = 15,["baseprice"] = 37,["multiprice"] = 0.1},
	[4] = {["idname"] = "fishingminnow",["name"] = "Cá tuế",["sizeMin"] = 50,["sizeMax"] = 150,["chance"] = 60,["baseprice"] = 39,["multiprice"] = 0.1},
	[5] = {["idname"] = "fishingeel",["name"] = "Lươn biển",["sizeMin"] = 50,["sizeMax"] = 150,["chance"] = 60,["baseprice"] = 39,["multiprice"] = 0.1},
	-- Noraml Sized Fish

	[6] = {["idname"] = "fishingsalmon",["name"] = "Cá hồi",["sizeMin"] = 100,["sizeMax"] = 500,["chance"] = 40,["baseprice"] = 43,["multiprice"] = 0.1},
	[7] = {["idname"] = "fishingflounder",["name"] = "cá bơn",["sizeMin"] = 100,["sizeMax"] = 500,["chance"] = 55,["baseprice"] = 46,["multiprice"] = 0.1},
	[8] = {["idname"] = "fishingcod",["name"] = "Cá tuyết",["sizeMin"] = 100,["sizeMax"] = 500,["chance"] = 50,["baseprice"] = 45,["multiprice"] = 0.1},
	[9] = {["idname"] = "fishingmackerel",["name"] = "Cá ngừ chù",["sizeMin"] = 100,["sizeMax"] = 500,["chance"] = 60,["baseprice"] = 48,["multiprice"] = 0.1},
	[10] = {["idname"] = "fishingbass",["name"] = "Cá vược",["sizeMin"] = 100,["sizeMax"] = 500,["chance"] = 65,["baseprice"] = 55,["multiprice"] = 0.1},

	-- Large Fish

	[11] = {["idname"] = "fishingbarbel",["name"] = "Cá râu",["sizeMin"] = 500,["sizeMax"] = 2000,["chance"] = 80,["baseprice"] = 72,["multiprice"] = 0.1},
	[12] = {["idname"] = "fishingtigerfish",["name"] = "Cá hổ",["sizeMin"] = 500,["sizeMax"] = 2000,["chance"] = 74,["baseprice"] = 70,["multiprice"] = 0.1},
	[13] = {["idname"] = "fishingmahseer",["name"] = "Cá chép rồng",["sizeMin"] = 500,["sizeMax"] = 2000,["chance"] = 78,["baseprice"] = 69,["multiprice"] = 0.1},
	[14] = {["idname"] = "fishinghake",["name"] = "Cá mecluc",["sizeMin"] = 500,["sizeMax"] = 2000,["chance"] = 75,["baseprice"] = 69,["multiprice"] = 0.1},
	[15] = {["idname"] = "fishingbillfish",["name"] = "Cá kiếm",["sizeMin"] = 500,["sizeMax"] = 2000,["chance"] = 78,["baseprice"] = 68,["multiprice"] = 0.1},
	

	-- Super Rare , Crazy Fish
	[16] = {["idname"] = "fishingredcod",["name"] = "Cá tuyết đỏ",["sizeMin"] = 2000,["sizeMax"] = 5000,["chance"] = 98,["baseprice"] = 120,["multiprice"] = 0.1},
	[17] = {["idname"] = "fishingdolphin",["name"] = "Cá heo",["sizeMin"] = 2000,["sizeMax"] = 5000,["chance"] = 93,["baseprice"] = 100,["multiprice"] = 0.1},
	[18] = {["idname"] = "fishingshark",["name"] = "Cá mập",["sizeMin"] = 2000,["sizeMax"] = 5000,["chance"] = 94,["baseprice"] = 100,["multiprice"] = 0.1},
	[19] = {["idname"] = "fishingwhale",["name"] = "Cá voi",["sizeMin"] = 2000,["sizeMax"] = 5000,["chance"] = 95,["baseprice"] = 100,["multiprice"] = 0.1},
	[20] = {["idname"] = "fishingtuna",["name"] = "Cá ngừ đại dương",["sizeMin"] = 2000,["sizeMax"] = 5000,["chance"] = 90,["baseprice"] = 70,["multiprice"] = 0.1},
}




Config.randomMessage = {
	[1] = {["idname"] = "fishingboot",["message"] = "Bạn vừa câu được một đôi ủng rách."},
	[2] = {["idname"] = "fishinglog",["message"] = "Bạn vừa câu được một khúc gỗ cũ"},
	[3] = {["idname"] = "fishingtin",["message"] = "Bạn vừa câu được một chiếc hộp thiếc."},
	[4] = {["idname"] = "-102323637",["message"] = "Bạn vừa câu được một cái chai vỡ."},
	[5] = {["idname"] = "bodygarbagebag",["message"] = "Bạn vừa câu được một túi rác"},
	[6] = {["idname"] = "humanskull",["message"] = "Bạn vừa câu được một cái đầu lâu."},
	[7] = {["idname"] = "bodybag",["message"] = "Bạn vừa câu được một túi khả nghi"},
    [8] = {["idname"] = "bodybag",["message"] = "Bạn vừa câu được một túi khả nghi"},
	[9] = {["idname"] = "humanbones",["message"] = "Bạn vừa câu được cái gì đấy"},
	[10] = {["idname"] = "humanbone",["message"] = "Bạn vừa câu được cái gì đấy"},

}

Config.BoatSpawn  = {
				{coords = vector3(705.17419, 4091.455, 30.681236), heading = 103.91, radius = 6.0},
				{coords = vector3(706.17077, 4102.1855, 30.681236), heading = 103.91, radius = 6.0},
				{coords = vector3(705.71441, 4110.4487, 30.681236), heading = 103.91, radius = 6.0},
				{coords = vector3(706.72174, 4119.7919, 30.681236), heading = 103.91, radius = 6.0}
				}

Config.BoatDelete  = {
	coords = vector3(708.38134, 4110.8911, 30.670038),

}
