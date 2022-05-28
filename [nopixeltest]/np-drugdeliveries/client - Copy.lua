local chopinfo = {

	[1] =  { ['x'] = 2341.1,['y'] = 3052.2, ['z'] = 48.15, ['h'] = 359.2, ['info'] = ' Chop Entry Point' },
	[2] =  { ['x'] = 2341.1,['y'] = 3052.2, ['z'] = 48.15,['h'] = 309.96, ['info'] = ' Craft' },
	[3] =  { ['x'] = 115.34,['y'] = 164.33,['z'] = 104.52,['h'] = 71.96, ['info'] = ' outside entrance' },
	[4] =  { ['x'] = 100.17,['y'] = 169.15,['z'] = 104.54,['h'] = 253.79, ['info'] = ' 1' },
	[5] =  { ['x'] = 126.96,['y'] = 159.32,['z'] = 104.51,['h'] = 249.47, ['info'] = ' 2' },
	[6] =  { ['x'] = 144.16,['y'] = 165.17,['z'] = 104.75,['h'] = 341.08, ['info'] = ' 3' },
	[7] =  { ['x'] = 147.77,['y'] = 175.11,['z'] = 105.1,['h'] = 339.32, ['info'] = ' 4' },

}

function IsDroppable()
	playerped = PlayerPedId()
	coordA = GetEntityCoords(playerped, 1)
	coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
	veh = getVehicleInDirection(coordA, coordB)
	return veh
end

function getVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle
	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		offset = offset - 1
		if vehicle ~= 0 then break end
	end
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	if distance > 25 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end

local vehicleList = {
	{ ["name"] = "Sultan", ["modelname"] = "sultan" },
	{ ["name"] = "Ingot", ["modelname"] = "INGOT" },
	{ ["name"] = "Surge", ["modelname"] = "SURGE" },
	{ ["name"] = "Issi", ["modelname"] = "ISSI2" },
	{ ["name"] = "Gresley", ["modelname"] = "GRESLEY" },
	{ ["name"] = "Pigalle", ["modelname"] = "PIGALLE" },
	{ ["name"] = "Sabre Turbo", ["modelname"] = "SABREGT" },
	{ ["name"] = "Landstalker", ["modelname"] = "Landstalker" },
	{ ["name"] = "Panto", ["modelname"] = "PANTO" },
	{ ["name"] = "Super Diamond", ["modelname"] = "superd" },
	{ ["name"] = "Massacro", ["modelname"] = "MASSACRO" },
	{ ["name"] = "Schafter", ["modelname"] = "schafter2" },
	{ ["name"] = "Bullet", ["modelname"] = "BULLET" },
	{ ["name"] = "Ruiner", ["modelname"] = "RUINER" },
	{ ["name"] = "Prairie", ["modelname"] = "PRAIRIE" },
	{ ["name"] = "Voltic", ["modelname"] = "VOLTIC" },
	{ ["name"] = "Sentinel", ["modelname"] = "SENTINEL2" },
	{ ["name"] = "Intruder", ["modelname"] = "INTRUDER" },
	{ ["name"] = "Seminole", ["modelname"] = "SEMINOLE" },
	{ ["name"] = "Felon GT", ["modelname"] = "FELON2" },
	{ ["name"] = "Emperor", ["modelname"] = "EMPEROR" },
	{ ["name"] = "Manana", ["modelname"] = "MANANA" },
	{ ["name"] = "Coquette", ["modelname"] = "COQUETTE" },
	{ ["name"] = "9F Cabrio", ["modelname"] = "NINEF2" },
	{ ["name"] = "Cavalcade", ["modelname"] = "Cavalcade" },
	{ ["name"] = "Comet", ["modelname"] = "Comet2" },
	{ ["name"] = "Rapid GT", ["modelname"] = "rapidgt" },
	{ ["name"] = "Blista Compact", ["modelname"] = "blista2" },
	{ ["name"] = "Mesa", ["modelname"] = "Mesa" },
	{ ["name"] = "Banshee", ["modelname"] = "Banshee" },
	{ ["name"] = "Carbonizzare", ["modelname"] = "carbonizzare" },
	{ ["name"] = "Peyote", ["modelname"] = "Peyote" },
	{ ["name"] = "BeeJay XL", ["modelname"] = "BJXL" },
	{ ["name"] = "Dilettante", ["modelname"] = "Dilettante" },
	{ ["name"] = "Tornado", ["modelname"] = "Tornado" },
	{ ["name"] = "Rocoto", ["modelname"] = "Rocoto" },
	{ ["name"] = "Zion", ["modelname"] = "Zion" },
	{ ["name"] = "Furore", ["modelname"] = "FuroreGT" },
	{ ["name"] = "Buffalo", ["modelname"] = "Buffalo" },
	{ ["name"] = "F620", ["modelname"] = "F620" },
	{ ["name"] = "Asea", ["modelname"] = "Asea" },
	{ ["name"] = "Feltzer", ["modelname"] = "feltzer2" },
	{ ["name"] = "Dubsta", ["modelname"] = "Dubsta" },
	{ ["name"] = "FQ2", ["modelname"] = "FQ2" },
	{ ["name"] = "Radius", ["modelname"] = "RADI" },
	{ ["name"] = "Stanier", ["modelname"] = "Stanier" },
	{ ["name"] = "Futo", ["modelname"] = "Futo" },
	{ ["name"] = "Vigero", ["modelname"] = "Vigero" },
	{ ["name"] = "Oracle", ["modelname"] = "oracle" },
	{ ["name"] = "Nine F", ["modelname"] = "ninef" },
	{ ["name"] = "Banshee", ["modelname"] = "banshee" },
	{ ["name"] = "Buffalo", ["modelname"] = "buffalo" },
	{ ["name"] = "Fusilade", ["modelname"] = "fusilade" },
	{ ["name"] = "Jester", ["modelname"] = "jester" },
	{ ["name"] = "Kuruma", ["modelname"] = "kuruma" },
	{ ["name"] = "Sultan", ["modelname"] = "sultan" },
	{ ["name"] = "Infernus", ["modelname"] = "infernus" },
	{ ["name"] = "Buccaneer", ["modelname"] = "buccaneer" },
	{ ["name"] = "Chino", ["modelname"] = "chino" },
	{ ["name"] = "Sanchez", ["modelname"] = "sanchez" },
	{ ["name"] = "Dominator", ["modelname"] = "dominator" },
	{ ["name"] = "Picador", ["modelname"] = "picador" },
	{ ["name"] = "Bifta", ["modelname"] = "bifta" },
	{ ["name"] = "Sandking", ["modelname"] = "sandking" },
	{ ["name"] = "Bison", ["modelname"] = "bison" },
	{ ["name"] = "Fugitive", ["modelname"] = "fugitive" },
	{ ["name"] = "Intruder", ["modelname"] = "intruder" },
	{ ["name"] = "Premier", ["modelname"] = "premier" },
	{ ["name"] = "Primo", ["modelname"] = "primo" },
	{ ["name"] = "Regina", ["modelname"] = "regina" },
	{ ["name"] = "Washington", ["modelname"] = "washington" },
	{ ["name"] = "Akuma", ["modelname"] = "AKUMA" },
	{ ["name"] = "Bagger", ["modelname"] = "bagger" },
	{ ["name"] = "Bati", ["modelname"] = "bati" },
	{ ["name"] = "Double", ["modelname"] = "double" },
	{ ["name"] = "Hexer", ["modelname"] = "hexer" },
	{ ["name"] = "Nemesis", ["modelname"] = "nemesis" },
	{ ["name"] = "BF 400", ["modelname"] = "bf400" },
	{ ["name"] = "Blade", ["modelname"] = "blade" },
	{ ["name"] = "Hot Rod Blazer", ["modelname"] = "blazer3" },
	{ ["name"] = "Street Blazer", ["modelname"] = "blazer4" },
	{ ["name"] = "Buccaneer Custom", ["modelname"] = "buccaneer2" },
	{ ["name"] = "Carbon RS", ["modelname"] = "carbonrs" },
	{ ["name"] = "Cheburek", ["modelname"] = "cheburek" },
	{ ["name"] = "Chino Custom", ["modelname"] = "chino2" },
	{ ["name"] = "Cliffhanger", ["modelname"] = "cliffhanger" },
	{ ["name"] = "Cognoscenti Cabrio", ["modelname"] = "cogcabrio" },
	--{ ["name"] = "", ["modelname"] = "comet4" },
	--{ ["name"] = "", ["modelname"] = "comet5" },
	{ ["name"] = "Defiler", ["modelname"] = "defiler" },
	{ ["name"] = "Diabolus", ["modelname"] = "diablous" },
	{ ["name"] = "Diabolus Custom", ["modelname"] = "diablous2" },
	{ ["name"] = "Ellie", ["modelname"] = "ellie" },
	{ ["name"] = "Enduro", ["modelname"] = "enduro" },
	{ ["name"] = "Esskey", ["modelname"] = "esskey" },
	{ ["name"] = "Faction", ["modelname"] = "faction" },
	{ ["name"] = "Faction Custom", ["modelname"] = "faction2" },
	{ ["name"] = "Fagaloa", ["modelname"] = "fagaloa" },
	{ ["name"] = "Faggio", ["modelname"] = "faggio" },
	{ ["name"] = "Furore GT", ["modelname"] = "furoregt" },
	{ ["name"] = "GB200", ["modelname"] = "gb200" },
	{ ["name"] = "Kamacho", ["modelname"] = "kamacho" },
	{ ["name"] = "Lynx", ["modelname"] = "lynx" },
	{ ["name"] = "Manchez", ["modelname"] = "manchez" },
	{ ["name"] = "Nightblade", ["modelname"] = "nightblade" },
	{ ["name"] = "Primo Custom", ["modelname"] = "primo2" },
	{ ["name"] = "Raiden", ["modelname"] = "raiden" },
	{ ["name"] = "Rapid GT Classic", ["modelname"] = "rapidgt3" },
	{ ["name"] = "Sadler", ["modelname"] = "sadler" },
	{ ["name"] = "Schafter LWB", ["modelname"] = "schafter4" },
	{ ["name"] = "Sentinel Classic", ["modelname"] = "sentinel3" },
	{ ["name"] = "Sovereign", ["modelname"] = "sovereign" },
	{ ["name"] = "Clown Van", ["modelname"] = "speedo2" },
	{ ["name"] = "Stryder", ["modelname"] = "stryder" },
	{ ["name"] = "Toros", ["modelname"] = "toros" },
	{ ["name"] = "Tropos Rallye", ["modelname"] = "tropos" },
	{ ["name"] = "Vindicator", ["modelname"] = "vindicator" },
	{ ["name"] = "Voodoo", ["modelname"] = "voodoo" },
	{ ["name"] = "Windsor", ["modelname"] = "windsor" },
	{ ["name"] = "Windsor Drop", ["modelname"] = "windsor2" }
}

function checkCars()
	for i = 1, #vehicleList do
		local hash = GetHashKey(vehicleList[i]["modelname"])
	end
end

local currentVehicleList = {}
local currentTimer = 60

RegisterNetEvent('chop:CurrentCarListRemove')
AddEventHandler('chop:CurrentCarListRemove', function(id)
	currentVehicleList[id]["resolved"] = true
	print(currentVehicleList[id]["resolved"])
end)

RegisterNetEvent('chop:CurrentCarList')
AddEventHandler('chop:CurrentCarList', function(newList, timer)
	currentVehicleList = newList
	currentTimer = timer
end)

local tradingTable = { 
	[1] = "scrapmetal",
	[2] = "electronics",
	[3] = "plastic",
	[4] = "glass",
	[5] = "rubber",
	[6] = "copper",
	[7] = "aluminium",
	[8] = "steel"
}

RegisterNetEvent('payment:chopshopscrap')
AddEventHandler('payment:chopshopscrap', function(rarity,playsound)
	
	
	if playsound then
		-- if math.random(50) == 20 then
		-- 	TriggerEvent( "player:receiveItem", "Gruppe6Card3", 1 )
		-- end
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'impactdrill', 0.5)
	end
	local amount = rarity * 5
		--TriggerEvent('player:receiveItem', tradingTable[math.random(#tradingTable)], amount)	
	if amount <= 50 then
		TriggerServerEvent('loot:useItem', 'chopchop')
	else
		TriggerServerEvent('loot:useItem', 'chopchoprare')
	end
	TriggerEvent("DoLongHudText","Picked up Scrap Items.",1)
end)


RegisterNetEvent('chopshoppub:leave')
AddEventHandler('chopshoppub:leave', function(plate)

	local veh = GetVehiclePedIsIn(PlayerPedId(), false)
	local myplate = GetVehicleNumberPlateText(veh)
	if plate == myplate then
		TaskLeaveVehicle(PlayerPedId(), veh, 0)
		Citizen.Wait(100)
		SetEntityCoords(PlayerPedId(),GetEntityCoords(PlayerPedId()))
	end

end)


function listedVehicle(veh)
	local answer = 0
	for i = 1, #currentVehicleList do 
		local modelID = currentVehicleList[i]["id"]
		if GetEntityModel(veh) == GetHashKey(vehicleList[modelID]["modelname"]) and not currentVehicleList[i]["resolved"] then
			answer = i
		end
	end
	return answer
end


local recentpix = false
function CompleteScrapping(vehicle, originalVehicleLocation)

	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'impactdrill', 0.5)

	RequestAnimDict('mp_car_bomb')
	while not HasAnimDictLoaded("mp_car_bomb") do
		Citizen.Wait(0)
	end

	TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 8.0, -8, -1, 49, 0, 0, 0, 0)

	local finished = exports["pw-taskbar"]:taskBar(20000,"Scrapping Car")
	local currentLocation = GetEntityCoords(vehicle)
	if finished == 100 then
	    local vehicleDifference = #(currentLocation - originalVehicleLocation)
		if not IsPedInVehicle(PlayerPedId(),vehicle,false) then
			if vehicleDifference <= 1 then
				local vehResponse = listedVehicle(veh)
				local plate = GetVehicleNumberPlateText(veh)
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'impactdrill', 0.5)
				TriggerServerEvent("chopshop:removevehicle",vehResponse,plate,50)
				Citizen.Wait(2500)
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'impactdrill', 0.5)
				SetEntityAsNoLongerNeeded(veh,true)
				DeleteEntity(veh)
			else
				TriggerEvent("DoLongHudText","Don't move your vehicle while we're trying to chop it, idiot.",2)
			end
		else
			TriggerEvent("DoLongHudText","You can't stay inside the vehicle while we're trying to chop it, idiot.",2)
		end
	end
end

function CleanUpArea()
    local playerped = PlayerPedId()
    local plycoords = GetEntityCoords(playerped)
    local handle, ObjectFound = FindFirstObject()
    local success
    repeat
        local pos = GetEntityCoords(ObjectFound)
        local distance = #(plycoords - pos)
        if distance < 10.0 and ObjectFound ~= playerped then
        	if IsEntityAPed(ObjectFound) then
        		if IsPedAPlayer(ObjectFound) then
        		else
        			DeleteObject(ObjectFound)
        		end
        	else
        		if not IsEntityAVehicle(ObjectFound) and not IsEntityAttached(ObjectFound) then
	        		DeleteObject(ObjectFound)
	        	end
        	end            
        end
        success, ObjectFound = FindNextObject(handle)
    until not success

    SetEntityAsNoLongerNeeded(drugStorePed)
    DeleteEntity(drugStorePed)

    EndFindObject(handle)
end


Citizen.CreateThread(function()

    while true do

	    Citizen.Wait(1)
	    local dropOff = #(vector3(GetEntityCoords(PlayerPedId())) - vector3(chopinfo[1]["x"],chopinfo[1]["y"],chopinfo[1]["z"]))

	    local dropOff2 = #(vector3(GetEntityCoords(PlayerPedId())) - vector3(chopinfo[2]["x"],chopinfo[2]["y"],chopinfo[2]["z"]))
	  --  local dropOff3 = #(vector3(GetEntityCoords(PlayerPedId())) - vector3(chopinfo[3]["x"],chopinfo[3]["y"],chopinfo[3]["z"]))
	    local dropOff4 = #(GetEntityCoords(PlayerPedId()) - vector3(590.51, 2739.8, 15.86))

		if dropOff4 < 1.5 then
			DrawText3Ds(590.51, 2739.8, 15.86, "[E] to Leave") 
			if IsControlJustReleased(0,38) then
				CleanUpArea()
				SetEntityCoords(PlayerPedId(),pillStore["x"],pillStore["y"],pillStore["z"])
				Citizen.Wait(1000)
			end
		end	
	


	    if dropOff2 < 20.0 then
	    	local isInVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
	    	if not isInVehicle then
	    		local veh = IsDroppable()
	    		local vehResponse = listedVehicle(veh)
	    		if DoesEntityExist(veh) and vehResponse > 0 then
	    			local vehLoc = GetEntityCoords(veh)
	    			DrawText3Ds(vehLoc["x"],vehLoc["y"],vehLoc["z"], "[E] Drop Vehicle Off") 
    				if IsControlJustReleased(0,38) then
    					CompleteScrapping(veh, GetEntityCoords(veh))
					end
	    		else
	    			DrawText3Ds(chopinfo[2]["x"],chopinfo[2]["y"],chopinfo[2]["z"], "The Chop Shop") 
    				if IsControlJustReleased(0,38) then
    					if #currentVehicleList == 0 then
    						TriggerServerEvent("request:chopshop")
    						Citizen.Wait(2000)
						end
    					local message = "Required List:"
						for i = 1, #currentVehicleList do 
							if not currentVehicleList[i]["resolved"] then
								if currentVehicleList[i]["rarity"] > 10 then
     								if i == 1 then
    									message = message .. " " .. vehicleList[currentVehicleList[i]["id"]]["name"] .. " (priority)"
    								else
    									message = message .. " | " .. vehicleList[currentVehicleList[i]["id"]]["name"] .. " (priority)"
    								end
								else
    								if i == 1 then
    									message = message .. " " .. vehicleList[currentVehicleList[i]["id"]]["name"]
    								else
    									message = message .. " | " .. vehicleList[currentVehicleList[i]["id"]]["name"]
    								end
								end

								
							end
						end
						TriggerEvent("chatMessage", "EMAIL ", 8, message)
						print('message')
    				end
	    		end
	    	end
	    else

	    	if dropOff2 > 2.0 and dropOff4 > 2.0 and GoldBars > 2.0 then
		    	Citizen.Wait(1000)
		    end

	    end

	    for i = 1, #drugLocs do

	    	if DoesEntityExist( drugLocs[i]["ent"] ) then

				if IsEntityDead( drugLocs[i]["ent"] ) then

					SetEntityAsNoLongerNeeded(drugLocs[i]["ent"])

					DeleteEntity( drugLocs[i]["ent"] )

				end

			end

		end

    end

end)


RegisterCommand("choplist", function(source, args, rawCommand)
    TriggerEvent('chop:commandrequest')
end)

RegisterNetEvent('chop:commandrequest')
AddEventHandler('chop:commandrequest', function()
	if #currentVehicleList == 0 then
		TriggerServerEvent("request:chopshop")
		Citizen.Wait(2000)
	end
	local message = "Chop List: (" .. currentTimer .. " mins remaining) <br>"
	for i = 1, #currentVehicleList do 
		if not currentVehicleList[i]["resolved"] then
			if currentVehicleList[i]["rarity"] > 10 then
					if i == 1 then
					message = message .. " " .. vehicleList[currentVehicleList[i]["id"]]["name"] .. " (priority)"
				else
					message = message .. " | " .. vehicleList[currentVehicleList[i]["id"]]["name"] .. " (priority)"
				end
			else
				if i == 1 then
					message = message .. " " .. vehicleList[currentVehicleList[i]["id"]]["name"]
				else
					message = message .. " | " .. vehicleList[currentVehicleList[i]["id"]]["name"]
				end
			end

			
		end
	end
	TriggerEvent("chatMessage", "EMAIL ", 8, message)
	print(message)


end)