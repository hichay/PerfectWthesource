Config = {}

Config.price_format = "~g~$%d" -- %d <- price

Config.cam_coords = {
    -- vector3(-662.1, -935.3, 22.0),
    -- vector3(810.2, -2157.3, 30.0),
    -- vector3(1693.4, 3759.5, 35.3),
    -- vector3(-330.2, 6083.8, 32.0),
    -- vector3(252.3, -50.0, 70.4),
    -- vector3(22.0, -1107.2, 30.5),
    -- vector3(2567.6, 294.3, 109.0),
    -- vector3(-1117.5, 2698.6, 19.3),
    -- vector3(842.4, -1033.4, 29.0)
	vector3(4286.9267, -4539.328, 5.5296173),
	vector3(5032.3334, -4630.647, 21.684604),
	vector3(5153.2065, -4934.029, 30.873422),
	vector3(5147.5043, -5053.323, 20.391548),
	vector3(5042.4267, -5114.978, 22.944614),
	vector3(5125.8085, -5527.314, 70.97039)
}

Config.cam_point_coords = {

    -- vector3(-662.2, -934.4, 22.0),
    -- vector3(810.2, -2158.3, 30.0),
    -- vector3(1692.4, 3760.2, 35.3),
    -- vector3(-330.9, 6084.6, 32.0),
    -- vector3(253.3, -50.38, 70.4),
    -- vector3(22.3, -1106.05, 30.5),
    -- vector3(2567.7, 293.2, 109.0),
    -- vector3(-1118.5, 2699.4, 19.3),
    -- vector3(842.3, -1034.9, 29.0)
	vector3(4286.2841, -4536.604, 5.5296173),
	vector3(5032.9526, -4630.874, 21.684604),
	vector3(5153.5874, -4933.564, 30.873422),
	vector3(5148.3266, -5053.323, 20.391548),
	vector3(5042.8652, -5114.973, 22.944614),
	vector3(5125.5717, -5526.936, 70.97039)
	
	

} -- placeholder <- the camera will point at the floating weapon once it spawns

Config.weapon_coords = {

    -- vector3(-662.2, -934.4, 22.0),
    -- vector3(810.2, -2158.3, 30.0),
    -- vector3(1692.4, 3760.2, 35.3),
    -- vector3(-330.9, 6084.6, 32.0),
    -- vector3(253.3, -50.38, 70.4),
    -- vector3(22.3, -1106.05, 30.5),
    -- vector3(2567.7, 293.2, 109.0),
    -- vector3(-1118.5, 2699.4, 19.3),
    -- vector3(842.3, -1034.9, 29.0)
	
	vector3(4286.789, -4537.983, 5.3655366),
	vector3(5032.9526, -4630.874, 21.684604),
	vector3(5154.0595, -4933.023, 30.873422),
	vector3(5148.3266, -5053.323, 20.391548),
	vector3(5043.4741, -5114.959, 22.944614),
	vector3(5125.3549, -5526.592, 70.97039)

} -- the floating weapon coords

Config.marker = {

    --pos = vector3(21.86, -1106.684, 28.797),
    size = vector3(1,1,0.2),
    color = {r = 50, g = 255, b = 50, a = 150},
    locations = {

        -- vector3(-662.1, -935.3, 20.8),
        -- vector3(810.2, -2157.3, 28.6),
        -- vector3(1693.4, 3759.5, 33.7),
        -- vector3(-330.2, 6083.8, 30.4),
        -- vector3(252.3, -50.0, 68.9),
        -- vector3(22.0, -1107.2, 28.8),
        -- vector3(2567.6, 294.3, 107.7),
        -- vector3(-1117.5, 2698.6, 17.5),
        -- vector3(842.4, -1033.4, 27.1)
		
		vector3(4286.6347, -4539.406, 4.2270169),
		vector3(5031.0805, -4630.519, 21.684604), --chòi canh
		vector3(5152.6669, -4934.532, 30.873422),
		vector3(5146.2294, -5053.412, 20.391548),
		vector3(5041.4257, -5114.986, 22.944614),
		vector3(5126.3027, -5528.085, 70.970397)

    }

}

Config.lang = {

    owned = "Đã sở hữu",
    equipped = "Đã trang bị",
    yes = "Đồng ý",
    no = "Từ chối",
    back = "Quay trở lại",
    attachments_upgrades = "Phụ kiện/Nâng cấp",
    tints = "Màu sơn",
    free = "Miễn phí",
    ammo = "Đạn (%d)", -- %d <- ammo count
    not_enough_money = "Bạn không có đủ tiền để mua!",
	buy_success = "Bạn đã mua thành công!",
	buy_ammo = "Bạn đã mua đạn thành công!",
	buy_compo = "Bạn đã mua phụ kiện thành công!",
	buy_tint = "Bạn đã mua sơn màu thành công!",
    marker_text = "Ấn ~INPUT_CONTEXT~ để mua súng"

}

Config.menu = {
    main = {
        title = "GUNSHOP.VN",
        subtitle = "VŨ KHÍ HIỆN CÓ",
        x = 0.76,
        y = 0.25,
        titlecolor = {255,255,255,255}, -- r,g,b,a
        backcolor = {247,65,71,255} -- r,g,b,a
    },

    weapon = {
        title = "%s", -- %s <- weapon label
        subtitle = "NÂNG CẤP HIỆN CÓ", -- %s <- weapon label
        x = 0.76,
        y = 0.25,
        titlecolor = {255,255,255,255}, -- r,g,b,a
        backcolor = {247,65,71,255} -- r,g,b,a
    }

}

--[[



Add your own weapons:

https://www.se7ensins.com/forums/threads/weapon-and-explosion-hashes-list.1045035/

https://wiki.rage.mp/index.php?title=Weapons_Components

https://wiki.gtanet.work/index.php?title=Weapons_Tints



--]]

Config.weapons = {

   
    -- {
        -- weapon = "WEAPON_NIGHTSTICK",
        -- label = "Dùi cui",
        -- price = 8000,
        -- can_buy_ammo = false,
        -- ammo_price = 0,
        -- ammo_count = 0,
        -- allowed = true,
    -- },
	
	-- {

        -- weapon = "WEAPON_SNIPERRIFLERED",
        -- label = "SNip",
        -- price = 200,
        -- can_buy_ammo = true,
        -- ammo_price = 0,
        -- ammo_count = 0,
        -- allowed = true,
		-- upgrades = {
            -- {
                -- label = "Đèn pin",
                -- hash = "COMPONENT_SNIPERRIFLELORE_FULL",
                -- price = 1000
            -- }
        -- },
    -- },
	
	--[[ {
        weapon = "weapon_stungun",
        label = "Súng điện",
        price = 20000,
        can_buy_ammo = false,
        ammo_price = 0,
        ammo_count = 0,
        allowed = false,
    },
	
    {
        weapon = "WEAPON_MACHETE",
        label = "Mã tấu",
        price = 10000,
        can_buy_ammo = false,
        ammo_price = 0,
        ammo_count = 0,
        allowed = true,
    },

    {
        weapon = "WEAPON_KNIFE",
        label = "Dao",
        price = 10000,
        can_buy_ammo = false,
        ammo_price = 0,
        ammo_count = 0,
        allowed = true,
    }, ]]


    -- {
    --     weapon = "WEAPON_PETROLCAN",
    --     label = "Bình xăng",
    --     price = 500,
    --     can_buy_ammo = true,
    --     ammo_price = 100,
    --     ammo_count = 50,
    -- },

    {

        weapon = "GADGET_PARACHUTE",
        label = "Dù",
        price = 2000,
        can_buy_ammo = false,
        ammo_price = 0,
        ammo_count = 0,
        allowed = true,

    },

    {

        weapon = "WEAPON_PISTOL",
        label = "Pistol",
        price = 50000,
        can_buy_ammo = true,
        ammo_price = 400,
        ammo_count = 80,
        allowed = true,
        upgrades = {

            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_PI_FLSH",
                price = 5000
            },

             {
                 label = "Giảm thanh",
                 hash = "COMPONENT_AT_PI_SUPP_02",
                 price = 30000
             },

            {
                label = "Băng đạn mặc định",
                hash = "COMPONENT_PISTOL_CLIP_01",
                price = 0
			},
			

            {
                label = "Băng đạn dài",
                hash = "COMPONENT_PISTOL_CLIP_02",
                price = 10000
			},
			
			-- {
                -- label = "Mạ vàng súng",
                -- hash = "COMPONENT_PISTOL_VARMOD_LUXE",
                -- price = 1000000
            -- }

        },

        tints = {
            {
                label = "Sơn mặc định",
                index = 0,
                price = 0
            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 20000

            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 20000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 20000

            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 20000

            },

            {
                label = "Sơn màu cam",
                index = 6,
                 price = 20000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 20000
            }

        }

    },

    {

        weapon = "WEAPON_COMBATPISTOL",
        label = "Combat Pistol",
        price = 70000,
        can_buy_ammo = true,
        ammo_price = 600,
        ammo_count = 80,
        allowed = true,
        upgrades = {

            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_PI_FLSH",
                price = 5000
            },

            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_PI_SUPP",
                price = 30000
            },

            {
                label = "Băng đạn mặc định",
                hash = "COMPONENT_COMBATPISTOL_CLIP_01",
                price = 0
            },

            {
                label = "Băng đạn dài",
                hash = "COMPONENT_COMBATPISTOL_CLIP_02",
                price = 15000
			},
			
			-- {
                -- label = "Mạ vàng súng",
                -- hash = "COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER",
                -- price = 1000000
            -- }

        },

        tints = {
            {
                label = "Sơn mặc định",
                index = 0,
                price = 0
            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 20000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 20000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 20000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 20000
            },

             {
                 label = "Sơn màu cam",
                 index = 6,
                 price = 20000
             },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 20000
            }
        }
    },

    {
        weapon = "WEAPON_APPISTOL",
        label = "AP Pistol",
        price = 100000,
        can_buy_ammo = true,
        ammo_price = 700,
        ammo_count = 80,
        allowed = true,
        upgrades = {
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_PI_FLSH",
                price = 5000
            },

            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_PI_SUPP",
                price = 30000
            },

            {
                label = "Băng đạn mặc định",
                hash = "COMPONENT_APPISTOL_CLIP_01",
                price = 0
            },

            {
                label = "Băng đạn dài",
                hash = "COMPONENT_APPISTOL_CLIP_02",
                price = 15000
			},
			
			-- {
                -- label = "Platinum Pearl Deluxe Finish",
                -- hash = "COMPONENT_PISTOL50_VARMOD_LUXE",
                -- price = 1000000
            -- }

        },

        tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 0
            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 20000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 20000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 20000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 20000
            },

             {

                 label = "Sơn màu cam",
                 index = 6,
                 price = 20000
             },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 20000
            }
        }
	},

	{

        weapon = "WEAPON_MACHINEPISTOL",
        label = "Machine Pistol",
        price = 70000,
        can_buy_ammo = true,
        ammo_price = 700,
        ammo_count = 80,
        allowed = true,
        upgrades = {

            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_PI_FLSH",
                price = 5000
            },

            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_PI_SUPP",
                price = 30000
            },

            {
                label = "Băng đạn mặc định",
                hash = "COMPONENT_MACHINEPISTOL_CLIP_01",
                price = 0
            },

            {
                label = "Băng đạn dài",
                hash = "COMPONENT_MACHINEPISTOL_CLIP_02",
                price = 40000
			},
			
			{
                label = "Băng đạn dài 2",
                hash = "COMPONENT_MACHINEPISTOL_CLIP_03",
                price = 40000
            }

        },

        tints = {
            {
                label = "Sơn mặc định",
                index = 0,
                price = 0
            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 20000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 20000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 20000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 20000
            },

             {
                 label = "Sơn màu cam",
                 index = 6,
                 price = 20000
             },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 20000
            }
        }
    },
	
	{
        weapon = "WEAPON_REVOLVER",
        label = "Heavy Revolver",
        price = 100000,
        can_buy_ammo = true,
        ammo_price = 10000,
        ammo_count = 80,
        allowed = true,
        upgrades = {
			{
                label = "Băng đạn mặc định",
                hash = "COMPONENT_REVOLVER_CLIP_01",
                price = 0
			},
			
            -- {
                -- label = "VIP Variant",
                -- hash = "COMPONENT_REVOLVER_VARMOD_BOSS",
                -- price = 300000
            -- },

			-- {
                -- label = "Bodyguard Variant",
                -- hash = "COMPONENT_REVOLVER_VARMOD_GOON",
                -- price = 300000
            -- }

        },

        tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 0
            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 500000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 500000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 500000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 500000
            },

            {

                label = "Sơn màu cam",
                index = 6,
                price = 500000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 500000
            }
        }
	},
	
	{
        weapon = "WEAPON_SNSPISTOL",
        label = "SNS Pistol",
        price = 80000,
        can_buy_ammo = true,
        ammo_price = 2000,
        ammo_count = 80,
        allowed = true,
        upgrades = {
			{
                label = "Băng đạn mặc định",
                hash = "COMPONENT_SNSPISTOL_CLIP_01",
                price = 0
			},
			
            {
                label = "Băng đạn mở rộng",
                hash = "COMPONENT_SNSPISTOL_CLIP_02",
                price = 100000
            },

			-- {
                -- label = "Etched Wood Grip Finish",
                -- hash = "COMPONENT_SNSPISTOL_VARMOD_LOWRIDER	",
                -- price = 300000
            -- }

        },

        tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 0
            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 500000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 500000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 500000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 500000
            },

            {

                label = "Sơn màu cam",
                index = 6,
                price = 500000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 500000
            }
        }
	},
	
	{
        weapon = "weapon_vintagepistol",
        label = "Vintage Pistol",
        price = 80000,
        can_buy_ammo = true,
        ammo_price = 2000,
        ammo_count = 80,
        allowed = true,
        upgrades = {
			{
                label = "Băng đạn mặc định",
                hash = "COMPONENT_VINTAGEPISTOL_CLIP_01",
                price = 0
			},
			
            {
                label = "Băng đạn mở rộng",
                hash = "COMPONENT_VINTAGEPISTOL_CLIP_02",
                price = 100000
            },

			{
                label = "Giảm thanh",
                hash = "COMPONENT_AT_PI_SUPP	",
                price = 300000
            }

        },

        tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 0
            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 500000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 500000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 500000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 500000
            },

            {

                label = "Sơn màu cam",
                index = 6,
                price = 500000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 500000
            }
        }
    },


    {
        weapon = "WEAPON_MICROSMG",
        label = "Micro SMG (Uzi)",
        price = 170000,
        can_buy_ammo = true,
        ammo_price = 1300,
        ammo_count = 80,
        allowed = true,
        upgrades = {

            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_PI_FLSH",
                price = 5000
            },

            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP_02",
                price = 40000
            },

            {
                label = "Băng đạn mặc định",
                hash = "COMPONENT_MICROSMG_CLIP_01",
                price = 0
            },

            {
                label = "Băng đạn dài",
                hash = "COMPONENT_MICROSMG_CLIP_02",
                price = 25000
            },

            {
                label = "Scope",
                hash = "COMPONENT_AT_SCOPE_MACRO",
                price = 10000
			},
			
			-- {
                -- label = "Mạ vàng",
                -- hash = "COMPONENT_MICROSMG_VARMOD_LUXE",
                -- price = 1000000
            -- }

        },

        tints = {
            {
                label = "Sơn mặc định",
                index = 0,
                price = 30000
            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 30000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 30000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 30000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 30000
            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 30000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 30000
            }
        }
    },

    {
        weapon = "WEAPON_SMG",
        label = "SMG",
        price = 220000,
        can_buy_ammo = true,
        ammo_price = 1500,
        ammo_count = 80,
        allowed = true,
        upgrades = {

            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                price = 5000
            },

            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_PI_SUPP",
                price = 40000
            },

            {
                label = "Băng đạn mặc định",
                hash = "COMPONENT_SMG_CLIP_01",
                price = 0
            },

            {
                label = "Băng đạn dài",
                hash = "COMPONENT_SMG_CLIP_02",
                price = 100000
			},
			
			{
                label = "Băng đạn dài 2",
                hash = "COMPONENT_SMG_CLIP_03",
                price = 100000
            },

            {
                label = "Scope",
                 hash = "COMPONENT_AT_SCOPE_MACRO_02",
                 price = 10000
			},
			
			-- {
                -- label = "Mạ vàng",
                 -- hash = "COMPONENT_SMG_VARMOD_LUXE",
                 -- price = 1000000
            -- }
        },

        tints = {
            {
                label = "Sơn mặc định",
                index = 0,
                price = 30000
            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 30000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 30000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 30000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 30000
            },

            {

                label = "Sơn màu cam",

                index = 6,

                price = 30000

             },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 30000
            }
        }
    },

    {
        weapon = "WEAPON_ASSAULTSMG",
        label = "Assault SMG",
        price = 270000,
        can_buy_ammo = true,
        ammo_price = 2000,
        ammo_count = 80,
        allowed = true,
        upgrades = {

            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                price = 5000
            },

            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP_02",
                price = 40000
            },

            {
                label = "Băng đạn mặc định",
                hash = "COMPONENT_ASSAULTSMG_CLIP_01",
                price = 0
            },

            {
                label = "Băng đạn dài",
                hash = "COMPONENT_ASSAULTSMG_CLIP_02",
                price = 100000
            },

            {
                label = "Scope",
                hash = "COMPONENT_AT_SCOPE_MACRO",
                price = 10000
			},
			
			-- {
                -- label = "Mạ vàng",
                -- hash = "COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER",
                -- price = 1000000
            -- }
        },

        tints = {
            {
                label = "Sơn mặc định",
                index = 0,
                price = 0
            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 30000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 30000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 30000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 30000
            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 30000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 30000
            }
        }
	},

	{
        weapon = "WEAPON_COMBATPDW",
        label = "Combat PDW",
        price = 300000,
        can_buy_ammo = true,
        ammo_price = 7000,
        ammo_count = 80,
        allowed = true,
        upgrades = {

            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                price = 5000
            },

            {
                label = "Grip",
                hash = "COMPONENT_AT_AR_AFGRIP",
                price = 40000
            },

            {
                label = "Băng đạn mặc định",
                hash = "COMPONENT_COMBATPDW_CLIP_01",
                price = 0
            },

            {
                label = "Băng đạn dài",
                hash = "COMPONENT_COMBATPDW_CLIP_02",
                price = 100000
			},
			
			{
                label = "Băng đạn dài 2",
                hash = "COMPONENT_COMBATPDW_CLIP_03",
                price = 100000
            },

            {
                label = "Scope",
                hash = "COMPONENT_AT_SCOPE_SMALL",
                price = 10000
			}
        },

        tints = {
            {
                label = "Sơn mặc định",
                index = 0,
                price = 0
            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 30000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 30000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 30000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 30000
            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 30000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 30000
            }
        }
	},

	
	
	{
        weapon = "WEAPON_PUMPSHOTGUN",
        label = "Pump Shotgun",
        price = 150000,
        can_buy_ammo = true,
        ammo_price = 2000,
        ammo_count = 80,
        allowed = true,
        upgrades = {

            {
            	label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                price = 50000
            },

            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_SR_SUPP",
                price = 100000
			},

			-- {
                -- label = "Mạ vàng",
                -- hash = "COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER",
                -- price = 1000000
			-- }
			
        },

        tints = {
            {
                label = "Sơn mặc định",
                index = 0,
                price = 0
            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 30000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 30000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 30000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 30000
            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 30000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 30000
            }
        }
    },

    {
        weapon = "WEAPON_SAWNOFFSHOTGUN",
        label = "Sawed-off Shotgun",
        price = 250000,
        can_buy_ammo = true,
        ammo_price = 1000,
        ammo_count = 80,
        allowed = true,

		upgrades = {


			-- {
                -- label = "Mạ kim loại",
                -- hash = "COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE",
                -- price = 100000
			-- }
			
        },

        tints = {
            {
                label = "Sơn mặc định",
                index = 0,
                price = 0
            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 30000	
			},   
			{
                label = "Sơn hồng",
                index = 3,
                price = 30000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 30000

            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 30000

            },

        	{
            	label = "Sơn màu cam",
        		index = 6,
                price = 30000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 30000
            }

        }

	},
	
	{
        weapon = "WEAPON_ASSAULTSHOTGUN",
        label = "Assault Shotgun",
        price = 280000,
        can_buy_ammo = true,
        ammo_price = 2000,
        ammo_count = 80,
        allowed = false,
        upgrades = {

            {
            	label = "Băng đạn mặc định",
                hash = "COMPONENT_ASSAULTSHOTGUN_CLIP_01",
                price = 0
			},
			
			{
            	label = "Băng đạn nâng cấp",
                hash = "COMPONENT_ASSAULTSHOTGUN_CLIP_02",
                price = 0
			},
			
			{
            	label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                price = 50000
			},
			
			{
            	label = "Grip",
                hash = "COMPONENT_AT_AR_AFGRIP",
                price = 200000
            },

            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP",
                price = 200000
			}
			
        },

        tints = {
            {
                label = "Sơn mặc định",
                index = 0,
                price = 0
            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 30000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 30000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 30000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 30000
            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 30000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 30000
            }
        }
    },

    {
        weapon = "WEAPON_BULLPUPSHOTGUN",
        label = "Bullpup Shotgun",
        price = 280000,
        can_buy_ammo = true,
        ammo_price = 2000,
        ammo_count = 80,
        allowed = true,
        upgrades = {

            {
            	label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                price = 5000
            },

            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP_02",
                price = 40000
			}
			
        },

        tints = {
            {
                label = "Sơn mặc định",
                index = 0,
                price = 0
            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 30000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 30000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 30000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 30000
            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 30000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 30000
            }
        }
    },

    {
        weapon = "WEAPON_ASSAULTRIFLE",
        label = "Assault Rifle",
        price = 500000,
        can_buy_ammo = true,
        ammo_price = 2000,
        ammo_count = 80,
        allowed = true,
        upgrades = {

            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                price = 50000

            },

            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP_02",
                price = 200000

            },
			 
			
            {
                label = "Băng đạn mặc định",
                hash = "COMPONENT_ASSAULTRIFLE_CLIP_01",
                price = 0

            },

            {
                label = "Băng đạn dài",
                hash = "COMPONENT_ASSAULTRIFLE_CLIP_02",
                price = 1000000

			},
			
			{
                label = "Băng đạn 2",
                hash = "COMPONENT_ASSAULTRIFLE_CLIP_03",
                price = 1000000

            },

            {
                label = "Scope",
                hash = "COMPONENT_AT_SCOPE_MACRO",
                price = 50000
			},
			
			{
                label = "Grip",
                hash = "COMPONENT_AT_AR_AFGRIP",
                price = 300000
			},
			
			-- {
                -- label = "Mạ Vàng Súng",
                -- hash = "COMPONENT_ASSAULTRIFLE_VARMOD_LUXE",
                -- price = 1000000
            -- }

        },

        tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 0

            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 50000

            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 1000000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 70000

            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 60000

            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 1000000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 1000000
            }

        }

	},
	
	{
        weapon = "WEAPON_SPECIALCARBINE",
        label = "Special Carbine",
        price = 800000,
        can_buy_ammo = true,
        ammo_price = 10000,
        ammo_count = 80,
        allowed = true,
        upgrades = {

            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                price = 50000

            },

            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP_02",
                price = 200000

            },
			 
			

            {
                label = "Băng đạn mặc định",
                hash = "COMPONENT_SPECIALCARBINE_CLIP_01",
                price = 0

            },

            {
                label = "Băng đạn dài",
                hash = "COMPONENT_SPECIALCARBINE_CLIP_02",
                price = 1000000

			},
			
			{
                label = "Băng đạn loại 2",
                hash = "COMPONENT_SPECIALCARBINE_CLIP_03",
                price = 1000000

            },

            {
                label = "Scope",
                hash = "COMPONENT_AT_SCOPE_MEDIUM",
                price = 50000
			},   
			
			{
                label = "Grip",
                hash = "COMPONENT_AT_AR_AFGRIP",
                price = 300000
			},
			
			-- {
                -- label = "Etched Gun Metal Finish",
                -- hash = "COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER",
                -- price = 1000000
            -- }

        },

        tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 0

            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 50000

            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 1000000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 70000

            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 60000

            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 1000000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 1000000
            }

        }

    },

    {
        weapon = "WEAPON_CARBINERIFLE",
        label = "Carbine Rifle",
        price = 700000,
        can_buy_ammo = true,
        ammo_price = 10000,
        ammo_count = 80,
        allowed = true,
        upgrades = {

            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                price = 50000
            },
			
		
			
			
            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP",
                price = 300000
            },

            {
                label = "Tay cầm",
                hash = "COMPONENT_AT_AR_AFGRIP",
                price = 300000
            },

            {
                label = "Băng đạn mặc định",
                hash = "COMPONENT_CARBINERIFLE_CLIP_01",
                price = 0
            },

            {
                label = "Băng đạn dài",
                hash = "COMPONENT_CARBINERIFLE_CLIP_02",
                price = 400000

			},
			
			{
                label = "Băng đạn hộp",
                hash = "COMPONENT_CARBINERIFLE_CLIP_03",
                price = 400000

            },

            {
                label = "Scope",
                hash = "COMPONENT_AT_SCOPE_MEDIUM",
                price = 10000
			},
			
			-- {
                -- label = "Mạ vàng toàn bộ",
                -- hash = "COMPONENT_CARBINERIFLE_VARMOD_LUXE",
                -- price = 1000000

            -- }

        },

        tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 50000

            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 50000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 1000000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 70000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 60000
            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 1000000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 1000000
            }

        }

    },

    {
        weapon = "WEAPON_ADVANCEDRIFLE",
        label = "Advanced Rifle",
        price = 800000,
        can_buy_ammo = true,
        ammo_price = 5000,
        ammo_count = 80,
        allowed = true,
        upgrades = {
		
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                price = 50000
            },

            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP",
                price = 200000
            },
			
		

            {
                label = "Băng đạn mặc định",
                hash = "COMPONENT_ADVANCEDRIFLE_CLIP_01",
                price = 0
            },

            {
                label = "Băng đạn dài",
                hash = "COMPONENT_ADVANCEDRIFLE_CLIP_02",
                price = 500000
            },

            {
                label = "Scope",
                hash = "COMPONENT_AT_SCOPE_SMALL",
                price = 200000
			},    
			
			-- {
                -- label = "Gilded Gun Metal Finish",
                -- hash = "COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE",
                -- price = 1000000
            -- }

        },

        tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 0

            },

            {

                label = "Sơn vàng",
                index = 2,
                price = 1000000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 1000000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 70000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 1000000
            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 1000000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 1000000

            }

        }

	},
	
	{
        weapon = "WEAPON_BULLPUPRIFLE",
        label = "Bullpup Rifle",
        price = 800000,
        can_buy_ammo = true,
        ammo_price = 5000,
        ammo_count = 80,
        allowed = true,
        upgrades = {
		
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                price = 50000
            },

            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP",
                price = 200000
            },
			
		

            {
                label = "Băng đạn mặc định",
                hash = "COMPONENT_ADVANCEDRIFLE_CLIP_01",
                price = 0
            },

            {
                label = "Băng đạn dài",
                hash = "COMPONENT_ADVANCEDRIFLE_CLIP_02",
                price = 500000
            },

            {
                label = "Scope",
                hash = "COMPONENT_AT_SCOPE_SMALL",
                price = 200000
			},    

			{
                label = "Grip",
                hash = "COMPONENT_AT_AR_AFGRIP",
                price = 200000
			},
			
			-- {
                -- label = "Gilded Gun Metal Finish",
                -- hash = "COMPONENT_BULLPUPRIFLE_VARMOD_LOW",
                -- price = 1000000
            -- }

        },

        tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 0

            },

            {

                label = "Sơn vàng",
                index = 2,
                price = 1000000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 1000000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 70000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 1000000
            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 1000000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 1000000

            }

        }

    },
	
	
	{
        weapon = "WEAPON_COMPACTRIFLE",
        label = "COMPACT Rifle",
        price = 400000,
        can_buy_ammo = true,
        ammo_price = 5000,
        ammo_count = 80,
        allowed = false,
        upgrades = {
		
            {
                label = "Băng đạn mặc định",
                hash = "COMPONENT_COMPACTRIFLE_CLIP_01",
                price = 0
            },

            {
                label = "Băng đạn mở rộng",
                hash = "COMPONENT_COMPACTRIFLE_CLIP_02",
                price = 500000
            },
			
		

            {
                label = "Băng đạn 2",
                hash = "COMPONENT_COMPACTRIFLE_CLIP_03",
                price = 500000
            }
      

        },

        tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 0

            },

            {

                label = "Sơn vàng",
                index = 2,
                price = 1000000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 1000000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 1000000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 1000000
            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 1000000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 1000000

            }

        }

    },

    {
        weapon = "WEAPON_PISTOL_MK2",
        label = "Pistol MK2",
        price = 1000,
        can_buy_ammo = true,
        ammo_price = 500,
        ammo_count = 80,
        allowed = false,

        upgrades = {
		
            {
                label = "Băng Đạn Mặc Định",
                hash = "COMPONENT_PISTOL_MK2_CLIP_01",
                price = 0
            },

            {
                label = "Băng Đạn Nâng Cấp",
                hash = "COMPONENT_PISTOL_MK2_CLIP_02",
                price = 50000
            },
			
		

            {
                label = "Tracer Rounds (đạn nâng câp)",
                hash = "COMPONENT_PISTOL_MK2_CLIP_TRACER",
                price = 100000
            },

            {
                label = "Incendiary Rounds (Đạn cháy)",
                hash = "COMPONENT_PISTOL_MK2_CLIP_INCENDIARY",
                price = 150000
            },

            {
                label = "Hollow Point Rounds (đạn xuyên giáp)",
                hash = "COMPONENT_PISTOL_MK2_CLIP_HOLLOWPOINT",
                price = 150000
            },

            {
                label = "Full Metal Jacket Rounds (xuyên giáp xe)",
                hash = "COMPONENT_PISTOL_MK2_CLIP_FMJ",
                price = 150000
            },

            {
                label = "TMounted Scope",
                hash = "COMPONENT_AT_PI_RAIL",
                price = 50000
            },

            {
                label = "Flashlight	",
                hash = "COMPONENT_AT_PI_FLSH_02",
                price = 20000
            },

            {
                label = "Suppressor",
                hash = "COMPONENT_AT_PI_SUPP_02",
                price = 50000
            },

            {
                label = "Compensator",
                hash = "COMPONENT_AT_PI_COMP",
                price = 20000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_PISTOL_MK2_CAMO",
                price = 20000
            },

            {
                label = "Brushstroke Camo",
                hash = "COMPONENT_PISTOL_MK2_CAMO_02",
                price = 20000
            },

            {
                label = "Woodland Camo",
                hash = "COMPONENT_PISTOL_MK2_CAMO_03",
                price = 20000
            },

            {
                label = "Skull",
                hash = "COMPONENT_PISTOL_MK2_CAMO_04",
                price = 20000
            },

            {
                label = "Sessanta Nove",
                hash = "COMPONENT_PISTOL_MK2_CAMO_05",
                price = 20000
            },

            {
                label = "Perseus",
                hash = "COMPONENT_PISTOL_MK2_CAMO_06",
                price = 20000
            },

            {
                label = "Leopard",
                hash = "COMPONENT_PISTOL_MK2_CAMO_07",
                price = 20000
            },

            {
                label = "Zebra",
                hash = "COMPONENT_PISTOL_MK2_CAMO_08",
                price = 20000
            },

            {
                label = "Geometric",
                hash = "COMPONENT_PISTOL_MK2_CAMO_09",
                price = 20000
            },

            {
                label = "Boom!",
                hash = "COMPONENT_PISTOL_MK2_CAMO_10",
                price = 20000
            },

            {
                label = "Patriotic",
                hash = "COMPONENT_PISTOL_MK2_CAMO_IND_01",
                price = 20000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_PISTOL_MK2_CAMO_SLIDE",
                price = 20000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_PISTOL_MK2_CAMO_02_SLIDE",
                price = 20000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_PISTOL_MK2_CAMO_03_SLIDE",
                price = 20000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_PISTOL_MK2_CAMO_04_SLIDE",
                price = 20000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_PISTOL_MK2_CAMO_05_SLIDE",
                price = 20000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_PISTOL_MK2_CAMO_06_SLIDE",
                price = 20000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_PISTOL_MK2_CAMO_07_SLIDE",
                price = 20000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_PISTOL_MK2_CAMO_08_SLIDE",
                price = 20000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_PISTOL_MK2_CAMO_09_SLIDE",
                price = 20000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_PISTOL_MK2_CAMO_10_SLIDE",
                price = 20000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_PISTOL_MK2_CAMO_IND_01_SLIDE",
                price = 20000
            },


            
        },

        tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 0

            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 20000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 20000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 20000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 20000
            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 20000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 20000

            }

        }


    },

	{
        weapon = "weapon_snspistol_mk2",
        label = "SNS Pistol Mk II",
        price = 1000,
        can_buy_ammo = true,
        ammo_price = 1000,
        ammo_count = 80,
        allowed = false,

        upgrades = {

            {
                label = "Băng Đạn Mặc Định",
                hash = "COMPONENT_SNSPISTOL_MK2_CLIP_01",
                price = 0
            },

            {
                label = "Băng Đạn Dài",
                hash = "COMPONENT_SNSPISTOL_MK2_CLIP_02",
                price = 50000
            },

            {
                label = "Tracer Rounds ( đạn nâng câp )",
                hash = "COMPONENT_SNSPISTOL_MK2_CLIP_TRACER",
                price = 100000
            },

            {
                label = "Incendiary Rounds (Đạn cháy)",
                hash = "COMPONENT_SNSPISTOL_MK2_CLIP_INCENDIARY",
                price = 150000
            },

            {
                label = "Hollow Point Rounds (đạn xuyên giáp)",
                hash = "COMPONENT_SNSPISTOL_MK2_CLIP_HOLLOWPOINT",
                price = 150000
            },

            {
                label = "Full Metal Jacket Rounds (xuyên giáp xe)",
                hash = "COMPONENT_SNSPISTOL_MK2_CLIP_FMJ",
                price = 150000
            },

            {
                label = "Flashlight",
                hash = "COMPONENT_AT_PI_FLSH_03",
                price = 20000
            },

            {
                label = "Mounted Scope",
                hash = "COMPONENT_AT_PI_RAIL_02",
                price = 50000
            },

            {
                label = "Suppressor",
                hash = "COMPONENT_AT_PI_SUPP_02",
                price = 50000
            },

            {
                label = "Compensator",
                hash = "COMPONENT_AT_PI_COMP_02",
                price = 50000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO",
                price = 20000
            },

            {
                label = "Brushstroke Camo",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_02",
                price = 20000
            },

            {
                label = "Woodland Camo",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_03",
                price = 20000
            },

            {
                label = "Skull",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_04",
                price = 20000
            },

            {
                label = "Sessanta Nove",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_05",
                price = 20000
            },

            {
                label = "Perseus",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_06",
                price = 20000
            },

            {
                label = "Leopard",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_07",
                price = 20000
            },

            {
                label = "Zebra",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_08",
                price = 20000
            },

            {
                label = "Geometric",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_09",
                price = 20000
            },

            {
                label = "Boom!",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_10",
                price = 20000
            },

            {
                label = "Boom!",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_IND_01",
                price = 20000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_SLIDE",
                price = 20000
            },

            {
                label = "Brushstroke Camo",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_02_SLIDE",
                price = 20000
            },

            {
                label = "Woodland Camo",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_03_SLIDE",
                price = 20000
            },

            {
                label = "Skull",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_04_SLIDE",
                price = 20000
            },

            {
                label = "Sessanta Nove",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_05_SLIDE",
                price = 20000
            },

            {
                label = "Perseus",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_06_SLIDE",
                price = 20000
            },

            {
                label = "Leopard",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_07_SLIDE",
                price = 20000
            },

            {
                label = "Zebra",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_08_SLIDE",
                price = 20000
            },

            {
                label = "Geometric",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_09_SLIDE",
                price = 20000
            },

            {
                label = "Boom!",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_10_SLIDE",
                price = 20000
            },

            {
                label = "Patriotic",
                hash = "COMPONENT_SNSPISTOL_MK2_CAMO_IND_01_SLIDE",
                price = 20000
            },

        },

        tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 0

            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 20000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 20000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 20000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 20000
            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 20000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 20000

            }

        }


    },

    {
        weapon = "WEAPON_REVOLVER_MK2",
        label = "Heavy Revolver Mk II",
        price = 1000,
        can_buy_ammo = true,
        ammo_price = 200,
        ammo_count = 80,
        allowed = false,

        upgrades = {

            {
                label = "Băng Đạn Mặc Định",
                hash = "COMPONENT_REVOLVER_MK2_CLIP_01",
                price = 0
            },

            {
                label = "Tracer Rounds ( đạn nâng câp )",
                hash = "COMPONENT_REVOLVER_MK2_CLIP_TRACER",
                price = 70000
            },

            {
                label = "Incendiary Rounds (Đạn cháy)",
                hash = "COMPONENT_REVOLVER_MK2_CLIP_INCENDIARY",
                price = 200000
            },

            {
                label = "Hollow Point Rounds (đạn xuyên giáp)",
                hash = "COMPONENT_REVOLVER_MK2_CLIP_HOLLOWPOINT",
                price = 200000
            },

            {
                label = "Full Metal Jacket Rounds (xuyên giáp xe)",
                hash = "COMPONENT_REVOLVER_MK2_CLIP_FMJ",
                price = 200000
            },

            {
                label = "Holographic Sight",
                hash = "COMPONENT_AT_SIGHTS",
                price = 50000
            },

            {
                label = "Small Scope",
                hash = "COMPONENT_AT_SCOPE_MACRO_MK2",
                price = 50000
            },

            {
                label = "Flashlight",
                hash = "COMPONENT_AT_PI_FLSH",
                price = 10000
            },

            {
                label = "Compensator",
                hash = "COMPONENT_AT_PI_COMP_03",
                price = 70000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_REVOLVER_MK2_CAMO",
                price = 30000
            },

            {
                label = "Brushstroke Camo",
                hash = "COMPONENT_REVOLVER_MK2_CAMO_02",
                price = 30000
            },

            {
                label = "Woodland Camo",
                hash = "COMPONENT_REVOLVER_MK2_CAMO_03",
                price = 30000
            },

            {
                label = "Skull",
                hash = "COMPONENT_REVOLVER_MK2_CAMO_04",
                price = 30000
            },

            {
                label = "Sessanta Nove",
                hash = "COMPONENT_REVOLVER_MK2_CAMO_05",
                price = 30000
            },

            {
                label = "Perseus",
                hash = "COMPONENT_REVOLVER_MK2_CAMO_06",
                price = 30000
            },

            {
                label = "Leopard",
                hash = "COMPONENT_REVOLVER_MK2_CAMO_07",
                price = 30000
            },

            {
                label = "Zebra",
                hash = "COMPONENT_REVOLVER_MK2_CAMO_08",
                price = 30000
            },

            {
                label = "Geometric",
                hash = "COMPONENT_REVOLVER_MK2_CAMO_09",
                price = 30000
            },

            {
                label = "Boom!",
                hash = "COMPONENT_REVOLVER_MK2_CAMO_10",
                price = 30000
            },

            {
                label = "Patriotic",
                hash = "COMPONENT_REVOLVER_MK2_CAMO_IND_01",
                price = 30000
            }
		},
        tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 0
    
            },
    
            {
                label = "Sơn vàng",
                index = 2,
                price = 30000
            },
    
            {
                label = "Sơn hồng",
                index = 3,
                price = 30000
            },
    
            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 30000
            },
    
            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 30000
            },
    
            {
                label = "Sơn màu cam",
                index = 6,
                price = 30000
            },
    
            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 30000
    
            }
    
        }
	},

    {
        weapon = "WEAPON_SMG_MK2",
        label = "SMG Mk II",
        price = 300000,
        can_buy_ammo = true,
        ammo_price = 7000,
        ammo_count = 80,
        allowed = true,
    
        upgrades = {
    
            {
                label = "Băng Đạn Mặc Định",
                hash = "COMPONENT_SMG_MK2_CLIP_01",
                price = 0
            },

            {
                label = "Băng Đạn Dài",
                hash = "COMPONENT_SMG_MK2_CLIP_02",
                price = 100000
            },

            {
                label = "Tracer Rounds ( đạn nâng câp )",
                hash = "COMPONENT_SMG_MK2_CLIP_TRACER",
                price = 200000
            },

            {
                label = "Incendiary Rounds (Đạn cháy)",
                hash = "COMPONENT_SMG_MK2_CLIP_INCENDIARY",
                price = 300000
            },

            {
                label = "Hollow Point Rounds (đạn xuyên giáp)",
                hash = "COMPONENT_SMG_MK2_CLIP_HOLLOWPOINT",
                price = 300000
            },

            {
                label = "Full Metal Jacket Rounds (xuyên giáp xe)",
                hash = "COMPONENT_SMG_MK2_CLIP_FMJ",
                price = 300000
            },

            {
                label = "Flashlight",
                hash = "COMPONENT_AT_AR_FLSH",
                price = 20000
            },

            {
                label = "Holographic Sight",
                hash = "COMPONENT_AT_SIGHTS_SMG",
                price = 50000
            },

            {
                label = "Small Scope",
                hash = "COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2",
                price = 50000
            },

            {
                label = "Medium Scope",
                hash = "COMPONENT_AT_SCOPE_SMALL_SMG_MK2",
                price = 50000
            },

            {
                label = "Suppressor",
                hash = "COMPONENT_AT_PI_SUPP",
                price = 50000
            },

            {
                label = "Flat Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_01",
                price = 50000
            },

            {
                label = "Tactical Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_02",
                price = 50000
            },

            {
                label = "Fat-End Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_03",
                price = 50000
            },

            {
                label = "Precision Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_04",
                price = 50000
            },

            {
                label = "Heavy Duty Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_05",
                price = 50000
            },

            {
                label = "Slanted Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_06",
                price = 50000
            },

            {
                label = "Split-End Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_07",
                price = 50000
            },

            {
                label = "Default Barrel",
                hash = "COMPONENT_AT_SB_BARREL_01",
                price = 50000
            },

            {
                label = "Heavy Barrel",
                hash = "COMPONENT_AT_SB_BARREL_02",
                price = 50000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_SMG_MK2_CAMO",
                price = 50000
            },

            {
                label = "Brushstroke Camo",
                hash = "COMPONENT_SMG_MK2_CAMO_02",
                price = 50000
            },

            {
                label = "Woodland Camo",
                hash = "COMPONENT_SMG_MK2_CAMO_03",
                price = 50000
            },

            {
                label = "Skull",
                hash = "COMPONENT_SMG_MK2_CAMO_04",
                price = 50000
            },

            {
                label = "Sessanta Nove",
                hash = "COMPONENT_SMG_MK2_CAMO_05",
                price = 50000
            },

            {
                label = "Perseus",
                hash = "COMPONENT_SMG_MK2_CAMO_06",
                price = 50000
            },

            {
                label = "Leopard",
                hash = "COMPONENT_SMG_MK2_CAMO_07",
                price = 50000
            },

			
			{
				label = "Zebra",
				hash = "COMPONENT_SMG_MK2_CAMO_08",
				price = 50000
            },
            
            {
                label = "Geometric",
                hash = "COMPONENT_SMG_MK2_CAMO_09",
                price = 50000
            },

            {
                label = "Boom!",
                hash = "COMPONENT_SMG_MK2_CAMO_10",
                price = 50000
            },

                {
                    label = "Patriotic",
                    hash = "COMPONENT_SMG_MK2_CAMO_IND_01",
                    price = 50000
                }
			},

            tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 0
            },
        
            {
                label = "Sơn vàng",
                index = 2,
                price = 50000
            },
        
            {
                label = "Sơn hồng",
                index = 3,
                price = 50000
            },
        
            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 50000
            },
        
            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 50000
            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 50000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 50000

            }

        }
        
        
        },

    {
        weapon = "WEAPON_PUMPSHOTGUN_MK2",
        label = "Pump Shotgun Mk II",
        price = 1000,
        can_buy_ammo = true,
        ammo_price = 200,
        ammo_count = 80,
        allowed = false,

        upgrades = {

            {
                label = "Default Shells",
                hash = "COMPONENT_PUMPSHOTGUN_MK2_CLIP_01",
                price = 0
            },

            {
                label = "Dragon's Breath Shells",
                hash = "COMPONENT_PUMPSHOTGUN_MK2_CLIP_INCENDIARY",
                price = 200000
            },

            {
                label = "Steel Buckshot Shells",
                hash = "COMPONENT_PUMPSHOTGUN_MK2_CLIP_ARMORPIERCING",
                price = 100000
            },

            {
                label = "Flechette Shells",
                hash = "COMPONENT_PUMPSHOTGUN_MK2_CLIP_HOLLOWPOINT",
                price = 200000
            },

            {
                label = "Explosive Slugs",
                hash = "COMPONENT_PUMPSHOTGUN_MK2_CLIP_EXPLOSIVE",
                price = 200000
            },

            {
                label = "Holographic Sight",
                hash = "COMPONENT_AT_SIGHTS",
                price = 50000
            },

            {
                label = "Small Scope",
                hash = "COMPONENT_AT_SCOPE_MACRO_MK2",
                price = 50000
            },

            {
                label = "Medium Scope",
                hash = "COMPONENT_AT_SCOPE_SMALL_MK2",
                price = 50000
            },

            {
                label = "Flashlight",
                hash = "COMPONENT_AT_AR_FLSH",
                price = 50000
            },

            {
                label = "Suppressor",
                hash = "COMPONENT_AT_SR_SUPP_03",
                price = 50000
            },

            {
                label = "Squared Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_08",
                price = 50000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_PUMPSHOTGUN_MK2_CAMO",
                price = 50000
            },

            {
                label = "Brushstroke Camo",
                hash = "COMPONENT_PUMPSHOTGUN_MK2_CAMO_02",
                price = 50000
            },

            {
                label = "Woodland Camo",
                hash = "COMPONENT_PUMPSHOTGUN_MK2_CAMO_03",
                price = 50000
            },

            {
                label = "Skull",
                hash = "COMPONENT_PUMPSHOTGUN_MK2_CAMO_04",
                price = 50000
            },

            {
                label = "Sessanta Nove",
                hash = "COMPONENT_PUMPSHOTGUN_MK2_CAMO_05",
                price = 50000
            },

            {
                label = "Perseus",
                hash = "COMPONENT_PUMPSHOTGUN_MK2_CAMO_06",
                price = 50000
            },

            {
                label = "Leopard",
                hash = "COMPONENT_PUMPSHOTGUN_MK2_CAMO_07",
                price = 50000
            },

            {
                label = "Zebra",
                hash = "COMPONENT_PUMPSHOTGUN_MK2_CAMO_08",
                price = 50000
            },

            {
                label = "Geometric",
                hash = "COMPONENT_PUMPSHOTGUN_MK2_CAMO_09",
                price = 50000
            },

            {
                label = "Boom!",
                hash = "COMPONENT_PUMPSHOTGUN_MK2_CAMO_10",
                price = 50000
            },

            {
                label = "Patriotic",
                hash = "COMPONENT_PUMPSHOTGUN_MK2_CAMO_IND_01",
                price = 50000
            }
        },	

        tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 0

            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 100000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 100000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 100000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 100000
            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 100000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 100000

            }

        }


    },

    {
        weapon = "WEAPON_ASSAULTRIFLE_MK2",
        label = "Assault Rifle Mk II",
        price = 3000000,
        can_buy_ammo = true,
        ammo_price = 20000,
        ammo_count = 80,
        allowed = true,

        upgrades = {
            
            {
                label = "Băng Đạn Mặc Định",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CLIP_01",
                price = 0
            },

            {
                label = "Băng Đạn Dài",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CLIP_02",
                price = 200000
            },

            {
                label = "Tracer Rounds ( đạn nâng câp )",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CLIP_TRACER",
                price = 300000
            },

            {
                label = "Incendiary Rounds (Đạn cháy)",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CLIP_INCENDIARY",
                price = 500000
            },

            {
                label = "Armor Piercing Rounds",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CLIP_ARMORPIERCING",
                price = 500000
            },

            {
                label = "Full Metal Jacket Rounds (xuyên giáp xe)",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CLIP_FMJ",
                price = 500000
            },

            {
                label = "Grip",
                hash = "COMPONENT_AT_AR_AFGRIP_02",
                price = 100000
            },

            {
                label = "Flashlight",
                hash = "COMPONENT_AT_AR_FLSH",
                price = 100000
            },

            {
                label = "Holographic Sight",
                hash = "COMPONENT_AT_SIGHTS",
                price = 100000
            },

            {
                label = "Small Scope",
                hash = "COMPONENT_AT_SCOPE_MACRO_MK2",
                price = 100000
            },

            {
                label = "Large Scope",
                hash = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
                price = 10000
            },

            {
                label = "Suppressor",
                hash = "COMPONENT_AT_AR_SUPP_02",
                price = 100000
            },

            {
                label = "Flat Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_01",
                price = 200000
            },

            {
                label = "Tactical Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_02",
                price = 200000
            },

            {
                label = "Fat-End Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_03",
                price = 200000
            },

            {
                label = "Precision Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_04",
                price = 200000
            },

            {
                label = "Heavy Duty Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_05",
                price = 200000
            },

            {
                label = "Slanted Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_06",
                price = 200000
            },

            {
                label = "Split-End Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_07",
                price = 200000
            },

            {
                label = "Default Barrel",
                hash = "COMPONENT_AT_AR_BARREL_01",
                price = 200000
            },

            {
                label = "Heavy BarreL",
                hash = "COMPONENT_AT_AR_BARREL_02",
                price = 200000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CAMO",
                price = 200000
            },

            {
                label = "Brushstroke Camo",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_02",
                price = 200000
            },

            {
                label = "Woodland Camo",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_03",
                price = 200000
            },

            {
                label = "Skull",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_04",
                price = 200000
            },

            {
                label = "Sessanta Nove",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_05",
                price = 200000
            },

            {
                label = "Perseus",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_06",
                price = 200000
            },

            {
                label = "Leopard",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_07",
                price = 200000
            },

            {
                label = "Zebra",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_08",
                price = 200000
            },

            {
                label = "Geometric",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_09",
                price = 200000
            },

            {
                label = "Boom!",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_10",
                price = 200000
            },

            {
                label = "Patriotic",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_IND_01",
                price = 200000
            }
        },	

        tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 0

            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 700000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 700000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 700000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 700000
            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 700000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 700000

            }

        }


    },

    {
        weapon = "WEAPON_CARBINERIFLE_MK2",
        label = "Carbine Rifle Mk II",
        price = 1000,
        can_buy_ammo = true,
        ammo_price = 200,
        ammo_count = 80,
        allowed = false,

        upgrades = {

            {
                label = "Băng Đạn Mặc Định",
                hash = "COMPONENT_CARBINERIFLE_MK2_CLIP_01",
                price = 0
            },

            {
                label = "Băng Đạn Dài",
                hash = "COMPONENT_CARBINERIFLE_MK2_CLIP_02",
                price = 150000
            },

            {
                label = "Tracer Rounds ( đạn nâng câp )",
                hash = "COMPONENT_CARBINERIFLE_MK2_CLIP_TRACER",
                price = 250000
            },

            {
                label = "Incendiary Rounds (Đạn cháy)",
                hash = "COMPONENT_CARBINERIFLE_MK2_CLIP_INCENDIARY",
                price = 300000
            },

            {
                label = "Armor Piercing Rounds",
                hash = "COMPONENT_CARBINERIFLE_MK2_CLIP_ARMORPIERCING",
                price = 350000
            },

            {
                label = "Full Metal Jacket Rounds (xuyên giáp xe)",
                hash = "COMPONENT_CARBINERIFLE_MK2_CLIP_FMJ",
                price = 400000
            },

            {
                label = "Grip",
                hash = "COMPONENT_AT_AR_AFGRIP_02",
                price = 100000
            },

            {
                label = "Băng Đạn Mặc Định",
                hash = "COMPONENT_ASSAULTRIFLE_MK2_CLIP_01",
                price = 150000
            },

            {
                label = "Flashlight",
                hash = "COMPONENT_AT_AR_FLSH",
                price = 100000
            },

            {
                label = "Holographic Sight",
                hash = "COMPONENT_AT_SIGHTS",
                price = 10000
            },

            {
                label = "Small Scope",
                hash = "COMPONENT_AT_SCOPE_MACRO_MK2",
                price = 10000
            },

            {
                label = "Large Scope",
                hash = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
                price = 10000
            },

            {
                label = "Suppressor",
                hash = "COMPONENT_AT_AR_SUPP",
                price = 100000
            },

            {
                label = "Flat Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_01",
                price = 200000
            },

            {
                label = "Tactical Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_02",
                price = 200000
            },

            {
                label = "Fat-End Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_03",
                price = 200000
            },

            {
                label = "Precision Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_04",
                price = 200000
            },

            {
                label = "Heavy Duty Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_05",
                price = 200000
            },

            {
                label = "Slanted Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_06",
                price = 200000
            },

            {
                label = "Split-End Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_07",
                price = 200000
            },

            {
                label = "Default Barrel",
                hash = "COMPONENT_AT_CR_BARREL_01",
                price = 200000
            },

            {
                label = "Heavy Barrel",
                hash = "COMPONENT_AT_CR_BARREL_02",
                price = 200000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_CARBINERIFLE_MK2_CAMO",
                price = 200000
            },

            {
                label = "Brushstroke Camo",
                hash = "COMPONENT_CARBINERIFLE_MK2_CAMO_02",
                price = 200000
            },

            {
                label = "Woodland Camo",
                hash = "COMPONENT_CARBINERIFLE_MK2_CAMO_03",
                price = 200000
            },

            {
                label = "Skull",
                hash = "COMPONENT_CARBINERIFLE_MK2_CAMO_04",
                price = 200000
            },

            {
                label = "Sessanta Nove",
                hash = "COMPONENT_CARBINERIFLE_MK2_CAMO_05",
                price = 200000
            },

            {
                label = "Perseus",
                hash = "COMPONENT_CARBINERIFLE_MK2_CAMO_06",
                price = 200000
            },

            {
                label = "Leopard",
                hash = "COMPONENT_CARBINERIFLE_MK2_CAMO_07",
                price = 200000
            },

            {
                label = "Zebra",
                hash = "COMPONENT_CARBINERIFLE_MK2_CAMO_08",
                price = 200000
            },

            {
                label = "Geometric",
                hash = "COMPONENT_CARBINERIFLE_MK2_CAMO_09",
                price = 200000
            },

            {
                label = "Boom!",
                hash = "COMPONENT_CARBINERIFLE_MK2_CAMO_10",
                price = 200000
            },

            {
                label = "Patriotic",
                hash = "COMPONENT_CARBINERIFLE_MK2_CAMO_IND_01",
                price = 200000
            }	
        },			

    tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 0

            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 500000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 500000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 500000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 500000
            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 500000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 500000

            }

        }


    },

    {
        weapon = "WEAPON_SPECIALCARBINE_MK2",
        label = "Special Carbine Mk II",
        price = 1000,
        can_buy_ammo = true,
        ammo_price = 200,
        ammo_count = 80,
        allowed = false,

        upgrades = {

            {
                label = "Băng Đạn Mặc Định",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CLIP_01",
                price = 0
            },

            {
                label = "Băng Đạn Dài",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CLIP_02",
                price = 100000
            },

            {
                label = "Tracer Rounds ( đạn nâng câp )",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CLIP_TRACER",
                price = 250000
            },

            {
                label = "Incendiary Rounds (Đạn cháy)",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CLIP_INCENDIARY",
                price = 300000
            },

            {
                label = "Armor Piercing Rounds",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CLIP_ARMORPIERCING",
                price = 350000
            },

            {
                label = "Full Metal Jacket Rounds (xuyên giáp xe)",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CLIP_FMJ",
                price = 400000
            },

            {
                label = "Flashlight",
                hash = "COMPONENT_AT_AR_FLSH",
                price = 10000
            },

            {
                label = "Holographic Sight",
                hash = "COMPONENT_AT_SIGHTS",
                price = 10000
            },

            {
                label = "Small Scope",
                hash = "COMPONENT_AT_SCOPE_MACRO_MK2",
                price = 10000
            },

            {
                label = "Large Scope",
                hash = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
                price = 10000
            },

            {
                label = "Suppressor",
                hash = "COMPONENT_AT_AR_SUPP_02",
                price = 100000
            },

            {
                label = "Flat Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_01",
                price = 200000
            },

            {
                label = "Tactical Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_02",
                price = 200000
            },

            {
                label = "Fat-End Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_03",
                price = 200000
            },

            {
                label = "Precision Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_04",
                price = 200000
            },

            {
                label = "Heavy Duty Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_05",
                price = 200000
            },

            {
                label = "Slanted Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_06",
                price = 200000
            },

            {
                label = "Split-End Muzzle Brake",
                hash = "COMPONENT_AT_MUZZLE_07",
                price = 200000
            },

            {
                label = "Grip",
                hash = "COMPONENT_AT_AR_AFGRIP_02",
                price = 100000
            },

            {
                label = "Default Barrel",
                hash = "COMPONENT_AT_SC_BARREL_01",
                price = 200000
            },

            {
                label = "Heavy Barrel",
                hash = "COMPONENT_AT_SC_BARREL_02",
                price = 200000
            },

            {
                label = "Digital Camo",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CAMO",
                price = 200000
            },

            {
                label = "Brushstroke Camo",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CAMO_02",
                price = 200000
            },

            {
                label = "Woodland Camo",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CAMO_03",
                price = 200000
            },

            {
                label = "Skull",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CAMO_04",
                price = 200000
            },

            {
                label = "Sessanta Nove",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CAMO_05",
                price = 200000
            },

            {
                label = "Perseus",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CAMO_06",
                price = 200000
            },

            {
                label = "Leopard",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CAMO_07",
                price = 200000
            },

            {
                label = "Zebra",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CAMO_08",
                price = 200000
            },

            {
                label = "Geometric",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CAMO_09",
                price = 200000
            },

            {
                label = "Boom!",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CAMO_10",
                price = 200000
            },

            {
                label = "Patriotic",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CAMO_IND_01",
                price = 200000
            }
        },

    tints = {

            {
                label = "Sơn mặc định",
                index = 0,
                price = 0

            },

            {
                label = "Sơn vàng",
                index = 2,
                price = 500000
            },

            {
                label = "Sơn hồng",
                index = 3,
                price = 500000
            },

            {
                label = "Sơn màu quân đội",
                index = 4,
                price = 500000
            },

            {
                label = "Sơn màu cảnh sát",
                index = 5,
                price = 500000
            },

            {
                label = "Sơn màu cam",
                index = 6,
                price = 500000
            },

            {
                label = "Sơn màu bạch kim",
                index = 7,
                price = 500000

            }

        }


        },

        {
            weapon = "WEAPON_BULLPUPRIFLE_MK2",
            label = "Bullpup Rifle Mk II",
            price = 1000,
            can_buy_ammo = true,
            ammo_price = 200,
            ammo_count = 80,
            allowed = false,
    
            upgrades = {
    
                {
                    label = "Băng Đạn Mặc Định",
                    hash = "COMPONENT_BULLPUPRIFLE_MK2_CLIP_01",
                    price = 0
                },

                {
                    label = "Băng Đạn Dài",
                    hash = "COMPONENT_BULLPUPRIFLE_MK2_CLIP_02",
                    price = 100000
                },

                {
                    label = "Tracer Rounds ( đạn nâng câp )",
                    hash = "COMPONENT_BULLPUPRIFLE_MK2_CLIP_TRACER",
                    price = 250000
                },

                {
                    label = "Incendiary Rounds (Đạn cháy)",
                    hash = "COMPONENT_BULLPUPRIFLE_MK2_CLIP_INCENDIARY",
                    price = 300000
                },

                {
                    label = "Armor Piercing Rounds",
                    hash = "COMPONENT_BULLPUPRIFLE_MK2_CLIP_ARMORPIERCING",
                    price = 350000
                },

                {
                    label = "Full Metal Jacket Rounds (xuyên giáp xe)",
                    hash = "COMPONENT_BULLPUPRIFLE_MK2_CLIP_FMJ",
                    price = 400000
                },

                {
                    label = "Flashlight",
                    hash = "COMPONENT_AT_AR_FLSH",
                    price = 10000
                },

                {
                    label = "Holographic Sight",
                    hash = "COMPONENT_AT_SIGHTS",
                    price = 10000
                },

                {
                    label = "Small Scope",
                    hash = "COMPONENT_AT_SCOPE_MACRO_02_MK2",
                    price = 10000
                },

                {
                    label = "Medium Scope",
                    hash = "COMPONENT_AT_SCOPE_SMALL_MK2",
                    price = 10000
                },

                {
                    label = "Default Barrel",
                    hash = "COMPONENT_AT_BP_BARREL_01",
                    price = 100000
                },

                {
                    label = "Heavy Barrel",
                    hash = "COMPONENT_AT_BP_BARREL_02",
                    price = 100000
                },

                {
                    label = "Suppressor",
                    hash = "COMPONENT_AT_AR_SUPP",
                    price = 100000
                },

                {
                    label = "Flat Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_01",
                    price = 200000
                },

                {
                    label = "Tactical Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_02",
                    price = 200000
                },

                {
                    label = "Fat-End Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_03",
                    price = 200000
                },

                {
                    label = "Precision Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_04",
                    price = 200000
                },

                {
                    label = "Heavy Duty Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_05",
                    price = 200000
                },

                {
                    label = "Slanted Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_06",
                    price = 200000
                },

                {
                    label = "Split-End Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_07",
                    price = 200000
                },

                {
                    label = "Grip",
                    hash = "COMPONENT_AT_AR_AFGRIP_02",
                    price = 200000
                },

                {
                    label = "Digital Camo",
                    hash = "COMPONENT_BULLPUPRIFLE_MK2_CAMO",
                    price = 200000
                },

                {
                    label = "Brushstroke Camo",
                    hash = "COMPONENT_BULLPUPRIFLE_MK2_CAMO_02",
                    price = 200000
                },

                {
                    label = "Woodland Camo",
                    hash = "COMPONENT_BULLPUPRIFLE_MK2_CAMO_03",
                    price = 200000
                },

                {
                    label = "Skull",
                    hash = "COMPONENT_BULLPUPRIFLE_MK2_CAMO_04",
                    price = 200000
                },

                {
                    label = "Sessanta Nove",
                    hash = "COMPONENT_BULLPUPRIFLE_MK2_CAMO_05",
                    price = 200000
                },

                {
                    label = "Perseus",
                    hash = "COMPONENT_BULLPUPRIFLE_MK2_CAMO_06",
                    price = 200000
                },

                {
                    label = "Leopard",
                    hash = "COMPONENT_BULLPUPRIFLE_MK2_CAMO_07",
                    price = 200000
                },

                {
                    label = "Zebra",
                    hash = "COMPONENT_BULLPUPRIFLE_MK2_CAMO_08",
                    price = 200000
                },

                {
                    label = "Geometric",
                    hash = "COMPONENT_BULLPUPRIFLE_MK2_CAMO_09",
                    price = 200000
                },

                {
                    label = "Boom!",
                    hash = "COMPONENT_BULLPUPRIFLE_MK2_CAMO_10",
                    price = 200000
                },

                {
                    label = "Patriotic",
                    hash = "COMPONENT_BULLPUPRIFLE_MK2_CAMO_IND_01",
                    price = 200000
                }
            },	

    tints = {

                {
                    label = "Sơn mặc định",
                    index = 0,
                    price = 0
    
                },
    
                {
                    label = "Sơn vàng",
                    index = 2,
                    price = 500000
				
				},
                {
                    label = "Sơn hồng",
                    index = 3,
                    price = 500000
                },
    
                {
                    label = "Sơn màu quân đội",
                    index = 4,
                    price = 500000
                },
    
                {
                    label = "Sơn màu cảnh sát",
                    index = 5,
                    price = 500000
                },
    
                {
                    label = "Sơn màu cam",
                    index = 6,
                    price = 500000
                },
    
                {
                    label = "Sơn màu bạch kim",
                    index = 7,
                    price = 500000
    
                }
    
            }
    
    
        },

        {
            weapon = "WEAPON_COMBATMG_MK2",
            label = "Combat MG Mk II",
            price = 1000,
            can_buy_ammo = true,
            ammo_price = 200,
            ammo_count = 80,
            allowed = false,
    
            upgrades = {
    
                {
                    label = "Băng Đạn Mặc Định",
                    hash = "COMPONENT_COMBATMG_MK2_CLIP_01",
                    price = 0
                },

                {
                    label = "Băng Đạn Dài",
                    hash = "COMPONENT_COMBATMG_MK2_CLIP_02",
                    price = 100000
                },

                {
                    label = "Tracer Rounds ( đạn nâng câp )",
                    hash = "COMPONENT_COMBATMG_MK2_CLIP_TRACER",
                    price = 250000
                },

                {
                    label = "Incendiary Rounds (Đạn cháy)",
                    hash = "COMPONENT_COMBATMG_MK2_CLIP_INCENDIARY",
                    price = 300000
                },

                {
                    label = "Armor Piercing Rounds",
                    hash = "COMPONENT_COMBATMG_MK2_CLIP_ARMORPIERCING",
                    price = 350000
                },

                {
                    label = "Full Metal Jacket Rounds (xuyên giáp xe)",
                    hash = "COMPONENT_COMBATMG_MK2_CLIP_FMJ",
                    price = 400000
                },

                {
                    label = "Grip",
                    hash = "COMPONENT_AT_AR_AFGRIP_02",
                    price = 200000
                },

                {
                    label = "Holographic Sight",
                    hash = "COMPONENT_AT_SIGHTS",
                    price = 200000
                },

                {
                    label = "Medium Scope",
                    hash = "COMPONENT_AT_SCOPE_SMALL_MK2",
                    price = 200000
                },

                {
                    label = "Large Scope",
                    hash = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
                    price = 200000
                },

                {
                    label = "Flat Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_01",
                    price = 200000
                },

                {
                    label = "Tactical Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_02",
                    price = 200000
                },

                {
                    label = "Fat-End Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_03",
                    price = 200000
                },

                {
                    label = "Precision Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_04",
                    price = 200000
                },

                {
                    label = "Heavy Duty Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_05",
                    price = 200000
                },

                {
                    label = "Slanted Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_06",
                    price = 200000
                },

                {
                    label = "Split-End Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_07",
                    price = 200000
                },

                {
                    label = "Default Barrel",
                    hash = "COMPONENT_AT_MG_BARREL_01",
                    price = 200000
                },

                {
                    label = "Heavy Barrel",
                    hash = "COMPONENT_AT_MG_BARREL_02",
                    price = 200000
                },

                {
                    label = "Digital Camo",
                    hash = "COMPONENT_COMBATMG_MK2_CAMO",
                    price = 200000
                },

                {
                    label = "Brushstroke Camo",
                    hash = "COMPONENT_COMBATMG_MK2_CAMO_02",
                    price = 200000
                },

                {
                    label = "Woodland Camo",
                    hash = "COMPONENT_COMBATMG_MK2_CAMO_03",
                    price = 200000
                },

                {
                    label = "Skull",
                    hash = "COMPONENT_COMBATMG_MK2_CAMO_04",
                    price = 200000
                },

                {
                    label = "Sessanta Nove",
                    hash = "COMPONENT_COMBATMG_MK2_CAMO_05",
                    price = 200000
                },

                {
                    label = "Perseus",
                    hash = "COMPONENT_COMBATMG_MK2_CAMO_06",
                    price = 200000
                },

                {
                    label = "Leopard",
                    hash = "COMPONENT_COMBATMG_MK2_CAMO_07",
                    price = 200000
                },

                {
                    label = "Zebra",
                    hash = "COMPONENT_COMBATMG_MK2_CAMO_08",
                    price = 200000
                },

                {
                    label = "Geometric",
                    hash = "COMPONENT_COMBATMG_MK2_CAMO_09",
                    price = 200000
                },

                {
                    label = "Boom!",
                    hash = "COMPONENT_COMBATMG_MK2_CAMO_10",
                    price = 200000
                },

                {
                    label = "Patriotic",
                    hash = "COMPONENT_COMBATMG_MK2_CAMO_IND_01",
                    price = 200000
                }
            },		

        tints = {

                {
                    label = "Sơn mặc định",
                    index = 0,
                    price = 0
    
                },
    
                {
                    label = "Sơn vàng",
                    index = 2,
                    price = 500000
                },
    
                {
                    label = "Sơn hồng",
                    index = 3,
                    price = 500000
                },
    
                {
                    label = "Sơn màu quân đội",
                    index = 4,
                    price = 500000
                },
    
                {
                    label = "Sơn màu cảnh sát",
                    index = 5,
                    price = 500000
                },
    
                {
                    label = "Sơn màu cam",
                    index = 6,
                    price = 500000
                },
    
                {
                    label = "Sơn màu bạch kim",
                    index = 7,
                    price = 500000
    
                }
    
            }
    
    
        },


        {
            weapon = "WEAPON_HEAVYSNIPER_MK2",
            label = "Heavy Sniper Mk II",
            price = 1000,
            can_buy_ammo = true,
            ammo_price = 200,
            ammo_count = 80,
            allowed = false,
    
            upgrades = {
    
                {
                    label = "Băng Đạn Mặc Định",
                    hash = "COMPONENT_HEAVYSNIPER_MK2_CLIP_01",
                    price = 0
                },

                {
                    label = "Băng Đạn Dài",
                    hash = "COMPONENT_HEAVYSNIPER_MK2_CLIP_02",
                    price = 600000
                },


                {
                    label = "Incendiary Rounds (Đạn cháy)",
                    hash = "COMPONENT_HEAVYSNIPER_MK2_CLIP_INCENDIARY",
                    price = 800000
                },


                {
                    label = "Armor Piercing Rounds",
                    hash = "COMPONENT_HEAVYSNIPER_MK2_CLIP_ARMORPIERCING",
                    price = 1000000
                },


                {
                    label = "Full Metal Jacket Rounds (xuyên giáp xe)",
                    hash = "COMPONENT_HEAVYSNIPER_MK2_CLIP_FMJ",
                    price = 1300000
                },


                {
                    label = "Explosive Rounds",
                    hash = "COMPONENT_HEAVYSNIPER_MK2_CLIP_EXPLOSIVE",
                    price = 500000
                },


                {
                    label = "Zoom Scope",
                    hash = "COMPONENT_AT_SCOPE_LARGE_MK2",
                    price = 500000
                },


                {
                    label = "Advanced Scope",
                    hash = "COMPONENT_AT_SCOPE_MAX",
                    price = 500000
                },


                {
                    label = "Night Vision Scope",
                    hash = "COMPONENT_AT_SCOPE_NV",
                    price = 500000
                },


                {
                    label = "Thermal Scope",
                    hash = "COMPONENT_AT_SCOPE_THERMAL",
                    price = 500000
                },


                {
                    label = "Suppressor",
                    hash = "COMPONENT_AT_SR_SUPP_03",
                    price = 500000
                },


                {
                    label = "Squared Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_08",
                    price = 500000
                },


                {
                    label = "Bell-End Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_09",
                    price = 500000
                },


                {
                    label = "Default Barrel",
                    hash = "COMPONENT_AT_SR_BARREL_01",
                    price = 500000
                },


                {
                    label = "Heavy Barrel",
                    hash = "COMPONENT_AT_SR_BARREL_02",
                    price = 500000
                },


                {
                    label = "Digital Camo",
                    hash = "COMPONENT_HEAVYSNIPER_MK2_CAMO",
                    price = 500000
                },


                {
                    label = "Brushstroke Camo",
                    hash = "COMPONENT_HEAVYSNIPER_MK2_CAMO_02",
                    price = 500000
                },


                {
                    label = "Woodland Camo",
                    hash = "COMPONENT_HEAVYSNIPER_MK2_CAMO_03",
                    price = 500000
                },


                {
                    label = "Skull",
                    hash = "COMPONENT_HEAVYSNIPER_MK2_CAMO_04",
                    price = 500000
                },


                {
                    label = "Sessanta Nove",
                    hash = "COMPONENT_HEAVYSNIPER_MK2_CAMO_05",
                    price = 500000
                },


                {
                    label = "Perseus",
                    hash = "COMPONENT_HEAVYSNIPER_MK2_CAMO_06",
                    price = 500000
                },


                {
                    label = "Leopard",
                    hash = "COMPONENT_HEAVYSNIPER_MK2_CAMO_07",
                    price = 500000
                },


                {
                    label = "Zebra",
                    hash = "COMPONENT_HEAVYSNIPER_MK2_CAMO_08",
                    price = 500000
                },


                {
                    label = "Geometric",
                    hash = "COMPONENT_HEAVYSNIPER_MK2_CAMO_09",
                    price = 500000
                },


                {
                    label = "Boom!",
                    hash = "COMPONENT_HEAVYSNIPER_MK2_CAMO_10",
                    price = 500000
                },


                {
                    label = "Patriotic",
                    hash = "COMPONENT_HEAVYSNIPER_MK2_CAMO_IND_01",
                    price = 500000
                }
            },	

    tints = {

                {
                    label = "Sơn mặc định",
                    index = 0,
                    price = 0
    
                },
    
                {
                    label = "Sơn vàng",
                    index = 2,
                    price = 700000
                },
    
                {
                    label = "Sơn hồng",
                    index = 3,
                    price = 700000
                },
    
                {
                    label = "Sơn màu quân đội",
                    index = 4,
                    price = 700000
                },
    
                {
                    label = "Sơn màu cảnh sát",
                    index = 5,
                    price = 700000
                },
    
                {
                    label = "Sơn màu cam",
                    index = 6,
                    price = 700000
                },
    
                {
                    label = "Sơn màu bạch kim",
                    index = 7,
                    price = 700000
    
                }
    
            }
    
    
    },

        {
            weapon = "WEAPON_MARKSMANRIFLE_MK2",
            label = "Marksman Rifle Mk II",
            price = 1000,
            can_buy_ammo = true,
            ammo_price = 200,
            ammo_count = 80,
            allowed = false,
    
            upgrades = {
    
                {
                    label = "Băng Đạn Mặc Định",
                    hash = "COMPONENT_MARKSMANRIFLE_MK2_CLIP_01",
                    price = 0
                },

                {
                    label = "Băng Đạn Dài",
                    hash = "COMPONENT_MARKSMANRIFLE_MK2_CLIP_02",
                    price = 600000
                },

                {
                    label = "Tracer Rounds ( đạn nâng câp )",
                    hash = "COMPONENT_MARKSMANRIFLE_MK2_CLIP_TRACER",
                    price = 800000
                },

                {
                    label = "Incendiary Rounds (Đạn cháy)",
                    hash = "COMPONENT_MARKSMANRIFLE_MK2_CLIP_INCENDIARY",
                    price = 10000000
                },

                {
                    label = "Armor Piercing Rounds",
                    hash = "COMPONENT_MARKSMANRIFLE_MK2_CLIP_ARMORPIERCING",
                    price = 11000000
                },

                {
                    label = "Full Metal Jacket Rounds (xuyên giáp xe)",
                    hash = "COMPONENT_MARKSMANRIFLE_MK2_CLIP_FMJ",
                    price = 1300000
                },

                {
                    label = "Holographic Sight",
                    hash = "COMPONENT_AT_SIGHTS",
                    price = 300000
                },

                {
                    label = "Large Scope",
                    hash = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
                    price = 300000
                },

                {
                    label = "Zoom Scope",
                    hash = "COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM_MK2",
                    price = 300000
                },

                {
                    label = "Flashlight",
                    hash = "COMPONENT_AT_AR_FLSH",
                    price = 100000
                },

                {
                    label = "Suppressor",
                    hash = "COMPONENT_AT_AR_SUPP",
                    price = 300000
                },

                {
                    label = "Flat Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_01",
                    price = 500000
                },

                {
                    label = "Tactical Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_02",
                    price = 500000
                },

                {
                    label = "Fat-End Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_03",
                    price = 500000
                },

                {
                    label = "COMPONENT_AT_MUZZLE_03",
                    hash = "COMPONENT_AT_MUZZLE_04",
                    price = 500000
                },

                {
                    label = "Heavy Duty Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_05",
                    price = 500000
                },

                {
                    label = "Slanted Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_06",
                    price = 500000
                },

                {
                    label = "Split-End Muzzle Brake",
                    hash = "COMPONENT_AT_MUZZLE_07",
                    price = 500000
                },

                {
                    label = "Default Barrel",
                    hash = "COMPONENT_AT_MRFL_BARREL_01",
                    price = 500000
                },

                {
                    label = "Heavy Barrel",
                    hash = "COMPONENT_AT_MRFL_BARREL_02",
                    price = 500000
                },

                {
                    label = "Grip",
                    hash = "COMPONENT_AT_AR_AFGRIP_02",
                    price = 500000
                },

                {
                    label = "Digital Camo",
                    hash = "COMPONENT_MARKSMANRIFLE_MK2_CAMO",
                    price = 500000
                },

                {
                    label = "Brushstroke Camo",
                    hash = "COMPONENT_MARKSMANRIFLE_MK2_CAMO_02",
                    price = 500000
                },

                {
                    label = "Woodland Camo",
                    hash = "COMPONENT_MARKSMANRIFLE_MK2_CAMO_03",
                    price = 500000
                },

                {
                    label = "Skull",
                    hash = "COMPONENT_MARKSMANRIFLE_MK2_CAMO_04",
                    price = 500000
                },

                {
                    label = "Sessanta Nove",
                    hash = "COMPONENT_MARKSMANRIFLE_MK2_CAMO_05",
                    price = 500000
                },

                {
                    label = "Perseus",
                    hash = "COMPONENT_MARKSMANRIFLE_MK2_CAMO_06",
                    price = 500000
                },

                {
                    label = "Leopard",
                    hash = "COMPONENT_MARKSMANRIFLE_MK2_CAMO_07",
                    price = 500000
                },

                {
                    label = "Zebra",
                    hash = "COMPONENT_MARKSMANRIFLE_MK2_CAMO_08",
                    price = 500000
                },

                {
                    label = "Geometric",
                    hash = "COMPONENT_MARKSMANRIFLE_MK2_CAMO_09",
                    price = 500000
                },

                {
                    label = "Boom!",
                    hash = "COMPONENT_MARKSMANRIFLE_MK2_CAMO_10",
                    price = 500000
                },

                {
                    label = "Boom!",
                    hash = "COMPONENT_MARKSMANRIFLE_MK2_CAMO_IND_01",
                    price = 500000
                }
            },	

    tints = {

                {
                    label = "Sơn mặc định",
                    index = 0,
                    price = 0
    
                },
    
                {
                    label = "Sơn vàng",
                    index = 2,
                    price = 500000
                },
    
                {
                    label = "Sơn hồng",
                    index = 3,
                    price = 500000
                },
    
                {
                    label = "Sơn màu quân đội",
                    index = 4,
                    price = 500000
                },
    
                {
                    label = "Sơn màu cảnh sát",
                    index = 5,
                    price = 500000
                },
    
                {
                    label = "Sơn màu cam",
                    index = 6,
                    price = 500000
                },
    
                {
                    label = "Sơn màu bạch kim",
                    index = 7,
                    price = 500000
    
                }

            }

        },
						
}