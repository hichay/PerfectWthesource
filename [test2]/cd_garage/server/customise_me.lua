------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------ NOTIFICATIONS ---------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

function Success_Notification(source, message, input1, input2)
    if source ~= nil and message ~= nil then
        if Config.ServerNotification_Type == 'chat' then
            if input1 ~= nil and input2 ~= nil then
                TriggerClientEvent('chat:addMessage', source, {
                    template = '<div class="chat-message info"> <div class="chat-message-header"> <class="chat-message-body"> '..message..' '..input1..' '..input2})
            elseif input1 ~= nil then
                TriggerClientEvent('chat:addMessage', source, {
                template = '<div class="chat-message info"> <div class="chat-message-header"> <class="chat-message-body"> '..message..' '..input1})
            else
                TriggerClientEvent('chat:addMessage', source, {
                template = '<div class="chat-message info"> <div class="chat-message-header"> '..message})
            end

        elseif Config.ServerNotification_Type == 'mythic_old' then
            if input1 ~= nil and input2 ~= nil then
                TriggerClientEvent('mythic_notify:client:SendAlert:custom', source, { type = 'success', text = message..' '..input1..' '..input2, length = 10000})
            elseif input1 ~= nil then
                TriggerClientEvent('mythic_notify:client:SendAlert:custom', source, { type = 'success', text = message..' '..input1, length = 10000})
            else
                TriggerClientEvent('mythic_notify:client:SendAlert:custom', source, { type = 'success', text = message, length = 10000})
            end

        elseif Config.ServerNotification_Type == 'mythic_new' then
            if input1 ~= nil and input2 ~= nil then
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = message..' '..input1..' '..input2, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
            elseif input1 ~= nil then
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = message..' '..input1, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = message, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
            end

        elseif Config.ServerNotification_Type == 'esx' then
            if input1 ~= nil and input2 ~= nil then
                TriggerClientEvent('esx:showNotification', source, message..' '..input1..' '..input2)
            elseif input1 ~= nil then
                TriggerClientEvent('esx:showNotification', source, message..' '..input1)
            else
                TriggerClientEvent('esx:showNotification', source, message)
            end

        elseif Config.ServerNotification_Type == 'custom' then
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

-- function Error_Notification(message)
	-- TriggerEvent('ESX:Notify',source,message,'error')
-- end

-- function Success_Notification(message)
	-- TriggerEvent('ESX:Notify',source,message,'sucess')
-- end

function Error_Notification(source, message, input1)
    if source ~= nil and message ~= nil then
        if Config.ServerNotification_Type == 'chat' then
            if input1 ~= nil then
                TriggerClientEvent('chat:addMessage', source, {
                template = '<div class="chat-message info"> <div class="chat-message-header"> <class="chat-message-body"> '..message..' '..input1})
            else
                TriggerClientEvent('chat:addMessage', source, {
                template = '<div class="chat-message info"> <div class="chat-message-header"> <class="chat-message-body"> '..message})
            end

        elseif Config.ServerNotification_Type == 'mythic_old' then
            if input1 ~= nil then
                TriggerClientEvent('mythic_notify:client:SendAlert:custom', source, { type = 'error', text = message..' '..input1, length = 10000})
            else
                TriggerClientEvent('mythic_notify:client:SendAlert:custom', source, { type = 'error', text = message, length = 10000})
            end

        elseif Config.ServerNotification_Type == 'mythic_new' then
            if input1 ~= nil then
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text =  message..' '..input1, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = message, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
            end

        elseif Config.ServerNotification_Type == 'esx' then
            if input1 ~= nil then
                TriggerClientEvent('esx:showNotification', source, message..' '..input1)
            else
                TriggerClientEvent('esx:showNotification', source, message)
            end

        elseif Config.ServerNotification_Type == 'custom' then
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
-------------------------------------- FRAMEWORK FUNCTIONS -------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
function CheckMoney(source, amount)
    if Config.UseESX then
        local xPlayer = ESX.GetPlayerFromId(source)
		
        if xPlayer.getAccount('bank').money >= amount then
            xPlayer.removeAccountMoney('bank', amount)
            return true
        else
            return false
        end
    else
        return --add your non esx money checks here - (return true if the player has enough money and you have removed the money or return false if the player does not have enough money).
    end
end

function RemoveMoney(source, amount)
    if Config.UseESX then
		local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        xPlayer.removeAccountMoney('bank', amount)
    else
        --add your non esx remove money here - (remove the money).
    end
end

function GetJob(source)
    if Config.UseESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer.job.name
    else
        return --add your non esx job checks here - (return the jobname).
    end
end

function GetSteamID(source)
    if Config.UseESX then
        local xPlayer = ESX.GetPlayerFromId(_source)
        return xPlayer.identifier
    else
        return GetPlayerIdentifiers(source)[1]
    end
end
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
---------------------------------------------- WEBHOOKS ----------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
function ImpoundVehicleLogs_Config(action, playername, vehiclelabel, vehicleplate, impoundlocation)
    if action == 'impound' then
        ImpoundVehicleLogs('Impound', playername..' Impounded a '..vehiclelabel..' plate : ['..vehicleplate.. '] @ '..impoundlocation, 16711680)
    elseif action == 'unimpound' then
        ImpoundVehicleLogs('Impound', playername..' Unimpounded a '..vehiclelabel..' plate : ['..vehicleplate..']', 56108)
    end
end

function TransferVehicleLogs_Config(playername, vehicleplate, targetname)
    TransferVehicleLogs('Transfer Vehicle', playername.. 'transfered ['..vehicleplate..'] to '..targetname, 16744192)
end

function ExploitAlertLogs_Config(source, playername, newmodel, oldmodel, steamidentifier)
    ExploitAlertLogs('@everyone '..playername..' tried to spawn a vehicle with hash: ' ..newmodel.. '. His original vehicle: ' ..oldmodel..'\n```\nSteam: '..steamidentifier..'\n```')
    DropPlayer(source, 'Modding')
end
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
----------------------------------------- VEHICLE RELATED --------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
RegisterServerEvent('cd_garage:TransferVehicle')
AddEventHandler('cd_garage:TransferVehicle', function(plate, target, garage_type, fromUI)
    if plate and target and garage_type then
        local _source = source
        if GetPlayerName(target) ~= nil then
            if target ~= _source then
                local source_identifier = GetPlayerIdentifiers(_source)[1]
                local target_identifier = GetPlayerIdentifiers(target)[1]

                local car_count = GetGarageCount(target, garage_type)
                local car_limit = GetGarageLimit(target)
                if car_count < car_limit or not Config.UseGarageSpace then
                    if GetVehicleOwner(_source, plate) then
                        MySQL.Sync.execute("UPDATE owned_vehicles SET owner=@owner WHERE plate=@plate",{['@owner'] = target_identifier, ['@plate'] = plate})
                        Success_Notification(_source, Locales[Config.Language]['transfer_vehicle'], target, plate)
                        Success_Notification(target, Locales[Config.Language]['recieve_vehicle'], _source, plate)
                        if fromUI then
                            TriggerClientEvent('cd_garage:TransferVehicle:Callback', _source, true, Locales[Config.Language]['transfer_success'])
                        end

                        if Config.ExploitLogWebhook ~= false or Config.ExploitLogWebhook ~= 'false' or Config.ExploitLogWebhook ~= 'FALSE' or Config.ExploitLogWebhook ~= nil then
                            TransferVehicleLogs_Config(GetPlayerName(_source), plate, GetPlayerName(target))
                        end
                    else
                        Error_Notification(_source, Locales[Config.Language]['dont_own_vehicle'])
                    end
                else
                    if fromUI then
                        TriggerClientEvent('cd_garage:TransferVehicle:Callback', _source, false, Locales[Config.Language]['garage_full'])
                    else
                        Error_Notification(_source, Locales[Config.Language]['garage_full'])
                    end
                end
            else
                if fromUI then
                    TriggerClientEvent('cd_garage:TransferVehicle:Callback', _source, false, Locales[Config.Language]['cant_transfer_yourself'])
                else
                    Error_Notification(_source, Locales[Config.Language]['incorreccant_transfer_yourselft_id'])
                end
            end
        else
            if fromUI then
                TriggerClientEvent('cd_garage:TransferVehicle:Callback', _source, false, Locales[Config.Language]['incorrect_id'])
            else
                Error_Notification(_source, Locales[Config.Language]['incorrect_id'])
            end
        end
    end
end)

if Config.UseGarageSpace and (Config.GarageSpaceCommand ~= false or Config.GarageSpaceCommand ~= 'false' or Config.GarageSpaceCommand ~= 'FALSE' or Config.GarageSpaceCommand ~= nil) then
    RegisterCommand(Config.GarageSpaceCommand, function(source, args)
        local _source = source
        local identifier = GetPlayerIdentifiers(_source)[1]

        if args[1] == nil then
            MySQL.Async.fetchAll('SELECT garage_limit FROM users WHERE identifier=@identifier',{['@identifier'] = identifier}, function(result)
                if result[1] ~= nil then
                    local limit = tonumber(result[1].garage_limit)
                    Success_Notification(_source, Locales[Config.Language]['garage_space_check'], limit)
                end
            end)

        elseif args[1] == 'add' then
            local MyJob = GetJob(_source)
            if Config.GarageSpaceJobs[MyJob] ~= nil then
                if args[2] ~= nil then
                    local target = args[2]
                    local identifier = GetPlayerIdentifiers(target)[1]
                    if GetPlayerName(target) ~= nil then
                        MySQL.Async.fetchAll('SELECT firstname, lastname, garage_limit FROM users WHERE identifier=@identifier',{['@identifier'] = identifier}, function(result)
                            if result[1] ~= nil then
                                local rpname = result[1].firstname..' '..result[1].lastname
                                local limit = tonumber(result[1].garage_limit)
                                local price
                                if Config.GarageSpace ~= nil then
                                    if limit < #Config.GarageSpace then
                                        for i=1, #Config.GarageSpace do
                                            if i == limit then
                                                price = Config.GarageSpace[i]
                                                break
                                            end
                                        end
                                        
                                        if CheckMoney(_source, Config.ReturnVehiclePrice) then
                                            MySQL.Async.execute("UPDATE users SET garage_limit = @garage_limit WHERE identifier = @identifier",{['@identifier'] = identifier,['@garage_limit'] = limit+1})
                                            Success_Notification(_source, Locales[Config.Language]['add_garageslot'], rpname)
                                            Success_Notification(target, Locales[Config.Language]['recieve_garageslot'], limit+1)
                                        else
                                            Error_Notification(_source, Locales[Config.Language]['not_enough_cash'])
                                        end
                                    else
                                        Error_Notification(_source, Locales[Config.Language]['garage_full'])
                                    end
                                end
                            end
                        end)
                    else
                        Error_Notification(_source, Locales[Config.Language]['incorrect_id'])
                    end
                else
                    Error_Notification(_source, Locales[Config.Language]['enter_playerid_here'])
                end
            else
                Error_Notification(_source, Locales[Config.Language]['no_permissions'])
            end
        else
            Error_Notification(_source, Locales[Config.Language]['invalid_action'])
        end
    end)
end

RegisterServerEvent('cd_garage:DeleteVehicleADV')
AddEventHandler('cd_garage:DeleteVehicleADV', function(net)
    local _source = source
    TriggerClientEvent('cd_garage:DeleteVehicleADV', _source, net)
end)