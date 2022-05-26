
function showContextMenu(data)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data,
    })
end


exports("showContextMenu", showContextMenu)

RegisterNetEvent("pw-context:showContextMenu")
AddEventHandler("pw-context:showContextMenu", showContextMenu)

RegisterNetEvent("pw-context:preLoadImages")
AddEventHandler("pw-context:preLoadImages", function(images)
    SendNUIMessage({
        action = "LOAD_IMAGES",
        data = images,
    })
end)

RegisterNUICallback("dataPost", function(data, cb)
    SetNuiFocus(false)
    TriggerEvent(data.action, data.key)
    cb("ok")
end)

RegisterNUICallback("cancel", function(data, cb)
    SetNuiFocus(false)
    cb("ok")
    Wait(800)
    TriggerEvent("attachedItems:block", false)
end)