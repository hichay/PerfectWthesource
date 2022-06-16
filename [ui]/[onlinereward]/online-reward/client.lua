
        ESX = nil 
        local menu_active = nil 
        Citizen.CreateThread(function() 
            while ESX == nil do 
                TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
                Citizen.Wait(0) 
            end 
        end)
    
function LoadRewardData() 
    ESX.TriggerServerCallback('online-reward:getTotalDay', function(data) 
        local day = data and data.day or 0 
        local taken = data and data.state or 0
        if not menu_active then 
            SetTimecycleModifierStrength(0) 
            SetTimecycleModifier('hud_def_blur') 
            Citizen.CreateThread(function() 
                for i = 1, 50 do 
                    Citizen.Wait(0) 
                    SetTimecycleModifierStrength(i / 50) 
                end 
            end) 
        end 
        
        menu_active = true 
        SendNUIMessage({type = 'load_data', day = day, taken = taken, data = Config["daily_reward"], title = Config["daily_title"], desc = Config["daily_desc"]}) SetNuiFocus(true, true) end) end 
		RegisterNUICallback("Close", function(data, cb) SetNuiFocus(false, false) Citizen.CreateThread(function() 
			local c = 1.0
            for i = 1, 50 do 
                Citizen.Wait(0) 
                c = c - 0.02 
                SetTimecycleModifierStrength(c) 
            end 
            SetTimecycleModifier('default') 
            menu_active = nil 
        end) 
    end) 
    
    local checkin_delay 
    
    RegisterNUICallback("Checkin", function(data, cb) 
        if checkin_delay and checkin_delay > GetGameTimer() then
            return 
        end 
        
        checkin_delay = GetGameTimer() + 1000 
        ESX.TriggerServerCallback('online-reward:checkIn', function(state) 
            if state then 
                LoadRewardData() 
                SendNUIMessage({type = 'dialog', title = Config["translate"]["checkIn"], message = Config["translate"]["checkIn2"]}) 
                SendNUIMessage({type = 'noti', state = false, btn = Config["daily_menu_key_text"] or "UNKNOWN"}) 
                SendNUIMessage({type = 'bell',})
            else 
                SendNUIMessage({type = 'dialog', title = Config["translate"]["already_checkin"], message = Config["translate"]["already_checkin2"]}) 
            end 
        end) 
    end) 
    
    Citizen.CreateThread(function() 
        Citizen.Wait(500) 
        ESX.TriggerServerCallback('online-reward:getTotalDay', function(data) 
            if not data.state then 
                SendNUIMessage({type = 'noti', state = true, btn = Config["daily_menu_key_text"] or "UNKNOWN"}) 
            end 
        end) 
        while true do 
            Citizen.Wait(0) 
            if IsControlPressed(0, Config["daily_menu_key"] or 57) then 
                LoadRewardData() 
                Citizen.Wait(1000) 
            end 
        end 
    end) 


