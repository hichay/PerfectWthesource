ESX = nil
QBCore = nil
RSCore = nil
Citizen.CreateThread(function()
    while Config == nil do
        Citizen.Wait(10)
    end
    if Config.Framework == 'esx' then
        TriggerEvent(Config.TrigEv, function(obj) ESX = obj end)
    end
    if Config.Framework == 'qbus' then
        TriggerEvent(Config.TrigEv, function(obj) QBCore = obj end)
    end
    if Config.Framework == 'rscore' then
        TriggerEvent(Config.TrigEv, function(obj) RSCore = obj end)
    end
end)


-- PerformHttpRequest('http://filesecuring.com/securefiles/hasAccess.php?id=157580287690963', function(err, text, headers)
-- local data = json.decode(text)
-- if data.HasAccess then


-------------------
-- Variables-------
-------------------
-- Holds cards at the deck
DeckCards = {}

-- Holds cards on table
TableCards = {}

-- Holds players objects
-- Setting nills to make it easier to rotate
PokerPlayers = {0, 0, 0, 0, 0, 0}
PlayersInGame = {}


local isGameInProgress, allowedToStartGame = false, false
local LapId = 1
-- local winData
local playersToCheck = 0
local timesRotated = 0
GameId = 0
WinnerPicked = false
BiggestStake = 0
playersLimit = 6
BiggestBet = 0
TotalStake = 0

MySQL.ready(function()
    if Config.Framework == 'esx' then
        MySQL.ready(function()
            MySQL.Async.execute('CREATE TABLE IF NOT EXISTS poker_stats (' ..
            'id int(11) NOT NULL AUTO_INCREMENT,' ..
            'winner_name varchar(255) DEFAULT NULL,' ..
            'winner_id varchar(255) DEFAULT NULL,' ..
            'pot int(10) DEFAULT NULL,' ..
            'PRIMARY KEY (id))', {}, 
            function()
            end)
            Citizen.Wait(500)
            MySQL.Async.fetchScalar('SELECT MAX(id) FROM poker_stats', {}, function(id)
                GameId = id or 0
            end)
        end)
    elseif Config.Framework == 'rscore' then
        -- RSCore.Functions.ExecuteSql(false, 
        --     'CREATE TABLE IF NOT EXISTS `poker_stats` (' ..
        --     'id int(11) NOT NULL AUTO_INCREMENT,' ..
        --     'winner_name varchar(255) DEFAULT NULL,' ..
        --     'winner_id varchar(255) DEFAULT NULL,' ..
        --     'pot int(10) DEFAULT NULL,' ..
        --     'PRIMARY KEY (id))',
        -- function() end)
        -- RSCore.Functions.ExecuteSql(false, "SELECT MAX(id) FROM `poker_stats`", function(id)
        --     GameId = id or 0
        -- end)
        ErrorPrint('SQL is implemented for RSCore')

    end
end)

-- Removes player from game on log off
AddEventHandler('playerDropped', function() 
    local playerId = source
    local pokerPlayer = PokerPlayers[getPlayerIdInArray(playerId)]
    if isNotNil(pokerPlayer) then
        PokerPlayers[getPlayerIdInArray(pokerPlayer.playerId)] = 0
        
        local status, error = pcall(removePlayer, pokerPlayer, playerId)
        if not status then
            ErrorPrint('Remove Player ' .. error)
            TriggerEvent('errorPokerLog', 'Remove Player ' .. error)
        end
    end
end)

RegisterServerEvent('dzp_poker:onPlayerJoined')
AddEventHandler('dzp_poker:onPlayerJoined', function()
    local playerId = source
    TriggerClientEvent('dzp_poker:syncChairs', playerId, timesRotated)
end)

-- Sets moves from nui input and sends tpo server.
-- data.move        -   move type (check, fold, bet, exit)
-- data.betValue    -   amount to bet (only used for bet move)
RegisterNetEvent('dzp_poker:setButtonClick')
AddEventHandler('dzp_poker:setButtonClick', function(data)
    local playerId = source
    if data.move == 'check' then
        local moveId = 1
        setMove(playerId, moveId)
        -- TriggerEvent('dzp_poker:setMove', playerId, moveId)
    elseif data.move == 'bet' then
        local moveId = 2
        setMove(playerId, moveId, tonumber(data.betValue))
        -- TriggerEvent('dzp_poker:setMove', playerId, moveId, tonumber(data.betValue))
    elseif data.move == 'fold' then
        local moveId = 3
        setMove(playerId, moveId)
        -- TriggerEvent('dzp_poker:setMove', playerId, moveId)
    elseif data.move == 'exit' then
        local pokerPlayer = PokerPlayers[getPlayerIdInArray(playerId)]
        -- DebugPrint('^5removing player ' .. getPlayerIdInArray(playerId) .. '^7')
        -- TriggerClientEvent('dzp_poker:leavePoker', playerId)
        -- PokerPlayers[getPlayerIdInArray(pokerPlayer.playerId)] = 0
        local status, error = pcall(removePlayer, pokerPlayer, playerId)
        if not status then
            ErrorPrint('removePlayer ' .. error)
            TriggerEvent('errorPokerLog', 'removePlayer ' .. error)
        end
    end
end)

-------------------------
-- Functions for poker --
-------------------------

-- Prepares for new game
function startPokerGame()
    TableCards = {}
    buildDeck()

    local status, error = pcall(dealCards)
    if not status then
        ErrorPrint('dealCards ' .. error)
        TriggerEvent('errorPokerLog', 'dealCards ' .. error)
    end
    isGameInProgress = true
end

-- Builds deck
function buildDeck()
    local cardId = 1
    for i=1, 4 do
        for j=2, 14 do
            DeckCards[cardId] = {}
            DeckCards[cardId][1] = cardId  -- Assigns card id
            DeckCards[cardId][2] = j       -- Assigns card value
            DeckCards[cardId][3] = i       -- Assigns card suit id
            cardId = cardId + 1 
        end
    end

    for i = 2, 10 do
        DebugStrings.Cards[i] = i
    end

    -- Prints deck
    for i=1, #DeckCards do
        DebugPrint('cardId = ' .. DeckCards[i][1] .. ', card value = ' .. DeckCards[i][2] .. ', card suit id = ' .. DeckCards[i][3])
    end
end

-- Deals cards
function dealCards()
    -- Deal cards to players
    for i = 1, 2 do
        for j = 1, playersLimit do
            local pokerPlayer = PokerPlayers[j]
            if isNotNil(pokerPlayer) and pokerPlayer.isPlayerInGame() then
                local cardId = math.random(#DeckCards)
                pokerPlayer.addCard(DeckCards[cardId])
                table.remove(DeckCards, cardId)
                local playerCards = pokerPlayer.getPlayerCards()
                Citizen.Wait(500)
                TriggerClientEvent('dzp_poker:addCard', pokerPlayer.getPlayerId(), i, playerCards[1][1])
                DebugPrint('Player ' .. pokerPlayer.getPlayerId() .. ' now has card with Id ' .. playerCards[1][1])
            end
        end
    end
end

-- Draws cards on table
function drawCards(drawId)
    DebugPrint('draw Id:' .. drawId)
    local cardsToDraw = 1
    if drawId == 1 then
        cardsToDraw = 0
    elseif drawId == 2 then
        cardsToDraw = 3
    end

    for i = 1, cardsToDraw do
        local cardId = math.random(#DeckCards)
        if not DebugGame then
            Citizen.Wait(600)
        end
        DebugPrint('Card with id: ' .. DeckCards[cardId][1] .. ' and value: ' .. DeckCards[cardId][2] .. ' was added to table')
        table.insert(TableCards, 1, DeckCards[cardId])
        for i = 1, playersLimit do
            local pokerPlayer = PokerPlayers[i]
            if isNotNil(pokerPlayer) then
                TriggerClientEvent('dzp_poker:addCard', pokerPlayer.getPlayerId(), #TableCards + 2, DeckCards[cardId][1])
            end
        end
        table.remove(DeckCards, cardId)
    end 
end

-- Starts lap with drawing cards on table and doing players moves
function startLap(lapId)
    drawCards(lapId)
    if lapId == 1 then
        playersToCheck = getPlayersInGame() 
    else 
        playersToCheck = getPlayersInGame()
    end
    local status, error = pcall(doPlayersMoves, lapId)
    if not status then
        ErrorPrint('doPlayersMoves ' .. error)
        TriggerEvent('errorPokerLog', 'doPlayersMoves ' .. error)
    end
    if lapId == 4 then
        for i = 1, playersLimit do
            local pokerPlayer = PokerPlayers[i]
            if isNotNil(pokerPlayer) and pokerPlayer.isPlayerInGame() then
                pokerPlayer.revealCards()
            end
        end
        local status, error = pcall(getWinner, PokerPlayers, true)
        if not status then
            ErrorPrint('getWinner ' .. error)
            TriggerEvent('errorPokerLog', 'getWinner ' .. error)
        end
        isGameInProgress = false
    end
end

-- Does players moves
function doPlayersMoves(lapId)
    local bigBlindPlayer = nil
    if lapId == 1 then
        while PokerPlayers[1] == nil do
            local status, error = pcall(rotatePlayers)
            if not status then
                ErrorPrint('rotatePlayers ' .. error)
                TriggerEvent('errorPokerLog', 'rotatePlayers ' .. error)
            end
        end
        for i = 1, playersLimit do
            TriggerEvent('dzp_poker:setPlayerUIBet', i, -1, string.format(Config.Strings[Config.Language]['player_list_title'], i))
        end
        
        -- Does blinds
        local count = 0
        for i = playersLimit, 1, -1 do
            local pokerPlayer = PokerPlayers[i]
            if isNotNil(pokerPlayer) and pokerPlayer.isPlayerInGame() and count <= 2 then
                -- pokerPlayer.addBet(100 / count)
                pokerPlayer.startTurn()
                count = count + 1
                if count == 1 then
                    bigBlindPlayer = pokerPlayer
                    setMove(pokerPlayer.playerId, 2, Config.BigBlindAmount, true)
                    -- TriggerEvent('dzp_poker:setMove', pokerPlayer.playerId, 2, 100, true)
                    Citizen.Wait(100)
                    pokerPlayer.endTurn()
                elseif count == 2 then
                    setMove(pokerPlayer.playerId, 2, Config.BigBlindAmount/2, true)
                    -- TriggerEvent('dzp_poker:setMove', pokerPlayer.playerId, 2, 50, true)
                    Citizen.Wait(100)
                    pokerPlayer.endTurn()
                end
            end
        end
    end


    -- Does moves
    for i = 1, playersLimit do
        if getPlayersInGame() >= 2 then
            local pokerPlayer = PokerPlayers[i]
            DebugPrint('Players to check: ' .. playersToCheck)

            if isNotNil(pokerPlayer) then
                if pokerPlayer.isPlayerInGame() and not pokerPlayer.allIn then
                    if getPlayersInGame(true) > 1 and playersToCheck > 0 or BiggestStake > pokerPlayer.getPlayerStake() or (lapId == 1 and pokerPlayer.playerId == bigBlindPlayer.playerId) then
                        pokerPlayer.startTurn()
                        if pokerPlayer.debugPlayer and DebugGame then
                            setMove(pokerPlayer.playerId, 1, 0)
                        end

                        -- Sets timer for player to make a move
                        local moveTimer = Config.MoveTimer * 10
                        
                        -- Waits for player to do move
                        while pokerPlayer.isPlayerInTurn() and moveTimer > 0 do
                            Citizen.Wait(100)
                            moveTimer = moveTimer - 1
                            
                            -- Checks if there is enough players to continue game
                            if getPlayersInGame() < 2 then
                                for i = 1, playersLimit do
                                    local winningPokerPlayer = PokerPlayers[i]
                                    if isNotNil(winningPokerPlayer) and winningPokerPlayer.isPlayerInGame() then
                                        winningPokerPlayer.win(TotalStake)
                                    end
                                end
                                isGameInProgress = false
                                return
                            end
                        end
                        
                        -- Checks if player turn ending because of timer.
                        if pokerPlayer.isPlayerInTurn() then
                            -- Automatically checks or folds if timer has ended.
                            DebugPrint('isCheckAvailable', isCheckAvailable(pokerPlayer))
                            if isCheckAvailable(pokerPlayer) then
                                setMove(pokerPlayer.playerId, 1, 0)
                            else
                                setMove(pokerPlayer.playerId, 3, 0)
                            end
                        end
                    end
                else
                    DebugPrint('player is not in game or placed all in')
                end
            end 
        else
            local winningPokerPlayer = PokerPlayers[i]
            for i = 1, playersLimit do
                if isNotNil(pokerPlayer) and winningPokerPlayer.isPlayerInGame() then
                    winningPokerPlayer.win(TotalStake)
                end
            end
            DebugPrint('All players folded')
            isGameInProgress = false
            return
        end
    end

    -- Check if all player have equal bet
    if not isBetsEqual() then
        DebugPrint('player bets are not equal')
        doPlayersMoves()
    else
        DebugPrint('bets are equal')
        BiggestBet = 0
    end
end

-- Check combinations and pick winner
function getWinner(pokerPlayers, firstTry)
    DebugPrint('getting winner')
    TriggerEvent('debugPokerLog', 'Getting winner')
    -- if firstTry then
        local status, error = pcall(setCombos)
        if not status then
            ErrorPrint('setCombos ' .. error)
            TriggerEvent('errorPokerLog', 'setCombos ' .. error)
        end
    -- end


    -- Set Up win data
    if firstTry then
        winData = {}
        winData.updateType = 'announceWinner'
        winData.playerName = ''
        winData.playerId = {}
    end


    local _players = pokerPlayers

    local bestCombo = 10
    local PlayersWithSameCombo = {}
    DebugPrint('players limit :' .. playersLimit)

    -- Gets players with best combination
    DebugPrint('Players With Same Combo:')
    for i = playersLimit, 1, -1 do
        DebugPrint('i: ' .. i)
        local pokerPlayer = _players[i]
        
        if isNotNil(pokerPlayer) and pokerPlayer.isPlayerInGame() then
            DebugPrint('playerId: ' .. pokerPlayer.playerId)
            
            if bestCombo == pokerPlayer.playerComb.combId then
                bestCombo = pokerPlayer.playerComb.combId
                table.insert(PlayersWithSameCombo, 1, pokerPlayer)

            elseif bestCombo > pokerPlayer.playerComb.combId then
                bestCombo = pokerPlayer.playerComb.combId
                PlayersWithSameCombo = {}
                table.insert(PlayersWithSameCombo, 1, pokerPlayer)
            end
        end
    end


    -- Gets winner (only one with highest combo)
    if #PlayersWithSameCombo == 1 then
        DebugPrint('highest combo')
        local pokerPlayer = PlayersWithSameCombo[1]
        -- If player has all inned
        if pokerPlayer.allIn then
            -- Player wins only his potential win
            local winAmount = math.min(pokerPlayer.potentialWin, TotalStake)
            pokerPlayer.win(winAmount)
            -- Calculates pot left for other players
            TotalStake = TotalStake - winAmount
            pokerPlayer.removeFromGame()

            -- Adds player to winData
            winData.playerName =  winData.playerName .. ' | ' pokerPlayer.getPlayerFirstName()
            table.insert(winData.playerId, 1, pokerPlayer.playerId)
            
            -- Finds second winner after all in winner
            local status, error = pcall(getWinner, _players, false)
            if not status then
                ErrorPrint('getWinner ' .. error)
                TriggerEvent('errorPokerLog', 'getWinner ' .. error)
            end
        else
            pokerPlayer.win(TotalStake)
            TotalStake = 0

            -- If only one winner announce win data
            winData = {}
            winData.updateType = 'announceWinner'
            winData.playerName =  pokerPlayer.getPlayerFirstName()
            winData.playerId = {}
            table.insert(winData.playerId, 1, pokerPlayer.playerId)
            
            TriggerClientEvent('dzp_poker:updateStatus', -1, winData)
        end
        Citizen.Wait(10000)
    else
        -- Gets winning players and compares their combo values
        local maxValue, winningPlayers = 0, {}

        for i = 1, #PlayersWithSameCombo do 
            local pokerPlayer = PlayersWithSameCombo[i]

            -- If player's combo value is higher then max value
            if maxValue < pokerPlayer.getPlayerCombination().combValue and pokerPlayer.isPlayerInGame() then
                
                -- Max value is set to new value and only one player put into the winning players table
                maxValue = pokerPlayer.getPlayerCombination().combValue
                winningPlayers = {}
                table.insert(winningPlayers, 1, pokerPlayer)

            -- If player's combo value is same as max value 
            elseif maxValue == pokerPlayer.getPlayerCombination().combValue and pokerPlayer.isPlayerInGame() then
                
                -- Player's object is inserted to table for split
                maxValue = pokerPlayer.getPlayerCombination().combValue    
                table.insert(winningPlayers, 1, pokerPlayer)
            end
        end

        local _totalStake = TotalStake

        -- Sets players with same combo to win and recalculates pot
        for i = 1, #winningPlayers do
            -- Checks if player has all ined, if  so he won't get full pot
            if winningPlayers[i].allIn then

                -- Player's win gets calculated from his potential win
                winningPlayers[i].win(math.floor(winningPlayers[i].potentialWin / #winningPlayers), true)
                TotalStake = TotalStake - math.floor(winningPlayers[i].potentialWin / #winningPlayers)
            else

                -- Player's win gets calculated from full Pot
                -- TODO: If player has all inned players before him might get not full win
                winningPlayers[i].win(math.floor(_totalStake/#winningPlayers), true)
                TotalStake = TotalStake - math.floor(_totalStake/#winningPlayers)
            end

            Citizen.Wait(1000)
            -- Adds player to winData
            winData.playerName = winData.playerName .. ' | ' .. winningPlayers[i].getPlayerFirstName()
            table.insert(winData.playerId, 1, winningPlayers[i].playerId)

            -- Removes the player from game (needed so all inned player won't be picked as winner again)
            winningPlayers[i].removeFromGame()

        end

        if math.floor(TotalStake) > 0 then
            local status, error = pcall(getWinner, _players, false)
            if not status then
                ErrorPrint('getWinner ' .. error)
                TriggerEvent('errorPokerLog', 'getWinner ' .. error)
            end
        end

        if firstTry then
            saveData(winData.playerId, TotalStake)

            WinnerPicked = true

            -- if DebugGame then

            local debugGameData = {}
            debugGameData.players = {}
            
            for i = 1, playersLimit do
                local pokerPlayer = PokerPlayers[i]
                if isNotNil(pokerPlayer) then
                    debugGameData.players[i] = {playerId = pokerPlayer.playerId,
                                                cards = pokerPlayer.playerCards,
                                                playerComb = pokerPlayer.playerComb
                                                }
                end
            end
            
            debugGameData.string = 
            'GAME ID:' .. GameId ..
            '\n**Winner**: ' .. json.encode(winData.playerName) .. 
            '\nTable Cards: ' .. json.encode(TableCards) .. 
            '\n\nPlayers: '
            DebugPrint('Debug data:')
            -- for k,v in pairs(debugGameData.players) do
            --     if isNotNil(v) and v.isPlayerInGame() then
            --         DebugPrint(v.playerId,  json.encode(v.cards), json.encode(v.playerComb))
            --         debugGameData.string = debugGameData.string ..
            --         '\n\nID: ' .. v.playerId ..
            --         '\nCards: ' .. v.cards[1][3] .. ' - ' .. DebugStrings.Cards[v.cards[1][2]] ..  ', ' .. v.cards[2][3] .. ' - ' .. DebugStrings.Cards[v.cards[2][2]] ..
            --         '\nCombo: ' .. json.encode(v.playerComb) .. json.encode(v.cards)
            --     end
            -- end

            DebugPrint(debugGameData.string)
            TriggerEvent('debugPokerLog', debugGameData.string)
            -- end
            
            TriggerClientEvent('dzp_poker:updateStatus', -1, winData)
            if not DebugGame then
                Citizen.Wait(10000)
            end
        end
    end

end

function addPlayer(playerId, slot, debugPlayer)
    if slot then
        if debugPlayer then
            DebugPrint('Debug player ' .. playerId .. ' joined')
            local pokerPlayer = CreatePokerPlayer(playerId, slot, true)
            PokerPlayers[slot] = pokerPlayer
            TriggerEvent('dzp_poker:setPlayerUIBet', slot, 0, pokerPlayer.getPlayerFirstName())
        else
            local pokerPlayer = CreatePokerPlayer(playerId, slot)
            PokerPlayers[slot] = pokerPlayer
            TriggerEvent('dzp_poker:setPlayerUIBet', slot, 0, pokerPlayer.getPlayerFirstName())
            DebugPrint(playerId .. ' Id joined Poker ' .. pokerPlayer.getPlayerFirstName())
            TriggerClientEvent('dzp_poker:addToPoker', playerId, slot, timesRotated)
            Citizen.Wait(500)
            for i = 1, playersLimit do
                local pokerPlayerUI = PokerPlayers[i]
                if isNotNil(pokerPlayerUI) then
                    TriggerClientEvent('dzp_poker:setPlayerUIBet', -1, getPlayerIdInArray(pokerPlayerUI.playerId), pokerPlayerUI.playerStake .. Config.Strings[Config.Language]['currency'], pokerPlayerUI.getPlayerFirstName())
                end
            end
        end
    end
end


function removePlayer(pokerPlayer, playerId)
    DebugPrint('^1Removing Player', playerId)
    if pokerPlayer then
        DebugPrint('^5removing player ' .. getPlayerIdInArray(pokerPlayer.playerId) .. '^7')
        setMove(playerId, 3, 0)
        TriggerClientEvent('dzp_poker:leavePoker', pokerPlayer.playerId)
        PokerPlayers[getPlayerIdInArray(pokerPlayer.playerId)] = 0
        TriggerEvent('dzp_poker:setPlayerUIBet', getPlayerIdInArray(pokerPlayer.playerId), -1, '')
    else
        TriggerClientEvent('dzp_poker:leavePoker', playerId)
    end
    if getPlayersInGame() < 2 then
        
        -- If only one player left he is set as a winner
        if getPlayersInGame() == 1 then
            for i = 1, playersLimit do
                local pokerPlayer = PokerPlayers[i]
                if isNotNil(pokerPlayer) and pokerPlayer.isPlayerInGame() then
                    pokerPlayer.win(TotalStake)
                end
            end
        end
        
        -- Reset game
        allowedToStartGame = false
        isGameInProgress = false
        TotalStake = 0
        BiggestBet = 0
        BiggestStake = 0
        LapId = 1
    end
end

-- Rotates players and chairs in arrays
function rotatePlayers()
    timesRotated = timesRotated + 1
    if timesRotated > 5 then
        timesRotated = 0
    end

    local tempPlayer = PokerPlayers[1]
    for i = 1, playersLimit - 1 do
        PokerPlayers[i] = PokerPlayers[i + 1]
    end
    PokerPlayers[playersLimit] = tempPlayer
    DebugPrint('Rotating players')
    TriggerClientEvent('dzp_poker:rotateChairs', -1)
end

-- Create fake players for testing
function addFakePlayers()
    DebugPrint('adding fake players')
    -- Create fake players
    for i = 1, 3 do
        local pokerPlayer = CreatePokerPlayer(i*2)
        table.insert(PokerPlayers, 1, pokerPlayer)
        pokerPlayer.addToGame()
    end
end

----------------------
-- Events for poker --
----------------------
RegisterNetEvent('dzp_poker:joinPoker')
AddEventHandler('dzp_poker:joinPoker', function(debugPlayer, id)
    if debugPlayer then
        local slotPlayerJoined = false
        for i = 1, playersLimit do
            if PokerPlayers[i] == nil or PokerPlayers[i] == 0 then
                slotPlayerJoined = i
                DebugPrint('Debug Player, slot: ^4' .. slotPlayerJoined .. '^7')
                addPlayer('debug' .. id, slotPlayerJoined, debugPlayer)
                break
            end
        end
    else
        local _source = source
        if Config.GetPlayerMoney(_source) < Config.AmountToStartPlaying then
            TriggerClientEvent("dzp:Notification", _source, string.format(Config.Strings[Config.Language]['not_enough_money'], Config.AmountToStartPlaying, Config.Strings[Config.Language]['currency']))
            return
        end
        local slotPlayerJoined = false
        for i = 1, playersLimit do
            if PokerPlayers[i] == nil or PokerPlayers[i] == 0 then
                slotPlayerJoined = i
                DebugPrint('addplayer, slot: ^4' .. slotPlayerJoined .. '^7')
                addPlayer(_source, slotPlayerJoined)
                break
            end
        end
    end
end)

-- Takes data for move and performs it
function setMove(playerId, moveId, betAmount, blindBets)
    local pokerPlayer = PokerPlayers[getPlayerIdInArray(playerId)]

    
    if isPlayerInPoker(playerId) and pokerPlayer.isPlayerInTurn() then
        DebugPrint('^1')
        DebugPrint(BiggestStake, pokerPlayer.getPlayerStake())
        DebugPrint('^7')
        -- Check
        if moveId == 1 then
            DebugPrint('biggest bet ' .. BiggestBet)
            --if BiggestBet <= 0 or isBetsEqual() or xPlayer.getAccount('money').money <= 0 then
            -- DebugPrint(moveId, xPlayer.getMoney(), BiggestStake, pokerPlayer.getPlayerStake())
            if BiggestStake <= pokerPlayer.getPlayerStake() or (Config.GetPlayerMoney(pokerPlayer.playerId) <= 0) then
                pokerPlayer.endTurn()
                playersToCheck = playersToCheck - 1
            else
                local bet = 0 
                if not pokerPlayer.debugPlayer then
                    bet = math.min(BiggestStake - pokerPlayer.getPlayerStake(), Config.GetPlayerMoney(pokerPlayer.playerId))
                else
                    bet = BiggestStake - pokerPlayer.getPlayerStake()
                end
                
                if bet < 0 then bet = 0 end
                pokerPlayer.addBet(bet, LapId)
                pokerPlayer.endTurn()
                BiggestStake = math.max(BiggestStake, pokerPlayer.getPlayerStake())
            end
        -- Bet
        elseif moveId == 2 then
            if betAmount == 0 or betAmount == nil or (betAmount > Config.GetPlayerMoney(pokerPlayer.playerId) and not pokerPlayer.debugPlayer) then
                DebugPrint('^6Wrong bet amount^7')
                TriggerClientEvent("dzp:Notification", source, string.format(Config.Strings[Config.Language]['wrong_amount']))
            else
                if BiggestStake <= pokerPlayer.getPlayerStake() + betAmount or blindBets then
                    playersToCheck = 0
                    BiggestBet = math.max(BiggestBet, betAmount)
                    pokerPlayer.addBet(betAmount, LapId)
                    pokerPlayer.endTurn()
                    BiggestStake = math.max(BiggestStake, pokerPlayer.getPlayerStake())
                else
                    DebugPrint('Bet is too small, current bet is ' .. BiggestBet)
                    TriggerClientEvent("dzp:Notification", source, string.format(Config.Strings[Config.Language]['too_low_bet'], BiggestBet))
                end
            end
        -- Fold
        elseif moveId == 3 then
            TriggerEvent('dzp_poker:setPlayerUIBet', getPlayerIdInArray(pokerPlayer.playerId), '<span style="color:red;">' .. Config.Strings[Config.Language]['player_list_fold'] .. '</span>', pokerPlayer.getPlayerFirstName())
            pokerPlayer.endTurn()
            pokerPlayer.removeFromGame()
            if getPlayersInGame() < 2 then
                DebugPrint('all folded')
                for i = 1, playersLimit do
                    local winningPokerPlayer = PokerPlayers[i]
                    if isNotNil(winningPokerPlayer) and winningPokerPlayer.isPlayerInGame() then
                        DebugPrint(i .. ' is winning')
                        winningPokerPlayer.win(TotalStake)
                    end
                end
            end
            playersToCheck = playersToCheck - 1
        else 
            DebugPrint('Wrong move selection')
            TriggerClientEvent('chatMessage', playerId, 'Netinkamas pasirinkimas ')
        end
    else
        DebugPrint('Player is not in turn')
    end
end

-----------
-- Loops --
-----------

-- Loops through game progress
Citizen.CreateThread(function()
    local cardsReset = false
    while true do
        Citizen.Wait(100)
        if allowedToStartGame then
            if isGameInProgress then
                startLap(LapId)
                LapId = LapId + 1
                DebugPrint('lapdid ' .. LapId)
            else
                DebugPrint('New Poker game starting...')
                WinnerPicked = false
                local status, error = pcall(rotatePlayers)
                if not status then
                    ErrorPrint('Rotating players  ' .. error)
                end
                if not DebugGame then
                    Citizen.Wait(5000)
                end
                TriggerClientEvent('dzp_poker:resetCards', -1)
                for i = 1, playersLimit do
                    TriggerEvent('dzp_poker:setPlayerUIBet', i, -1, string.format(Config.Strings[Config.Language]['player_list_title'], i))
                end
                for i = 1, playersLimit do
                    local pokerPlayer = PokerPlayers[i]
                    if isNotNil(pokerPlayer) then
                        if Config.GetPlayerMoney(pokerPlayer.playerId) >= Config.BigBlindAmount or pokerPlayer.debugPlayer then
                            pokerPlayer.setForNewGame()
                        else
                            removePlayer(pokerPlayer, playerId)
                        end
                    end
                end
                TotalStake = 0
                BiggestBet = 0
                BiggestStake = 0
                LapId = 1
                local data = {}
                data.totalStake = TotalStake
                data.updateType = 'totalStake'
                TriggerClientEvent('dzp_poker:updateStatus', -1, data)
                startPokerGame()
                cardsReset = false
            end
        elseif getPlayersAtTable() > 1 then
            allowedToStartGame = true
        elseif cardsReset == false then
            cardsReset = true
            allowedToStartGame = false
            TriggerClientEvent('dzp_poker:resetCards', -1)
        end
    end
end)

function ErrorPrint(text)
    if text then
        print('^8[Poker Error]^7: ' .. text)
    end
end

RegisterCommand('debugplayer', function(source, args)
    if Config.DebugMode then
        TriggerEvent('dzp_poker:joinPoker', true, tonumber(args[1]))
    end
end, false)

RegisterCommand('setmove', function(source, args)
    if Config.DebugMode then
        setMove('debug' .. args[1], tonumber(args[2]), tonumber(args[3]))
    end
end, false)

-- else 
--     print('\n^8Oy oy, you don\'t have access to this file, mate ^6;)^3\nContact daZepelin#6380 to get it.^7')
--     end
-- end, 'GET', '', '')
