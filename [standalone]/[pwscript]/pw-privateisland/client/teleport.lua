ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()

  addBlip(vector3(-941.4793, -2954.771, 13.94507), 652, 0.8, 5, "[Đảo] - Điểm lên đảo")
  addBlip(vector3(4495.5522, -4517.425, 4.357779), 655, 0.8, 5, "[Đảo] - Điểm rời đảo")
end)

function DrawText3Ds(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("CUSTOM_TEXT1")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

addBlip = function(coords, sprite, size, colour, text)
  local blip = AddBlipForCoord(coords)
  SetBlipSprite(blip, sprite)
  SetBlipScale  (blip, size)
  SetBlipColour (blip, colour)
  --SetBlipColour(blip, colour)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("CUSTOM_TEXT")
  AddTextComponentString(text)
  EndTextCommandSetBlipName(blip)
end




Citizen.CreateThread(function()

  while true do
    Citizen.Wait(1)
      if #(GetEntityCoords(PlayerPedId()) - vector3(-941.4793, -2954.771, 13.94507)) < 1.5 then
        DrawText3Ds(-941.4793, -2954.771, 13.94507, "[E] Để lên đảo (1000$)") 
        DrawMarker(33, -941.4793, -2954.771, 13.94507, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)
        if IsControlJustReleased(0,38) then
            TriggerEvent("pw-privateisland:TeleportStation")
            --ESX.TriggerServerCallback('thugnhiena:checkMoney', function(hasMoney)
              --if hasMoney then
                --Citizen.Wait(1000)
                --[[ BeginLeaving(false)
                BeginLanding(false)
                SetEntityCoords(PlayerPedId(),4495.5522, -4517.425, 4.357779)
                if IsScreenFadedOut() then
                  DoScreenFadeIn(1000)
                  while not IsScreenFadedIn() do
                    Wait(50)
                  end
                end ]]
              --else			
                --TriggerEvent("ESX:Notify","Không có đủ tiền để thực hiện chuyến bay","info")
              --end
            --end)
        end
      end

      if #(GetEntityCoords(PlayerPedId()) - vector3(4495.5522, -4517.425, 4.357779)) < 1.5 then
        DrawText3Ds(4495.5522, -4517.425, 4.357779, "[E] Để rời khỏi đảo (1000$)") 
        DrawMarker(33, 4495.5522, -4517.425, 4.357779, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)
        if IsControlJustReleased(0,38) then 
          --ESX.TriggerServerCallback('thugnhiena:checkMoney', function(hasMoney)
            --if hasMoney then
              BeginLeaving(true)
              BeginLanding(true)
              SetEntityCoords(PlayerPedId(),-941.4793, -2954.771, 13.94507)
              if IsScreenFadedOut() then
                DoScreenFadeIn(1000)
                while not IsScreenFadedIn() do
                  Wait(50)
                end
              end
            --else			
              --TriggerEvent("ESX:Notify","Không có đủ tiền để thực hiện chuyến bay","info")
            --end
          --end)
        end
      end

  end
end)


RegisterNetEvent('pw-privateisland:Teleport', function(data)
    if data.pos == 1 then 
      BeginLeaving(false)
      BeginLanding(false)
      SetEntityCoords(PlayerPedId(),4495.5522, -4517.425, 4.357779)
      if IsScreenFadedOut() then
        DoScreenFadeIn(1000)
        while not IsScreenFadedIn() do
          Wait(50)
        end
      end
    elseif data.pos == 2 then
      BeginLeaving(false)
      BeginLanding(false)
      SetEntityCoords(PlayerPedId(),4939.2358, -5149.8, 2.4542949)
      if IsScreenFadedOut() then
        DoScreenFadeIn(1000)
        while not IsScreenFadedIn() do
          Wait(50)
        end
      end
    elseif data.pos == 3 then
      BeginLeaving(false)
      BeginLanding(false)
      SetEntityCoords(PlayerPedId(),5578.7734, -5192.868, 12.422496)
      if IsScreenFadedOut() then
        DoScreenFadeIn(1000)
        while not IsScreenFadedIn() do
          Wait(50)
        end
      end  
    end
end)


RegisterNetEvent('pw-privateisland:TeleportStation', function()

		TriggerEvent('pw-context:sendMenu', {
			{
				id = 1,
				header = "Vị trí 1",
				txt = "",
				params = {
					event = "pw-privateisland:Teleport",
					args = {
					pos = 1
					}
				}
			},
      {
				id = 2,
				header = "Vị trí 2",
				txt = "",
				params = {
					event = "pw-privateisland:Teleport",
					args = {
           pos = 2
					}
				}
			},

		})
	
end)