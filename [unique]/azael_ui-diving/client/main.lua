ESX = nil
local dict, anim = Config["animation"]["dict_clothing"], Config["animation"]["anim_clothing"]
local isPaused, isDead, isAnimation = false, false, false
local useScuba, wantScuba, setScuba = false, false, false
local useSnorkelling, wantSnorkelling, setSnorkelling, underWaterSnorkelling = false, false, false, false
local snorkellingTime = 0
local setDisplay = nil
local isActive = true
Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                Config["esx_routers"]["client_shared_obj"],
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end
    end
)
RegisterNetEvent(Config["esx_routers"]["client_player_load"])
AddEventHandler(
    Config["esx_routers"]["client_player_load"],
    function(xPlayer)
        Citizen.Wait(5000)
        Citizen.CreateThread(
            function()
                while isActive == false do
                    ESX.TriggerServerCallback(
                        "azael_ui-diving:authenticating",
                        function(active)
                            if active then
                                isActive = true
				print('actived')
                            end
                        end
                    )
                    Citizen.Wait(1000)
                end
            end
        )
    end
)
AddEventHandler(
    "azael_ui-diving:setDisplay",
    function(display, status)
        if display == "scuba" then
            if status then
                SendNUIMessage({scuba = status, pause = "block"})
            else
                SendNUIMessage({scuba = status, pause = "none"})
            end
        elseif display == "snorkelling" then
            if status then
                SendNUIMessage({snorkelling = status, pause = "block"})
            else
                SendNUIMessage({snorkelling = status, pause = "none"})
            end
        end
    end
)
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(300)
            if useScuba or useSnorkelling then
                local playerPed = PlayerPedId()
                if useScuba then
                    setDisplay = "scuba"
                elseif useSnorkelling then
                    setDisplay = "snorkelling"
                end
                if IsEntityDead(playerPed) and not isDead then
                    isDead = true
                    TriggerEvent("azael_ui-diving:setDisplay", setDisplay, false)
                elseif not IsEntityDead(playerPed) and isDead then
                    isDead = false
                    TriggerEvent("azael_ui-diving:setDisplay", setDisplay, true)
                end
                if IsPauseMenuActive() and not isPaused then
                    isPaused = true
                    TriggerEvent("azael_ui-diving:setDisplay", setDisplay, false)
                elseif not IsPauseMenuActive() and isPaused then
                    isPaused = false
                    TriggerEvent("azael_ui-diving:setDisplay", setDisplay, true)
                end
            end
        end
    end
)
RegisterNetEvent("azael_ui-diving:scubaDiving")
AddEventHandler(
    "azael_ui-diving:scubaDiving",
    function()
        if useSnorkelling or not isActive then
            return
        end
        local playerPed = PlayerPedId()
        if not useScuba and not isAnimation then
            local playerJob = ESX.GetPlayerData().job.name
            ESX.Streaming.RequestAnimDict(
                dict,
                function()
                    isAnimation, useScuba, wantScuba, setScuba = true, true, true, false
                    TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
                    Citizen.Wait(Config["animation"]["delay_clothing"])
                    TriggerEvent(
                        "skinchanger:getSkin",
                        function(skin)
                            if skin.sex == 0 then
                                if
                                    Config["skin_color_scuba_agencies"]["enable"] and
                                        playerJob == Config["skin_color_scuba_agencies"]["ambulance"]["name"] or
                                        playerJob == Config["skin_color_scuba_agencies"]["police"]["name"]
                                 then
                                    local scubaSkin = Config["skin"]["scuba"]["male"]
                                    local agenColor = nil
                                    if playerJob == Config["skin_color_scuba_agencies"]["ambulance"]["name"] then
                                        agenColor = Config["skin_color_scuba_agencies"]["ambulance"]["color"]
                                        for k, v in ipairs(
                                            Config["skin_color_scuba_agencies"]["ambulance"]["color_position"]
                                        ) do
                                            if scubaSkin[v] then
                                                scubaSkin[v] = agenColor
                                            end
                                        end
                                    elseif playerJob == Config["skin_color_scuba_agencies"]["police"]["name"] then
                                        agenColor = Config["skin_color_scuba_agencies"]["police"]["color"]
                                        for k, v in ipairs(
                                            Config["skin_color_scuba_agencies"]["police"]["color_position"]
                                        ) do
                                            if scubaSkin[v] then
                                                scubaSkin[v] = agenColor
                                            end
                                        end
                                    end
                                    TriggerEvent("skinchanger:loadClothes", skin, scubaSkin)
                                else
                                    if Config["skin_color_random"]["scuba_enable"] then
                                        local scubaSkin = Config["skin"]["scuba"]["male"]
                                        math.randomseed(GetGameTimer())
                                        local randomColor =
                                            math.random(
                                            Config["skin_color_random"]["scuba_male"]["color_min"],
                                            Config["skin_color_random"]["scuba_male"]["color_max"]
                                        )
                                        if Config["skin_color_scuba_agencies"]["enable"] then
                                            repeat
                                                if
                                                    randomColor ==
                                                        Config["skin_color_scuba_agencies"]["ambulance"]["color"] or
                                                        randomColor ==
                                                            Config["skin_color_scuba_agencies"]["police"]["color"]
                                                 then
                                                    randomColor =
                                                        math.random(
                                                        Config["skin_color_random"]["scuba_male"]["color_min"],
                                                        Config["skin_color_random"]["scuba_male"]["color_max"]
                                                    )
                                                    Citizen.Wait(0)
                                                end
                                            until randomColor ~=
                                                Config["skin_color_scuba_agencies"]["ambulance"]["color"] or
                                                randomColor ~= Config["skin_color_scuba_agencies"]["police"]["color"]
                                        end
                                        for k, v in ipairs(Config["skin_color_random"]["scuba_male"]["color_position"]) do
                                            if scubaSkin[v] then
                                                scubaSkin[v] = randomColor
                                            end
                                        end
                                        TriggerEvent("skinchanger:loadClothes", skin, scubaSkin)
                                    else
                                        local scubaSkin = Config["skin"]["scuba"]["male"]
                                        TriggerEvent("skinchanger:loadClothes", skin, scubaSkin)
                                    end
                                end
                            else
                                if
                                    Config["skin_color_scuba_agencies"]["enable"] and
                                        playerJob == Config["skin_color_scuba_agencies"]["ambulance"]["name"] or
                                        playerJob == Config["skin_color_scuba_agencies"]["police"]["name"]
                                 then
                                    local scubaSkin = Config["skin"]["scuba"]["female"]
                                    local agenColor = nil
                                    if playerJob == Config["skin_color_scuba_agencies"]["ambulance"]["name"] then
                                        agenColor = Config["skin_color_scuba_agencies"]["ambulance"]["color"]
                                        for k, v in ipairs(
                                            Config["skin_color_scuba_agencies"]["ambulance"]["color_position"]
                                        ) do
                                            if scubaSkin[v] then
                                                scubaSkin[v] = agenColor
                                            end
                                        end
                                    elseif playerJob == Config["skin_color_scuba_agencies"]["police"]["name"] then
                                        agenColor = Config["skin_color_scuba_agencies"]["police"]["color"]
                                        for k, v in ipairs(
                                            Config["skin_color_scuba_agencies"]["police"]["color_position"]
                                        ) do
                                            if scubaSkin[v] then
                                                scubaSkin[v] = agenColor
                                            end
                                        end
                                    end
                                    TriggerEvent("skinchanger:loadClothes", skin, scubaSkin)
                                else
                                    if Config["skin_color_random"]["scuba_enable"] then
                                        local scubaSkin = Config["skin"]["scuba"]["female"]
                                        math.randomseed(GetGameTimer())
                                        local randomColor =
                                            math.random(
                                            Config["skin_color_random"]["scuba_female"]["color_min"],
                                            Config["skin_color_random"]["scuba_female"]["color_max"]
                                        )
                                        if Config["skin_color_scuba_agencies"]["enable"] then
                                            repeat
                                                if
                                                    randomColor ==
                                                        Config["skin_color_scuba_agencies"]["ambulance"]["color"] or
                                                        randomColor ==
                                                            Config["skin_color_scuba_agencies"]["police"]["color"]
                                                 then
                                                    randomColor =
                                                        math.random(
                                                        Config["skin_color_random"]["scuba_female"]["color_min"],
                                                        Config["skin_color_random"]["scuba_female"]["color_max"]
                                                    )
                                                    Citizen.Wait(0)
                                                end
                                            until randomColor ~=
                                                Config["skin_color_scuba_agencies"]["ambulance"]["color"] or
                                                randomColor ~= Config["skin_color_scuba_agencies"]["police"]["color"]
                                        end
                                        for k, v in ipairs(
                                            Config["skin_color_random"]["scuba_female"]["color_position"]
                                        ) do
                                            if scubaSkin[v] then
                                                scubaSkin[v] = randomColor
                                            end
                                        end
                                        TriggerEvent("skinchanger:loadClothes", skin, scubaSkin)
                                    else
                                        local scubaSkin = Config["skin"]["scuba"]["female"]
                                        TriggerEvent("skinchanger:loadClothes", skin, scubaSkin)
                                    end
                                end
                            end
                        end
                    )
                    if Config["object"]["scuba"]["enable"] then
                        local x, y, z = table.unpack(GetEntityCoords(playerPed))
                        local boneIndexMask = GetPedBoneIndex(playerPed, 12844)
                        local boneIndexTank = GetPedBoneIndex(playerPed, 24818)
                        local propHashMask = GetHashKey(Config["object"]["scuba"]["mask"])
                        local propHashTank = GetHashKey(Config["object"]["scuba"]["tank"])
                        ESX.Streaming.RequestModel(propHashMask)
                        ESX.Streaming.RequestModel(propHashTank)
                        propScubaMask = CreateObject(propHashMask, x, y, z - 3, true, true, true)
                        propScubaTank = CreateObject(propHashTank, x, y, z - 3, true, true, true)
                        AttachEntityToEntity(
                            propScubaMask,
                            playerPed,
                            boneIndexMask,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            90.0,
                            180.0,
                            true,
                            true,
                            false,
                            true,
                            1,
                            true
                        )
                        AttachEntityToEntity(
                            propScubaTank,
                            playerPed,
                            boneIndexTank,
                            -0.30,
                            -0.22,
                            0.0,
                            0.0,
                            90.0,
                            180.0,
                            true,
                            true,
                            false,
                            true,
                            1,
                            true
                        )
                    end
                    TriggerEvent("azael_ui-diving:setDisplay", "scuba", true)
                    ClearPedSecondaryTask(playerPed)
                    isAnimation = false
                end
            )
        else
            if not isAnimation then
                ESX.Streaming.RequestAnimDict(
                    dict,
                    function()
                        isAnimation = true
                        TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
                        Citizen.Wait(Config["animation"]["delay_clothing"])
                        if Config["object"]["scuba"]["enable"] then
                            DeleteObject(propScubaMask)
                            DeleteObject(propScubaTank)
                        end
                        TriggerEvent(
                            "skinchanger:getSkin",
                            function(playerSkin)
                                ESX.TriggerServerCallback(
                                    Config["esx_routers"]["client_player_skin"],
                                    function(playerSkin, hasSkin)
                                        if hasSkin then
                                            TriggerEvent("skinchanger:loadSkin", playerSkin)
                                            TriggerEvent(Config["esx_routers"]["client_re_loadout"])
                                        end
                                    end
                                )
                            end
                        )
                        SetPedDiesInWater(playerPed, true)
                        TriggerEvent("azael_ui-diving:setDisplay", "scuba", false)
                        ClearPedSecondaryTask(playerPed)
                        isAnimation, useScuba, wantScuba, setScuba = false, false, false, false
                    end
                )
            end
        end
    end
)
AddEventHandler(
    Config["esx_routers"]["client_status_loaded"],
    function(status)
        TriggerEvent(
            Config["esx_routers"]["client_status_register"],
            "scubaOxygen",
            0,
            "#00c6ff",
            function(status)
                return false
            end,
            function(status)
                status.remove(0)
            end
        )
        Citizen.CreateThread(
            function()
                while true do
                    Citizen.Wait(1000)
                    if useScuba and not isDead then
                        local playerPed = PlayerPedId()
                        local isPedUnderWater = IsPedSwimmingUnderWater(playerPed)
                        TriggerEvent(
                            Config["esx_routers"]["client_status_get"],
                            "scubaOxygen",
                            function(status)
                                if isPedUnderWater then
                                    if status.val >= Config["scuba_oxygen_remove"] then
                                        if wantScuba and not setScuba then
                                            SetPedDiesInWater(playerPed, false)
                                            wantScuba, setScuba = false, true
                                        end
                                        TriggerEvent(
                                            Config["esx_routers"]["client_status_remove"],
                                            "scubaOxygen",
                                            Config["scuba_oxygen_remove"]
                                        )
                                    else
                                        if not wantScuba and setScuba then
                                            SetPedDiesInWater(playerPed, true)
                                            wantScuba, setScuba = true, false
                                            TriggerEvent(Config["esx_routers"]["client_status_set"], "scubaOxygen", 0)
                                        end
                                    end
                                else
                                    if not wantScuba and setScuba then
                                        SetPedDiesInWater(playerPed, true)
                                        wantScuba, setScuba = true, false
                                    end
                                end
                                if not isDead and not isPaused then
                                    SendNUIMessage(
                                        {
                                            scuba = true,
                                            oxygen = status.val,
                                            pause = "block",
                                            max = Config["esx_status_max"]
                                        }
                                    )
                                end
                            end
                        )
                    end
                end
            end
        )
    end
)
RegisterNetEvent("azael_ui-diving:scubaCheckPedInWater")
AddEventHandler(
    "azael_ui-diving:scubaCheckPedInWater",
    function()
        local playerPed = PlayerPedId()
        local isPedSwimming = IsPedSwimming(playerPed)
        if not isPedSwimming then
            TriggerEvent("azael_ui-diving:scubaDiving")
        else
            if Config["pNotify"]["enable"] then
                TriggerEvent(
                    "pNotify:SendNotification",
                    {
                        text = "ไม่สามารถใช้งานในน้ำได้",
                        type = Config["pNotify"]["type"],
                        timeout = Config["pNotify"]["timeout"],
                        layout = Config["pNotify"]["layout"],
                        queue = Config["pNotify"]["queue"]
                    }
                )
            else
                ESX.ShowNotification("~r~Cannot be used~s~ in ~b~water~s~")
            end
        end
    end
)
RegisterNetEvent("azael_ui-diving:scubaoxygenCheckPedInWater")
AddEventHandler(
    "azael_ui-diving:scubaoxygenCheckPedInWater",
    function()
        if useScuba then
            local playerPed = PlayerPedId()
            local isPedSwimming = IsPedSwimming(playerPed)
            if not isPedSwimming then
                TriggerServerEvent("azael_ui-diving:scubaoxygenUsableItem", true)
            else
                if Config["pNotify"]["enable"] then
                    TriggerEvent(
                        "pNotify:SendNotification",
                        {
                            text = "ไม่สามารถใช้งานในน้ำได้",
                            type = Config["pNotify"]["type"],
                            timeout = Config["pNotify"]["timeout"],
                            layout = Config["pNotify"]["layout"],
                            queue = Config["pNotify"]["queue"]
                        }
                    )
                else
                    ESX.ShowNotification("~r~Cannot be used~s~ in ~b~water~s~")
                end
            end
        else
            if Config["pNotify"]["enable"] then
                TriggerEvent(
                    "pNotify:SendNotification",
                    {
                        text = "ไม่สามารถใช้งานได้ โปรดสวมชุดดำน้ำลึกก่อนใช้งาน",
                        type = Config["pNotify"]["type"],
                        timeout = Config["pNotify"]["timeout"],
                        layout = Config["pNotify"]["layout"],
                        queue = Config["pNotify"]["queue"]
                    }
                )
            else
                ESX.ShowNotification("~r~Cannot be used~s~\nPlease wear a deep ~s~diving suit~s~ before use")
            end
        end
    end
)
RegisterNetEvent("azael_ui-diving:snorkellingDiving")
AddEventHandler(
    "azael_ui-diving:snorkellingDiving",
    function()
        if useScuba or not isActive then
            return
        end
        local playerPed = PlayerPedId()
        if not useSnorkelling and not isAnimation then
            ESX.Streaming.RequestAnimDict(
                dict,
                function()
                    isAnimation, useSnorkelling, wantSnorkelling, setSnorkelling, underWaterSnorkelling =
                        true,
                        true,
                        true,
                        false,
                        false
                    TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
                    Citizen.Wait(Config["animation"]["delay_clothing"])
                    TriggerEvent(
                        "skinchanger:getSkin",
                        function(skin)
                            if skin.sex == 0 then
                                if Config["skin_color_random"]["snorkelling_enable"] then
                                    local snorkellingSkin = Config["skin"]["snorkelling"]["male"]
                                    math.randomseed(GetGameTimer())
                                    local randomColor =
                                        math.random(
                                        Config["skin_color_random"]["snorkelling_male"]["color_min"],
                                        Config["skin_color_random"]["snorkelling_male"]["color_max"]
                                    )
                                    for k, v in ipairs(
                                        Config["skin_color_random"]["snorkelling_male"]["color_position"]
                                    ) do
                                        if snorkellingSkin[v] then
                                            snorkellingSkin[v] = randomColor
                                        end
                                    end
                                    TriggerEvent("skinchanger:loadClothes", skin, snorkellingSkin)
                                else
                                    local snorkellingSkin = Config["skin"]["snorkelling"]["male"]
                                    TriggerEvent("skinchanger:loadClothes", skin, snorkellingSkin)
                                end
                            else
                                if Config["skin_color_random"]["snorkelling_enable"] then
                                    local snorkellingSkin = Config["skin"]["snorkelling"]["female"]
                                    math.randomseed(GetGameTimer())
                                    local randomColor =
                                        math.random(
                                        Config["skin_color_random"]["snorkelling_female"]["color_min"],
                                        Config["skin_color_random"]["snorkelling_female"]["color_max"]
                                    )
                                    for k, v in ipairs(
                                        Config["skin_color_random"]["snorkelling_female"]["color_position"]
                                    ) do
                                        if snorkellingSkin[v] then
                                            snorkellingSkin[v] = randomColor
                                        end
                                    end
                                    TriggerEvent("skinchanger:loadClothes", skin, snorkellingSkin)
                                else
                                    local snorkellingSkin = Config["skin"]["snorkelling"]["female"]
                                    TriggerEvent("skinchanger:loadClothes", skin, snorkellingSkin)
                                end
                            end
                        end
                    )
                    if Config["object"]["snorkelling"]["enable"] then
                        local x, y, z = table.unpack(GetEntityCoords(playerPed))
                        local boneIndexMask = GetPedBoneIndex(playerPed, 12844)
                        local propHashMask = GetHashKey(Config["object"]["snorkelling"]["mask"])
                        ESX.Streaming.RequestModel(propHashMask)
                        propSnorkellingbaMask = CreateObject(propHashMask, x, y, z - 3, true, true, true)
                        AttachEntityToEntity(
                            propSnorkellingbaMask,
                            playerPed,
                            boneIndexMask,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            90.0,
                            180.0,
                            true,
                            true,
                            false,
                            true,
                            1,
                            true
                        )
                    end
                    snorkellingTime = Config["snorkelling_timer"]
                    ClearPedSecondaryTask(playerPed)
                    isAnimation = false
                end
            )
        else
            if not isAnimation then
                ESX.Streaming.RequestAnimDict(
                    dict,
                    function()
                        isAnimation = true
                        TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
                        Citizen.Wait(Config["animation"]["delay_clothing"])
                        if Config["object"]["snorkelling"]["enable"] then
                            DeleteObject(propSnorkellingbaMask)
                        end
                        TriggerEvent(
                            "skinchanger:getSkin",
                            function(playerSkin)
                                ESX.TriggerServerCallback(
                                    Config["esx_routers"]["client_player_skin"],
                                    function(playerSkin, hasSkin)
                                        if hasSkin then
                                            TriggerEvent("skinchanger:loadSkin", playerSkin)
                                            TriggerEvent(Config["esx_routers"]["client_re_loadout"])
                                        end
                                    end
                                )
                            end
                        )
                        SetPedDiesInWater(playerPed, true)
                        TriggerEvent("azael_ui-diving:setDisplay", "snorkelling", false)
                        ClearPedSecondaryTask(playerPed)
                        isAnimation, useSnorkelling, wantSnorkelling, setSnorkelling, underWaterSnorkelling =
                            false,
                            false,
                            false,
                            false,
                            false
                    end
                )
            end
        end
    end
)
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            if useSnorkelling then
                local playerPed = PlayerPedId()
                local isPedSwimming = IsPedSwimming(playerPed)
                local isPedUnderWater = IsPedSwimmingUnderWater(playerPed)
                if isPedSwimming then
                    local x, y, z = table.unpack(GetEntityCoords(playerPed))
                    local coordsZ = ESX.Math.Round(string.gsub(z, "%-", ""))
                    if isPedUnderWater then
                        if Config["snorkelling_depth"] > coordsZ and snorkellingTime > 0 then
                            if wantSnorkelling and not setSnorkelling then
                                SetPedDiesInWater(playerPed, false)
                                wantSnorkelling, setSnorkelling, underWaterSnorkelling = false, true, true
                            end
                            snorkellingTime = snorkellingTime - 1
                        else
                            if not wantSnorkelling and setSnorkelling then
                                SetPedDiesInWater(playerPed, true)
                                wantSnorkelling, setSnorkelling = true, false
                            end
                        end
                        if not isDead and not isPaused then
                            local valDepth = Config["snorkelling_depth"] - coordsZ
                            if valDepth < (0) then
                                valDepth = (0)
                            end
                            SendNUIMessage(
                                {
                                    snorkelling = true,
                                    pause = "block",
                                    depth = {val = valDepth, max = Config["snorkelling_depth"]},
                                    timer = {val = snorkellingTime, max = Config["snorkelling_timer"]}
                                }
                            )
                        end
                    else
                        if not wantSnorkelling and setSnorkelling then
                            SetPedDiesInWater(playerPed, true)
                            wantSnorkelling, setSnorkelling = true, false
                        end
                        if snorkellingTime < Config["snorkelling_timer"] then
                            snorkellingTime = (snorkellingTime + Config["snorkelling_timer_recovery"])
                        end
                        if not isDead and not isPaused then
                            SendNUIMessage(
                                {
                                    snorkelling = true,
                                    pause = "block",
                                    depth = {val = Config["snorkelling_depth"], max = Config["snorkelling_depth"]},
                                    timer = {val = snorkellingTime, max = Config["snorkelling_timer"]}
                                }
                            )
                        end
                    end
                else
                    if underWaterSnorkelling then
                        SetPedDiesInWater(playerPed, true)
                        underWaterSnorkelling = false
                    end
                    if snorkellingTime ~= Config["snorkelling_timer"] then
                        snorkellingTime = Config["snorkelling_timer"]
                    end
                    TriggerEvent("azael_ui-diving:setDisplay", "snorkelling", false)
                end
            end
        end
    end
)
RegisterNetEvent("azael_ui-diving:snorkellingCheckPedInWater")
AddEventHandler(
    "azael_ui-diving:snorkellingCheckPedInWater",
    function()
        local playerPed = PlayerPedId()
        local isPedSwimming = IsPedSwimming(playerPed)
        if not isPedSwimming then
            TriggerEvent("azael_ui-diving:snorkellingDiving")
        else
            if Config["pNotify"]["enable"] then
                TriggerEvent(
                    "pNotify:SendNotification",
                    {
                        text = "ไม่สามารถใช้งานในน้ำได้",
                        type = Config["pNotify"]["type"],
                        timeout = Config["pNotify"]["timeout"],
                        layout = Config["pNotify"]["layout"],
                        queue = Config["pNotify"]["queue"]
                    }
                )
            else
                ESX.ShowNotification("~r~Cannot be used~s~ in ~b~water~s~")
            end
        end
    end
)
