Config = {}
Config["debug"] = false -- debug print
Config["wheel_duration"] = 23 -- Time open
Config["wheel_delay_award"] = true
Config["reward_broadcast"] = false
Config["reward_broadcast_tier_limit"] = { 
	[1] = false, -- Common
	[2] = false, -- Rare
	[3] = false, -- Epic
	[4] = false, -- Unique
	[5] = false, -- Legendary
	[6] = false, -- GOD
}
Config["vehicle_plate_length_text"] = 3 
Config["vehicle_plate_length_number"] = 3

--Config["vehicle_custom_plate"] = function(src, hash) local text = "TEST 123" return text end 

Config["chance"] = {
	[1] = { name = "Common", rate = 40, color = "#242424", discord_color = 2368548 }, -- setting loại tỉ lệ nhận được Name = tên của nó rate xuất hiện 50
	[2] = { name = "Rare", rate = 30, color = "blue", discord_color = 255 },
	[3] = { name = "Epic", rate = 6, color = "purple", discord_color = 8388736 },
	[4] = { name = "Unique", rate = 4, color = "pink", discord_color = 13938487 },
	[5] = { name = "Legendary", rate = 1, color = "gold", discord_color = 65280 },
	[6] = { name = "GoD", rate = 0.1, color = "red", discord_color = 65280 },
}

Config["lootbox"] = {
	["firstimegift"] = {
		name = "Quà nhận lần đầu",
		list = {
			{ money = 3000, tier = 3 },
			{ money = 1500, tier = 2 },
			{ money = 2000, tier = 2 },
			{ money = 1500, tier = 2 },
			{ money = 500, tier = 1 },
			{ money = 1000, tier = 1 },			
			{ item = "jadeite", tier = 2 ,amount = math.random(1,2)},
			{ item = "nitrous", tier = 5 ,amount = math.random(1,2)},
			{ item = "harness", tier = 5 ,amount = 1},
			{ item = "aluminium", tier = 2 ,amount = 10},
			{ item = "aluminium", tier = 3 ,amount = 15},
			{ item = "aluminium", tier = 4 ,amount = 20},
			{ item = "steel", tier = 4 ,amount = 20},
			{ item = "steel", tier = 3 ,amount = 15},
			{ item = "steel", tier = 2 ,amount = 10},
			{ item = "rubber", tier = 3 ,amount = 20},
			{ item = "rubber", tier = 2 ,amount = 10},
			{ item = "rubber", tier = 4 ,amount = 30},
			{ item = "plastic", tier = 4 ,amount = 30},
			{ item = "plastic", tier = 3 ,amount = 20},
			{ item = "plastic", tier = 2 ,amount = 10},
			{ item = "lockpick", tier = 2 ,amount = math.random(1,5)},
			{ item = "brick", tier = 2 ,amount = math.random(1,3)},
			{ item = "-1786099057", tier = 6 ,amount = math.random(1)},
			
		}
	},
	["onlinelv1"] = {
		name = "Quà online cấp 1",
		list = {
			{ money = 3000, tier = 3 },
			{ money = 1500, tier = 2 },
			{ money = 2000, tier = 2 },
			{ money = 1500, tier = 2 },
			{ money = 500, tier = 1 },
			{ money = 1000, tier = 1 },			
			{ item = "jadeite", tier = 2 ,amount = math.random(1,2)},
			{ item = "bandage", tier = 2 ,amount = math.random(1,2)},
			{ item = "nitrous", tier = 5 ,amount = math.random(1,2)},
			{ item = "harness", tier = 5 ,amount = 1},
			{ item = "aluminium", tier = 2 ,amount = 10},
			{ item = "aluminium", tier = 3 ,amount = 15},
			{ item = "aluminium", tier = 4 ,amount = 20},
			{ item = "steel", tier = 4 ,amount = 20},
			{ item = "steel", tier = 3 ,amount = 15},
			{ item = "steel", tier = 2 ,amount = 10},
			{ item = "rubber", tier = 3 ,amount = 20},
			{ item = "rubber", tier = 2 ,amount = 10},
			{ item = "rubber", tier = 4 ,amount = 30},
			{ item = "plastic", tier = 4 ,amount = 30},
			{ item = "plastic", tier = 3 ,amount = 20},
			{ item = "plastic", tier = 2 ,amount = 10},
			{ item = "scrapmetal", tier = 4 ,amount = 30},
			{ item = "scrapmetal", tier = 3 ,amount = 20},
			{ item = "scrapmetal", tier = 2 ,amount = 10},
			{ item = "electronics", tier = 4 ,amount = 15},
			{ item = "electronics", tier = 3 ,amount = 10},
			{ item = "electronics", tier = 2 ,amount = 5},
			{ item = "lockpick", tier = 2 ,amount = math.random(1,5)},
			{ item = "brick", tier = 2 ,amount = math.random(1,3)},
			
		}
	},
	["onlinelv2"] = {
		name = "Quà online cấp 2",
		list = {
			{ money = 3000, tier = 3 },
			{ money = 1500, tier = 2 },
			{ money = 2000, tier = 2 },
			{ money = 1500, tier = 2 },
			{ money = 500, tier = 1 },
			{ money = 1000, tier = 1 },			
			{ item = "jadeite", tier = 2 ,amount = math.random(1,2)},
			{ item = "bandage", tier = 2 ,amount = math.random(1,2)},
			{ item = "nitrous", tier = 5 ,amount = math.random(1,2)},
			{ item = "harness", tier = 5 ,amount = 1},
			{ item = "aluminium", tier = 2 ,amount = 10},
			{ item = "aluminium", tier = 3 ,amount = 15},
			{ item = "aluminium", tier = 4 ,amount = 20},
			{ item = "steel", tier = 4 ,amount = 20},
			{ item = "steel", tier = 3 ,amount = 15},
			{ item = "steel", tier = 2 ,amount = 10},
			{ item = "rubber", tier = 3 ,amount = 20},
			{ item = "rubber", tier = 2 ,amount = 10},
			{ item = "rubber", tier = 4 ,amount = 30},
			{ item = "plastic", tier = 4 ,amount = 30},
			{ item = "plastic", tier = 3 ,amount = 20},
			{ item = "plastic", tier = 2 ,amount = 10},
			{ item = "scrapmetal", tier = 4 ,amount = 30},
			{ item = "scrapmetal", tier = 3 ,amount = 20},
			{ item = "scrapmetal", tier = 2 ,amount = 10},
			{ item = "electronics", tier = 4 ,amount = 15},
			{ item = "electronics", tier = 3 ,amount = 10},
			{ item = "electronics", tier = 2 ,amount = 5},
			{ item = "lockpick", tier = 2 ,amount = math.random(1,5)},
			{ item = "brick", tier = 2 ,amount = math.random(1,3)},
			{ item = "bikearmor", tier = 5 ,amount = 1},
			
			
		}
	},
	["onlinelv3"] = {
		name = "Quà online cấp 3",
		list = {
			{ money = 3000, tier = 3 },
			{ money = 1500, tier = 2 },
			{ money = 2000, tier = 2 },
			{ money = 1500, tier = 2 },
			{ money = 500, tier = 1 },
			{ money = 1000, tier = 1 },			
			{ item = "jadeite", tier = 2 ,amount = math.random(1,2)},
			{ item = "nitrous", tier = 5 ,amount = math.random(1,2)},
			{ item = "harness", tier = 5 ,amount = 1},
			{ item = "aluminium", tier = 2 ,amount = 10},
			{ item = "aluminium", tier = 3 ,amount = 15},
			{ item = "aluminium", tier = 4 ,amount = 20},
			{ item = "steel", tier = 4 ,amount = 20},
			{ item = "steel", tier = 3 ,amount = 15},
			{ item = "steel", tier = 2 ,amount = 10},
			{ item = "rubber", tier = 3 ,amount = 20},
			{ item = "rubber", tier = 2 ,amount = 10},
			{ item = "rubber", tier = 4 ,amount = 30},
			{ item = "plastic", tier = 4 ,amount = 30},
			{ item = "plastic", tier = 3 ,amount = 20},
			{ item = "plastic", tier = 2 ,amount = 10},
			{ item = "scrapmetal", tier = 4 ,amount = 30},
			{ item = "scrapmetal", tier = 3 ,amount = 20},
			{ item = "scrapmetal", tier = 2 ,amount = 10},
			{ item = "electronics", tier = 4 ,amount = 15},
			{ item = "electronics", tier = 3 ,amount = 10},
			{ item = "electronics", tier = 2 ,amount = 5},
			{ item = "lockpick", tier = 2 ,amount = math.random(1,5)},
			{ item = "brick", tier = 2 ,amount = math.random(1,3)},
			{ item = "bikearmor", tier = 5 ,amount = 1},
			{ item = "armor", tier = 5 ,amount = math.random(1,3)},
			
		}
	},
	
	
	["loginreward1"] = {
		name = "Quà đăng nhập cấp 1",
		list = {
			{ money = 3000, tier = 3 },
			{ money = 1500, tier = 2 },
			{ money = 2000, tier = 2 },
			{ money = 1500, tier = 2 },
			{ money = 500, tier = 1 },
			{ money = 1000, tier = 1 },			
			{ item = "jadeite", tier = 2 ,amount = math.random(1,4)},
			{ item = "bandage", tier = 2 ,amount = math.random(1,3)},
			{ item = "nitrous", tier = 5 ,amount = math.random(1,3)},
			{ item = "harness", tier = 5 ,amount = 1},
			{ item = "aluminium", tier = 2 ,amount = 10},
			{ item = "aluminium", tier = 3 ,amount = 15},
			{ item = "aluminium", tier = 4 ,amount = 20},
			{ item = "steel", tier = 4 ,amount = 20},
			{ item = "steel", tier = 3 ,amount = 15},
			{ item = "steel", tier = 2 ,amount = 10},
			{ item = "rubber", tier = 3 ,amount = 20},
			{ item = "rubber", tier = 2 ,amount = 10},
			{ item = "rubber", tier = 4 ,amount = 30},
			{ item = "plastic", tier = 4 ,amount = 30},
			{ item = "plastic", tier = 3 ,amount = 20},
			{ item = "plastic", tier = 2 ,amount = 10},
			{ item = "scrapmetal", tier = 4 ,amount = 30},
			{ item = "scrapmetal", tier = 3 ,amount = 20},
			{ item = "scrapmetal", tier = 2 ,amount = 10},
			{ item = "electronics", tier = 4 ,amount = 15},
			{ item = "electronics", tier = 3 ,amount = 10},
			{ item = "electronics", tier = 2 ,amount = 5},
			{ item = "refinedaluminium", tier = 5 ,amount = math.random(1,10)},
			{ item = "refinedplastic", tier = 5 ,amount = math.random(1,10)},
			{ item = "refinedrubber", tier = 5 ,amount = math.random(1,10)},
			{ item = "refinedcopper", tier = 5 ,amount = math.random(1,10)},
			{ item = "refinedglass", tier = 5 ,amount = math.random(1,10)},
			{ item = "lockpick", tier = 2 ,amount = math.random(3,5)},
			{ item = "brick", tier = 2 ,amount = math.random(1,3)},
			-- { item = "jewelry_ring", tier = 5 ,amount = 1},
			-- { item = "jewelry_necklace", tier = 5 ,amount = 1},
			-- { item = "jewelry_relic", tier = 6 ,amount = 1},
			-- { item = "jewelry_part", tier = 4 ,amount = math.random(1,5)},
			{ item = "oxy", tier = 2 ,amount = math.random(1,2)},
			{ item = "oxy", tier = 4 ,amount = math.random(2,4)},
			
			
			
		}
	},
	
	["loginreward2"] = {
		name = "Quà đăng nhập cấp 2",
		list = {
			{ money = 3000, tier = 3 },
			{ money = 1500, tier = 2 },
			{ money = 2000, tier = 2 },
			{ money = 1500, tier = 2 },
			{ money = 500, tier = 1 },
			{ money = 1000, tier = 1 },			
			{ item = "jadeite", tier = 2 ,amount = math.random(1,4)},
			{ item = "bandage", tier = 2 ,amount = math.random(1,3)},
			{ item = "nitrous", tier = 5 ,amount = math.random(1,3)},
			{ item = "harness", tier = 5 ,amount = 1},
			{ item = "aluminium", tier = 2 ,amount = 10},
			{ item = "aluminium", tier = 3 ,amount = 15},
			{ item = "aluminium", tier = 4 ,amount = 20},
			{ item = "steel", tier = 4 ,amount = 20},
			{ item = "steel", tier = 3 ,amount = 15},
			{ item = "steel", tier = 2 ,amount = 10},
			{ item = "rubber", tier = 3 ,amount = 20},
			{ item = "rubber", tier = 2 ,amount = 10},
			{ item = "rubber", tier = 4 ,amount = 30},
			{ item = "plastic", tier = 4 ,amount = 30},
			{ item = "plastic", tier = 3 ,amount = 20},
			{ item = "plastic", tier = 2 ,amount = 10},
			{ item = "scrapmetal", tier = 4 ,amount = 30},
			{ item = "scrapmetal", tier = 3 ,amount = 20},
			{ item = "scrapmetal", tier = 2 ,amount = 10},
			{ item = "electronics", tier = 4 ,amount = 15},
			{ item = "electronics", tier = 3 ,amount = 10},
			{ item = "electronics", tier = 2 ,amount = 5},
			{ item = "refinedaluminium", tier = 5 ,amount = math.random(5,10)},
			{ item = "refinedplastic", tier = 5 ,amount = math.random(5,10)},
			{ item = "refinedrubber", tier = 5 ,amount = math.random(5,10)},
			{ item = "refinedcopper", tier = 5 ,amount = math.random(5,10)},
			{ item = "refinedglass", tier = 5 ,amount = math.random(5,10)},
			{ item = "lockpick", tier = 2 ,amount = math.random(3,5)},
			{ item = "brick", tier = 2 ,amount = math.random(1,3)},
			-- { item = "jewelry_ring", tier = 5 ,amount = 1},
			-- { item = "jewelry_necklace", tier = 5 ,amount = 1},
			-- { item = "jewelry_relic", tier = 6 ,amount = 1},
			-- { item = "jewelry_part", tier = 4 ,amount = math.random(1,5)},
			{ item = "oxy", tier = 2 ,amount = math.random(1,2)},
			{ item = "oxy", tier = 4 ,amount = math.random(2,4)},
			
		}
	},
}

Config["discord_bot"] = "BOTBOT" -- botname
Config["lootbox_discord"] = { 
	["item"] = "https://discordapp.com/api/webhooks/752085703386726410/Lzh3M22QeVQlCil3khNQasDIphdnExWwTQcBU-LiORYjRspWo6fzw-1Nh5s6xQ8nHU7j",
	["weapon"] = "https://discordapp.com/api/webhooks/752085703386726410/Lzh3M22QeVQlCil3khNQasDIphdnExWwTQcBU-LiORYjRspWo6fzw-1Nh5s6xQ8nHU7j",
	["money"] = "https://discordapp.com/api/webhooks/752085703386726410/Lzh3M22QeVQlCil3khNQasDIphdnExWwTQcBU-LiORYjRspWo6fzw-1Nh5s6xQ8nHU7j",
	["vehicle"] = "https://discordapp.com/api/webhooks/752085703386726410/Lzh3M22QeVQlCil3khNQasDIphdnExWwTQcBU-LiORYjRspWo6fzw-1Nh5s6xQ8nHU7j",
}

Config["translate"] = {
	broadcast_header = "^3^*Hộp Quà: ",
	broadcast_text = "Người chơi ^6^*%s ^7^rnhận được ^2%s ^7từ ^3%s",
	discord_gacha_unbox = "Người chơi %s Mở hòm quay thưởng %s và nhận được %s!",
	discord_identifier = "\nSteam Identifier: %s\nThời gian: %s"
}