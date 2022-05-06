Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/'..Config.CommandName, 'Callsign for the dispatch', {{ name="action", help='[show / set / delete]'}, { name="callsign", help='Enter the name of your chosen callsign'}})
end)

Config.Client_Locales = { --Customise the client sided notification message.
    ['EN'] = {
        ['cooldown'] = 'There is a 1 second cooldown when pressing G to avoid issues',
    },

    ['FR'] = {
        ['cooldown'] = 'Le nom ne peut pas dépasser 10 caractères',
    },

    ['ES'] = {
        ['cooldown'] = 'El nombre no puede tener más de 10 caracteres',
    },
}

RegisterNetEvent('cd_dispatch:Error_Notification')
AddEventHandler('cd_dispatch:Error_Notification', function(message)
    if Config.ClientNotification_Type == 'chat' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message info"> <div class="chat-message-header"> <class="chat-message-body"> <i class="fas fa-house-user"></i> <b>PERSONAL SPAWN :</b> '..message})

    elseif Config.ClientNotification_Type == 'mythic_old' then
        exports['mythic_notify']:DoCustomHudText('error', message, 10000)

    elseif Config.ClientNotification_Type == 'mythic_new' then
        exports['mythic_notify']:DoHudText('error', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })

    elseif Config.ClientNotification_Type == 'esx' then
        ESX.ShowNotification(message)

    elseif Config.ClientNotification_Type == 'custom' then
        --enter custom notification here
		TriggerEvent("ESX:Notify",message,"error")
    end
end)

function BlipSound(sound)
    if sound == 1 then
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
    elseif sound == 2 then
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
        Wait(900)
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
    elseif sound == 3 then 
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
        Wait(900)
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
        Wait(900)
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
    elseif sound == 4 then 
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.0, 'panic', 0.5)
    end
end










------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
---------- CHAT COMMANDS (OPTIONAL) Remove/hash our if you don not want to use these. ----------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
local hasSentpanic = false
local charname = nil
local charnumber = nil
local phoneBox = {
    {'prop_phonebox_04'},
    {'p_phonebox_02_s'},
    {'p_phonebox_01b_s'},
    {'prop_phonebox_01a'},
    {'prop_phonebox_01b'},
    {'prop_phonebox_01c'},
    {'prop_phonebox_02'},
    {'prop_phonebox_03'},
}
local JobsTable = {
    ['police'] = {CommandName = '911', Job = 'police'},
	['ambulance'] = {CommandName = 'ems', Job = 'ambulance'},
	['cardealer'] = {CommandName = 'cardealer', Job = 'cardealer'},
	['realestate'] = {CommandName = 'realestate', Job = 'realestate'},
	['taxi'] = {CommandName = 'taxi', Job = 'taxi'},
}

RegisterNetEvent('cd_dispatch:GetCharName')
AddEventHandler('cd_dispatch:GetCharName', function(charname2)
    charname = charname2
end)

RegisterNetEvent('cd_dispatch:GetCharNumber')
AddEventHandler('cd_dispatch:GetCharNumber', function(charnumber2)
    charnumber = charnumber2
end)

Citizen.CreateThread(function()
    for k, v in pairs(JobsTable) do
        TriggerEvent('chat:addSuggestion', '/'..v.CommandName, 'Send a call to any available '..v.Job:gsub("^%l", string.upper)..' - They will recieve your location.', {{ name='message', help='Enter the message to send (In Character)'}})
    end
    TriggerEvent('chat:addSuggestion', '/reply', 'Reply to a dispatch call', {{ name='callerid', help='ID of the caller (server ID)'}, { name='message', help='Enter the message to send (In Character)'}})
end)

for k, v in pairs(JobsTable) do
    RegisterCommand(v.CommandName, function(source, args)
        local ped = GetPlayerPed(-1)
        local message = table.concat(args, ' ')
        -- local coords = GetEntityCoords(ped)
        -- local isNearPhone = false
        -- for k, p in pairs(phoneBox) do
        --     local object = GetClosestObjectOfType(coords, 1.0, GetHashKey(p), false, false, false)
        --     if DoesEntityExist(object) then
        --         local phone = GetEntityCoords(entity)
        --         if #(coords-phone) < 1.2 then
        --             isNearPhone = true
        --             break
        --         end
        --     end
        -- end

        -- if isNearPhone then
            if args[1] ~= nil then
                while charname == nil do Wait(500) TriggerServerEvent('cd_dispatch:GetCharName') end
                while charnumber == nil do Wait(500) TriggerServerEvent('cd_dispatch:GetCharNumber') end
                TriggerServerEvent('cd_dispatch:CallCommand', {job = v.Job, message = message, charnumber = charnumber, charname = charname, callinfo = exports['cd_dispatch']:GetPlayerInfo()})
                PlayAnimation('cellphone@', 'cellphone_call_listen_base', 5000)
            else
                exports['mythic_notify']:DoLongHudText('error', 'Please enter your message to be sent to the '..v.Job)
            end
        -- else
        --     exports['mythic_notify']:DoLongHudText('error', 'Get a phone before you try call the '..v.Job..' or use a payphone')
        -- end
    end)
end

RegisterCommand('reply', function(source, args)
    local job = GetJob()
    if JobsTable[job] ~= nil then
        local ped = GetPlayerPed(-1)
        local targetid = args[1]
        local message = table.concat(args, ' ')

        if targetid ~= nil then
            local length = #targetID+1
            local message = message:sub(tonumber(length))
            if #message > 0 then
                while charname == nil do Wait(500) TriggerServerEvent('cd_dispatch:GetCharName') end
                TriggerServerEvent('cd_dispatch:CallCommand:Reply', {job = job, targetid = targetid, message = message, charname = charname})
            else
                exports['mythic_notify']:DoLongHudText('error', 'Enter the message to send')
            end
        else
            exports['mythic_notify']:DoLongHudText('error', 'Enter a player ID')
        end
    else
        exports['mythic_notify']:DoCustomHudText('error', 'You do not have permission to use this command', 10000)
    end
end)

RegisterCommand('panic', function(source, args)
    if not hasSentpanic then
        local job = GetJob()
        if job == 'police' then
            hasSentpanic = true
            while charname == nil do Wait(500) TriggerServerEvent('cd_dispatch:GetCharName') end
            TriggerServerEvent('cd_dispatch:CallCommand:Panic', {job = job, charname = charname, callinfo = exports['cd_dispatch']:GetPlayerInfo()})
            PlayAnimation('random@arrests', 'generic_radio_chatter', 1000)
            Wait(30000)
            hasSentpanic = false
        else
            exports['mythic_notify']:DoCustomHudText('error', 'You do not have permission to use this command', 10000)
        end
    else
        exports['mythic_notify']:DoLongHudText('error', 'You dont need to spam this')
    end
end)

function PlayAnimation(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end



RegisterCommand('dispatchtest', function()
     TriggerServerEvent('dispatchtest', exports['cd_dispatch']:GetPlayerInfo())
--     --TriggerServerEvent('testevent', exports['cd_dispatch']:GetPlayerInfo(), vector3(0,0,0)) --if you want to send a set location instead of the players location you can add them here.
end)