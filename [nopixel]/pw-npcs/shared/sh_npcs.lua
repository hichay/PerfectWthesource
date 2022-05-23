Generic = {}
Generic.NPCS = {}

Generic.SpawnLocations = {
    vector4(556.42, 2664.66, 42.2 - 1.0, 189.65),
}

Generic.ShopKeeperLocations = {
    vector4(-3037.773, 584.8989, 6.97, 30.0),
    vector4(1960.64, 3739.03, 31.50, 321.36),
    vector4(1393.84,3606.8,34.99,172.8),
    vector4(549.01,2672.44,42.16,122.33),
    vector4(2558.39,380.74,108.63,21.54),
    vector4(-1819.57,793.59,138.09,134.3),
    vector4(-1221.26,-907.92,11.3,54.44),
    vector4(-706.12,-914.56,18.22,94.66),
    vector4(24.47,-1348.47,28.5,298.26),
    vector4(-47.36,-1758.68,28.43,50.84),
    vector4(1164.95,-323.7,68.21,101.73),
    vector4(372.19,325.74,102.57,276.17),
    vector4(2678.63,3278.86,54.25,344.4),
    vector4(1727.3,6414.27,34.04,259.1),
    vector4(-160.56,6320.76,30.59,319.99),
    vector4(1165.29,2710.85,37.16,178.47),
    vector4(1697.23,4923.42,41.07,327.94),
}

Generic.WeaponShopLocations = {
    vector4(23.36,-1105.82,28.8,156.03),
    vector4(1696.02,3760.72,33.71,193.37),
    vector4(808.26,-2157.71,28.62,276.46),
    vector4(254.32,-49.28,68.95,70.86),
    vector4(840.21,-1032.9,27.2,289.83),
    vector4(-331.75,6084.95,30.46,224.64),
    vector4(-666.13,-938.73,20.83,269.52),
    vector4(-1310.05,-389.17,35.7,144.36),
    vector4(-1116.51,2700.33,17.58,149.9),
    vector4(2571.79,298.1,107.74,84.22),
    vector4(-3169.53,1089.59,19.84,237.35),
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "pawnshop",
  name = "Pawn Shop",
  pedType = 4,
  model = "s_m_y_ammucity_01",
  networked = false,
  distance = 200.0,
  position = {
    coords = vector3(0.0, 0.0, 0.0),
    heading = 0.0,
    random = true
  },
  appearance = '{"eyebrow":{"params":[2,0,0.0],"mode":"overlay"},"skinproblem":{"params":[6,0,0.0],"mode":"overlay"},"freckles":{"params":[9,0,0.0],"mode":"overlay"},"badges":{"params":[10,0,0,1],"mode":"component"},"arms":{"params":[3,0,0,1],"mode":"component"},"hat":{"params":[0,-1,-1,1],"mode":"prop"},"beard_color":{"params":[2,0,0,0,0],"mode":"overlaycolor"},"kevlar":{"params":[9,0,0,1],"mode":"component"},"bag":{"params":[5,0,0,1],"mode":"component"},"undershirt":{"params":[8,0,0,1],"mode":"component"},"wrinkles":{"params":[3,0,0.0],"mode":"overlay"},"shoes":{"params":[6,0,0,1],"mode":"component"},"legs":{"params":[4,0,0,1],"mode":"component"},"watch":{"params":[6,-1,-1,1],"mode":"prop"},"haircolor":{"params":[-1,-1],"mode":"haircolor"},"bracelet":{"params":[7,-1,-1,1],"mode":"prop"},"torso":{"params":[11,0,0,1],"mode":"component"},"hair":{"params":[2,0,0,1],"mode":"component"},"glasses":{"params":[1,-1,-1,1],"mode":"prop"},"mask":{"params":[1,0,0,1],"mode":"component"},"beard":{"params":[1,0,0.0],"mode":"overlay"},"accesory":{"params":[7,0,0,1],"mode":"component"},"eyecolor":{"params":[-1],"mode":"eyecolor"},"face":{"params":[0,0,0,1],"mode":"component"},"ears":{"params":[2,-1,-1,1],"mode":"prop"}}',
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
      ['isPawnBuyer'] = true
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
    id = "weedshop",
    name = "Weed NPC shop",
    pedType = 4,
    model = "a_f_y_hippie_01",
    networked = false,
    distance = 200.0,
    position = {
        coords = vector3(-1171.17, -1571.09, 3.67),
        heading = 120.0,
        random = false,
    },
    appearance = nil,
    settings = {
        { mode = "invincible", active = true },
        { mode = "ignore", active = true },
        { mode = "freeze", active = true },
    },
    flags = {
        ["isNPC"] = true,
        ["isWeedShopKeeper"] = true,
    },
    scenario = "WORLD_HUMAN_SMOKING_POT",
}


Generic.NPCS[#Generic.NPCS + 1] = {
    id = "illegal_medic",
    name = "Ilegal Nancy",
    pedType = 4,
    model = "a_m_o_ktown_01",
    networked = false,
    distance = 150.0,
    position = {
        coords = vector3(-625.68, -1628.5, 32.01),
        heading = 250.0,
        random = false,
    },
    appearance = nil,
    settings = {
        { mode = "invincible", active = true },
        { mode = "ignore", active = true },
        { mode = "freeze", active = true },
    },
    flags = {
        ["isNPC"] = true,
        ["isIllegalMedic"] = true,
    },
    scenario = "WORLD_HUMAN_AA_SMOKE",
}

Generic.NPCS[#Generic.NPCS + 1] = {
    id = "paycheck_banker",
    name = "Gerente do Banco",
    pedType = 4,
    model = "cs_bankman",
    networked = false,
    distance = 25.0,
    position = {
        coords = vector3(149.45, -1042.05, 29.37),
        heading = 340.0,
        random = false,
    },
    appearance = nil,
    settings = {
        { mode = "invincible", active = true },
        { mode = "ignore", active = true },
        { mode = "freeze", active = true },
        { mode = "collision", active = true },
    },
    flags = {
        ["isNPC"] = true,
        ["isBankAccountManager"] = true,
    },
    scenario = "WORLD_HUMAN_DRINKING",
}

Generic.NPCS[#Generic.NPCS + 1] = {
    id = "supply",
    name = "Supplier",
    pedType = 4,
    model = "u_m_y_antonb",
    networked = false,
    distance = 150.0,
    position = {
        coords = vector3(-71.55, -1821.35, 25.94),
        heading = 250.0,
        random = false,
    },
    appearance = nil,
    settings = {
        { mode = "invincible", active = true },
        { mode = "ignore", active = true },
        { mode = "freeze", active = true },
    },
    flags = {
        ["isNPC"] = true,
    },
    scenario = "WORLD_HUMAN_AA_COFFEE",
}