ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('pw-event:laymanh')
AddEventHandler('pw-event:laymanh', function(manh)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("player:receiveItem",source,manh,1,true,true,""..xPlayer.getName())    
end)

RegisterServerEvent('pw-event:ghepmanh')
AddEventHandler('pw-event:ghepmanh', function(manh)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("player:receiveItem",source,manh,1,true,true,""..xPlayer.getName())    
end)