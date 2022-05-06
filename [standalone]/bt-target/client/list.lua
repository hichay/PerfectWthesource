Citizen.CreateThread(function()
    local lumberjack = {
    `mp_m_counterfeit_01`
    }	
    AddTargetModel(lumberjack,{
	options = {
		{
			event = "pw-lumberjack:client:kichhoat",
			icon = "fas fa-hand-paper",
			label = "Bắt đầu/ Kết thúc công việc",
			num = 1
		},

	},
	distance = 2
    })
	
	local mine = {
    `g_m_importexport_01`
    }	
    AddTargetModel(mine,{
	options = {
		{
			event = "pw-mine:client:kichhoat",
			icon = "fas fa-hand-paper",
			label = "Bắt đầu/ Kết thúc công việc",
			num = 1
		},
		{
			event = "pw-mine:makeSales",
			icon = "fas fa-hand-paper",
			label = "Bán quặng thô",
			num = 2
		},

	},
	distance = 2
    })
	
	local hunter = {
    `cs_josef`,

    }	
    AddTargetModel(hunter,{
	options = {
		{
			event = "pw-hunting:makeSales",
			icon = "fas fa-hand-paper",
			label = "Bán đồ săn được",
			num = 1
		},
		{
			event = "pw-freshmeat:makeSales",
			icon = "fas fa-hand-paper",
			label = "Bán thịt bò",
			num = 2
		},
		{
			event = "pw-hunting:client:kichhoat",
			icon = "fas fa-exclamation-triangle",
			label = "Bắt đầu/Kết thúc đi săn",
			num = 3
		},
	},
	distance = 2
    })
	
	local huntinganimal = {
    `a_c_deer`,
	`a_c_boar`,
	`a_c_mtlion`,
	`a_c_coyote`,
	`a_c_rabbit_01`,
	`a_c_cormorant`,
	`a_c_chickenhawk`,
	`a_c_panther`,
    }	
    AddTargetModel(huntinganimal,{
	options = {
		{
			event = "pw-hunting:client:lamthit",
			icon = "fa-knife-kitchen",
			label = "Làm thịt",
			num = 1
		},
	},
	distance = 2
    })
	
	local golf = {
    `cs_milton`,
    }	
    AddTargetModel(golf,{
	options = {
		{
			event = "pw-golfgame:spawngolf",
			icon = "fas fa-hand-paper",
			label = "Thuê xe đánh golf",
			num = 1
		},
	},
	distance = 2
    })
    
    AddBoxZone("PoliceDuty", vector3(441.79, -982.07, 30.69), 0.4, 0.6, {
	name="PoliceDuty",
	heading=91,
	debugPoly=false,
	minZ=30.79,
	maxZ=30.99
    }, {
        options = {
            {
                event = "signon",
                icon = "far fa-clipboard",
                label = "Sign On",
            },
            {
                event = "signoff",
                icon = "far fa-clipboard",
                label = "Sign Off",
            },
        },
        distance = 1.5
    })
	
	
	local dumpster = {
    `prop_cs_dumpster_01a`,
	`prop_dumpster_02a`,
	`prop_dumpster_01a`,
	`prop_dumpster_02b`,
	`prop_dumpster_4b`,
	`prop_dumpster_3a`,
	`prop_bin_05a`,

    }
    AddTargetModel(dumpster, {
        options = {
            {
                event = "pw-materials:client:search:trash",
                icon = "fas fa-hand-paper",				
                label = "Lục lọi",
				num = 1
            },

        },
        distance = 3.5
    })
	
	local dumpster = {
    `prop_parknmeter_01`,
	`prop_parknmeter_02`,

    }
    AddTargetModel(dumpster, {
        options = {
            {
                event = "pw-materials:client:crack:parkmeter",
                icon = "fas fa-hand-paper",				
                label = "Cạy cây",
				num = 1
            },

        },
        distance = 3.5
    })
end)