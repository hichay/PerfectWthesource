Installation instructions:

First you need to import db.sql into your database.

If you are updating the resource you will need to import db-update.sql, instead of db.sql

Second you need to copy this resource folder into your resources folder.
Add the following line to the server.cfg: start codev_vehsystem
Afterwards open config.lua and edit it by changing the license to the one you received in your email, the license is the tebex transaction id.

Be sure to start this on your server as it verifies the IP on the first start, if you started this on a different server or ip you can contact us on https://discord.gg/EmxJKp2W3g 
You can also request a developer license on https://discord.gg/EmxJKp2W3g if your developing server is ran on a different server.

If you want mechanics to be able to use /fixengine and /fixstart commands you'll have to add the following ace permissions in server.cfg

Where example would go the steam:hexid
#add_ace identifier.steam:example codev_vehsystem.fixengine allow
#add_ace identifier.steam:example codev_vehsystem.fixstart allow

If you want to allow all admins it would be like this:
#add_ace group.admin codev_vehsystem allow

If you want to add the option of making it so only car owners can start up the engine or ignition then you'll have to add the following server event on your vehicle shop after purchase passing the plate.

This event is to be executed on your server after purchasing a car, passing the source and the plate of the vehicle.
TriggerEvent('vehicle_system:setOwner', source, plate)

Make sure to also change the sv_config.lua setting for ownerIdentifier type, steam, license or fivem.

Important information:

If you have started the script on a different server rather than your server and you're getting a "incorrect configuration" error then send us a message at https://discord.gg/EmxJKp2W3g

Do not rename the script.
Do not resell the script.