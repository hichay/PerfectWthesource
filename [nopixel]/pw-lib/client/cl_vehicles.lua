function GetVehicleIdentifier(pVehicle)
    return exports["pw-vehicles"]:GetVehicleIdentifier(pVehicle)
end

function HasVehicleKey(pVehicle)
    return exports["pw-vehicles"]:HasVehicleKey(pVehicle)
end

function GetVehicleFuel(pVehicle)
    return exports["pw-vehicles"]:GetVehicleFuel(pVehicle)
end

function IsOnParkingSpot(pEntity, pEntity, pRadius)
    return exports["pw-vehicles"]:IsOnParkingSpot(pEntity, pEntity, pRadius)
end

function VehicleHasHarness(pVehicle)
    return exports["pw-vehicles"]:VehicleHasHarness(pVehicle)
end

function GetHarnessLevel(pVehicle)
    return exports["pw-vehicles"]:GetHarnessLevel(pVehicle)
end

function IsUsingNitro()
    return exports["pw-vehicles"]:IsUsingNitro()
end

function VehicleHasNitro(pVehicle)
    return exports["pw-vehicles"]:VehicleHasNitro(pVehicle)
end

function GetNitroLevel(pVehicle)
    return exports["pw-vehicles"]:GetNitroLevel(pVehicle)
end

function GetVehicleMetadata(pVehicle, pKey)
    return exports["pw-vehicles"]:GetVehicleMetadata(pVehicle, pKey)
end