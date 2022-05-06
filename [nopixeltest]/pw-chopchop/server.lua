ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('oxydelivery:server')
AddEventHandler('oxydelivery:server', function(money)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(source)
    

	if xPlayer.getMoney() >= money then
		 xPlayer.removeMoney(money) 	

		TriggerClientEvent("oxydelivery:startDealing", source)
    else
        TriggerClientEvent('notification', source, 'You dont have enough money little stupid fucking bitch.', 2)
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
    for i = 1, 20 do
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
AddEventHandler('chopshop:removevehicle', function(vehicleid, plate, class)
    newList[vehicleid]["resolved"] = true
    TriggerClientEvent("chop:CurrentCarListRemove", -1, vehicleid)
    TriggerClientEvent("keys:remove", source, plate)
    TriggerClientEvent("payment:chopshopscrap", source, newList[vehicleid]["rarity"],class)
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


RegisterServerEvent('chopchop:giveitem')
AddEventHandler('chopchop:giveitem', function(string)
	local src = source
    -- --print("shit loot")
    if string == 'ClassA' then
		randomnumb = math.random(1,30)
		if randomnumb == 1 then
			TriggerClientEvent("player:receiveItem",source,"axleparta",1)
		end
		
		if randomnumb == 2 then
			TriggerClientEvent("player:receiveItem",source,"bodypanela",1)
		end
		
		if randomnumb == 3 then
			TriggerClientEvent("player:receiveItem",source,"brakeparta",1)
		end
		
		if randomnumb == 4 then
			TriggerClientEvent("player:receiveItem",source,"clutchparta",1)
		end
		
		if randomnumb == 5 then
			TriggerClientEvent("player:receiveItem",source,"coolingparta",1)
		end
		
		if randomnumb == 6 then
			TriggerClientEvent("player:receiveItem",source,"electronicparta",1)
		end
		
		if randomnumb == 7 then
			TriggerClientEvent("player:receiveItem",source,"engineparta",1)
		end
		
		if randomnumb == 8 then
			TriggerClientEvent("player:receiveItem",source,"fuelinjectora",1)
		end
		
		if randomnumb == 9 then
			TriggerClientEvent("player:receiveItem",source,"tirekita",1)
		end
		
		if randomnumb == 10 then
			TriggerClientEvent("player:receiveItem",source,"transmissionparta",1)
		end
		
		if randomnumb > 10 and randomnumb < 15 then
			TriggerClientEvent("player:receiveItem",source,"scrapmetal",math.random(1,15))
		end
		
		if randomnumb > 15 and randomnumb < 20 then
			TriggerClientEvent("player:receiveItem",source,"plastic",math.random(1,15))
		end
		
		if randomnumb > 20 and randomnumb < 25 then
			TriggerClientEvent("player:receiveItem",source,"rubber",math.random(1,15))
		end
		
		if randomnumb > 25 and randomnumb < 30 then
			TriggerClientEvent("player:receiveItem",source,"glass",math.random(1,15))
		end
	elseif string == 'ClassB' then
	
		randomnumb = math.random(1,30)
		if randomnumb == 1 then
			TriggerClientEvent("player:receiveItem",source,"axlepartb",1)
		end
		
		if randomnumb == 2 then
			TriggerClientEvent("player:receiveItem",source,"bodypanelb",1)
		end
		
		if randomnumb == 3 then
			TriggerClientEvent("player:receiveItem",source,"brakepartb",1)
		end
		
		if randomnumb == 4 then
			TriggerClientEvent("player:receiveItem",source,"clutchpartb",1)
		end
		
		if randomnumb == 5 then
			TriggerClientEvent("player:receiveItem",source,"coolingpartb",1)
		end
		
		if randomnumb == 6 then
			TriggerClientEvent("player:receiveItem",source,"electronicpartb",1)
		end
		
		if randomnumb == 7 then
			TriggerClientEvent("player:receiveItem",source,"enginepartb",1)
		end
		
		if randomnumb == 8 then
			TriggerClientEvent("player:receiveItem",source,"fuelinjectorb",1)
		end
		
		if randomnumb == 9 then
			TriggerClientEvent("player:receiveItem",source,"tirekitb",1)
		end
		
		if randomnumb == 10 then
			TriggerClientEvent("player:receiveItem",source,"transmissionpartb",1)
		end
		
		if randomnumb > 10 and randomnumb < 15 then
			TriggerClientEvent("player:receiveItem",source,"scrapmetal",math.random(1,15))
		end
		
		if randomnumb > 15 and randomnumb < 20 then
			TriggerClientEvent("player:receiveItem",source,"plastic",math.random(1,15))
		end
		
		if randomnumb > 20 and randomnumb < 25 then
			TriggerClientEvent("player:receiveItem",source,"rubber",math.random(1,15))
		end
		
		if randomnumb > 25 and randomnumb < 30 then
			TriggerClientEvent("player:receiveItem",source,"glass",math.random(1,15))
		end
		
	elseif string == 'ClassC' then
		
		randomnumb = math.random(1,30)
		if randomnumb == 1 then
			TriggerClientEvent("player:receiveItem",source,"axlepartc",1)
		end
		
		if randomnumb == 2 then
			TriggerClientEvent("player:receiveItem",source,"bodypanelc",1)
		end
		
		if randomnumb == 3 then
			TriggerClientEvent("player:receiveItem",source,"brakepartc",1)
		end
		
		if randomnumb == 4 then
			TriggerClientEvent("player:receiveItem",source,"clutchpartc",1)
		end
		
		if randomnumb == 5 then
			TriggerClientEvent("player:receiveItem",source,"coolingpartc",1)
		end
		
		if randomnumb == 6 then
			TriggerClientEvent("player:receiveItem",source,"electronicpartc",1)
		end
		
		if randomnumb == 7 then
			TriggerClientEvent("player:receiveItem",source,"enginepartc",1)
		end
		
		if randomnumb == 8 then
			TriggerClientEvent("player:receiveItem",source,"fuelinjectorc",1)
		end
		
		if randomnumb == 9 then
			TriggerClientEvent("player:receiveItem",source,"tirekitc",1)
		end
		
		if randomnumb == 10 then
			TriggerClientEvent("player:receiveItem",source,"transmissionpartc",1)
		end
		
		if randomnumb > 10 and randomnumb < 15 then
			TriggerClientEvent("player:receiveItem",source,"scrapmetal",math.random(1,15))
		end
		
		if randomnumb > 15 and randomnumb < 20 then
			TriggerClientEvent("player:receiveItem",source,"plastic",math.random(1,15))
		end
		
		if randomnumb > 20 and randomnumb < 25 then
			TriggerClientEvent("player:receiveItem",source,"rubber",math.random(1,15))
		end
		
		if randomnumb > 25 and randomnumb < 30 then
			TriggerClientEvent("player:receiveItem",source,"glass",math.random(1,15))
		end
		
	elseif string == 'ClassD' then
	
		randomnumb = math.random(1,30)
		if randomnumb == 1 then
			TriggerClientEvent("player:receiveItem",source,"axlepartd",1)
		end
		
		if randomnumb == 2 then
			TriggerClientEvent("player:receiveItem",source,"bodypaneld",1)
		end
		
		if randomnumb == 3 then
			TriggerClientEvent("player:receiveItem",source,"brakepartd",1)
		end
		
		if randomnumb == 4 then
			TriggerClientEvent("player:receiveItem",source,"clutchpartd",1)
		end
		
		if randomnumb == 5 then
			TriggerClientEvent("player:receiveItem",source,"coolingpartd",1)
		end
		
		if randomnumb == 6 then
			TriggerClientEvent("player:receiveItem",source,"electronicpartd",1)
		end
		
		if randomnumb == 7 then
			TriggerClientEvent("player:receiveItem",source,"enginepartd",1)
		end
		
		if randomnumb == 8 then
			TriggerClientEvent("player:receiveItem",source,"fuelinjectord",1)
		end
		
		if randomnumb == 9 then
			TriggerClientEvent("player:receiveItem",source,"tirekitd",1)
		end
		
		if randomnumb == 10 then
			TriggerClientEvent("player:receiveItem",source,"transmissionpartd",1)
		end
		
		if randomnumb > 10 and randomnumb < 15 then
			TriggerClientEvent("player:receiveItem",source,"scrapmetal",math.random(1,15))
		end
		
		if randomnumb > 15 and randomnumb < 20 then
			TriggerClientEvent("player:receiveItem",source,"plastic",math.random(1,15))
		end
		
		if randomnumb > 20 and randomnumb < 25 then
			TriggerClientEvent("player:receiveItem",source,"rubber",math.random(1,15))
		end
		
		if randomnumb > 25 and randomnumb < 30 then
			TriggerClientEvent("player:receiveItem",source,"glass",math.random(1,15))
		end
		
	elseif string == 'ClassS' then
	
		randomnumb = math.random(1,30)
		if randomnumb == 1 then
			TriggerClientEvent("player:receiveItem",source,"axleparts",1)
		end
		
		if randomnumb == 2 then
			TriggerClientEvent("player:receiveItem",source,"bodypanels",1)
		end
		
		if randomnumb == 3 then
			TriggerClientEvent("player:receiveItem",source,"brakeparts",1)
		end
		
		if randomnumb == 4 then
			TriggerClientEvent("player:receiveItem",source,"clutchparts",1)
		end
		
		if randomnumb == 5 then
			TriggerClientEvent("player:receiveItem",source,"coolingparts",1)
		end
		
		if randomnumb == 6 then
			TriggerClientEvent("player:receiveItem",source,"electronicparts",1)
		end
		
		if randomnumb == 7 then
			TriggerClientEvent("player:receiveItem",source,"engineparts",1)
		end
		
		if randomnumb == 8 then
			TriggerClientEvent("player:receiveItem",source,"fuelinjectors",1)
		end
		
		if randomnumb == 9 then
			TriggerClientEvent("player:receiveItem",source,"tirekits",1)
		end
		
		if randomnumb == 10 then
			TriggerClientEvent("player:receiveItem",source,"transmissionparts",1)
		end
		
		if randomnumb > 10 and randomnumb < 15 then
			TriggerClientEvent("player:receiveItem",source,"scrapmetal",math.random(1,15))
		end
		
		if randomnumb > 15 and randomnumb < 20 then
			TriggerClientEvent("player:receiveItem",source,"plastic",math.random(1,15))
		end
		
		if randomnumb > 20 and randomnumb < 25 then
			TriggerClientEvent("player:receiveItem",source,"rubber",math.random(1,15))
		end
		
		if randomnumb > 25 and randomnumb < 30 then
			TriggerClientEvent("player:receiveItem",source,"glass",math.random(1,15))
		end
	end	
	
end)	