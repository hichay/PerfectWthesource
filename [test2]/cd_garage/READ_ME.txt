-------------
HOW TO SET UP
-------------
Step 1 :
Unzip all folders from the zips folder. (choose one of the weather scripts, cd_easytime or vSync or use your own).

Step 2 :
Add to your server config.
start cd_garage
start cd_garageshell
start cd_drawtextui
start cd_easytme

-------------
EXPORTS
-------------
exports['cd_garage']:GetGarageLimit(source)                - SERVER SIDED EXPORT TO GET A PLAYERS GARAGE LIMIT. - returns a number.
exports['cd_garage']:GetGarageCount(source, garage_type)   - SERVER SIDED EXPORT TO GET A PLAYERS GARAGE COUNT. (if the garage_type is nill it will choose car by default). - returns a number.

exports['cd_garage']:GetGarageType(vehicle)                - CLIENT SIDED EXPORT TO GET THE VEHICLE TYPE - returns a string (car/boat/air).
exports['cd_garage']:GetAdvStats(plate)                    - CLIENT SIDED EXPORT TO GET THE VEHICLES ADVANDED STATS (plate/mileage/maxhealth) - returns a table.

-------------
COMMANDS
-------------
/impound
/transfervehicle (serverid)
/checkmiles
/garagespace (add) (serverid)

-------------
EVENTS
-------------
TriggerEvent('cd_garage:checkmileage')                      - THIS EVENT CAN BE TRIGGERED TO CHECK MILES INSTEAD OF USING THE COMMAND.
TriggerEvent('cd_garage:ImpoundVehicle')                    - THIS EVENT CAN BE TRIGGERED TO IMPOUND VEHICLES INSTEAD OF USING THE COMMAND.
TriggerEvent('cd_garage:TransferVehicle', targetID)         - THIS EVENT CAN BE TRIGGERED TO TRANSFER A VEHICLE TO ANOTHER PLAYER INSTEAD OF USING THE COMMAND. It requires you to send the server id of the player you are transfering the vehicle to.

-------------
REQUIRED EDITS
-------------
--IF YOU ARE USING AN OLDER VERSION OF ES_EXTENED, GOTO : es_extended/client/fuctions > and find the ESX.Game.GetVehicleProperties, if these lines below are not there, add them to the function.
bodyHealth        = ESX.Math.Round(GetVehicleBodyHealth(vehicle), 1),
engineHealth      = ESX.Math.Round(GetVehicleEngineHealth(vehicle), 1),
fuelLevel         = ESX.Math.Round(GetVehicleFuelLevel(vehicle), 1),

--SAME FOR ESX.Game.GetVehicleProperties (in the same file).
if props.bodyHealth then SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0) end
if props.engineHealth then SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0) end
if props.fuelLevel then SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0) end

--when you are adding a vehicle to your garage, send this to your server too and send the garage type - 
exports['cd_garage']:GetGarageType(vehicle)