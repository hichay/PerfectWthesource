local beds = {
    { x = 314.589, y = -584.082, z = 44.204, h = 170.0, taken = false, model = 1631638868 },
    { x = 311.1046, y = -583.1647, z = 44.204, h = 170.0, taken = false, model = 1631638868 },
    { x = 317.7204, y = -585.5063, z = 44.204, h = 170.0, taken = false, model = 1631638868 },
    { x = 322.6154, y = -587.3105, z = 44.204, h = 170.0, taken = false, model = 1631638868 },
    { x = 319.4153, y = -580.909, z = 44.204, h = -20.0, taken = false, model = 1631638868 },
    { x = 313.948, y = -578.8614, z = 44.204, h = -20.0, taken = false, model = 1631638868 },
    { x = 309.2876, y = -577.2015, z = 44.204, h = -20.0, taken = false, model = 1631638868 },
}

local bedssamac = {
    { x = 1828.7852, y = 3678.1875, z = 34.635967, h = 28.999647, taken = false, model = 1631638868 },
    { x = 1830.895, y = 3674.3854, z = 34.981361, h = 208.99964, taken = false, model = 1631638868 },
    { x = 1821.8574, y = 3680.5129, z = 34.981338, h = 298.99765, taken = false, model = 1631638868 },
    { x = 1818.2698, y = 3678.3193, z = 35.017936, h = 295.99761, taken = false, model = 1631638868 },

}

local bedsTaken = {}
local injuryBasePrice = 100

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

RegisterServerEvent('pw-hospital:server:RequestBed')
AddEventHandler('pw-hospital:server:RequestBed', function()
    for k, v in pairs(beds) do
        if not v.taken then
            v.taken = true
            bedsTaken[source] = k
            TriggerClientEvent('pw-hospital:client:SendToBed', source, k, v)
            return
        end
    end

    TriggerClientEvent('DoLongHudText', source, 'No Beds Available', 2)
end)

RegisterServerEvent('pw-hospital:server:RequestBedsamac')
AddEventHandler('pw-hospital:server:RequestBedsamac', function()
    for k, v in pairs(bedssamac) do
        if not v.taken then
            v.taken = true
            bedsTaken[source] = k
            TriggerClientEvent('pw-hospital:client:SendToBed', source, k, v)
            return
        end
    end

    TriggerClientEvent('DoLongHudText', source, 'Không còn giường nào để nằm', 2)
end)

RegisterServerEvent('pw-hospital:server:RPRequestBed')
AddEventHandler('pw-hospital:server:RPRequestBed', function(plyCoords)
    local foundbed = false
    for k, v in pairs(beds) do
        local distance = #(vector3(v.x, v.y, v.z) - plyCoords)
        if distance < 3.0 then
            if not v.taken then
                v.taken = true
                foundbed = true
                TriggerClientEvent('pw-hospital:client:RPSendToBed', source, k, v)
                return
            else
                TriggerEvent('chat:addMessage', source, 'Giường đã có người nằm')
            end
        end
    end

    if not foundbed then
        TriggerEvent('chat:addMessage', source, 'Không gần giường nào cả')
    end
end)

RegisterServerEvent('pw-hospital:server:EnteredBed')
AddEventHandler('pw-hospital:server:EnteredBed', function()
    local src = source
    local injuries = GetCharsInjuries(src)

    local totalBill = injuryBasePrice

    -- if injuries ~= nil then
        -- for k, v in pairs(injuries.limbs) do
            -- if v.isDamaged then
                -- totalBill = totalBill + (injuryBasePrice * v.severity)
            -- end
        -- end

        -- if injuries.isBleeding > 0 then
            -- totalBill = totalBill + (injuryBasePrice * injuries.isBleeding)
        -- end
    -- end
    TriggerClientEvent('pw-hospital:client:FinishServices', src)
end)

RegisterServerEvent('pw-hospital:server:LeaveBed')
AddEventHandler('pw-hospital:server:LeaveBed', function(id)
    beds[id].taken = false
	bedssamac[id].taken = false
end)