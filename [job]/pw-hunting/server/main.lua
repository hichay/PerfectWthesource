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
                --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'Error', text = Config.Text['between_bait']})
				TriggerClientEvent("ESX:Notify",source, Config.Text['between_bait'],"info")
            end
        else
            --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'Error', text = Config.Text['cant_place_bait']})
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
	
    -- xPlayer.addInventoryItem(itemName, count)
	TriggerClientEvent("player:receiveItem",source,itemName,count,true,true,"S?n ph?m t? th? r?ng")
end)

-- RegisterServerEvent('pw-hunting:server:sell')
-- AddEventHandler('pw-hunting:server:sell', function(itemName, price, count, blackMoney)
    -- local _source = source
	-- local xPlayer = ESX.GetPlayerFromId(_source)
	-- local itemN = nil
	-- for i=1, #xPlayer.inventory, 1 do
		-- local item = xPlayer.inventory[i]

		-- if item.name == itemName then
			-- itemN = item.count
		-- end
	-- end
    -- if itemN >= count then
        -- xPlayer.removeInventoryItem(itemName, count)
        -- if blackMoney then
            -- xPlayer.addAccountMoney('black_money', price*count)
        -- else
            -- xPlayer.addMoney(price*count)
        -- end
        -- TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Succesfully sold' })
    -- else
        -- TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'Error', text = Config.Text['no_material'] })
    -- end
-- end)

-- RegisterServerEvent('pw-hunting:server:giveMoney')
-- AddEventHandler('pw-hunting:server:giveMoney', function(count, blackMoney)
    -- local _source = source
	-- local xPlayer = ESX.GetPlayerFromId(_source)
    -- TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'Success', text = Config.Text['sold'] })
-- end)

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
        --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'Error', text = Config.Text['no_material']})
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
        --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'Error', text = Config.Text['no_material'] })
		TriggerClientEvent("ESX:Notify",source, Config.Text['no_material'],"error")
        cb(false)
    end
end)

-- ESX.RegisterServerCallback('pw-hunting:server:giveLicense', function(source, id)
	-- --local xPlayer = ESX.GetPlayerFromId(source)

    -- local xPlayer = ESX.GetPlayerFromId(id)

	-- if xPlayer then
		-- TriggerEvent('esx_license:addLicense', source, 'hunt', function()
            -- TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'Inform', text = 'Success' })
        -- end)
	-- else
        -- TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'Error', text = 'No player nearby' })
	-- end
-- end)
