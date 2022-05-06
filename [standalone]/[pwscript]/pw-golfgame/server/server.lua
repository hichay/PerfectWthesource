ESX = nil

TriggerEvent(
    'esx:getSharedObject',
    function(obj)
        ESX = obj
    end
)

ESX.RegisterUsableItem(
    'golf',
    function(source)
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            TriggerClientEvent('avGolf:spawnBall', xPlayer.source, 'prop_golf_ball')
        end
    end
)

ESX.RegisterUsableItem(
    'golf_yellow',
    function(source)
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            TriggerClientEvent('avGolf:spawnBall', xPlayer.source, 'prop_golf_ball_p2')
        end
    end
)

ESX.RegisterUsableItem(
    'golf_green',
    function(source)
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            TriggerClientEvent('avGolf:spawnBall', xPlayer.source, 'prop_golf_ball_p3')
        end
    end
)

ESX.RegisterUsableItem(
    'golf_pink',
    function(source)
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            TriggerClientEvent('avGolf:spawnBall', xPlayer.source, 'prop_golf_ball_p4')
        end
    end
)

RegisterNetEvent('avGolf:saveHit')
AddEventHandler(
    'avGolf:saveHit',
    function(distance)
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            distance = round2(distance, 2)

            if Config.Toplist.Enabled then
                MySQL.Async.fetchAll(
                    'SELECT * FROM golfhits WHERE identifier = @identifier',
                    {
                        ['@identifier'] = xPlayer.identifier
                    },
                    function(result)
                        if result[1] then
                            local savedDistance = result[1].distance
                            if distance > savedDistance then
                                TriggerClientEvent('av:midMessage', source, 'Golf', _('midmessage_newrecord', distance))
                                MySQL.Sync.execute(
                                    'UPDATE golfhits SET distance = @distance, date = @date WHERE identifier = @identifier',
                                    {
                                        ['@identifier'] = xPlayer.identifier,
                                        ['@distance'] = distance,
                                        ['@date'] = os.date('%x') .. ' (' .. os.date('%X') .. ')'
                                    }
                                )
                            end
                        else
                            TriggerClientEvent('av:midMessage', source, 'Golf', _('midmessage_newrecord', distance))
                            MySQL.Sync.execute(
                                'INSERT INTO golfhits (identifier, name, distance, date) VALUES (@identifier, @name, @distance, @date)',
                                {
                                    ['@identifier'] = xPlayer.identifier,
                                    ['@distance'] = distance,
                                    ['@name'] = GetPlayerName(xPlayer.source),
                                    ['@date'] = os.date('%x') .. ' (' .. os.date('%X') .. ')'
                                }
                            )
                        end
                    end
                )
            else
                TriggerClientEvent('av:midMessage', source, 'Golf', _('midmessage_putball', distance))
            end
        end
    end
)

function round2(num, numDecimalPlaces)
    return tonumber(string.format('%.' .. (numDecimalPlaces or 0) .. 'f', num))
end

if Config.Toplist.Enabled then
    RegisterCommand(
        Config.Toplist.Command,
        function(source)
            MySQL.Async.fetchAll(
                string.format('SELECT * FROM golfhits order by distance desc limit %s', Config.Toplist.Count),
                {},
                function(result)
                    TriggerClientEvent('avGolf:leaderboard', source, result)
                end
            )
        end,
        false
    )
end

-- ONLY STANDALONE
-- function getIdentifier(source)
--     local id = nil
--     for k, v in pairs(GetPlayerIdentifiers(source)) do
--         if string.sub(v, 1, string.len('license:')) == 'license:' then
--             id = v
--         end
--     end

--     return id
-- end
