ESX = nil

Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

isLoggedIn = true
stress = 0
PlayerJob = {}

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if ESX == nil then
            TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)    
            Citizen.Wait(200)
        end
        if ESX ~= nil then
            TriggerEvent("hud:client:SetMoney")
            return
        end
		ESX.GetPlayerData = ESX.GetPlayerData()
    end
end)

-- RegisterNetEvent("esx:onPlayerSpawn")
-- AddEventHandler("esx:onPlayerSpawn", function()
    -- isLoggedIn = false
    -- QBHud.Show = true
    -- SendNUIMessage({
        -- action = "hudtick",
        -- show = true,
    -- })
-- end)

RegisterNetEvent("esx:onPlayerSpawn")
AddEventHandler("esx:onPlayerSpawn", function()
    isLoggedIn = true
    QBHud.Show = true
    	
    showRoundMap()
    --PlayerJob = ESX.GetPlayerData.job
    -- SendNUIMessage({
        -- action = "hudtick",
        -- show = true,
    -- })
end)

local StressGain = 0
local IsGaining = false

Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(-1)

        if IsPedShooting(GetPlayerPed(-1)) then
            local StressChance = math.random(1, 3)
            local odd = math.random(1, 3)
            if StressChance == odd then
                local PlusStress = math.random(2, 4) / 100
                StressGain = StressGain + PlusStress
            end
            if not IsGaining then
                IsGaining = true
            end
        else
            if IsGaining then
                IsGaining = false
            end
        end

        if (PlayerJob.name ~= "police") then
            if IsPlayerFreeAiming(PlayerId()) and not IsPedShooting(GetPlayerPed(-1)) then
                local CurrentWeapon = GetSelectedPedWeapon(ped)
                --local WeaponData = QBCore.Shared.Weapons[CurrentWeapon]
                --if WeaponData.name:upper() ~= "WEAPON_UNARMED" then
                    local StressChance = math.random(1, 20)
                    local odd = math.random(1, 20)
                    if StressChance == odd then
                        local PlusStress = math.random(1, 3) / 100
                        StressGain = StressGain + PlusStress
                    end
                --end
                if not IsGaining then
                    IsGaining = true
                end
            else
                if IsGaining then
                    IsGaining = false
                end
            end
        end

        Citizen.Wait(50)
    end
end)

RegisterNetEvent('hud:client:UpdateStress')
AddEventHandler('hud:client:UpdateStress', function(newStress)
    stress = newStress
end)

Citizen.CreateThread(function()
    while true do
        if not IsGaining then
            StressGain = math.ceil(StressGain)
            if StressGain > 0 then
                --QBCore.Functions.Notify('Ficas-te com stress', "primary", 2000)
				TriggerEvent("ESX:Notify", "Căng thẳng tăng","warning")
                --TriggerServerEvent('qb-hud:Server:UpdateStress', StressGain)
				TriggerEvent('esx_status:add','stress', StressGain)
                StressGain = 0
            end
        end

        Citizen.Wait(20000)
    end
end)

function GetShakeIntensity(stresslevel)
    local retval = 0.05
    for k, v in pairs(QBStress.Intensity["shake"]) do
        if stresslevel >= v.min and stresslevel < v.max then
            retval = v.intensity
            break
        end
    end
    return retval
end

function GetEffectInterval(stresslevel)
    local retval = 60000
    for k, v in pairs(QBStress.EffectInterval) do
        if stresslevel >= v.min and stresslevel < v.max then
            retval = v.timeout
            break
        end
    end
    return retval
end

Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(-1)
        local Wait = GetEffectInterval(stress)
        if stress >= 100 then
            local ShakeIntensity = GetShakeIntensity(stress)
            local FallRepeat = math.random(2, 4)
            local RagdollTimeout = (FallRepeat * 1750)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', ShakeIntensity)
            SetFlash(0, 0, 500, 3000, 500)

            if not IsPedRagdoll(ped) and IsPedOnFoot(ped) and not IsPedSwimming(ped) then
                local player = PlayerPedId()
                SetPedToRagdollWithFall(player, RagdollTimeout, RagdollTimeout, 1, GetEntityForwardVector(player), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
            end

            Citizen.Wait(500)
            for i = 1, FallRepeat, 1 do
                Citizen.Wait(750)
                DoScreenFadeOut(200)
                Citizen.Wait(1000)
                DoScreenFadeIn(200)
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', ShakeIntensity)
                SetFlash(0, 0, 200, 750, 200)
            end
        elseif stress >= QBStress.MinimumStress then
            local ShakeIntensity = GetShakeIntensity(stress)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', ShakeIntensity)
            SetFlash(0, 0, 500, 2500, 500)
        end
        Citizen.Wait(Wait)
    end
end)
--[[
posX = 0.01
posY = 0.0-- 0.0152

width = 0.183
height = 0.32--0.354

posX = -0.0085
posY = -0.010 -- 0.0152
        
width = 0.128
height = 0.221 --0.354

showRoundMap = function()
    RequestStreamedTextureDict("circlemap", false)
    while not HasStreamedTextureDictLoaded("circlemap") do
        Wait(100)
    end

    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")

    SetMinimapClipType(1)
    SetMinimapComponentPosition('minimap', 'L', 'B', posX, posY, width, height)
    --SetMinimapComponentPosition('minimap_mask', 'L', 'B', 0.0, 0.032, 0.101, 0.259)
    SetMinimapComponentPosition('minimap_mask', 'L', 'B', posX, posY, width, height)
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', 0.015, 0.022, 0.256, 0.337)

    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)

    while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
        SetBlipAlpha(GetNorthRadarBlip(), 0)
    end
end

local isPause = false
local uiHidden = false

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsBigmapActive() or IsPauseMenuActive() and not isPause or IsRadarHidden() then
            if not uiHidden then
                SendNUIMessage({
                    action = "hideUI"
                })
                uiHidden = true
            end
        elseif uiHidden or IsPauseMenuActive() and isPause then
            SendNUIMessage({
                action = "displayUI"
            })
            uiHidden = false
        end
    end
end)]]

showRoundMap = function()
    local posX = -0.01
    local posY = 0.00-- 0.0152
    
    local width = 0.200
    local height = 0.28 --0.354
    
    Citizen.CreateThread(function()
        RequestStreamedTextureDict("circlemap", false)
        while not HasStreamedTextureDictLoaded("circlemap") do
            Wait(100)
        end
    
        AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")
    
        SetMinimapClipType(1)
        SetMinimapComponentPosition('minimap', 'L', 'B', posX, posY, width, height)
        -- SetMinimapComponentPosition('minimap_mask', 'L', 'B', 0.0, 0.032, 0.101, 0.259)
        SetMinimapComponentPosition('minimap_mask', 'L', 'B', posX, posY, width, height)
        SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.01, 0.024, 0.256, 0.337)
    
        local minimap = RequestScaleformMovie("minimap")
        SetRadarBigmapEnabled(true, false)
        Wait(0)
        SetRadarBigmapEnabled(false, false)
    
        while true do
            Wait(0)
            BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
            ScaleformMovieMethodAddParamInt(3)
            EndScaleformMovieMethod()
        end
    end)
    
    local isPause = false
    local uiHidden = false
    
    Citizen.CreateThread(function()
        while true do
            Wait(50)
            if IsBigmapActive() or IsPauseMenuActive() and not isPause or IsRadarHidden() then
                if not uiHidden then
                    SendNUIMessage({
                        action = "hideUI"
                    })
                    uiHidden = true
                end
            elseif uiHidden or IsPauseMenuActive() and isPause then
                SendNUIMessage({
                    action = "displayUI"
                })
                uiHidden = false
            end
        end
    end)
end

RegisterNetEvent("stress:timed")
AddEventHandler("stress:timed",function(alteredValue,scenario)
	local removedStress = 0
	Wait(1000)

	
	--TriggerEvent("DoShortHudText",'Stress is being relieved',6)
	TriggerEvent("ESX:Notify",'Stress đang giảm','info')
	--SetPlayerMaxArmour(PlayerId(), 60 )
	while true do
		removedStress = removedStress + 10000
		if removedStress >= alteredValue then
			break
		end
        --local armor = GetPedArmour(PlayerPedId())
        --SetPedArmour(PlayerPedId(),armor+3)
		if scenario ~= "None" then
			if not IsPedUsingScenario(PlayerPedId(),scenario) then
				TriggerEvent("animation:cancel")
				break
			end
		end
		Citizen.Wait(1000)
	end
	TriggerEvent('esx_status:remove','stress', removedStress)
end)