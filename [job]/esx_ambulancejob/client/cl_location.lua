local listening = false
local currentPrompt = nil

local EVENTS = {
    LOCKERS = 1,
    CLOTHING = 2,
    ARMORY = 3,
}


local zoneData = {
    pillboxhos_clothing_lockers = {
        promptText = "[E] Tủ quần áo & Tủ Đồ",
        menuData = {
            {
				icon = 'box-open',
                title = "Tủ cá nhân",
                description = "",
                action = "pw-ambulance:handler",
                key = EVENTS.LOCKERS
            },
            {
				icon = 'shirt',
                title = "Chỉnh quần áo",
                description = "",
                action = "pw-ambulance:handler",
                key = EVENTS.CLOTHING
            },
			{
				icon = 'shirt',
                title = "Tủ đồ",
                description = "",
                action = "pw-ambulance:handler",
                key = EVENTS.OUTFIT
            },
        }
    },
    pillboxhos_armory = {
        promptText = "[E] Kho trang bị"
    },
    pillboxhos_bossaction = {
        promptText = "[E] để mở bossmenu"
    },
    

}


local function listenForKeypress(pZone, pAction)
    listening = true

    Citizen.CreateThread(function()
        while listening do
            if IsControlJustReleased(0, 38) then
                if pAction == "context" then
                    exports["pw-context"]:showContextMenu(zoneData[pZone].menuData)
                elseif pAction == "armory"  then
                    TriggerEvent("server-inventory-open", "10", "Shop")
                elseif pAction == "bossmenu"  then
                    TriggerServerEvent("pw-bossmenu:server:openMenu")
                end
            end

            Citizen.Wait(1)
        end
    end)
end


AddEventHandler("pw-polyzone:enter", function(pZoneName, pZoneData)
    if pZoneName == "pw-ambulance:zone" then
        if ESX.GetPlayerData().job.name == pZoneData.job then
            currentPrompt = pZoneData.zone
            exports["pw-interaction"]:showInteraction(zoneData[pZoneData.zone].promptText)
            listenForKeypress(pZoneData.zone, pZoneData.action)
        end
    elseif pZoneName == 'pw-ambulance:bossaction' then 
        if ESX.GetPlayerData().job.name == pZoneData.job and ESX.GetPlayerData().job.grade >= 10 then
            currentPrompt = pZoneData.zone
            exports["pw-interaction"]:showInteraction(zoneData[pZoneData.zone].promptText)
            listenForKeypress(pZoneData.zone, pZoneData.action)
        end
    end
end)

AddEventHandler("pw-polyzone:exit", function(pZoneName, pZoneData)
    if pZoneName == "pw-ambulance:zone" then
        exports["pw-interaction"]:hideInteraction()
        listening = false
        currentPrompt = nil
    end
end)

 
AddEventHandler("pw-ambulance:handler", function(eventData)
    local job = ESX.GetPlayerData().job.name

    local location = currentPrompt ~= nil and string.match(currentPrompt, "(.-)_") or ""

    if eventData == EVENTS.LOCKERS and job == 'ambulance' then
        local cid = ESX.GetPlayerData().id
        TriggerEvent("server-inventory-open", "1", ("personalStorage-%s-%s"):format(location, cid))
        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3.0, "LockerOpen", 0.4)
    elseif eventData == EVENTS.CLOTHING then
        exports["pw-interaction"]:hideInteraction()
        Wait(500)
        TriggerEvent("raid_clothes:openClothing", true, false)
	elseif eventData == EVENTS.OUTFIT then
        exports["pw-interaction"]:hideInteraction()
        Wait(500)
        TriggerServerEvent("raid_clothes:list_outfits")	
    elseif eventData == EVENTS.ARMORY and ESX.GetPlayerData().job.name == 'police' then
        TriggerEvent("server-inventory-open", "10", "Shop")    
    end
end)




Citizen.CreateThread(function()

    -- pillnox Lockers
    exports["pw-polyzone"]:AddBoxZone("pw-ambulance:zone", vector3(300.2156, -598.6964, 43.284069), 4.4, 4.8, {
        heading = 0,
        minZ = 42.64,
        maxZ = 43.84,
        data = {
            job = "ambulance",
            action = "context",
            zone = "pillboxhos_clothing_lockers",
        },
    })

    -- pillnox Armory
    exports["pw-polyzone"]:AddBoxZone("pw-ambulance:zone", vector3(309.78085, -567.8145, 43.284088), 3.2, 4.8, {
        heading = 90,
        minZ = 42.69,
        maxZ = 43.49,
        data = {
            job = "ambulance",
            action = "armory",
            zone = "pillboxhos_armory",
        },
    })

    -- MRPD BossRoom
    exports["pw-polyzone"]:AddBoxZone("pw-ambulance:bossaction", vector3(334.95559, -594.0388, 43.284057), 3.2, 4.8, {
        heading = 90,
        minZ = 42.69,
        maxZ = 43.49,
        data = {
            job = "ambulance",
            action = "bossmenu",
            zone = "pillboxhos_bossaction",
        },
    })


end)