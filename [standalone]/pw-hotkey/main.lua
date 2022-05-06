
local display = false

RegisterCommand("on", function()
    Citizen.CreateThread(function()
      TriggerEvent('nui:on1', true)
    end)
end)
  


  RegisterCommand("off", function()
    Citizen.CreateThread(function()
        TriggerEvent("nui:off", true)
    end)
  end)

  --[[ ////////////////////////////////////////// ]]

  RegisterNetEvent('nui:on1')
  AddEventHandler('nui:on1', function()
    SendNUIMessage({
      type = "ui",
      display = true
    })
  end)

  RegisterNetEvent('nui:off')
  AddEventHandler('nui:off', function()
    SendNUIMessage({
      type = "ui",
      display = false
    })
  end)

  
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsPauseMenuActive() and not IsPaused then
			IsPaused = true
      SendNUIMessage({
        type = "ui",
        display = false
      })
		elseif not IsPauseMenuActive() and IsPaused then
			IsPaused = false
		end
	end
end)
