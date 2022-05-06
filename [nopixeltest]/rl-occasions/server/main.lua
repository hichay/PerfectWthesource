ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('rl-occasions:server:getVehicles', function(source, cb)
    exports['ghmattimysql']:execute('SELECT * FROM `occasion_vehicles`', function(result)
        if result[1] ~= nil then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

ESX.RegisterServerCallback("rl-garage:server:checkVehicleOwner", function(source, cb, plate)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

    exports['ghmattimysql']:execute('SELECT * FROM owned_vehicles WHERE plate = @plate AND owner  = @identifier', {['@plate'] = plate, ['@identifier'] = xPlayer.identifier}, function(result)
        if result[1] ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback("rl-occasions:server:getSellerInformation", function(source, cb, identifier)
    local src = source

    exports['ghmattimysql']:execute('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = identifier}, function(result)
        if result[1] ~= nil then
            cb(result[1])
        else
            cb(nil)
        end
    end)
end)

RegisterServerEvent('rl-occasions:server:ReturnVehicle')
AddEventHandler('rl-occasions:server:ReturnVehicle', function(vehicleData)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    exports['ghmattimysql']:execute("SELECT * FROM `occasion_vehicles` WHERE `plate` = '"..vehicleData['plate'].."' AND `occasionid` = '"..vehicleData["oid"].."'", function(result)
        if result[1] ~= nil then 
            if result[1].seller == xPlayer.indentifier then
                exports['ghmattimysql']:execute("INSERT INTO `owned_vehicles` (`owner`, `model`, , `props`, `plate`, `state`, `stats`) VALUES ('"..xPlayer.indentifier.."', '"..vehicleData["model"].."', '"..vehicleData["mods"].."', '"..vehicleData["plate"].."', 'impound'), '"..vehicleData["stats"].."'")
                exports['ghmattimysql']:execute("DELETE FROM `occasion_vehicles` WHERE `occasionid` = '"..vehicleData["oid"].."' and `plate` = '"..vehicleData['plate'].."'")
                TriggerClientEvent("rl-occasions:client:ReturnOwnedVehicle", src, result[1])
                TriggerClientEvent('rl-occasion:client:refreshVehicles', -1)
            else
                TriggerClientEvent('RLCore:Notify', src, 'This is not your vehicle...', 'error', 3500)
            end
        else
            TriggerClientEvent('RLCore:Notify', src, 'Vehicle does not exist...', 'error', 3500)
        end
    end)
end)

RegisterServerEvent('rl-occasions:server:sellVehicle')
AddEventHandler('rl-occasions:server:sellVehicle', function(vehiclePrice, vehicleData)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    exports['ghmattimysql']:execute("DELETE FROM `owned_vehicles` WHERE `plate` = '"..vehicleData.plate.."' AND `model` = '"..vehicleData.model.."'")
    exports['ghmattimysql']:execute("INSERT INTO `occasion_vehicles` (`seller`, `price`, `description`, `plate`, `model`, `mods`, `occasionid`,`stats`) VALUES ('"..xPlayer.identifier.."', '"..vehiclePrice.."', '"..escapeSqli(vehicleData.desc).."', '"..vehicleData.plate.."', '"..vehicleData.model.."', '"..json.encode(vehicleData.mods).."','"..generateOID().."', '"..json.encode(vehicleData.stats).."')")
    

    TriggerClientEvent('rl-occasion:client:refreshVehicles', -1)
end)

RegisterServerEvent('rl-occasions:server:buyVehicle')
AddEventHandler('rl-occasions:server:buyVehicle', function(vehicleData)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    exports['ghmattimysql']:execute("SELECT * FROM `occasion_vehicles` WHERE `plate` = '"..vehicleData['plate'].."' AND `occasionid` = '"..vehicleData["oid"].."'", function(result)
        if result[1] ~= nil and next(result[1]) ~= nil then
            if xPlayer.getMoney() >= result[1].price then
                local SellerCitizenId = result[1].seller
                --local SellerData = RLCore.Functions.GetPlayerByCitizenId(SellerCitizenId)
                -- New price calculation minus tax
                local NewPrice = math.ceil((result[1].price / 100) * 77)

                xPlayer.removeMoney(result[1].price)

                -- Insert vehicle for buyer
                exports['ghmattimysql']:execute("INSERT INTO `owned_vehicles` (`owner`, `model`, `props`, `plate`, `state` , `stats`) VALUES ('"..xPlayer.identifier.."', '"..result[1].model.."', '"..result[1].mods.."', '"..result[1].plate.."', 'impound', '"..result[1].stats.."')")
                
                -- Handle money transfer
                if SellerCitizenId ~= nil then
                    -- Add money for online
                    --SellerData.Functions.AddMoney('bank', NewPrice)
					
					xPlayer.addAccountMoney('bank', NewPrice)
                else
                    -- Add money for offline
                    exports['ghmattimysql']:execute("SELECT * FROM `users` WHERE `identifier` = '"..SellerCitizenId.."'", function(BuyerData)
                        if BuyerData[1] ~= nil then
                            local BuyerMoney = json.decode(BuyerData[1].accounts)
                            BuyerMoney.bank = BuyerMoney.bank + NewPrice
                            exports['ghmattimysql']:execute("UPDATE `users` SET `accounts` = '"..json.encode(BuyerMoney).."' WHERE `identifier` = '"..SellerCitizenId.."'")
                        end
                    end)
                end


                TriggerClientEvent('rl-occasion:client:refreshVehicles', -1)
            
                -- Delete vehicle from Occasion
                exports['ghmattimysql']:execute("DELETE FROM `occasion_vehicles` WHERE `plate` = '"..result[1].plate.."' and `occasionid` = '"..result[1].occasionid.."'")

                -- Send selling mail to seller
                TriggerEvent('qb-phone:server:sendNewMailToOffline', SellerCitizenId, {
                    sender = "Mosleys Occasions",
                    subject = "You have sold a vehicle!",
                    message = result[1].model.." is sold for €"..result[1].price..",-!"
                })
            elseif xPlayer.getAccount('bank').money >= result[1].price then
                local SellerCitizenId = result[1].seller
                --local SellerData = RLCore.Functions.GetPlayerByCitizenId(SellerCitizenId)
                -- New price calculation minus tax
                local NewPrice = math.ceil((result[1].price / 100) * 77)

                --Player.Functions.RemoveMoney('bank', result[1].price)
				xPlayer.removeAccountMoney('bank',result[1].price)

                -- Insert vehicle for buyer
                exports['ghmattimysql']:execute("INSERT INTO `owned_vehicles` (`owner`, `model`, `props`, `plate`, `state`, `stats`) VALUES ( '"..xPlayer.identifier.."', '"..result[1].model.."', '"..result[1].mods.."', '"..result[1].plate.."', 'impound', '"..result[1].stats.."')")
                
                -- Handle money transfer
                if SellerCitizenId ~= nil then
                    -- Add money for online
                    xPlayer.addAccountMoney('bank', NewPrice)
                else
                    -- Add money for offline
                    exports['ghmattimysql']:execute("SELECT * FROM `users` WHERE `citizenid` = '"..SellerCitizenId.."'", function(BuyerData)
                        if BuyerData[1] ~= nil then
                            local BuyerMoney = json.decode(BuyerData[1].accounts)
                            BuyerMoney.bank = BuyerMoney.bank + NewPrice
                            exports['ghmattimysql']:execute("UPDATE `users` SET `accounts` = '"..json.encode(BuyerMoney).."' WHERE `identifier` = '"..SellerCitizenId.."'")
                        end
                    end)
                end
            
                -- Delete vehicle from Occasion
                exports['ghmattimysql']:execute("DELETE FROM `occasion_vehicles` WHERE `plate` = '"..result[1].plate.."' and `occasionid` = '"..result[1].occasionid.."'")

                -- Send selling mail to seller
                TriggerEvent('qb-phone:server:sendNewMailToOffline', SellerCitizenId, {
                    sender = "Mosleys Occasions",
                    subject = "U heeft een voertuig verkocht!",
                    message = "Je "..result[1].model.." is verkocht voor €"..result[1].price..",-!"
                })
            else
                TriggerClientEvent('RLCore:Notify', src, 'You do not have enough money..', 'error', 3500)
            end
        end
    end)
end)

function generateOID()
    local num = math.random(1, 10)..math.random(111, 999)

    return "OC"..num
end

function round(number)
    return number - (number % 1)
end

function escapeSqli(str)
    local replacements = { ['"'] = '\\"', ["'"] = "\\'" }
    return str:gsub( "['\"]", replacements ) -- or string.gsub( source, "['\"]", replacements )
end