UseESX = true

CheckLoopTime = 1000

AllZones = {	
	["PlayZone"] = {
		Debug = false,
		Zones = {
			{
				minZ = -10.0,
				maxZ = 500.5,
				Coords = {
				  vector2(6498.96484375, -5700.9384765625),
				  vector2(6108.33203125, -6325.6826171875),
				  vector2(4956.4545898438, -7079.4833984375),
				  vector2(4051.1042480469, -6641.0932617188),
				  vector2(2604.8269042969, -5145.8662109375),
				  vector2(2132.1281738281, -4010.7724609375),
				  vector2(3129.6635742188, -2735.3037109375),
				  vector2(6209.04296875, -2849.9448242188),
				  vector2(7159.8525390625, -4691.0854492188)
				},
			},
		},
	},
	
	-- Style
	-- [""] = {
		-- Debug = false,
		-- Zones = {
			-- {
				-- minZ = 0.0,
				-- maxZ = 0.0,
				-- Coords = {
				-- },
			-- },
		-- },
	-- },
}

WhiteListedJobs = {
	["police"] = { -- Jobe Name
		["Police"] = 0, -- [Zone Name] = MinGrade,
	},
	["ambulance"] = { -- Jobe Name
		["Hospital"] = 0, -- [Zone Name] = MinGrade,
	},
}

Texts = {
	["Enter"] = "Bạn đã vào vùng giao tranh",
	["Exit"] = "Bạn đã rời vùng giao tranh",
}

Notify = function(Type,Massge) -- change this to anything you want
	exports['mythic_notify']:SendAlert(Type, Texts[Massge])
	--Trigger("ESX:Notify",Massge,Type)
end