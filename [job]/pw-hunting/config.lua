Config = {}

-- [GENERAL]:
Config.EnableFootprints     = true
Config.PNearAnimalToEscape  = 40      -- if the distance between a player and the animal is less than this value, it will run away (not for native animals)

-- [HARVESTING]:
Config.HeadshotForPerfect = true      -- In order to receve the perfect item, you will need to get perfect in Config.WeaponDamages and also kill the animal with an headshot 
Config.TimeToHarvest      = 15000     -- number of milliseconds to complete harvesting
Config.CameraMovement     = false      -- if true camera animation when harvesting animals
Config.MinLeather         = 1         -- the minimum number of leather you can drop
Config.MaxLeather         = 1         -- the maximum number of leather you can drop 
Config.CanDropMeat        = true      -- false if you don't want that animals can drop meat
Config.MeatItem           = "meat"    -- item name for meat
Config.MinMeat            = 1         -- the minimum number of leather you can drop
Config.MaxMeat            = 1         -- the maximum number of leather you can drop
Config.CanDropSpecial     = true      -- false if you don't want that animals can drop special items (see Config.Animals)
Config.SpecialProb        = 96        -- probability, example: the script generates a random number from 1 to 100, if the random number is higher (>) than this one it will drop (so 10% probability)

-- [BAIT]:
Config.EnableBait           = true
Config.BlipOnBaitAnimal     = true
Config.BaitPlacingTime      = 15000     -- milliseconds
Config.BaitItemName         = "huntingbait"
Config.BaitAnimals          = {"a_c_deer", "a_c_boar", "a_c_mtlion", "a_c_coyote"}  -- animal that can spawn when placing a bait (need to be also in Config.Animals)
Config.TimeForAnimalToLeave = 10000     -- animal once reached bait will wait this time before walking away milliseconds
Config.BaitSpawnRadious     = 30        -- when you place a bait, the animal will spawn in this radious (I raccomend 200) 
Config.TimeBetween          = 120       -- IN SECONDS, time you need to wait before placing another bait


-- [ANIMALS / WEAPONS]:
    -- MODEL: the model of animal you want to spawn / hunt 
    -- BAD/GOOD/PERFECT: the item dropped when harvesting that animal
    -- DIMENSION: size of the animal, you need this with Config.WeaponDamages

Config.Animals = {
    {dimension = "big", model = "a_c_deer", bad = "leatherdeer1", badCost = 100, good = "leatherdeer2", goodCost = 420, perfect = "leatherdeer3", perfectCost = 890, hash = -664053099, specialItem = "deer_horn", specialItemCost = 630, isIllegal = false, badmeat = "huntingcarcass1", goodmeat = "huntingcarcass2", perfectmeat = "huntingcarcass3"},
    {dimension = "medBig", model = "a_c_boar", bad = "leatherboard1", badCost = 100, good = "leatherboard2", goodCost = 420, perfect = "leatherboard3", perfectCost = 890, hash = -832573324, specialItem = "", specialItemCost = 0, isIllegal = false, badmeat = "huntingcarcass1", goodmeat = "huntingcarcass2", perfectmeat = "huntingcarcass2"},
    {dimension = "medBig", model = "a_c_mtlion", bad = "leathermtlion1", badCost = 100, good = "leathermtlion2", goodCost = 420, perfect = "leathermtlion3", perfectCost = 890, hash = 307287994, specialItem = "", specialItemCost = 0, isIllegal = true, illegalBadCost = 50, illegalGoodCost = 190, illegalPerfectCost = 430, badmeat = "huntingcarcass1", goodmeat = "huntingcarcass2", perfectmeat = "huntingcarcass2"},
    {dimension = "medium", model = "a_c_coyote", bad = "leathercoyote1", badCost = 100, good = "leathercoyote2", goodCost = 420, perfect = "leathercoyote3", perfectCost = 890, hash = 1682622302, specialItem = "", specialItemCost = 0, isIllegal = true, illegalBadCost = 50, illegalGoodCost = 190, illegalPerfectCost = 430, badmeat = "huntingcarcass1", goodmeat = "huntingcarcass1", perfectmeat = "huntingcarcass1"},
    {dimension = "small", model = "a_c_rabbit_01", bad = "leatherrabbit1", badCost = 100, good = "leatherrabbit2", goodCost = 420, perfect = "leatherrabbit3", perfectCost = 890, hash = -541762431, specialItem = "", specialItemCost = 0, isIllegal = false, badmeat = "huntingcarcass1", goodmeat = "huntingcarcass1", perfectmeat = "huntingcarcass1"},
    {dimension = "medium", model = "a_c_cormorant", bad = "leathercormorant1", badCost = 100, good = "leathercormorant2", goodCost = 420, perfect = "leathercormorant3", perfectCost = 890, hash = 1457690978, specialItem = "", specialItemCost = 0, isIllegal = true, illegalBadCost = 50, illegalGoodCost = 190, illegalPerfectCost = 430, badmeat = "huntingcarcass1", goodmeat = "huntingcarcass1", perfectmeat = "huntingcarcass1"},
    {dimension = "small", model = "a_c_chickenhawk", bad = "leather_chickenhawk_bad", badCost = 100, good = "leather_chickenhawk_good", goodCost = 420, perfect = "leather_chickenhawk_perfect", perfectCost = 890, hash = -1430839454, specialItem = "", specialItemCost = 0, isIllegal = true, illegalBadCost = 50, illegalGoodCost = 190, illegalPerfectCost = 430, badmeat = "huntingcarcass1", goodmeat = "huntingcarcass1", perfectmeat = "huntingcarcass1" },
	-- {dimension = "medium", model = "a_c_panther", bad = "leathermtlion1", badCost = 100, good = "leathermtlion2", goodCost = 420, perfect = "leathermtlion3", perfectCost = 890, hash = 307287994, specialItem = "", specialItemCost = 0, isIllegal = true, illegalBadCost = 50, illegalGoodCost = 190, illegalPerfectCost = 430, badmeat = "huntingcarcass1", goodmeat = "huntingcarcass2", perfectmeat = "huntingcarcass2"}
	-- {dimension = "medium", model = "a_c_panther", bad = "leather_chickenhawk_bad", badCost = 100, good = "leather_chickenhawk_good", goodCost = 420, perfect = "leather_chickenhawk_perfect", perfectCost = 890, hash = -1430839454, specialItem = "", specialItemCost = 0, isIllegal = true, illegalBadCost = 50, illegalGoodCost = 190, illegalPerfectCost = 430}
}   -- IMPORTANT: dimension name must be one of these "small" / "medium" / "medBig" / "big"
    -- IMPORTANT: you don't have to change hash numbers
    -- IMPORTANT: you need to have bad / good / perfect items in your items database

Config.WeaponDamages = {
    -- According to the type of weapon (category) used to kill the animal, it will drop a certain type of skin based on his size (Config.Animals dimension)
    -- EXAMPLE: if i kill with a sniper a big animal in this case it will give me perfect item
    {category = "unarmed", small = "bad", medium = "bad", medBig = "bad", big = "bad", smallmeat = "badmeat", mediummeat = "goodmeat", medBigmeat = "perfectmeat", bigmeat = "perfectmeat"},
    {category = "melee", small = "bad", medium = "bad", medBig = "bad", big = "bad", smallmeat = "badmeat", mediummeat = "goodmeat", medBigmeat = "perfectmeat", bigmeat = "perfectmeat"},
    {category = "pistol", small = "good", medium = "good", medBig = "bad", big = "bad", smallmeat = "badmeat", mediummeat = "goodmeat", medBigmeat = "perfectmeat", bigmeat = "perfectmeat"},
    {category = "subgun", small = "bad", medium = "bad", medBig = "good", big = "bad", smallmeat = "badmeat", mediummeat = "goodmeat", medBigmeat = "perfectmeat", bigmeat = "perfectmeat"},
    {category = "shootgun", small = "bad", medium = "bad", medBig = "good", big = "bad", smallmeat = "badmeat", mediummeat = "goodmeat", medBigmeat = "perfectmeat", bigmeat = "perfectmeat"},
    {category = "rifle", small = "bad", medium = "bad", medBig = "bad", big = "bad", smallmeat = "badmeat", mediummeat = "goodmeat", medBigmeat = "perfectmeat", bigmeat = "perfectmeat"},
    {category = "snip", small = "bad", medium = "good", medBig = "perfect", big = "perfect", smallmeat = "badmeat", mediummeat = "goodmeat", medBigmeat = "perfectmeat", bigmeat = "perfectmeat"}
}   -- IMPORTANT: you don't have to change category names

Config.NativeAnimal      = false   -- false if you want to spawn your animals (modify AnimalModels) and not use native ones
Config.SpawnAnimalNumber = 10     -- number of animal to spawn if you aren't using native animals
Config.KnifesForHarvest  = {'WEAPON_KNIFE', 'WEAPON_SWITCHBLADE', 'WEAPON_DAGGER'}  -- you can harvest an animal only with these knifes


-- [HUNTING ZONES]:
Config.huntAllMap  = true   -- true if you want to enable hunting in all the map
Config.huntPoint   = {
    {x = -1133.44, y = 4605.55, z = 144.96},
	{x = 2226.2229, y = 1942.3349, z = 110.3809},
	{x = -1830.35, y = 2224.5942, z = 84.632415},
	{x = -2388.623, y = 2439.8422, z = 2.6139578},
    { x = 1996.02, y = 4982.71, z = 40.63}
	
}   -- if Config.huntAllMap false you have to decide a point in the map and the radious where you can hunt
Config.huntRadious = 700


-- [CAMPFIRE]:
Config.EnableCampfire       = true
Config.CampfireCommand      = "campfire" -- don't put the slash before
Config.CampfireProp         = "prop_beach_fire" -- name for the prop to spawn
Config.CampfireNameItem1    = "coal"     -- name for item1 in crafting
Config.CampfireCountItem1   = 2          -- number of pieces you need for item1
Config.CampfireNameItem2    = "wood"     -- name for item2 in crafting
Config.CampfireCountItem2   = 4          -- number of pieces you need for item2
Config.CampPlacingTime      = 15000      -- milliseconds
Config.KeyCampfireMenu      = "E"        -- ["E"]
Config.MeatName             = "meat"     
Config.CookingTime          = 20000      -- milliseconds
Config.CookedMeatName       = "cookedMeat"
Config.KeyDestroyCampfire   = "G"        -- ["G"]
Config.noCampfireZoneRadious = 1000
Config.noCampfireZone       = {
    {x = -259.24, y = -1900.51, z = 27.76}
}   --you can add multiple of them (remember ",")


-- [SELLING ITEMS]:
Config.MeatCost = 20
-- see also Config.Animals for prices


-- [BLIPS]:
Config.BlipOnEntity = true  -- if not using native animals 
Config.Blips = {
    {coords = vector3(-1133.44, 4605.55, 144.96), name = "Hunting", sprite = 161, colour = 27},
    {coords = vector3(-1133.44, 4605.55, 144.96), name = "Hunting Zone", sprite = 442, colour = 27}
}


-- [LOCATIONS]:
Config.Locations = {
    SellZone = { x = 1225.43, y = -3246.84, z = 4.55 },
    IllegalNPC = { x = 1996.02, y = 4982.71, z = 40.63, h = 219.41}
}


-- [LANGUAGE]:
Config.Text = {
    ['before_harvest']   = 'Nhấn [~g~E~w~] để thu hoạch',
    ['need_knife']       = 'Cần dao để thực hiện điều này',
    ['receved_leather']  = 'Bạn nhận được da',
	['ruined_leather']   = 'Bộ da đã hư hại quá nặng. Không thể lấy',
	['receved_meat']     = 'Nhận được thịt',
	['special_item']     = 'May mắn nhận được thêm đồ',
    ----
    ['campfire']         = 'Nhấn [~g~E~w~] để nấu, [~g~G~w~] để Xoá',
    ['cooking']          = 'Cooking meat',
    ['placing_campfire'] = 'Placing campfire...',
    ['cant_place_camp']  = "You can't place your campfire here",
    ----
    ['cant_place_bait']  = "Không thể đặt mồi săn ở đây",
    ['placing_bait']     = 'Placing bait...',
    ['between_bait']     = 'You need to wait before use it again',
	['no_effects_bait']  = 'Your bait had any effects',
    ----
    ['sell_items']       = 'Press [~g~E~w~] to sell',
	['sold']             = 'Successfully sold',
	----
	['no_material']      = "You don't have enough material",
    ['you_didnt_kill_it'] = "Bạn không phải là người giết"
}