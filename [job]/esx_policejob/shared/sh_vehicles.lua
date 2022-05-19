VehiclesConfig = {
    {   
        ["Job"] = "police",
        ["Label"] = "Xe cảnh",
        ["Garage"] = "MRPD",
        ["Spawn"] = {coords = vector3(435.95938, -976.0041, 25.699846) , heading = 88.65,},
        ["Vehicles"] = {
            { name = "Ford Crown Victoria", model = "npolvic", price = 5000, image = 'https://i.imgur.com/C9EPcgL.png' },
            { name = "Ford Explorer", model = "npolexp", price = 5000, image = 'https://i.imgur.com/C9EPcgL.png' },
            { name = "Ford Mustang", model = "npolstang", price = 5000, image = 'https://i.imgur.com/C9EPcgL.png' },
            { name = "Dodge Charger", model = "npolchar", price = 5000, image = 'https://i.imgur.com/C9EPcgL.png' },
            { name = "Dodge Challenger", model = "npolchal", price = 5000, image = 'https://i.imgur.com/C9EPcgL.png' },
            { name = "Chevrolet Corvette", model = "npolvette", price = 5000, image = 'https://i.imgur.com/C9EPcgL.png' },
            { name = "MM (Moto)", model = "npolmm", price = 5000, image = 'https://media.discordapp.net/attachments/974185293982879755/976747095413362718/mm.png' },
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