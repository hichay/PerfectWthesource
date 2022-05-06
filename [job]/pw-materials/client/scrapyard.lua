local NearScrapYard = false

local CurrentScrapYard = nil
local CanScrap = true
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        if CanScrap then	 
         local PlayerCoords = GetEntityCoords(GetPlayerPed(-1))
         --for k, v in pairs(Config.ScrapyardLocations) do 
             --local Area = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['X'], v['Y'], v['Z'], true)
			-- local dst = #(GetEntityCoords(playerPed) - vector3(v['X'],  v['Y'], v['Z']))
			local dst = #(PlayerCoords - vector3(2352.27,  3133.19, 48.20))
			
             if dst < 7.5 then
                --CurrentScrapYard = k
                NearScrapYard = true
				DrawMarker(2, 2352.27,  3133.19, 48.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                DrawText3D(2352.27,  3133.19, 48.20 + 0.15, "~g~E~w~ - Để rã xe")
				if IsControlJustPressed(0, 38) then
                    if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and GetIsVehicleEngineRunning(GetVehiclePedIsIn(GetPlayerPed(-1)),false) == 1 then
					    TriggerEvent('pw-materials:client:scrap:vehicle')
                    else
                        TriggerEvent("ESX:Notify","Phải ngồi trên xe hoặc xe phải đang mở động cơ","info")
                    end
				end
             end
			 
			 
         --end
         if not NearScrapYard then
            Citizen.Wait(2500)
            NearScrapYard = false
         end
        end
    end
end)

function DrawText3D(x, y, z, text)
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("CUSTOM_TEXT1")
  SetTextCentre(true)
  AddTextComponentString(text)
  SetDrawOrigin(x,y,z, 0)
  DrawText(0.0, 0.0)
  ClearDrawOrigin()
end

RegisterNetEvent('pw-materials:client:scrap:vehicle')
AddEventHandler('pw-materials:client:scrap:vehicle', function()
    local Vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	local class = GetVehicleClass(Vehicle)
	if class == 0 or class == 8 then
		class = "A"
	elseif class == 1 or class == 3 then
		class = "B"
	elseif class == 4 or class == 9 or class == 18 then
		class = "C"
	elseif class == 2 or class == 12 then
		class = "D"
	elseif class == 5 or class == 6 or class == 7 then
		class = "S"
	else
		class = "All"
	end	
	--print(CanScrap)
	--print(NearScrapYard)
    if CanScrap and NearScrapYard then
		CanScrap = false
	    --ESX.TriggerServerCallback('pw-materials:server:is:vehicle:owned', function(IsOwned)
            --if not IsOwned then
                local Time = math.random(30000, 40000)	 
                ScrapVehicleAnim(Time)
                ESX.Progressbar("scrap-vehicle", "Đang rã xe..", Time, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    ESX.Game.DeleteVehicle(Vehicle)
                    StopAnimTask(GetPlayerPed(-1), "mp_car_bomb", "car_bomb_mechanic", 1.0)
                    TriggerServerEvent('pw-materials:server:scrap:reward',class)
                    Citizen.SetTimeout((1000 * 60) * 15, function()
                    CanScrap = true
                    end)
                end, function() -- Cancel
                    --ESX.ShowNotification("Đã rã xe thành công..", "error")
                    ScrapVehicleAnim(0)
                    --StopAnimTask(GetPlayerPed(-1), "mp_car_bomb", "car_bomb_mechanic", 1.0)
                end)				
            --else
                --ESX.ShowNotification("Xe không thể rã, chiếc này thuộc về ai đó..", "error")									
            --end
        --end, GetVehicleNumberPlateText(Vehicle))
    else
      ESX.ShowNotification("Bạn phải đợi thêm một thời gian nữa..", "error")	
    end								
end)

function IsNearScrapYard()
  if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
      return NearScrapYard
  else
      return false
  end
end


function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function ScrapVehicleAnim(time)
    time = (time / 1000)
    loadAnimDict("mp_car_bomb")
    TaskPlayAnim(GetPlayerPed(-1), "mp_car_bomb", "car_bomb_mechanic" ,3.0, 3.0, -1, 16, 0, false, false, false)
    Scrapping = true
    Citizen.CreateThread(function()
        while Scrapping do
            TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(2000)
			time = time - 2
            if time <= 0 then
                Scrapping = false
                StopAnimTask(GetPlayerPed(-1), "mp_car_bomb", "car_bomb_mechanic", 1.0)
            end
        end
    end)
end