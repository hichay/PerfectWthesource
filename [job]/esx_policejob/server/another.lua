RegisterServerEvent('police:IsTargetCuffed') -- that is np's code ((sway))
AddEventHandler('police:IsTargetCuffed', function(playerID)
	local src = source
	TriggerClientEvent("police:IsPlayerCuffed", playerID, src)
end)

--- POLICE SEXTION -------------------------------

RegisterServerEvent('police:cuffGranted2')
AddEventHandler('police:cuffGranted2', function(t,softcuff)
	local src = source
    
	--print('cuffing')
	TriggerClientEvent('menu:setCuffState', t, true)
	TriggerEvent('police:setCuffState2', t, true)
	if softcuff then
        TriggerClientEvent('handCuffedWalking', t)
        --print('softcuff')
    else
        --print('hardcuff')
		TriggerClientEvent('police:getArrested2', t, src)
		TriggerClientEvent('police:cuffTransition',src)
	end
end)

RegisterServerEvent('police:cuffGranted')
AddEventHandler('police:cuffGranted', function(t)
	local src = source
	
		TriggerEvent('police:setCuffState', t, true)
		TriggerClientEvent('menu:setCuffState', t, true)
		TriggerClientEvent('police:getArrested', t, src)
		TriggerClientEvent('police:cuffTransition',src)
end)


RegisterServerEvent('falseCuffs')
AddEventHandler('falseCuffs', function(t)
	TriggerClientEvent('falseCuffs',t)
	TriggerClientEvent('menu:setCuffState', t, false)
end)

RegisterServerEvent('police:setCuffState')
AddEventHandler('police:setCuffState', function(t,state)
	TriggerClientEvent('police:currentHandCuffedState',t,true)
	TriggerClientEvent('menu:setCuffState', t, true)
end)
