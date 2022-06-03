Config = {
    pricexd = {
        -- ['item'] = {min, max} --
        steel = math.random(10, 40),
        iron = math.random(10, 60),
        copper = math.random(30, 60),
        diamond = math.random(50, 90),
        emerald = math.random(60, 110)
    },
    ChanceToGetItem = 100, -- if math.random(0, 100) <= ChanceToGetItem then give item
    --Items = {'copper','iron','copper','iron','copper', 'iron', 'copper', 'iron', 'copper', 'iron', 'copper', 'iron', 'copper', 'iron', 'jadeite'},
    Items = {'rock'},
    --Sell = vector3(2832.6193, 2799.9738, 57.474582),
    WashLocation = {
        {coords = vector3(-539.124, 2938.3337, 14.319754)},
        {coords = vector3(-548.1904, 2941.5363, 14.290513)},
        {coords = vector3(-530.677, 2935.8449, 14.362404)},
        {coords = vector3(-521.1026, 2926.6433, 14.044811)}
    },
    NPC = vector3(2832.6193, 2799.9738, 56.474582),
    Objects = {
        ['pickaxe'] = 'prop_tool_pickaxe',
    },
    MiningPositions = {
        {coords = vector3(2980.56, 2825.31, 46.09), heading = 209.29},
        {coords = vector3(2983.03, 2750.9, 42.02), heading = 214.08},
        {coords = vector3(3003.86, 2784.83, 44.463), heading = 246.21},
        {coords = vector3(2934.265, 2742.695, 43.1), heading = 96.1},
		{coords = vector3(2968.27, 2847.44, 47.11), heading = 209.29},
		{coords = vector3(2951.40, 2852.84, 49.03), heading = 209.29},
        {coords = vector3(2907.25, 2788.27, 45.4), heading = 109.39}
    },
}
Config.textDel = '~g~[E]~w~ Để Đào'
Strings = {
    ['press_mine'] = 'Nhấn [E] để bắt đầu.',
    ['mining_info'] = 'Nhấn [SPACE] Để bắt đầu, [BACKSPACE] để dừng.',
    ['you_sold'] = 'You sold %sx %s for $%s ',
    ['e_sell'] = 'Press [E] to sell materials from the mine.',
    ['someone_close'] = 'Citizen to close!',
    ['mining'] = '[1] - Chỗ đào',
    ['npc'] = 'Công ty khoáng sản',
    ['sell_mine'] = 'Mining Sales',
    ['e_wash'] = 'Press [E] để rửa đá.',
    ['washlocation'] = '[2] - Điểm rửa đá.'
}