Config = {}

-- Shared object event. Change it if you using qbus
Config.TrigEv = 'esx:getSharedObject'
-- To avoid people from dying of hunger or thirst at the table after every game their status can be reset
Config.RestoreStatus = true
Config.SetStatusEvent = 'esx_status:set'

-- Webhook for poker logs
Config.DiscordWebhook = 'https://discord.com/api/webhooks/875702515793010718/xLLScbCr86xIlxe98xembesG1c2Z-negLr916VGIU26yRrds_T3jqEWQ8l17-Ii0CKay'

Config.NewESX = true

-- Poker blip settings
Config.BlipCoords = vector3(1587.56, 3605.68, 38.56)
Config.BlipDisplay = 4
Config.BlipSprite = 267
Config.BlipColor = 49
Config.BlipScale = 0.0

-- Amount that automatically gets placed on blind call
Config.BigBlindAmount = 50

-- Amount of money player has to have in cash to sit at poker table
Config.AmountToStartPlaying = 50

-- Time for player to make decision (in seconds)
Config.MoveTimer = 30 -- seconds

-- Disables automatic camera moving (cinematic camera) while at the table
Config.DisableCinematicCamera = true

-- Marker to sit at the poker table
Config.MarkerCoords = vector3(244.8433, -757.114, 29.825378)

-- Hash keys for table and chair objects
Config.ChairHash = GetHashKey('prop_table_02_chr')
Config.TableHash = GetHashKey('prop_proxy_chateau_table')

-- Table position
Config.Table = {x = 244.8433, y = -757.114, z = 29.825378}
-- Config.Table = {x = 1608.24, y = 3607.0, z = 34.16}


-- Set chairs position depending on table by using offsets
Config.SetChairsByOffset = true

-- Chairs positions
Config.ChairsData = {
    {x = -1589.12, y = -3011.24, z = -77.0, h = 0, xOffset = 0.0, yOffset = 1.3},
    {x = -1587.68, y = -3012.0, z = -77.0, h = 290.0, xOffset = 1.3, yOffset = 0.6},
    {x = -1587.6, y = -3013.46, z = -77.0, h = 230.0, xOffset = 1.15, yOffset = -0.60},
    {x = -1589.0, y = -3014.08, z = -77.0, h = 180.0, xOffset = -0.0, yOffset = -1.3},
    {x = -1590.15, y = -3013.64, z = -77.0, h = 120.0, xOffset = -1.3, yOffset = -0.6},
    {x = -1590.24, y = -3012.24, z = -77.0, h = 65.0, xOffset = -1.2, yOffset = 0.6}
}

Config.Framework = 'esx' -- esx/qbus

-- Strings:
-- Language to use
Config.Language = 'en'
-- Translations
Config.Strings = {
    ['en'] = {
        ['blip_name'] = 'Poker Table',
        ['poker_title'] = 'Bàn chơi poker',
        ['pot_title'] = 'Tổng Pot: {1}{0}', -- {0:amount}{1:currency}
        ['player_turn_title'] = 'Lượt của: {0}', -- {0:player's name}
        ['player_list_title'] = 'Player',
        ['winning_announcement'] = '{0} Thắng', -- {0:player's name}
        ['winning_status'] = 'Thắng',
        ['currency'] = '$',
        ['no_space'] = 'All seats are taken at the table',
        ['leave_table'] = 'You left Poker table',
        ['join_table'] = '~INPUT_CONTEXT~ - sit at the Poker table',
        ['not_enough_money'] = 'You must have at least %d%s if you want to start playing poker',
        ['wrong_amount'] = 'Invalid bet amount',
        ['too_low_bet'] = 'Bet is to small. Current bet - %d',
        ['player_status_title'] = 'Người chơi {0}: ', -- {0:table slot}
        ['player_list_fold'] = 'Đã bỏ bài',
        ['default_player_status'] = ' Trống',
        ['check-button_title'] = 'Xem',
        ['call-button_title'] = 'Theo {1}{0}', -- {0:amount}{1:currency}
        ['bet-button_title'] = 'Cược',
        ['fold-button_title'] = 'Bỏ bài',
        ['exit-button_title'] = 'Thoát',
    },
    ['lt'] = {
        ['blip_name'] = 'Pokerio stalas',
        ['poker_title'] = 'Pokeris',
        ['pot_title'] = 'Bendras Prizas: {0}{1}', -- {0:amount}{1:currency}
        ['player_turn_title'] = 'Žaidėjo {0} eilė', -- {0:player's name}
        ['player_list_title'] = 'Žaidėjas',
        ['winning_announcement'] = '{0} Laimėjo', -- {0:player's name}
        ['winning_status'] = 'Laimėjo',
        ['currency'] = '€',
        ['no_space'] = 'Nera laisvu vietu prie stalo',
        ['leave_table'] = 'Palikote stala',
        ['join_table'] = '~INPUT_CONTEXT~ - sesti prie pokerio stalo',
        ['not_enough_money'] = 'Norint atsisesti prie pokerio stalo reikia tureti bent %d€',
        ['wrong_amount'] = 'Netinkamai ivesta statymo suma',
        ['too_low_bet'] = 'Statymas per mazas, dabartinis statymas - %d',
        ['player_status_title'] = 'Žaidėjas {0}: ', -- {0:table slot}
        ['player_list_fold'] = 'Nusimetė Kortas',
        ['default_player_status'] = 'Ne prie stalo',
        ['check-button_title'] = 'Praleisti',
        ['call-button_title'] = 'Atsakyti {0}{1}', -- {0:amount}{1:currency}
        ['bet-button_title'] = 'Statyti',
        ['fold-button_title'] = 'Nusimesti',
        ['exit-button_title'] = 'Išeiti',
    },
    ['es'] = {
        ['blip_name'] = 'Mesa de póker',
        ['poker_title'] = 'Póker',
        ['pot_title'] = 'Bote: {1}{0}', -- {0:amount}{1:currency}
        ['player_turn_title'] = 'Turno de {0}', -- {0:player's name}
        ['player_list_title'] = 'Jugador',
        ['winning_announcement'] = '{0} ganó', -- {0:player's name}
        ['winning_status'] = 'Ganó',
        ['currency'] = '$',
        ['no_space'] = 'Todos los asientos están ocupados',
        ['leave_table'] = 'Dejaste la mesa',
        ['join_table'] = 'Pulsa  ~INPUT_CONTEXT~ para sentarte en la mesa',
        ['not_enough_money'] = 'Necesitas por lo menos %d%s para jugar',
        ['wrong_amount'] = 'Cantidad inválida',
        ['too_low_bet'] = 'Apuesta insuficiente. Apuesta actual - %d',
        ['player_status_title'] = 'Jugador {0}: ', -- {0:table slot}
        ['player_list_fold'] = 'Retirado',
        ['default_player_status'] = ' No está en la mesa',
        ['check-button_title'] = 'Pasar',
        ['call-button_title'] = 'Igualar {1}{0}', -- {0:amount}{1:currency}
        ['bet-button_title'] = 'Apostar',
        ['fold-button_title'] = 'Retirarse',
        ['exit-button_title'] = 'Salir',
    }
}

MySQL = {}
MySQL.ready = function() end

-- Functions
-- Note: script author does not take any responsibility for issues caused by functions below

Config.GetPlayerMoney = function(playerId)
    if type(playerId) == "number" then 
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then
            return xPlayer.getMoney()
        end
    else -- if player is debug player
        return 10000
    end
    return 0
end
Config.AddPlayerMoney = function(playerId, amount)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        xPlayer.addAccountMoney('money', amount)
    end
end
Config.RemovePlayerMoney = function(playerId, amount)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        xPlayer.removeAccountMoney('money', amount)
    end
end
Config.GetPlayerName = function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local name = xPlayer.getName()
    if xPlayer then
        return name
    end
    return playerId
end