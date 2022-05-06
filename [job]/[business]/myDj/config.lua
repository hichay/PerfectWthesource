Config = {}
Translation = {}

Translation = {
    ['de'] = {
        ['DJ_interact'] = 'Nhấn ~g~E~s~, để mở bàn',
        ['title_does_not_exist'] = '~r~Tiêu đề này không tồn tại!',
    },

    ['en'] = {
        ['DJ_interact'] = 'Nhấn ~g~E~s~, để mở DJ',
        ['title_does_not_exist'] = '~r~This title does not exist!',
    }
}

Config.Locale = 'en'

Config.useESX = true -- can not be disabled without changing the callbacks
Config.enableCommand = false

Config.enableMarker = true -- purple marker at the DJ stations

Config.DJPositions = {
    {
        name = 'VaniUnicorn',
        pos = vector3(120.49282, -1281.456, 29.48036),
        requiredJob = nil, 
		requiredJob = 'luciferbarcard',
        range = 25.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    }

    --{name = 'bahama', pos = vector3(-1381.01, -616.17, 31.5), requiredJob = 'DJ', range = 25.0}
}