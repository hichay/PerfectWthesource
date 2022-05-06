--[[
	file: config.lua
	resource: scotty-stolen-vehicle
	author: Scotty1944
	contact: https://steamcommunity.com/id/scotty1944/
	warning: หากนำไปขายต่อหรือแจกจ่าย หรือใช้ร่วมกันเกิน 1 server จะถูกยกเลิก license ทันที
]]

Config = {}

Config["debug"] = false -- เปิดโหมดพัฒนา
Config["enable_stolen_blip"] = true -- เมื่อมีคนขโมยรถคันนี้จะทำให้ปรากฏลงบนแมพเพื่อให้ทุกคนตามล่า
Config["hijack_car"] = true -- มีอาวุธจะบังคับให้คนในรถลงจากรถได้

Config["stream_frequency"] = 1 -- ปรับฮัตราการทำงานของระบบ Vehicle Streaming (ไม่สามารถปรับต่ำกว่า 1 วินาที)
Config["cop_frequency"] = 60 -- ปรับอัตราการเช็คตำรวจ (ปรับน้อยยิ่งเช็คหนักปรับเยอะยิ่งลดการทำงาน) (เซิฟที่ Scotty ปรับแต่งให้ไม่จำเป็นต้องปรับตัวนี้ไม่ค่อยมีผลอะไรมาก)

-- Config พวกนี้จะ work หากทำตามคู่มือและเป็นเซิฟที่เปิดการใช้ AI Peds (Infinity ใช้ไม่ได้นะเพราะว่าไม่มี AI Peds)
Config["wanted_level"] = 3 -- จำนวนดาวเมื่อขโมยรถ (เปิดระบบตำรวจ AI)
Config["wanted_level_never_fade"] = false -- จำนวนดาวจะไม่มีวันหายเลยถึงจะหนีได้
Config["wanted_level_duration_on_exit"] = 30 -- ยังติดดาวอยู่อีกกี่วินาที จึงจะหายหลังออกจากรถ
Config["wanted_level_escape"] = false -- ต้องหนีจากตำรวจ AI ให้ได้ก่อนถึงจะส่งรถได้ (จะใช้ไม่ได้หากเปิด wanted_level_never_fade ไว้)

Config["discord_bot"] = "Stolen Bot" -- ชื่อบอท Discord
Config["discord_webhook"] = "" -- ลิงค์ URL ของ Discord Webhook 

Config["restrict_job"] = { -- อาชีพที่ไม่สามารถไปส่งตามจุดหลักได้ และจะต้องขับไปส่งที่สถานีตำรวจ
	["police"] = true
}

Config["broadcast_notify"] = true -- เปิดการแจ้งเตือนให้ทุกคนรู้
Config["hud_freemode_message"] = true -- เปิด HUD ที่จะปรากฏขึ้นกลางจอเมื่อส่งสำเร็จ

Config["disable_auto_check_weapon"] = false -- สำหรับเซิฟที่อาวุธคือไอเทมชิ้นนึงในกระเป๋า

Config["police_drop_off"] = { x = 407.45, y = -984.02, z = 28.73, h = 232.49 } -- จุดที่ต้องไปส่งรถหากเป็นอาชีพที่ห้ามทำ
Config["police_drop_off_reward"] = { -- รางวัลที่จะแจกทุกอย่างใน list
	["cash"] = 250,
}
Config["police_drop_off_reward_random"] = { -- รางวัลแบบที่จะสุ่มขึ้นมา 1 ชิ้น ถ้ายังมีลิส police_drop_off_reward ลิสรายการนี้จะไม่ทำงาน (ให้เลือกว่าจะใช้ police_drop_off_reward หรือ police_drop_off_reward_random)
	{
		["item"] = "cash", -- ชื่อของ
		["amount"] = 100, -- จำนวน
		["rate"] = 1 -- โอกาสที่จะได้
	},
	{
		["item"] = "cash", 
		["amount"] = 200,
		["rate"] = 0.1
	},
}

Config["car_location"] = {
	{
		["name"] = "รถในตำนาน",
		["model"] = "microlight", -- ชื่อโมเดลรถ
		["pos"] = { x = -1335.43, y = -3323.16, z = 12.26, h = 329.92 }, -- จุดที่จอดประจำ
		["respawn_time"] = 30 * 60, -- ระยะเวลาเกิดของรถหลังจากที่ไปส่งสำเร็จ
		["time"] = { -- ตารางเวลาที่รถคันนี้จะโผล่ออกมา
			{{00,00}, {09,00}}, -- 06.00 ถึง 09.00
			{{12,00}, {14,00}},
		},
		["police"] = 1, -- เช็คตำรวจหากไม่ตรงเงื่อนไขจะไม่เกิด
		["reward"] = { -- ได้ของตามรายการทุกอย่าง
			["bread"] = 1,
			["water"] = 1
		},
		["reward_random"] = { -- รางวัลแบบที่จะสุ่มขึ้นมา 1 ชิ้น ถ้ายังมีลิส reward ลิสรายการนี้จะไม่ทำงาน (ให้เลือกว่าจะใช้ reward หรือ reward_random)
			{
				["item"] = "bread", -- ชื่อของ
				["amount"] = 1, -- จำนวน
				["rate"] = 1 -- โอกาสที่จะได้
			},
			{
				["item"] = "WEAPON_KNIFE", 
				["amount"] = 1,
				["rate"] = 0.1
			},
		},
	},
	{
		["name"] = "Voltic Mark II",
		["model"] = "voltic2", -- ชื่อโมเดลรถ
		["pos"] = { x = 942.68, y = -2884.91, z = 17.48, h = 90.00 }, -- จุดที่จอดประจำ(ตอนนี้ทำไว้ท่าเรือ)
		["respawn_time"] = 30 * 60, -- ระยะเวลาเกิดของรถหลังจากที่ไปส่งสำเร็จ
		["time"] = { -- ตารางเวลาที่รถคันนี้จะโผล่ออกมา
			{{09,00}, {11,30}}, -- 09.00 ถึง 11.30
			{{19,00}, {22,00}},
		},
		["reward"] = { -- ได้ของตามรายการทุกอย่าง
			["bread"] = 1,
			["water"] = 1
		},
		["reward_random"] = { -- รางวัลแบบที่จะสุ่มขึ้นมา 1 ชิ้น ถ้ายังมีลิส reward ลิสรายการนี้จะไม่ทำงาน (ให้เลือกว่าจะใช้ reward หรือ reward_random)
			{
				["item"] = "bread", -- ชื่อของ
				["amount"] = 1, -- จำนวน
				["rate"] = 1 -- โอกาสที่จะได้
			},
			{
				["item"] = "WEAPON_KNIFE", 
				["amount"] = 1,
				["rate"] = 0.1
			},
		},
	},
}

Config["drop_off_location"] = { -- จุดที่สามารถเอาไปส่งได้
	{ x = 1730.65, y = 3322.98, z = 40.69, h = 284.41 },
	{ x = 2361.92, y = 2528.99, z = 46.13, h = 268.14 },
	{ x = 2770.29, y = 2805.18, z = 40.87, h = 121.06 },
	{ x = 1725.57, y = 4802.01, z = 41.18, h = 270.10 },
	{ x = -141.44, y = 6496.43, z = 29.19, h = 227.88 },
	{ x = -2330.30, y = 260.37, z = 169.07, h = 204.17 },
}

Config["translate"] = {
	hint_hud = "จงขับ ~g~%s~s~ ไปยังจุดหมาย",
	hint_escape_hud = "คุณจะต้อง ~r~หนีตำรวจ~s~ ให้ได้ก่อน",
	hint_restrict_job = "~r~อาชีพคุณไม่สามารถปล้นรถได้",
	
	dropoff_title = "~o~Stolen Car Drop Off",
	dropoff_desc = "จุดส่งรถที่ขโมยมา",
	success_mission = "ภารกิจส่ง  ~g~%s~s~ สำเร็จ",
	
	hud_stolen_title = "~y~STOLEN CAR",
	hud_stolen_desc = "delivered!",
	
	announce_text = 'มีใครบางคนกำลังขโมยรถ <span style="color:gold;">@vehicle</span> อยู่!',
	announce_desc = "รถจะปรากฏในแผนที่ให้เห็น",
	
	escort_text = '<span style="color:gold;">@vehicle</span> ได้ถูกส่งแล้วเรียบร้อย!',
	escort_desc = "คนขับได้รับรางวัลอย่างงามเลยล่ะ!",
	
	discord_text = "คุณ @name ได้ขโมยรถ @model แล้วส่งได้สำเร็จ",
	discord_text2 = "คุณ @name ได้นำรถ @model ส่งคืนสถานีตำรวจ",
	discord_text_reward = "คุณ @name ได้รับรางวัลจากการส่งรถ",
	discord_identifier = "\nSteam Identifier: %s\nเวลา: %s",
}