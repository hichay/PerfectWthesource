ESX = nil 
local vehicletable = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)





Citizen.CreateThread(function()
	local char = Config.PlateLetters
	char = char + Config.PlateNumbers
	if Config.PlateUseSpace then char = char + 1 end

	if char > 8 then
		print(('[^3WARNING^7] Plate character count reached, %s/8 characters!'):format(char))
	end

    Citizen.Wait(1000)
    MySQL.query('SELECT * FROM `vehicles`', {}, function(result)
        vehicletable = result
    end)
end)

RegisterServerEvent('vehicleshop.requestInfo')
AddEventHandler('vehicleshop.requestInfo', function()
    local src = source
    local rows    

    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = GetPlayerIdentifiers(src)[1]

    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    })

    local firstname = result[1].firstname 

    local resultVehicles = MySQL.Sync.fetchAll('SELECT * FROM vehicles')

    TriggerClientEvent('vehicleshop.receiveInfo', src, xPlayer.getAccount('bank').money, firstname)    

    TriggerClientEvent("vehicleshop.vehiclesInfos", src , resultVehicles)

    TriggerClientEvent("vehicleshop.notify", src, 'error', _U('rotate_keys'))
end)

ESX.RegisterServerCallback('pw-vehicleshop:retrieveJobVehicles', function(source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.query('SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND job = @job', {
		['@owner'] = xPlayer.identifier,
		['@type'] = type,
		['@job'] = xPlayer.job.name
	}, function(result)
		cb(result)
	end)
end)


RegisterServerEvent('vehicleshop.CheckMoneyForVeh')
AddEventHandler('vehicleshop.CheckMoneyForVeh', function(modelcar, sale, name, vehicleProps, stats)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= sale then
        xPlayer.removeMoney(sale) 	
		-- TriggerEvent('pw-garages:server:setVehicleOwned', vehicleProps, stats, modelcar)
        MySQL.query('SELECT stock FROM vehicles WHERE model = @model', {
            ['@model'] = modelcar
        }, function(result)
            if result[1].stock ~= nil then
                if result[1].stock >= 1 then
                    local restock = result[1].stock - 1
                    MySQL.query('UPDATE vehicles SET stock = @stock WHERE model = @model', {
                        ['@model'] = modelcar,
                        ['@stock'] = restock
                    })
					TriggerEvent('pw-garages:server:setVehicleOwned', vehicleProps, stats, modelcar)

                    -- MySQL.query('INSERT INTO owned_vehicles (owner, plate, props, stored) VALUES (@owner, @plate, @props, @stored)', {
                        -- ['@owner']   = xPlayer.identifier,
                        -- ['@plate']   = vehicleProps.plate,
                        -- ['@props'] = json.encode({model = GetHashKey(modelcar), plate = vehicleProps.plate}),
                        -- ['stored']   = 0
                    -- }, function(rowsChanged)
                        -- MySQL.query('UPDATE vehicles SET stock = @stock WHERE model = @model', {
                            -- ['@model'] = modelcar,
                            -- ['@stock'] = restock
                        -- })

                        -- TriggerClientEvent('vehicleshop.basarili', source, name, vehicleProps.plate, sale)
                        -- TriggerClientEvent('vehicleshop.spawnVehicle', modelcar, vehicleProps.plate)
                    -- end)
                end
            else
				TriggerEvent('pw-garages:server:setVehicleOwned', vehicleProps, stats, modelcar)
                -- MySQL.query('INSERT INTO owned_vehicles (owner, plate, props, stored) VALUES (@owner, @plate, @props, @stored)', {
                    -- ['@owner']   = xPlayer.identifier,
                    -- ['@plate']   = vehicleProps.plate,
                    -- ['@props'] = json.encode({model = GetHashKey(model), plate = vehicleProps.plate}),
                    -- ['stored']   = 0
                -- }, function(rowsChanged)

                    -- TriggerClientEvent('vehicleshop.basarili', source, name, vehicleProps.plate, sale)
                    -- TriggerClientEvent('vehicleshop.spawnVehicle', modelcar, vehicleProps.plate)
                -- end)
            end
        end)
    elseif xPlayer.getAccount('bank') >= sale then
		xPlayer.removeAccountMoney('bank', sale)
		MySQL.query('SELECT stock FROM vehicles WHERE model = @model', {
            ['@model'] = modelcar
        }, function(result)
            if result[1].stock ~= nil then
                if result[1].stock >= 1 then
                    local restock = result[1].stock - 1
                    MySQL.query('UPDATE vehicles SET stock = @stock WHERE model = @model', {
                        ['@model'] = modelcar,
                        ['@stock'] = restock
                    })
					TriggerEvent('pw-garages:server:setVehicleOwned', vehicleProps, stats, modelcar)

                    -- MySQL.query('INSERT INTO owned_vehicles (owner, plate, props, stored) VALUES (@owner, @plate, @props, @stored)', {
                        -- ['@owner']   = xPlayer.identifier,
                        -- ['@plate']   = vehicleProps.plate,
                        -- ['@props'] = json.encode({model = GetHashKey(modelcar), plate = vehicleProps.plate}),
                        -- ['stored']   = 0
                    -- }, function(rowsChanged)
                        -- MySQL.query('UPDATE vehicles SET stock = @stock WHERE model = @model', {
                            -- ['@model'] = modelcar,
                            -- ['@stock'] = restock
                        -- })

                        -- TriggerClientEvent('vehicleshop.basarili', source, name, vehicleProps.plate, sale)
                        -- TriggerClientEvent('vehicleshop.spawnVehicle', modelcar, vehicleProps.plate)
                    -- end)
                end
            else
				TriggerEvent('pw-garages:server:setVehicleOwned', vehicleProps, stats, modelcar)
                -- MySQL.query('INSERT INTO owned_vehicles (owner, plate, props, stored) VALUES (@owner, @plate, @props, @stored)', {
                    -- ['@owner']   = xPlayer.identifier,
                    -- ['@plate']   = vehicleProps.plate,
                    -- ['@props'] = json.encode({model = GetHashKey(model), plate = vehicleProps.plate}),
                    -- ['stored']   = 0
                -- }, function(rowsChanged)

                    -- TriggerClientEvent('vehicleshop.basarili', source, name, vehicleProps.plate, sale)
                    -- TriggerClientEvent('vehicleshop.spawnVehicle', modelcar, vehicleProps.plate)
                -- end)
            end
        end)
    else
        TriggerClientEvent('vehicleshop.notify', source, 'notify', 'Yeteri kadar paran yok.')
    end
end)


ESX.RegisterServerCallback('vehicleshop:buyVehicle', function (source, cb, vehicleModel)
	local xPlayer     = ESX.GetPlayerFromId(source)
	local vehicleData = nil
    if vehicleModel.modelcar == 'sh350' then 
        MySQL.single('SELECT id FROM owned_vehicles WHERE model = @model AND owner = @owner', {
            ['@model'] = vehicleModel.modelcar,
            ['@owner'] = xPlayer.getIdentifier()
        }, function(result)
            if result then 
                cb(false)
				TriggerClientEvent('DoLongHudText',-1,"Bạn đã nhận xe hỗ trợ. không thể mua thêm",2)
            else
                MySQL.single('SELECT id FROM owned_vehicles WHERE model = @model AND owner = @owner', {
                    ['@model'] = "raptor150",
                    ['@owner'] = xPlayer.getIdentifier()
                }, function(result2)
                    if result2 then 
                        cb(false)
                        TriggerClientEvent('DoLongHudText',-1,"Bạn đã nhận xe hỗ trợ. không thể mua thêm",2)
                    else
                        if xPlayer.getMoney() >= vehicleModel.sale then
                            xPlayer.removeMoney(vehicleModel.sale)
							exports["pw-balance"].addTaxFromValue("Vehicles", vehicleModel.sale)
                            MySQL.query('SELECT stock FROM vehicles WHERE model = @model', {
                                ['@model'] = vehicleModel.modelcar
                            }, function(result)
                                
                                if result[1].stock ~= nil then
                                    print('thisw')
                                    local sendToDiscord = "Người chơi "..xPlayer.getName().." vừa bỏ ra "..vehicleModel.sale.."$ để mua "..vehicleModel.modelcar..""
                                    TriggerEvent('moon_discordlogs:sendToDiscord','BuyVehicle', sendToDiscord, source, '^1') 
                                    if result[1].stock >= 1 then
                                        local restock = result[1].stock - 1
                                        MySQL.query('UPDATE vehicles SET stock = @stock WHERE model = @model', {
                                            ['@model'] = vehicleModel.modelcar,
                                            ['@stock'] = restock
                                        })
                                    cb(true)	
                                    end
                                else
                                    cb(false)
                                end
                            end)
                            
                        else
                            cb(false)
                        end
                    end
                end)
            end
        end)
    else 
        if xPlayer.getMoney() >= vehicleModel.sale then
            xPlayer.removeMoney(vehicleModel.sale)
            MySQL.query('SELECT stock FROM vehicles WHERE model = @model', {
                ['@model'] = vehicleModel.modelcar
            }, function(result)
                
                if result[1].stock ~= nil then
                    print('thisw')
                    local sendToDiscord = "Người chơi "..xPlayer.getName().." vừa bỏ ra "..vehicleModel.sale.."$ để mua "..vehicleModel.modelcar..""
                    TriggerEvent('moon_discordlogs:sendToDiscord','BuyVehicle', sendToDiscord, source, '^1') 
                    if result[1].stock >= 1 then
                        local restock = result[1].stock - 1
                        MySQL.query('UPDATE vehicles SET stock = @stock WHERE model = @model', {
                            ['@model'] = vehicleModel.modelcar,
                            ['@stock'] = restock
                        })
                    cb(true)	
                    end
                else
                    cb(false)
                end
            end)
            
        else
            cb(false)
        end  

    end

    if vehicleModel.modelcar == 'raptor150'  then 
        MySQL.single('SELECT id FROM owned_vehicles WHERE model = @model AND owner = @owner', {
            ['@model'] = vehicleModel.modelcar,
            ['@owner'] = xPlayer.getIdentifier()
        }, function(result)
            if result then 
                cb(false)
				TriggerClientEvent('DoLongHudText',-1,"Bạn đã nhận xe hỗ trợ. không thể mua thêm",2)
            else
                MySQL.single('SELECT id FROM owned_vehicles WHERE model = @model AND owner = @owner', {
                    ['@model'] = "sh350",
                    ['@owner'] = xPlayer.getIdentifier()
                }, function(result2)
                    if result2 then 
                        cb(false)
                        TriggerClientEvent('DoLongHudText',-1,"Bạn đã nhận xe hỗ trợ. không thể mua thêm",2)
                    else
                        if xPlayer.getMoney() >= vehicleModel.sale then
                            xPlayer.removeMoney(vehicleModel.sale)
							exports["pw-balance"].addTaxFromValue("Vehicles", vehicleModel.sale)
                            MySQL.query('SELECT stock FROM vehicles WHERE model = @model', {
                                ['@model'] = vehicleModel.modelcar
                            }, function(result)
                                
                                if result[1].stock ~= nil then
                                    print('thisw')
                                    local sendToDiscord = "Người chơi "..xPlayer.getName().." vừa bỏ ra "..vehicleModel.sale.."$ để mua "..vehicleModel.modelcar..""
                                    TriggerEvent('moon_discordlogs:sendToDiscord','BuyVehicle', sendToDiscord, source, '^1') 
                                    if result[1].stock >= 1 then
                                        local restock = result[1].stock - 1
                                        MySQL.query('UPDATE vehicles SET stock = @stock WHERE model = @model', {
                                            ['@model'] = vehicleModel.modelcar,
                                            ['@stock'] = restock
                                        })
                                    cb(true)	
                                    end
                                else
                                    cb(false)
                                end
                            end)
                            
                        else
                            cb(false)
                        end
                    end
                end)
            end
        end)

    else 
        if xPlayer.getMoney() >= vehicleModel.sale then
            xPlayer.removeMoney(vehicleModel.sale)
            MySQL.query('SELECT stock FROM vehicles WHERE model = @model', {
                ['@model'] = vehicleModel.modelcar
            }, function(result)
                
                if result[1].stock ~= nil then
                    print('thisw')
                    local sendToDiscord = "Người chơi "..xPlayer.getName().." vừa bỏ ra "..vehicleModel.sale.."$ để mua "..vehicleModel.modelcar..""
                    TriggerEvent('moon_discordlogs:sendToDiscord','BuyVehicle', sendToDiscord, source, '^1') 
                    if result[1].stock >= 1 then
                        local restock = result[1].stock - 1
                        MySQL.query('UPDATE vehicles SET stock = @stock WHERE model = @model', {
                            ['@model'] = vehicleModel.modelcar,
                            ['@stock'] = restock
                        })
                    cb(true)	
                    end
                else
                    cb(false)
                end
            end)
            
        else
            cb(false)
        end  
    end

end)

ESX.RegisterServerCallback('vehicleshop-plaka-cek', function(source, cb, plate)
	MySQL.query('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

RegisterNetEvent("shop:removeVehicle")
AddEventHandler("shop:removeVehicle", function(plate)
	plate = ESX.Math.Trim(plate)
	local vehicles = GetAllVehicles()
	for k,v in pairs(vehicles) do 
		local p = ESX.Math.Trim(GetVehicleNumberPlateText(v))
		if plate == p then 
			DeleteEntity(v)
		end
	end
end)