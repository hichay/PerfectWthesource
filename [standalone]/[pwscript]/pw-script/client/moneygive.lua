function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end
Citizen.CreateThread(function()
local Interact = {
	data = {
	  {
		id = 'give_moneyinter',
		label = 'label',
		icon = 'hand-holding',
		event = 'pw-scripts:client:Duatien',
		parameters = {},
	  },
	},
	options = {
	  distance = { radius = 2.5 },
	  --[[ isEnabled = function(pEntity, pContext)
		return isOnDeliveryTask()
	  end, ]]
	},
  }
  
  exports["pw-interact"]:AddPeekEntryByFlag({'isPlayerModel'}, Interact.data, Interact.options)

end)


RegisterNetEvent('pw-scripts:client:Duatien')
AddEventHandler('pw-scripts:client:Duatien', function()


	local elements = {
		{ name = "amount", label = "Số tiền", icon = "scroll" }
	}
    
	local prompt = exports['np-ui']:OpenInputMenu(elements, function(values)
		return type(tonumber(values.amount)) == 'number' and tonumber(values.amount) >= 0
	end)

	if prompt == nil or prompt.amount == nil then return end 
	local Pedentity = GetPlayerPed(pEntity)
	local PlayerId
	
	for _, player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)
		if Pedentity == ped then
			TriggerServerEvent("pw-scripts:server:Duatien",prompt.amount,player)
	  end
	end

end)


RegisterCommand('tattuido', function()
	TriggerEvent("closeInventoryGui")
end, false)

