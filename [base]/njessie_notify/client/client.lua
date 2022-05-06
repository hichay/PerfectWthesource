

function SendNotification(options)

    local options = {
        type = options.type or "notify",
        message = options.message or "Empty message",
        title = options.title or ""
    }

    SendNUIMessage({type = options.type, message = options.message, title = options.title})
end

RegisterNetEvent("pNotify:SendNotification")
AddEventHandler("pNotify:SendNotification", function(options)
    new_options = {
        type = "notify1",
        message = options.text
    }
    SendNotification(new_options)
end)

RegisterNetEvent("njessieNotify:SendNotification")
AddEventHandler("njessieNotify:SendNotification", function(options)
    options.type = "notify"
    SendNotification(options)
end)

RegisterNetEvent("njessieNotify:ShowHelperUIText")
AddEventHandler("njessieNotify:ShowHelperUIText", function(options)
    options.type = "helper"
    SendNotification(options)
end)

-- Inventory
RegisterNetEvent("njessieNotify:SendNotificationInventory")
AddEventHandler("njessieNotify:SendNotificationInventory", function(options)
    SendNotificationInventory(options)
    local options = {
        type = options.type or "inventory",
        add = options.add or "",
        item = options.item or "",
        count = options.count or 0
    }

    SendNUIMessage({type = options.type, add = options.add, item = options.item, count = options.count})
end)
