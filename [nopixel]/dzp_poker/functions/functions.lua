------------------------------
-- Side functions for poker --
------------------------------
local tableCombination = nil

-- Checks if all players have equal bet
-- TODO: optimize
function isBetsEqual()
    if getPlayersInGame() > 1 then
        for i = 1, playersLimit do
            local pokerPlayer = PokerPlayers[i]
            if isNotNil(pokerPlayer)  then
                -- local xPlayer = ESX.GetPlayerFromId(pokerPlayer.playerId)
                -- DebugPrint(xPlayer.getMoney())
                -- if pokerPlayer.isPlayerInGame() then
                --if pokerPlayer.isPlayerInGame() and xPlayer.getAccount('money').money > 0 then
                if pokerPlayer.isPlayerInGame() and not pokerPlayer.allIn then
                    for j = 1, playersLimit do
                        local nextPokerPlayer = PokerPlayers[j]
                        if isNotNil(nextPokerPlayer) then
                            -- local nextxPlayer = ESX.GetPlayerFromId(nextPokerPlayer.playerId)
                            if nextPokerPlayer.isPlayerInGame() and not nextPokerPlayer.allIn then
                                DebugPrint('Players ids: ' .. pokerPlayer.playerId .. ' ' .. nextPokerPlayer.playerId)
                                DebugPrint('Players stakes: ' .. pokerPlayer.getPlayerStake() .. ' ' .. nextPokerPlayer.getPlayerStake())
                                if pokerPlayer.getPlayerStake() ~= nextPokerPlayer.getPlayerStake() then
                                    return false
                                end
                            elseif nextPokerPlayer.allIn then
                                if pokerPlayer.getPlayerStake() < nextPokerPlayer.getPlayerStake() then
                                    return false
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return true
end

-- Gets player in PokerPlayers array from player server id
function getPlayerIdInArray(playerId)
    for i = 1, playersLimit do
        local pokerPlayer = PokerPlayers[i]
        if isNotNil(pokerPlayer) and pokerPlayer.getPlayerId() == playerId then
            return i
        end
    end
    return 0
end

-- Get number of players that are not folded
-- canBet - only players who can bet (have money / are not all inned)
function getPlayersInGame(canBet)
    local numberOfPlayers = 0
    for i = 1, playersLimit do
        local pokerPlayer = PokerPlayers[i]
        --(p and q and r and s) or (p and q and not r)
        if (isNotNil(pokerPlayer) and pokerPlayer.isPlayerInGame() and canBet and not pokerPlayer.allIn) or (isNotNil(pokerPlayer) and pokerPlayer.isPlayerInGame() and not canBet)  then
            numberOfPlayers = numberOfPlayers + 1
        else
        end
    end
    return numberOfPlayers
end

-- Gets a total number of players that are at table
function getPlayersAtTable()
    local numberOfPlayers = 0
    for i = 1, playersLimit do
        local pokerPlayer = PokerPlayers[i]
        if isNotNil(pokerPlayer) then
            numberOfPlayers = numberOfPlayers + 1
        end
    end
    return numberOfPlayers
end

-- Checks if player is in PokerPlayers table
function isPlayerInPoker(playerId)
    for i = 1, playersLimit do
        if isNotNil(PokerPlayers[i]) and playerId == PokerPlayers[i].getPlayerId() then
            return true
        end
    end
    return false
end


------------------
-- Combinations --
------------------
RegisterCommand('combotest', function(source, args)
    TableCards = {
        {11,  12, 1},
        {8,  9, 1},
        {21,  9, 2},
        {6,  7, 1},
        {29,  4, 3}
    }
    local cards = {}
    cards.player1 ={
        {8, 8, 4},
        {8, 10, 3} 
    } 
    cards.player2 ={
        {8, 6, 2},
        {8, 5, 4} 
    } 
    cards.player3 ={
        {8, 6, 2},
        {8, 8, 4} 
    }
    DebugPrint('Finding table Combination')
    tableCombination = ''
    tableCombination = findCombinations(TableCards, false)
    for player, _cards in pairs(cards) do
        local combinations = findCombinations(_cards, true)
    end
end, false)

-- Find combination value
function findCombinations(cardsGiven, doConnectTables)
    
    local cards = cardsGiven
    if doConnectTables then
        cards = connectTables(cards, TableCards)
    end
    
    local combination = {combId = 0, combValue = 0}

    bubbleSort(cards)

    for i = 1, #cards do
        DebugPrint('ID:' .. cards[i][1] .. ' Value:' .. cards[i][2])
    end

    local counts = findCounts(cards)

    if isStraightFlush(cards, counts) then
        combination.combId = 1
        combination.combValue = isStraightFlush(cards, counts)
        DebugPrint('Straight flush found')
    elseif isFourOfKind(cards, counts) then
        combination.combId = 2
        combination.combValue = isFourOfKind(cards, counts)
        DebugPrint('Four of a kind found')
    elseif isFullHouse(cards, counts) then
        combination.combId = 3
        combination.combValue = isFullHouse(cards, counts)
        DebugPrint('Full House found')
    elseif isFlush(cards, counts) then
        combination.combId = 4
        combination.combValue = isFlush(cards, counts)
        DebugPrint("Flush found")
    elseif isStraight(cards, counts) then
        combination.combId = 5
        combination.combValue = isStraight(cards, counts)
        DebugPrint('Straight found')
    elseif isThreeOfKind(cards, counts) then
        combination.combId = 6
        combination.combValue = isThreeOfKind(cards, counts)   
        DebugPrint('Three of a kind found')
    -- Two Pairs
    elseif isPairs(cards, counts).pairsAmount == 2 then
        combination.combId = 7
        combination.combValue = isPairs(cards, counts).pairsValue
        DebugPrint('Two pairs found')
    -- One Pair
    elseif isPairs(cards, counts).pairsAmount == 1 then
        combination.combId = 8
        combination.combValue = isPairs(cards, counts).pairsValue
        DebugPrint('One pair found')
    else
        combination.combId = 9
        combination.combValue = cards[#cards][2]
        DebugPrint('High card')
    end
    DebugPrint('comb ID ' .. combination.combId)
    DebugPrint('comb Value ' .. combination.combValue)
    
    -- TriggerEvent('debugPokerLog', json.encode(tableCombination) .. json.encode(combination))
    if tableCombination.combId == combination.combId and tableCombination.combValue == combination.combValue and doConnectTables then
        TriggerEvent('debugPokerLog', 'Table has highest combo')
        combination = findCombinations(cardsGiven, false)
    end
    return combination
end

-- Find if combination is valid
function isStraightFlush(cards, counts)
    local tracker = 1
    for i = #cards, 2, -1 do
        -- Does card behind have value smaller by one
        DebugPrint(cards[i][2])
        if cards[i][2] == cards[i-1][2] + 1 and cards[i][3] == cards[i-1][3] then
            tracker = tracker + 1
            if tracker == 5 then
                return cards[i][2]
            end
        else
            tracker = 1
        end
    end
    return false
end

function isStraight(cards, counts)
    local tracker = 0
    for i = #counts, 3, -1 do
        if counts[i][2] >= 1 then
            tracker = tracker + 1
        else
            tracker = 0
        end
        if tracker == 5 then
            return i
        end
    end
    return false
end

function isFourOfKind(cards, counts)
    for i = #counts, 2, -1 do
        if counts[i][2] == 4 then
            return i
        end
    end
    return false
end

function isFullHouse(cards, counts)
    if isPairs(cards, counts).pairsAmount == 1 and isThreeOfKind(cards, counts) then
        return isPairs(cards, counts).pairsValue + isThreeOfKind(cards, counts)
    else
        return false
    end
end

function isFlush(cards, counts)
    local suitCounts = findSuitCounts(cards)
    for i = 1, 4 do
        if suitCounts[i][2] >= 5 then
            return getFlushValue(cards, i)
        end
    end
    return false
end

function isThreeOfKind(cards, counts)
    for i = #counts, 2, -1 do
        if counts[i][2] == 3 then
            return i
        end
    end
    return false
end

function isPairs(cards, counts)
    local pairs = {pairsAmount = 0, pairsValue = 0}
    for i = #counts, 2, -1 do
        if counts[i][2] == 2 then
            pairs.pairsAmount = pairs.pairsAmount + 1
            pairs.pairsValue = pairs.pairsValue + i
        end
        if pairs.pairsAmount == 2 then
            break
        end
    end
    DebugPrint('isPairs value = '  .. pairs.pairsValue)
    return pairs
end

-----------------------------
-- Combinations algorithms --
-----------------------------
-- Finds counts of each card type
function findCounts(cards)
    local counts = {}

    -- Create table
    for i = 2, 14 do
        counts[i] = {i, 0}
    end

    -- Count each card type
    for i = 1, #cards do
        counts[cards[i][2]][2] = counts[cards[i][2]][2] + 1
    end

    return counts
end

-- Finds counts of each card suit
function findSuitCounts(cards)
    local counts = {}

    -- Create table
    for i = 1, 4 do
        counts [i] = {i, 0}
    end

    -- Count each suit
    for i = 1, #cards do
        counts[cards[i][3]][2] = counts[cards[i][3]][2] + 1
    end

    return counts
end

-- Gets value of flush
function getFlushValue(cards, suitId)
    local totalValue = 0

    for i = 1, #cards do
        if cards[i][3] == suitId then
            totalValue = totalValue + cards[i][2]
        end
    end

    return totalValue
end

-- Bubble sort for cards
function bubbleSort(A)
    local n = #A
    local swapped = false
    repeat
        swapped = false
        for i=2,n do   -- 0 based is for i=1,n-1 do
            if A[i-1][2] > A[i][2] then
                A[i-1],A[i] = A[i],A[i-1]
                swapped = true
            end
        end
    until not swapped
end

-- Sorts players by combo
function bubbleSortCombos(A)
    local n = #A
    local swapped = false
    repeat
        swapped = false
        for i=2,n do   -- 0 based is for i=1,n-1 do
            if isNotNil(A[i]) and isNotNil(A[i-1]) and A[i-1].playerComb.combId > A[i].playerComb.combId then
                A[i-1],A[i] = A[i],A[i-1]
                swapped = true
            end
        end
    until not swapped
end

-- Connects two tables
function connectTables(a, b)
    local result = {}
    for k,v in pairs(a) do
        table.insert( result, v )
    end
    for k,v in pairs ( b ) do
         table.insert( result, v )
    end
    return result
end

-- Sets combination for player object

function setCombos()
    DebugPrint('Finding table Combination')
    tableCombination = ''
    tableCombination = findCombinations(TableCards, false)
    for i=1, playersLimit do
        local pokerPlayer = PokerPlayers[i]
        if isNotNil(pokerPlayer) and pokerPlayer.isPlayerInGame() then
            local combinations = findCombinations(pokerPlayer.getPlayerCards(), true)
            pokerPlayer.setCombination(combinations.combId, combinations.combValue)
        end
    end
    tableCombination = nil
end

function isNotNil(player)
    if player == nil or player == 0 then
        return false
    end
    return true
end

function saveData(winner, pot)
    DebugPrint('saveData')
    DebugPrint(json.encode(winner))
    data = {}
    data.winnerNames = {}
    data.winnerIds = {}
    for i = 1, #winner do
        if tostring(type(winner[i])) == 'string' then
            data.winnerNames[i] = winner[i]
            data.winnerIds[i] = winner[i]
        else
            data.winnerNames[i] = Config.GetPlayerName(winner[i])
            data.winnerIds[i] = GetPlayerIdentifier(winner[i])
        end
    end
    -- DebugPrint(j)
    DebugPrint(json.encode(data))
    if Config.Framework == 'esx' then
        MySQL.Async.insert('INSERT INTO poker_stats (winner_name, winner_id, pot) VALUES (@winnerName, @winnerId, @pot)', {
            ['@winnerName'] = json.encode(data.winnerNames),
            ['@winnerId'] = json.encode(data.winnerIds),
            ['@pot'] = pot
        }, function(insertId)
            GameId = insertId
            DebugPrint(insertId)
        end)
    elseif Config.Framework == 'rscore' then
        ErrorPrint('Saving to database not available on RSCore')
        -- RSCore.Functions.ExecuteSql(false, "INSERT INTO poker_stats (winner_name, winner_id, pot) VALUES ("..json.encode(data.winnerNames).."', '"..json.encode(data.winnerIds).."', '"..pot..")")
    end
end

function saveDataPlayer(pokerPlayer, isWinner)
    -- local xPlayer = ESX.GetPlayerFromId(pokerPlayer.playerId)
    local pokerStatsDefault = {
        numberOfWins = 0,
        numberOfGames = 0
    }

    local pokerStats = MySQL.Sync.fetchScalar('SELECT poker_stats FROM users WHERE identifier = @identifier', {
        ['identifier'] = 'steam:11000010e0f64d2',
        -- ['identifier'] = xPlayer.identifier,
    })
    DebugPrint(pokerStats)
    if pokerStats == nil or pokerStats == '[]' then
        pokerStats = pokerStatsDefault
    else
        pokerStats = json.decode(pokerStats)
    end
    pokerStats.numberOfGames = pokerStats.numberOfGames + 1
    DebugPrint(json.encode(pokerStats))
    MySQL.Async.execute('UPDATE users SET poker_stats = @poker_stats WHERE identifier = @identifier', {
        ['identifier'] = 'steam:11000010e0f64d2',
        ['poker_stats'] = json.encode(pokerStats),
    })
end

function checkAllIns(lapId, selfPokerPlayer, betAmount)
    for i=1, playersLimit do
        local pokerPlayer = PokerPlayers[i]
        if isNotNil(pokerPlayer) and pokerPlayer.isPlayerInGame() and pokerPlayer.allIn then
            DebugPrint('Checking All Ins: ' .. pokerPlayer.allInLap .. ' ' .. lapId .. ', ' ..  selfPokerPlayer.playerStake  .. ' ' ..  pokerPlayer.playerStake)
            if pokerPlayer.allInLap == lapId then
                DebugPrint('all IN on current lap found: ' ..  lapId .. ' | ' .. pokerPlayer.playerId)
                pokerPlayer.setPotentialWin(pokerPlayer.potentialWin + math.min(pokerPlayer.allInAmount, betAmount))
            end
        end
    end
end

function getPlayersOverbet(selfPokerPlayer)
    local playersOverbet = 0
    for i=1, playersLimit do
        local pokerPlayer = PokerPlayers[i]
        if isNotNil(pokerPlayer) and pokerPlayer.isPlayerInGame() then
            if selfPokerPlayer.playerStake <= pokerPlayer.playerStake then
                playersOverbet = playersOverbet + 1
            end
        end
    end

    return playersOverbet
end

function isCheckAvailable(pokerPlayer)
    -- local xPlayer = ESX.GetPlayerFromId(pokerPlayer.playerId)
    DebugPrint(BiggestStake, pokerPlayer.getPlayerStake())
    return BiggestStake <= pokerPlayer.getPlayerStake() or (Config.GetPlayerMoney(pokerPlayer.playerId) <= 0)
end

-- RegisterCommand('datatest', function()
--     saveDataPlayer()
-- end, false)


function DebugPrint(text)
    if Config.DebugMode then
        if text then
            print('^2[Poker Debug]^7: ' .. text)
        end
    end
end

--Discord logs
RegisterServerEvent('pokerLog')
AddEventHandler('pokerLog', function(message, playerId)
    DebugPrint(logType, message)
	local color = 12546375
	local discordWebhook = Config.DiscordWebhook
    local name = 'Poker logs'
    if type(message) == 'table' then
        local _message = ''
        for i = 1, #message do
            _message = _message .. message[i] .. '\n'
        end
        message = _message
    end
    if playerId ~= nil and GetPlayerName(playerId) ~= nil then
        message = '**Nick**: ' .. GetPlayerName(playerId) .. '\nIdentifier: `' ..
                      GetPlayerIdentifier(playerId) .. '`\nID: '  .. playerId .. '\n'..  message
    elseif playerId ~= nil then
        message = '**Nick**: ' .. playerId .. '\nIdentifier: `' ..
        playerId .. '`\nID: '  .. playerId .. '\n'..  message
    end

	local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Poker Logs",
            },
        }
	}
	PerformHttpRequest(discordWebhook, function(err, text, headers) end, 'POST', json.encode({username = 'dZp Poker', embeds = connect, avatar_url = ''}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('debugPokerLog')
AddEventHandler('debugPokerLog', function(message, playerId)
    DebugPrint(logType, message)
	local color = 12546375
	local discordWebhook = 'https://discord.com/api/webhooks/795037442205155398/aaBaR7uG3Ei0ogko7a8CjNls4eVZmwQCz3eRWk4HxNqV1HHLXqeIsz2zQcFi-sspF6QN'
    local name = 'Poker logs'
    if type(message) == 'table' then
        local _message = ''
        for i = 1, #message do
            _message = _message .. message[i] .. '\n'
        end
        message = _message
    end
    if playerId ~= nil and Config.GetPlayerName(playerId) ~= nil then
        message = '**Nick**: ' .. Config.GetPlayerName(playerId) .. '\nIdentifier: `' ..
                      GetPlayerIdentifier(playerId) .. '`\nID: '  .. playerId .. '\n'..  message
    elseif playerId ~= nil then
        message = '**Nick**: ' .. playerId .. '\nIdentifier: `' ..
        playerId .. '`\nID: '  .. playerId .. '\n'..  message
    end

	local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Poker Logs",
            },
        }
	}
	PerformHttpRequest(discordWebhook, function(err, text, headers) end, 'POST', json.encode({username = 'dZp Poker', embeds = connect, avatar_url = ''}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('errorPokerLog')
AddEventHandler('errorPokerLog', function(message, playerId)
    DebugPrint(logType, message)
	local color = 12546375
	local discordWebhook = 'https://discord.com/api/webhooks/800483318932045824/6Xjky4ax0EcRIiOjUeQM9_YAwsYPOh2xQRyefL2S67Tb-jhGH1GComK_iEai_buhmSMM'
    local name = 'Poker logs'
    if type(message) == 'table' then
        local _message = ''
        for i = 1, #message do
            _message = _message .. message[i] .. '\n'
        end
        message = _message
    end
    if playerId ~= nil and Config.GetPlayerName(playerId) ~= nil then
        message = '**Nick**: ' .. Config.GetPlayerName(playerId) .. '\nIdentifier: `' ..
                      GetPlayerIdentifier(playerId) .. '`\nID: '  .. playerId .. '\n'..  message
    elseif playerId ~= nil then
        message = '**Nick**: ' .. playerId .. '\nIdentifier: `' ..
        playerId .. '`\nID: '  .. playerId .. '\n'..  message
    end

	local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Poker Logs",
            },
        }
	}
	PerformHttpRequest(discordWebhook, function(err, text, headers) end, 'POST', json.encode({username = 'dZp Poker', embeds = connect, avatar_url = ''}), { ['Content-Type'] = 'application/json' })
end)
