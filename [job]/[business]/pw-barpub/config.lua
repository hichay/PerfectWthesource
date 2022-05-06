Config = {}

--v1.0


--Main
Config.Locale = 'en'
Config.ItemTester = 'alcotester' -- Item for alcohol tester
Config.Status = true -- if you use esx_status, type true and for food and drink you can set how much it will gain when you bite into the food
-- if you have Config.Status = true then turn off esx_basicneeds
Config.EnableNightclubs           = true    -- If true spawn Nightclub NPCs (Need a IPL Loader https://github.com/Bob74/bob74_ipl or other) (After Hours DLC)
Config.EnableSolomun = true
Config.EnableDixon = true
Config.Locations = {
    --[[ ["exit"] = {x = 945.13, y = -975.84, z = 39.49, h = 181.5, r = 1.0}, ]]
    ["blip"] = {x = 127.79933, y = -1297.17, z = 29.269281, h = 6.1376714, r = 1.0},
    ["buyitem"] = {x = 129.29827, y = -1280.959, z = 29.269294, h = 6.1376714, r = 1.0},

}

------------------------------------NIGHTCLUBS-------------------------------------
Config.Locations2 = { -- Nightclub Girls1 nhún
	{ x = 107.719273,   y = -1290.962, z = 28.249687, heading = 218.13182 },	-- NClub1
	{ x = 106.71478,   y = -1288.913, z = 28.249687, heading = 34.423637 }	-- NClub2
}
Config.Locations3 = { -- Nightclub Girls Cheering nhảy
	{ x = 108.48113,   y = -1289.746, z = 28.249711, heading = 296.48498 }	-- NClub1
}
Config.Locations4 = { -- Nightclub Girls Partying nhảy 2
	{ x = 101.63103,   y = -1290.095, z = 28.249713, heading = 300.6759 },	-- NClub1
	{ x = 104.17943,   y = 104.17943, z = 103.17943, heading = 104.17943 }	-- NClub2
}

Config.Locations5 = { -- Nightclub Girls Slow
	{ x = 115.83251,   y = -1283.729, z = 26.265092, heading = 176.14201 }	-- NClub1
}
Config.Locations6 = { -- Nightclub Girls Tops
	{ x = 119.15851,   y = -1288.44, z = 27.260145, heading = 13.578731 }	-- NCTop1
}
Config.Locations10 = { -- Nightclub Bartender
	{ x = 129.68246,   y = -1283.7, z = 28.269273, heading = 115.65909 },	-- NClub1
	{ x = 130.07611,   y = -1282.309, z = 28.269273, heading = 296.1723 }	-- NClub2
}

Config.Locations11 = { -- Nightclub Guards
	{ x = 130.3587,   y = -1297.973, z = 28.232744, heading = 215.12419 },	-- NClub1
	{ x = 127.45598,   y = -1299.608, z = 28.232744, heading = 207.99708 },	-- NClub2
	{ x = 106.76937,   y = -1282.787, z = 27.260145, heading = 207.28186 },	-- NClub3
	{ x = 113.04427,   y = -1293.364, z = 27.26015, heading = 44.131195 },	-- NClub4
	{ x = 96.004653,   y = -1283.711, z = 28.263601, heading = 37.411609 },	-- NClub5
	{ x = 102.26366,   y = -1295.767, z = 27.768901, heading = 117.02617 }	-- NCWelcome
	}
Config.Locations12 = { -- Nightclub Solomun
	{ x = 120.79547,   y = -1281.913, z = 28.480361, heading = 217.69667 }	-- NCSolomun
}

--[[ --Food
Config.EatButton = 38
Config.FoodThrow = 105
Config.ServeFood = 10
Config.FoodSmallRemove = {min = 17, max = 30} -- this is a random removal of g when biting into food below 100 g
Config.FoodBigRemove = {min = 30, max = 50} -- this is an accidental removal of g when biting into food over 100 g ]]

--[[ Config.Food = {
    {Item = "burger",  Label = 'Hamburger', g = 220, Prop = "prop_cs_burger_01", StatusHunger = 50000, Pos1 = 0.13, Pos2 = 0.05, Pos3 = 0.02, Pos4 = -50.0, Pos5 = 16.0, Pos6 = 60.0}, --G this is grams
    {Item = "chaser",  Label = 'Chaser Choco Bar', g = 70, Prop = "prop_choc_ego", StatusHunger = 50000, Pos1 = 0.13, Pos2 = 0.05, Pos3 = 0.02, Pos4 = 50.0, Pos5 = 30.0, Pos6 = 260.0},
    {Item = "meteorite", Label = 'Meteorite Choco Bar', g = 80, Prop = "prop_choc_meto", StatusHunger = 50000, Pos1 = 0.13, Pos2 = 0.05, Pos3 = 0.02, Pos4 = 50.0, Pos5 = 30.0, Pos6 = 260.0},
    {Item = "hotdog",  Label = 'Hotdog', g = 120, Prop = "prop_cs_hotdog_01", StatusHunger = 50000, Pos1 = 0.13, Pos2 = 0.05, Pos3 = 0.02, Pos4 = 0.0, Pos5 = -140.0, Pos6 = -140.0},
    {Item = "taco",  Label = 'Taco', g = 180, Prop = "prop_taco_01", StatusHunger = 50000, Pos1 = 0.13, Pos2 = 0.05, Pos3 = 0.02, Pos4 = 0.0, Pos5 = -140.0, Pos6 = -140.0},
} ]]


-- Drink
Config.DrinkingButton = 38
Config.DrinkThrowButton = 105
Config.ServeDrink = 10
Config.SplitDrinkButton = 317
Config.CleanUpItem = 317
Config.DrinkSmallRemove = {min = 15, max = 30} -- it is an accidental removal of ml when drinking below 100 ml
Config.DrinkBigRemove = {min = 35, max = 80} -- it is an accidental removal of ml when drinking above 100 ml


Config.Drink = {
    -- ITEM = spawn code -- CleanUpItem = This is an item that you get after inserting the shot into the inventory -- ml = item content -- prop = the code of the item you are holding in your hands -- StatusDrink = this is for esx_status
   -- thirst is added after each click of the Drink button -- Alcohol = How much effect is added after one click on the Drink button -- Shots = true if you want to pour shots from the bottle -- pos = prop position
    --[[ {Item = "piswasser",  CleanUpItem = '', ml = 500, Prop = "prop_amb_beer_bottle", Alcohol = 0.0359949, Shots = false , Pos1 = 0.0, Pos2 = -0.02, Pos3 = -0.01, Pos4 = 18.0, Pos5 = -10.0, Pos6 = 0.0},

    
     
    {Item = "nogo_vodka",  CleanUpItem = 'shot_nogo_vodka', ml = 500, Prop = "prop_vodka_bottle", Alcohol = 0.0859949, Shots = true, Pos1 = 0.0, Pos2 = -0.02, Pos3 = -0.28, Pos4 = 0.2, Pos5 = -06.0, Pos6 = 0.0},

    {Item = "raine",  CleanUpItem = '', ml = 250, Prop = "ba_prop_club_water_bottle", Alcohol = 0.0, Shots = false, Pos1 = 0.02, Pos2 = -0.01, Pos3 = -0.14, Pos4 = 0.2, Pos5 = -06.0, Pos6 = 0.0},

    {Item = "bean_machine_coffe",  CleanUpItem = '', ml = 250, Prop = "p_ing_coffeecup_01", Alcohol = 0.0, Shots = false, Pos1 = 0.0, Pos2 = -0.01, Pos3 = -0.02, Pos4 = 05.0, Pos5 = -10.0, Pos6 = 0.0},



    {Item = "bmary",  CleanUpItem = '', ml = 100, Prop = "prop_cocktail", Alcohol = 0.0, Shots = false, Pos1 = 0.0, Pos2 = -0.01, Pos3 = -0.02, Pos4 = 05.0, Pos5 = -10.0, Pos6 = 0.0},
 ]]
 

    {Item = "tequila",  CleanUpItem = 'tequilashot', ml = 500, Prop = "prop_tequila_bottle", Alcohol = 0.1959949, Shots = true, Pos1 = 0.0, Pos2 = -0.02, Pos3 = -0.23, Pos4 = 0.2, Pos5 = -06.0, Pos6 = 0.0, shotProp = "prop_tequila", shotP1 = 0.1, shotP2 = -0.07, shotP3 = 0.03, shotP4 = -100.0, shotP5 = 0.0, shotP6 = 0.0 },

    {Item = "whiskey",  CleanUpItem = 'wglass', ml = 500, Prop = "prop_whiskey_bottle", Alcohol = 0.0759949, Shots = true, Pos1 = 0.0, Pos2 = -0.02, Pos3 = -0.17, Pos4 = 0.2, Pos5 = -06.0, Pos6 = 0.0, shotProp = "p_cs_shot_glass_s", shotP1 = 0.11, shotP2 = 0.03, shotP3 = 0.02, shotP4 = 250.0, shotP5 = 0.0, shotP6 = 0.0},
    
    {Item = "cabsinthe",  CleanUpItem = '', ml = 500, Prop = "prop_wine_bot_01", Alcohol = 0.0759949, Shots = true, Pos1 = 0.0, Pos2 = -0.02, Pos3 = -0.27, Pos4 = 0.2, Pos5 = -06.0, Pos6 = 0.0, shotProp = "p_cs_shot_glass_s", shotP1 = 0.11, shotP2 = 0.03, shotP3 = 0.02, shotP4 = 250.0, shotP5 = 0.0, shotP6 = 0.0},

    {Item = "logger",  CleanUpItem = 'wglass', ml = 200, Prop = "prop_beer_logger", Alcohol = 0.0759949, Shots = false, Pos1 = 0.0, Pos2 = -0.02, Pos3 = -0.17, Pos4 = 0.2, Pos5 = -06.0, Pos6 = 0.0, shotProp = "p_cs_shot_glass_s", shotP1 = 0.11, shotP2 = 0.03, shotP3 = 0.02, shotP4 = 250.0, shotP5 = 0.0, shotP6 = 0.0},

    {Item = "rum",  CleanUpItem = '', ml = 200, Prop = "prop_rum_bottle", Alcohol = 0.0759949, Shots = true, Pos1 = 0.0, Pos2 = -0.02, Pos3 = -0.17, Pos4 = 0.2, Pos5 = -06.0, Pos6 = 0.0, shotProp = "p_cs_shot_glass_s", shotP1 = 0.11, shotP2 = 0.03, shotP3 = 0.02, shotP4 = 250.0, shotP5 = 0.0, shotP6 = 0.0},

    {Item = "sake",  CleanUpItem = '', ml = 200, Prop = "p_cs_bottle_01", Alcohol = 0.0759949, Shots = true, Pos1 = 0.0, Pos2 = -0.02, Pos3 = -0.05, Pos4 = 0.2, Pos5 = -06.0, Pos6 = 0.0, shotProp = "prop_shot_glass", shotP1 = 0.11, shotP2 = -0.01, shotP3 = 0.02, shotP4 = 250.0, shotP5 = 0.0, shotP6 = 0.0},

    {Item = "brandy",  CleanUpItem = '', ml = 500, Prop = "prop_bottle_brandy", Alcohol = 0.0759949, Shots = true, Pos1 = 0.0, Pos2 = -0.02, Pos3 = -0.24, Pos4 = 0.2, Pos5 = -06.0, Pos6 = 0.0, shotProp = "prop_brandy_glass", shotP1 = 0.11, shotP2 = -  0.03, shotP3 = 0.02, shotP4 = 250.0, shotP5 = 0.0, shotP6 = 0.0},

    {Item = "cognac",  CleanUpItem = '', ml = 500, Prop = "prop_bottle_cognac", Alcohol = 0.0759949, Shots = true, Pos1 = 0.0, Pos2 = -0.02, Pos3 = -0.25, Pos4 = 0.2, Pos5 = -06.0, Pos6 = 0.0, shotProp = "p_cs_shot_glass_s", shotP1 = 0.11, shotP2 = 0.03, shotP3 = 0.02, shotP4 = 250.0, shotP5 = 0.0, shotP6 = 0.0},

    {Item = "richardhennessy",  CleanUpItem = '', ml = 500, Prop = "prop_bottle_richard", Alcohol = 0.0759949, Shots = true, Pos1 = 0.0, Pos2 = -0.02, Pos3 = -0.30, Pos4 = 0.2, Pos5 = -06.0, Pos6 = 0.0, shotProp = "p_cs_shot_glass_s", shotP1 = 0.11, shotP2 = 0.03, shotP3 = 0.02, shotP4 = 250.0, shotP5 = 0.0, shotP6 = 0.0},

}

--SHOTS
Config.DrinkShot = { --we recommend leaving 30 ml for a shot
    --[[ {Item = "wglass",  Label = 'Ly rượu whiskey', mlshot = 30, Alcohol = 0.0759949},

    {Item = "shot_nogo_vodka",  Label = 'Panak Nogo Vodka', mlshot = 30, Alcohol = 0.0859949}, ]]
    
    {Item = "tequilashot", mlshot = 30, Prop = "prop_tequila", Alcohol = 0.09, Pos1 = 0.1, Pos2 = -0.07, Pos3 = 0.03, Pos4 = -100.0, Pos5 = 0.0, Pos6 = 0.0},

    {Item = "wglass", mlshot = 30, Prop = "p_cs_shot_glass_s", Alcohol = 0.11, Pos1 = 0.1, Pos2 = 0.03, Pos3 = 0.02, Pos4 = 250.0, Pos5 = 0.0, Pos6 = 0.0},

    {Item = "martini", mlshot = 150, Prop = "prop_cocktail_glass", Alcohol = 0.11, Pos1 = 0.1, Pos2 = -0.07, Pos3 = 0.03, Pos4 = -100.0, Pos5 = 0.0, Pos6 = 0.0},

    {Item = "bglass", mlshot = 60, Prop = "prop_cocktail", Alcohol = 0.0, Pos1 = 0.15, Pos2 = -0.00, Pos3 = 0.08, Pos4 = -75.0, Pos5 = 130.0, Pos6 = 0.0},

    {Item = "bmary", mlshot = 90, Prop = "v_serv_bs_mug", Alcohol = 0.0, Pos1 = 0.13, Pos2 = -0.01, Pos3 = -0.02, Pos4 = 05.0, Pos5 = -10.0, Pos6 = 0.0},

    {Item = "mugbeer", mlshot = 150, Prop = "prop_mug_04", Alcohol = 0.0, Pos1 = 0.15, Pos2 = -0.00, Pos3 = 0.08, Pos4 = -75.0, Pos5 = 130.0, Pos6 = 0.0},

    {Item = "pinacolada", mlshot = 150, Prop = "prop_cocktail_glass", Alcohol = 0.10, Pos1 = 0.1, Pos2 = -0.07, Pos3 = 0.03, Pos4 = -100.0, Pos5 = 0.0, Pos6 = 0.0},
    
    {Item = "polarbear", mlshot = 150, Prop = "prop_cocktail_glass", Alcohol = 0.09, Pos1 = 0.1, Pos2 = -0.07, Pos3 = 0.03, Pos4 = -100.0, Pos5 = 0.0, Pos6 = 0.0},

    {Item = "rumcoke", mlshot = 150, Prop = "prop_pint_glass_01", Alcohol = 0.10, Pos1 = 0.1, Pos2 = -0.05, Pos3 = 0.05, Pos4 = 250.0, Pos5 = 0.0, Pos6 = 0.0},

    {Item = "planterpunch", mlshot = 150, Prop = "prop_cocktail_glass", Alcohol = 0.12, Pos1 = 0.1, Pos2 = -0.07, Pos3 = 0.03, Pos4 = -100.0, Pos5 = 0.0, Pos6 = 0.0},

    {Item = "aperolspritz", mlshot = 150, Prop = "prop_cocktail_glass", Alcohol = 0.12, Pos1 = 0.1, Pos2 = -0.07, Pos3 = 0.03, Pos4 = -100.0, Pos5 = 0.0, Pos6 = 0.0},

    {Item = "sazerac", mlshot = 150, Prop = "prop_cocktail_glass", Alcohol = 0.12, Pos1 = 0.1, Pos2 = -0.07, Pos3 = 0.03, Pos4 = -100.0, Pos5 = 0.0, Pos6 = 0.0},
    
    {Item = "penicillin", mlshot = 150, Prop = "prop_cocktail_glass", Alcohol = 0.12, Pos1 = 0.1, Pos2 = -0.07, Pos3 = 0.03, Pos4 = -100.0, Pos5 = 0.0, Pos6 = 0.0},

    {Item = "vieuxcarre", mlshot = 150, Prop = "prop_cocktail_glass", Alcohol = 0.12, Pos1 = 0.1, Pos2 = -0.07, Pos3 = 0.03, Pos4 = -100.0, Pos5 = 0.0, Pos6 = 0.0},
    
    {Item = "magarita", mlshot = 150, Prop = "prop_cocktail_glass", Alcohol = 0.12, Pos1 = 0.1, Pos2 = -0.07, Pos3 = 0.03, Pos4 = -100.0, Pos5 = 0.0, Pos6 = 0.0},

}


--WINE
Config.Wine = {
    {Item = "redwine",  CleanUpItem = 'wineglass', ml = 500, Prop = "prop_wine_bot_01", Alcohol = 0.0759949, Pos1 = 0.02, Pos2 = -0.009, Pos3 = -0.26, Pos4 = 05.0, Pos5 = -10.0, Pos6 = 25.0, shotProp = "p_wine_glass_s", shotP1 = 0.11, shotP2 = -0.03, shotP3 = 0.03, shotP4 = 250.0, shotP5 = 0.0, shotP6 = 0.0},

    {Item = "whitewine",  CleanUpItem = 'glass_rockford_hill', ml = 500, Prop = "prop_wine_bot_02", Alcohol = 0.0759949, Pos1 = 0.0, Pos2 = -0.01, Pos3 = -0.28, Pos4 = 0.2, Pos5 = -03.0, Pos6 = 0.0, shotProp = "prop_drink_whtwine", shotP1 = 0.11, shotP2 = -0.03, shotP3 = 0.03, shotP4 = 250.0, shotP5 = 0.0, shotP6 = 0.0},
     
    {Item = "champagne",  CleanUpItem = 'glass_rockford_hill', ml = 500, Prop = "prop_champ_01b", Alcohol = 0.0759949, Pos1 = 0.0, Pos2 = -0.01, Pos3 = -0.28, Pos4 = 0.2, Pos5 = -03.0, Pos6 = 0.0, shotProp = "prop_drink_champ", shotP1 = 0.11, shotP2 = -0.05, shotP3 = 0.03, shotP4 = 250.0, shotP5 = 0.0, shotP6 = 0.0},

    --[[ {Item = "vinewood_blanc",  CleanUpItem = 'glass_vinewood_blanc', ml = 500, Prop = "prop_wine_white", Alcohol = 0.0759949, Pos1 = 0.0, Pos2 = -0.02, Pos3 = -0.28, Pos4 = 0.2, Pos5 = -03.0, Pos6 = 0.0}, ]]

}

Config.WineGlass = { --we recommend leaving 100 ml for a wine glass
    {Item = "wineglass",  Label = 'Ly rượu vang đỏ', mlwine = 50, Alcohol = 0.0759949},

    {Item = "glass_rockford_hill",  Label = 'Glass Rockford Hill Reserve', mlwine = 100, Alcohol = 0.0759949},
     
    {Item = "glass_vinewood_red",  Label = 'Glass Vinewood Red Zinfadel', mlwine = 100, Alcohol = 0.0759949},

    {Item = "glass_vinewood_blanc",  Label = 'Glass Vinewood Sauvignon Blanc', mlwine = 100, Alcohol = 0.0759949},
}