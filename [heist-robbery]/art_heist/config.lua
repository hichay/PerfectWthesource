Config = {}

Config.SharedObject = 'esx:getSharedObject' -- ESX Shared Object / Change if using a custom version of ESX

Config.Locale = 'en' -- Language

Config.WindowEntrance = vector3(26.68, 145.07, 104.12) -- Entrance

Config.RandomPainting = false    -- Randomly get painting tiers or not, if not using random you need to assign a tier in the PaintingLocations section


-- NOTIFICATIONS --
Config.MythicNotify   = true      -- You need to disable pNotify if this is enabled

Config.pNotify        = false       -- You need to disable MythicNotify if this is enabled
Config.pNotifyOptions = {
    layout            = 'bottomCenter' -- options are: top, topLeft, topRight, topCenter, center, centerLeft, centerRight, bottom, bottomLeft, bottomRight, bottomCenter
}

---- ADD-ONS ----
Config.UseProgressbar      = true
Config.UseSkillsbar     = false
Config.UseMHacking      = false


Config.SkillbarDifficulty = {
    ['RoofWindow'] = 4, -- Amount of iterations
    ['Winch'] = 4,
    ['GoldenEgg']   = 8,
    ['HackingCiv']   = 8,
    ['HackingPolice']   = 12,
}
-- SETTINGS --
Config.TimeAfterHack    = 30 -- How much time is bought before the alarm goes off after hacking intime

-- PAINTING TIERS AVAILABLE = 1, 2, 3
Config.PaintingLocations = {
    {pos = vector3(23.5, 149.27, 93.79), tier = 1, heading = 340.0},
    {pos = vector3(24.17, 150.80, 93.79), tier = 1, heading = 160.0},
    {pos = vector3(22.15, 151.5, 93.79), tier = 1, heading = 160.0},
    {pos = vector3(198.81, 139.14, 93.79), tier = 1, heading = 340.0},
    {pos = vector3(37.68, 134.5, 93.79), tier = 1, heading = 160.0},
    {pos = vector3(41.39, 144.45, 93.79), tier = 1, heading = 160.0},
    {pos = vector3(18.6, 141.5, 93.79), tier = 1, heading = 160.0},
    {pos = vector3(39.63, 133.76, 93.79), tier = 1, heading = 160.0},
    {pos = vector3(39.04, 132.22, 93.79), tier = 1, heading = 340.0},
    {pos = vector3(40.76, 142.91, 93.79), tier = 1, heading = 340.0},
    {pos = vector3(19.841184, 139.401, 93.7928), tier = 1, heading = 340.0},
}

Config.DoorButtons = {
    {pos = vector3(18, 144.63, 93.79), heading = 70.0},
    {pos = vector3(15.21, 144.29, 93.79), heading = 70.0, policeHack = vector3(15.38, 144.52, 93.79)}
}

Config.GallerySettings = {
    UseTimes = false, -- ONLY DISABLE THIS IF YOUR SERVER TIME ISNT SYNCED OR IF YOU WANT THE GALLERY TO BE ROBBABLE AT ANY TIME
    ClosingTime = 21,
    OpeningTime = 9
}

Config.RequiredPolice = 0 -- Amount of police required to rob the gallery

Config.Cooldown     = 500 -- seconds

Config.SecuritySystem = { pos = vector3(17.43, 153.39, 93.79) }

Config.BankVault = {pos = vector3(14.762, 138.72, 93.981), hash = -660779536, defaultHeading = 70.0, curHeading = 70.0, markerPos = vector3(16.18, 139.95, 93.8), eggPos = vector3(10.22, 139.62, 93.8)}

-- BLACK MARKET OPTIONS --
Config.SellLocations = {
    {
        callMarker = vector3(2545.77, 2583.9, 37.94),
        driveTo = { pos = vector3(2543.38, 2583.09, 37.94), heading = 15.0 },
        spawn = { pos = vector3(2562.86, 2708.81, 42.13), heading = 100.0}
    }
}

Config.BlackmarketItems = {
    ['painting_1'] = 5000,
    ['painting_2'] = 5000,
    ['painting_3'] = 5000,
    ['golden_egg'] = 5000,
}

Config.BlackmarketSettings = {
    vehicle         = 'burrito3',
    npc             = 'mp_m_niko_01',
    useBlip         = true,
    useBlackMoney   = true
}

