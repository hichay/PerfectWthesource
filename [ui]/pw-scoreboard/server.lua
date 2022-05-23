ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('qb-scoreboard:server:GetCurrentPlayers', function(source, cb)
    local TotalPlayers = 0
    for k, v in pairs(ESX.GetPlayers()) do
        TotalPlayers = TotalPlayers + 1
    end
    cb(TotalPlayers)
end)


ESX.RegisterServerCallback('getID', function(id, cb)
	local xPlayer = ESX.GetPlayerFromIdCard(id)
	local idplayer = getIdPlayer(xPlayer.identifier)
	cb(idplayer)
	
end)

function getIdPlayer(identifier)
	local result = MySQL.Sync.fetchAll("SELECT users.id FROM users WHERE users.identifier = @identifier",{
		['@identifier'] = identifier
		})
		if result[1] ~= nil then 
			return result[1].id
		end
		return nil
end

ESX.RegisterServerCallback('qb-scoreboard:server:GetActivity', function(source, cb)
    local PoliceCount = 0
    local AmbulanceCount = 0
	local MechanicCount = 0 
    
    for k, v in pairs(ESX.GetPlayers()) do
        local Player = ESX.GetPlayerFromId(v)
        if Player ~= nil then
            if (Player.job.name == "police") then
                PoliceCount = PoliceCount + 1
            end

            if (Player.job.name == "ambulance" or Player.job.name == "doctor") then
                AmbulanceCount = AmbulanceCount + 1
            end
			
			if (Player.job.name == "mechanic" ) then
                MechanicCount = MechanicCount + 1
            end
        end
    end

    cb(PoliceCount, AmbulanceCount, MechanicCount)
end)

ESX.RegisterServerCallback('qb-scoreboard:server:GetConfig', function(source, cb)
    cb(Config.IllegalActions)
end)

ESX.RegisterServerCallback('qb-scoreboard:server:GetPlayersArrays', function(source, cb)
    local players = {}
    for k, v in pairs(ESX.GetPlayers()) do
        local Player = ESX.GetPlayerFromId(v)
		local Idcard = Player.id
        if Player ~= nil then 
            players[Player.source] = {}
			players[Player.source].idcard = Idcard
            --players[Player.source].permission = QBCore.Functions.IsOptin(Player.source)
        end
    end
    cb(players)
end)

RPC.register('qb-scoreboard:server:GetPlayersArrays',function(src)
	local players = {}
    for k, v in pairs(ESX.GetPlayers()) do
        local Player = ESX.GetPlayerFromId(v)
		local Idcard = Player.id
        if Player ~= nil then 
            players[Player.source] = {}
			players[Player.source].idcard = Idcard
            --players[Player.source].permission = QBCore.Functions.IsOptin(Player.source)
        end
    end
	return players
end)

RegisterServerEvent('qb-scoreboard:server:SetActivityBusy')
AddEventHandler('qb-scoreboard:server:SetActivityBusy', function(activity, bool)
    Config.IllegalActions[activity].busy = bool
    TriggerClientEvent('qb-scoreboard:client:SetActivityBusy', -1, activity, bool)
end)

RegisterServerEvent('qb-scoreboard:server:openid')
AddEventHandler('qb-scoreboard:server:openid', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("ESX:ShowInfo",target,"Người chơi "..xPlayer.getName().." Đang mở xem id","neutral")
end)