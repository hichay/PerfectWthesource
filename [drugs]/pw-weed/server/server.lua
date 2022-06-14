ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('mission:completed')
AddEventHandler('mission:completed', function(money)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(money)
end)

RegisterServerEvent('mission:caughtMoney')
AddEventHandler('mission:caughtMoney', function(rnd)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(rnd)
end)

IsWeedProcessing = false
IsWeedProcessingFinished = false

RegisterNetEvent('ProcessWeed')
AddEventHandler('ProcessWeed', function()
    Citizen.Wait(1000)

    TriggerClientEvent('np-weed:weedReady',-1,true)
end)

RPC.register('pw-weed:processWeed',function(source)
    print('dong')
    --TriggerClientEvent("inventory:removeItem",source,"smallbud",50)
    TriggerEvent('ProcessWeed')
    TriggerClientEvent('np-weed:weedProcessing',-1,true)
    return true
end)

RPC.register('np-weed:collectpackage',function(src)
    print('lay thanh cong')
    TriggerClientEvent('np-weed:weedReady',-1,false)
    TriggerClientEvent('np-weed:weedProcessing',-1,false)
    return true
end)

RPC.register('pw-weed:getInitialState',function(src)
    data = {
        ['IsWeedProcessingFinished'] = IsWeedProcessingFinished,
        ['IsWeedProcessing'] = IsWeedProcessing,
    }
    return data
end)



function CountCops()

	local xPlayers = ESX.GetExtendedPlayers("job", "police")
	CopsConnected = 0

	for i=1, #xPlayers, 1 do	
		CopsConnected = CopsConnected + 1
	end
    TriggerClientEvent('ListCopOnline'-1,CopsConnected)
	SetTimeout(10000, CountCops)

end