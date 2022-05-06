Config = {}

Config.UseESX = true --If you are not using ESX, edit the functions in the customise_me.lua's.
Config.ESXTrigger = 'esx:getSharedObject' --You can change this trigger for ESX.
Config.Language = 'EN' --EN / FR / EN / CZ / PT. (You can add your own locales to the Locales.lua. but make sure to add it here).
Config.ServerNotification_Type = 'esx' --chat / mythic_old / mythic_new / esx / custom.
Config.ClientNotification_Type = 'esx' --chat / mythic_old / mythic_new / esx / custom.

Config.GarageTax = true --Vehicle tax system, if enabled you can customise this config.
Config.GarageTaxDefault = 200 --The default value for the vehicle class multipler to multiply againt.

Config.UseDatabasePrices = true --If enabled, this will grab all the prices of each car to display when using the inside garage is you use the 'vehicles' table in the database.
Config.UniqueGarages = true --If enabled, you will only be able to get your car from the garage you last put it in.
Config.BlipNames = true --If enabled, each garage will be names by its unique id, for example: 'Garage A'. But if disabled all garages will be called 'Garage'.

Config.UseImpound = false --If enabled, you will be able to use the in built impound system.
Config.ImpoundTime = 10 --How long it takes to impound a vehicle. (in seconds).
Config.AnyoneCanImpound = false --If enabled, anyone can go to the impound and pay a set fee (CivImpoundFee), to get their vehicle out of the impound.
Config.CivImpoundFee = 1000 --^^^
Config.AllowedJobsImpound = { --Only jobs inside this table can impound vehicles or unimpound vehicles.
    ['police'] = true,
}
Config.ImpoundCommand = 'impound' --Customise the chat command to impound vehicles.

Config.UseTransferVehicle = true --If enabled, you will be able to use the in built command to transfer vehicles to another player.
Config.TransferVehicleCommand = 'transfervehicle' --Customise the chat command to transfer vehicles.

Config.UseMileage = true --If enabled, this will use the in built vehicle mileage system, the higher the miles the lower the vehicles max health will be.
Config.MileageMultiplier = 1.0 --Increase this number to increase how fast vehicles gain miles.
Config.SpeedMetrics = 'kilometers' --(miles/kilometers) Choose what you want the mileage to display as.
Config.ShowMaxHealth = true --If enabled, when using the check miles command it will show the max health too.
Config.CheckMilesCommand = 'checkmiles' --Customise the chat command to check your vehicles miles and max health.

Config.UseGarageSpace = true --If enabled, you will be able to limit the amount of cars each player can hold.
Config.GarageSpace = { --If Config.UseGarageSpace is enabled, this is the max amount of cars each player can own. To allow people to own more vehicles, add to the table.
    [1] = 10000,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
    [7] = 0,
    [8] = 25000,
    [9] = 50000,
    [10] = 75000,
    --[11] = 100000, --The number 11 would be the 11th garage slot, and the 100000 number would be the price for the 11th garage slot.
}
Config.GarageSpaceJobs = { --Only jobs inside this table can sell extra garage slots to players.
    ['police'] = true,
}
Config.GarageSpaceCommand = 'garagespace' --Customise the chat command to purchase extra garage space.

Config.MaxVehiclesInsideGarage = 10 --This is the max number of vehicles that we allow into the inside garage (we are limited by space inside the garage).
Config.ReturnVehiclePrice = 500 --This is the price to pay for your vehicle to be returned to your garage if you have taken it out but it despawned or got destroyed.
Config.Shell_Zaxis = math.random(10,50) --This is how low under the ground the garage shell will spawn, you could use math.random(10,50) to make it random each time so players dont see each other in their garage.
Config.QuickChoose_Key = 38 --The key to open the quick garage. (default E).
Config.EnterGarage_Key = 74 --The key to open the inside garage. (default H).
Config.SaveCarHealth = true --If enabled, the garage will save the poped tires and broken doors and re-apply them all when spawning a vehicle.




Config.ShellTimeScript = 'vsync' --Choose which time script you are using so we can set the time when you enter the shell. (easytime / vsync / other).
Config.EnginesOn = false --If enabled, the vehicles engine will be turned on when you enter the inside garage.
Config.LightsOn = false --If enabled, the vehicles headlights will be turned on when you enter the inside garage.
Config.UseSpotlight = true --If enabled, a spotlight will shine on the closest vehicle.
Config.InsideLoopWait = 100 --The wait timer of the loop to refresh the UI. (shorter times will be mor optimised client side but longer times means more delay when moving to the next car).
Config.Blacklisted_insidegarage = { --Vehicles inside this table will not be spawned inside the garage, this is used for large vehicles that will not fit.
    [GetHashKey('flatbed')] = true,
}


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--------------------------------------------- BLIPS --------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
Config.Blip = {
    ['car'] = {
        sprite = 357, --Icon of the blip.
        scale = 0.6, --Size of the blip.
        colour = 9, --Colour of the blip.
        name = Locales[Config.Language]['garage']..' ' --You dont need to change this.
    },

    ['boat'] = {
        sprite = 357,
        scale = 0.6,
        colour = 9,
        name = Locales[Config.Language]['harbor']..' '
    },

    ['air'] = {
        sprite = 357,
        scale = 0.6,
        colour = 9,
        name = Locales[Config.Language]['hangar']..' '
    },
}


Config.Locations = {
    -- {
        -- Garage_ID = 'A', --LEGION
        -- Type = 'car', --The type of vehicles which use this garage. (car/boat/air).
        -- Dist = 10, --The distance that you can use this garage.
        -- x_1 = 215.09, y_1 = -805.17, z_1 = 30.81, --This is the location of the garage, where you press e to open for example.
        -- EventName1 = 'cd_garage:QuickChoose', --DONT CHANGE THIS.
        -- EventName2 = 'cd_garage:EnterGarage', --DONT CHANGE THIS.
        -- Name = '<b>'..Locales[Config.Language]['garage']..'</b></p>'..Locales[Config.Language]['open_garage_1']..'</p>'..Locales[Config.Language]['open_garage_2'], --You dont need to change this.
        -- x_2 = 212.42, y_2 = -798.77, z_2 = 30.88, h_2 = 336.61, --This is the location where the vehicle spawns.
    -- },
    
    -- {
        -- Garage_ID = 'B', --PINK MOTEL
        -- Type = 'car',
        -- Dist = 10,
        -- x_1 = 273.0, y_1 = -343.85, z_1 = 44.91,
        -- EventName1 = 'cd_garage:QuickChoose',
        -- EventName2 = 'cd_garage:EnterGarage',
        -- Name = '<b>'..Locales[Config.Language]['garage']..'</b></p>'..Locales[Config.Language]['open_garage_1']..'</p>'..Locales[Config.Language]['open_garage_2'],
        -- x_2 = 270.75, y_2 = -340.51, z_2 = 44.92, h_2 = 342.03,
    -- },

    {
        Garage_ID = '1', --GROVE
        Type = 'car',
        Dist = 10,
        x_1 = -71.46, y_1 = -1821.83, z_1 = 26.94,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = '<b>'..Locales[Config.Language]['garage']..'</b></p>'..Locales[Config.Language]['open_garage_1']..'</p>'..Locales[Config.Language]['open_garage_2'],
        x_2 = -66.51, y_2 = -1828.01, z_2 = 26.94, h_2 = 235.64,
    },

    {
        Garage_ID = '2', --MIRROR
        Type = 'car',
        Dist = 10,
        x_1 = 1032.84, y_1 = -765.1, z_1 = 58.18,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = '<b>'..Locales[Config.Language]['garage']..'</b></p>'..Locales[Config.Language]['open_garage_1']..'</p>'..Locales[Config.Language]['open_garage_2'],
        x_2 = 1023.2, y_2 = -764.27, z_2 = 57.96, h_2 = 319.66,
    },

    {
        Garage_ID = '3', --BEACH
        Type = 'car',
        Dist = 10,
        x_1 = -1248.69, y_1 = -1425.71, z_1 = 4.32,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = '<b>'..Locales[Config.Language]['garage']..'</b></p>'..Locales[Config.Language]['open_garage_1']..'</p>'..Locales[Config.Language]['open_garage_2'],
        x_2 = -1244.27, y_2 = -1422.08, z_2 = 4.32, h_2 = 37.12,
    },

    {
        Garage_ID = '4', --GO HIGHWAY
        Type = 'car',
        Dist = 10,
        x_1 = -2961.58, y_1 = 375.93, z_1 = 15.02,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = '<b>'..Locales[Config.Language]['garage']..'</b></p>'..Locales[Config.Language]['open_garage_1']..'</p>'..Locales[Config.Language]['open_garage_2'],
        x_2 = -2964.96, y_2 = 372.07, z_2 = 14.78, h_2 = 86.07,
    },

    {
        Garage_ID = '5', --SANDY WEST
        Type = 'car',
        Dist = 10,
        x_1 = 217.33, y_1 = 2605.65, z_1 = 46.04,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = '<b>'..Locales[Config.Language]['garage']..'</b></p>'..Locales[Config.Language]['open_garage_1']..'</p>'..Locales[Config.Language]['open_garage_2'],
        x_2 = 216.94, y_2 = 2608.44, z_2 = 46.33, h_2 = 14.07,
    },

    -- {
        -- Garage_ID = '6', --SANDY MAIN
        -- Type = 'car',
        -- Dist = 10,
        -- x_1 = 1878.44, y_1 = 3760.1, z_1 = 32.94,
        -- EventName1 = 'cd_garage:QuickChoose',
        -- EventName2 = 'cd_garage:EnterGarage',
        -- Name = '<b>'..Locales[Config.Language]['garage']..'</b></p>'..Locales[Config.Language]['open_garage_1']..'</p>'..Locales[Config.Language]['open_garage_2'],
        -- x_2 = 1880.14, y_2 = 3757.73, z_2 = 32.93, h_2 = 215.54,
    -- },

    -- {
        -- Garage_ID = '7', --VINEWOOD
        -- Type = 'car',
        -- Dist = 10,
        -- x_1 = 365.21, y_1 = 295.65, z_1 = 103.46,
        -- EventName1 = 'cd_garage:QuickChoose',
        -- EventName2 = 'cd_garage:EnterGarage',
        -- Name = '<b>'..Locales[Config.Language]['garage']..'</b></p>'..Locales[Config.Language]['open_garage_1']..'</p>'..Locales[Config.Language]['open_garage_2'],
        -- x_2 = 364.84, y_2 = 289.73, z_2 = 103.42, h_2 = 164.23,
    -- },

    -- {
        -- Garage_ID = '8', --GRAPESEED
        -- Type = 'car',
        -- Dist = 10,
        -- x_1 = 1713.06, y_1 = 4745.32, z_1 = 41.96,
        -- EventName1 = 'cd_garage:QuickChoose',
        -- EventName2 = 'cd_garage:EnterGarage',
        -- Name = '<b>'..Locales[Config.Language]['garage']..'</b></p>'..Locales[Config.Language]['open_garage_1']..'</p>'..Locales[Config.Language]['open_garage_2'],
        -- x_2 = 1710.64, y_2 = 4746.94, z_2 = 41.95, h_2 = 90.11,
    -- },

    -- {
        -- Garage_ID = '9', --PALETO
        -- Type = 'car',
        -- Dist = 10,
        -- x_1 = 107.32, y_1 = 6611.77, z_1 = 31.98,
        -- EventName1 = 'cd_garage:QuickChoose',
        -- EventName2 = 'cd_garage:EnterGarage',
        -- Name = '<b>'..Locales[Config.Language]['garage']..'</b></p>'..Locales[Config.Language]['open_garage_1']..'</p>'..Locales[Config.Language]['open_garage_2'],
        -- x_2 = 110.84, y_2 = 6607.82, z_2 = 31.86, h_2 = 265.28,
    -- },


    -- {   --THIS IS A BOAT GARAGE, YOU CAN REMOVE OR ADD NEW BOAT GARAGE IF YOU WISH.
        -- Garage_ID = 'A',
        -- Type = 'boat',
        -- Dist = 10,
        -- x_1 = -806.22, y_1 = -1496.7, z_1 = 1.6,
        -- EventName1 = 'cd_garage:QuickChoose',
        -- Name = '<b>'..Locales[Config.Language]['harbor']..'</b></p>'..Locales[Config.Language]['open_garage_3'],
        -- x_2 = -811.54, y_2 = -1509.42, z_2 = -0.47, h_2 = 130.14,
    -- },

    -- {   --THIS IS A AIR GARAGE, YOU CAN REMOVE OR ADD NEW AIR GARAGE IF YOU WISH.
        -- Garage_ID = 'A',
        -- Type = 'air',
        -- Dist = 10,
        -- x_1 = -982.55, y_1 = -2993.94, z_1 = 13.95,
        -- EventName1 = 'cd_garage:QuickChoose',
        -- Name = '<b>'..Locales[Config.Language]['hangar']..'</b></p>'..Locales[Config.Language]['open_garage_4'],
        -- x_2 = -989.59, y_2 = -3004.93, z_2 = 13.94, h_2 = 58.15
    -- },
}




Config.Impound = { --DO NOT CHANGE THE TABLE IDENTIFIERSs, for example - ['car_2'], if you wish to add more, then name the next one ['car_3']. It must have either car/boat/air in the name.
    ['car_1'] = {
        ImpoundID = 1, --The unique id of the impound.
        coords = {x = 401.28, y = -1631.44, z = 29.29}, --This is the location of the garage, where you press e to open for example.
        spawnpoint = {x = 404.66, y = -1642.03, z = 29.29, h = 225.5}, --This is the location where the vehicle spawns.
        blip = {
            sprite = 357, --Icon of the blip.
            scale = 0.5, --Size of the blip.
            colour = 3, --Colour of the blip.
            name = Locales[Config.Language]['car_city_impound'], --This can be changed in the Locales.
        }
    },

    ['car_2'] = { 
        ImpoundID = 2,
        coords = {x = 1893.48, y = 3713.50, z = 32.77},
        spawnpoint = {x = 1887.123, y = 3710.348, z = 31.92, h = 212.0},
        blip = {
            sprite = 357,
            scale = 0.5,
            colour = 3,
            name = Locales[Config.Language]['car_sandy_impound'],
        }
    },

    ['boat_1'] = {
        ImpoundID = 3,
        coords = {x = -848.8, y = -1368.42, z = 1.6},
        spawnpoint = {x = -848.4, y = -1362.8, z = -0.47, h = 113.0},
        blip = {
            sprite = 357,
            scale = 0.5,
            colour = 3,
            name = Locales[Config.Language]['boat_impound'],
        }
    },

    ['air_1'] = {
        ImpoundID = 4,
        coords = {x = -956.49, y = -2919.74, z = 13.96},
        spawnpoint = {x = -960.22, y = -2934.4, z = 13.95, h = 153.0},
        blip = {
            sprite = 357,
            scale = 0.5,
            colour = 3,
            name = Locales[Config.Language]['air_impound'],
        }
    },
}

Config.CarOffsets = { --This is the offsets of the vehicles inside the garage.
    [1] = {x = -4, y = 6.5, z = -99.43, h = 135.00},--1
    [2] = {x = -4, y = 10.8, z = -99.43, h = 135.00},--2
    [3] = {x = -4, y = 15.1, z = -99.43, h = 135.00},--3
    [4] = {x = -4, y = 19.4, z = -99.43, h = 135.00},--4
    [5] = {x = -4, y = 23.7, z = -99.42, h = 135.00},--5

    [6] = {x = -12, y = 23.7, z = -99.43, h = 225.00},--6
    [7] = {x = -12, y = 19.4, z = -99.42, h = 225.00},--7
    [8] = {x = -12, y = 15.1, z = -99.42, h = 225.00},--8
    [9] = {x = -12, y = 10.8, z = -99.43, h = 225.00},--9
    [10] = {x = -12, y = 6.5, z = -99.42, h = 225.00},--10
}

Config.Blasklist_transfer = { --Vehicles inside this table will not be able to be transfered to another player.
    --[GetHashKey("CHANGEME")] = true,
}

--These are disabled by default, until you enter your discord webhook.
Config.ExploitLogWebhook = 'FALSE' --If a player is found using cheat engine to change the hash of a vehicle, this will send a message on discord and kick thm from the game.
Config.ImpoundLogWebhook = 'FALSE' --When police impound/unimpound a vehicle it will send a message on discord.
Config.TransferVehicleLogWebhook = 'FALSE' --When a player transfered a vehicle to another player it will send a message on discord.




--VEHICLE TAX TABLE GUIDE.
--hash = Replace 'CHANGEME' with the vehicles spawn name.
--class = This is used for the inside vehicle UI to display its vehicle class.
--taxrate = This is number that is multiplied against the Config.GarageTaxDefault. 0.5 would be half of the default value and 2.0 would be double the default value.
Config.GarageTaxTable = {
    --Hyper
    {hash = GetHashKey("CHANGEME"), class = 'Hyper', taxrate  = 6},

    --Super
    {hash = GetHashKey("CHANGEME"), class = 'Super', taxrate  = 4},

    --Import
    {hash = GetHashKey("CHANGEME"), class = 'Import', taxrate  = 2},

    --Sports
    {hash = GetHashKey("CHANGEME"), class = 'Sports', taxrate  = 0.8},

    --Sedan
    {hash = GetHashKey("CHANGEME"), class = 'Sedan', taxrate  = 0.8},

    --Coupe
    {hash = GetHashKey("CHANGEME"), class = 'Coupe', taxrate  = 0.8},

    --Muscle
    {hash = GetHashKey("CHANGEME"), class = 'Muscle', taxrate  = 0.7},

    --Suv
    {hash = GetHashKey("CHANGEME"), class = 'Suv', taxrate  = 0.7},
    
    --SportsClassic
    {hash = GetHashKey("CHANGEME"), class = 'Sports Classic', taxrate  = 0.6},

    --Compact
    {hash = GetHashKey("CHANGEME"), class = 'Compact', taxrate  = 0.5},

    --Motorcycle
    {hash = GetHashKey("CHANGEME"), class = 'Motorcycle', taxrate  = 0.5},

    --Offroad
    {hash = GetHashKey("CHANGEME"), class = 'Offroad', taxrate  = 0.4},

    --Van
    {hash = GetHashKey("CHANGEME"), class = 'Van', taxrate  = 0.3},

    --Commercial
    {hash = GetHashKey("CHANGEME"), class = 'Commercial', taxrate  = 0.3},
}