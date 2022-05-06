local ReqClose = false local CloseData = {}

Notification = function(msg)
    if type(Cfg.notify.arg) == 'table' then
        if Cfg.notify.arg.text then
            Cfg.notify.arg.text = '%s'
            Cfg.notify.arg.text = tostring(Cfg.notify.arg.text):format(msg)
        end
    elseif type(Cfg.notify.arg) == 'string' then
        Cfg.notify.arg = '%s'
        Cfg.notify.arg = tostring(Cfg.notify.arg):format(msg)
    end
    TriggerEvent(Cfg.notify.event, Cfg.notify.arg, Cfg.notify.arg2)

end

RegisterNetEvent('pw-motelsbusiness:Notification')
AddEventHandler('pw-motelsbusiness:Notification', function (data)
    SendNUIMessage({type = 'notification', msg = data.text, ms = data.ms})
end)

RegisterNetEvent('pw-motelsbusiness:StopRentCycle')
AddEventHandler('pw-motelsbusiness:StopRentCycle', function(upval, data)
    ReqClose = upval
    CloseData = data
end)

function HasPermission(isOwned, player, type)
    if (isOwned) or (EmployeeMotels[player] and EmployeeMotels[player].permissions[type]) then
        return true
    else
        return false
    end
end

function GetPlayers()
    if Cfg.QBCore then
        return ESX.Functions.GetPlayers()
    else
        return ESX.Game.GetPlayers()
    end
end

function GetPlayerData()
    if not Cfg.QBCore then
        return ESX.GetPlayerData()
    else
        return ESX.Functions.GetPlayerData()
    end
    return false
end

function Identifier()
    if Cfg.identifierType == "citizenid" then
        return GetPlayerData().citizenid
    elseif Cfg.identifierType == "identifier" then
        return GetPlayerData().identifier 
    end
end

function GetTimer(target)
    local text = "0"
    if PlayersMotels[target] then
        if PlayersMotels[target].rentcycle then
            if PlayersMotels[target].rentcycle <= tonumber('60000') then
                text = tostring(math.floor(PlayersMotels[target].rentcycle/tonumber('1000')))..' '.._U['second']
            elseif PlayersMotels[target].rentcycle > tonumber('60000') and PlayersMotels[target].rentcycle < tonumber('3600000') then
                text = tostring(math.floor(PlayersMotels[target].rentcycle/tonumber('60000')))..' '.._U['minute']
            elseif PlayersMotels[target].rentcycle >= tonumber('3600000') and PlayersMotels[target].rentcycle < 86400000 then
                text = tostring(Round(PlayersMotels[target].rentcycle/3600000))..' '.._U['hour']
            elseif PlayersMotels[target].rentcycle >= 86400000 then
                text = tostring(math.floor(PlayersMotels[target].rentcycle/86400000))..' '.._U['day']
            end
        end
    end
    return text
end

function Round(number)
    local power = 10^1
    return math.floor(number * power) / power
end

function GetFirstTimer(cycle)
    local text = "0"
    if cycle then
        if cycle <= tonumber('60000') then
            text = tostring(math.floor(cycle/tonumber('1000')))..' '.._U['second']
        elseif cycle > tonumber('60000') and cycle < tonumber('3600000') then
            text = tostring(math.floor(cycle/tonumber('60000')))..' '.._U['minute']
        elseif cycle >= tonumber('3600000') and cycle < 86400000 then
            text = tostring(Round(cycle/3600000))..' '.._U['hour']
        elseif cycle >= 86400000 then
            text = tostring(math.floor(cycle/86400000))..' '.._U['day']
        end
    end
    return text
end

RegisterNetEvent('pw-motelsbusiness:StartRentCycle')
AddEventHandler('pw-motelsbusiness:StartRentCycle', function(cycle)
    local firstWarning = false local secondWarning = false local thirstWarning = false local fourWarning = false local fiveWarning = false
    if cycle then
        timer = cycle
        repeat
            Citizen.Wait(tonumber('1000'))
            timer = timer-tonumber('1000')
            if timer < tonumber('0') then
                timer = tonumber('0')
            end
            if ReqClose then
                timer = tonumber('0')
            end
            if (not ReqClose) and not firstWarning and timer <= tonumber(cycle*tonumber('0.5')) then
                TriggerServerEvent('pw-motelsbusiness:CheckPay', tonumber('1'))
                firstWarning = true
            end
            if (not ReqClose) and not secondWarning and timer <= tonumber(cycle*tonumber('0.4')) then
                TriggerServerEvent('pw-motelsbusiness:CheckPay', tonumber('2'))
                secondWarning = true
            end
            if (not ReqClose) and not thirstWarning and timer <= tonumber(cycle*tonumber('0.3')) then
                TriggerServerEvent('pw-motelsbusiness:CheckPay', tonumber('3'))
                thirstWarning = true
            end
            if (not ReqClose) and not fourWarning and timer <= tonumber(cycle*tonumber('0.2')) then
                TriggerServerEvent('pw-motelsbusiness:CheckPay', tonumber('4'))
                fourWarning = true
            end
            if (not ReqClose) and not fiveWarning and timer <= tonumber(cycle*tonumber('0.1')) then
                TriggerServerEvent('pw-motelsbusiness:CheckPay', tonumber('5'))
                fiveWarning = true
            end
            TriggerServerEvent('pw-motelsbusiness:GetRentCycle', timer)
        until timer == 0 if ReqClose then ReqClose = false TriggerServerEvent('pw-motelsbusiness:StoppedRent', CloseData) CloseData = {} else TriggerServerEvent('pw-motelsbusiness:ResetRentCycle') end 
    end
end)

CreateThread(function ()
    while not Cfg do Wait(100) end
    if not Cfg.QBCore then
        UniqItem = function(meta, key, id)
			local newmeta = json.decode(meta)
            if newmeta and newmeta.code and newmeta.steam and key and id and next(PlayersMotels) and PlayersMotels[newmeta.steam] then
                if newmeta.motel == key..'-'..id and newmeta.code == PlayersMotels[newmeta.steam].uniq then
                    if PlayersMotels[newmeta.steam].suspended == tonumber('1') then
                        return Notification(_U['motel_Suspended'])
                    else
                        return true
                    end
                else
                    return false
                end
            else
                return false
            end
        end    
    else
        UniqItem = function(item, key, id)
            if item and item.info and item.info.code and item.info.steam and key and id and next(PlayersMotels) and PlayersMotels[item.info.steam] then
                if item.info.motel == key..'-'..id and item.info.code == PlayersMotels[item.info.steam].uniq then
                    if PlayersMotels[item.info.steam].suspended == tonumber('1') then
                        return Notification(_U['motel_Suspended'])
                    else
                        return true
                    end
                else
                    return false
                end
            else
                return false
            end
        end    
    end    
end)
