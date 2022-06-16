
Config = {}

Config["debug"] = true -- debug command

Config["daily_title"] = "Quà Đăng Nhập Ngày" -- text
Config["daily_desc"] = "Với quà cho người chơi đăng nhập từ ngày 1 đến 30 ngày mỗi tháng" --text

Config["daily_menu_key"] = 344 
Config["daily_menu_key_text"] = "F11" 

Config["vehicle_plate_length_text"] = 3 
Config["vehicle_plate_length_number"] = 3 
--Config["vehicle_custom_plate"] = function(src, hash) local text = "TEST 123" return text end 

Config["online_tier"] = {
	-- {
		-- time = 1 * 60, -- time setting ( 300s hoặc 5 * 60
		-- item = {
			-- ["bread"] = 1, -- itemname = số
			-- ["water"] = 1,
		-- },
		-- cash = 100,
	-- },
	-- {
		-- time = 3 * 60,
		-- item = {
			-- ["bread"] = 5,
			-- ["water"] = 5,
		-- },
		-- cash = 1000,
	-- }
}

--[[
	online_tier 
	-- item = {
		bread = 1, 
		weapon_knife = 1, 
	},
	-- cash = 100 
	-- vehicle = "baller" 
]]

--[[
	daily_reward 
	-- item = {
		bread = 1, 
		weapon_knife = 1, 
	},
	-- cash = 100 
	-- vehicle = "baller" -- hash 
	-- tooltip = "Baller" 
]]

Config["daily_reward"] = { -- 28 ngày
	[1] = { item = { firstimegift = 1}, tooltip = "Quà đăng nhập đầu tiên"},
	[2] = { item = { loginreward1 = 1 }},
	[3] = { item = { loginreward1 = 1 }},
	[4] = { item = { loginreward1 = 1 }},
	[5] = { item = { loginreward1 = 1 }},
	[6] = { item = { loginreward1 = 1 }},
	[7] = { item = { loginreward1 = 2}, tooltip = "Quà đăng nhập ngày thứ 7"},
	[8] = { item = { loginreward1 = 1 }},
	[9] = { item = { loginreward1 = 1 }},
	[10] = { item = { loginreward1 = 1 }},
	[11] = { item = { loginreward1 = 1 }},
	[12] = { item = { loginreward1 = 1 }},
	[13] = { item = { loginreward1 = 2}, tooltip = "Quà đăng nhập ngày thứ 14"},
	[14] = { item = { loginreward2 = 1 }},
	[15] = { item = { loginreward2 = 1 }},
	[16] = { item = { loginreward2 = 1 }},
	[17] = { item = { loginreward2 = 1 }},
	[18] = { item = { loginreward2 = 1 }},
	[19] = { item = { loginreward2 = 1 }},
	[20] = { item = { loginreward2 = 1 }},
	[21] = { item = { loginreward2 = 2}, tooltip = "Quà đăng nhập ngày thứ 21"},
	[22] = { item = { loginreward2 = 1 }},
	[23] = { item = { loginreward2 = 1 }},
	[24] = { item = { loginreward2 = 1 }},
	[25] = { item = { loginreward2 = 1 }},
	[26] = { item = { loginreward2 = 1 }},
	[27] = { item = { loginreward2 = 1 }},
	[28] = { vehicle = "deathbike2", tooltip = "Quà Đặc Biệt Tri Ân 28 Ngày Online" },
}

Config["discord_bot"] = "Time Keeper" --  Discord botname
Config["discord_webhook"] = { -- URL Discord Webhook
	["online_reward"] = "",
	["daily_reward"] = ""
}
Config["discord_color"] = { 
	["online_reward"] = 13938487,
	["daily_reward"] = 65280
}

Config["translate"] = { 
	checkIn = "Quà đăng nhập ngày",
	checkIn2 = "Cảm ơn bạn đã đăng nhập ngày hôm nay!<br>Đừng quên quay lại vào ngày mai",
	already_checkin = "Quà đăng nhập ngày",
	already_checkin2 = "Bạn đã nhận thưởng của ngày hôm nay rồi!",
	discord_gift = "Người chơi %s nhận quà online ngày %s!",
	discord_time = "Người chơi %s nhận một món quà online %s một phút trước!",
	discord_identifier = "\nSteam Identifier: %s\ntime: %s"
}