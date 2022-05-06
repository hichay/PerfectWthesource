GaragesConfig = {
    ['settings'] = {
        ['blip'] = {
            ['garage'] = {43, 524, 6, 0.9},
            ['impound'] = {47, 524, 6, 0.9},
            ['house'] = {50, 492, 6, 0.9},
        },


        --[[
            Blacklisted Weapons,
            Players will not be able to rob NPC car with these weapons
        ]]
        ['blacklistedWeapons'] = {
            "WEAPON_UNARMED",
            "WEAPON_Knife",
            "WEAPON_Nightstick",
            "WEAPON_HAMMER",
            "WEAPON_Bat",
            "WEAPON_Crowbar",
            "WEAPON_Golfclub",
            "WEAPON_Bottle",
            "WEAPON_Dagger",
            "WEAPON_Hatchet",
            "WEAPON_KnuckleDuster",
            "WEAPON_Machete",
            "WEAPON_Flashlight",
            "WEAPON_SwitchBlade",
            "WEAPON_Poolcue",
            "WEAPON_Wrench",
            "WEAPON_Battleaxe",
            "WEAPON_Grenade",
            "WEAPON_StickyBomb",
            "WEAPON_ProximityMine",
            "WEAPON_BZGas",
            "WEAPON_Molotov",
            "WEAPON_FireExtinguisher",
            "WEAPON_PetrolCan",
            "WEAPON_Flare",
            "WEAPON_Ball",
            "WEAPON_Snowball",
            "WEAPON_SmokeGrenade",
        },

        -- Accept Bank?
        ['bank-payments'] = true,

        -- Fakeplates Stuff
        ['fakeplates'] = {
            ['screwdriver-break-chance'] = 4, -- X / 10
            ['skillbars-max-random'] = 1, -- Max random number of skill bars
            ['taskbarskill-export'] = 'rl-taskbarskill',
        },

        ['interactions'] = {
            ['interact'] = 'Garage',
            ['to_interact'] = '~r~E~w~ để mở garage',
            ['houseinteract'] = 'Garage Nhà',
            ['to_houseinteract'] = '~r~E~w~ để mở garage nhà',

        },

        ['housing'] = {
            ['realestate-job'] = 'realestate',
            ['qb-houses:client:addGarage'] = 'Allhousing:client:addGarage',
            ['max-garage-slots'] = 4,
        }
        
    }
}

Config = {}

Config.NoRobWeapons = {
    "WEAPON_UNARMED",
    "WEAPON_Knife",
    "WEAPON_Nightstick",
    "WEAPON_HAMMER",
    "WEAPON_Bat",
    "WEAPON_Crowbar",
    "WEAPON_Golfclub",
    "WEAPON_Bottle",
    "WEAPON_Dagger",
    "WEAPON_Hatchet",
    "WEAPON_KnuckleDuster",
    "WEAPON_Machete",
    "WEAPON_Flashlight",
    "WEAPON_SwitchBlade",
    "WEAPON_Poolcue",
    "WEAPON_Wrench",
    "WEAPON_Battleaxe",
    "WEAPON_Grenade",
    "WEAPON_StickyBomb",
    "WEAPON_ProximityMine",
    "WEAPON_BZGas",
    "WEAPON_Molotov",
    "WEAPON_FireExtinguisher",
    "WEAPON_PetrolCan",
    "WEAPON_Flare",
    "WEAPON_Ball",
    "WEAPON_Snowball",
    "WEAPON_SmokeGrenade",
}