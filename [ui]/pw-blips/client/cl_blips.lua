
local Config = {
    ["clothing"] = {
        ["text"] = "Cửa hàng quần áo",
        ["sprite"] = 73,
        ["scale"] = 0.6,
        ["colour"] = 2,

        ["default"] = true,

        ["blips"] = {
            { ["pos"] = vector3(1693.69, 4822.86, 42.06) },
            { ["pos"] = vector3(-709.85, -153.08, 37.41) },
            { ["pos"] = vector3(-1192.81, -768.41, 17.31) },
            { ["pos"] = vector3(424.96, -806.24, 29.49) },
            { ["pos"] = vector3(-162.63, -303.03, 39.73) },
            { ["pos"] = vector3(75.43, -1392.95, 29.37) },
            { ["pos"] = vector3(-822.35, -1073.73, 11.32) },
            { ["pos"] = vector3(-1450.57, -237.63, 49.81) },
            { ["pos"] = vector3(4.39, 6512.80, 31.87) },
            { ["pos"] = vector3(614.29, 2762.54, 42.08) },
            { ["pos"] = vector3(1196.47, 2710.16, 38.22) },
            { ["pos"] = vector3(-3170.60, 1043.77, 20.86) },
            { ["pos"] = vector3(-1101.52, 2710.40, 19.10) },
            { ["pos"] = vector3(125.69, -223.86, 54.55) },
        },
    },
    ["barber"] = {
        ["text"] = "Barber Shop",
        ["sprite"] = 71,
        ["scale"] = 0.6,
        ["colour"] = 48,

        ["default"] = false,

        ["blips"] = {
            { ["pos"] = vector3(1932.07, 3729.67, 32.84) },
            { ["pos"] = vector3(-278.19, 6228.36, 31.69) },
            { ["pos"] = vector3(1211.99, -472.77, 66.20) },
            { ["pos"] = vector3(-33.22, -152.62, 57.07) },
            { ["pos"] = vector3(136.71, -1708.26, 29.29) },
            { ["pos"] = vector3(-815.18, -184.53, 37.56) },
            { ["pos"] = vector3(-1283.28, -1117.32, 6.99) },
        },
    },
    ["tattoo"] = {
        ["text"] = "Tattoo Shop",
        ["sprite"] = 75,
        ["scale"] = 0.6,
        ["colour"] = 27,

        ["default"] = false,

        ["blips"] = {
            { ["pos"] = vector3(1322.64, -1651.96, 52.27) },
            { ["pos"] = vector3(-1153.67, -1425.68, 4.95) },
            { ["pos"] = vector3(322.139, 180.467, 103.587) },
            { ["pos"] = vector3(-3170.07, 1075.05, 20.82) },
        },
    },
    -- ["ammunation"] = {
        -- ["text"] = "Ammunation",
        -- ["sprite"] = 110,
        -- ["scale"] = 0.7,
        -- ["colour"] = 17,

        -- ["default"] = true,

        -- ["blips"] = {
            -- { ["pos"] = vector3(-662.10, -935.30, 20.81) },
            -- { ["pos"] = vector3(810.20, -2157.30, 28.61) },
            -- { ["pos"] = vector3(1693.40, 3759.50, 33.71) },
            -- { ["pos"] = vector3(-330.20, 6083.80, 30.41) },
            -- { ["pos"] = vector3(252.30, -50.00, 68.91) },
            -- { ["pos"] = vector3(22.00, -1107.20, 28.81) },
            -- { ["pos"] = vector3(2567.60, 294.30, 107.71) },
            -- { ["pos"] = vector3(-1117.50, 2698.60, 17.51) },
            -- { ["pos"] = vector3(842.40, -1033.40, 27.11) },
            -- { ["pos"] = vector3(-1306.20, -394.00, 35.61) },
        -- },
    -- },
    ["shop247"] = {
        ["text"] = "Cửa hàng tạp hóa",
        ["sprite"] = 52,
        ["scale"] = 0.7,
        ["colour"] = 2,

        ["default"] = true,

        ["blips"] = {
            { ["pos"] = vector3(1392.41, 3604.47, 34.98) },
            { ["pos"] = vector3(546.98, 2670.31, 42.15) },
            { ["pos"] = vector3(-1223.66, -906.67, 12.32) },
            { ["pos"] = vector3(26.41, -1347.58, 29.49) },
            { ["pos"] = vector3(439.36, -979.00, 30.68) },
            { ["pos"] = vector3(-45.46, -1754.41, 29.42) },
            { ["pos"] = vector3(-707.39, -910.11, 19.21) },
            { ["pos"] = vector3(1162.87, -319.21, 69.20) },
            { ["pos"] = vector3(373.87, 331.02, 103.56) },
            { ["pos"] = vector3(2552.47, 381.03, 108.62) },
            { ["pos"] = vector3(-1823.67, 796.291, 138.12) },
            { ["pos"] = vector3(2673.91, 3281.77, 55.24) },
            { ["pos"] = vector3(1957.64, 3744.29, 32.34) },
            { ["pos"] = vector3(1701.97, 4921.81, 42.06) },
            { ["pos"] = vector3(1730.06, 6419.63, 35.03) },
            { ["pos"] = vector3(-436.94, 6007.02, 31.72) },
            { ["pos"] = vector3(191.06288, -890.5704, 30.71) },
            { ["pos"] = vector3(1166.0147, 2707.7802, 38.15) },
            { ["pos"] = vector3(-2969.487, 390.78109, 15.04) },
            { ["pos"] = vector3(-3247.092, 1001.0137, 12.83) },
            { ["pos"] = vector3(-2550.102, 2317.163, 33.21) },
            { ["pos"] = vector3(-1111.374, 2694.3085, 18.55) },
            { ["pos"] = vector3(-2195.55, 4289.7783, 49.17) },
            { ["pos"] = vector3(-679.541, 5837.4458, 17.34) },
            { ["pos"] = vector3(165.0545, 6642.217, 30.69) },
        },
    },
    ["misc"] = {
        ["default"] = true,
        ["custom"] = true,

        ["blips"] = {
            { ["text"] = "Cửa hàng thợ săn", ["sprite"] = 463, ["scale"] = 1.0, ["colour"] = 48, ["pos"] = vector3(-675.77, 5836.10, 17.33) },
            { ["text"] = "Cửa hàng dụng cụ", ["sprite"] = 566, ["scale"] = 0.7, ["colour"] = 10, ["pos"] = vector3(46.080375, -1749.123, 28.633472) },
            { ["text"] = "Cửa hàng dụng cụ", ["sprite"] = 566, ["scale"] = 0.7, ["colour"] = 10, ["pos"] = vector3(2748.6979, 3472.0498, 54.677799) },
        },
    },
}

AddEventHandler("pw-blips:update", function(pType, pInit)
    if not pType or not Config[pType] then return end

    local blips = tryGet("table", "pw-blips")

    if pInit ~= true then
        blips[pType] = not blips[pType]
        set(blips, "pw-blips")
    end

    local show = blips[pType]
    local typeData = Config[pType]
    local typeBlips = typeData["blips"]

    if typeData["custom"] then
        TriggerEvent("pw-blips:updateMisc", pType, show)
        return
    end

    for i, v in ipairs(typeBlips) do
        if show then
            v["blip"] = AddBlipForCoord(v["pos"])
            SetBlipSprite(v["blip"], typeData["sprite"])
            SetBlipScale(v["blip"], typeData["scale"])
            SetBlipAsShortRange(v["blip"], true)
            SetBlipColour(v["blip"], typeData["colour"])
            BeginTextCommandSetBlipName("CUSTOM_TEXT")
            AddTextComponentString(typeData["text"])
            EndTextCommandSetBlipName(v["blip"])
        else
            if v["blip"] ~= nil then
                RemoveBlip(v["blip"])
            end
        end
    end
end)

AddEventHandler("pw-blips:updateMisc", function(pType, show)
    local typeData = Config[pType]
    local typeBlips = typeData["blips"]

    for i, v in ipairs(typeBlips) do
        if show then
            v["blip"] = AddBlipForCoord(v["pos"])
            SetBlipSprite(v["blip"], v["sprite"])
            SetBlipScale(v["blip"], v["scale"])
            SetBlipAsShortRange(v["blip"], true)
            SetBlipColour(v["blip"], v["colour"])
            BeginTextCommandSetBlipName("CUSTOM_TEXT")
            AddTextComponentString(v["text"])
            EndTextCommandSetBlipName(v["blip"])
        else
            if v["blip"] ~= nil then
                RemoveBlip(v["blip"])
            end
        end
    end
end)

Citizen.CreateThread(function()
    local update = false
    local blips = tryGet("table", "pw-blips")

    if blips then
        for k, v in pairs(blips) do
            if Config[k] == nil then
                blips[k] = nil
                update = true
            end
        end
        for k, v in pairs(Config) do
            if blips[k] == nil then
                blips[k] = v.default
                update = true
            end
        end
    else
        update = true
        blips = {}

        for k, v in pairs(Config) do
            blips[k] = v.default
        end
    end

    if update then
        Setstorage(blips, "pw-blips")
    end

    for k, v in pairs(Config) do
        TriggerEvent("pw-blips:update", k, true)
    end
end)