
local beehive = {}

function DestroyOldBeeHive()
    local beekep = MySQL.query.await('SELECT * FROM beekeep')
    local CurrentOStime = os.time()
    
    if beekep then 
        for k,v in pairs(beekep) do 
            local timestampchange = CurrentOStime - v.timeinstall
            if timestampchange >= (HiveConfig.LifeTime * 60) then 
                print('delete this file')
                TriggerClientEvent('DoLongHudText',-1,"xóa")
                MySQL.query('DELETE FROM beekeep WHERE id = ?', {v.id})
                TriggerClientEvent('np-beekeeping:trigger_zone',-1, 4, v)
            end
        end
    end
end
--setInterval(DestroyOldBeeHive, HiveConfig.UpdateTimer)

Citizen.CreateThread(function()
    while true do 
        DestroyOldBeeHive()
        Citizen.Wait(HiveConfig.UpdateTimer)
    end
end)

RPC.register('np-beekeeping:removeHive',function(src, dataid, ready)
    if ready then 
        local beekep = MySQL.single.await('SELECT * FROM beekeep WHERE id = ?', {dataid})
    
        if beekep then 
                local beehivecoord = json.decode(beekep.coords)
                local beeupdate = {
                    id = beekep.id,
                    last_harvest = beekep.last_harvest,
                    timestamp = beekep.timestamp,
                    has_queen = beekep.has_queen,
                    coords = vector3(beehivecoord.x,beehivecoord.y,beehivecoord.z),
                    heading = beehivecoord.h,
                }
        
            TriggerClientEvent('np-beekeeping:trigger_zone',-1, 4, beeupdate)
        end
        local Data = MySQL.query.await('DELETE FROM beekeep WHERE id = ?', {dataid})
        return true
    end
    return false
end)

RPC.register('np-beekeeping:harvestHive',function(src, dataid)
    MySQL.Async.execute('UPDATE beekeep SET last_harvest = ? WHERE id = ?', {os.time(), dataid})

    local beekep = MySQL.single.await('SELECT * FROM beekeep WHERE id = ?', {dataid})
    
    if beekep then 
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
    end
    
    
    TriggerClientEvent("player:receiveItem",source,"honey",1)
    local randum = math.random(1)
    if randum <= HiveConfig.QueenChance then 
        TriggerClientEvent("player:receiveItem",source,"beequeen",1)
    end
end)

RPC.register('np-beekeeping:addQueen',function(src, dataid)
    MySQL.Async.execute('UPDATE beekeep SET has_queen = ? WHERE id = ?', {true, dataid})
    --local beekep = MySQL.query.await('SELECT * FROM beekeep')
    local beekep = MySQL.single.await('SELECT * FROM beekeep WHERE id = ?', {dataid})
    
    if beekep then 
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
    end
    
end)

RPC.register('np-beekeeping:getBeehives',function(src)
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
    return beehive

end)


RPC.register('np-beekeeping:installHive',function(src , pCoords , pHeading)
    
    local thecoords = {}
    local xcor,ycor,zcor = table.unpack(pCoords)
    thecoords = {x = xcor,y=ycor,z=zcor,h=pHeading}
    MySQL.query("INSERT INTO `beekeep` (`coords`, `last_harvest`, `timestamp`, `timeinstall`, `has_queen`) VALUES ('" .. json.encode(thecoords) .. "', '" .. os.time() .. "','" .. GetGameTimer() .. "', '" .. os.time() .. "', false)")
    local beekep = MySQL.single.await('SELECT * FROM beekeep ORDER BY id DESC LIMIT 1')
    Wait(200)
    local metafile = {
        id = beekep.id,
        last_harvest = beekep.last_harvest,
        timestamp = beekep.timestamp,
        has_queen = beekep.has_queen,
        coords = pCoords,
        heading = pHeading,
    }
    TriggerClientEvent('np-beekeeping:trigger_zone',-1, 2, metafile)
    --TriggerEvent('pw-beekeep:Sync')
end)

--[[ RegisterNetEvent("pw-beekeep:Sync")
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