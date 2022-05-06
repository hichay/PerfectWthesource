Config = {}

Config = {
    -- Lumberjack Job
    Prices = {
        ['wood_proc'] = {20, 64}
    },
    ChanceToGetItem = 30, -- if math.random(0, 100) <= ChanceToGetItem then give item
    Items = {'wood_cut','wood_cut','wood_cut','wood_cut','wood_cut'},
    Sell = vector3(1210.0, -1318.51, 35.23),
    Process = vector3(-584.66, 5285.63, 70.26),
    NPC = vector3(-559.7275, 5282.7309, 73.050994),
    Objects = {
        ['pickaxe'] = 'w_me_hatchet',
    },
    WoodPosition = {
        {coords = vector3(-493.0, 5395.37, 77.18-0.97), heading = 282.49},
        {coords = vector3(-503.69, 5392.12, 75.98-0.97), heading = 113.62},
        {coords = vector3(-456.85, 5397.37, 79.49-0.97), heading = 29.92},
        {coords = vector3(-500.208, 5400.4843, 75.228477), heading = 16.11},
        {coords = vector3(-509.4244, 5389.9868, 73.280876), heading = 127.76},
        {coords = vector3(-457.42, 5409.05, 78.78-0.97), heading = 209.65}
    },
   
}

Config.textDel = '~g~[E]~w~ Chặt cây'

overpoweredvehicle = {}
overpoweredvehicle.SpawnVehicle = {
    x = 1205.31, 
    y = -1288.06, 
    z = 35.23, 
    h = 250.0,
}
Strings = {
    ['wood_info'] = 'Nhan ~INPUT_ATTACK~ , ~INPUT_FRONTEND_RRIGHT~ Stop.',
    ['e_sell'] = 'Press ~INPUT_CONTEXT~ to sell goods',
    ['someone_close'] = 'There is another citizen nearby!',
    ['wood'] = 'Cây gỗ',
    ['npc'] = 'Công ty chế biến gỗ',
    ['process'] = 'Tinh chế gỗ',
    ['sell_wood'] = 'Điểm bán gỗ',
}