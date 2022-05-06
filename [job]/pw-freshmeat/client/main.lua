
ESX = nil
Isworking = false
ProtectSpam = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	ScriptLoaded()
end)

-- Create Blips
Citizen.CreateThread(function()

	local ConfigLocation = Config.Zone
	blip1 = AddBlipForCoord(ConfigLocation.Pos.x, ConfigLocation.Pos.y, ConfigLocation.Pos.z)

	SetBlipSprite (blip1, ConfigLocation.Blips.Id)
	SetBlipDisplay(blip1, 4)
	SetBlipScale  (blip1, 0.6)
	SetBlipColour (blip1, ConfigLocation.Blips.Color)
	SetBlipAsShortRange(blip1, true)

	BeginTextCommandSetBlipName("CUSTOM_TEXT1")
    AddTextComponentSubstringPlayerName("[Nông] - Trại bò")
	EndTextCommandSetBlipName(blip1)

end)




function ScriptLoaded()
	Citizen.Wait(1000)
	LoadWorking()
end

local AnimalsInSession = {}

local OnGoingHuntSession = false

function LoadWorking()

	LoadModel('a_c_cow')
	LoadAnimDict('amb@medic@standing@kneel@base')
	LoadAnimDict('anim@gangops@facility@servers@bodysearch@')

	Citizen.CreateThread(function()
		while true do

			local coords = GetEntityCoords(GetPlayerPed(-1))
			local Pos = Config.Zone.Pos
			local Marker = Config.Zone.Marker
			
			if #(coords - vector3(Pos.x,Pos.y,Pos.z)) < Marker.DrawSize then

				DrawMarker(2, Pos.x, Pos.y, Pos.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)
			end

			local isInMarker  = false

			if #(coords - vector3(Pos.x,Pos.y,Pos.z)) < Marker.Size.x then
				isInMarker  = true
			end

			if isInMarker and not ProtectSpam then
				if OnGoingHuntSession == false then
					DrawText3Ds(Pos.x, Pos.y, Pos.z+1, '[E] để bắt đầu công việc')
					if IsControlJustPressed(0, Config.Key['E']) then
						StartHuntingSession()
					end
				else
					DrawText3Ds(Pos.x, Pos.y, Pos.z+1, '[E] để dừng công việc')
					if IsControlJustPressed(0, Config.Key['E']) then
						StartHuntingSession()
					end
				end
			end

			Citizen.Wait(10)
		end
	end)
end



function StartHuntingSession()

	if OnGoingHuntSession then

		OnGoingHuntSession = false

		for index, value in pairs(AnimalsInSession) do
			if DoesEntityExist(value.id) then
				DeleteEntity(value.id)
			end
		end

	else
		OnGoingHuntSession = true

		Citizen.CreateThread(function()

				
			for index, value in pairs(Config.AnimalPosition) do

				ProtectSpam = true

				local Ped = PlayerPedId()
				RequestModel('a_c_cow')
					while not HasModelLoaded('a_c_cow') do
						Wait(1)
					end
				local Animal = CreatePed(5, GetHashKey('a_c_cow'), value.x, value.y, value.z, 0.0, false, false)
				Citizen.Wait(1000)
				TaskSmartFleePed(Animal, Ped, 9000.0, -1, false, false)

				local AnimalBlip = AddBlipForEntity(Animal)
				SetBlipSprite(AnimalBlip, 153)
				SetBlipColour(AnimalBlip, 1)
				BeginTextCommandSetBlipName("CUSTOM_TEXT")
				AddTextComponentString('Động vật - Bò')
				EndTextCommandSetBlipName(AnimalBlip)

				table.insert(AnimalsInSession, {id = Animal, x = value.x, y = value.y, z = value.z, Blipid = AnimalBlip})

				if next(Config.AnimalPosition,index) == nil then
					ProtectSpam = false
				end
			end

			while OnGoingHuntSession do
				local sleep = 500
				for index, value in ipairs(AnimalsInSession) do
					if DoesEntityExist(value.id) then
						local AnimalCoords = GetEntityCoords(value.id)
						local PlyCoords = GetEntityCoords(PlayerPedId())
						local AnimalHealth = GetEntityHealth(value.id)
						
						local PlyToAnimal = GetDistanceBetweenCoords(PlyCoords, AnimalCoords, true)

						if PlyToAnimal < 2.0 and not Isworking then
							sleep = 30
							
							DrawText3Ds(AnimalCoords.x, AnimalCoords.y, AnimalCoords.z + 1, 'Nhấn [G] để làm thịt')

							if IsControlJustReleased(0, Config.Key['G']) then
								if DoesEntityExist(value.id) then
									SetEntityHealth(value.id, 0)
									table.remove(AnimalsInSession, index)
									SlaughterAnimal(value.id)
								end
							end
						end
					end
				end

				Citizen.Wait(sleep)

			end
				
		end)
	end
end


function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("CUSTOM_TEXT")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function SlaughterAnimal(AnimalId)

	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
	Isworking = true
	Citizen.Wait(5000)

	ClearPedTasksImmediately(PlayerPedId())

	local AnimalWeight = math.random(10, 160) / 10

	TriggerServerEvent('pw-freshmeat:reward')
	
	Isworking = false
	
	DeleteEntity(AnimalId)
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end


RegisterNetEvent("pw-freshmeat:makeSales")
AddEventHandler("pw-freshmeat:makeSales", function()
	local totalCash = 0
	local qty = exports["pw-inventory"]:getQuantity("freshmeat", true)
	if qty > 0 then
		TriggerEvent("inventory:removeItem", "freshmeat", qty)
		totalCash = totalCash + (17 * qty)
	end
	
	if totalCash == 0 then
		TriggerEvent("ESX:Notify","Không có gì để bán","error")
    end
    
    if totalCash > 0 then
        TriggerServerEvent("pw-hunting:Payout",totalCash)
    end
	
end)