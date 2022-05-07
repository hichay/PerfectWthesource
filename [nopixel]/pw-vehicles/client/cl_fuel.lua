--[[

    Variables

]]

DecorRegister("Vehicle-Fuel", 3)

local Fuel = 50
local DrivingSet = false
local LastVehicle = nil
local lastupdate = 0
local fuelMulti = 0

--[[

    Functions

]]

function SetVehicleFuel(vehicle, fuel, random)
	if not DoesEntityExist(vehicle) then return end

	if fuel and type(fuel) == "number" then
		Sync.DecorSetInt(vehicle, "Vehicle-Fuel", fuel)
	elseif random then
		local rnd = math.random(80, 100)
		Sync.DecorSetInt(vehicle, "Vehicle-Fuel", rnd)
	end
end

function GetVehicleFuel(vehicle)
    if not DoesEntityExist(vehicle) then
		return
	end

	if not DecorExistOn(vehicle, "Vehicle-Fuel") then
		return
	end

	return DecorGetInt(vehicle, "Vehicle-Fuel")
end

--[[

    Exports

]]

exports("SetVehicleFuel", SetVehicleFuel)
exports("GetVehicleFuel", GetVehicleFuel)

--[[

    Events

]]

AddEventHandler("caue-vehicles:refuel",function()
    local vehicle = nil

    local target = exports["caue-target"]:GetCurrentEntity()
    if DoesEntityExist(target) and GetEntityType(target) == 2 and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(target)) < 5 then
        vehicle = target
    end

    if not vehicle then return end

    local curFuel = GetVehicleFuel(vehicle)
    if not curFuel or curFuel == 100 then return end

    local price = (100 - curFuel) * 3
    local tax = RPC.execute("caue-financials:priceWithTax", price, "Services")

    local data = {
        {
            title = "Gas Station",
            description = "$" .. tax.total .. " Incl. " .. tax.porcentage .. "% tax",
            action = "caue-vehicles:refuelVehicle",
            params = {
                price = tax.total,
                tax = tax.tax,
                vehicle = VehToNet(vehicle),
            },
        }
    }

    exports["caue-context"]:showContext(data)
end)


AddEventHandler("caue-vehicles:refuelVehicle",function(params)
    local vehicle = NetToVeh(params.vehicle)

    if not vehicle or not DoesEntityExist(vehicle) or GetEntityType(vehicle) ~= 2 or #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(vehicle)) > 5 then
        return
    end

    local curFuel = GetVehicleFuel(vehicle)
    if not curFuel or curFuel == 100 then return end

    local refuel = RPC.execute("caue-vehicles:refuel", params.price, params.tax)
    if not refuel then return end

    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict("weapon@w_sp_jerrycan")
    TaskPlayAnim(PlayerPedId(), "weapon@w_sp_jerrycan", "fire", 8.0, 1.0, -1, 1, 0, 0, 0, 0)

    local finished = exports["caue-taskbar"]:taskBar((100 - curFuel) * 400, "Refueling")
    if finished == 100 then
        SetVehicleFuel(vehicle, 100)
    else
        local curFuel = GetVehicleFuel(vehicle)
        local endFuel = (100 - curFuel)
        endFuel = math.ceil(endFuel * (finished / 100) + curFuel)

        SetVehicleFuel(vehicle, endFuel)
    end

    ClearPedTasksImmediately(PlayerPedId())
end)

AddEventHandler("baseevents:leftVehicle", function(pCurrentVehicle, pCurrentSeat, vehicleDisplayName)
    local vid = GetVehicleIdentifier(pCurrentVehicle)
    if vid then
        local fuel = GetVehicleFuel(pCurrentVehicle)
        if not fuel then return end

        RPC.execute("caue-vehicles:updateVehicle", vid, "metadata", "fuel", fuel)
    end
end)

--[[

    Threads

]]

Citizen.CreateThread(function()

    -- Boat Station, Marina
	exports["caue-polyzone"]:AddBoxZone("pillbox_clothing_lockers_staff", vector3(300.28, -598.83, 43.28), 3.2, 4.2, {
		heading=340,
		minZ=42.28,
        maxZ=45.68,
        data = {
            vehicleClassRequirement = 14
        }
    })

    -- Boat Station, Marina
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-847.41, -1497.2, 1.63), 3.4, 4.2, {
        heading=19,
        minZ=0.63,
        maxZ=4.03,
        data = {
            vehicleClassRequirement = 14
        }
    })

    -- Boat Station, Marina | 2020-11-18T17:41:15Z
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-850.86, -1488.04, 1.63), 2.0, 4.2, {
        heading=20,
        minZ=0.63,
        maxZ=4.03,
        data = {
            vehicleClassRequirement = 14
        }
    })

    -- Boat Station, Marina | 2020-11-18T17:41:37Z
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-853.76, -1479.52, 1.6), 2.0, 4.2, {
        heading=20,
        minZ=0.6,
        maxZ=4.0,
        data = {
            vehicleClassRequirement = 14
        }
    })

    -- Boat Station, Marina | 2020-11-18T17:42:05Z
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-857.3, -1470.45, 1.63), 3.4, 4.2, {
        heading=20,
        minZ=0.63,
        maxZ=4.03,
        data = {
            vehicleClassRequirement = 14
        }
    })

    -- Boat Station, Marina | 2020-11-18T17:44:05Z
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-805.91, -1496.73, 8.64), 3.4, 4.2, {
        heading=20,
        minZ=0.64,
        maxZ=4.04,
        data = {
            vehicleClassRequirement = 14
        }
    })

    -- Boat Station, Marina | 2020-11-18T17:48:01Z
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-799.81, -1512.77, 4.93), 3.2, 4.2, {
        heading=20,
        minZ=0.93,
        maxZ=4.33,
        data = {
            vehicleClassRequirement = 14
        }
    })

    -- Paleto PD, Helicopter
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-475.14, 5988.95, 31.34), 28.4, 20.6, {
        heading=45,
        minZ=30.34,
        maxZ=36.74,
        data = {
            vehicleClassRequirement = 15
        }
    })

    -- VBPD, Helicopter
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-1095.41, -835.28, 37.68), 11.0, 10.8, {
        heading=39,
        minZ=36.68,
        maxZ=43.08,
        data = {
            vehicleClassRequirement = 15
        }
    })

    -- Marina, Helicopter
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-724.52, -1444.08, 5.0), 15.0, 15.2, {
        heading=50,
        minZ=4.0,
        maxZ=10.4,
        data = {
            vehicleClassRequirement = 15
        }
    })

    -- Pillbox, Helicopter
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(351.84, -588.1, 74.16), 10.8, 10.8, {
        heading=75,
        minZ=73.16,
        maxZ=79.56,
        data = {
            vehicleClassRequirement = 15
        }
    })

    -- MRPD, Helicopter
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(481.83, -982.1, 41.01), 11.0, 10.8, {
        heading=91,
        minZ=40.01,
        maxZ=46.41,
        data = {
            vehicleClassRequirement = 15
        }
    })

    -- Grapeseed, Airplane
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(2104.14, 4784.48, 41.06), 11.0, 10.8, {
        heading=116,
        minZ=40.06,
        maxZ=46.46,
        data = {
            vehicleClassRequirement = 16
        }
    })

    -- Sandy Shores, Airplane
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(1734.57, 3298.99, 41.11), 16.4, 42.4, {
        heading=104,
        minZ=40.11,
        maxZ=46.51,
        data = {
            vehicleClassRequirement = 16
        }
    })

    -- Sandy Shores, Helicopter
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(1770.36, 3239.85, 41.36), 14.0, 14.8, {
        heading=15,
        minZ=40.79,
        maxZ=45.79,
        data = {
            vehicleClassRequirement = 15
        }
    })

    -- LSIA, Airplane
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-1272.96, -3383.31, 13.94), 38.8, 46.8, {
        heading=60,
        minZ=12.94,
        maxZ=21.54,
        data = {
            vehicleClassRequirement = 16
        }
    })

    -- Drift School, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-66.37, -2532.39, 6.01), 20.2, 18.8, {
        heading=54,
        minZ=4.86,
        maxZ=10.86
    })

    -- Innocence Blvd / La Puerta, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-319.98, -1471.75, 30.72), 19.4, 28.6, {
        heading=30,
        minZ=29.57,
        maxZ=35.57
    })

    -- Panorama Drive, Sandy, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(1785.61, 3330.48, 41.24), 7.6, 6.05, {
        heading=29,
        minZ=40.09,
        maxZ=46.09
    })

    -- Palamino Freway, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(2580.96, 361.65, 108.46), 24.2, 15.45, {
        heading=88,
        minZ=107.46,
        maxZ=111.26
    })

    -- Clinton Avenue, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(621.11, 269.04, 103.03), 28.0, 19.25, {
        heading=90,
        minZ=102.03,
        maxZ=105.83
    })

    -- Mirror Park Blvd, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(1181.16, -330.36, 69.18), 25.8, 16.05, {
        heading=10,
        minZ=68.18,
        maxZ=71.98
    })

    -- El Rancho Blvd, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(1208.43, -1402.33, 35.23), 18.55, 8.65, {
        heading=45,
        minZ=34.23,
        maxZ=38.03
    })

    -- Vespucci Blvd, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(818.88, -1029.24, 26.12), 29.15, 17.05, {
        heading=271,
        minZ=25.12,
        maxZ=28.92
    })

    -- Strawberry, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(264.06, -1261.88, 29.17), 30.55, 23.65, {
        heading=269,
        minZ=28.17,
        maxZ=31.97
    })

    -- Grove Street, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-70.69, -1761.35, 29.39), 28.55, 15.65, {
        heading=249,
        minZ=28.39,
        maxZ=32.19
    })

    -- Calais Ave / Dutch London, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-525.44, -1211.17, 18.18), 20.55, 17.65, {
        heading=247,
        minZ=17.18,
        maxZ=20.98
    })

    -- Lindsay Circus, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-723.7, -935.56, 19.01), 25.95, 14.45, {
        heading=270,
        minZ=18.01,
        maxZ=21.81
    })

    -- West Eclipse Blvd, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-2096.84, -318.99, 13.02), 26.15, 20.85, {
        heading=264,
        minZ=12.02,
        maxZ=15.82
    })

    -- Perth Street, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-1436.6, -275.84, 46.56), 19.75, 19.05, {
        heading=221,
        minZ=45.16,
        maxZ=48.96
    })

    -- North Rockford Drive, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-1799.94, 803.18, 138.7), 16.15, 26.25, {
        heading=224,
        minZ=137.3,
        maxZ=141.1
    })

    -- Route 68, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-2555.18, 2332.81, 33.06), 16.15, 27.05, {
        heading=274,
        minZ=31.66,
        maxZ=35.46
    })

    -- Cascabel Avenue, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-93.79, 6420.09, 31.42), 10.2, 14.0, {
        heading=45,
        minZ=30.37,
        maxZ=34.37
    })

    -- Paleto Gas Station, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(179.51, 6602.49, 31.85), 15.4, 27.8, {
        heading=10,
        minZ=30.8,
        maxZ=34.8
    })

    -- Great Ocean  Highway / Paleto, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(1701.99, 6416.48, 32.61), 14.0, 10.6, {
        heading=65,
        minZ=31.61,
        maxZ=35.61
    })

    -- Grapeseed, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(1687.92, 4929.84, 42.08), 14.6, 10.2, {
        heading=55,
        minZ=41.08,
        maxZ=45.08
    })

    -- Marina Drive, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(2005.41, 3774.53, 32.18), 14.6, 10.2, {
        heading=299,
        minZ=31.18,
        maxZ=35.18
    })

    -- Senora Fwy, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(2680.2, 3264.51, 55.24), 14.6, 10.2, {
        heading=151,
        minZ=54.24,
        maxZ=58.24
    })

    -- Senora Way, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(2536.92, 2593.69, 37.95), 4.0, 4.8, {
        heading=113,
        minZ=36.95,
        maxZ=40.95
    })

    -- Route 68, Harmony, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(1208.14, 2660.14, 37.81), 10.6, 9.4, {
        heading=135,
        minZ=36.81,
        maxZ=40.81
    })

    -- Route 68, Motel, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(1038.76, 2671.25, 39.55), 17.6, 13.6, {
        heading=90,
        minZ=38.55,
        maxZ=42.55
    })

    -- Route 68, Joshua Road, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(264.23, 2607.21, 44.98), 7.0, 9.2, {
        heading=100,
        minZ=43.98,
        maxZ=47.98
    })

    -- Route 68, Approach, Cars
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(50.05, 2778.29, 57.88), 9.8, 10.8, {
        heading=52,
        minZ=56.88,
        maxZ=60.88
    })

    -- Viceroy Medical, Helicopter
    exports["caue-polyzone"]:AddBoxZone("gas_station", vector3(-791.1, -1191.5, 53.03), 15.0, 14.8, {
        name="viceroy",
        heading=320,
        data = {
            vehicleClassRequirement = 15
        }
    })

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(250)

        local player = PlayerPedId()

        if IsPedInAnyVehicle(player, false) then
            local veh = GetVehiclePedIsIn(player,false)

            if GetPedInVehicleSeat(veh, -1) == player then
                if not DrivingSet then
                    if LastVehicle ~= veh then
                        if not GetVehicleFuel(veh) then
                            SetVehicleFuel(veh, nil, true)
                        else
                            Fuel = GetVehicleFuel(veh)
                        end
                    else
                        Fuel = GetVehicleFuel(veh)
                    end

                    DrivingSet = true
                    LastVehicle = veh
                    lastupdate = 0

                    if not GetVehicleFuel(veh) then
                        SetVehicleFuel(veh, nil, true)
                    end
                else
                    if Fuel > 105 then
                        Fuel = GetVehicleFuel(veh)
                    end
                    if Fuel == 101 then
                        Fuel = GetVehicleFuel(veh)
                    end
                end

                if lastupdate > 300 then
                    SetVehicleFuel(veh, round(Fuel))
                    lasteupdate = 0
                end

                lastupdate = lastupdate + 1

                if Fuel > 0 then
                    if IsVehicleEngineOn(veh) then
                        local algofuel = GetEntitySpeed(GetVehiclePedIsIn(player, false)) * 3.6

                        if algofuel > 160 then
                            algofuel = algofuel * 1.8
                        else
                            algofuel = algofuel / 2.0
                        end

                        algofuel = algofuel / 15000

                        if algofuel == 0 then
                            algofuel = 0.0001
                        end

                        if IsPedInAnyBoat(PlayerPedId()) then
                            algofuel = 0.0090
                        end

                        if fuelMulti == 0 then
                            fuelMulti = 1
                        end

                        Fuel = Fuel - (algofuel + fuelMulti / 10000)
                    end
                end

                if Fuel <= 4 and Fuel > 0 then
                    if not IsThisModelABike(GetEntityModel(veh)) then
                        local decayChance = math.random(20, 100)
                        if decayChance > 90 then
                            Sync.SetVehicleEngineOn(veh, 0, 0, 1)
                            Sync.SetVehicleUndriveable(veh, true)
                            Citizen.Wait(100)
                            Sync.SetVehicleEngineOn(veh, 1, 0, 1)
                            Sync.SetVehicleUndriveable(veh, false)
                        end
                    end
                end

                if Fuel < 1 then
                    if Fuel ~= 0 then
                        Fuel = 0
                        SetVehicleFuel(veh, round(Fuel))
                    end

                    if IsVehicleEngineOn(veh) or IsThisModelAHeli(GetEntityModel(veh)) then
                        Sync.SetVehicleEngineOn(veh,0,0,1)
                        Sync.SetVehicleUndriveable(veh,false)
                    end
                end
            end
        else
            if DrivingSet then
                DrivingSet = false
                SetVehicleFuel(veh, round(Fuel))
            end

            Citizen.Wait(1500)
        end
    end
end)