ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
    addBlips()
end)

local MenuData = {
    mini_market = {
        text = "Để mở cửa hàng"
    },
    weapon_shop = {
        text = "Để mở cửa hàng"
    },
	hunting_shop = {
        text = "Để mở cửa hàng"
    }
}

local showMinimarketBlips = false
local showWeaponshopBlips = false
local showHuntingstoreBlips = false
local showToolshopBlips = false
local listening = false


RegisterNetEvent('blips:ToggleToolShop')
AddEventHandler('blips:ToggleToolShop', function()
   showToolshopBlips = not showToolshopBlips
   for _, item in pairs(toolshop) do
        if not showToolshopBlips then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[2])
			SetBlipSprite(item.blip, 566)
			SetBlipScale(item.blip, 0.7)
			SetBlipColour(item.blip, 10)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("CUSTOM_TEXT")
            AddTextComponentString("Cửa hàng dụng cụ")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)	
	
RegisterNetEvent('blips:ToggleWeaponShop')
AddEventHandler('blips:ToggleWeaponShop', function()
   showWeaponshopBlips = not showWeaponshopBlips
   for _, item in pairs(weaponshop) do
        if not showWeaponshopBlips then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[2])
            SetBlipSprite(item.blip, 71)
            SetBlipColour(item.blip, 1)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("CUSTOM_TEXT")
            AddTextComponentString("Cửa hàng súng")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)

RegisterNetEvent('blips:ToggleHuntingStore')
AddEventHandler('blips:ToggleHuntingStore', function()
   showHuntingstoreBlips = not showHuntingstoreBlips
   for _, item in pairs(huntingshop) do
        if not showHuntingstoreBlips then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[2])
            SetBlipSprite(item.blip, 463)
            SetBlipColour(item.blip, 48)
			SetBlipScale(item.blip, 1.0)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("CUSTOM_TEXT")
            AddTextComponentString("Cửa hàng thợ săn")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)

RegisterNetEvent('blips:ToggleMinimarket')
AddEventHandler('blips:ToggleMinimarket', function()
   showMinimarketBlips = not showMinimarketBlips
   for _, item in pairs(shop247) do
        if not showMinimarketBlips then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[2])
            SetBlipSprite(item.blip, 52)
            SetBlipColour(item.blip, 2)
			SetBlipScale(item.blip, 0.7)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("CUSTOM_STRING")
            AddTextComponentString("Cửa hàng tạp hoá")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)

AddEventHandler("pw-polyzone:enter", function(zone, data)
    local currentZone = MenuData[zone]
    if currentZone then
        exports["np-ui"]:showInteraction(("[E] %s"):format(currentZone.text))
        listenForKeypress(zone)
    end
end)

AddEventHandler("pw-polyzone:exit", function(zone)
    local currentZone = MenuData[zone]
    if currentZone then
        listening = false
        exports["np-ui"]:hideInteraction()
    end
end)

function listenForKeypress(zoneName)
    listening = true
    Citizen.CreateThread(function()

        while listening do
            if IsControlJustReleased(0, 38) then
                if zoneName == "mini_market" then
                    TriggerEvent("server-inventory-open", "2", "Shop");	
				elseif zoneName == "weapon_shop" then
					TriggerEvent("server-inventory-open", "5", "Shop");
				--[[ elseif zoneName == "hunting_shop" then
					TriggerEvent("server-inventory-open", "12", "Shop"); ]]
				--[[ elseif zoneName == "tool_shop" then
					TriggerEvent("server-inventory-open", "12", "Shop"); ]]
                end
                

                exports["np-ui"]:hideInteraction()
            end
            Wait(0)
        end
    end)
end

function addBlips()
    --showMinimarketBlips = true
    --showHuntingstoreBlips = true
    --showToolshopBlips = true    

    TriggerEvent('blips:ToggleMinimarket')

    TriggerEvent('blips:ToggleHuntingStore')
    TriggerEvent('blips:ToggleToolShop')
    
end
