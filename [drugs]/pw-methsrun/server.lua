ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(10000, CountCops)

end

CountCops()


-- Oxy Run
RegisterServerEvent('oxydeliverymeth:server')
AddEventHandler('oxydeliverymeth:server', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.StartOxyPayment and CopsConnected >= 1 then
		xPlayer.removeMoney(Config.StartOxyPayment)
		
		TriggerClientEvent("oxydeliverymeth:startDealing", source)
	else
		TriggerClientEvent("ESX:Notify",src,"Đang không có đủ 2 cảnh sát online hoặc không đủ tiền")
	end
end)

RegisterServerEvent('oxydeliverymeth:receiveBigRewarditem')
AddEventHandler('oxydeliverymeth:receiveBigRewarditem', function()
	local src = source
    local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent("player:receiveItem",source,"morphine",1,true,true,"Nguyên liệu thô")
	TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items["green-card"], 'add')
end)

RegisterServerEvent('oxydeliverymeth:receiveoxy')
AddEventHandler('oxydeliverymeth:receiveoxy', function()
	local src = source
    local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent("player:receiveItem",source,"morphine",1,true,true,"Nguyên liệu thô")
    --TriggerClientEvent('ESX:Notify', src, "You were handed $ "..pay.. " and some oxy!", "success")
end)

-- RegisterServerEvent('oxydelivery:receivemoneyyy')
-- AddEventHandler('oxydelivery:receivemoneyyy', function()
	-- local src = source
	-- local Player = Framework.Functions.GetPlayer(src)
	
	-- TriggerClientEvent('Framework:Notify', src, "You were handed $ "..Config.Payment)

	-- Player.Functions.AddMoney('cash',Config.Payment)
-- end)
