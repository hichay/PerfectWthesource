Citizen.CreateThread(function() 
    if(Config.UseCommand)then
        RegisterCommand(Config.CommandName, function(source, args, rawCommand)
            if(args[1] ~= nil)then
                TriggerEvent("cameraSystem:server:OpenCamera", source, tonumber(args[1]))
            else
                --Notification(source, "no_arguments")
            end
        end, false)
    end
end)

RegisterServerEvent("cameraSystem:server:OpenCamera")
AddEventHandler("cameraSystem:server:OpenCamera", function(source, id)
    if(Config.UsingJobs)then
        if(CheckJob(source))then
            TriggerClientEvent("cameraSystem:client:OpenCamera", source, id)
        else
            Notification(source, "no_job")
        end
    else
        TriggerClientEvent("cameraSystem:client:OpenCamera", source, id)
    end
end)

RegisterServerEvent("cameraSystem:server:updateState")
AddEventHandler("cameraSystem:server:updateState", function(key, state)
    TriggerClientEvent("cameraSystem:client:updateState", -1, key, state)
end)

RegisterServerEvent("cameraSystem:server:notification")
AddEventHandler("cameraSystem:server:notification", function(source, type)
    Notification(source, type)
end)

RegisterServerEvent('cameraSystem:hackfail')
AddEventHandler('cameraSystem:hackfail', function(data, customcoords)
    if customcoords ~= nil then data.coords = customcoords end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job = 'police', 
        coords = data.coords,
        title = 'Phá hệ thống camera',
        message = 'Một người '..data.sex..' đang phá hoại hệ thống camera cửa hàng tại '..data.street_1..', '..data.street_2, 
        flash = 0, 
        blip = {
            sprite = 769, 
            scale = 1.0, 
            colour = 1,
            flashes = true, 
            text = 'Phá camera',
            time = (2*60*1000),
            sound = 1,
        }
    })
end)