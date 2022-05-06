local showPlayerBlips = false
local ignorePlayerNameDistance = false
local playerNamesDist = 30
local displayIDHeight = 1 --Height of ID above players head(starts at center body mass)
--Set Default Values for Colors
local red = 255
local green = 255
local blue = 255
local idVisable = true
local connectedPlayerss = {}
local test = 95
local wantedCount = 0
local isWanted = false
local timeWanted = 20
local PlayerData = {}
ESX = nil

RegisterFontFile("arial")
fontId = RegisterFontId("arial font")

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
    Citizen.Wait(2000)
	ESX.TriggerServerCallback('esx_scoreboard:getConnectedPlayers', function(connectedPlayers)
        --UpdatePlayerTable(connectedPlayers)
        connectedPlayerss = connectedPlayers
		local dumped = ESX.DumpTable(connectedPlayers)
		print(dumped)
		--print(connectedPlayers[test].job2)
	end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('lv_wanted:setWanted')
AddEventHandler('lv_wanted:setWanted', function(count)
    print(count .. "Truy na [ON]")
	isWanted = true
	wantedCount = count
end)

RegisterNetEvent('esx_scoreboard:updateConnectedPlayers')
AddEventHandler('esx_scoreboard:updateConnectedPlayers', function(connectedPlayers)
	connectedPlayerss = connectedPlayers
end)

function DrawText3D(x,y,z, text, name) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(ESX.FontId)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString("["..text.."] "..name)
		World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isWanted == true then
            print(isWanted)
			
			if wantedCount > 0 then
				Wait(60000)
				timeWanted = timeWanted - 10
				print(timeWanted)
				if timeWanted <= 0 then



					isWanted = false

                    ESX.ShowNotification("Bạn đã hết bị truy nã")
                    exports['mythic_notify']:DoHudText('inform', 'Bạn đã hết bị truy nã')

					wantedCount = 0

					timeWanted = 20 -- truy nã trong 20 phút

				end

			end
		end

	end

end)

function hasLogo(Id)
	--print(Id)
	if connectedPlayerss[Id] ~= nil and connectedPlayerss[Id].job2 ~= 'unemployed2' then 
		for k, v  in  ipairs(Config.logo.job2) do 
			if connectedPlayerss[Id].job2 == v.name then 
				return v.logoName 
			end 
		end 
	elseif  connectedPlayerss[Id] ~= nil then
		for k, v  in  ipairs(Config.logo.job) do 
			if connectedPlayerss[Id].job == v.name then 
				return v.logoName 
			end 
		end 
	end 
	return false 
end

Citizen.CreateThread(function()
	if not HasStreamedTextureDictLoaded(Config.dic) then
        RequestStreamedTextureDict(Config.dic, true)
        while not HasStreamedTextureDictLoaded(Config.dic) do
            Wait(1)
            print("not load")
        end
	end
	Citizen.Wait(4000)
	print(ESX.DumpTable(Config.logo))
    while true do
        for k, id in ipairs(GetActivePlayers()) do
            if GetPlayerPed( id ) ~= GetPlayerPed( -1 ) then
                ped = GetPlayerPed( id )
                blip = GetBlipFromEntity( ped ) 
				serverId = tonumber(GetPlayerServerId(id))
                x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

                if(ignorePlayerNameDistance) then
					if NetworkIsPlayerTalking(id) then
						red = 0
						green = 0
						blue = 255
						DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id), GetPlayerName(id))
					else
						red = 255
						green = 255
						blue = 255
						DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id), GetPlayerName(id))
					end
                end

                if ((distance < playerNamesDist)) then
                    if not (ignorePlayerNameDistance) then
                        local logoName = hasLogo(serverId)
						--print(logoName)
                        if NetworkIsPlayerTalking(id) then
                            if logoName ~= false then                                 
                                DrawMarker(9, x2, y2, z2 + displayIDHeight + 0.2, 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255,false, true, 2, false, Config.dic, logoName, false)                               
                                red = 0
                                green = 0
                                blue = 255
                                DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id), GetPlayerName(id))
                            else
                                red = 0
                                green = 0
                                blue = 255
                                DrawText3D(x2, y2, z2 + displayIDHeight, serverId, GetPlayerName(id))
                            end
						else
							if logoName ~= false then    
                                DrawMarker(9, x2, y2, z2 + displayIDHeight + 0.2, 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255,false, true, 2, false, Config.dic, logoName, false)
                                red = 255
								green = 255
								blue = 255
                                DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id), GetPlayerName(id))
                            else
                                red = 255
								green = 255
								blue = 255
                                DrawText3D(x2, y2, z2 + displayIDHeight, serverId, GetPlayerName(id))
                            end
							
						end
                    end
                end 
	
				if isWanted == true then
				
                    red = 255
                    green = 0
                    blue = 0
                    DrawMarker(9, x2, y2, z2 + displayIDHeight + 1.2, 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 0.45, 0.45, 0.2, 255, 255, 255, 255,false, true, 2, false, "logo", wantedCount, false)

                end	
				
            end
        end
        Citizen.Wait(0)
    end
end)
 