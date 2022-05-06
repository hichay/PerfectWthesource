ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Bail, runningStands = {}
ESX.RegisterServerCallback('pw-hotdogjob:server:HasMoney', function(source, cb)
    local Player = ESX.GetPlayerFromId(source)

    if Player.getAccount('money').money >= Config.Bail then
		Player.removeAccountMoney('money',Config.Bail)
        Bail[Player.getIdentifier()] = true
        cb(true)
    elseif Player.getAccount('bank').money >= Config.Bail then
		Player.removeAccountMoney('bank',Config.Bail)
        Bail[Player.getIdentifier()] = true
        cb(true)
    else
        Bail[Player.getIdentifier()] = false
        cb(false)
    end
end)

ESX.RegisterServerCallback('pw-hotdogjob:server:BringBack', function(source, cb)
    local Player = ESX.GetPlayerFromId(source)

    if Bail[Player.getIdentifier()] and Bail[Player.getIdentifier()] == true then
		Player.addMoney(Config.Bail)
        cb(true)
    else
        cb(false)
    end
end)

local canGetPaid = {}
RegisterServerEvent('bb-scripts:locationChange:b')
AddEventHandler('bb-scripts:locationChange:b', function()
    canGetPaid[source] = true
end)

RegisterServerEvent('pw-hotdogjob:server:Pay')
AddEventHandler('pw-hotdogjob:server:Pay', function(Amount, Price)
    local src = source
    local Player = ESX.GetPlayerFromId(src)

    
	Player.addMoney(tonumber(Amount * Price))
    if canGetPaid[src] ~= nil and canGetPaid[src] == true then
        canGetPaid[src] = false
		Player.addMoney(amount)
    else
        local timeTable = os.date("*t", 2147483647)
        -- RLCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', 'Unauthorized Trigger', '"..GetPlayerName(src).."')")
        -- DropPlayer(src, "You have been banned from the server: Unauthorized Trigger\nYour ban expires in "..timeTable["day"].. "/" .. timeTable["month"] .. "/" .. timeTable["year"] .. " " .. timeTable["hour"].. ":" .. timeTable["min"] .. "\nCheck our website for more information:  www.realistic-life.co.il")
        -- TriggerEvent('bb-logs:server:createLog', 'anticheat', 'pw-hotdogjob:server:Pay', "Has been banned from the server.\n**Reason:** Unauthorized Trigger.", src)
    end
end)

RegisterServerEvent('hotdog:cash')
AddEventHandler('hotdog:cash', function()
	local src = source
    local Player = ESX.GetPlayerFromId(src)
	local cash = math.random(8, 13)
	
	Player.addMoney(cash)
end)

local Reset = false
RegisterServerEvent('pw-hotdogjob:server:UpdateReputation')
AddEventHandler('pw-hotdogjob:server:UpdateReputation', function(quality)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local JobReputation = 1
    
    if Reset then
        --JobReputation = 0
        --Player.Functions.SetMetaData("jobrep", JobReputation)
        TriggerClientEvent('pw-hotdogjob:client:UpdateReputation', src, JobReputation)
        return
    end

    if quality == "exotic" then
        if JobReputation ~= nil and JobReputation + 3 > Config.MaxReputation then
            JobReputation = Config.MaxReputation
            --Player.Functions.SetMetaData("jobrep", JobReputation)
            TriggerClientEvent('pw-hotdogjob:client:UpdateReputation', src, JobReputation)
            return
        end
        if JobReputation == nil then
            JobReputation = 3
        else
            JobReputation = JobReputation + 3
        end
    elseif quality == "rare" then
        if JobReputation ~= nil and JobReputation + 2 > Config.MaxReputation then
            JobReputation = Config.MaxReputation
            --Player.Functions.SetMetaData("jobrep", JobReputation)
            TriggerClientEvent('pw-hotdogjob:client:UpdateReputation', src, JobReputation)
            return
        end
        if JobReputation == nil then
            JobReputation = 2
        else
            JobReputation = JobReputation + 2
        end
    elseif quality == "common" then
        if JobReputation ~= nil and JobReputation + 1 > Config.MaxReputation then
            JobReputation = Config.MaxReputation
            --Player.Functions.SetMetaData("jobrep", JobReputation)
            TriggerClientEvent('pw-hotdogjob:client:UpdateReputation', src, JobReputation)
            return
        end
        if JobReputation == nil then
            JobReputation = 1
        else
            JobReputation = JobReputation + 1
        end
    end
    --Player.Functions.SetMetaData("jobrep", JobReputation)
    TriggerClientEvent('pw-hotdogjob:client:UpdateReputation', src, JobReputation)
end)

-- RLCore.Commands.Add("dvstand", "Delete hotdogs stand", {}, false, function(source, args)
    -- TriggerClientEvent('pw-hotdogjob:staff:DeletStand', source)
-- end, 'admin')

RegisterServerEvent('pw-hotdogjob:server:updateRunningStand')
AddEventHandler('pw-hotdogjob:server:updateRunningStand', function()
    
end)