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
    for i=1, #playerData.accounts, 1 do
		if playerData.accounts[i].name == 'money' then
			cashAmount = playerData.accounts[i].money
			break
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