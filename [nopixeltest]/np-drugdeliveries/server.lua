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



RegisterServerEvent('oxydelivery:server')
AddEventHandler('oxydelivery:server', function(money)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(source)
    

	if xPlayer.getMoney() >= money and CopsConnected >= 2 then
		 xPlayer.removeMoney(money) 	

		TriggerClientEvent("oxydelivery:startDealing", source)
    else
        TriggerClientEvent("ESX:Notify",src,"Đang không có đủ 2 cảnh sát online hoặc không đủ tiền")
	end
end)

RegisterServerEvent('drugdelivery:server')
AddEventHandler('drugdelivery:server', function(money)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= money then
        xPlayer.removeMoney(money)
		
		TriggerClientEvent("drugdelivery:startDealing", source)
    else
        TriggerClientEvent('notification', source, 'You dont have enough money.', 2)
	end
end)

local counter = 0
RegisterServerEvent('delivery:status')
AddEventHandler('delivery:status', function(status)
    if status == -1 then
        counter = 0
    elseif status == 1 then
        counter = 2
    end
    TriggerClientEvent('delivery:deliverables', -1, counter, math.random(1,14))
end)



local activechop = {}
local newList = {}

function makenewlist()
    for i = 1, 5 do
        table.insert(newList, {["id"] = math.random(1, 118), ["rarity"] = math.random(1, 15), ["resolved"] = false})
    end
end

local timer = 60

function updatetimer()
    if timer > 0 then
        timer = timer - 1
        TriggerClientEvent("chop:CurrentCarList", -1, newList, timer)
    else
        newList = {}
        makenewlist()
        timer = 60
        TriggerClientEvent("chop:CurrentCarList", -1, newList, timer)
    end
end

RegisterServerEvent('request:chopshop')
AddEventHandler('request:chopshop', function()
    TriggerClientEvent("chop:CurrentCarList", -1, newList, timer)
end)

RegisterServerEvent('chopshop:removevehicle')
AddEventHandler('chopshop:removevehicle', function(vehicleid, plate, value)
    newList[vehicleid]["resolved"] = true
    TriggerClientEvent("chop:CurrentCarListRemove", -1, vehicleid)
    TriggerClientEvent("keys:remove", source, plate)
    TriggerClientEvent("payment:chopshopscrap", source, newList[vehicleid]["rarity"])
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    makenewlist()
    --print('The resource ' .. resourceName .. ' has been started.')
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        updatetimer()
    end
end)