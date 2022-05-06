

Config = {}
Config["debug"] = true -- โหมดพัฒนา
Config["wheel_duration"] = 10 -- ระยะเวลาที่ใช้ในการเปิดกาชา
Config["wheel_delay_award"] = true -- ให้ของในกาชาเมื่อจบ wheel_duration
Config["gachapon_broadcast"] = true -- ประกาศลงแชทเมื่อมีคนได้ของไหม ?

Config["gachapon_broadcast_top_message"] = true-- ประกาศรางวัลเป็นข้อความด้านบนแบบ Battle X
Config["gachapon_broadcast_top_message_duration"] = 2500 -- ระยะเวลาที่ประกาศ

Config["gachapon_broadcast_tier_limit"] = { -- ให้ประกาศเมื่อได้ของ tier อะไร
	[1] = true, -- Common
	[2] = true, -- Rare
	[3] = true, -- Epic
	[4] = true, -- Unique
	[5] = true, -- Legendary
}
Config["vehicle_plate_length_text"] = 3 -- ความยาวป้ายทะเบียนรถที่จะได้ ตัวอักษร
Config["vehicle_plate_length_number"] = 3 -- ความยาวป้ายทะเบียนรถที่จะได้ ตัวเลข
Config["vehicle_plate_check"] = true -- เช็คป้ายทะเบียนกับ SQL ว่าซ้ำกันไหม

Config["disable_auto_check_weapon"] = false -- ปิดระบบเช็คว่าไอเทมเป็นอาวุธไหม (ต้องเปิดหากเซิฟคุณเป็นแบบที่อาวุธเหมือนเป็นไอเทมชิ้นนึง)

--Config["vehicle_plate_func"] = function(src, hash) local text = "TEST 123" return text end -- ออกแบบป้ายทะเบียนเอง ใช้ไม่เป็นอย่าเปิดใช้โดยเด็ดขาด
--Config["vehicle_query"] = 'INSERT INTO owned_vehicles (owner, plate, vehicle, type, `stored`) VALUES (@owner, @plate, @vehicle, @type, 1)'

Config["image_source"] = "nui://esx_inventoryhud/html/img/items/"

Config["chance"] = {
	[1] = { name = "Common", rate = 50, color = "#242424", discord_color = 2368548 },
	[2] = { name = "Rare", rate = 40, color = "blue", discord_color = 255 },
	[3] = { name = "Epic", rate = 8, color = "purple", discord_color = 8388736 },
	[4] = { name = "Unique", rate = 1.7, color = "gold", discord_color = 13938487 },
	[5] = { name = "Legendary", rate = 0.3, color = "green", discord_color = 65280 },
}

Config["gachapon"] = {
	["firstimegift"] = {
		name = "Quà nhận lần đầu",
		list = {
			{ item = "steel_bar", tier = 4 ,amount = 10},
			{ money = 30000, tier = 4 },
			{ money = 70000, tier = 5 },
			{ money = 30000, tier = 4 },
			{ money = 10000, tier = 3 },
			{ money = 1500, tier = 2 },
			{ money = 2000, tier = 2 },
			{ money = 2500, tier = 2 },
			{ money = 500, tier = 1 },
			{ money = 1000, tier = 1 },			
			{ item = "kevlar", tier = 2 ,amount = 1},
			{ item = "kevlar", tier = 4 ,amount = 5},
			{ item = "kevlar", tier = 3 ,amount = 2},
			{ item = "steel_bar", tier = 2 ,amount = 1},
			{ item = "steel_bar", tier = 3 ,amount = 2},
			{ item = "steel_bar", tier = 4 ,amount = 5},
			{ item = "steel", tier = 4 ,amount = 25},
			{ item = "steel", tier = 3 ,amount = 20},
			{ item = "steel", tier = 2 ,amount = 15},
			{ item = "mushroom", tier = 3 ,amount = 30},
			{ item = "mushroom", tier = 2 ,amount = 20},
			{ item = "mushroom", tier = 4 ,amount = 50},
			{ item = "coral", tier = 4 ,amount = 40},
			{ item = "coral", tier = 3 ,amount = 25},
			{ item = "blueprintmachinepistol", tier = 4 ,amount = 1},
			{ item = "blueprindbshotgun", tier = 3 ,amount = 1},
			{ item = "blueprintgusenberg", tier = 4 ,amount = 1},
			{ item = "blueprintpumpshotgun", tier = 4 ,amount = 1},
			{ item = "blueprintsawnoffshotgun", tier = 4 ,amount = 1},
			{ item = "blueprintassaultsmg", tier = 4 ,amount = 1},
			{ item = "blueprintrevoler", tier = 4 ,amount = 1},
			{ item = "blueprintspecialcarbine", tier = 5 ,amount = 1},
			{ item = "blueprintak47", tier = 5 ,amount = 1},
			{ item = "blueprintcompactrifle", tier = 5 ,amount = 1},
			{ item = "blueprintassaultsmg", tier = 5 ,amount = 1},
			{ money = 50000, tier = 4 },
			
			
		}
	},
	["onlinelv1"] = {
		name = "Quà online cấp 1",
		list = {
			{ item = "steel_bar", tier = 4 ,amount = 10},
			{ money = 5000, tier = 4 },
			{ money = 20000, tier = 5 },
			{ money = 5000, tier = 4 },
			{ money = 3000, tier = 3 },
			{ money = 1500, tier = 2 },
			{ money = 2000, tier = 2 },
			{ money = 2500, tier = 2 },
			{ money = 500, tier = 1 },
			{ money = 1000, tier = 1 },		
			{ item = "kevlar", tier = 2 ,amount = 1},
			{ item = "kevlar", tier = 4 ,amount = 5},
			{ item = "kevlar", tier = 3 ,amount = 2},
			{ item = "steel_bar", tier = 2 ,amount = 1},
			{ item = "steel_bar", tier = 3 ,amount = 2},
			{ item = "steel_bar", tier = 4 ,amount = 5},
			{ item = "steel", tier = 4 ,amount = 25},
			{ item = "steel", tier = 3 ,amount = 20},
			{ item = "steel", tier = 2 ,amount = 15},
			{ item = "gold_bar", tier = 2 ,amount = 5},
			{ item = "gold_bar", tier = 3 ,amount = 10},
			{ item = "mushroom", tier = 3 ,amount = 30},
			{ item = "mushroom", tier = 2 ,amount = 20},
			{ item = "mushroom", tier = 4 ,amount = 50},
			{ item = "coral", tier = 4 ,amount = 20},
			{ item = "coral", tier = 3 ,amount = 15},
			{ item = "tool_cement", tier = 5 ,amount = 1},
			{ item = "tool_pipe", tier = 5 ,amount = 1},
			{ item = "tool_engine", tier = 5 ,amount = 1},
			{ item = "blueprintmachinepistol", tier = 4 ,amount = 1},
			{ item = "blueprintminismg", tier = 4 ,amount = 1},
			{ item = "blueprintmicrosmg", tier = 3 ,amount = 1},
			{ item = "blueprindbshotgun", tier = 3 ,amount = 1},
			{ item = "blueprintgusenberg", tier = 4 ,amount = 1},
			{ item = "blueprintpumpshotgun", tier = 4 ,amount = 1},
			{ item = "blueprintsawnoffshotgun", tier = 4 ,amount = 1},
			{ item = "blueprintassaultsmg", tier = 4 ,amount = 1},
			{ item = "blueprintrevoler", tier = 4 ,amount = 1},
			{ item = "blueprintspecialcarbine", tier = 5 ,amount = 1},
			{ item = "blueprintak47", tier = 5 ,amount = 1},
			{ item = "blueprintcompactrifle", tier = 5 ,amount = 1},
			{ item = "blueprintassaultsmg", tier = 5 ,amount = 1},
			
		}
	},
	["onlinelv2"] = {
		name = "Quà online cấp 2",
		list = {
			{ item = "steel_bar", tier = 4 ,amount = 10},
			{ money = 30000, tier = 4 },
			{ money = 70000, tier = 5 },
			{ money = 30000, tier = 4 },
			{ money = 10000, tier = 3 },
			{ money = 1500, tier = 2 },
			{ money = 2000, tier = 2 },
			{ money = 2500, tier = 2 },
			{ money = 500, tier = 1 },
			{ money = 1000, tier = 1 },			
			{ item = "kevlar", tier = 2 ,amount = 1},
			{ item = "kevlar", tier = 4 ,amount = 5},
			{ item = "kevlar", tier = 3 ,amount = 2},
			{ item = "steel_bar", tier = 2 ,amount = 1},
			{ item = "steel_bar", tier = 3 ,amount = 2},
			{ item = "steel_bar", tier = 4 ,amount = 5},
			{ item = "steel", tier = 4 ,amount = 25},
			{ item = "steel", tier = 3 ,amount = 20},
			{ item = "steel", tier = 2 ,amount = 15},
			{ item = "mushroom", tier = 3 ,amount = 30},
			{ item = "mushroom", tier = 2 ,amount = 20},
			{ item = "mushroom", tier = 4 ,amount = 50},
			{ item = "coral", tier = 4 ,amount = 40},
			{ item = "coral", tier = 3 ,amount = 25},
			{ item = "blueprintmachinepistol", tier = 4 ,amount = 1},
			{ item = "blueprindbshotgun", tier = 3 ,amount = 1},
			{ item = "blueprintgusenberg", tier = 4 ,amount = 1},
			{ item = "blueprintpumpshotgun", tier = 4 ,amount = 1},
			{ item = "blueprintsawnoffshotgun", tier = 4 ,amount = 1},
			{ item = "blueprintassaultsmg", tier = 4 ,amount = 1},
			{ item = "blueprintrevoler", tier = 4 ,amount = 1},
			{ item = "blueprintspecialcarbine", tier = 5 ,amount = 1},
			{ item = "blueprintak47", tier = 5 ,amount = 1},
			{ item = "blueprintcompactrifle", tier = 5 ,amount = 1},
			{ item = "blueprintassaultsmg", tier = 5 ,amount = 1},
			{ money = 50000, tier = 4 },
			
			
		}
	},
	["onlinelv3"] = {
		name = "Quà online cấp 3",
		list = {
			{ item = "steel_bar", tier = 4 ,amount = 10},
			{ money = 30000, tier = 4 },
			{ money = 70000, tier = 5 },
			{ money = 30000, tier = 4 },
			{ money = 10000, tier = 3 },
			{ money = 1500, tier = 2 },
			{ money = 2000, tier = 2 },
			{ money = 2500, tier = 2 },
			{ money = 500, tier = 1 },
			{ money = 1000, tier = 1 },			
			{ item = "kevlar", tier = 2 ,amount = 1},
			{ item = "kevlar", tier = 4 ,amount = 5},
			{ item = "kevlar", tier = 3 ,amount = 2},
			{ item = "steel_bar", tier = 2 ,amount = 1},
			{ item = "steel_bar", tier = 3 ,amount = 2},
			{ item = "steel_bar", tier = 4 ,amount = 5},
			{ item = "steel", tier = 4 ,amount = 25},
			{ item = "steel", tier = 3 ,amount = 20},
			{ item = "steel", tier = 2 ,amount = 15},
			{ item = "mushroom", tier = 3 ,amount = 30},
			{ item = "mushroom", tier = 2 ,amount = 20},
			{ item = "mushroom", tier = 4 ,amount = 50},
			{ item = "coral", tier = 4 ,amount = 40},
			{ item = "coral", tier = 3 ,amount = 25},
			{ item = "blueprintmachinepistol", tier = 4 ,amount = 1},
			{ item = "blueprindbshotgun", tier = 3 ,amount = 1},
			{ item = "blueprintgusenberg", tier = 4 ,amount = 1},
			{ item = "blueprintpumpshotgun", tier = 4 ,amount = 1},
			{ item = "blueprintsawnoffshotgun", tier = 4 ,amount = 1},
			{ item = "blueprintassaultsmg", tier = 4 ,amount = 1},
			{ item = "blueprintrevoler", tier = 4 ,amount = 1},
			{ item = "blueprintspecialcarbine", tier = 5 ,amount = 1},
			{ item = "blueprintak47", tier = 5 ,amount = 1},
			{ item = "blueprintcompactrifle", tier = 5 ,amount = 1},
			{ item = "blueprintassaultsmg", tier = 5 ,amount = 1},
			{ money = 50000, tier = 4 },
			
		}
	},
	
	
	["loginreward1"] = {
		name = "Quà đăng nhập cấp 1",
		list = {
			{ item = "steel_bar", tier = 4 ,amount = 10},
			{ money = 30000, tier = 4 },
			{ money = 70000, tier = 5 },
			{ money = 30000, tier = 4 },
			{ money = 10000, tier = 3 },
			{ money = 1500, tier = 2 },
			{ money = 2000, tier = 2 },
			{ money = 2500, tier = 2 },
			{ money = 500, tier = 1 },
			{ money = 1000, tier = 1 },			
			{ item = "kevlar", tier = 2 ,amount = 1},
			{ item = "kevlar", tier = 4 ,amount = 5},
			{ item = "kevlar", tier = 3 ,amount = 2},
			{ item = "steel_bar", tier = 2 ,amount = 1},
			{ item = "steel_bar", tier = 3 ,amount = 2},
			{ item = "steel_bar", tier = 4 ,amount = 5},
			{ item = "steel", tier = 4 ,amount = 25},
			{ item = "steel", tier = 3 ,amount = 20},
			{ item = "steel", tier = 2 ,amount = 15},
			{ item = "mushroom", tier = 3 ,amount = 30},
			{ item = "mushroom", tier = 2 ,amount = 20},
			{ item = "mushroom", tier = 4 ,amount = 50},
			{ item = "coral", tier = 4 ,amount = 40},
			{ item = "coral", tier = 3 ,amount = 25},
			{ item = "blueprintmachinepistol", tier = 4 ,amount = 1},
			{ item = "blueprindbshotgun", tier = 3 ,amount = 1},
			{ item = "blueprintgusenberg", tier = 4 ,amount = 1},
			{ item = "blueprintpumpshotgun", tier = 4 ,amount = 1},
			{ item = "blueprintsawnoffshotgun", tier = 4 ,amount = 1},
			{ item = "blueprintassaultsmg", tier = 4 ,amount = 1},
			{ item = "blueprintrevoler", tier = 4 ,amount = 1},
			{ item = "blueprintspecialcarbine", tier = 5 ,amount = 1},
			{ item = "blueprintak47", tier = 5 ,amount = 1},
			{ item = "blueprintcompactrifle", tier = 5 ,amount = 1},
			{ item = "blueprintassaultsmg", tier = 5 ,amount = 1},
			{ money = 50000, tier = 4 },
			
			
			
		}
	},
	
	["loginreward2"] = {
		name = "Quà đăng nhập cấp 2",
		list = {
			{ item = "steel_bar", tier = 4 ,amount = 10},
			{ money = 30000, tier = 4 },
			{ money = 70000, tier = 5 },
			{ money = 30000, tier = 4 },
			{ money = 10000, tier = 3 },
			{ money = 1500, tier = 2 },
			{ money = 2000, tier = 2 },
			{ money = 2500, tier = 2 },
			{ money = 500, tier = 1 },
			{ money = 1000, tier = 1 },			
			{ item = "kevlar", tier = 2 ,amount = 1},
			{ item = "kevlar", tier = 4 ,amount = 5},
			{ item = "kevlar", tier = 3 ,amount = 2},
			{ item = "steel_bar", tier = 2 ,amount = 1},
			{ item = "steel_bar", tier = 3 ,amount = 2},
			{ item = "steel_bar", tier = 4 ,amount = 5},
			{ item = "steel", tier = 4 ,amount = 25},
			{ item = "steel", tier = 3 ,amount = 20},
			{ item = "steel", tier = 2 ,amount = 15},
			{ item = "mushroom", tier = 3 ,amount = 30},
			{ item = "mushroom", tier = 2 ,amount = 20},
			{ item = "mushroom", tier = 4 ,amount = 50},
			{ item = "coral", tier = 4 ,amount = 40},
			{ item = "coral", tier = 3 ,amount = 25},
			{ item = "blueprintmachinepistol", tier = 4 ,amount = 1},
			{ item = "blueprindbshotgun", tier = 3 ,amount = 1},
			{ item = "blueprintgusenberg", tier = 4 ,amount = 1},
			{ item = "blueprintpumpshotgun", tier = 4 ,amount = 1},
			{ item = "blueprintsawnoffshotgun", tier = 4 ,amount = 1},
			{ item = "blueprintassaultsmg", tier = 4 ,amount = 1},
			{ item = "blueprintrevoler", tier = 4 ,amount = 1},
			{ item = "blueprintspecialcarbine", tier = 5 ,amount = 1},
			{ item = "blueprintak47", tier = 5 ,amount = 1},
			{ item = "blueprintcompactrifle", tier = 5 ,amount = 1},
			{ item = "blueprintassaultsmg", tier = 5 ,amount = 1},
			{ money = 50000, tier = 4 },
			
		}
	},
}

Config["discord_bot"] = "Gachapon Bot" -- ชื่อ Bot
Config["gacha_discord"] = {
	["item"] = "",
	["weapon"] = "",
	["money"] = "",
	["vehicle"] = "",
}

Config["translate"] = {
	broadcast_header = "^3^*Gachapon: ",
	broadcast_text = "Bạn ^6^*%s ^7^rnhận được ^2%s ^7từ ^3%s",
	broadcast_top_text = 'Bạn <span style=\"color:gold;\">%s</span> nhận được <span style=\"color:lightgreen;\">%s</span> từ <span style=\"color:gold;\">%s</span>',
	discord_gacha_unbox = "Người chơi %s mở %s nhận được %s!",
	discord_identifier = "\nSteam Identifier: %s\nเวลา: %s",
	
	ui_you_got = "Bạn đã nhận được %s!",
	ui_exit = "Thoát",
	ui_open_more = "Tiếp tục mở (%s)",
	ui_black_money = "Tiền bẩn",
}