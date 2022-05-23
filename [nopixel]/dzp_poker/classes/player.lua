function CreatePokerPlayer(playerId, tableSlot, debugPlayer)
    local self = {}

    self.debugPlayer = debugPlayer

    self.playerId = playerId
    self.tableSlot = tableSlot
    self.source = playerId
    self.playerCards = {}
    self.playerStake = 0
    self.potentialWin = 0
    
    --[[ combId - 
    9 = high card
    8 = pair
    7 = two pairs
    6 = three of a kind
    5 = straight
    4 = flush
    3 = full house
    2 = four of a kind
    1 = straight flush
    ]]
    self.playerComb = {combId = 0, combValue = 0} 
    self.isInTurn = false
    self.isInGame = false
    self.allIn = false
    self.allInLap = nil
    self.allInAmount = 0

    self.getPlayerId = function()
        return self.playerId
    end

    self.getPlayerCards = function()
        return self.playerCards
    end

    self.getPlayerStake = function()
        return self.playerStake
    end

    self.getPlayerCombination = function()
        return self.playerComb
    end

    self.isPlayerInTurn = function()
        return self.isInTurn
    end

    self.isPlayerInGame = function()
        return self.isInGame
    end

    self.getTableSlot = function()
        return self.tableSlot
    end

    self.getPlayerFirstName = function()
        return Config.GetPlayerName(self.playerId)

    end

    -- Test method
    self.testMethod = function()
        print('Test method called for player id ' .. self.playerId)
    end

    self.addCard = function(cardData)
        table.insert(self.playerCards, 1, cardData)
    end

    self.resetPlayerCards = function()
        self.playerCards = {}
    end

    self.addBet = function(betAmount, lapId)
        if not self.debugPlayer then
            Config.RemovePlayerMoney(self.playerId, betAmount)
        end
        -- local xPlayer = ESX.GetPlayerFromId(self.playerId)
        -- if xPlayer then
        --     xPlayer.removeMoney(betAmount)
        -- end
        
        betAmount = betAmount + 0.0
        TotalStake = TotalStake + betAmount
        self.playerStake = self.playerStake + betAmount
        
        checkAllIns(lapId, self, betAmount)
        if Config.GetPlayerMoney(self.playerId) <= 0 and not self.debugPlayer then
            self.setAllIn(true)
            self.allInLap = lapId
            self.allInAmount = betAmount
        end
        
        
        local data = {}
        data.totalStake = TotalStake
        data.updateType = 'totalStake'
        TriggerClientEvent('dzp_poker:updateStatus', -1, data)
        TriggerClientEvent('dzp_poker:setPlayerUIBet', -1, getPlayerIdInArray(self.playerId), self.playerStake .. Config.Strings[Config.Language]['currency'], self.getPlayerFirstName())
        DebugPrint('GamdeId = ' .. GameId)
        TriggerEvent('pokerLog', {'🎲**Poker game id**: ' .. GameId, '**Bet**: ' .. betAmount .. '€', '**Current pot**: ' .. TotalStake .. '€'}, self.playerId)
    end
    
    self.resetPlayerStake = function()
        self.playerStake = 0
    TriggerClientEvent('dzp_poker:setPlayerUIBet', -1, getPlayerIdInArray(self.playerId), self.playerStake .. Config.Strings[Config.Language]['currency'], self.getPlayerFirstName())    
end

    self.resetPotentialWin = function()
        self.potentialWin = 0
    end

    self.setPotentialWin = function(amount)
        self.potentialWin =  amount
        DebugPrint('Potenial win of ' .. self.playerId .. ' ' .. self.potentialWin)
    end
    
    self.setCombination = function(combId, combValue)
        self.playerComb.combId = combId
        self.playerComb.combValue = combValue
    end
    
    self.resetPlayerComb = function()
        self.playerComb = {combId = 0, combValue = 0} 
    end

    self.win = function(moneyAmount, leaveStake)

        if not self.isInGame then
            ErrorPrint('Player id ' .. self.playerId .. ' WON without being in game!')
        end

        DebugPrint('Win Amount:' .. moneyAmount)
        DebugPrint('Potential win:' .. self.potentialWin)
        TriggerEvent('debugPokerLog', 'Win Amount: ' .. moneyAmount .. '\nPotential win:' .. self.potentialWin)

        if not WinnerPicked or leaveStake then
            WinnerPicked = true
            Config.AddPlayerMoney(self.playerId, moneyAmount)

            TriggerClientEvent('dzp_poker:setPlayerUIBet', -1, getPlayerIdInArray(self.playerId), '<span style="color:green;">' .. Config.Strings[Config.Language]['winning_status'] .. ': ' .. moneyAmount .. Config.Strings[Config.Language]['currency'].. '</span>', self.getPlayerFirstName())
            TriggerEvent('pokerLog', {'🎲**Poker game id**: ' .. GameId, 'Won a game', 'received ' .. moneyAmount .. '€'}, self.playerId)

            if not leaveStake or leaveStake == nil then
                saveData({self.playerId}, TotalStake)
                TotalStake = 0
            end
        end
    end

    self.addToGame = function()
        self.isInGame = true
    end

    self.removeFromGame = function()
        self.isInGame = false
    end

    self.startTurn = function()

        local data = {}
        data.updateType = 'playerTurn'
        if Config.GetPlayerName(self.playerId) then
            data.playerName = Config.GetPlayerName(self.playerId)
        else
            data.playerName = self.playerId
        end
        TriggerClientEvent('dzp_poker:updateStatus', -1, data)
        self.isInTurn = true
        if not self.debugPlayer then
            local bet = math.min(BiggestStake - self.getPlayerStake(), Config.GetPlayerMoney(self.playerId))
            TriggerClientEvent('dzp_poker:setTurn', self.source, true, BiggestStake <= self.playerStake or Config.GetPlayerMoney(self.playerId) <= 0, bet)
        end
    end
    
    self.endTurn = function()
        DebugPrint('^4Starting turn' .. self.playerId, '^7')
        self.isInTurn = false
        TriggerClientEvent('dzp_poker:setTurn', self.source, false)
    end

    self.revealCards = function()
        TriggerClientEvent('dzp_poker:revealCards', -1, getPlayerIdInArray(self.playerId), 1, self.playerCards[1][1])
        TriggerClientEvent('dzp_poker:revealCards', -1, getPlayerIdInArray(self.playerId), 2, self.playerCards[2][1])
    end

    self.setAllIn = function(toggle)
        DebugPrint('setAllIn')
        self.allIn = toggle
        if self.allIn then
            local playersOverbet = getPlayersOverbet(self)
            if playersOverbet > 0 then
                self.setPotentialWin(playersOverbet * self.playerStake)
            else
                self.setPotentialWin(TotalStake)
            end
        end
    end

    self.setForNewGame = function()

        -- Restores status
        if Config.RestoreStatus then

            if Config.SetStatusEvent == nil then
                Config.SetStatusEvent = 'esx_status:set'
            end

            TriggerClientEvent(Config.SetStatusEvent, self.playerId, 'hunger', 900000)
            TriggerClientEvent(Config.SetStatusEvent, self.playerId, 'thirst', 900000)
        end

        -- Resets cards and UI
        TriggerClientEvent('dzp_poker:resetCards', self.playerId)
        for i = 1, playersLimit do
            TriggerClientEvent('dzp_poker:setPlayerUIBet', self.playerId, i, -1, string.format(Config.Strings[Config.Language]['player_list_title'], i))
        end

        self.resetPlayerComb()
        self.resetPlayerCards()
        self.resetPotentialWin()
        self.resetPlayerStake()
        self.addToGame()
        self.setAllIn(false)
        self.allInLap = nil
        self.allInBet = 0
    end

    return self

end

RegisterNetEvent('dzp_poker:setPlayerUIBet')
AddEventHandler('dzp_poker:setPlayerUIBet', function(slot, amount, name)
    TriggerClientEvent('dzp_poker:setPlayerUIBet', -1, slot, amount, name)
end)