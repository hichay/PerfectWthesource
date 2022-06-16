
ESX = nil 
    local item_name = {}
    Citizen.CreateThread(function() 
        while ESX == nil do 
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
            Citizen.Wait(0) 
        end 
        -- local inv = ESX.GetPlayerData().inventory
        -- for k, v in pairs(inv) do 
            -- item_name[v.name] = v.label
        -- end 
    end)

function GetChance(tier) 
    return Config["chance"][tier].rate 
end

function GetColor(tier) 
    return Config["chance"][tier].color 
end 

RegisterNUICallback('Close', function(data, cb) 
    SetNuiFocus(false, false) 
end)

RegisterNetEvent("mon_lootbox:StartWheel") 
AddEventHandler("mon_lootbox:StartWheel", function(gacha, won) 
	--[[ local inv = ESX.GetPlayerData().inventory
        for k, v in pairs(inv) do 
            item_name[v.name] = v.label
        end  ]]
    --TriggerEvent('esx_inventoryhud:closeHud') 
    local data = Config["lootbox"][gacha] 
    local wheel = {}
    for k, v in pairs(data.list) do 
    local name = "Unknown"
    local image = "unknown"
    if v.name then 
        name = v.name 
        image = v.item or v.money and "cash" or v.vehicle 
    elseif v.item then 
        name = item_name[v.item] or "Unknown" image = v.item 
    elseif v.money then 
        name = "$"..string.Comma(v.money) or "Unknown" image = "cash"
    elseif v.vehicle then 
        name = v.vehicle or "Unknown" image = v.vehicle 
    end 
    table.insert(wheel, {name = name, image = image, 
    chance = GetChance(v.tier), 
    color = GetColor(v.tier), 
    type = v.item and "item" 
    or v.money and "money"
    or v.vehicle and "vehicle"
    or "unknown"
    }) 
end 

SendNUIMessage({action = 'start', wheel = wheel, target = won, duration = Config["wheel_duration"] and Config["wheel_duration"] * 1000
    }) 
    SetNuiFocus(true, true) 
end)

function string.Comma(number) 
    if tonumber(number) then 
        number = string.format("%f", number) 
        number = string.match(number, "^(.-)%.?0*$") 
    end 
    local k
    while true do 
        number, k = string.gsub(number, "^(-?%d+)(%d%d%d)", "%1,%2") if (k == 0) then
            break
        end
    end
    return number 
end 
