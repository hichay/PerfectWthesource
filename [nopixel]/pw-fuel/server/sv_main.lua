
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RPC.register('pw-gasSations:refuel',function(src, price , tax)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= price then 
        xPlayer.removeMoney(price)
        exports["pw-balance"]:addTax("Vehicles", tax)
        return true
    else 
        TriggerClientEvent('DoLongHudText',-1,"Không đủ tiền đổ xăng",2)
        return false
    end
end)


