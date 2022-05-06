

Config = {}
Config["debug"] = true -- developer mode to activate "sc_bench" command
Config["craft_table_color"] = "gold" -- craft ui menu color (use only web code color)
Config["craft_duration"] = 5 -- craft duration
Config["craft_duration_multiply"] = true -- will duration multiply when craft more than one
Config["craft_duration_max"] = 30 -- maximum craft duration
Config["craft_enable_fail"] = true -- fail chance enable 
Config["craft_fail_item"] = {"bread",1} -- when failed what you will get
Config["craft_table_sound_distance"] = 5.0 -- maxmimum sound distance
Config["craft_table_sound"] = { -- craft sound inside folder html/sound
	["success"] = "success", -- sound file when success
	["failed"] = "failed" -- sound file when failed
}
Config["notify_mode"] = "pnotify" -- which notify you use on your server ? between pnotify or mythic
Config["craft_discord"] = { -- Discord Webhook Beta
	["item"] = "", -- webhook url
	["weapon"] = "" -- webhook url
}
Config["craft_cost"] = 100 -- craft cost
Config["craft_cost_type"] = "cash" -- craft cost type (between "cash" or "black_money")
Config["craft_cost_multiply"] = true -- multiply craft cost when craft more than one

Config["disable_auto_check_weapon"] = false -- disable auto check if item is weapon (set it to true if your server have weapon as a normal item)

Config["disable_blur"] = true -- actually it enable blur

Config["cash_symbol"] = "💵" -- cash icon
Config["black_money_symbol"] = "🧧" -- black money icon

Config["default_animation"] = {"anim@amb@business@coc@coc_unpack_cut_left@","cut_cough_coccutter"} -- default animation
Config["image_source"] = "nui://esx_inventoryhud/html/img/items/" -- image source for item icon

Config["craft_table"] = {

	{
		name = "~y~โdsadsa",
		desc = "Crafting Table",
		model = GetHashKey("gr_prop_gr_bench_04b"),
		
		disable_model = false, -- ปิดโมเดล
		marker = true, -- เปิด marker
		marker_scale = {2.0,2.0,2.0}, -- ขนาดของ marker กว้าง ยาว สูง
		marker_color = {0,255,0}, -- สีของ marker แบบ rgb
		
		position = {x = 1154.59, y = 3028.57, z = 40.90, h = 197.15},
		table_color = "red", -- เปลี่ยนสีเมนู
		max_distance = 2.0,
		map_blip = true,
		limit_category = { 1 },
		no_item_limit = true,
		blip_name = "what",
		number = "27",
	},
	{
		name = "~y~โdsads321a",
		desc = "Crafting Table1",
		model = GetHashKey("gr_prop_gr_bench_01b"),
		
		disable_model = false, -- ปิดโมเดล
		marker = true, -- เปิด marker
		marker_scale = {2.0,2.0,2.0}, -- ขนาดของ marker กว้าง ยาว สูง
		marker_color = {0,255,0}, -- สีของ marker แบบ rgb
		
		position = {x = 1164.3, y = 3033.6, z = 40.2, h = 197.15},
		table_color = "red", -- เปลี่ยนสีเมนู
		max_distance = 2.0,
		map_blip = true,
		limit_category = { 1 },
		no_item_limit = true,
		blip_name = "what3",
		number = "10",
		type = "Shop",
	},
	{
		name = "~y~โdsads321a",
		desc = "Crafting Table1",
		--model = GetHashKey("gr_prop_gr_bench_01b"),
		
		disable_model = true, 
		marker = true, -- เปิด marker
		marker_scale = {2.0,2.0,2.0}, -- ขนาดของ marker กว้าง ยาว สูง
		marker_color = {0,255,0}, -- สีของ marker แบบ rgb
		
		position = {x = 487.23, y = -997.04, z = 30.0, h = 197.15},
		table_color = "red", 
		max_distance = 2.0,
		map_blip = false,
		limit_category = { 1 },
		no_item_limit = true,
		job = "police",
		number = "10",
		type = "Shop",
	},
	{
		name = "LSPD_LOCKER",
		desc = "Crafting Table1",
		--model = GetHashKey("gr_prop_gr_bench_01b"),
		
		disable_model = true, 
		marker = true, 
		marker_scale = {2.0,2.0,2.0}, 
		marker_color = {0,255,0}, -- สีของ marker แบบ rgb
		
		position = {x = 487.23, y = -997.04, z = 30.0, h = 197.15},
		table_color = "red", -- เปลี่ยนสีเมนู
		max_distance = 2.0,
		map_blip = false,
		limit_category = { 1 },
		no_item_limit = true,
		job = "police",
		number = "10",
		type = "Shop",
	},
}

Config["command"] = {
	command = "craftmenu",
	limit_category = {1,2,3},
	table_color = "red", -- เปลี่ยนสีเมนู
	enabled = true, -- ปรับเป็น false ถ้าไม่เอา
	event_mode = true, -- ใช้เมนูพิเศษนี้เป็น event แทน command = ชื่อ event ที่ใช้เรียกได้
}

--[[
	ทุกครั้งที่มีการต่อเพิ่มในตารางอย่าลืมใส่ , ที่ปีกกาปิดของอันเก่า
	
	ตัวอย่างการเพิ่ม หมวด
	[1] = { -- ต้องใช้เป็นเลขใหม่ต่อท้ายหมวดเก่า
		name = "หมวดทั่วไป", -- ชื่อหมวด
		scenario = "WORLD_HUMAN_AA_SMOKE", -- scenario ถ้าเปิดใช้อยู่ animation จะไม่ทำงานแล้วไปใช้งาน scenario
		animation = { -- เพิ่มอนิเมชั้นเองโดยเปลี่ยนทั้งหมวด ลบหากต้องการใช้แบบธรรมดา
			dict = "mp_player_inteat@burger",
			anim = "mp_player_int_eat_burger",
			flag = 30
		},
		list = { -- สำหรับเพิ่มไอเทม ต้องใส่ภายในปีกกาเท่านั้น
		}
	}
		
	ตัวอย่างการเพิ่ม ไอเทมลงในหมวด
	{
		item = "bread", --ชื่อของไอเทม ถ้าเป็นอาวุธให้ใช้ตัวเล็กหมด
		fail_chance = 15, --โอกาสที่จะล้มเหลวเวลาคราฟ
		fail_item = {"bread",1}, -- จะได้อะไรถ้าคราฟล้มเหลว
		amount = 3, --เมื่อคราฟแล้วจะได้กี่ชิ้น
		ammo = 10, -- เมื่อคราฟอาวุธอยากได้กระสุนกี่นัด
		cost = 500, -- เพิ่มราคาคราฟ ถ้าไม่มีจะยึดจาก Config["craft_cost"]
		cost_type = "black_money", -- ใช้เงินแบบไหนในการคราฟ ระหว่าง cash กับ black_money ปรับเป็นอย่างอื่นไม่ได้
		
		craft_duration = 10, -- สำหรับปรับเวลาที่จะใช้คราฟของชิ้นนี้
		scenario = "WORLD_HUMAN_AA_SMOKE", -- scenario ถ้าเปิดใช้อยู่ animation จะไม่ทำงานแล้วไปใช้งาน scenario
		
		animation = { -- เพิ่มอนิเมชั้นเองโดยเปลี่ยนแค่ชิ้นนี้ สามารถลบออกได้ถ้าไม่ต้องการ
			dict = "mp_player_inteat@burger",
			anim = "mp_player_int_eat_burger",
			flag = 30
		},
		
		equipment = { -- ถ้าต้องมีอุปกรณ์บางชิ้นก่อนถึงใส่ได้ให้เพิ่ม ถ้าไม่มีให้ลบออก
			["scissors"] = true, -- => true คือ เปิด false คือปิด
			["pro_wood"] = false -- ทั้งหมดหมายความว่าต้องการแค่กรรไกรในการคราฟ
		},
		
		blueprint = { -- ลิสของที่ต้องการ => ["ชื่อของไอเทม"] = @จำนวนที่ใช้
			["leather"] = 1, -- => หนังสัตว์ 1 ชิ้น
			["wood"] = 2 -- => ไม้ 2 ท่อน
		},
	},
]]

Config["category"] = {
	[1] = {
		name = "หมวดทั่วไป",
		list = {
			{
				item = "bread",
				fail_chance = 50,
				fail_item = {"bread",1}, -- ให้ของอย่างอื่นเมื่อล้มเหลว
				cost = 5000,
				cost_type = "cash",
				amount = 1,
				blueprint = {
					["bread"] = 50,
					["diamond"] = 5,
				},
			},
			{
				item = "cardweapon",
				fail_chance = 80,
				fail_item = {"bread",1}, -- ให้ของอย่างอื่นเมื่อล้มเหลว				
				cost = 2000,
				cost_type = "cash",		
				amount = 1,
				blueprint = {
					["diamond"] = 5,
					["gold_bar"] = 20,
					["carotool"] = 50,
					["cement"] = 10,
					["wire"] = 10,
				},
			},
		}
	},
	[2] = {
		name = "ของผิดกฎหมาย",
		list = {
			{
				item = "handcuffs_key",
				fail_chance = 95,
				fail_item = {"bread",1}, -- ให้ของอย่างอื่นเมื่อล้มเหลว

				craft_duration = 30,
				cost = 2000,
				cost_type = "black_money",
				blueprint = {
					["wire"] = 10,
					["diamond"] = 5,
					["Gem_Ruby"] = 5,
					["cement"] = 10,
					["carotool"] = 50,
					["steel_bar"] = 30,

				}
			},

			{
				item = "handcuffs",
				fail_chance = 95,
				fail_item = {"bread",1}, -- ให้ของอย่างอื่นเมื่อล้มเหลว

				craft_duration = 30,

				cost = 2000,
				cost_type = "black_money",
				blueprint = {
					["wire"] = 10,
					["Gem_Ruby"] = 5,
					["cement"] = 10,
					["carotool"] = 50,
					["steel_bar"] = 30,
				}
			},

			{
				item = "paper_bag",
				fail_chance = 50,
				fail_item = {"bread",1}, -- ให้ของอย่างอื่นเมื่อล้มเหลว

				craft_duration = 30,
				cost = 2000,
				cost_type = "black_money",
				blueprint = {
					["wire"] = 10,
					["steel_bar"] = 20,
					["Gem_Ruby"] = 5,
					["carotool"] = 50,
					["plasticbag"] = 20,

				}
			},
			{
				item = "hackerDevice",
				fail_chance = 80,
				fail_item = {"bread",1}, -- ให้ของอย่างอื่นเมื่อล้มเหลว

				craft_duration = 30,
				cost = 2000,
				cost_type = "black_money",
				blueprint = {
					["wire"] = 10,
					["steel_bar"] = 20,
					["Gem_Ruby"] = 5,
					["carotool"] = 50,

				}
			},


			

		}
	},
	[3] = {
		name = "หมวดอาวุธ",
		list = {
			{
				item = "weapon_bat",
				fail_chance = 97,
				craft_duration = 30,
				cost = 2000,
				cost_type = "black_money",
				equipment = { 
			    ["cardweapon"] = true, -- => true คือ เปิด false คือปิด  
		        },
				blueprint = {
					["wire"] = 20,
					["copper_bar"] = 30,
					["carotool"] = 50,
					["gold_bar"] = 20,
					["cement"] = 10,
					["diamond"] = 5,
					["Gem_Ruby"] = 5,

				}
			},
			{
				item = "weapon_POOLCUE",
				fail_chance = 97,
				craft_duration = 30,
				cost = 2000,
				cost_type = "black_money",
				equipment = { 
			    ["cardweapon"] = true, -- => true คือ เปิด false คือปิด  
		        },
				blueprint = {
					["wire"] = 20,
					["copper_bar"] = 30,
					["carotool"] = 50,
					["gold_bar"] = 20,
					["Gem_Ruby"] = 5,
					["cement"] = 10,
					["diamond"] = 5,

				}
			},
			{
				item = "weapon_knuckle",
				fail_chance = 0,
				craft_duration = 30,
				cost = 6000,
				cost_type = "black_money",
				equipment = { 
			    ["cardweapon"] = true, -- => true คือ เปิด false คือปิด  
		        },
				blueprint = {
					["token_fail"] = 50,
					["Gem_Ruby"] = 10,
					["cement"] = 10,
					["wire"] = 10,
					["carotool"] = 100,
				}
			},
			
		}
	},
	[4] = {
		name = "หมวดอาหาร",
		list = {
			{
				item = "pie", 
				fail_chance = 0,          -- โอกาศล้มเหลว 10%
				fail_item = {"bread",1}, -- ถ้าแตกจะได้ ขนมปัง
				cost = 0,         -- 200 บาท
				cost_type = "cash", -- ใช้เงินเขียว
				amount = 1,         -- คราฟแล้วได้ ขนมปัง 1 ชิ้น
				blueprint = {
					["cook_tomato"] = 5,  -- ของที่ใช้คราฟ
					["cook_ride_plant_process"] = 5,
					["cook_lettuce"] = 5,
					["cook_cornflour"] = 5,
					["water"] = 1,
				},
			},
			{
				item = "hotdog",
				fail_chance = 0,
				fail_item = {"bread",1}, -- ให้ของอย่างอื่นเมื่อล้มเหลว				
				cost = 0,
				cost_type = "cash",		
				amount = 1,
				blueprint = {
					["cook_tomato"] = 5,
					["cook_ride_plant_process"] = 5,
					["cook_lettuce"] = 5,
					["cook_cornflour"] = 5,
					["bread"] = 1,
				},
			},
			{
				item = "taco",
				fail_chance = 0,
				fail_item = {"bread",1}, -- ให้ของอย่างอื่นเมื่อล้มเหลว				
				cost = 0,
				cost_type = "cash",		
				amount = 1,
				blueprint = {
					["cook_tomato"] = 5,
					["cook_ride_plant_process"] = 5,
					["cook_lettuce"] = 5,
					["cook_cornflour"] = 5,
					["meat"] = 1,
				},
			},
		}
	},





}

Config["disable_custom_font"] = false

Config["translate"] = {
	you_crafted = 'คุณได้ทำการสร้าง <span style="color:gold">%s</span> จำนวน <span style="color:lawngreen">%d</span> ชิ้น!',
	not_enough = "ส่วนประกอบไม่เพียงพอ",
	not_enough2 = "กรุณาเตรียมส่วนประกอบให้พร้อม",
	you_blow = "คุณล้มเหลวในการสร้าง %s",
	received_from_fail = 'คุณได้รับ <span style="color:maroon">%s</span> จำนวน <span style="color:red">%s</span> ชิ้น จากความล้มเหลวของตัวเอง',
	no_equipment = "คุณไม่มีอุปกรณ์",
	no_equipment2 = "ต้องใช้อุปกรณ์ในการคราฟของชิ้นนี้",
	no_money = "เงินไม่เพียงพอ",
	no_money2 = "คุณต้องการเงิน $%s ในการคราฟ",
	limit_reach = "ไม่สามารถสร้างเกินจำนวน",
	limit_reach2 = "เนื่องจากจะเกินจำนวนที่ตั้งไว้ จึงไม่สามารถสร้างได้",
	discord_bot = "Crafting Table",
	discord_item = "คุณ %s ได้สร้าง %s เป็นจำนวน %s อัน",
	discord_weapon = "คุณ %s ได้สร้างอาวุธ %s เป็นจำนวน %s อัน",
	discord_failed = "คุณ %s ล้มเหลวในการสร้าง %s",
	discord_identifier = "\nSteam Identifier: %s\nเวลา: %s",
	crafting = "กำลังสร้าง",
	limit_weight_reach = "น้ำหนักกระเป๋าเกิน",
	limit_weight_reach2 = "น้ำหนักกระเป๋าเกินไม่สามารถสร้างได้<br>ตอนนี้ %s/%s KG.",
	already_have_weapon = "ไม่สร้างอาวุธได้",
	already_have_weapon2 = "คุณมีอาวุธนี้อยู่แล้ว",
	job_limit = "~r~คุณไม่สามารถใช้โต๊ะของ %s ได้",
	job_police = "ตำรวจ",
	job_ambulance = "หมอ",
	job_mecano = "ช่าง",
	job_mechanic = "ช่าง",
	police_required = "~r~ต้องการตำรวจ %s นาย",
	not_allowed = "~r~คุณไม่ได้รับอนุญาติให้ใช้โต๊ะนี้",
	allow_for = "~g~ใช้งานได้อีก: %s วินาที",
	press_info = "press ~INPUT_CONTEXT~ to access ~y~crafting menu",
	ui_no_item_category = "ไม่มีของในหมวดนี้",
	ui_required_item = "ส่วนประกอบที่ต้องการ",
	ui_required_equipment = "อุปกรณ์ที่ต้องการ",
	ui_you_will_get = "จะได้รับ",
}