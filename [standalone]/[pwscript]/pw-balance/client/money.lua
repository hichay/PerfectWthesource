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
AddEventHandler("hud:client:ShowMoney", function(type)
    TriggerEvent("hud:client:SetMoney")
    SendNUIMessage({
        action = "show",
        cash = cashAmount,
        bank = bankAmount,
        type = type,
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
	for i=1, #playerData.accounts, 1 do
		if playerData.accounts[i].name == 'money' then
			cashAmount = playerData.accounts[i].money
			break
		end
	end
	

	 	
    if RLHud.Money.ShowConstant then
        SendNUIMessage({
            action = "open",
            cash = cashAmount,
            bank = bankAmount,
        })
    else
        SendNUIMessage({
            action = "update",
            cash = cashAmount,
            bank = bankAmount,
            amount = amount,
            minus = isMinus,
            type = type,
        })
    end
end)