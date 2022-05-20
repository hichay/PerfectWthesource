VehiclesConfig = {
    {   
        ["Job"] = "police",
        ["Label"] = "Xe cảnh",
        ["Garage"] = "MRPD",
        ["Spawn"] = {coords = vector3(435.95938, -976.0041, 25.699846) , heading = 88.65,},
        ["Vehicles"] = {
            { name = "Ford Crown Victoria", model = "npolvic", price = 5000, image = 'https://media.discordapp.net/attachments/974185293982879755/976746562367680523/Victor.png' },
            { name = "Ford Explorer", model = "npolexp", price = 5000, image = 'https://media.discordapp.net/attachments/974185293982879755/976746792878227516/Ford_Explore.png' },
            { name = "Ford Mustang", model = "npolstang", price = 5000, image = 'https://media.discordapp.net/attachments/974185293982879755/976746676364660786/Mustang.png' },
            { name = "Dodge Charger", model = "npolchar", price = 5000, image = 'https://media.discordapp.net/attachments/974185293982879755/976746817645609000/Dodge_Charger.png' },
            { name = "Dodge Challenger", model = "npolchal", price = 5000, image = 'https://media.discordapp.net/attachments/974185293982879755/976746851460071444/Dodge_Challenger.png' },
            { name = "Chevrolet Corvette", model = "npolvette", price = 5000, image = 'https://media.discordapp.net/attachments/974185293982879755/976746871492063242/Corvette.png' },
            { name = "MM (Moto)", model = "npolmm", price = 5000, image = 'https://media.discordapp.net/attachments/974185293982879755/976747095413362718/mm.png' },
            { name = "Charger 14", model = "v14charger", price = 5000, image = 'https://media.discordapp.net/attachments/974185293982879755/976746613529796608/v14Charger.png' },
            { name = "Ford Explorer 13", model = "v13explorer", price = 5000, image = 'https://media.discordapp.net/attachments/974185293982879755/976746644693475348/v13explorer.png' },
            { name = "Ford Explorer 16", model = "v16explorer", price = 5000, image = 'https://media.discordapp.net/attachments/974185293982879755/976746591471955968/v16explorer.png' },
            { name = "Blazer", model = "npolblazer", price = 5000, image = 'https://media.discordapp.net/attachments/974185293982879755/976746890504830996/Blazer.png' },
        },

        ['NPC'] = {
            id = "mrpd_vehicles_seller",
            position = {coords = vector3(441.43, -974.95, 24.7), heading = 180.62},
            pedType = 4,
            model = "s_m_y_cop_01",
            networked = false,
            distance = 25.0,
            settings = {{ mode = 'invincible', active = true }, { mode = 'ignore', active = true }, { mode = 'freeze', active = true }},
            flags = {["isNPC"] = true, ["isPoliceVehicleSeller"] = true,},
            scenario = "WORLD_HUMAN_COP_IDLES",
        }
    },
}