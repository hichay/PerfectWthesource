Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

ESX = nil

Citizen.CreateThread(function() 
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)    
        Citizen.Wait(200)
    end
end)

local uiOpen = false
local currentRegister   = 0
local currentSafe = 0
local copsCalled = false
local CurrentCops = 0
local PlayerJob = {}
local onDuty = false
local usingAdvanced = false

Citizen.CreateThread(function()
    Wait(1000)
    if ESX.GetPlayerData().job ~= nil and next(ESX.GetPlayerData().job) then
        PlayerJob = ESX.GetPlayerData().job
    end
end)
RegisterCommand('fuck2', function()
		 TriggerServerEvent("rl-storerobbery:server:takeMoney",1,true)
		
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000 * 60 * 5)
        if copsCalled then
            copsCalled = false
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    setupRegister()
    setupSafes()
    while true do
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local inRange = false
        for k, v in pairs(Config.Registers) do
            local dist = GetDistanceBetweenCoords(pos, Config.Registers[k].x, Config.Registers[k].y, Config.Registers[k].z)

            if dist <= 1 and Config.Registers[k].robbed then
                inRange = true
                DrawText3Ds(Config.Registers[k].x, Config.Registers[k].y, Config.Registers[k].z, 'Máy tính tiền này đã bị cạy.')
            end
        end
        if not inRange then 
            Citizen.Wait(2000)
        end
        Citizen.Wait(3)
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        local inRange = false
        if ESX ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            for safe,_ in pairs(Config.Safes) do
                local dist = GetDistanceBetweenCoords(pos, Config.Safes[safe].x, Config.Safes[safe].y, Config.Safes[safe].z)
                if dist < 3 then
                    inRange = true
                    if dist < 1.0 then
                        if not Config.Safes[safe].robbed then
                            DrawText3Ds(Config.Safes[safe].x, Config.Safes[safe].y, Config.Safes[safe].z, '~g~E~w~ - Thử mở két')
                            if IsControlJustPressed(0, Keys["E"]) then
                                if CurrentCops >= Config.MinimumStoreRobberyPolice then
                                    currentSafe = safe
                                    -- if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
                                        -- TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                                    -- end
                                    -- if math.random(100) <= 50 then
                                        -- TriggerServerEvent('rl-hud:Server:GainStress', math.random(1, 3))
                                    -- end
                                    if Config.Safes[safe].type == "keypad" then
                                        SendNUIMessage({
                                            action = "openKeypad",
                                        })
                                        SetNuiFocus(true, true)
                                    else
                                        ESX.TriggerServerCallback('rl-storerobbery:server:getPadlockCombination', function(combination)
                                            TriggerEvent("SafeCracker:StartMinigame", combination)
                                        end, safe)
                                    end

                                    local pos = GetEntityCoords(GetPlayerPed(-1))
                                    local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
                                    local street1 = GetStreetNameFromHashKey(s1)
                                    local street2 = GetStreetNameFromHashKey(s2)
                                    local streetLabel = street1
                                    if street2 ~= nil then 
                                        streetLabel = streetLabel .. " " .. street2
                                    end
                                    if copsCalled == false then
                                        --TriggerEvent('dispatch:storeRobbery', 'Store Robbery: Safe Cracking In Progress')
										TriggerServerEvent('rl-storerobbery:calldispatch', exports['cd_dispatch']:GetPlayerInfo())
                                        TriggerServerEvent("rl-storerobbery:server:callCops", "safe", currentSafe)
                                        copsCalled = true
                                    end
                                else
									TriggerEvent("DoLongHudText","Not enough police.")
                                end
                            end
                        else
                            DrawText3Ds(Config.Safes[safe].x, Config.Safes[safe].y, Config.Safes[safe].z, 'Két này đã bị mở.')
                        end
                    end
                end
            end
        end

        if not inRange then
            Citizen.Wait(2000)
        end
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
	playerData = ESX.GetPlayerData()
    PlayerJob = ESX.GetPlayerData().job
    onDuty = true
end)

RegisterNetEvent('RLCore:Client:SetDuty')
AddEventHandler('RLCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerJob = job
	ESX.PlayerData.job = job
    onDuty = true
end)

RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('lockpicks:UseLockpick')
AddEventHandler('lockpicks:UseLockpick', function(isAdvanced)
    usingAdvanced = isAdvanced
    for k, v in pairs(Config.Registers) do
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local dist = GetDistanceBetweenCoords(pos, Config.Registers[k].x, Config.Registers[k].y, Config.Registers[k].z)
        if dist <= 1 and not Config.Registers[k].robbed then
            if CurrentCops >= Config.MinimumStoreRobberyPolice then
                if usingAdvanced then
                    lockpick(true)
                    currentRegister = k
                    if not IsWearingHandshoes() then
                        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                    end
                    
                    local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
                    local street1 = GetStreetNameFromHashKey(s1)
                    local street2 = GetStreetNameFromHashKey(s2)
                    local streetLabel = street1
                    if street2 ~= nil then 
                        streetLabel = streetLabel .. " " .. street2
                    end
                    if math.random(1, 10) <= 5 then
                        TriggerServerEvent("rl-storerobbery:server:callCops", "cashier", currentRegister)
                        TriggerServerEvent('rl-storerobbery:calldispatch', exports['cd_dispatch']:GetPlayerInfo())						
                        --TriggerEvent('dispatch:storeRobbery', 'Store Robbery: Cash Register Lockpicking in progress')
                    end
                else
                   
					if exports["pw-inventory"]:hasEnoughOfItem("lockpick",1,false) then
						lockpick(true)
						currentRegister = k
						if not IsWearingHandshoes() then
							TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
						end
						-- local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
						-- local street1 = GetStreetNameFromHashKey(s1)
						-- local street2 = GetStreetNameFromHashKey(s2)
						-- local streetLabel = street1
						-- if street2 ~= nil then 
							-- streetLabel = streetLabel .. " " .. street2
						-- end
						if math.random(1, 10) <= 5 then
							TriggerServerEvent("rl-storerobbery:server:callCops", "cashier", currentRegister)
							TriggerServerEvent('rl-storerobbery:calldispatch', exports['cd_dispatch']:GetPlayerInfo())
							--TriggerEvent('dispatch:storeRobbery', 'Store Robbery: Cash Register Lockpicking in progress')
						end
					else
						TriggerEvent("DoLongHudText","You are missing a screwdriver.")
					end
                end
                
            else
				TriggerEvent("DoLongHudText","Not enough police.")
            end
        end
    end
end)

function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(GetPlayerPed(-1), 3)
    local model = GetEntityModel(GetPlayerPed(-1))
    local retval = true
    
    if model == GetHashKey("mp_m_freemode_01") then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

function setupRegister()
    ESX.TriggerServerCallback('rl-storerobbery:server:getRegisterStatus', function(Registers)
        for k, v in pairs(Registers) do
            Config.Registers[k].robbed = Registers[k].robbed
        end
    end)
end

function setupSafes()
    ESX.TriggerServerCallback('rl-storerobbery:server:getSafeStatus', function(Safes)
        for k, v in pairs(Safes) do
            Config.Safes[k].robbed = Safes[k].robbed
        end
    end)
end

DrawText3Ds = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("CUSTOM_TEXT")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function lockpick(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool,
    })
    SetCursorLocation(0.5, 0.2)
    uiOpen = bool
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(100)
    end
end

function takeAnim()
    local ped = GetPlayerPed(-1)
    while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do
        RequestAnimDict("amb@prop_human_bum_bin@idle_b")
        Citizen.Wait(100)
    end
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "idle_d", 8.0, 8.0, -1, 50, 0, false, false, false)
    Citizen.Wait(2500)
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "exit", 8.0, 8.0, -1, 50, 0, false, false, false)
end

local openingDoor = false
RegisterNUICallback('success', function()
    if currentRegister ~= 0 then
        lockpick(false)
        TriggerServerEvent('rl-storerobbery:server:setRegisterStatus', currentRegister)
        local lockpickTime = 30000
        LockpickDoorAnim(lockpickTime)
        ESX.Progressbar("search_register", "Đang lục máy tính tiền", lockpickTime, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "veh@break_in@0h@p_m_one@",
            anim = "low_force_entry_ds",
            flags = 16,
        }, {}, {}, function() -- Done
            openingDoor = false
            ClearPedTasks(GetPlayerPed(-1))
            TriggerServerEvent('rl-storerobbery:server:takeMoney', currentRegister, true)            
            currentRegister = 0
        end, function() -- Cancel
            openingDoor = false
            ClearPedTasks(GetPlayerPed(-1))
			TriggerEvent("DoLongHudText","Hủy")
            currentRegister = 0
        end)
        Citizen.CreateThread(function()
            while openingDoor do
                TriggerServerEvent('rl-hud:Server:GainStress', math.random(1, 3))
                Citizen.Wait(10000)
            end
        end)
    else
        SendNUIMessage({
            action = "kekw",
        })
    end
end)

function LockpickDoorAnim(time)
    time = time / 1000
    loadAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(GetPlayerPed(-1), "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    Citizen.CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(2000)
            time = time - 2
            TriggerServerEvent('rl-storerobbery:server:takeMoney', currentRegister, false)
            if time <= 0 then
                openingDoor = false
                StopAnimTask(GetPlayerPed(-1), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
    end)
end

RegisterNUICallback('callcops', function()
    TriggerEvent("police:SetCopAlert")
end)

RegisterNetEvent('SafeCracker:EndMinigame')
AddEventHandler('SafeCracker:EndMinigame', function(won)
    if currentSafe ~= 0 then
        if won then
			
            if currentSafe ~= 0 then
				
                if not Config.Safes[currentSafe].robbed then
                    SetNuiFocus(false, false)
                    TriggerServerEvent("rl-storerobbery:server:SafeReward1",currentSafe)
                    TriggerServerEvent("rl-storerobbery:server:setSafeStatus", currentSafe)
                    currentSafe = 0
                    takeAnim()
                end
            else
                SendNUIMessage({
                    action = "kekw",
                })
            end
        end
    end
    copsCalled = false
end)

RegisterNUICallback('PadLockSuccess', function()
    if currentSafe ~= 0 then
        if not Config.Safes[currentSafe].robbed then
            SendNUIMessage({
                action = "kekw",
            })
        end
    else
        SendNUIMessage({
            action = "kekw",
        })
    end
end)

RegisterNUICallback('PadLockClose', function()
    SetNuiFocus(false, false)
    
end)

RegisterNUICallback("CombinationFail", function(data, cb)
    PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
end)

RegisterNUICallback('fail', function()
    if usingAdvanced then
        if math.random(1, 100) < 30 then
           
			TriggerEvent('inventory:removeItem','advancedlockpick', 1)
            -- TriggerEvent('inventory:client:ItemBox', RLCore.Shared.Items["advancedlockpick"], "remove")
        end
    else
        if math.random(1, 100) < 70 then
			TriggerEvent('inventory:removeItem','lockpick', 1)
            -- TriggerEvent('inventory:client:ItemBox', RLCore.Shared.Items["lockpick"], "remove")
        end
    end
    if (IsWearingHandshoes() and math.random(1, 100) <= 25) then
        local pos = GetEntityCoords(GetPlayerPed(-1))
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
		TriggerEvent("DoLongHudText","Lockpick đã bị gãy.")
    end
    lockpick(false)
end)

RegisterNUICallback('exit', function()
    lockpick(false)
end)

RegisterNUICallback('TryCombination', function(data, cb)
    ESX.TriggerServerCallback('rl-storerobbery:server:isCombinationRight', function(combination)
        if tonumber(data.combination) ~= nil then
            if tonumber(data.combination) == combination then
                TriggerServerEvent("rl-storerobbery:server:SafeReward1",currentSafe)
                TriggerServerEvent("rl-storerobbery:server:setSafeStatus", currentSafe)
                SetNuiFocus(false, false)
                SendNUIMessage({
                    action = "closeKeypad",
                    error = false,
                })
                currentSafe = 0
                takeAnim()
            else
                TriggerEvent("police:SetCopAlert")
                SetNuiFocus(false, false)
                SendNUIMessage({
                    action = "closeKeypad",
                    error = true,
                })
                currentSafe = 0
            end
        end
    end, currentSafe)
end)

RegisterNetEvent('rl-storerobbery:client:setRegisterStatus')
AddEventHandler('rl-storerobbery:client:setRegisterStatus', function(register, bool)
    Config.Registers[register].robbed = bool
end)

RegisterNetEvent('rl-storerobbery:client:setSafeStatus')
AddEventHandler('rl-storerobbery:client:setSafeStatus', function(safe, bool)
    Config.Safes[safe].robbed = bool
end)



-- RegisterNetEvent("rl-storerobbery:reward")
-- AddEventHandler("rl-storerobbery:reward", function(labelcode)
	-- if math.random(1, 100) <= 15 then
		-- TriggerEvent("player:receiveItem","notepiece",1,true,true,labelcode)
	-- else
		-- TriggerEvent("player:receiveItem","cashroll",math.random(1,5),true,true,"Tiền không rõ nguồn gốc")
	-- end
-- end)


-- RegisterNetEvent("rl-storerobbery:Safereward")
-- AddEventHandler("rl-storerobbery:Safereward", function()
	-- if math.random(1, 100) <= 20 then
		-- TriggerEvent("player:receiveItem","cashstack",math.random(1,5),true,true,"Tiền không rõ nguồn gốc")
	-- else
		-- TriggerEvent("player:receiveItem","cashroll",math.random(5,15),true,true,"Tiền không rõ nguồn gốc")
	-- end
-- end)