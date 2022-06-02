ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterCommand("testfi", function(source, args, rawCommand)
	FishingGame(math.random(1,2))
end, false)

local taskInProcess = false
local activeTasks = 0


function openGui(speed)
    guiEnabled = true
    SetNuiFocus(guiEnabled,true)
    SendNUIMessage({runProgress = true,Speedfish = speed})
end

function closeGui()
    guiEnabled = false
    SetNuiFocus(guiEnabled,false)
    SendNUIMessage({closeFail = true})	
end




RegisterNUICallback('taskCancel', function(data, cb)
  closeGui()
  activeTasks = data.tasknum

end)

RegisterNUICallback('taskEnd', function(data, cb)
    closeGui()
    activeTasks = data.tasknum
   
end)


function FishingGame(speed)
	
  openGui(speed)
  activeTasks = 1
  while activeTasks == 1 do
        Citizen.Wait(1)
  end
	if activeTasks == 2 then
        closeGui()
        taskInProcess = false
        return 0
    else
        closeGui()
        taskInProcess = false
        return 100
    end 
  	
 	
end

function getIsOnBoat()
	posFishing = GetEntityCoords(PlayerPedId())
	local boat = GetClosestVehicle(posFishing[1], posFishing[2], posFishing[3], 10.000, 867467158, 12294)
	if IsEntityInWater(boat) then
		return true
		
	end
    return false
end

function isValidZone()
    local zoneInH = GetNameOfZone(GetEntityCoords(PlayerPedId()))
	
    for _, zone in pairs(Config.FishingZone) do
        if zoneInH == zone then
			print('this zone available')
            return true
        end
    end
end

RegisterNetEvent('Fishingame:Start')
AddEventHandler('Fishingame:Start', function()
    local PlayerPos = GetEntityCoords(PlayerPedId())
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) ~= 1 then
		
		if not playing_femote and getIsOnBoat() and isValidZone() then
			
		-- GetDistanceBetweenCoords(PlayerPos,1429.06,4048.65,30.02) < 350
			if exports["pw-inventory"]:hasEnoughOfItem("fishingrod",1,false) and exports["pw-inventory"]:hasEnoughOfItem("fishbait",1,false)then
				local targetspeed = GetEntitySpeed(GetPlayerPed(-1)) * 3.6
				if targetspeed < 35 then			
					fishingStart()	
				else
					TriggerEvent("DoShortHudText","Thuyền còn đang chạy nhanh.",2)
				end
			else
				TriggerEvent("DoShortHudText","Thiếu mồi câu.",2)
			end
		else
			TriggerEvent("DoShortHudText","Không phải khu vực cho phép.",2)
		end	
	end
end)


Citizen.CreateThread(function()
	local data = {
		id = "fisher_npc",
		position = {coords = vector3(714.52294, 4101.8281, 34.785232), heading = 56.555},
		pedType = 4,
		model = "a_m_y_vinewood_01",
		networked = false,
		distance = 50.0,
		settings = {{ mode = 'invincible', active = true }, { mode = 'ignore', active = true }, { mode = 'freeze', active = true }},
		flags = { ["isNPC"] = true, },
		scenario = "WORLD_HUMAN_CLIPBOARD_FACILITY",
	}
	local npc = exports["pw-npcs"]:RegisterNPC(data, "fishername_npc")

	local Interact = {
	  data = {
		{
		  	id = 'sellfish',
		  	label = 'Bán cá',
		  	icon = 'fish-fins',
		  	event = 'fishingame:banca',
		  	parameters = {},
		},
		{
			id = 'buyitem',
			label = 'Mua đồ',
			icon = 'circle',
			event = 'pw-npcs:ped:keeper',
			parameters = {"101"},
		},
		{
			id = 'rentboat',
			label = 'Thuê thuyền',
			icon = 'sailboat',
			event = 'fishingame:spawnboat',
			parameters = {},
		},
	  },
	  options = {
		distance = { radius = 2.5 },
		npcIds = { 'fisher_npc' },
		--[[ isEnabled = function(pEntity, pContext)
		  return isOnDeliveryTask()
		end, ]]
	  },
	}
	
	exports["pw-interact"]:AddPeekEntryByFlag({'isNPC'}, Interact.data, Interact.options)


end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(PlayerPedId())
		local VehicleDistance = #(pos - Config.BoatDelete.coords)
		
		
		if VehicleDistance < 10 then
			inRange = true
			DrawMarker(2, Config.BoatDelete.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)
			if VehicleDistance < 5 then
				local InVehicle = IsPedInAnyVehicle(PlayerPedId())
				local vehiclein = GetVehiclePedIsIn(PlayerPedId())
				
				if InVehicle then
					DrawText3Ds(708.38134, 4110.8911, 30.670038, '[E] Trả thuyền đã thuê')
					if IsControlJustPressed(0, 38)  then
						DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
					end
				else
					
				end
			end
		end
	end
end)	

RegisterNetEvent('fishingame:spawnboat')
AddEventHandler('fishingame:spawnboat', function()
	local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint()

	if foundSpawn then
		ESX.Game.SpawnVehicle("dinghy4", spawnPoint.coords, spawnPoint.heading, function(vehicle)
		TriggerEvent("vehiclekeys:client:SetOwner", ESX.Game.GetVehicleProperties(vehicle).plate)			 	
        TriggerEvent("ESX:Notify", "Đã thuê thuyền thành công" ,"success") 		
		end)
	end
	
end)


RegisterNetEvent('fishingame:banca')
AddEventHandler('fishingame:banca', function()
	local fouFish
	local infofish
	local fishpriceup
	local multiprice
	local basepirce
	local fishid
	local multipice
	for i = 1, #Config.fishTable do
		fouFish = exports["pw-inventory"]:hasEnoughOfItem(Config.fishTable[i].idname,1,false)
		infofish = exports["pw-inventory"]:GetItemInfoName(Config.fishTable[i].idname)
		fishpriceup = (Config.fishTable[i].sizeMin + Config.fishTable[i].sizeMax)/2/10
		baseprice = Config.fishTable[i].baseprice
		fishid = Config.fishTable[i].idname
		multipice = Config.fishTable[i].multiprice	
		if 	fouFish then
			break

		end
		Citizen.Wait(300)
	end


	if fouFish then 
			-- infofish = exports["pw-inventory"]:GetItemInfoName(Config.fishTable[i].idname)			
			local info = string.sub(infofish,12)
												
			--fishpriceup = (Config.fishTable[i].sizeMin + Config.fishTable[i].sizeMax) / 2 /10
								
			if tonumber(info) > fishpriceup then
				diffrentlg = info - fishpriceup
		   
				price = baseprice + diffrentlg * multipice						
				TriggerEvent("inventory:removeItem", fishid, 1)
				TriggerServerEvent('fishingGame:Banca', price )
				TriggerEvent("ESX:Notify", "Bán thành công", "success")
				TriggerServerEvent("fishingame:sendlog",fishid,price)
			else
				price = baseprice
				TriggerEvent("inventory:removeItem", fishid, 1)
				TriggerServerEvent('fishingGame:Banca', price )
				TriggerEvent("ESX:Notify" ,"Bán thành công", "success")
				TriggerServerEvent("fishingame:sendlog",fishid,price)
			end
	else
		
			TriggerEvent("ESX:Notify","Phải có cá mới có thể bản","info")
		end   
end)




function GetAvailableVehicleSpawnPoint()
	local spawnPoints = Config.BoatSpawn
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		
		return false
	end
end



function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("CUSTOM_TEXT")
	AddTextComponentString(text)
	DrawText(x, y)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("CUSTOM_TEXT")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end



ALAMO = {
	-- small fish 
	[1] = {["idname"] = "fishingherring",["name"] = "Cá trích",["sizeMin"] = 250,["sizeMax"] = 700,["chance"] = 20,["speed"] = 32,["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	[2] = {["idname"] = "fishinghalibut",["name"] = "Cá bơn vĩ",["sizeMin"] = 150,["sizeMax"] = 400,["chance"] = 20,["speed"] = 34,["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	[3] = {["idname"] = "fishingredfish",["name"] = "Cá da đỏ",["sizeMin"] = 150,["sizeMax"] = 300,["chance"] = 15,["speed"] = 30,["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	[4] = {["idname"] = "fishingminnow",["name"] = "Cá tuế",["sizeMin"] = 50,["sizeMax"] = 100,["chance"] = 60,["speed"] = 39,["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	[5] = {["idname"] = "fishingeel",["name"] = "Lươn sông",["sizeMin"] = 50,["sizeMax"] = 100,["chance"] = 60,["speed"] = 39,["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	-- Noraml Sized Fish

	[6] = {["idname"] = "fishingsalmon",["name"] = "Cá hồi",["sizeMin"] = 580,["sizeMax"] = 1000,["chance"] = 40,["speed"] = 41,["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	[7] = {["idname"] = "fishingflounder",["name"] = "cá bơn",["sizeMin"] = 600,["sizeMax"] = 740,["chance"] = 55,["speed"] = 43,["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	[8] = {["idname"] = "fishingcod",["name"] = "Cá tuyết",["sizeMin"] = 750,["sizeMax"] = 1400,["chance"] = 50,["speed"] = 40,["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	[9] = {["idname"] = "fishingmackerel",["name"] = "Cá ngừ chù",["sizeMin"] = 500,["sizeMax"] = 900,["chance"] = 60,["speed"] = 46,["multiprice"] = 0.1, ["Zone"] = "ALAMO"},
	[10] = {["idname"] = "fishingbass",["name"] = "Cá vược",["sizeMin"] = 700,["sizeMax"] = 1000,["chance"] = 65,["speed"] = 53,["multiprice"] = 0.1, ["Zone"] = "ALAMO"},

}

local fishInBucket = {}

playing_femote = false
function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 


function fishingStart()
	
	isFishing = true
	playing_femote = true
	local lPed = GetPlayerPed(-1)
	local ZoneName = GetNameOfZone(GetEntityCoords(PlayerPedId()))
	RequestAnimDict("amb@world_human_stand_fishing@idle_a")
	while not HasAnimDictLoaded("amb@world_human_stand_fishing@idle_a") do
		Citizen.Wait(0)
	end

	attachModel = GetHashKey('prop_fishing_rod_01')

	SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263) 
	local bone = GetPedBoneIndex(GetPlayerPed(-1), 60309)

	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end

	FishRod = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	AttachEntityToEntity(FishRod, GetPlayerPed(-1), bone, 0,0,0, 0,0,0, 1, 1, 0, 0, 2, 1)


	local leftFishing = false


	TriggerEvent("playFishing")


	local zseccount = 100

	while zseccount > 0 do
		Citizen.Wait(1)
		zseccount = zseccount - 1
		if IsControlJustPressed(1, 38) then
			zseccount = 0
			leftFishing = true
		end

	end

	if not leftFishing then

		local dicks = 250
		local fish = false 

		while dicks > 0 do

			drawTxt('Có con gì đó vừa cắn câu, Nhấn ~g~E~s~ để cố bắt!',0,1,0.5,0.8,0.3,255,255,255,255)

			Citizen.Wait(1)
			dicks = dicks - 1
			if IsControlJustPressed(1, 38) then
				dicks = 0
				fish = true
				TriggerEvent("inventory:removeItem","fishbait", 1)	
			end
		end

		if fish then 
			local itemRandom = math.random(1000)
			if itemRandom < 100 then
				if itemRandom < 20 then
					TriggerEvent("DoLongHudText","Bạn vừa câu được một chiếc hộp gì đó.",1)
					TriggerEvent("player:receiveItem",'fishingchest',1)
					-- lượm được chest
				-- elseif itemRandom < 70 then
					-- TriggerEvent("DoLongHudText","You found a sealed bag of cash, how odd.",1)
					-- local rnd = math.random(10,100)
					-- TriggerServerEvent('missionSystem:caughtMoney',rnd)
					-- -- lượm được np_fishingtacklebox
				else 
					local randit = math.random(9)
					TriggerEvent("DoLongHudText",Config.randomMessage[randit].message,1)
					TriggerEvent("player:receiveItem",Config.randomMessage[randit].idname,1)	
					-- còn lại lượm được np_fishingboot np_fishingtin np_fishinglog
				end
				
			else
			    local foundFish = false
				local fishNumber = 0
				local finished = 0
				local rnd = 0
				local chancefish
				repeat
					Wait(0)
					rnd = math.random(1,10)

					if ZoneName == 'OCEANA' then
						chancefish = Config.OCEANA[rnd].chance
						sizeMin = Config.OCEANA[rnd].sizeMin
						sizeMax = Config.OCEANA[rnd].sizeMax
						name = Config.OCEANA[rnd].name
						idname = Config.OCEANA[rnd].idname
						fishspeed = Config.OCEANA[rnd].speed
					elseif ZoneName ==  "ALAMO" then 
						chancefish = Config.ALAMO[rnd].chance
						sizeMin = Config.ALAMO[rnd].sizeMin
						sizeMax = Config.ALAMO[rnd].sizeMax
						name = Config.ALAMO[rnd].name
						idname = Config.ALAMO[rnd].idname
						fishspeed = Config.OCEANA[rnd].speed
					elseif ZoneName ==  "PALCOV" then  
						chancefish = Config.PALCOV[rnd].chance
						sizeMin = Config.PALCOV[rnd].sizeMin
						sizeMax = Config.PALCOV[rnd].sizeMax
						name = Config.PALCOV[rnd].name
						idname = Config.PALCOV[rnd].idname
						fishspeed = Config.PALCOV[rnd].speed
					end
					if math.random(100) >= chancefish then
						--[[ if rnd == 15 or rnd == 16 or rnd == 17 or rnd == 18 then
							if math.random(100) >= 25 then
								foundFish = true
								fishNumber = rnd
							end
						else ]]
							foundFish = true
							fishNumber = rnd
						--end
					end
				until foundFish
				--[[ if rnd <= 5 then 
					finished = FishingGame(math.random(1,2))		
				end
				if rnd >= 5 and rnd < 10 then 
					finished = FishingGame(math.random(1,2))				
				end	
				if rnd >= 10 and rnd < 14 then
					finished = FishingGame(math.random(1,2))					
				end
				if rnd >= 14 and rnd < 18 then
					finished = FishingGame(math.random(1,2))				
				end ]]

				finished = FishingGame(fishspeed)

					if finished == 100 then 
						local fishsize = math.random(sizeMin,sizeMax)
						TriggerEvent("DoLongHudText","Bạn vừa bắt được "..name.." độ dài " .. (fishsize / 10) .. "cm.",3)
						Citizen.Wait(100)
						TriggerServerEvent('fishingame:sendlogcauduoc',idname)
						TriggerEvent("player:receiveItem",idname,1,true,true,"Độ dài "..(fishsize / 10))
					end
				
			end

		else
			TriggerEvent("DoLongHudText","Lâu quá rồi không còn kịp.",2)
		end
	end

	ClearPedTasks(lPed)
	TriggerEvent("fistpump")
	DeleteEntity(FishRod)
	playing_femote = false
	isFishing = false
end

-- local noFish = {
	-- {-815.97216796875,-1462.1270751953,37.754516601563,250},
	-- {-1117.2260742188,-1823.3757324219,13.025714874268,210},
	-- {-1034.0518798828,-1069.9602050781,13.025714874268,250},
-- }

-- function isInNoFish()
	-- for i,v in ipairs(noFish) do
		-- if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),v[1],v[2],v[3]) <= v[4] then return true end
	-- end
	-- return false
-- end

RegisterNetEvent('playFishing')
AddEventHandler('playFishing', function()

	local lPed = GetPlayerPed(-1)
	loadAnimDict( "amb@world_human_stand_fishing@base" )
	loadAnimDict( "amb@world_human_stand_fishing@idle_a" )
	ClearPedTasksImmediately(IPed)
	while playing_femote do
		TaskPlayAnim(lPed, "amb@world_human_stand_fishing@idle_a", "idle_c", 20.0, -8, -1, 16, 0, 0, 0, 0)
		Wait(8200)
	end

end)