ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('pepe-mine:getItem')
AddEventHandler('pepe-mine:getItem', function()
	local xPlayer, randomItem = ESX.GetPlayerFromId(source), Config.Items[math.random(1, #Config.Items)]
	
	if math.random(0, 100) <= Config.ChanceToGetItem then
		--local Item = xPlayer.Functions.GetItemByName(randomItem)
        local name = randomItem
		--if Item == nil then
            TriggerClientEvent("player:receiveItem",source,'rock',1)
		--else	
	    
    end
end)

RPC.register('pw-mine:sellStolenItems',function(src)
    local inventory = exports["pw-inventory"]:getInventory("Stolen-Goods-1-")
    local item = inventory[1]
    if item then 
        
        local qty = exports["pw-inventory"]:getQuantityOfInven('water',true,"Stolen-Goods-1-")
        print(qty)
    end
end)



RegisterServerEvent('pw-mine:ruada')
AddEventHandler('pw-mine:ruada', function()
    --TriggerClientEvent("inventory:removeItem",source,"rock",1)
    local randnum =  math.random(0, 100)
    if randnum >= 1 and randnum <= 20 then 
        TriggerClientEvent("player:receiveItem",source,"coal",math.random(2,5))
    elseif randnum >= 20 and randnum <= 40 then
        TriggerClientEvent("player:receiveItem",source,"goldmate",math.random(2,5))
    elseif randnum >= 40 and randnum <= 60 then
        TriggerClientEvent("player:receiveItem",source,"ironmate",math.random(2,5))
    elseif randnum >= 60 and randnum <= 80 then
        TriggerClientEvent("player:receiveItem",source,"mercury",math.random(2,5))
    elseif randnum >= 80 and randnum <= 99 then
        TriggerClientEvent("player:receiveItem",source,"aluminiummate",math.random(2,5))   
    elseif randnum == 100 then            
        TriggerClientEvent("player:receiveItem",source,"jadeite",math.random(1,3))    
    end   
end)


RegisterServerEvent('pw-mine:Payout')
AddEventHandler('pw-mine:Payout', function(cash)	
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addMoney(cash)
	TriggerEvent("ESX:Notify",source,"Bạn vừa kiếm được " ..cash.. "$","success")
end)

--[[ RegisterServerEvent('pepe-mine:sell')
AddEventHandler('pepe-mine:sell', function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    
if Player ~= nil then

    if Player.Functions.RemoveItem("steel", 1) then
        TriggerClientEvent("Framework:Notify", src, "You sold 1x Steel", "success", 1000)
        Player.Functions.AddMoney("cash", Config.pricexd.steel)
        Citizen.Wait(200)
        TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['steel'], 'remove')
    else
        TriggerClientEvent("Framework:Notify", src, "You have nothing to offer.", "error", 1000)
    end
        Citizen.Wait(1000)
    if Player.Functions.RemoveItem("iron", 1) then
        TriggerClientEvent("Framework:Notify", src, "You sold 1x Iron", "success", 1000)
        Player.Functions.AddMoney("cash", Config.pricexd.iron)
        Citizen.Wait(200)
        TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['iron'], 'remove')
    else
        TriggerClientEvent("Framework:Notify", src, "You have nothing to offer.", "error", 1000)
    end
        Citizen.Wait(1000)
    if Player.Functions.RemoveItem("copper", 1) then
        TriggerClientEvent("Framework:Notify", src, "You sold 1x Copper", "success", 1000)
        Player.Functions.AddMoney("cash", Config.pricexd.copper)
        Citizen.Wait(200)
        TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['copper'], 'remove')
    else
        TriggerClientEvent("Framework:Notify", src, "You have nothing to offer.", "error", 1000)
    end
        Citizen.Wait(1000)
    if Player.Functions.RemoveItem("diamond", 1) then
        TriggerClientEvent("Framework:Notify", src, "You sold 1x Diamond", "success", 1000)
        Player.Functions.AddMoney("cash", Config.pricexd.diamond)
        Citizen.Wait(200)
        TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['diamond'], 'remove')
    else
        TriggerClientEvent("Framework:Notify", src, "You have nothing to offer.", "error", 1000)
    end
        Citizen.Wait(1000)
    if Player.Functions.RemoveItem("emerald", 1) then
        TriggerClientEvent("Framework:Notify", src, "You sold 1x Emerald", "success", 1000)
        Player.Functions.AddMoney("cash", Config.pricexd.emerald)
        Citizen.Wait(200)
        TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['emerald'], 'remove')
    else
        TriggerClientEvent("Framework:Notify", src, "You have nothing to offer.", "error", 1000)
    end
end
end) ]]
