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

Citizen.CreateThread(function()
	
		local blip = AddBlipForCoord(-1190.88, -889.25, 13.99)
		SetBlipSprite(blip, 439)
		SetBlipScale(blip, 1.2)
		SetBlipColour(blip, 28)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("CUSTOM_TEXT")
		AddTextComponentString("Nhân viên BurgerKing")
		EndTextCommandSetBlipName(blip)

	
end)


local OffsetData = {
    x = 0.0,
    y = -0.8,
    z = 1.0,
    Distance = 0.5
}

local IsWorking = false
local taskInProcess = false
local isWearUniform = false
local money = 0


function openGui()
    guiEnabled = true
    SetNuiFocus(guiEnabled,true)
    SendNUIMessage({openGame = true})
end

function closeGui()
    guiEnabled = false
    SetNuiFocus(guiEnabled,false)
    SendNUIMessage({closeGame = true})	
end


function BurgerGame()
	
  openGui()
  money = 0
  while money == 0 do
        Citizen.Wait(1)
  end	
    if money > 0 then
        closeGui()
        taskInProcess = false
        return money
    end 
  	
 	
end



RegisterNUICallback('EndGame', function(data, cb)
  closeGui()
  money = data.info
  print(money)
  TriggerServerEvent("burgerGame:PayCheck",money)
end)





Citizen.CreateThread(function()
    while true do
        local inRange = false
        
		if Config ~= nil then
			local PlayerPed = GetPlayerPed(-1)
			local PlayerPos = GetEntityCoords(PlayerPed)

			local v = Config.Locations["cloth"]
			local distance = GetDistanceBetweenCoords(PlayerPos, v.coords.x, v.coords.y, v.coords.z, true)
			if distance < 10 then
				inRange = true
				DrawMarker(2, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 0, 0, 1, 0, 0, 0)
				if not isWearUniform then
					if distance < OffsetData.Distance then
						DrawText3Ds(v.coords.x, v.coords.y, v.coords.z, "[E] để mặc đồ")
						if IsControlJustPressed(0, Keys["E"]) then
							isWearUniform = true
							MacQuanAo()
						end
					elseif distance < 3 then
						DrawText3Ds(v.coords.x, v.coords.y, v.coords.z, "Mặc đồ")
					end
				else
					if distance < OffsetData.Distance then
						DrawText3Ds(v.coords.x, v.coords.y, v.coords.z, "[E] để rời ca")
						if IsControlJustPressed(0, Keys["E"]) then
							isWearUniform = false
							MacQuanAo()
						end
					elseif distance < 3 then
						DrawText3Ds(v.coords.x, v.coords.y, v.coords.z, "Rời ca")
					end
				end
			end

			local z = Config.Locations["cloth"]
		end
		
		if Config ~= nil then
			local PlayerPed = GetPlayerPed(-1)
			local PlayerPos = GetEntityCoords(PlayerPed)

			local v = Config.Locations["work"]
			local distance = GetDistanceBetweenCoords(PlayerPos, v.coords.x, v.coords.y, v.coords.z, true)
			if distance < 10 then
				inRange = true
				DrawMarker(2, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 0, 0, 1, 0, 0, 0)
				if not IsWorking and isWearUniform then
					if distance < OffsetData.Distance then
						DrawText3Ds(v.coords.x, v.coords.y, v.coords.z, "[E] để bắt đầu công việc")
						if IsControlJustPressed(0, Keys["E"]) then
							LamViec()
						end
					elseif distance < 3 then
						DrawText3Ds(v.coords.x, v.coords.y, v.coords.z, "Bắt đầu công việc")
					end
				end
			end

			local z = Config.Locations["work"]
		end
        
        if not inRange then
            Citizen.Wait(1000)
        end
        Citizen.Wait(3)
    end
end)



function LamViec()
	IsWorking = true
	Citizen.SetTimeout((1000 * 60) * 3, function()
        IsWorking = false
    end)
   BurgerGame()
end


function MacQuanAo()
    if isWearUniform then 
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            if skin.sex == 0 then
                TriggerEvent('skinchanger:loadClothes', skin, Config.WorkForm["uniform"]["male"])
            else
                TriggerEvent('skinchanger:loadClothes', skin, Config.WorkForm["uniform"]["female"])
            end
            ESX.ShowNotification("Bây giờ bạn có thể bắt đầu công việc!!")
        end)
    else
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
    end
end



function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("CUSTOM_TEXT1")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

