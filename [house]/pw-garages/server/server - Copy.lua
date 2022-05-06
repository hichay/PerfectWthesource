ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetOSSep()
	if os.getenv('HOME') then
		return '/'
	else
		return '\\'
	end
end


serverConfig = GaragesConfig
serverConfig['garages'] = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json'))
serverConfig['impounds'] = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'impounds.json'))
serverConfig['houses'] = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'houses.json'))
local networkVehicles = {}
local isAuthorized = true
local coordsSaver = {}


CreateThread(function()
    Wait(1000)
    TriggerEvent('pw-garages:server:setFirstData')

    --[[
    local resName = GetCurrentResourceName()
    if resName ~= "pw-garages" then
        print('^1[barbaroNNs garages] ^7Not Authorized | Wrong Resource Name.')
        local embed = {
        {
                ["color"] = "65450",
                ["title"] = 'Product Started',
                ["description"] = '**Product Name:** pw-garages\n**Not Authorized** | Name failed ' .. resName,
                ["footer"] = {
                    ["text"] = "Made by barbaroNN#0006",
                },
            }
        }
        PerformHttpRequest("https://discordapp.com/api/webhooks/761083962189414410/Ahfu4NaHJRTMBToEQ4sBlG-vcqnmRdFJqHKoG5Vchi6V20MRh-AFACGCkbZbeL6ntHwp", function(err, text, headers) end, 'POST', json.encode({username = 'barbaroNNs Products', embeds = embed}), { ['Content-Type'] = 'application/json' })
        while true do end
        return
    end

    if GaragesConfig == nil or GaragesConfig['settings']['license'] == nil then
        print('^1[barbaroNNs garages] ^7Unable to locate the Config File.')
        local embed = {
            {
                ["color"] = "65450",
                ["title"] = 'Product Started',
                ["description"] = '**Product Name:** ' .. resName .. '\n**Not Authorized** | Config failed',
                ["footer"] = {
                    ["text"] = "Made by barbaroNN#0006",
                },
            }
        }
        PerformHttpRequest("https://discordapp.com/api/webhooks/761083962189414410/Ahfu4NaHJRTMBToEQ4sBlG-vcqnmRdFJqHKoG5Vchi6V20MRh-AFACGCkbZbeL6ntHwp", function(err, text, headers) end, 'POST', json.encode({username = 'barbaroNNs Products', embeds = embed}), { ['Content-Type'] = 'application/json' })
        while true do end
        return
    end

    PerformHttpRequest("https://api.myip.com/", function(err, text, headers) 
        local ip = json.decode(text).ip
        PerformHttpRequest("http://barbaronn.xyz/api/licensingSystem.php/?api_key=A462D4A614E645267556B5870&license=" .. GaragesConfig['settings']['license'] .. "&ip=" .. ip, function(err, text, headers) 
            local data = json.decode(text)
            if data["Code"] ~= "200" then
                print('^6[barbaroNNs garages] ^7Not ^1Authorized.')
                local embed = {
                {
                        ["color"] = "65450",
                        ["title"] = 'Product Started',
                        ["description"] = '**Product Name:** ' .. resName .. '\n**IP:** ' .. ip .. '\n**License:** ' .. GaragesConfig['settings']['license'] .. '\n**Not Authorized** | Triggered Server Crash',
                        ["footer"] = {
                            ["text"] = "Made by barbaroNN#0006",
                        },
                    }
                }
                PerformHttpRequest("https://discordapp.com/api/webhooks/761083962189414410/Ahfu4NaHJRTMBToEQ4sBlG-vcqnmRdFJqHKoG5Vchi6V20MRh-AFACGCkbZbeL6ntHwp", function(err, text, headers) end, 'POST', json.encode({username = 'barbaroNNs Products', embeds = embed}), { ['Content-Type'] = 'application/json' })
                while true do end
            else
                local embed = {
                {
                        ["color"] = "65450",
                        ["title"] = 'Product Started',
                        ["description"] = '**Product Name:** ' .. resName .. '\n**IP:** ' .. ip .. '\n**License:** ' .. GaragesConfig['settings']['license'] .. '\n**Authorized** | ' .. data["Text"],
                        ["footer"] = {
                            ["text"] = "Made by barbaroNN#0006",
                        },
                    }
                }
                PerformHttpRequest("https://discordapp.com/api/webhooks/761083962189414410/Ahfu4NaHJRTMBToEQ4sBlG-vcqnmRdFJqHKoG5Vchi6V20MRh-AFACGCkbZbeL6ntHwp", function(err, text, headers) end, 'POST', json.encode({username = 'barbaroNNs Products', embeds = embed}), { ['Content-Type'] = 'application/json' })
                print('^6[barbaroNNs garages] ^7' .. data["Text"] .. ' ^2Authorized.')
                isAuthorized = true
                
            end
        end)
    end)]]
end)

RegisterServerEvent('pw-garages:server:setFirstData')
AddEventHandler('pw-garages:server:setFirstData', function()
    local src = source
    exports['ghmattimysql']:execute("SELECT * FROM `owned_vehicles`", function(vehicles)
        if vehicles[1] ~= nil then
            local counter, impound = 0, 0
            for _, veh in pairs(vehicles) do
                if veh.state == 'garage' then
                    counter = counter + 1
                    local data = json.decode(veh.parking)
                    serverConfig['garages'][data[2]]['slots'][data[1]][2] = false
                    serverConfig['garages'][data[2]]['slots'][data[1]][3] = {model = veh.model, vehicle = json.decode(veh.vehicle), plate = veh.plate}
                elseif veh.state == 'house' then
                    local data = json.decode(veh.parking)
                    serverConfig['houses'][data[2]]['slots'][data[1]][2] = false
                    serverConfig['houses'][data[2]]['slots'][data[1]][3] = {model = veh.model, vehicle = json.decode(veh.vehicle), plate = veh.plate}
                elseif veh.state == 'unknown' then
                    exports['ghmattimysql']:execute("UPDATE `owned_vehicles` SET `state` = 'impound', `parking` = '' WHERE `plate` = '" .. veh.plate .. "' AND `owner` = '" .. veh.owner .. "' LIMIT 1")
                end

                if veh.fakeplate ~= nil and veh.fakeplate ~= '' then
                    exports['ghmattimysql']:execute("UPDATE `owned_vehicles` SET `fakeplate` = '' WHERE `plate` = '" .. veh.plate .. "' AND `owner` = '" .. veh.owner .. "' LIMIT 1")
                end
            end
            
            print('^6[barbaroNNs garages] ^7Loaded ' .. tostring(math.ceil(counter)) .. ' vehicles.')
            TriggerClientEvent('pw-garages:client:createParkingVehicle',true)
        else
            print('^6[barbaroNNs garages] ^7Could not find any vehicles.')
        end

        exports['ghmattimysql']:execute("SELECT * FROM `player_houses`", function(housing)
            local counter = 0
            if housing[1] ~= nil then
                for key, house in pairs(housing) do
                    if serverConfig['houses'][house.id] ~= nil then
					print("sdvv")
                        serverConfig['houses'][id]['acess'] = json.decode(house.keyholders)
                        counter = counter + 1
                    end
                end

                print('^6[barbaroNNs garages] ^7Loaded ' .. tostring(counter) .. ' house garages.')
            else
                print('^6[barbaroNNs garages] ^7Could not find any house garages.')
            end

            TriggerClientEvent('pw-garages:client:syncConfig', -1, 1, serverConfig)
            print('^6[barbaroNNs garages] ^7Waiting for first player in order to create vehicles.')
            
            while #ESX.GetPlayers() <= 0 do Wait(0) end
            local playerid = ESX.GetPlayers()
            TriggerClientEvent('pw-garages:client:createParkingVehicle',playerid, true)
        end)
    end)
end)

RegisterServerEvent('pw-garages:server:impoundVehicle')
AddEventHandler('pw-garages:server:impoundVehicle', function(plate)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    
    exports['ghmattimysql']:execute("UPDATE `owned_vehicles` SET `state` = 'impound', `parking` = '' WHERE `plate` = '" .. plate .. "' AND `owner` = '" .. xPlayer.getIdentifier() .. "' LIMIT 1")
end)
    
RegisterServerEvent('pw-garages:server:parkVehicle')
AddEventHandler('pw-garages:server:parkVehicle', function(garage, typ, slots, plate, stats)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    local time = os.time()

    if typ == 'garages' then
        serverConfig['garages'][garage]['slots'][slots[1]][2] = false

        local jsonz = {slots[1], garage, plate, time}
        --[[ local jsonz = {
            ["slots"] = slots[1], 
            ["garage"] = garage, 
            ["plate"] = plate, 
            ["time"] = time,
        } ]]
        exports['ghmattimysql']:execute("SELECT `vehicle` FROM `owned_vehicles` WHERE `owner` = '" .. xPlayer.getIdentifier() .. "' AND `plate` = '" .. plate .. "' LIMIT 1", function(props)
            if props[1] ~= nil then
                local vehicleprops = json.decode(props[1].vehicle)
                serverConfig['garages'][garage]['slots'][slots[1]][3] = {model = vehicleprops.model, vehicle = vehicleprops, plate = plate}

                exports['ghmattimysql']:execute("UPDATE `owned_vehicles` SET `stats` = '" .. json.encode(stats) .. "', `state` = 'garage', `parking` = '" .. json.encode(jsonz) .. "' WHERE `owner` = '" .. xPlayer.getIdentifier() .. "' AND `plate` = '" .. plate .. "'")
                TriggerClientEvent('pw-garages:client:syncConfig', -1, 2, 'garages', garage, 'slots', serverConfig['garages'][garage]['slots'])
                TriggerClientEvent('pw-garages:client:createParkingVehicle', src, false, serverConfig['garages'][garage]['slots'][slots[1]])
                TriggerEvent("ESX:Notify",source,"Đỗ xe vào bãi đỗ thành công","success")
            else
                print('^1[pw-garages] ^7' .. GetPlayerName(src) .. ' just tried to expoilt the garages.')
            end
        end)
    elseif typ == 'houses' then
        --serverConfig['houses'][garage]['slots'][slots[1]][2] = false
        local jsonz = {slots[1], garage, plate}
        --[[ local jsonz = {
            ["slots"] = slots[1], 
            ["garage"] = garage, 
            ["plate"] = plate, 
            ["time"] = time,
        } ]]
        exports['ghmattimysql']:execute("SELECT `vehicle` FROM `owned_vehicles` WHERE `owner` = '" .. xPlayer.getIdentifier() .. "' AND `plate` = '" .. plate .. "' LIMIT 1", function(props)
            if props[1] ~= nil then
                local vehicleprops = json.decode(props[1].props)
                serverConfig['houses'][garage]['slots'][slots[1]][3] = {model = vehicleprops.model, props = vehicleprops, plate = plate}

                exports['ghmattimysql']:execute("UPDATE `owned_vehicles` SET `stats` = '" .. json.encode(stats) .. "', `state` = 'house', `parking` = '" .. json.encode(jsonz) .. "' WHERE `owner` = '" .. xPlayer.getIdentifier() .. "' AND `plate` = '" .. plate .. "'")
                TriggerClientEvent('pw-garages:client:syncConfig', -1, 2, 'houses', garage, 'slots', serverConfig['houses'][garage]['slots'])
                TriggerClientEvent('pw-garages:client:createParkingVehicle', src, false, serverConfig['houses'][garage]['slots'][slots[1]])
            else
                print('^1[pw-garages] ^7' .. GetPlayerName(src) .. ' just tried to expoilt the garages.')
            end
        end)
    end
end)

RegisterServerEvent('pw-garages:server:setVehicleOwned')
AddEventHandler('pw-garages:server:setVehicleOwned', function(props, stats, model)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    

    exports['ghmattimysql']:execute("INSERT INTO `owned_vehicles` (`owner`, `plate`, `model`, `vehicle`, `stats`, `state`) VALUES ('" .. xPlayer.identifier .. "', '" .. props.plate .. "', '" .. model .. "', '" .. json.encode(props) .. "', '" .. json.encode(stats) .. "', 'unknown')")
end)

RegisterServerEvent('pw-garages:server:updateProps')
AddEventHandler('pw-garages:server:updateProps', function(props)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    

    exports['ghmattimysql']:execute("UPDATE `owned_vehicles` SET `stats` = '" .. json.encode(stats) .. "', `state` = 'garage', `parking` = '" .. json.encode(jsonz) .. "' WHERE `owner` = '" .. xPlayer.getIdentifier() .. "' AND `plate` = '" .. plate .. "'")
    exports['ghmattimysql']:execute("UPDATE `owned_vehicles` (`vehicle`) VALUES ('" .. xPlayer.getIdentifier() .. "', '" .. props.plate .. "', '" .. model .. "', '" .. json.encode(props) .. "', '" .. json.encode(stats) .. "', 'unknown')")
end)

RegisterServerEvent('pw-garages:server:vehiclePayout')
AddEventHandler('pw-garages:server:vehiclePayout', function(garage, plate, price, typ)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    
    if typ ~= 'houses' then
        if xPlayer.getMoney() >= price or (GaragesConfig['settings']['bank-payments'] == true and xPlayer.getMoney() >= price) then
            exports['ghmattimysql']:execute("SELECT * FROM `owned_vehicles` WHERE `owner` = '" .. xPlayer.getIdentifier() .. "' AND `plate` = '" .. plate .. "' LIMIT 1", function(vehicle)
                if vehicle[1] ~= nil then
                    local veh = vehicle[1]
                    --local modelExists = IsModelExists(veh.model)
					local a = true
                    if a then
						xPlayer.removeMoney(price)
                        if true then
							
                            exports['ghmattimysql']:execute("UPDATE `owned_vehicles` SET `state` = 'unknown', `parking` = '' WHERE `id` = '" .. veh.id .. "'")
                            if typ == 'garages' then
                                serverConfig['garages'][garage]['slots'][json.decode(veh.parking)[1]][2] = true
                                serverConfig['garages'][garage]['slots'][json.decode(veh.parking)[1]][3] = nil
                                TriggerClientEvent('pw-garages:client:syncConfig', -1, 2, 'garages', garage, 'slots', serverConfig['garages'][garage]['slots'])
                                print('^2[pw-garages] ^7Released ' .. plate .. ' from the garage')
                            

                            else
                                print('^2[pw-garages] ^7Released ' .. plate .. ' from the impound')
                            end
                            
                            TriggerClientEvent('pw-garages:client:releaseVehicle', src, veh, typ, garage)
                        else
                            TriggerClientEvent('ESX:Notify', src, "Bạn có chắc bạn đủ tiền ?", "error")
                        end
                    else
                        TriggerClientEvent('ESX:Notify', src, "Có lỗi xảy ra. Liên hệ owner với thông tin [CODE " .. veh.id .. "]", "error")
                    end
                else
                    TriggerClientEvent('ESX:Notify', src, "Không thể tìm thấy xe của bạn", "error")
                    cb(false)
                end
            end)
        else
            TriggerClientEvent('ESX:Notify', src, "Bạn không có đủ tiền.", "error")
        end
    else
        exports['ghmattimysql']:execute("SELECT * FROM `owned_vehicles` WHERE `owner` = '" .. xPlayer.getIdentifier() .. "' AND `plate` = '" .. plate .. "' LIMIT 1", function(vehicle)
            local veh = vehicle[1]

            --local modelExists = IsModelExists(veh.model)
			local a = true
            if a then
				
                exports['ghmattimysql']:execute("UPDATE `owned_vehicles` SET `state` = 'unknown', `parking` = '' WHERE `id` = '" .. veh.id .. "'")
                
                serverConfig['houses'][garage]['slots'][json.decode(veh.parking)[1]][2] = true
                serverConfig['houses'][garage]['slots'][json.decode(veh.parking)[1]][3] = nil
                TriggerClientEvent('pw-garages:client:syncConfig', -1, 2, 'houses', garage, 'slots', serverConfig['houses'][garage]['slots'])
                print('^2[pw-garages] ^7Released ' .. plate .. ' from the house garage')
                
                TriggerClientEvent('pw-garages:client:releaseVehicle', src, veh, typ, garage)
            else
                TriggerClientEvent('ESX:Notify', src, "Có lỗi xảy ra. Liên hệ owner với thông tin [CODE " .. veh.id .. "]", "error")
            end
        end)
    end
end)

ESX.RegisterServerCallback('pw-garages:server:getConfig', function(source, cb)
        cb(serverConfig, isAuthorized, 'http://185.249.197.6/files/garagesv0.0.8')

end)

ESX.RegisterServerCallback('pw-garages:server:getOwnedVehicles', function(source, cb, nearbyVehicles, freeSlots, name, keys)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    


    exports['ghmattimysql']:execute("SELECT * FROM `owned_vehicles` WHERE `owner` = '" .. xPlayer.getIdentifier() .. "'", function(vehicles)
        function nospaceButton(plate)
            return "<a id='button' btn-type='nospace' btn-plate='" .. plate .. "' href=\"#\" class=\"btn btn-danger btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-times-circle\"></i></span><span class=\"text\">Hết chỗ</span></a>"
        end

        function payButton(plate)
            return "<a id='button' btn-type='pay' btn-plate='" .. plate .. "' href=\"#\" data-toggle=\"modal\" data-target=\"#payModal\" class=\"btn btn-primary btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-money-check-alt\"></i></span><span class=\"text\">Lấy xe</span></a>"
        end

        function unknownButton(plate)
            return "<a id='button' btn-type='unknown' btn-plate='" .. plate .. "' href=\"#\" class=\"btn btn-danger btn-icon-split\"><span class=\"icon text-white-50\">    <i class=\"fas fa-search\"></i>  </span>  <span class=\"text\">Chưa rõ</span></a>"
        end

        function garageButton(name, plate, typ)
            return "<a id='button' btn-type='" .. typ .. "' btn-plate='" .. plate .. "' btn-name='" .. name .. "' href=\"#\" class=\"btn btn-warning btn-icon-split\">  <span class=\"icon text-white-50\">    <i class=\"fas fa-exclamation-triangle\"></i>  </span>  <span class=\"text\">" .. name .. "</span></a>"
        end
        
        function houseButton(name, plate)
            return "<a id='button' btn-type='house' btn-plate='" .. plate .. "' btn-name='" .. name .. "' href=\"#\" class=\"btn btn-info btn-icon-split\">  <span class=\"icon text-white-50\">    <i class=\"fas fa-warehouse\"></i>  </span>  <span class=\"text\">Nhà số "..name.."</span></a>"
        end
        
        function parkButton(plate)
            return "<a id='button' btn-type='park' btn-plate='" .. plate .. "' href=\"#\" class=\"btn btn-success btn-icon-split\">  <span class=\"icon text-white-50\">    <i class=\"fas fa-charging-station\"></i>  </span>  <span class=\"text\">Đỗ xe</span></a>"
        end


        function renameVehicle(plate)
            return "<a id='button' btn-type='rename' btn-plate='" .. plate .. "' href=\"#\" class=\"btn btn-success btn-icon-split\"><span class=\"icon text-white-50\">    <i class=\"fas fa-edit\"></i>  </span>  <span class=\"text\">Đổi tên</span></a>"
        end
        
        local vehiclesTable = {}

        if vehicles[1] ~= nil and isAuthorized == true then
            for _, vehicle in pairs(vehicles) do
                local stats = json.decode(vehicle.stats)
                local status = vehicle.state
				
                if status == 'unknown' then
					local isNearby = IsNearby(vehicle.plate, nearbyVehicles)
					
                    if isNearby == true then
                        if freeSlots > 0 then
                            table.insert(vehiclesTable, {vehicle.model, vehicle.plate, vehicle.name, stats, parkButton(vehicle.plate) ,renameVehicle(vehicle.plate), 'border-left-success'})
                        else
                            table.insert(vehiclesTable, {vehicle.model, vehicle.plate, vehicle.name, stats, nospaceButton(vehicle.plate) ,renameVehicle(vehicle.plate), 'border-left-danger'})
                        end
                    else
                        table.insert(vehiclesTable, {vehicle.model, vehicle.plate, vehicle.name, stats, unknownButton(vehicle.plate), renameVehicle(vehicle.plate), 'border-left-danger'})
                    end
                elseif status == 'house' then
                    local parking = json.decode(vehicle.parking)
                    if parking[2] == name then
                        table.insert(vehiclesTable, {vehicle.model, vehicle.plate, vehicle.name, stats, payButton(vehicle.plate), renameVehicle(vehicle.plate), 'border-left-info', parking})
                    else
                        table.insert(vehiclesTable, {vehicle.model, vehicle.plate, vehicle.name, stats, houseButton(parking[2], vehicle.plate), renameVehicle(vehicle.plate), 'border-left-info'})
                    end
                elseif status == 'impound' then
                    local parking = json.decode(vehicle.parking)
                    table.insert(vehiclesTable, {vehicle.model, vehicle.plate, vehicle.name, stats, garageButton('Bị giam', vehicle.plate, 'impound'), renameVehicle(vehicle.plate), 'border-left-warning'})
                elseif status == 'garage' then
                    local parking = json.decode(vehicle.parking)
                    if parking[2] == name then
                        local parking = json.decode(vehicle.parking)
                        local time = os.time() - parking[4]
                        parking[4] = math.ceil((time / 60) / 60)
                        if serverConfig['garages'][name]['payment']['onetime'] == true then
                            parking[5] = math.ceil(serverConfig['garages'][name]['payment']['price'] * math.ceil(parking[4]))
                        else
                            parking[5] = serverConfig['garages'][name]['payment']['price']
                        end
                        table.insert(vehiclesTable, {vehicle.model, vehicle.plate, vehicle.name, stats, payButton(vehicle.plate), renameVehicle(vehicle.plate), 'border-left-primary', parking})
                    else
                        table.insert(vehiclesTable, {vehicle.model, vehicle.plate, vehicle.name, stats, garageButton(parking[2], vehicle.plate, 'garage'), renameVehicle(vehicle.plate), 'border-left-danger'})
                    end
                end
            end
        end

        cb(vehiclesTable)
    end)
end)

RegisterServerEvent('pw-garages:renamevehicle')
AddEventHandler('pw-garages:renamevehicle', function(vehicleplate, vehiclename)
    exports['ghmattimysql']:execute("UPDATE owned_vehicles SET name = @name WHERE plate=@plate",{['@name'] = vehiclename , ['@plate'] = vehicleplate})
end)

ESX.RegisterServerCallback('pw-garages:server:getImpoundedVehicles', function(source, cb, name)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    

    exports['ghmattimysql']:execute("SELECT * FROM `owned_vehicles` WHERE `owner` = '" .. xPlayer.getIdentifier() .. "' AND `state` = 'impound'", function(vehicles)
        function payButton(plate)
            return "<a id='button' btn-type='pay' btn-plate='" .. plate .. "' href=\"#\" data-toggle=\"modal\" data-target=\"#payModal\" class=\"btn btn-warning btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-money-check-alt\"></i></span><span class=\"text\">Trả tiền</span></a>"
        end
        
        local vehiclesTable = {}
        if vehicles[1] ~= nil and isAuthorized == true then
            for _, vehicle in pairs(vehicles) do
                table.insert(vehiclesTable, {vehicle.model, vehicle.plate, vehicle.name, payButton(vehicle.plate), serverConfig['impounds'][name]['price']})
            end
        end

        cb(vehiclesTable)
    end)
end)

ESX.RegisterServerCallback('pw-garages:server:isVehicleOwned', function(source, cb, plate)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    

    exports['ghmattimysql']:execute("SELECT * FROM `owned_vehicles` WHERE `owner` = '" .. xPlayer.getIdentifier() .. "' AND `plate` = '" .. plate .. "'", function(result)
        if result[1] ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback('pw-garages:server:hasFines', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    

    exports['ghmattimysql']:execute("SELECT * FROM `billing` WHERE `target` = 'society_police' AND `identifier` = '" .. xPlayer.getIdentifier() .. "'", function(result)
        if result[1] ~= nil and #result > 0 then
            cb(true)
        else
            cb(false)
        end
    end)
end)

-- house garages

--[[ RLCore.Commands.Add("addhousegarage", "BBGarages: Add garage to nearest house", {{name = 'slots', help = 'Slots'}}, true, function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.PlayerData.job.name == GaragesConfig['settings']['housing']['realestate-job'] then
		TriggerClientEvent(GaragesConfig['settings']['housing']['qb-houses:client:addGarage'], source, tonumber(args[1]))
	end
end) ]]

--[[ ESX.RegisterCommand('addhousegarage', 'admin', function(xPlayer, args, showError)
	TriggerClientEvent(GaragesConfig['settings']['housing']['qb-houses:client:addGarage'], source, args.slot)
end, false, {help = "add house garage", validate = false, arguments = {
	{name = 'slot', help = "số slot", type = 'number'}
}}) ]]


--[[ RegisterCommand("addhousegarage", function(source, args)
	local Player = ESX.GetPlayerFromId(source)
    local houseid = args[1]
    local slot = args[2]
	TriggerClientEvent(GaragesConfig['settings']['housing']['qb-houses:client:addGarage'], source, houseid, slot)
end) ]]


ESX.RegisterCommand('addhousegarage', 'admin', function(xPlayer, args)
    TriggerClientEvent(GaragesConfig['settings']['housing']['qb-houses:client:addGarage'], xPlayer.source, args.houseid, args.slot)
end, false, {help = "add thêm garage nhà", validate = true, arguments = {
    {name = 'houseid', help = "số nhà", type = 'number'},
    {name = 'slot', help = "số slot", type = 'number'}
}})

RegisterCommand("setslotshouse", function(source, args)
	local src = source
	TriggerClientEvent('pw-garages:client:coords:UpdateSlotHouse', src)
end)




RegisterCommand("setslot", function(source, args)
	local Player = ESX.GetPlayerFromId(source)
	--local name = args[1]
	TriggerClientEvent('pw-garages:client:GetPlayerCoords', source, 'pw-garages:server:updateHouseSlot', args, true)
end)


RegisterCommand("setslots", function(source, args)
	local src = source
	TriggerClientEvent('pw-garages:client:coords:updateStatus', src)
end)





--[[ ESX.RegisterCommand('setslot', 'admin', function(xPlayer, args, showError)
    TriggerClientEvent(GaragesConfig['settings']['housing']['qb-houses:client:addGarage'], source, args.slot)
    TriggerClientEvent('pw-garages:client:GetPlayerCoords', source, 'pw-garages:server:updateHouseSlot', args.slot, true)
end, false, {help = "set slot nhà", validate = false, arguments = {
	{name = 'slot', help = "số slot", type = 'number'}
}}) ]]


--[[ RLCore.Commands.Add('setslot', 'pw-garages: Set House Garage Slot', {{name = 'index', help = 'Index'}}, true, function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.PlayerData.job.name == GaragesConfig['settings']['housing']['realestate-job'] then
        TriggerClientEvent('pw-garages:client:GetPlayerCoords', source, 'pw-garages:server:updateHouseSlot', args, true)
    end
end) ]]

RegisterServerEvent('pw-garages:server:addHouseGarage')
AddEventHandler('pw-garages:server:addHouseGarage', function(house, coord, max)
    local src = source
    --TriggerClientEvent('ESX:Notify', src, "You have added a garage to " .. house)
    print('add garage to house '..house)

    local houseGarages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'houses.json'))
    if houseGarages[house] == nil then
        
        houseGarages[house] = {
            coords = coord,
            max = max,
            acess = {},
            slots = {}
        }

        local saved = SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'houses.json', json.encode(houseGarages), -1)
        exports['ghmattimysql']:execute("SELECT * FROM `allhousing` WHERE `id` = '" .. house .. "' LIMIT 1", function(housing)
            serverConfig['houses'][house] = {
                coords = coord,
                max = max,
                acess = {},
                slots = {}
            }

            if housing[1] ~= nil then
                local houseData = housing[1]

               
                serverConfig['houses'][house]['acess'] = json.decode(housing.keyholders)
            end

            TriggerClientEvent('pw-garages:client:syncConfig', -1, 3, 'houses', house, serverConfig['houses'][house])
        end)
	end
end)

RegisterNetEvent('pw-garages:server:buyHouseGarage')
AddEventHandler('pw-garages:server:buyHouseGarage', function(house, citizenid, coords, Ownername)
   
    local closestHouse = GetClosestHouse(coords)

    if closestHouse ~= '' then
        local HouseAccess = {
            ['identifier'] = citizenid,
        }

        local houseGarages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'houses.json'))
        if houseGarages[closestHouse] ~= nil then
            houseGarages[closestHouse]['acess'] = HouseAccess
            local saved = SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'houses.json', json.encode(houseGarages), -1)

            serverConfig['houses'][closestHouse]['acess'] = HouseAccess
            TriggerClientEvent('pw-garages:client:syncConfig', -1, 1, serverConfig)
        else
            --TriggerClientEvent('ESX:Notify', src, "Error: Could not find the garage " .. closestGarage .. " on the Database", "error")
            print("Error: Could not find the garage " .. closestHouse .. " on the Database")
        end
    else
        TriggerClientEvent('ESX:Notify', src, "Không tìm được vị trí garage gần nhất.", "error")
    end


end)

RegisterNetEvent('pw-garages:server:buyHouseGarage1')
AddEventHandler('pw-garages:server:buyHouseGarage1', function(house)
    local holders
    exports['ghmattimysql']:execute("SELECT `keyholders` FROM `player_houses` WHERE `id` = '"..house.."'", function(result)
        for k,v in pairs(result) do 
            holders = json.decode(v.keyholders)
        end
        cb(holders)
    end)
    
end) 

ESX.RegisterServerCallback('pw-garages:server:buyHouseGarage1', function(source, cb, house)
    local holders
    exports['ghmattimysql']:execute("SELECT `keyholders` FROM `player_houses` WHERE `id` = '"..house.."'", function(result)
        for k,v in pairs(result) do 
            
            holders = json.decode(v.keyholders)
        end
        cb(holders)
    end)
	
end)

ESX.RegisterServerCallback('pw-garages:server:GetVehicleStatus', function(source, cb, plate)
    local status
    exports['ghmattimysql']:execute("SELECT `stats` FROM `owned_vehicles` WHERE `plate` = '"..plate.."'", function(result)
        for k,v in pairs(result) do 
            status = json.decode(v.stats)
        end
        cb(status)
    end)
	
end)

RegisterNetEvent('pw-garages:server:updateHouseAccess')
AddEventHandler('pw-garages:server:updateHouseAccess', function(data, house)
    local src = source
    
    if serverConfig['houses'][house] ~= nil then
        serverConfig['houses'][house]['acess'] = data
        print('update house access')
        TriggerClientEvent('pw-garages:client:syncConfig', -1, 2, 'houses', house, 'acess', data)
    end
end)

RegisterServerEvent('pw-garages:server:updateHouseSlot')
AddEventHandler('pw-garages:server:updateHouseSlot', function(coords, heading, args, house)
    local src = source  

    if #serverConfig['houses'][house]['slots'] <= serverConfig['houses'][house]['max'] then
        serverConfig['houses'][house]['slots'][tonumber(args[1])] = {{x = coords.x, y = coords.y, z = coords.z, h = heading}, true}

        local houseGarages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'houses.json'))
        houseGarages[house]['slots'] = serverConfig['houses'][house]['slots']
        local saved = SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'houses.json', json.encode(houseGarages), -1)
        TriggerClientEvent('pw-garages:client:syncConfig', -1, 2, 'houses', house, 'slots', serverConfig['houses'][house]['slots'])
        TriggerClientEvent('ESX:Notify', src, "Updated " .. house .. ' garage, slot ' .. args[1] .. '.', "success")
    else
        TriggerClientEvent('ESX:Notify', src, 'You reached the max amount of garage slots, Try replacing old ones.', "error")
    end
end)

-- fakeplates

ESX.RegisterUsableItem('advancedscrewdriver', function(source)
    local src = source
    TriggerClientEvent('pw-garages:client:fakeplate:steal', src)
end)

ESX.RegisterUsableItem('licenseplate', function(source, info)
    local src = source
    TriggerClientEvent('pw-garages:client:fakeplate:usePlate', src, info)
end)

RegisterServerEvent('pw-garages:server:isPlayerVehicle')
AddEventHandler('pw-garages:server:isPlayerVehicle', function(typ, plate, vehicle)
    if typ == 'STEAL' then
        exports['ghmattimysql']:execute("SELECT `model` FROM `owned_vehicles` WHERE `plate` = '" .. plate .. "' LIMIT 1", function(result)
            if result[1] ~= nil then
                exports['ghmattimysql']:execute("UPDATE `owned_vehicles` SET `fakeplate` = '%' WHERE `plate` = '" .. plate .. "' AND `model` = '" .. result[1].model .. "' LIMIT 1")
                networkVehicles[vehicle] = {plate, '%'}
            end
        end)
    elseif typ == 'SET' then
        if networkVehicles[vehicle] ~= nil then
            if networkVehicles[vehicle][1] == plate then
                exports['ghmattimysql']:execute("UPDATE `owned_vehicles` SET `fakeplate` = '' WHERE `plate` = '" .. plate .. "' LIMIT 1")
                networkVehicles[vehicle] = nil
            else
                exports['ghmattimysql']:execute("UPDATE `owned_vehicles` SET `fakeplate` = '" .. plate .. "' WHERE `plate` = '" .. networkVehicles[vehicle][1] .. "' LIMIT 1")
                networkVehicles[vehicle][2] = plate
            end
        end
    end
end)

RegisterServerEvent('pw-garages:server:fakeplate:breakScrewdriver')
AddEventHandler('pw-garages:server:fakeplate:breakScrewdriver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeInventoryItem('advancedscrewdriver', 1)
    TriggerClientEvent('ESX:Notify', src, "Your Advanced Screwdriver went broken", "error")
end)

RegisterServerEvent('pw-garages:server:fakeplate:removeLicensePlate')
AddEventHandler('pw-garages:server:fakeplate:removeLicensePlate', function(slot)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeInventoryItem('licenseplate', 1)
    TriggerClientEvent('ESX:Notify', src, "Success fully installed license plate", "success")
end)

RegisterServerEvent('pw-garages:server:fakeplate:createLicensePlate')
AddEventHandler('pw-garages:server:fakeplate:createLicensePlate', function(plate)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    --xPlayer.Functions.AddItem('licenseplate', 1, nil, {plate = plate})
    xPlayer.addInventoryItem('licenseplate',1)
    TriggerClientEvent('ESX:Notify', src, "You stole a license plate", "success")
end)

-- dev

ESX.RegisterCommand('creategarage', 'admin', function(xPlayer, args)
    TriggerClientEvent('pw-garages:client:GetPlayerCoords', xPlayer.source, 'pw-garages:server:dev:creategarage', args.name)
    --args.name.TriggerClientEvent('pw-garages:client:GetPlayerCoords', xPlayer, 'pw-garages:server:dev:creategarage')
end, true, {help = "tạo thêm garage", validate = true, arguments = {
	{name = 'name', help = "tên", type = 'any'}
}})

--[[ RegisterCommand("creategarage1", function(source, args)
	local Player = ESX.GetPlayerFromId(source)
	local name = args[1]
	TriggerClientEvent('pw-garages:client:GetPlayerCoords', source, 'pw-garages:server:dev:creategarage', name)
end) ]]


--[[ RLCore.Commands.Add('creategarage', 'pw-garages: Create New Garage', {{name = 'name', help = 'Name'}}, true, function(source, args)
    TriggerClientEvent('pw-garages:client:GetPlayerCoords', source, 'pw-garages:server:dev:creategarage', args)
end, GaragesConfig['settings']['dev']['rank']) ]]

ESX.RegisterCommand('setinteract', 'admin', function(xPlayer, args, showError)
	TriggerClientEvent('pw-garages:client:GetPlayerCoords', xPlayer.source, 'pw-garages:server:dev:setinteract', args.enable)
end, false, {help = "pw-garages: Set Closest Garage Interact Location", validate = false, arguments = {
	{name = 'enable', help = "Bật mở 0/1", type = 'number'}
}})


ESX.RegisterCommand('setpayment', 'admin', function(xPlayer, args)
    local onetime = tonumber(args.onetime) ~= nil and tonumber(args.onetime) == 1 and true or false
	TriggerClientEvent('pw-garages:client:GetPlayerCoords', xPlayer.source, 'pw-garages:server:dev:setpayment', {args.price, onetime})
end, true, {help = 'pw-garages: Set the payment for the closest garage', validate = false, arguments = {
	{name = 'price', help = 'Giá [Theo giờ/Một l]', type = 'number'},
	{name = 'onetime', help = 'Trả một lần? 0 = không, 1 = có [0/1] ', type = 'number'}
}})

--[[ RLCore.Commands.Add('setinteract', 'pw-garages: Set Closest Garage Interact Location', {{name = 'enable', help = 'Enable Ped? [0/1]'}}, true, function(source, args)
    TriggerClientEvent('pw-garages:client:GetPlayerCoords', source, 'pw-garages:server:dev:setinteract', args)
end, GaragesConfig['settings']['dev']['rank']) ]]

--[[ RLCore.Commands.Add('setpayment', 'pw-garages: Set the payment for the closest garage', {{name = 'price', help = 'Price [Perhour/Onetime]'}, {name = 'onetime', help = 'Onetime? [0/1]'} }, true, function(source, args)
    local price = args[1]
    local perhour = tonumber(args[2]) ~= nil and tonumber(args[2]) == 1 and true or false
    TriggerClientEvent('pw-garages:client:GetPlayerCoords', source, 'pw-garages:server:dev:setpayment', {price, perhour})
end, GaragesConfig['settings']['dev']['rank']) ]]


--[[ ESX.RegisterCommand('setslots', 'admin', function(xPlayer, args, showError)
	local src = source
	TriggerClientEvent('pw-garages:client:coords:updateStatus', src)
end, false, {help = "pw-garages: Toggle pw-garages Slots Editor"}) ]]

--[[ RLCore.Commands.Add('setslots', 'pw-garages: Toggle pw-garages Slots Editor', {}, false, function(source, args)
	local src = source
	TriggerClientEvent('pw-garages:client:coords:updateStatus', src)
end, GaragesConfig['settings']['dev']['rank']) ]]

RegisterServerEvent('pw-garages:server:dev:creategarage')
AddEventHandler('pw-garages:server:dev:creategarage', function(coords, heading, args)
    local src = source
    local name = args
    if serverConfig['garages'][name] == nil then
        local newgarage = {}
        newgarage['blip'] = {
            ['enable'] = true,
            ['coords'] = coords,
            ['type'] = 'garage',
        }

        
        newgarage['slots'] = {}
        newgarage['payment'] = { ['price'] = 36, ['onetime'] = false}

        local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json'))
        
        garages[name] = newgarage
        local saved = SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json', json.encode(garages), -1)

        serverConfig['garages'][name] = newgarage
        TriggerClientEvent('ESX:Notify', src, "Created new garage! [" .. name .. "]", "success")
        TriggerClientEvent('pw-garages:client:syncConfig', -1, 1, serverConfig)
    else
        TriggerClientEvent('ESX:Notify', src, "A Garage with the same name already exists", "error")
    end
end)

RegisterServerEvent('pw-garages:server:dev:setinteract')
AddEventHandler('pw-garages:server:dev:setinteract', function(coords, heading, args)
    local src = source
    local enablePed = tonumber(args) ~= nil and tonumber(args) == 1 and true or false

    local closestGarage = GetClosestGarage(coords)
    if closestGarage ~= '' then
        local garagePed = {
            ['coords'] = coords,
            ['created'] = false,
            ['heading'] = heading,
            ['type'] = -567724045,
            ['enable'] = enablePed,
        }

        local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json'))
        if garages[closestGarage] ~= nil then
            garages[closestGarage]['ped'] = garagePed
            local saved = SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json', json.encode(garages), -1)

            serverConfig['garages'][closestGarage]['ped'] = garagePed
            TriggerClientEvent('ESX:Notify', src, "Updated " .. closestGarage .. " interact location.", "success")
            TriggerClientEvent('pw-garages:client:syncConfig', -1, 1, serverConfig)
            print('Updated interact location'.. closestGarage)
        else
            TriggerClientEvent('ESX:Notify', src, "Error: Could not find the garage " .. closestGarage .. " on the Database", "error")
        end
    else
        TriggerClientEvent('ESX:Notify', src, "Error: Could not find closest garage.", "error")
    end
end)

RegisterServerEvent('pw-garages:server:dev:setpayment')
AddEventHandler('pw-garages:server:dev:setpayment', function(coords, heading, args)
    local src = source
    local price = tonumber(args[1])
    local perhour = args[2]

    local closestGarage = GetClosestGarage(coords)
    if closestGarage ~= '' then
        local garagePayment = {
            ['price'] = price,
            ['onetime'] = perhour,
        }

        local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json'))
        if garages[closestGarage] ~= nil then
            garages[closestGarage]['payment'] = garagePayment
            local saved = SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json', json.encode(garages), -1)

            serverConfig['garages'][closestGarage]['payment'] = garagePayment
            TriggerClientEvent('ESX:Notify', src, "Updated " .. closestGarage .. " payment information.", "success")
            TriggerClientEvent('pw-garages:client:syncConfig', -1, 1, serverConfig)
        else
            TriggerClientEvent('ESX:Notify', src, "Error: Could not find the garage " .. closestGarage .. " on the Database", "error")
        end
    else
        TriggerClientEvent('ESX:Notify', src, "Error: Could not find closest garage.", "error")
    end
end)

    
RegisterServerEvent('pw-garages:server:dev:saveCoords')
AddEventHandler('pw-garages:server:dev:saveCoords', function(name, index)
    local src = source

    local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json'))
    if garages[name] ~= nil then
        local slots = garages[name]['slots']
        local newslots = {}
        for k, v in pairs(slots) do
            newslots[#newslots+1] = {{
                x = v[1].x,
                y = v[1].y,
                z = v[1].z,
                h = v[1].h,
            }, true}
        end

        for k, v in pairs(index) do
            newslots[#newslots+1] = {{
                x = v[1].x,
                y = v[1].y,
                z = v[1].z,
                h = v[2],
            }, true}

            serverConfig['garages'][name]['slots'][k] = {{
                x = v[1].x,
                y = v[1].y,
                z = v[1].z,
                h = v[2],
            }, true}
        end

        garages[name]['slotsbackup'] = garages[name]['slots']
        garages[name]['slots'] = newslots
        SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json', json.encode(garages), -1)
        TriggerClientEvent('pw-garages:client:syncConfig', -1, 1, serverConfig)
    end
end)

RegisterServerEvent('pw-garages:server:dev:saveCoordsHouse')
AddEventHandler('pw-garages:server:dev:saveCoordsHouse', function(name, index)
    local src = source
    local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'houses.json'))
    if garages[name] ~= nil then
        local slots = garages[name]['slots']
        local newslots = {}
        for k, v in pairs(slots) do
            newslots[#newslots+1] = {{
                x = v[1].x,
                y = v[1].y,
                z = v[1].z,
                h = v[1].h,
            }, true}
        end

        for k, v in pairs(index) do
            newslots[#newslots+1] = {{
                x = v[1].x,
                y = v[1].y,
                z = v[1].z,
                h = v[2],
            }, true}

            serverConfig['houses'][name]['slots'][k] = {{
                x = v[1].x,
                y = v[1].y,
                z = v[1].z,
                h = v[2],
            }, true}
        end

        --garages[name]['slotsbackup'] = garages[name]['slots']
        garages[name]['slots'] = newslots
        SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'houses.json', json.encode(garages), -1)
        TriggerClientEvent('pw-garages:client:syncConfig', -1, 1, serverConfig)
    end
end)

function IsModelExists(model)
    for key, value in pairs(RLCore.Shared.Vehicles) do
        if value['model'] == model then
            return true
        end
    end
    return false
end

function GetClosestGarage(coords)
    local closestName, closestDst = '', 99999.9
    for k, v in pairs(serverConfig['garages']) do
        local dst = #(vector3(v['blip']['coords'].x, v['blip']['coords'].y, v['blip']['coords'].z) - coords)
        if dst < closestDst then
            closestDst = dst
            closestName = k
        end
    end
    return closestName
end

function GetClosestHouse(coords)
    local closestName, closestDst = '', 99999.9
    for k, v in pairs(serverConfig['houses']) do
        local dst = #(vector4(v['coords'].x, v['coords'].y, v['coords'].z, v['coords'].h) - coords)
        if dst < closestDst then
            closestDst = dst
            closestName = k
        end
    end
    return closestName
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function stringsplit(Input, Seperator)
	if Seperator == nil then
		Seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(Input, '([^'..Seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

-- functions
function IsNearby(plate, vehicles)
    for _, vehicle in pairs(vehicles) do
        if plate == vehicle then
            return true
        end
    end
    return false
end

function escape_sqli(source)
    local replacements = { ['"'] = '\\"', ["'"] = "\\'" }
    return source:gsub( "['\"]", replacements ) -- or string.gsub( source, "['\"]", replacements )
end

function randString(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end

--function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end