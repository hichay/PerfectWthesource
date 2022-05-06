Opod = {
    data = {},
    functions = {}
}

Opod.functions.StartHacking = function(location)
    Opod.data.IsBusy = true
    FreezeEntityPosition(PlayerPedId(), true)
    TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_STAND_MOBILE_UPRIGHT', 0, true)
    if Config.UseMHacking then
        TE("mhacking:show")
        if location == 'security' or location == 'vault' then
            TE("mhacking:start", 5, 35, function(success)
                if success then
                    if location == 'security' then
                        TSE('opod-artHeist:HackSecurity', true)
                    else
                        TSE('opod-artHeist:SetVaultDoor', false)
                    end
                end
                Opod.data.IsBusy = false
                FreezeEntityPosition(PlayerPedId(), false)
                ClearPedTasks(PlayerPedId())
                TE('mhacking:hide')
            end)
        elseif location == 'police' then
            local timer = math.random(10,30)
            TE("mhacking:start", 1, timer, function(success)
                if success then
                    TSE('opod-artHeist:HackSecurity', false)
                end
                Opod.data.IsBusy = false
                FreezeEntityPosition(PlayerPedId(), false)
                ClearPedTasks(PlayerPedId())
                TE('mhacking:hide')
            end)
        end
    else
        if location == 'security' or location == 'vault' then
            local result = nil
            if Config.UseSkillsbar and Config.SkillbarDifficulty['HackingCiv'] then
                TE('opod-skillbar:startSkillbar', function(success)
                    result = success
                end, Config.SkillbarDifficulty['HackingCiv'])
                while result == nil do Citizen.Wait(5) end
            else
                Opod.functions.Progressbar(_U('prog_hacking'), 30000)
                result = true
            end
            if result then
                if location == 'security' then
                    TSE('opod-artHeist:HackSecurity', true)
                else
                    TSE('opod-artHeist:SetVaultDoor', false)
                end
            else
                Opod.functions.ShowNotification(_U('skill_failed'), 'error')
            end
        elseif location == 'police' then
            local result = nil
            if Config.UseSkillsbar and Config.SkillbarDifficulty['HackingPolice'] then
                TE('opod-skillbar:startSkillbar', function(success)
                    result = success
                end, Config.SkillbarDifficulty['HackingPolice'])
                while result == nil do Citizen.Wait(5) end
            else
                for i = 1, 5 do
                    local timer = math.random(5000, 10000)
                    Opod.functions.Progressbar(_U('prog_hacking'), timer)
                end
                result = true
            end
            if result then
                TSE('opod-artHeist:HackSecurity', false)
            else
                Opod.functions.ShowNotification(_U('skill_failed'), 'error')
            end
        end
        FreezeEntityPosition(PlayerPedId(), false)
        Opod.data.IsBusy = false
        ClearPedTasks(PlayerPedId())
    end
end

Opod.functions.StealEgg = function()
    Opod.data.IsBusy = true
    FreezeEntityPosition(PlayerPedId(), true)
    RequestAnimDict('mp_common')
    while not HasAnimDictLoaded('mp_common') do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_b', 8.0, -8, 2000, 0, 0, 0, 0, 0)
    Opod.functions.Progressbar(_U('prog_steal_egg'), 2000)
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    TSE('opod-artHeist:SetDisplayCut', 'gone')
    --TSE('opod-artHeist:GiveInventoryItem', 'golden_egg', 1)
    TriggerEvent("player:receiveItem","negg",1)
    Opod.data.IsBusy = false
end


Opod.functions.FixWindow = function()
    TSE('opod-artHeist:SetWindowCut', false)
    TSE('opod-artHeist:SetWinchSync', false)
end

Opod.functions.StopRapealing = function(insideMueseum)
    DoScreenFadeOut(500)
    Citizen.Wait(500)
    Opod.data.IsRapealing   = false
    TSE('opod-artHeist:DetachRope')
    ESX.Game.DeleteObject(Opod.data.Platform)
    Opod.data.Platform      = nil
    if insideMueseum then
        Opod.data.IsRobber = true
    end
    Citizen.Wait(1000)
    DoScreenFadeIn(500)
    ClearPedTasks(PlayerPedId())
end

Opod.functions.WalkToCoords = function(coord, heading)
	TaskGoStraightToCoord(PlayerPedId(), coord, 1.0, -1, heading, 0.0) -- goto the coord
    while #(GetEntityCoords(PlayerPedId()) - coord) >= 0.1 do Citizen.Wait(1) end -- Check if the player is close to coord
    Citizen.Wait(500)
	SetEntityHeading(PlayerPedId(), heading)
	SetEntityCoords(PlayerPedId(), coord.x, coord.y, coord.z - 1.0)
end

Opod.functions.StartRapealing = function(insideMueseum)
    DoScreenFadeOut(500)
    Citizen.Wait(500)
    FreezeEntityPosition(PlayerPedId(), true)
    ESX.Game.SpawnObject('prop_cs_bottle_opener', vector3(Opod.data.PlayerPosition.x, Opod.data.PlayerPosition.y, Opod.data.PlayerPosition.z - 1), function(platform)
        Opod.data.Platform          = platform
        SetEntityCompletelyDisableCollision(Opod.data.Platform, true, true)
        SetEntityAlpha(Opod.data.Platform, 0, 0)
        FreezeEntityPosition(Opod.data.Platform, true)
        if not insideMueseum then
            Opod.data.IsRobber          = true
        end

        Opod.data.IsRapealing       = true
        Opod.data.IsBusy            = true
        if not insideMueseum then
            SetEntityCoords(PlayerPedId(), vector3(Opod.data.winchPosition.xy, 93.0))
            SetEntityAlpha(PlayerPedId(), 0, 0)
        end
        TSE('opod-artHeist:StartRapealing', NetworkGetNetworkIdFromEntity(PlayerPedId()), insideMueseum)
        Citizen.Wait(250)
        if not insideMueseum then
            SetEntityAlpha(PlayerPedId(), 255, 0)
        end
        Citizen.Wait(750)
        DoScreenFadeIn(500)
        Opod.data.IsBusy            = false
    end)
end

Opod.functions.DrawMarker = function(pos)
    DrawMarker(2, pos, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 255, 0, 0, 120, 0, 0, 0, 1, nil, nil, 0)
end

Opod.functions.ShowContextMenu = function(str)
    -- ESX.ShowHelpNotification(str)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.4, 0.4)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(true)
    SetTextEntry("CUSTOM_TEXT")
    AddTextComponentString(str)
    DrawText(0.5, 0.9)
end

Opod.functions.ShowNotification = function(str, type)
    TE('opod-artHeist:ShowNotification', str, type)
end


Opod.functions.SetupWinch = function()
    --ESX.TriggerServerCallback('opod-artHeist:HasItem', function(hasItem)
        if true then
            Opod.data.IsBusy = true
            Opod.functions.WalkToCoords(vector3(27.9, 144.82, 104.12), 80.0)
            RequestAnimDict('mini@repair')
            while not HasAnimDictLoaded('mini@repair') do
                Citizen.Wait(0)
            end
            TaskPlayAnim(PlayerPedId(), 'mini@repair', 'fixing_a_player', 8.0, -8, -1, 3, 0, 0, 0, 0)
            local result = nil
            if Config.UseSkillsbar and Config.SkillbarDifficulty['Winch'] then
                TE('opod-skillbar:startSkillbar', function(success)
                    result = success
                end, Config.SkillbarDifficulty['Winch'])
                while result == nil do Citizen.Wait(5) end
            else
                result = true
                Opod.functions.Progressbar(_U('prog_set_winch'), 15000)
            end
            if result then
                TSE('opod-artHeist:RemoveItem', 'winch', 1)
                TSE('opod-artHeist:SetWinchSync', true)
            else
                Opod.functions.ShowNotification(_U('skill_failed'), 'error')
            end
            Opod.data.IsBusy = false
            ClearPedTasks(PlayerPedId())
        else
            Opod.functions.ShowNotification(_U('dont_have', 'Winch'))
        end
    --end, 'winch')
end

Opod.functions.Progressbar = function(str, time)
    if Config.UseProgressbar then
        exports['progressBars']:startUI(time, str)
        Citizen.Wait(time)
    else
        Citizen.Wait(time)
    end
end

Opod.functions.CutWindow = function()
    if not Opod.data.WindowCut then
        --ESX.TriggerServerCallback('opod-artHeist:HasItem', function(hasItem)
            if true then

                Opod.functions.WalkToCoords(vector3(26.68, 145.07, 104.12), 20.0)
                ESX.Game.SpawnObject('k4mb1_laserdrill_01a', vector3(26.7, 145.0, 103.65), function(laserDrill)
                    Opod.data.LaserDrill = laserDrill
                    RequestAnimDict('amb@world_human_const_drill@male@drill@idle_a')
                    while not HasAnimDictLoaded('amb@world_human_const_drill@male@drill@idle_a') do
                        Citizen.Wait(0)
                    end
                    AttachEntityToEntity(Opod.data.LaserDrill, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.2, 90.0, 0.0, 180.0, true, true, false, true, 1, true)
                    TaskPlayAnim(PlayerPedId(), 'amb@world_human_const_drill@male@drill@idle_a', 'idle_a', 1.0, -1.0, -1, 3, 0.0, 0, 0, 0)
                    Citizen.Wait(1000)
                    ESX.Streaming.RequestNamedPtfxAsset('scr_ornate_heist', function()
                        if HasNamedPtfxAssetLoaded('scr_ornate_heist') then
                            SetPtfxAssetNextCall("scr_ornate_heist")
                            StartNetworkedParticleFxLoopedOnEntity("scr_heist_ornate_thermal_burn", Opod.data.LaserDrill, 0.0, -0.7, 0.0, 0.0, 0.0, 0.0, 0.5, 0, 0, 0, 0)
                        end
                    end)
                    ESX.Streaming.RequestNamedPtfxAsset('core', function()
                        if HasNamedPtfxAssetLoaded('core') then
                            SetPtfxAssetNextCall("core")
                            StartNetworkedParticleFxLoopedOnEntity("proj_laser_enemy", Opod.data.LaserDrill, 0.0, -0.68, 0.018, 0.0, 0.0, 0.0, 0.1, 0, 0, 0, 0)
                        end
                    end)
                end)
                Opod.data.IsBusy = true
                local result = nil
                if Config.UseSkillsbar and Config.SkillbarDifficulty['RoofWindow'] then
                    TE('opod-skillbar:startSkillbar', function(success)
                        result = success
                    end, Config.SkillbarDifficulty['RoofWindow'])
                    while result == nil do Citizen.Wait(5) end
                else
                    Opod.functions.Progressbar(_U('prog_cut_hole'), 10000)
                    result = true
                end
                if result then
                    TSE('opod-artHeist:SetWindowCut', true)
                    Opod.data.IsRobber = true
                    Opod.functions.StartTimer(60, 'alarm')
                else
                    Opod.functions.ShowNotification(_U('skill_failed'), 'error')
                end
                ClearPedTasks(PlayerPedId())
                Opod.data.IsBusy = false
                ESX.Game.DeleteObject(Opod.data.LaserDrill)
                Opod.data.LaserDrill = nil
            else
                Opod.functions.ShowNotification(_U('dont_have', 'Laser Drill'))
            end
        --end, 'laser_drill')
    end
end

Opod.functions.DrawText = function(str, x, y)
    Opod.functions.DrawRect(0.865, 0.95, 0.1430, 0.045, 0, 0, 0, 80)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.3, 0.3)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("CUSTOM_TEXT")
    AddTextComponentString(str)
    DrawText(0.87,0.9523)
end


Opod.functions.DrawRect = function(x, y, width, height, r, g, b, a)
    DrawRect(x + width/2, y +  height/2, width,  height, r, g, b, a)
end

Opod.functions.StartTimer = function(time, type)
    Citizen.Wait(150)
    CT(function()
        time = time * 1000
        while time > 0 do
            Citizen.Wait(1)
            time = time - 10
            if type == 'alarm' then
                if not Opod.data.IsRobber then
                    return
                end
                Opod.functions.DrawText(_U("time_left", math.floor(time/1000)))
                if Opod.data.SystemsHacked then
                    Opod.functions.ShowNotification(_U('time_bought', Config.TimeAfterHack))
                    Opod.functions.StartTimer(Config.TimeAfterHack)
                    return
                end
            end
        end
        TSE('opod-artHeist:RobberyAlert', true)
    end)
end

Opod.functions.OpenBlackmarket = function()
    Opod.data.PlayerData = ESX.GetPlayerData()
    FreezeEntityPosition(PlayerPedId(), true)
    Opod.data.IsBusy = true
    local elements = {}

    for _, v in ipairs(Opod.data.PlayerData['inventory']) do
        for k, x in pairs(Config.BlackmarketItems) do
            if v['name'] == k and v['count'] > 0 then
                table.insert(elements, {label = v['label'] .. ' - ' .. _U('currency', x), price = x, value = k})
            end
        end
    end

    ESX.UI.Menu.Open('default', 'opod-artheist', 'opod_blackmarket',
    {
        title  = _U('blackmarket'),
        elements = elements,
        align = 'left'
    },
    function(data, menu)
        menu.close()
        TSE('opod-artHeist:SellItem', data.current.value, data.current.price)
        Citizen.Wait(150)
        Opod.functions.OpenBlackmarket()
    end,
    function(data, menu)
        menu.close()
        Opod.data.IsBusy = false
        ClearPedTasks(PlayerPedId())
        FreezeEntityPosition(PlayerPedId(), 0)
    end)
end

Opod.functions.CutGlass = function()
    if IsInteriorEntitySetActive(Opod.data.InteriorId, "egg1") then
        --ESX.TriggerServerCallback('opod-artHeist:HasItem', function(hasItem)
            if true then
                Opod.functions.WalkToCoords(Opod.data.BankVault.eggPos, 250.0)
                ESX.Game.SpawnObject('k4mb1_laserdrill_01a', vector3(26.7, 145.0, 103.65), function(laserDrill)
                    Opod.data.LaserDrill = laserDrill
                    RequestAnimDict('anim_heist@hs3f@ig9_vault_drill@laser_drill@')
                    while not HasAnimDictLoaded('anim_heist@hs3f@ig9_vault_drill@laser_drill@') do
                        Citizen.Wait(0)
                    end
                    AttachEntityToEntity(Opod.data.LaserDrill, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.005, 20.0, 190.0, 0.0, true, true, false, true, 1, true)
                    TaskPlayAnim(PlayerPedId(), 'anim_heist@hs3f@ig9_vault_drill@laser_drill@', 'drill_straight_idle', 1.0, -1.0, -1, 3, 0.0, 0, 0, 0)
                    Citizen.Wait(1000)
                    ESX.Streaming.RequestNamedPtfxAsset('scr_ornate_heist', function()
                        if HasNamedPtfxAssetLoaded('scr_ornate_heist') then
                            SetPtfxAssetNextCall("scr_ornate_heist")
                            StartNetworkedParticleFxLoopedOnEntity("scr_heist_ornate_thermal_burn", Opod.data.LaserDrill, 0.0, -0.15, 0.0, 0.0, 0.0, 0.0, 0.5, 0, 0, 0, 0)
                        end
                    end)
                    ESX.Streaming.RequestNamedPtfxAsset('core', function()
                        if HasNamedPtfxAssetLoaded('core') then
                            SetPtfxAssetNextCall("core")
                            StartNetworkedParticleFxLoopedOnEntity("proj_laser_enemy", Opod.data.LaserDrill, 0.0, -0.68, 0.018, 0.0, 0.0, 0.0, 0.1, 0, 0, 0, 0)
                        end
                    end)
                end)
                SetEntityHeading(PlayerPedId(), 250.0)
                Opod.data.IsBusy = true
                local result = nil
                if Config.UseSkillsbar and Config.SkillbarDifficulty['GoldenEgg'] then
                    TE('opod-skillbar:startSkillbar', function(success)
                        result = success
                    end, Config.SkillbarDifficulty['GoldenEgg'])
                    while result == nil do Citizen.Wait(5) end
                else
                    Opod.functions.Progressbar(_U('prog_cut_hole'), 10000)
                    result = true
                end
                if result then
                    TSE('opod-artHeist:SetDisplayCut', 'cut')
                    TSE('opod-artHeist:RemoveItem', 'laser_drill', 1)
                else
                    Opod.functions.ShowNotification(_U('skill_failed'), 'error')
                end
                ClearPedTasks(PlayerPedId())
                ESX.Game.DeleteObject(Opod.data.LaserDrill)
                Opod.data.IsBusy = false
                Opod.data.LaserDrill = nil
            else
                Opod.functions.ShowNotification(_U('dont_have', 'Laser Drill'))
            end
        --end, 'laser_drill')
    end
end

Opod.functions.SpawnBlackmarket = function()
    RequestModel(Config.BlackmarketSettings.vehicle)
    while not HasModelLoaded(Config.BlackmarketSettings.vehicle) do
        Citizen.Wait(5)
    end
    Opod.data.BlackmarketVehicle = CreateVehicle(GetHashKey(Config.BlackmarketSettings.vehicle), Config.SellLocations[1].spawn.pos, Config.SellLocations[1].spawn.heading, true, true)
    RequestModel(Config.BlackmarketSettings.npc)
    while not HasModelLoaded(Config.BlackmarketSettings.npc) do
        Citizen.Wait(5)
    end
    local ped = CreatePedInsideVehicle(Opod.data.BlackmarketVehicle, 0, GetHashKey(Config.BlackmarketSettings.npc), -1, true, true)
    local VanPos = GetEntityCoords(Opod.data.BlackmarketVehicle)
    SetModelAsNoLongerNeeded(Config.BlackmarketSettings.vehicle)
    SetModelAsNoLongerNeeded(Config.BlackmarketSettings.npc)
    SetEntityInvincible(ped, true)
    SetVehicleDoorsLocked(Opod.data.BlackmarketVehicle, 4)
    SetBlockingOfNonTemporaryEvents(ped, true)
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(ped)
    ESX.ShowAdvancedNotification('Text Message', _U('subject_heading'), _U('text_message'), mugshotStr, 1)
    UnregisterPedheadshot(mugshot)
    
    TaskVehiclePark(ped, Opod.data.BlackmarketVehicle, Config.SellLocations[1].driveTo.pos, Config.SellLocations[1].driveTo.heading, 0, 20.0, true)
    local dist = #(VanPos - Config.SellLocations[1].driveTo.pos)
    local Driving = true
    while Driving do
        VanPos = GetEntityCoords(Opod.data.BlackmarketVehicle)
        dist = #(VanPos - Config.SellLocations[1].driveTo.pos)
        Citizen.Wait(5)
        if dist < 20.0 and IsVehicleStopped(Opod.data.BlackmarketVehicle) then
            Driving = false
        end
    end
    SetVehicleDoorOpen(Opod.data.BlackmarketVehicle, 2, 1, 1)
    Citizen.Wait(150)
    SetVehicleDoorOpen(Opod.data.BlackmarketVehicle, 3, 1, 1)
    local timer = 30000
    while timer > 0 do
        timer = timer - 5
        if not Opod.data.IsBusy then
            local markerPos = GetOffsetFromEntityInWorldCoords(Opod.data.BlackmarketVehicle, 0.0, -3.5, 0)
            local dist = #(Opod.data.PlayerPosition - markerPos)
            if dist <= 5.0 and not Opod.data.IsBusy then
                Opod.functions.DrawMarker(markerPos)
                if dist <= 1.5 then
                    Opod.functions.ShowContextMenu(_U('sell_blackmarket'))
                    if IsControlJustReleased(0, 38) then
                        RequestAnimDict('mini@repair')
                        while not HasAnimDictLoaded('mini@repair') do
                            Citizen.Wait(0)
                        end
                        TaskPlayAnim(PlayerPedId(), 'mini@repair', 'fixing_a_player', 8.0, -8, -1, 3, 0, 0, 0, 0)            
                        Opod.functions.OpenBlackmarket()
                    end
                end
            end
        end
        Citizen.Wait(5)
    end
    ESX.UI.Menu.CloseAll()
    Opod.data.IsBusy = false
    ClearPedTasks(PlayerPedId())
    SetVehicleDoorsShut(Opod.data.BlackmarketVehicle, 1)
    TaskVehicleDriveWander(ped, Opod.data.BlackmarketVehicle, 20.0, 388)
    SetEntityAsNoLongerNeeded(Opod.data.BlackmarketVehicle)
    SetEntityAsNoLongerNeeded(ped)
    FreezeEntityPosition(PlayerPedId(), 0)
end