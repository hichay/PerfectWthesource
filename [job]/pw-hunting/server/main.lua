ESX = nil
local baitUsable = true
local baitTime = Config.TimeBetween
local isEntityInWater = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.EnableBait then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            if not baitUsable then
                if baitTime == 0 then
                    baitUsable = true
                    baitTime = Config.TimeBetween
                else
                    baitTime = baitTime - 1
                end
            end
        end
    end)

    ESX.RegisterUsableItem(Config.BaitItemName, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent('pw-hunting:client:canPlaceBait', source)
        Citizen.Wait(300)
        if not isEntityInWater then
            if baitUsable then
                xPlayer.removeInventoryItem(Config.BaitItemName, 1)
                TriggerClientEvent('pw-hunting:client:bait', source)
                baitUsable = false
            else
				TriggerClientEvent("ESX:Notify",source, Config.Text['between_bait'],"info")
            end
        else
			TriggerClientEvent("ESX:Notify",source, Config.Text['cant_place_bait'],"error")
        end
        
    end)
end

RegisterServerEvent('pw-hunting:server:canPlaceBaitS')
AddEventHandler('pw-hunting:server:canPlaceBaitS', function(water)
    isEntityInWater = water
end)


RegisterServerEvent('pw-hunting:Payout')
AddEventHandler('pw-hunting:Payout', function(cash)	
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addMoney(cash)
	TriggerEvent("ESX:Notify",source,"B?n v?a ki?m ???c " ..cash.. "$","success")
end)

RegisterServerEvent('pw-hunting:server:giveReward')
AddEventHandler('pw-hunting:server:giveReward', function(itemName, count)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
    TriggerClientEvent("player:receiveItem",source,itemName,count)
end)


ESX.RegisterServerCallback('pw-hunting:server:cook',function(source, cb, meatName, count)
    local xPlayer = ESX.GetPlayerFromId(source)
	local itemN = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == meatName then
			itemN = item.count
		end
	end

    if itemN >= count then
        xPlayer.removeInventoryItem(meatName, count)
        cb(true)
    else
		TriggerClientEvent("ESX:Notify",source, Config.Text['no_material'],"error")
        cb(false)
    end
end)

ESX.RegisterServerCallback('pw-hunting:server:campfire',function(source, cb, coalName, woodName, coalCount, woodCount)
    local xPlayer = ESX.GetPlayerFromId(source)
	local coalN = 0
    local woodN = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == coalName then
			coalN = item.count
        elseif item.name == woodName then
            woodN = item.count
        end
	end
    
    if coalN >= coalCount and woodN >= woodCount then
        xPlayer.removeInventoryItem(coalName, coalCount)
        xPlayer.removeInventoryItem(woodName, woodCount)
        cb(true)
    else 
		TriggerClientEvent("ESX:Notify",source, Config.Text['no_material'],"error")
        cb(false)
    end
end)

