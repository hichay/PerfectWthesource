Citizen.CreateThread(function()
    if(Config.UsingESX)then
        ESX = nil
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

function Notification(type) --Notifications go here. I AM NOT ENTIRELY SURE IF THIS WORKS AS I DIDN'T TEST IT. If you have issues with this message me.

    if(type =="no_arguments")then
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Please fill out the arguments, example: /" .. Config.CommandName .. " <id>")
    elseif(type == "no_job")then
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is only available for emergency services!")
    elseif(type == "no_camera")then
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Camera not found.")
    end
end

function CheckJob(source) --Checks the job. If your using esx don't change anything.
        if(Config.UsingESX)then
            for k, v in pairs(Config.WhitelistedJobs) do

                local Player = ESX.GetPlayerFromId(source)

                if Player.job.name == v then
                    return true
                end

            end

            return false
        else
            for k, v in pairs(Config.WhitelistedJobs) do
                --DO YOUR CHECK HERE. IF IT FINDS THE JOB IT NEEDS TO RETURN TRUE. CHECK THE ESX CODE ABOVE.
            end

            return false
        end

end