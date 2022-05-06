Config = {}

--[[
    This Is How Damage Must Be Applied To Trigger The Limb Damage Aspect
]]

Config.Hash = {
	{hash = "ambulance", detection = 4.8, depth = -2.5, height = 0.3},
	{hash = "20ramambo", detection = 4.8, depth = 4.0, height = -0.145},
	{hash = "ambulance22", detection = 4.1, depth = -1.0, height = -0.15},
}
Config.HealthDamage = 10
Config.ArmorDamage = 5
Config.CheckTime = 10
Config.BodyArmorStaggerChance = 20
--[[
    This Is The Timer For How Long The Player Will Be In The Bed When They Check-In To Be Healed Automatically, This Is In Seconds
]]
Config.AIHealTimer = 30

--[[ 
    TIMERS This Is In Seconds - This Will Decide How Long The Thread Controlling This Functionality Is Slept For
]]
Config.BleedTickRate = 90

--[[
    This is how many seconds is taken away from the bleed tick rate if the player is walking, jogging, or sprinting
]]
Config.BleedMovementTick = 1
Config.BleedMovementAdvance = 2

--[[ 
    How Many Bleed Ticks You Want To Occur Before A Screen Fade Happens
]]
Config.FadeOutTimer = 2

--[[
    This Is How Many Intervals Pass Before You Blackout | This Is Calculated By BleedTickRate * FadeOutTimer = 1 Blackouttimer Tick 
    So Setting This To 10 with the above set to default would be 10 minutes ((30 * 2) * 10) = 600
]]
Config.BlackoutTimer = 10

--[[
    How Many Bleed Ticks Occur Before Your Bleed Level Is Increased
]]
Config.AdvanceBleedTimer = 10

--[[
    How many times, in seconds, are certain injury types checked to have side-effects applied
]]
Config.HeadInjuryTimer = 30
Config.ArmInjuryTimer = 30
Config.LegInjuryTimer = 15

--[[
    The Chance, In Percent, That Certain Injury Side-Effects Get Applied
]]
Config.HeadInjuryChance = 25
Config.ArmInjuryChance = 25
Config.LegInjuryChance = {
    Running = 50,
    Walking = 15
}

Config.ArmorStaggerChance = 65 -- Note : Small caliber weapons are this % halved

--[[
    The Base Damage That Is Multiplied By Bleed Level Every Time A Bleed Tick Occurs
]]
Config.BleedTickDamage = 4

--[[ ------------------------------------------------------------------------------------------------------------------------------------- ]]
--[[ ------------------------------------------------------------------------------------------------------------------------------------- ]]
--[[ ------------------------------------------------------------------------------------------------------------------------------------- ]]
--[[ ------------------------------------------------------------------------------------------------------------------------------------- ]]
--[[ ------------------------------------------------------------------------------------------------------------------------------------- ]]
--[[ ------------------------------------------------------------------------------------------------------------------------------------- ]]

Config.WeaponClasses = {
    ['SMALL_CALIBER'] = 1,
    ['MEDIUM_CALIBER'] = 2,
    ['HIGH_CALIBER'] = 3,
    ['SHOTGUN'] = 4,
    ['CUTTING'] = 5,
    ['LIGHT_IMPACT'] = 6,
    ['HEAVY_IMPACT'] = 7,
    ['EXPLOSIVE'] = 8,
    ['FIRE'] = 9,
    ['SUFFOCATING'] = 10,
    ['OTHER'] = 11,
    ['WILDLIFE'] = 12,
    ['NOTHING'] = 13
}

Config.WoundStates = {
    'Bị đau nhẹ',
    'Khá đau đớn',
    'Cực kỳ đau đớn',
    'Đau đớn không thể chịu được',
}

Config.BleedingStates = {
    'Chảy máu nhẹ',
    'Chảy máu đáng kể',
    'Chảy máu nặng',
    'Chảy máu rất nhiều',
}

Config.MovementRate = {
    0.98,
    0.95,
    0.92,
    0.90,
}

Config.Bones = {
    [0]     = 'NONE',
    [31085] = 'HEAD',
    [31086] = 'HEAD',
    [39317] = 'NECK',
    [57597] = 'SPINE',
    [23553] = 'SPINE',
    [24816] = 'SPINE',
    [24817] = 'SPINE',
    [24818] = 'SPINE',
    [10706] = 'UPPER_BODY',
    [64729] = 'UPPER_BODY',
    [11816] = 'LOWER_BODY',
    [45509] = 'LARM',
    [61163] = 'LARM',
    [18905] = 'LHAND',
    [4089] = 'LFINGER',
    [4090] = 'LFINGER',
    [4137] = 'LFINGER',
    [4138] = 'LFINGER',
    [4153] = 'LFINGER',
    [4154] = 'LFINGER',
    [4169] = 'LFINGER',
    [4170] = 'LFINGER',
    [4185] = 'LFINGER',
    [4186] = 'LFINGER',
    [26610] = 'LFINGER',
    [26611] = 'LFINGER',
    [26612] = 'LFINGER',
    [26613] = 'LFINGER',
    [26614] = 'LFINGER',
    [58271] = 'LLEG',
    [63931] = 'LLEG',
    [2108] = 'LFOOT',
    [14201] = 'LFOOT',
    [40269] = 'RARM',
    [28252] = 'RARM',
    [57005] = 'RHAND',
    [58866] = 'RFINGER',
    [58867] = 'RFINGER',
    [58868] = 'RFINGER',
    [58869] = 'RFINGER',
    [58870] = 'RFINGER',
    [64016] = 'RFINGER',
    [64017] = 'RFINGER',
    [64064] = 'RFINGER',
    [64065] = 'RFINGER',
    [64080] = 'RFINGER',
    [64081] = 'RFINGER',
    [64096] = 'RFINGER',
    [64097] = 'RFINGER',
    [64112] = 'RFINGER',
    [64113] = 'RFINGER',
    [36864] = 'RLEG',
    [51826] = 'RLEG',
    [20781] = 'RFOOT',
    [52301] = 'RFOOT',
}

Config.BoneIndexes = {
    ['NONE'] = 0,
    ['HEAD'] = 31085,
    ['HEAD'] = 31086,
    ['NECK'] = 39317, 
    ['SPINE'] = 57597,
    ['SPINE'] = 23553,
    ['SPINE'] = 24816,
    ['SPINE'] = 24817,
    ['SPINE'] = 24818,
    ['UPPER_BODY'] = 10706,
    ['UPPER_BODY'] = 64729,
    ['LOWER_BODY'] = 11816,
    ['LARM'] = 45509,
    ['LARM'] = 61163,
    ['LHAND'] = 18905,
    ['LFINGER'] = 4089,
    ['LFINGER'] = 4090,
    ['LFINGER'] = 4137,
    ['LFINGER'] = 4138,
    ['LFINGER'] = 4153,
    ['LFINGER'] = 4154,
    ['LFINGER'] = 4169,
    ['LFINGER'] = 4170,
    ['LFINGER'] = 4185,
    ['LFINGER'] = 4186,
    ['LFINGER'] = 26610,
    ['LFINGER'] = 26611,
    ['LFINGER'] = 26612,
    ['LFINGER'] = 26613,
    ['LFINGER'] = 26614,
    ['LLEG'] = 58271,
    ['LLEG'] = 63931,
    ['LFOOT'] = 2108,
    ['LFOOT'] = 14201,
    ['RARM'] = 40269,
    ['RARM'] = 28252,
    ['RHAND'] = 57005,
    ['RFINGER'] = 58866,
    ['RFINGER'] = 58867,
    ['RFINGER'] = 58868,
    ['RFINGER'] = 58869,
    ['RFINGER'] = 58870,
    ['RFINGER'] = 64016,
    ['RFINGER'] = 64017,
    ['RFINGER'] = 64064,
    ['RFINGER'] = 64065,
    ['RFINGER'] = 64080,
    ['RFINGER'] = 64081,
    ['RFINGER'] = 64096,
    ['RFINGER'] = 64097,
    ['RFINGER'] = 64112,
    ['RFINGER'] = 64113,
    ['RLEG'] = 36864,
    ['RLEG'] = 51826,
    ['RFOOT'] = 20781,
    ['RFOOT'] = 52301,
}

Config.Weapons = {
    --[[ Small Caliber ]]--
    [`WEAPON_PISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_COMBATPISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_APPISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_COMBATPDW`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_MACHINEPISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_MICROSMG`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_MINISMG`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_PISTOL_MK2`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_SNSPISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_SNSPISTOL_MK2`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_VINTAGEPISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],

    --[[ Medium Caliber ]]--
    [`WEAPON_ADVANCEDRIFLE`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_ASSAULTSMG`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_BULLPUPRIFLE`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_BULLPUPRIFLE_MK2`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_CARBINERIFLE`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_CARBINERIFLE_MK2`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_COMPACTRIFLE`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_DOUBLEACTION`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_GUSENBERG`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_HEAVYPISTOL`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_MARKSMANPISTOL`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_PISTOL50`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_REVOLVER`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_REVOLVER_MK2`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_SMG`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_SMG_MK2`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_SPECIALCARBINE`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_SPECIALCARBINE_MK2`] = Config.WeaponClasses['MEDIUM_CALIBER'],

    --[[ High Caliber ]]--
    [`WEAPON_ASSAULTRIFLE`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_ASSAULTRIFLE_MK2`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_COMBATMG`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_COMBATMG_MK2`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_HEAVYSNIPER`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_HEAVYSNIPER_MK2`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_MARKSMANRIFLE`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_MARKSMANRIFLE_MK2`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_MG`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_MINIGUN`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_MUSKET`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_RAILGUN`] = Config.WeaponClasses['HIGH_CALIBER'],

    --[[ Shotguns ]]--
    [`WEAPON_ASSAULTSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
    [`WEAPON_BULLUPSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
    [`WEAPON_DBSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
    [`WEAPON_HEAVYSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
    [`WEAPON_PUMPSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
    [`WEAPON_PUMPSHOTGUN_MK2`] = Config.WeaponClasses['SHOTGUN'],
    [`WEAPON_SAWNOFFSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
    [`WEAPON_SWEEPERSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],

    --[[ Animals ]]--
    [`WEAPON_ANIMAL`] = Config.WeaponClasses['WILDLIFE'], -- Animal
    [`WEAPON_COUGAR`] = Config.WeaponClasses['WILDLIFE'], -- Cougar
    [`WEAPON_BARBED_WIRE`] = Config.WeaponClasses['WILDLIFE'], -- Barbed Wire
    
    --[[ Cutting Weapons ]]--
    [`WEAPON_BATTLEAXE`] = Config.WeaponClasses['CUTTING'],
    [`WEAPON_BOTTLE`] = Config.WeaponClasses['CUTTING'],
    [`WEAPON_DAGGER`] = Config.WeaponClasses['CUTTING'],
    [`WEAPON_HATCHET`] = Config.WeaponClasses['CUTTING'],
    [`WEAPON_KNIFE`] = Config.WeaponClasses['CUTTING'],
    [`WEAPON_MACHETE`] = Config.WeaponClasses['CUTTING'],
    [`WEAPON_SWITCHBLADE`] = Config.WeaponClasses['CUTTING'],

    --[[ Light Impact ]]--
    --[`WEAPON_GARBAGEBAG`] = Config.WeaponClasses['LIGHT_IMPACT'], -- Garbage Bag
    --[`WEAPON_BRIEFCASE`] = Config.WeaponClasses['LIGHT_IMPACT'], -- Briefcase
    --[`WEAPON_BRIEFCASE_02`] = Config.WeaponClasses['LIGHT_IMPACT'], -- Briefcase 2
    --[`WEAPON_BALL`] = Config.WeaponClasses['LIGHT_IMPACT'],
    --[`WEAPON_FLASHLIGHT`] = Config.WeaponClasses['LIGHT_IMPACT'],
    [`WEAPON_KNUCKLE`] = Config.WeaponClasses['LIGHT_IMPACT'],
    --[`WEAPON_NIGHTSTICK`] = Config.WeaponClasses['LIGHT_IMPACT'],
    --[`WEAPON_SNOWBALL`] = Config.WeaponClasses['LIGHT_IMPACT'],
    --[`WEAPON_UNARMED`] = Config.WeaponClasses['LIGHT_IMPACT'],
    --[`WEAPON_PARACHUTE`] = Config.WeaponClasses['LIGHT_IMPACT'],
    --[`WEAPON_NIGHTVISION`] = Config.WeaponClasses['LIGHT_IMPACT'],
    
    --[[ Heavy Impact ]]--
    [`WEAPON_BAT`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_CROWBAR`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_FIREEXTINGUISHER`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_FIRWORK`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_GOLFLCUB`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_HAMMER`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_PETROLCAN`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_POOLCUE`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_WRENCH`] = Config.WeaponClasses['HEAVY_IMPACT'],
    
    --[[ Explosives ]]--
    [`WEAPON_EXPLOSION`] = Config.WeaponClasses['EXPLOSIVE'], -- Explosion
    [`WEAPON_GRENADE`] = Config.WeaponClasses['EXPLOSIVE'],
    [`WEAPON_COMPACTLAUNCHER`] = Config.WeaponClasses['EXPLOSIVE'],
    [`WEAPON_HOMINGLAUNCHER`] = Config.WeaponClasses['EXPLOSIVE'],
    [`WEAPON_PIPEBOMB`] = Config.WeaponClasses['EXPLOSIVE'],
    [`WEAPON_PROXMINE`] = Config.WeaponClasses['EXPLOSIVE'],
    [`WEAPON_RPG`] = Config.WeaponClasses['EXPLOSIVE'],
    [`WEAPON_STICKYBOMB`] = Config.WeaponClasses['EXPLOSIVE'],
    
    --[[ Other ]]--
    [`WEAPON_FALL`] = Config.WeaponClasses['OTHER'], -- Fall
    [`WEAPON_HIT_BY_WATER_CANNON`] = Config.WeaponClasses['OTHER'], -- Water Cannon
    [`WEAPON_RAMMED_BY_CAR`] = Config.WeaponClasses['OTHER'], -- Rammed
    [`WEAPON_RUN_OVER_BY_CAR`] = Config.WeaponClasses['OTHER'], -- Ran Over
    [`WEAPON_HELI_CRASH`] = Config.WeaponClasses['OTHER'], -- Heli Crash
    [`WEAPON_STUNGUN`] = Config.WeaponClasses['OTHER'],
    
    --[[ Fire ]]--
    [`WEAPON_ELECTRIC_FENCE`] = Config.WeaponClasses['FIRE'], -- Electric Fence 
    [`WEAPON_FIRE`] = Config.WeaponClasses['FIRE'], -- Fire
    [`WEAPON_MOLOTOV`] = Config.WeaponClasses['FIRE'],
    [`WEAPON_FLARE`] = Config.WeaponClasses['FIRE'],
    [`WEAPON_FLAREGUN`] = Config.WeaponClasses['FIRE'],

    --[[ Suffocate ]]--
    [`WEAPON_DROWNING`] = Config.WeaponClasses['SUFFOCATING'], -- Drowning
    [`WEAPON_DROWNING_IN_VEHICLE`] = Config.WeaponClasses['SUFFOCATING'], -- Drowning Veh
    [`WEAPON_EXHAUSTION`] = Config.WeaponClasses['SUFFOCATING'], -- Exhaust
    [`WEAPON_BZGAS`] = Config.WeaponClasses['SUFFOCATING'],
    [`WEAPON_SMOKEGRENADE`] = Config.WeaponClasses['SUFFOCATING'],
}


Config.WeaponDamageList = {
	["WEAPON_UNARMED"] = "Nắm đấm",
	["WEAPON_ANIMAL"] = "Vết thương do động vật cắn",
	["WEAPON_COUGAR"] = "Vết thương do động vật cắn",
	["WEAPON_KNIFE"] = "Vết thương đâm",
	["WEAPON_NIGHTSTICK"] = "Bị đánh từ một cây gậy hoặc một cái gì đó tương tự",
	["WEAPON_BREAD"] = "Dent in your head from a baguette!",
	["WEAPON_HAMMER"] = "Bị đánh từ một cây gậy hoặc một cái gì đó tương tự",
	["WEAPON_BAT"] = "Bị đánh từ một cây gậy hoặc một cái gì đó tương tự",
	["WEAPON_GOLFCLUB"] = "Bị đánh từ một cây gậy hoặc một cái gì đó tương tự",
	["WEAPON_CROWBAR"] = "Bị đánh từ một cây gậy hoặc một cái gì đó tương tự",
	["WEAPON_PISTOL"] = "Bị đạn súng lục bắn",
	["WEAPON_COMBATPISTOL"] = "Bị đạn súng lục bắn",
	["WEAPON_APPISTOL"] = "Bị đạn súng lục bắn",
	["WEAPON_PISTOL50"] = "Bị đạn súng lục bắn",
	["WEAPON_MICROSMG"] = "Bị đạn smg bắn",
	["WEAPON_SMG"] = "Bị đạn smg bắn",
	["WEAPON_ASSAULTSMG"] = "Bị đạn smg bắn",
	["WEAPON_ASSAULTRIFLE"] = "Bị đạn súng trường bắn",
	["WEAPON_CARBINERIFLE"] = "Bị đạn súng trường bắn",
	["WEAPON_ADVANCEDRIFLE"] = "Bị đạn súng trường bắn",
	["WEAPON_MG"] = "Machine Gun bullets in the body",
	["WEAPON_COMBATMG"] = "Machine Gun bullets in the body",
	["WEAPON_PUMPSHOTGUN"] = "Shotgun bullets in the body",
	["WEAPON_SAWNOFFSHOTGUN"] = "Shotgun bullets in the body",
	["WEAPON_ASSAULTSHOTGUN"] = "Shotgun bullets in the body",
	["WEAPON_BULLPUPSHOTGUN"] = "Shotgun bullets in the body",
	["WEAPON_STUNGUN"] = "Taser prints",
	["WEAPON_SNIPERRIFLE"] = "Sniper bullets in the body",
	["WEAPON_HEAVYSNIPER"] = "Sniper bullets in the body",
	["WEAPON_REMOTESNIPER"] = "Sniper bullets in the body",
	["WEAPON_GRENADELAUNCHER"] = "Burns and fragments",
	["WEAPON_GRENADELAUNCHER_SMOKE"] = "Smoke Damage",
	["WEAPON_RPG"] = "Burns and fragments",
	["WEAPON_STINGER"] = "Burns and fragments",
	["WEAPON_MINIGUN"] = "Very much bullets in the body",
	["WEAPON_GRENADE"] = "Burns and fragments",
	["WEAPON_STICKYBOMB"] = "Burns and fragments",
	["WEAPON_SMOKEGRENADE"] = "Smoke Damage",
	["WEAPON_BZGAS"] = "Gas Damage",
	["WEAPON_MOLOTOV"] = "Heavy Burns",
	["WEAPON_FIREEXTINGUISHER"] = "Sprayed on :)",
	["WEAPON_PETROLCAN"] = "Petrol Can Damage",
	["WEAPON_FLARE"] = "Flare Damage",
	["WEAPON_BARBED_WIRE"] = "Barbed Wire Damage",
	["WEAPON_DROWNING"] = "Đuối nước",
	["WEAPON_DROWNING_IN_VEHICLE"] = "Đuối nước",
	["WEAPON_BLEEDING"] = "Mất nhiều máu",
	["WEAPON_ELECTRIC_FENCE"] = "Vết thương hàng rào điện",
	["WEAPON_EXPLOSION"] = "Bị cháy (vụ nổ)",
	["WEAPON_FALL"] = "Gãy xương",
	["WEAPON_EXHAUSTION"] = "Died of Exhaustion",
	["WEAPON_HIT_BY_WATER_CANNON"] = "Water Cannon Pelts",
	["WEAPON_RAMMED_BY_CAR"] = "Tại nạn xe cộ",
	["WEAPON_RUN_OVER_BY_CAR"] = "Bị tông bởi xe",
	["WEAPON_HELI_CRASH"] = "Sự cố trực thăng",
	["WEAPON_FIRE"] = "Bị cháy",
}