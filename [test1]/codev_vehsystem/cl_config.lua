config = {
    key = 47, -- https://docs.fivem.net/docs/game-references/controls/
    lang = {
        turnOnEngine = "Turn on engine holding ~INPUT_DETONATE~", -- add the Control Name based on your key above, if the key is 47 your Control Name should be ~INPUT_DETONATE~.
        turnOnIgnition = "Turn on ignition pressing ~INPUT_DETONATE~", -- if the key is 38 your control name would be ~INPUT_PICKUP~.
        turnOffIgnition = "Turn off ignition pressing ~INPUT_DETONATE~"
    },
    startCheck = { -- you can add here as many as you want
        {moreThan = 0.0, time = 0.5}, -- if the last start check is more than {moreThan} mileage the starting time will be {time} in seconds.
        {moreThan = 10.0, time = 3},
        {moreThan = 50.0, time = 4},
        {moreThan = 150.0, time = 7},
        {moreThan = 250.0, time = 9},
        {moreThan = 450.0, time = 12},
        {moreThan = 650.0, time = 15},
        {moreThan = 850.0, time = 20},
        {moreThan = 1050.0, time = 45}
    },
    engineCheck = { -- you can add here as many as you want
        {moreThan = 10.0, maxHealth = 950.0}, -- if the last engine check is more than {moreThan} mileage the maximum engine health will be {maxHealth}
        {moreThan = 50.0, maxHealth = 900.0},
        {moreThan = 150.0, maxHealth = 800.0},
        {moreThan = 250.0, maxHealth = 700.0},
        {moreThan = 450.0, maxHealth = 650.0},
        {moreThan = 650.0, maxHealth = 550.0},
        {moreThan = 850.0, maxHealth = 450.0},
        {moreThan = 1050.0, maxHealth = 350.0}
    },
    autoSaving = 10 -- this will autosave the current vehicle every {autoSaving} seconds.
}