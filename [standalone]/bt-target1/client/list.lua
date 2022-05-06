Citizen.CreateThread(function()
    local peds = {
    `cs_josef`,
    }
    AddTargetModel(peds, {
        options = {
            {
                event = "pw-hunting:makeSales",
                icon = "fad fa-angle-double-right",
                label = "Bán thịt thú",
            },	

        },
        distance = 3.5
    })


    -- local vehicle = {
        -- `vehicle`,
    -- }
    -- AddTargetModel1(vehicle, {
        -- options = {
            -- {
                -- event = "qb-radialmenu:openMenuVehicle",
                -- icon = "fad fa-angle-double-right",
                -- label = "Xe",
            -- },

        -- },
        -- distance = 3.5
    -- })	
	

    -- local coffee = {
        -- 690372739,
    -- }
    -- AddTargetModel(coffee, {
        -- options = {
            -- {
                -- event = "coffeeevent",
                -- icon = "fas fa-coffee",
                -- label = "Coffee",
            -- },
        -- },
        -- distance = 2.5
    -- })
    
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
            },

        },
        distance = 3.5
    })
end)