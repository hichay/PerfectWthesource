ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('rl-weed:server:getBuildingPlants', function(source, cb, building)
    local buildingPlants = {}

    exports['ghmattimysql']:execute('SELECT * FROM house_plants WHERE building = @building', {['@building'] = building}, function(plants)
        for i = 1, #plants, 1 do
            table.insert(buildingPlants, plants[i])
        end

        if buildingPlants ~= nil then
            cb(buildingPlants)
        else    
            cb(nil)
        end
    end)
end)

-- RegisterCommand('plant', function(source, args)
    -- local _source = source
	-- local type = args[1]
	-- TriggerClientEvent('rl-weed:client:placePlant', source, type)
-- end)



RegisterServerEvent('rl-weed:server:placePlant')
AddEventHandler('rl-weed:server:placePlant', function(currentHouse, coords, sort)
    local random = math.random(1, 2)
    local gender
    if random == 1 then gender = "man" else gender = "woman" end

    exports['ghmattimysql']:execute("INSERT INTO `house_plants` (`building`, `coords`, `gender`, `sort`, `plantid`) VALUES ('"..currentHouse.."', '"..coords.."', '"..gender.."', '"..sort.."', '"..math.random(1,999999).."')")
    TriggerClientEvent('rl-weed:client:refreshHousePlants', -1, currentHouse)
end)

RegisterServerEvent('rl-weed:server:removeDeathPlant')
AddEventHandler('rl-weed:server:removeDeathPlant', function(building, plantId)
    exports['ghmattimysql']:execute("DELETE FROM `house_plants` WHERE plantid = '"..plantId.."' AND building = '"..building.."'")
    TriggerClientEvent('rl-weed:client:refreshHousePlants', -1, building)
end)

Citizen.CreateThread(function()
    while true do
        exports['ghmattimysql']:execute( "SELECT * FROM `house_plants`", function(housePlants)
            for k, v in pairs(housePlants) do
                if housePlants[k].food >= 50 then
                    exports['ghmattimysql']:execute("UPDATE `house_plants` SET `food` = '"..(housePlants[k].food - 1).."' WHERE `plantid` = '"..housePlants[k].plantid.."'")
                    if housePlants[k].health + 1 < 100 then
                        exports['ghmattimysql']:execute("UPDATE `house_plants` SET `health` = '"..(housePlants[k].health + 1).."' WHERE `plantid` = '"..housePlants[k].plantid.."'")
                    end
                end

                if housePlants[k].food < 50 then
                    if housePlants[k].food - 1 >= 0 then
                        exports['ghmattimysql']:execute("UPDATE `house_plants` SET `food` = '"..(housePlants[k].food - 1).."' WHERE `plantid` = '"..housePlants[k].plantid.."'")
                    end
                    if housePlants[k].health - 1 >= 0 then
                        exports['ghmattimysql']:execute("UPDATE `house_plants` SET `health` = '"..(housePlants[k].health - 1).."' WHERE `plantid` = '"..housePlants[k].plantid.."'")
                    end
                end
            end

            TriggerClientEvent('rl-weed:client:refreshPlantStats', -1)
        end)

        Citizen.Wait((60 * 1000) * 19.2)
    end
end)

Citizen.CreateThread(function()
    while true do
        exports['ghmattimysql']:execute( "SELECT * FROM `house_plants`", function(housePlants)
            for k, v in pairs(housePlants) do
                if housePlants[k].health > 50 then
                    local Grow = math.random(1, 3)
                    if housePlants[k].progress + Grow < 100 then
                        exports['ghmattimysql']:execute("UPDATE `house_plants` SET `progress` = '"..(housePlants[k].progress + 1).."' WHERE `plantid` = '"..housePlants[k].plantid.."'")
                    elseif housePlants[k].progress + Grow >= 100 then
                        if housePlants[k].stage ~= PwWeed.Plants[housePlants[k].sort]["highestStage"] then
                            if housePlants[k].stage == "stage-a" then
                                exports['ghmattimysql']:execute("UPDATE `house_plants` SET `stage` = 'stage-b' WHERE `plantid` = '"..housePlants[k].plantid.."'")
                            elseif housePlants[k].stage == "stage-b" then
                                exports['ghmattimysql']:execute("UPDATE `house_plants` SET `stage` = 'stage-c' WHERE `plantid` = '"..housePlants[k].plantid.."'")
                            elseif housePlants[k].stage == "stage-c" then
                                exports['ghmattimysql']:execute("UPDATE `house_plants` SET `stage` = 'stage-d' WHERE `plantid` = '"..housePlants[k].plantid.."'")
                            elseif housePlants[k].stage == "stage-d" then
                                exports['ghmattimysql']:execute("UPDATE `house_plants` SET `stage` = 'stage-e' WHERE `plantid` = '"..housePlants[k].plantid.."'")
                            elseif housePlants[k].stage == "stage-e" then
                                exports['ghmattimysql']:execute("UPDATE `house_plants` SET `stage` = 'stage-f' WHERE `plantid` = '"..housePlants[k].plantid.."'")
                            elseif housePlants[k].stage == "stage-f" then
                                exports['ghmattimysql']:execute("UPDATE `house_plants` SET `stage` = 'stage-g' WHERE `plantid` = '"..housePlants[k].plantid.."'")
                            end
                            exports['ghmattimysql']:execute("UPDATE `house_plants` SET `progress` = '0' WHERE `plantid` = '"..housePlants[k].plantid.."'")
                        end
                    end
                end
            end

            TriggerClientEvent('rl-weed:client:refreshPlantStats', -1)
        end)

        Citizen.Wait((60 * 1000) * 9.6)
    end
end)

ESX.RegisterUsableItem("whiteseed", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent('rl-weed:client:placePlant', source, 'white-widow', item)
end)

ESX.RegisterUsableItem("dsddsf", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent('rl-weed:client:placePlant', source, 'skunk', item)
end)

ESX.RegisterUsableItem("weed_purple-haze_seed", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent('rl-weed:client:placePlant', source, 'purple-haze', item)
end)

ESX.RegisterUsableItem("kushseed", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent('rl-weed:client:placePlant', source, 'og-kush', item)
end)

ESX.RegisterUsableItem("weed_amnesia_seed", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent('rl-weed:client:placePlant', source, 'amnesia', item)
end)

ESX.RegisterUsableItem("weed_ak47_seed", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent('rl-weed:client:placePlant', source, 'ak47', item)
end)

ESX.RegisterUsableItem("fertilizer", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent('rl-weed:client:foodPlant', source, item)
end)

RegisterServerEvent('rl-weed:server:removeSeed')
AddEventHandler('rl-weed:server:removeSeed', function(itemslot, seed)
    local Player = ESX.GetPlayerFromId(source)
    Player.Functions.RemoveItem(seed, 1, itemslot)
end)

RegisterServerEvent('rl-weed:server:harvestPlant')
AddEventHandler('rl-weed:server:harvestPlant', function(house, amount, plantName, plantId)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local weedBag = Player.Functions.GetItemByName('empty_weed_bag')
	local sndAmount = math.random(9, 18)

    --if weedBag ~= nil then
        -- if weedBag.amount >= sndAmount then
		if true then
            if house ~= nil then 
                exports['ghmattimysql']:execute( "SELECT * FROM `house_plants` WHERE plantid = '"..plantId.."' AND building = '"..house.."'", function(result)
                    if result[1] ~= nil then
                        --Player.Functions.AddItem('weed4g', 4)
                        --Player.Functions.AddItem('weed_'..plantName, sndAmount)
						
						TriggerEvent("player:receiveItem",source,"weedq",sndAmount,true,true,"Hàng tự trồng")
                        --Player.Functions.RemoveItem('empty_weed_bag', sndAmount)
                        exports['ghmattimysql']:execute("DELETE FROM `house_plants` WHERE plantid = '"..plantId.."' AND building = '"..house.."'")
						TriggerEvent("DoLongHudText","Cây đã được thu hoạch",1)
                        TriggerClientEvent('rl-weed:client:refreshHousePlants', -1, house)
                    else
                        
						TriggerEvent("DoLongHudText","This plant no longer exists?")
                    end
                end)
            else               
				TriggerEvent("DoLongHudText","House not found")
            end
        else
			TriggerEvent("DoLongHudText","You don\'t have enough resealable bags")
        end
   -- else
		--TriggerEvent("DoLongHudText","You do not have resealable bags")
   -- end
end)

RegisterServerEvent('rl-weed:server:foodPlant')
AddEventHandler('rl-weed:server:foodPlant', function(house, amount, plantName, plantId)
    local src = source
    local Player = ESX.GetPlayerFromId(src)

    exports['ghmattimysql']:execute( 'SELECT * FROM `house_plants` WHERE `building` = "'..house..'" AND `sort` = "'..plantName..'" AND `plantid` = "'..tostring(plantId)..'"', function(plantStats)
        TriggerClientEvent('RLCore:Notify', src, PwWeed.Plants[plantName]["label"]..' | Nutrition: '..plantStats[1].food..'% + '..amount..'% ('..(plantStats[1].food + amount)..'%)', 'success', 3500)
        if plantStats[1].food + amount > 100 then
            exports['ghmattimysql']:execute("UPDATE `house_plants` SET `food` = '100' WHERE `building` = '"..house.."' AND `plantid` = '"..plantId.."'")
        else
            exports['ghmattimysql']:execute("UPDATE `house_plants` SET `food` = '"..(plantStats[1].food + amount).."' WHERE `building` = '"..house.."' AND `plantid` = '"..plantId.."'")
        end
        Player.Functions.RemoveItem('weed_nutrition', 1)
        TriggerClientEvent('rl-weed:client:refreshHousePlants', -1, house)
    end)
end)