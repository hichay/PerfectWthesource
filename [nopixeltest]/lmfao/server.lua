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



