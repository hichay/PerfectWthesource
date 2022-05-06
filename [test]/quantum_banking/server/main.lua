ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

RegisterServerEvent('nightstudio_banking:balance')
AddEventHandler('nightstudio_banking:balance', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    local bal = xPlayer.getAccount('bank').money
    local bal2 = xPlayer.getAccount('money').money

    TriggerClientEvent('nightstudio_banking:currentBalance', source, bal, bal2)
end)

RegisterServerEvent('nightstudio_banking:cardnumber')
AddEventHandler('nightstudio_banking:cardnumber', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll('SELECT iban FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(result)
        TriggerClientEvent('nightstudio_banking:setCardnumber', _source, result[1].iban)
    end)
end)

RegisterServerEvent('nightstudio_banking:getTransactions')
AddEventHandler('nightstudio_banking:getTransactions', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll('SELECT iban FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(result)
        local transactions = {}
        MySQL.Async.fetchAll('SELECT * FROM transactions WHERE receiver = @receiver OR sender = @sender', {
            ['@receiver'] = result[1].iban,
            ['@sender'] = result[1].iban
        }, function(results)
            for i = 1, #results, 1 do
                table.insert(transactions, {
                    id = results[i].transaction_id,
                    receiver = results[i].receiver,
                    sender = results[i].sender,
                    amount = results[i].amount,
                    text = results[i].description,
                    date = results[i].date
                })
            end
            TriggerClientEvent('nightstudio_banking:setTransactions', src, transactions)
        end)
    end)
end)

-- AddEventHandler('playerJoining', function()
    -- local xPlayer = ESX.GetPlayerFromId(source)
    -- local identifier = false

    -- local license = false
    -- for k, v in pairs(GetPlayerIdentifiers(source)) do
        -- if string.sub(v, 1, string.len("license:")) == "license:" then
            -- identifier = string.sub(v, 9)
        -- end
    -- end

    -- MySQL.Async.fetchAll('SELECT cardnumber FROM users WHERE identifier = @identifier', {
        -- ['@identifier'] = identifier
    -- }, function(result)

        -- if result[1].cardnumber == nil then
            -- local cardnumber = math.random(1000000000000000, 9999999999999999)
            -- MySQL.Async.execute('UPDATE users SET `cardnumber` = @cardnumber WHERE identifier = @identifier', {
                -- ['@cardnumber'] = cardnumber,
                -- ['@identifier'] = identifier
            -- })
            -- print('Added cardnumber to player')
        -- end
    -- end)

-- end)

RegisterServerEvent('nightstudio_banking:withdraw')
AddEventHandler('nightstudio_banking:withdraw', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local bank = xPlayer.getAccount('bank').money

    amount = tonumber(amount)

    if amount == nil or amount <= 0 or amount > bank then
        TriggerClientEvent("ESX:Notify",source,Config.Translations[Config.Locale]['not_enough'],'error')
    else
        xPlayer.removeAccountMoney('bank', amount)
        xPlayer.addMoney(amount)
        TriggerClientEvent("ESX:Notify",source,Config.Translations[Config.Locale]['money_withdrawn'],'succes')
    end
end)

RegisterServerEvent('nightstudio_banking:deposit')
AddEventHandler('nightstudio_banking:deposit', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getAccount('money').money

    amount = tonumber(amount)

    if amount == nil or amount <= 0 or amount > money then
        TriggerClientEvent("ESX:Notify",source,Config.Translations[Config.Locale]['not_enough'],'error')
    else
        xPlayer.removeMoney(amount)
        xPlayer.addAccountMoney('bank', amount)
        TriggerClientEvent("ESX:Notify",source,Config.Translations[Config.Locale]['money_deposit'],'success')
    end
end)

RegisterServerEvent('nightstudio_banking:transfer')
AddEventHandler('nightstudio_banking:transfer', function(betrag, to, text)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local bank = xPlayer.getAccount('bank').money

    betrag = tonumber(betrag)

    if betrag == nil or betrag <= 0 then
        TriggerClientEvent("ESX:Notify",source,Config.Translations[Config.Locale]['invalid_amount'],'error')
    elseif betrag > bank then
        TriggerClientEvent("ESX:Notify",source,Config.Translations[Config.Locale]['not_enough'],'error')
    else
        MySQL.Async.fetchAll('SELECT * FROM users WHERE iban = @iban', {
            ['@iban'] = to
        }, function(result)
            if result[1] ~= nil then
                local xPlayers = ESX.GetPlayers()
                local playerFound = false
                for i = 1, #xPlayers, 1 do
                    local xtargetPlayer = ESX.GetPlayerFromId(xPlayers[i])

                    if xtargetPlayer.getIdentifier() == result[1].identifier then
                        xtargetPlayer.addAccountMoney('bank', betrag)
                        TriggerClientEvent("ESX:Notify",xtargetPlayer.source,string.format(Config.Translations[Config.Locale]['received_money'], betrag),'success')
                        playerFound = true
                        xPlayer.removeAccountMoney('bank', betrag)
                        TriggerClientEvent("ESX:Notify",src,string.format(Config.Translations[Config.Locale]['send_money'], result[1].firstname.." "..result[1].lastname, betrag),'success')
                    end
                end
                if not playerFound then
                    TriggerClientEvent("ESX:Notify",src,"Người chơi không tồn tại",'info')
                end

                MySQL.Async.fetchAll('SELECT iban FROM users WHERE identifier = @identifier', {
                    ['@identifier'] = xPlayer.getIdentifier()
                }, function(result) 

                MySQL.Async.execute(
                    'INSERT INTO transactions (transaction_id, receiver, sender, amount, description, date) VALUES(@transaction_id, @receiver, @sender, @amount, @description, @date)',
                    {
                        ['@transaction_id'] = math.random(100000000, 999999999),
                        ['@receiver'] = to,
                        ['@sender'] = result[1].iban,
                        ['@amount'] = betrag,
                        ['@description'] = text,
                        ['@date'] = os.date("%c"),
                    })
                end)
                TriggerClientEvent('nightstudio_banking:transactions', src)
            end
        end)
    end
end)
