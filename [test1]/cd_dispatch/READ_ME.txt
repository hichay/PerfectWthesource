EXAMPLE OF TRIGGERING AN POLICE ALERT

STEP 1 - FROM CLIENT TO SERVER
TriggerServerEvent('testevent', exports['cd_dispatch']:GetPlayerInfo())
TriggerServerEvent('testevent', exports['cd_dispatch']:GetPlayerInfo(), vector3(0,0,0)) --if you want to send a set location instead of the players location you can add them here.

THE EXPORT RETURNS THIS TABLE. (if you are not in a vehicle it will not return any vehicle data).
return {
        ped = ped,
        coords = coords,
        street_1 = streetnames.street1,
        street_2 = streetnames.street2,
        sex = sex,
        vehicle = vehicle,
        vehicle_label = vehicle_label,
        vehicle_colour = vehicle_colour
}

STEP 2 - FROM SERVER TO CLIENT

RegisterServerEvent('testevent')
AddEventHandler('testevent', function(table, customcoords)
    if customcoords ~= nil then
        table.coords = customcoords
    end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job = 'police', --everyone who has this job will recieve this notification.
        coords = table.coords,
        title = '10-15 - Store Robbery',
        message = 'A '..table.sex..' robbing a store at '..table.street_1..', '..table.street_2, --you can remove the sex/streets etc if you dont want to display them.
        flash = 0, --set to 1 to make the ui flash, used for panic button calls etc.
        blip = { --blip info.
            sprite = 431, --blips icon - more can be found here https://docs.fivem.net/docs/game-references/blips/.
            scale = 1.2, --size of the blip.
            colour = 3, --colour of the blip - can be found at then bottom of this website page https://docs.fivem.net/docs/game-references/blips/.
            flashes = false, --if set to true the blip will flash, used for more important calls.
            text = '911 - Store Robbery',
            time = (5*60*1000),--the amount of time until the blip fades (default is 5 mins.)
            sound = 1, --the sound when recieving a notification (1 = 1 sound, 2 = 2 sounds, 3 = 3 sounds, 4 = panic button alert sound).
        }
    })
end)





TRIGGER THIS EVENT FROM YOUR RADIO SCRIPT EVERYTIME A PLAYER WHO HAS ACCESS TO THE DISPATCH CHANGES RADIO CHANNEL.
TriggerSererEvent('cd_dispatch:GetRadioChannel', radiochannelhere) --radio channel must be a number.


TRIGGER THIS EVENT FROM YOUR ON/OFF DUTY SCRIPT. (OPTIONAL, this is only needed if your police dont switch jobs to go off duty, but instead have an on/off duty system).
boolean = send false if they are off duty, send true if they are on duty.
from client to client : TriggerEvent('cd_dispatch:OnDutyChecks, boolean)
from server to client : TriggerClientEvent('cd_dispatch:OnDutyChecks, source, boolean)

TRIGGER THIS IN YOUR MULTI CHARACTER SCRIPT AFTER YOU HAVE SPAWNED IN.
TriggerEvent('cd_garage_GrabInfo')