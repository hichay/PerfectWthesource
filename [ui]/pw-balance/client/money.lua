ESX = nil

Citizen.CreateThread(function() 
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)    
        Citizen.Wait(200)
    end
    PlayerData = ESX.GetPlayerData()
end)


local cashAmount = 0 
RegisterNetEvent("hud:client:ShowMoney")
AddEventHandler("hud:client:ShowMoney", function()
	local playerData = ESX.GetPlayerData()
    for i=1, #playerData.accounts, 1 do
		if playerData.accounts[i].name == 'money' then
			cashAmount = playerData.accounts[i].money
		end
	end
	
	SendNUIMessage({
		type = 'cash', 
		casheData = {amount = cashAmount},
		
	})
	
end)

RegisterNetEvent("hud:client:OnMoneyChange")
AddEventHandler("hud:client:OnMoneyChange", function(type, amount, isMinus)
	local playerData = ESX.GetPlayerData()
	-- for i=1, #playerData.accounts, 1 do
		-- if playerData.accounts[i].name == 'bank' then
			-- bankAmount = playerData.accounts[i].money
			-- break
		-- end
	-- end
	local cashAmount
	for i=1, #playerData.accounts, 1 do
		if playerData.accounts[i].name == 'money' then
			cashAmount = playerData.accounts[i].money
		end
	end
	
	if isMinus then 
		SendNUIMessage({
			type = 'cashe', 
			casheData = {addedamount = '- ' .. amount, amount = cashAmount},
			
		})
	else
		SendNUIMessage({
			type = 'cashe', 
			casheData = {addedamount = '+ ' .. amount, amount = cashAmount},
			
		})
	end
end)

-- RegisterCommand("buff", function(source, args, rawCommand)
	-- exports['ps-buffs']:StaminaBuffEffect(15000, 2.4)
-- end, false)

-- RegisterCommand("armor", function(source, args, rawCommand)
	-- exports['ps-buffs']:AddArmorBuff(30000, 10)
-- end, false)

-- RegisterCommand("health", function(source, args, rawCommand)
	-- exports['ps-buffs']:AddHealthBuff(10000, 10)
-- end, false)