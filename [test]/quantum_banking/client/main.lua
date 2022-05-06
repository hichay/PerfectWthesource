ESX = nil
local isInMarker = false
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
end)

-- Create blips
Citizen.CreateThread(function()
    if Config.Blips then
        for k, v in pairs(Config.Atms) do
            local blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(blip, 108)
            SetBlipScale(blip, 0.7)
            SetBlipDisplay(blip, 4)
            SetBlipColour(blip, 5)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(tostring(v.name))
            EndTextCommandSetBlipName(blip)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if isInMarker then
            if Config.DisplayHelpText then
                ESX.ShowHelpNotification(Config.HelpText)
            end
            if IsControlJustPressed(0, Config.OpenKey) then
                SendNUIMessage({
                    action = 'open'
                })
                SetNuiFocus(true, true)
                TriggerServerEvent('nightstudio_banking:balance')
                TriggerServerEvent('nightstudio_banking:cardnumber')
                TriggerServerEvent('nightstudio_banking:getTransactions')
            end
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(250)

        local player = PlayerPedId()
        local coords = GetEntityCoords(player)

        isInMarker = false
        for _, bank in pairs(Config.Atms) do
            local distance = Vdist(coords, bank.x, bank.y, bank.z)
            if distance <= 1.3 then
                isInMarker = true
            end
        end
    end
end)

RegisterNUICallback('closeBanking', function()
    SetNuiFocus(false, false)
    SendNUIMessage({action = 'close'})
end)

RegisterNetEvent('nightstudio_banking:refreshData')
AddEventHandler('nightstudio_banking:refreshData', function()
    TriggerServerEvent('nightstudio_banking:getTransactions')
    TriggerServerEvent('nightstudio_banking:balance')
end)

RegisterNetEvent('nightstudio_banking:currentBalance')
AddEventHandler('nightstudio_banking:currentBalance', function(bal, bal2)
    local id = PlayerPedId()
    local name = GetPlayerName(id)

    SendNUIMessage({
        action = "bal",
        bal = bal,
        bal2 = bal2,
        player = name,
    })

end)

RegisterNetEvent('nightstudio_banking:setTransactions')
AddEventHandler('nightstudio_banking:setTransactions', function(transactions)

    SendNUIMessage({
        action = "transactions",
        transactions = transactions
    })

end)

RegisterNetEvent('nightstudio_banking:setCardnumber')
AddEventHandler('nightstudio_banking:setCardnumber', function(cardnumber)

    SendNUIMessage({
        action = 'cardnumber',
        card = cardnumber
    })
end)

AddEventHandler('onResourceStop', function(resourceName) 

    if (GetCurrentResourceName ~= resourceName) then
        return
    else
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = 'close'
        })
    end
end)

RegisterNUICallback('geldAuszahlen', function(data)

    TriggerServerEvent('nightstudio_banking:withdraw', tonumber(data.betrag))
    TriggerServerEvent('nightstudio_banking:balance')

end)

RegisterNUICallback('geldEinzahlen', function(data)

    TriggerServerEvent('nightstudio_banking:deposit', tonumber(data.betrag))
    TriggerServerEvent('nightstudio_banking:balance')
end)

RegisterNUICallback('transferGeld', function(data)

    TriggerServerEvent('nightstudio_banking:transfer', tonumber(data.betrag), tonumber(data.to), data.text)
    TriggerServerEvent('nightstudio_banking:balance')
end)