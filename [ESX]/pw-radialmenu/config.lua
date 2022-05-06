Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

Config = {}

Config.MenuItems = {
    [1] = {
        id = 'citizen',
        title = 'Tương tác',
        icon = '#citizen',
        items = {
			{
                id    = 'lockunlock',
                title = 'Khóa/Mở xe',
                icon = '#lockveh',
                type = 'client',
                event = 'pw-garage:LockVehicle',
                shouldClose = true,
            },
			{
                id    = 'givekeys',
                title = 'Đưa chìa khóa',
                icon = '#givekey',
                type = 'client',
                event = 'vehiclekeys:client:GiveKeys',
                shouldClose = true,
            },
            {
                id    = 'givenum',
                title = 'Đưa số điện thoại',
                icon = '#givenumber',
                type = 'client',
                event = 'qb-phone:client:GiveContactDetails',
                shouldClose = true,
            },
			
		
            -- {
                -- id = 'interactions',
                -- title = 'Interactions',
                -- icon = '#illegal',
                -- items = {
                    -- {
                        -- id    = 'handcuff',
                        -- title = 'Cuff',
                        -- icon = '#general',
                        -- type = 'client',
                        -- event = 'police:client:CuffPlayerSoft',
                        -- shouldClose = true,
                    -- },
                    -- {
                        -- id    = 'playerinvehicle',
                        -- title = 'Put in vehicle',
                        -- icon = '#general',
                        -- type = 'client',
                        -- event = 'police:client:PutPlayerInVehicle',
                        -- shouldClose = true,
                    -- },
                    -- {
                        -- id    = 'playeroutvehicle',
                        -- title = 'Put out of the vehicle',
                        -- icon = '#general',
                        -- type = 'client',
                        -- event = 'police:client:SetPlayerOutVehicle',
                        -- shouldClose = true,
                    -- },
                    -- {
                        -- id    = 'stealplayer',
                        -- title = 'Steal',
                        -- icon = '#general',
                        -- type = 'client',
                        -- event = 'police:client:RobPlayer',
                        -- shouldClose = true,
                    -- },
                    -- {
                        -- id    = 'escort',
                        -- title = 'Kidnap',
                        -- icon = '#general',
                        -- type = 'client',
                        -- event = 'police:client:KidnapPlayer',
                        -- shouldClose = true,
                    -- },
                    -- {
                        -- id    = 'escort2',
                        -- title = 'Escort',
                        -- icon = '#general',
                        -- type = 'client',
                        -- event = 'police:client:EscortPlayer',
                        -- shouldClose = true,
                    -- },
                    -- {
                        -- id    = 'escort554',
                        -- title = 'Hostage',
                        -- icon = '#general',
                        -- type = 'client',
                        -- event = 'A5:Client:TakeHostage',
                        -- shouldClose = true,
                    -- },
                -- }
            -- },
        }
    },

    [2] = {
        id = 'jobinteractions',
        title = 'Tương tác công việc',
        icon = '#jobs',
        items = {},
    }, 
    [3] = {
        id = 'vehicle',
        title = 'Phương tiện',
        icon = '#vehicle',
        items = {
            {
                id    = 'vehicledoors',
                title = 'Tổng quát',
                icon = '#vehicledoors',
				type = 'client',
				event = 'veh:options',
				shouldClose = true,
                
            },
            {
                id    = 'getintrunk',
                title = 'Chui vào cốp',
                icon = '#vehiclekey',
                type = 'client',
                event = 'qb-trunk:client:GetIn',
                shouldClose = true,
            },
        }
    },
	[4] = {
        id = 'animations',
        title = 'Tướng đi',
        icon = '#walking',
        items = {
		{
			id    = 'default',
			title = 'Default',
			icon = '#animation-default',
			type = 'client',
			event = 'AnimSet:default',
			shouldClose = true,
		},
		
		{
			id    = 'brave',
			title = 'Brave',
			icon = '#animation-brave',
			type = 'client',
			event = 'AnimSet:Brave',
			shouldClose = true,
		},
		{
			id    = 'hurry',
			title = 'Hurry',
			icon = '#animation-hurry',
			type = 'client',
			event = 'AnimSet:Hurry',
			shouldClose = true,
		},
		{
			id    = 'business',
			title = 'Business',
			icon = '#animation-business',
			type = 'client',
			event = 'AnimSet:Business',
			shouldClose = true,
		},
		{
			id    = 'tipsy',
			title = 'Tipsy',
			icon = '#animation-tipsy',
			type = 'client',
			event = 'AnimSet:Tipsy',
			shouldClose = true,
		},
		{
			id    = 'injured',
			title = 'Injured',
			icon = '#animation-injured',
			type = 'client',
			event = 'AnimSet:Injured',
			shouldClose = true,
		},
		{
			id    = 'tough',
			title = 'Tough',
			icon = '#animation-tough',
			type = 'client',
			event = 'AnimSet:ToughGuy',
			shouldClose = true,
		},
		{
			id    = 'sassy',
			title = 'Sassy',
			icon = '#animation-sassy',
			type = 'client',
			event = 'AnimSet:Sassy',
			shouldClose = true,
		},
		
		{
			id = 'animations2',
			title = 'Tướng 2',
			icon = '#animation-more',
			items = {
				{
					id    = 'sad',
					title = 'Sad',
					icon = '#animation-sad',
					type = 'client',
					event = 'AnimSet:Sad',
					shouldClose = true,
				},
				{
					id    = 'posh',
					title = 'Posh',
					icon = '#animation-posh',
					type = 'client',
					event = 'AnimSet:Posh',
					shouldClose = true,
				},
				
				{
					id    = 'alien',
					title = 'Alien',
					icon = '#animation-alien',
					type = 'client',
					event = 'AnimSet:Alien',
					shouldClose = true,
				},
				
				{
					id    = 'hobo',
					title = 'Hobo',
					icon = '#animation-hobo',
					type = 'client',
					event = 'AnimSet:Hobo',
					shouldClose = true,
				},
				
				{
					id    = 'hobo',
					title = 'Hobo',
					icon = '#animation-hobo',
					type = 'client',
					event = 'AnimSet:Hobo',
					shouldClose = true,
				},
				
				{
					id    = 'money',
					title = 'Money',
					icon = '#animation-money',
					type = 'client',
					event = 'AnimSet:Money',
					shouldClose = true,
				},
				
				{
					id    = 'swagger',
					title = 'Swagger',
					icon = '#animation-swagger',
					type = 'client',
					event = 'AnimSet:Swagger',
					shouldClose = true,
				},
				
				{
					id    = 'shady',
					title = 'Shady',
					icon = '#animation-shady',
					type = 'client',
					event = 'AnimSet:Shady',
					shouldClose = true,
				},
				
				{
					id    = 'maneater',
					title = 'Maneater',
					icon = '#animation-maneater',
					type = 'client',
					event = 'AnimSet:ManEater',
					shouldClose = true,
				},
				
				{
					id    = 'chichi',
					title = 'Chichi',
					icon = '#animation-maneater',
					type = 'client',
					event = 'AnimSet:ChiChi',
					shouldClose = true,
				},
			}
		},
		
		
    },
		
		
		},
    [5] = {
        id = 'clothing',
        title = 'Quần áo',
        icon = '#cloth',
		type = 'client',
		event = 'dpc:ToggleMenu',
		shouldClose = true,
     
    },   
	
	
	 
}


Config.MenuVehicle = {
    [1] = {
        id    = 'lockunlockve',
        title = 'Driver',
        icon = '#vehicle',
        type = 'client',
        event = 'pw-radialmenu:client:ChangeSeat',
        shouldClose = true,
    },
    [2] = {
        id    = 'stasthvehicle',
        title = 'Driver',
        icon = '#vehicle',
        type = 'client',
        event = 'pw-radialmenu:client:ChangeSeat',
        shouldClose = true,
    },	
}

Config.JobInteractions = {
    ["ambulance"] = {
	{
            id    = 'ambulancebill',
            title = 'Ghi bill',
            icon = '#bill',
            type = 'client',
            event = 'esx_ambulancejob:Ghibill',
            shouldClose = true,
        },
        {
            id    = 'reviveplayer',
            title = 'Cứu người chơi',
            icon = '#reviveplayer',
            type = 'client',
            event = 'esx_ambulancejob:rivieplayer',
            shouldClose = true,
        },
        {
            id    = 'deadlist',
            title = 'Kiểm tra',
            icon = '#deadlist',
            type = 'client',
            event = 'hospital:client:CheckStatus',
            shouldClose = true,
        },
        {
            id    = 'billmanage',
            title = 'Quản lý hóa đơn',
            icon = '#billmanage',
            type = 'client',
            event = 'esx_ambulancejob:OpenUnpaidBillsMenu',
            shouldClose = true,
        },
        {
            id    = 'finddead',
            title = 'Kéo xác',
            icon = '#finddead',
            type = 'server',
            event = 'esx_ambulancejob:svsearch',
            shouldClose = true,
        },
		
		{
            id = 'brancardoptions',
            title = 'Cáng cứu thương',
            icon = 'procedures',
            items = {
                {
                    id = 'spawnbrancard',
                    title = 'Lấy băng ca',
                    icon = '#illegal',
                    type = 'client',
                    event = 'hospital:client:TakeBrancard',
                    shouldClose = true
                }, {
                    id = 'despawnbrancard',
                    title = 'Dưa băng ca lên xe',
                    icon = '#illegal',
                    type = 'client',
                    event = 'hospital:client:Dualenxe',
                    shouldClose = true
                }
            }
        }
        
    },
    ["taxi"] = {
        {
            id    = 'togglemeter',
            title = 'Show/Hide Meter',
            icon = '#general',
            type = 'client',
            event = 'qb-taxi:client:toggleMeter',
            shouldClose = true,
        },
        {
            id    = 'togglemouse',
            title = 'Start/Stop Meter',
            icon = '#general',
            type = 'client',
            event = 'qb-taxi:client:enableMeter',
            shouldClose = true,
        },
        {
            id    = 'npc_mission',
            title = 'NPC Missions',
            icon = '#general',
            type = 'client',
            event = 'qb-taxi:client:DoTaxiNpc',
            shouldClose = true,
        },
    },
    ["tow"] = {
        {
            id    = 'togglenpc',
            title = 'Toggle NPC',
            icon = '#general',
            type = 'client',
            event = 'jobs:client:ToggleNpc',
            shouldClose = true,
        },
        {
            id    = 'towvehicle',
            title = 'Tow Vehicle',
            icon = '#vehicle',
            type = 'client',
            event = 'qb-tow:client:TowVehicle',
            shouldClose = true,
        },
    },
    ["police"] = {
        {
            id = 'policeinteraction',
            title = 'Công dân',
            icon = '#policeinteraction',
            items = {
                -- {
                    -- id    = 'idcarcheck1',
                    -- title = 'Kiểm tra toàn thân',
                    -- icon = '#idcard',
                    -- type = 'client',
                    -- event = 'esx_policejob:peoplesearch',
                    -- shouldClose = true,
                -- },
		{
                    id    = 'idcarcheck',
                    title = 'Căn cước',
                    icon = '#idcard',
                    type = 'client',
                    event = 'esx_policejob:OpenIdentityCardMenu',
                    shouldClose = true,
                },
                -- {
                    -- id    = 'checking',
                    -- title = 'Kiểm tra',
                    -- icon = '#checking',
                    -- type = 'client',
                    -- event = 'esx_policejob:peoplesearch',
                    -- shouldClose = true,
                -- },
                {
                    id    = 'drag',
                    title = 'Áp giải',
                    icon = '#drag',
                    type = 'client',
                    event = 'esx_policejob:dragplayer',
                    shouldClose = true,
                },
                {
                    id    = 'cuff',
                    title = 'Còng tay',
                    icon = '#cuff',
                    type = 'client',
                    event = 'esx_policejob:handcuffclient',		    
                    shouldClose = true,
                },
                {
                    id    = 'uncuff',
                    title = 'Mở còng',
                    icon = '#uncuff',
                    type = 'client',
                    event = 'esx_policejob:uncuffclient',
		   
                    shouldClose = true,
                },
		{
                    id    = 'community',
                    title = 'Lao động công ích',
                    icon = '#community',
                    type = 'client',
                    event = 'esx_policejob:SendToCommunityService',
		   
                    shouldClose = true,
                },
		{
                    id    = 'unpaidbill',
                    title = 'Quản lý hóa đơn',
                    icon = '#billmanage',
                    type = 'client',
                    event = 'esx_policejob:OpenUnpaidBillsMenu',
		   
                    shouldClose = true,
                },
		{
                    id    = 'policechecklic',
                    title = 'Quản lý giấy phép',
                    icon = '#checklic',
                    type = 'client',
                    event = 'esx_policejob:ShowPlayerLicense',
		   
                    shouldClose = true,
                },
            }
        },
        {
            id = 'vehicleinteraction',
            title = 'Phương tiện',
            icon = '#vehicleinteraction',
            items = {
                {
                    id    = 'vehcileinfo',
                    title = 'Thông tin',
                    icon = '#vehcileinfo',
                    type = 'client',
                    event = 'esx_policejob:OpenVehicleInfosMenu',
                    shouldClose = true,
                },
                {
                    id    = 'impound',
                    title = 'Giam xe',
                    icon = '#impound',
                    type = 'client',
                    event = 'esx_policejob:ImpoundVehicle',
                    shouldClose = true,
                },
           
            }
        },
        {
            id = 'wanted',
            title = 'Truy nã',
            icon = '#wanted',
            type = 'client',
            event = 'esx_wanted:OpenWantedMenu',
            shouldClose = true,
        },
        {
            id = 'judgle',
            title = 'Tòa án liên bang',
            icon = '#judgle',
            type = 'client',
            event = 'esx-monkey-jail:openJailMenu',
            shouldClose = true,
        },
        
    },
    ["mechanic"] = {
	{
            id    = 'mechanicbill',
            title = 'Ghi bill',
            icon = '#bill',
            type = 'client',
            event = 'qb-hotdogjob:client:ToggleSell',
            shouldClose = true,
        },
        {
            id    = 'fixvehicle',
            title = 'Sửa xe',
            icon = '#suaxe',
            type = 'client',
            event = 'qb-hotdogjob:client:ToggleSell',
            shouldClose = true,
        },
	{
            id    = 'cleanvehicle',
            title = 'Lau xe',
            icon = '#lauxe',
            type = 'client',
            event = 'qb-hotdogjob:client:ToggleSell',
            shouldClose = true,
        },
	
	
    },
    -- ["taxi"] = {

    -- },
}

Config.TrunkClasses = {
    [0]  = { allowed = true, x = 0.0, y = -1.5, z = 0.0 }, --Coupes  
    [1]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Sedans  
    [2]  = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --SUVs  
    [3]  = { allowed = true, x = 0.0, y = -1.5, z = 0.0 }, --Coupes  
    [4]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Muscle  
    [5]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Sports Classics  
    [6]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Sports  
    [7]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Super  
    [8]  = { allowed = false, x = 0.0, y = -1.0, z = 0.25 }, --Motorcycles  
    [9]  = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Off-road  
    [10] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Industrial  
    [11] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Utility  
    [12] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Vans  
    [13] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Cycles  
    [14] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Boats  
    [15] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Helicopters  
    [16] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Planes  
    [17] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Service  
    [18] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Emergency  
    [19] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Military  
    [20] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Commercial  
    [21] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Trains  
}