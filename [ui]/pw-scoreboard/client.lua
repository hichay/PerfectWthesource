local scoreboardOpen = false
local PlayerOptin = {}
local idPlayer = "nothing"
ESX = nil
Citizen.CreateThread(function() 
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)    
        Citizen.Wait(200)
    end
	
	while ESX.GetPlayerData().job == nil do
    Citizen.Wait(10)
	end
	
	PlayerData = ESX.GetPlayerData()
	

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    isLoggedIn = true
    ESX.TriggerServerCallback('qb-scoreboard:server:GetConfig', function(config)
        Config.IllegalActions = config
    end)
end)

RegisterNetEvent('qb-scoreboard:client:SetActivityBusy')
AddEventHandler('qb-scoreboard:client:SetActivityBusy', function(activity, busy)
    Config.IllegalActions[activity].busy = busy
end)

RegisterCommand('scoreboard', function()
    if not scoreboardOpen then
        ESX.TriggerServerCallback('qb-scoreboard:server:GetPlayersArrays', function(playerList)
            ESX.TriggerServerCallback('qb-scoreboard:server:GetActivity', function(cops, ambulance, mechanic)
                ESX.TriggerServerCallback("qb-scoreboard:server:GetCurrentPlayers", function(Players)
                    PlayerOptin = playerList
                    Config.CurrentCops = cops

                    SendNUIMessage({
                        action = "open",
                        players = Players,
                        maxPlayers = Config.MaxPlayers,
                        requiredCops = Config.IllegalActions,
                        currentCops = Config.CurrentCops,
                        currentAmbulance = ambulance,
						currentMechanic = mechanic
                    })
                    scoreboardOpen = true
					
                end)
            end)
        end)	
		scoreboardOpen = true
    else
        SendNUIMessage({
            action = "close",
        })
        scoreboardOpen = false
		ClearDrawOrigin()
    end
	
	
    
		if scoreboardOpen == true then 
			for _, player in pairs(GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), 10.0)) do
				local PlayerId = GetPlayerServerId(player)
				TriggerServerEvent("qb-scoreboard:server:openid",PlayerId)
			end	
		end
		
			
		while scoreboardOpen == true do
			Wait(0)
			 for _, player in pairs(GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), 10.0)) do
				local PlayerId = GetPlayerServerId(player)
				local PlayerPed = GetPlayerPed(player)
				local PlayerName = GetPlayerName(player)
				local PlayerCoords = GetEntityCoords(PlayerPed)

            
               DrawText3D(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z + 1.0, '['..PlayerOptin[PlayerId].idcard..']')
            end
        end
    
end)

RegisterKeyMapping('scoreboard', 'Open Scoreboard', 'keyboard', 'HOME')

-- Functions

DrawText3D = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end



GetPlayersFromCoords = function(coords, distance)
    local players = GetPlayers()
    local closePlayers = {}

    if coords == nil then
		coords = GetEntityCoords(PlayerPedId())
    end
    if distance == nil then
        distance = 5.0
    end
    for _, player in pairs(players) do
		local target = GetPlayerPed(player)
		local targetCoords = GetEntityCoords(target)
		local targetdistance = #(targetCoords - vector3(coords.x, coords.y, coords.z))
		if targetdistance <= distance then
			table.insert(closePlayers, player)
		end
    end
    
    return closePlayers
end

GetPlayers = function()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end
