Citizen.CreateThread(function()
    exports["pw-polyzone"]:AddBoxZone("wheelchair_store", vector3(-803.48, -1248.7, 7.34), 1.6, 1.0, {
        heading=320,
        minZ=6.14,
        maxZ=8.74,
        data = {
            id = "1",
        },
    })

    exports["pw-polyzone"]:AddBoxZone("police_station", vector3(461.91, -993.59, 30.69), 55.8, 54.8, {
        heading=0,
        minZ = 23.49,
        maxZ = 32.29,
        data = {
            id = "mrpd"
        }
    })

    exports["pw-polyzone"]:AddBoxZone("police_station", vector3(-1084.8, -836.75, 13.52), 25.6, 11.2, {
        heading=309,
        minZ=12.32,
        maxZ=17.72,
        data = {
            id = "vspd"
        }
    })

    exports["pw-polyzone"]:AddBoxZone("police_station", vector3(1834.68, 3687.33, 42.97), 28.0, 65.4, {
        heading=30,
        minZ=33.17,
        maxZ=41.37,
        data = {
            id = "sspd"
        }
    })

    exports["pw-polyzone"]:AddBoxZone("police_station", vector3(-443.63, 6003.52, 31.49), 26.6, 37.6, {
        heading=316,
        minZ=22.34,
        maxZ=44.34,
        data = {
            id = "ppd"
        }
    })

    exports["pw-polyzone"]:AddBoxZone("police_station", vector3(382.87, 796.83, 187.46), 8.0, 11.8, {
        heading=0,
        minZ=186.46,
        maxZ=193.26,
        data = {
            id = "prpd"
        }
    })

    exports["pw-polyzone"]:AddBoxZone("police_station", vector3(375.22, -1608.44, 30.04), 38.0, 61.2, {
        heading=320,
        minZ=27.84,
        maxZ=41.24,
        data = {
            id = "davispd"
        }
    })

    exports["pw-polyzone"]:AddBoxZone("police_station", vector3(844.08, -1295.15, 38.62), 36.4, 32.2, {
        heading=0,
        minZ=24.82,
        maxZ=34.02,
        data = {
            id = "lamesapd"
        }
    })

    exports["pw-polyzone"]:AddBoxZone("possession_pickup", vector3(472.98, -1007.43, 26.27), 1.2, 2.6, {
        heading=0,
        minZ=25.27,
        maxZ=27.47,
        data = {
            id = "mrpdpickup"
        }
    })

    exports["pw-polyzone"]:AddBoxZone("possession_pickup", vector3(-1088.5, -811.11, 19.3), 1.2, 2.6, {
        heading=40,
        minZ=18.3,
        maxZ=20.5,
        data = {
            id = "vspdpickup"
        }
    })

    exports["pw-polyzone"]:AddBoxZone("possession_pickup", vector3(384.99, 799.86, 187.46), 1.2, 2.6, {
        heading=0,
        minZ=186.46,
        maxZ=188.66,
        data = {
            id = "prpdpickup"
        }
    })

    exports["pw-polyzone"]:AddBoxZone("possession_pickup", vector3(1835.42, 3678.33, 34.2), 2, 2, {
        heading=30,
        minZ=32.4,
        maxZ=36.4,
        data = {
            id = "sspdpickup"
        }
    })

    exports["pw-polyzone"]:AddBoxZone("possession_pickup", vector3(-446.11, 6013.73, 32.29), 1.6, 1.2, {
        heading=316,
        minZ=31.29,
        maxZ=33.49,
        data = {
            id = "ppdpickup"
        }
    })

    exports["pw-polyzone"]:AddBoxZone("possession_pickup", vector3(1840.42, 2579.44, 46.01), 2.2, 2.6, {
        heading=0,
        minZ=45.01,
        maxZ=47.61,
        data = {
            id = "prisonpickup"
        }
    })

    --[[ PolyZoneInteraction("possession_pickup", "[E] Re-claim Possessions", 38, function (data)
        local cid = exports["isPed"]:isPed("cid")
        TriggerServerEvent("server-jail-items", cid, false, GetPlayerServerId(PlayerId()))
        TriggerEvent("DoLongHudText", "Your possessions were returned.")
        exports["np-ui"]:hideInteraction()
        Citizen.Wait(15000)
    end) ]]
end)
