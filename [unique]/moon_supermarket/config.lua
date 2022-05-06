Config_xZC_Shop = {}

-- Base Extended
Config_xZC_Shop.Base = {
    getSharedObject = 'esx:getSharedObject',
    setJob = 'esx:setJob'
}

------------------------------ Config Settings
Config_xZC_Shop.URL_Images = "nui://pw-inventory/nui/icons/" 
Config_xZC_Shop.ESX_CheckWeight = true 

------------------------------- Default
Config_xZC_Shop.Default = {
    limit = 10,
    item_type = "item_standard",
    price_account_name = "money",

    -- Blip
    Blip = {
        Sprite = 52,
        Colour = 2,
        Scale = 1.0
    },
    -- Marker
    Marker = {
        Distance = 30,
        Type = 1,
        Size = { x = 1.5, y = 1.5, z = 1.5 },
        Color = { r = 0, g = 128, b = 255 }
    }
}


Config_xZC_Shop.Zones = {

    {
        Name = "General", --Tên tham chiếu
        Label = "Cửa hàng tạp hoá", -- Tên hiển thị
        Job = { 
			--"police",
			--"ambulance"
        }, 
        ItemsRequire = {
            -- Phải có đồ yêu cầu mới cho phép mua
            --"phone",
            --"credit"
        },
        Items = { 
            {
                name = "bread", 
				label = "Bánh mì", 
                item_type = "item_standard",
                --price_account_name = "black_money", 
                price = 100
                --limit = 5
            },
	    {
                name = "fishbait", -- ชื่อไอเทม
					
				--label = "ขนมปัง", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                --item_type = "item_weapon", -- หากไอเทมเป็นประเภทอาวุธให้ใส่บรรทัดนี้เข้าไปด้วย (ถ้าไอเทมปกติไม่ต้องใส่บรรทัดนี้)
                --price_account_name = "black_money", -- หากต้องการให้ใช้เงินแดงซื้อให้ใส่บรรทัดนี้ลงไป (ถ้าเงินเขียวไม่ต้องใส่บรรทัดนี้)
                price = 10, -- ราคา
                limit = 5 -- สามารถเลือกจำนวนซื้อได้ทีละกี่อัน (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
            },
            {
                name = "water",
		label = "Nước",
		item_type = "item_standard",
                price = 100
            },
			{
                name = "beer",
		label = "Bia",
		item_type = "item_standard",
                price = 1000
            },
			{
                name = "haniken",
		label = "Haniken",
		item_type = "item_standard",
                price = 1000
            },
			{
                name = "vodka",
				label = "Vodka Cá Sấu",
				item_type = "item_standard",
                price = 1000
            },
			{
                name = "phone",
				label = "Điện thoại",
				item_type = "item_weapon",
                price = 1000
            },
			{
                name = "fishingrod",
				label = "Cần câu cá",
				item_type = "item_standard",
                price = 1500
            },
			{
                name = "fishbait",
				label = "Mồi câu cá",
				item_type = "item_standard",
                price = 100
            },
			{
                name = "turtlebait",
				label = "Mồi câu rùa",
				item_type = "item_standard",
				price_account_name = "black_money", 
                price = 4000
            },
			{
                name = "revivekit",
				label = "Hộp cứu chữa",
				item_type = "item_standard",
                price = 30000
            },
			{
                name = "medkit",
				label = "Hộp sơ cứu",
				item_type = "item_standard",
                price = 5000
            },
			{
                name = "oxygen_mask",
				label = "Mặt nạ lặn",
				item_type = "item_standard",
                price = 800
            },
			{
                name = "bullet_wear_2",
				label = "Giáp chống đạn lv2",
				item_type = "item_standard",
                price = 40000
            },
			{
                name = "fixkit",
				label = "Công cụ sửa chữa",
				item_type = "item_standard",
                price = 40000
            },
			{
                name = "petfood",
				label = "Thức ăn pet",
				item_type = "item_standard",
                price = 5000
            },
			{
                name = "petwater",
				label = "Nước cho pet",
				item_type = "item_standard",
                price = 5000
            },
			{
                name = "tool_cement",
				label = "Bao tay chuyên dụng",
				item_type = "item_standard",
                price = 500000
            },
			{
                name = "tool_engine",
				label = "Công cụ chuyên dụng",
				item_type = "item_standard",
                price = 500000
            },
			{
                name = "tool_pipe",
				label = "Đèn khò",
				item_type = "item_standard",
                price = 500000
            }
			
	 -- {
                 -- name = "weapon_pistol",
		 -- item_type = "item_weapon",
		-- price_account_name = "black_money",
                -- price = 15,
				 -- ammo = 50
             -- }
         },
        ItemsInclude = { }, -- Set item
        Blip = { -- Blip Map
			
            Show = true, 
            Name = "Shop - General",
            Sprite = 52, 
            Colour = 2, 
            Scale = 1.0 
        },
        Marker = { 
            Show = true, 
            Type = 29, 
            Size = { x = 1.5, y = 1.5, z = 1.5 }, 
			Color = { r = 0, g = 128, b = 255 }, 
            Pos_Z_up = 1.0, --Nó sẽ cao bao nhiêu so với vị trí ban đầu (Đề phòng trường hợp nó chìm xuống đất, giá trị có thể tăng lên ở đây)
            Pos_Z_down = 0 -- Nó sẽ được đặt thấp bao nhiêu so với vị trí ban đầu?
        },
        Pos = { 
            {x = 1135.808,  y = -982.281,  z = 45.415},
			{x = -1222.915, y = -906.983,  z = 11.326},
			{x = -1487.553, y = -379.107,  z = 39.163},
			{x = -2968.243, y = 390.910,   z = 14.043},
			{x = 1166.024,  y = 2708.930,  z = 37.157},
			{x = 1392.562,  y = 3604.684,  z = 33.980},
			{x = 25.723,   y = -1346.966, z = 28.497}, 
			{x = -1393.409, y = -606.624,  z = 29.319},
            {x = -1037.618,  y = -2737.399,   z = 19.169},
            {x = 373.875,   y = 325.896,  z = 102.566},
			{x = 2557.458,  y = 382.282,  z = 107.622},
			{x = -3038.939, y = 585.954,  z = 6.908},
			{x = -3241.927, y = 1001.462, z = 11.830},
			{x = 547.431,   y = 2671.710, z = 41.156},
			{x = 1961.464,  y = 3740.672, z = 31.343},
			{x = 2678.916,  y = 3280.671, z = 54.241},
			{x = 1729.216,  y = 6414.131, z = 34.037}
        }
    }

    -- {
        -- Name = "Weapons", 
        -- Label = "ร้านค้าอาวุธ",
        -- Job = { },
        -- ItemsRequire = {

        -- },
        -- Items = {  
            -- {
                -- name = "WEAPON_PISTOL", 
                -- item_type = "item_weapon",
                -- ammo = 100, 
                -- price_account_name = "black_money", 
                -- price = 1000, 
            -- },
            -- {
                -- name = "weapon_combatpistol", -
                -- item_type = "item_weapon",
                -- ammo = 100, -- กระสุนที่ได้ตอนซื้อ
                -- price_account_name = "black_money", -- เงินแดงให้ใส่บรรทัดนี้ลงไป
                -- price = 1500, -- ราคา
            -- },
            -- {
                -- name = "weapon_pistol50", -- ชื่อไอเทม
                -- item_type = "item_weapon",
                -- ammo = 100, -- กระสุนที่ได้ตอนซื้อ
                -- price_account_name = "black_money", -- เงินแดงให้ใส่บรรทัดนี้ลงไป
                -- price = 1500, -- ราคา
            -- },
            -- {
                -- name = "weapon_marksmanpistol", -- ชื่อไอเทม
                -- item_type = "item_weapon",
                -- ammo = 50, -- กระสุนที่ได้ตอนซื้อ
                -- price_account_name = "black_money", -- เงินแดงให้ใส่บรรทัดนี้ลงไป
                -- price = 5000, -- ราคา
            -- },
            -- {
                -- name = "weapon_microsmg", -- ชื่อไอเทม
                -- item_type = "item_weapon",
                -- ammo = 100, -- กระสุนที่ได้ตอนซื้อ
                -- price_account_name = "black_money", -- เงินแดงให้ใส่บรรทัดนี้ลงไป
                -- price = 5000, -- ราคา
            -- },
            -- {
                -- name = "weapon_knuckle", -- ชื่อไอเทม
                -- item_type = "item_weapon",
                -- ammo = 0, -- กระสุนที่ได้ตอนซื้อ
                -- price_account_name = "black_money", -- เงินแดงให้ใส่บรรทัดนี้ลงไป
                -- price = 1000, -- ราคา
            -- }
        -- },
        -- ItemsInclude = { "SET_WEAPON_01" }, -- ดึงรายไอเทมที่เราสร้างเซ็ทไอเทมไว้มาลงในร้านนี้
        -- Blip = { -- Blip Map
            -- Show = true, -- true = แสดง Blip ใน Map (ถ้า false = ไม่แสดง)
            -- Name = "Shop - Weapons", -- ชื่อ Blip ใน Map
            -- Sprite = 110, -- รูป Blip
            -- Colour = 1, -- สี Blip
            -- Scale = 1.0 -- ขนาด Blip
        -- },
        -- Marker = { -- Marker
            -- Show = true, -- true = แสดง Marker (false = ไม่แสดง)
            -- Type = 29, -- ประเภท Marker
            -- Size = { x = 1.5, y = 1.5, z = 1.5 }, -- ขนาด Marker
            -- Color = { r = 255, g = 0, b = 0 }, -- สี Marker
            -- Pos_Z_up = 0, -- จะกำหนดให้สูงจากตำแหน่งเดิมเท่าไหร่ (เอาไว้กรณีมันจมลงไปในพื้นสามารถเพิ่มค่าตรงนี้ได้)
            -- Pos_Z_down = 0 -- จะกำหนดให้ต่ำจากตำแหน่งเดิมเท่าไหร่
        -- },
        -- Pos = { -- สร้างจุดสำหรับกดเปิดร้าน (ตำแหน่งในเกม x y z)
            -- {x = 21.64, y = -1106.79, z = 29.8}

        -- }
    -- }

}

------------------------ ItemsInclude กำหนดสร้างเซ็ทไอเทม (เอาไว้สำหรับลงขายในร้าน)
Config_xZC_Shop.ItemsInclude = {
    
    ["SET_WEAPON_01"] = {
        {
            name = "weapon_doubleaction",
            item_type = "item_weapon",
            ammo = 100,
            price_account_name = "black_money",
            price = 1000
        },
        {
            name = "weapon_assaultsmg",
            item_type = "item_weapon",
            ammo = 100,
            price_account_name = "black_money",
            price = 5000
        },
        {
            name = "weapon_heavyshotgun",
            item_type = "item_weapon",
            price_account_name = "black_money",
            ammo = 100,
            price = 5000
        }
    }
}
