------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------ CHAT COMMANDS ---------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------


TriggerEvent('jhslkdf:sadkGARAGEkjdfs',true)


Citizen.CreateThread(function()
    if Config.UseImpound and (Config.ImpoundCommand ~= false or Config.ImpoundCommand ~= 'false' or Config.ImpoundCommand ~= 'FALSE' or Config.ImpoundCommand ~= nil) then
        TriggerEvent('chat:addSuggestion', '/'..Config.ImpoundCommand, 'Impound a vehicle')
    end
    if Config.UseMileage and (Config.CheckMilesCommand ~= false or Config.CheckMilesCommand ~= 'false' or Config.CheckMilesCommand ~= 'FALSE' or Config.CheckMilesCommand ~= nil) then
        TriggerEvent('chat:addSuggestion', '/'..Config.CheckMilesCommand, 'Check the mileage of your vehicle')
    end
    if Config.UseGarageSpace and (Config.GarageSpaceCommand ~= false or Config.GarageSpaceCommand ~= 'false' or Config.GarageSpaceCommand ~= 'FALSE' or Config.GarageSpaceCommand ~= nil) then
        TriggerEvent('chat:addSuggestion', '/'..Config.GarageSpaceCommand, 'Check your garage limit', {{ name="add", help='CARDEALERS ONLY - Purchase an extra garage slot for a customer'}, { name="playerid", help='CARDEALERS ONLY - The ID of the player'}})
    end
    if (Config.TransferVehicleCommand ~= false or Config.TransferVehicleCommand ~= 'false' or Config.TransferVehicleCommand ~= 'FALSE' or Config.TransferVehicleCommand ~= nil) then
        TriggerEvent('chat:addSuggestion', '/'..Config.TransferVehicleCommand, 'Transfer your vehicle to another player', {{ name="serverid", help='The players server ID'}})
    end
    TriggerEvent('chat:addSuggestion', '/closeall', 'This command force closes all menu\'s and UI\'s. - You can also use this command in F8 just without the /')
end)

if Config.UseImpound and (Config.ImpoundCommand ~= false or Config.ImpoundCommand ~= 'false' or Config.ImpoundCommand ~= 'FALSE' or Config.ImpoundCommand ~= nil) then
    RegisterCommand(Config.ImpoundCommand, function()
        if IsAllowed() then
            TriggerEvent('cd_garage:ImpoundVehicle')
        else
            TriggerEvent('cd_garage:Error_Notification', Locales[Config.Language]['no_permissions_impounding'])
        end
    end)
end

if Config.UseMileage and (Config.CheckMilesCommand ~= false or Config.CheckMilesCommand ~= 'false' or Config.CheckMilesCommand ~= 'FALSE' or Config.CheckMilesCommand ~= nil) then
    RegisterCommand(Config.CheckMilesCommand, function()
        TriggerEvent('cd_garage:checkmileage')
    end)
end

if Config.UseTransferVehicle and (Config.TransferVehicleCommand ~= false or Config.TransferVehicleCommand ~= 'false' or Config.TransferVehicleCommand ~= 'FALSE' or Config.TransferVehicleCommand ~= nil) then
    RegisterCommand(Config.TransferVehicleCommand, function(source, args)
        TransferVehicle(false, args[1])
    end)
end

RegisterCommand('closeall', function()
    CloseAllNUI()
end)
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------ NOTIFICATIONS ---------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
function Success_Notification(message, input1, input2)
    if message ~= nil then
        if Config.ClientNotification_Type == 'chat' then
            if input1 ~= nil and input2 ~= nil then
                TriggerEvent('chat:addMessage', {
                template = '<div class="chat-message info"> <div class="chat-message-header"> <class="chat-message-body"> '..message..' '..input1..' '..input2})
            elseif input1 ~= nil then
                TriggerEvent('chat:addMessage', {
                template = '<div class="chat-message info"> <div class="chat-message-header"> <class="chat-message-body"> '..message..' '..input1})
            else
                TriggerEvent('chat:addMessage', {
                template = '<div class="chat-message info"> <div class="chat-message-header"> <class="chat-message-body"> '..message})
            end

        elseif Config.ClientNotification_Type == 'mythic_old' then
            if input1 ~= nil and input2 ~= nil then
                exports['mythic_notify']:DoCustomHudText('success', message..' '..input1..' '..input2, 10000)
            elseif input1 ~= nil then
                exports['mythic_notify']:DoCustomHudText('success', message..' '..input1, 10000)
            else
                exports['mythic_notify']:DoCustomHudText('success', message, 10000)
            end

        elseif Config.ClientNotification_Type == 'mythic_new' then
            if input1 ~= nil and input2 ~= nil then
                exports['mythic_notify']:DoHudText('success', message..' '..input1..' '..input1, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            elseif input1 ~= nil then
                exports['mythic_notify']:DoHudText('success', message..' '..input1, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            else
                exports['mythic_notify']:DoHudText('success', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            end

        elseif Config.ClientNotification_Type == 'esx' then
            if input1 ~= nil and input2 ~= nil then
            ESX.ShowNotification(message..' '..input1..' '..input1)
            elseif input1 ~= nil then
                ESX.ShowNotification(message..' '..input1)
            else
                ESX.ShowNotification(message)
            end

        elseif Config.ClientNotification_Type == 'custom' then
            if input1 ~= nil and input2 ~= nil then
                --enter custom notification here
            elseif input1 ~= nil then
                --enter custom notification here
            else
                --enter custom notification here
            end
        end
    end
end

function Error_Notification(message, input1)
    if message ~= nil then
        if Config.ClientNotification_Type == 'chat' then
            if input1 ~= nil then
                TriggerEvent('chat:addMessage', {
                template = '<div class="chat-message info"> <div class="chat-message-header"> <class="chat-message-body"> '..message..' '..input1})
            else
                TriggerEvent('chat:addMessage', {
                template = '<div class="chat-message info"> <div class="chat-message-header"> <class="chat-message-body"> '..message})
            end

        elseif Config.ClientNotification_Type == 'mythic_old' then
            if input1 ~= nil then
                exports['mythic_notify']:DoCustomHudText('error', message..' '..input1, 10000)
            else
                exports['mythic_notify']:DoCustomHudText('error', message, 10000)
            end

        elseif Config.ClientNotification_Type == 'mythic_new' then
            if input1 ~= nil then
                exports['mythic_notify']:DoHudText('error', message..' '..input1, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            else
                exports['mythic_notify']:DoHudText('error', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            end

        elseif Config.ClientNotification_Type == 'esx' then
            if input1 ~= nil then
                ESX.ShowNotification(message..' '..input)
            else
                ESX.ShowNotification(message)
            end

        elseif Config.ClientNotification_Type == 'custom' then
            if input1 ~= nil then
                --enter custom notification here
            else
                --enter custom notification here
            end
        end
    end
end
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--------------------------------------------- OTHER --------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
function IsAllowed()
    if Config.AllowedJobsImpound[GetJob()] then
        return true
    else
        return false
    end
end

function GetJob()
    if Config.UseESX then
        while ESX.PlayerData == nil or ESX.PlayerData.job == nil or ESX.PlayerData.job.name == nil do
            Wait(0)
        end
        return ESX.PlayerData.job.name
    else
        return --add your non esx job checks here - (return the jobname).
    end
end

function ToggleShellTime(toggle)
    if toggle == 'enter' then
        if Config.ShellTimeScript == 'easytime' then
            TriggerEvent('cd_easytime:PauseSync', true)
        elseif Config.ShellTimeScript == 'vsync' then
            TriggerEvent('vSync:toggle',false)
            NetworkOverrideClockTime(23, 00, 00)
        elseif Config.ShellTimeScript == 'other' then
            --enter other here
        end
    elseif toggle == 'exit' then
        if Config.ShellTimeScript == 'easytime' then
            TriggerEvent('cd_easytime:PauseSync', false)
        elseif Config.ShellTimeScript == 'vsync' then
            TriggerEvent('vSync:toggle',true)
            TriggerServerEvent('vSync:requestSync')
        elseif Config.ShellTimeScript == 'other' then
            --enter other here
        end
    end
end

Citizen.CreateThread(function()
    for k, v in pairs (Config.Locations) do
        if v.Type ~= nil then
            local blip = AddBlipForCoord(v.x_1, v.y_1, v.z_1)
            SetBlipSprite (blip, Config.Blip[v.Type].sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale  (blip, Config.Blip[v.Type].scale)
            SetBlipColour (blip, Config.Blip[v.Type].colour)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            if Config.BlipNames then
                AddTextComponentSubstringPlayerName(Config.Blip[v.Type].name..':'..v.Garage_ID)
            else
                AddTextComponentSubstringPlayerName(Config.Blip[v.Type].name)
            end
            EndTextCommandSetBlipName(blip)
        end
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        TriggerEvent('cd_drawtextui:HideUI')
        if MyCars ~= nil then
            for g=1, #MyCars do
                if MyCars[g] ~= nil then
                    SetEntityAsNoLongerNeeded(MyCars[g].vehicle)
                    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(MyCars[g].vehicle))
                    DeleteEntity(MyCars[g].vehicle)
                    DeleteVehicle(MyCars[g].vehicle)
                end
            end
        end
        SetNuiFocus(false, false)
        if shell then
            DeleteGarage()
        end
    end
end)
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--------------------------------------- VEHICLE RELATED ----------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
function SaveFuelCustom(vehicle, plate)
    return nil --return nil if you want to use the default one in esx vehicle props.
    -- OR
    --return Round(GetVehicleFuelLevel(vehicle), 1) --add your custom code to get the fuel of the vehicle you are storing and save it in the props.
end

function TransferVehicle(fromui, targetID, plate, garage_type)
    if fromui then
        TriggerServerEvent('cd_garage:TransferVehicle', plate, targetID, garage_type, fromui)
    else
        local ped = GetPlayerPed(-1)
        if IsPedInAnyVehicle(ped, false) then
            local veh = GetVehiclePedIsUsing(ped)
            local plate = tostring(GetVehicleNumberPlateText(veh))
            local hash = GetEntityModel(veh)

            if Config.Blasklist_transfer[hash] == nil or Config.Blasklist_transfer[hash] ~= true then
                if not fromui then
                    garage_type = nil
                    if IsPedInAnyHeli(ped) or IsPedInAnyPlane(ped) then
                        garage_type = 'air'
                    elseif IsPedInAnySub(ped) or IsPedInAnyBoat(ped) then
                        garage_type = 'boat'
                    elseif IsPedInAnyVehicle(ped, false) then
                        garage_type = 'car'
                    end
                end
                if garage_type ~= nil then
                    TriggerServerEvent('cd_garage:TransferVehicle', plate, targetID, garage_type, fromui)
                else
                    TriggerEvent('cd_garage:Error_Notification', Locales[Config.Language]['no_vehicle_found'])
                end
            else
                TriggerEvent('cd_garage:Error_Notification', Locales[Config.Language]['transfer_blacklisted'])
            end
        else
            TriggerEvent('cd_garage:Error_Notification', Locales[Config.Language]['get_inside_veh'])
        end
    end
end