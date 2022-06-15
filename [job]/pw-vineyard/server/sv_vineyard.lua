ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local beehive = {}

RPC.register('pw-vineyard:installBarbel',function(src , pCoords , pHeading)
    --[[ local xPlayer = ESX.GetPlayerFromId(source)
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
    MySQL.query("INSERT INTO `vineyard` (`coords`, `last_harvest`, `timestamp`, `timeinstall`) VALUES ('" .. json.encode(thecoords) .. "', '" .. os.time() .. "','" .. GetGameTimer() .. "', '" .. os.time() .. "')")

    TriggerEvent('pw-beekeep:Sync')
 ]]
 local xPlayer = ESX.GetPlayerFromId(source)
    local thecoords = {}
    local xcor,ycor,zcor = table.unpack(pCoords)
    thecoords = {x = xcor,y=ycor,z=zcor,h=pHeading}
    MySQL.query("INSERT INTO `vineyard` (`coords`, `timestamp`) VALUES ('" .. json.encode(thecoords) .. "','" .. GetGameTimer() .. "')")
    local beekep = MySQL.single.await('SELECT * FROM vineyard ORDER BY id DESC LIMIT 1')
    Wait(200)


    local normalmeta = {
        id = beekep.id,
        type = "vinewood_grape_barrel",
        name = "Unnamed",
        sealed = false,
        created_at = os.time(),
        grapes = {},
        _hideKeys = { "cid", "id", "type", "sealed", "created_at", "grapes" },
    }

    local metadata = {
        id = beekep.id,
        coords = pCoords,
        heading = pHeading,
        meta = {
            type = "vinewood_grape_barrel",
            name = "Unnamed",
            sealed = false,
            created_at = os.time(),
            grapes = {},
            _hideKeys = { "cid", "id", "type", "sealed", "created_at", "grapes" },
        }
    }

    MySQL.Async.execute('UPDATE vineyard SET meta = ? WHERE id = ?', {json.encode(normalmeta), beekep.id})
    TriggerClientEvent('pw-vineyard:trigger_zone',-1, 2, metadata)
end)

RPC.register('np-beekeeping:getBarrels',function(src)
    local beekep = MySQL.query.await('SELECT * FROM vineyard')
    if beekep then 
        for k,v in pairs(beekep) do 
            local beehivecoord = json.decode(v.coords)
            beehive[#beehive+1] = {
                id = v.id,
                coords = vector3(beehivecoord.x,beehivecoord.y,beehivecoord.z),
                heading = beehivecoord.h,
                meta = json.decode(v.meta),
            }
        end
        
        TriggerClientEvent('pw-vineyard:trigger_zone',-1, 1, beehive)
    end
    return beehive

end)

RPC.register('pw-vineyard:changeBarrelName',function(src, dataid, name)
    --MySQL.Async.execute('UPDATE beekeep SET has_queen = ? WHERE id = ?', {true, dataid})
    --local beekep = MySQL.query.await('SELECT * FROM beekeep')
    print(dataid)
    local beekep = MySQL.single.await('SELECT * FROM vineyard WHERE id = ?', {dataid})
    for k,v in pairs(beekep) do
        local metadata = json.decode(v.meta)
    end
    local metanew = {
        name = name,
        type = metadata.type,
        id = metadata.id,
        sealed = metadata.sealed,
        grapes = metadata.grapes,
        _hideKeys = metadata._hideKeys,
        created_at = metadata.created_at
    }


    MySQL.Async.execute('UPDATE vineyard SET meta = ? WHERE id = ?', {json.encode(metanew), dataid})
    TriggerClientEvent('np-beekeeping:trigger_zone',-1, 3, metanew)
    --[[ if beekep then 
            local beehivecoord = json.decode(beekep.coords)
            local beeupdate = {
                id = beekep.id,
                last_harvest = beekep.last_harvest,
                timestamp = beekep.timestamp,
                has_queen = beekep.has_queen,
                coords = vector3(beehivecoord.x,beehivecoord.y,beehivecoord.z),
                heading = beehivecoord.h,
            }
       
        TriggerClientEvent('np-beekeeping:trigger_zone',-1, 3, beeupdate)
    end ]]
    
end)

--[[ 
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
end) ]]