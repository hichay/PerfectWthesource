


RPC.register('np-beekeeping:installHive',function(src , pCoords , pHeading)
    local xPlayer = ESX.GetPlayerFromId(source)
    local thecoords = {}
    local xcor,ycor,zcor = table.unpack(pCoords)
    thecoords = {x = xcor,y=ycor,z=zcor,h=pHeading}

    local metadata = {
      cid = xPlayer.id,
      id = id,
      type = "vinewood_grape_barrel",
      name = "Unnamed"
      sealed = false,
      created_at = os.time(),
      grapes = {},
      _hideKeys = { "cid", "id", "type", "sealed", "created_at", "grapes" },
    }
    MySQL.query("INSERT INTO `beekeep` (`coords`, `last_harvest`, `timestamp`, `timeinstall`, `has_queen`) VALUES ('" .. json.encode(thecoords) .. "', '" .. os.time() .. "','" .. GetGameTimer() .. "', '" .. os.time() .. "', false)")

    TriggerEvent('pw-beekeep:Sync')
end)

RegisterNetEvent("pw-beekeep:Sync")
AddEventHandler("pw-beekeep:Sync", function()
    Wait()
    local beekep = MySQL.query.await('SELECT * FROM beekeep')
    if beekep then 
        for k,v in pairs(beekep) do 
            local beehivecoord = json.decode(v.coords)
            beehive[#beehive+1] = {
                id = v.id,
                last_harvest = v.last_harvest,
                timestamp = v.timestamp,
                has_queen = v.has_queen,
                coords = vector3(beehivecoord.x,beehivecoord.y,beehivecoord.z),
                heading = beehivecoord.h,
            }
        end
        TriggerClientEvent('np-beekeeping:trigger_zone',-1, 1, beehive)
    end
end)