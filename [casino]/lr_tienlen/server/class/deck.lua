Deck = {}
Deck.__index = Deck

function Deck:Create(options)
    local o = {}
    setmetatable(o, Deck)
    o.started = false
    o.cards = nil
    o.deckCards = {}
    o.waitTime = 5
    o.nhat = options.nhat
    o.nhi = options.nhi
    o.caxi = options.caxi
    o.cakhap = options.cakhap
    o.scores = {
        ["1st"] = nil,
        ["2nd"] = nil,
        ["3rd"] = nil,
        ["4th"] = nil
    }
    o.slot = {
        ["1"] = {playerId = nil, hand = {}, name = nil, ready = false, hit = false, vote = 0},
        ["2"] = {playerId = nil, hand = {}, name = nil, ready = false, hit = false, vote = 0},
        ["3"] = {playerId = nil, hand = {}, name = nil, ready = false, hit = false, vote = 0},
        ["4"] = {playerId = nil, hand = {}, name = nil, ready = false, hit = false, vote = 0},
    }
    o.lastWin = nil
    self.startWithLowest = true

    return o
end

function Deck:Join(playerId, slot)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    slot = tostring(slot)
    if self.slot[slot].playerId ~= nil then 
        return false 
    else 
        if xPlayer then 
            self.slot[slot].name = xPlayer.name
        else
            self.slot[slot].name = "Test Player"
        end
        self.slot[slot].playerId = playerId 
        self:SyncPlayerData()
        SyncTablesData()
        return true 
    end
end

function Deck:SyncPlayerData()
    local SyncData = {
        data = {},
        result = self.scores
    }
    for k, v in pairs(self.slot) do 
        if v.playerId ~= nil then 
            local xPlayer = ESX.GetPlayerFromId(v.playerId)
            if xPlayer then 
                SyncData.data[k] = {
                    name = xPlayer.name,
                    money = xPlayer.getMoney(),
                    ready = v.ready,
                    grade = self:GetGrade(k)
                }
            else
                SyncData.data[k] = {
                    name = "Test player",
                    money = math.random(10000, 1000000),
                    ready = v.ready,
                    grade = self:GetGrade(k)
                }
            end
        end
    end
    self:TriggerClientEvent("lr_tienlen:client:sync", SyncData)
end

function Deck:GetGrade(slot)
    for k, v in pairs(self.scores) do 
        if v == slot then 
            return k 
        end
    end
    return false
end

function Deck:Ready(slot, cb)
    slot = tostring(slot)
    if self.started then return end
    if self.slot[slot].playerId ~= nil then 
        local xPlayer = ESX.GetPlayerFromId(self.slot[slot].playerId)
        if xPlayer then
            if xPlayer.getMoney() >= self.nhat then
                xPlayer.removeMoney(self.nhat)
                self.slot[slot].ready = true
                cb(true)
                self:SyncPlayerData()
                Wait(5000)

                if self:CanStart() then 
                    self:Start()
                end
            else
                xPlayer.showNotification(("Bạn không có đủ ~r~[%s]~g~$~w~ để sẵn sàng"):format(self.nhat))
                cb(false)
            end
        else
            self.slot[slot].ready = true
            cb(true)
            self:SyncPlayerData()
            Wait(5000)

            if self:CanStart() then 
                self:Start()
            end
        end
    else
        cb(false)
    end
end

function Deck:Leave(slot)
    slot = tostring(slot)
    if slot == self.lastWin then 
        self.lastWin = nil
        self.startWithLowest = true
    end
    if self.slot[slot].playerId ~= nil then 
        self.slot[slot].ready = false
        self.slot[slot].playerId = nil
        self.slot[slot].hand = {}
        self.slot[slot].vote  = 0
    end
    SyncTablesData()
    self:SyncPlayerData()
    local allLeave = true
    for k, v in pairs(self.slot) do 
        if v.playerId ~= nil then 
            allLeave = false
        end
    end
    if allLeave then 
        self.startWithLowest = true
    end
end

function Deck:IsAllReady()
    for k, v in pairs(self.slot) do 
        if v.playerId ~= nil and v.ready == false then 
            return false
        end
    end
    return true
end

function Deck:CountPlayers()
    local players = 0
    for k, v in pairs(self.slot) do 
        if v.playerId ~= nil then 
            players = players + 1
        end
    end
    return players
end

function Deck:CountReadyPlayers()
    local players = 0
    for k, v in pairs(self.slot) do 
        if v.playerId ~= nil and v.ready then 
            players = players + 1
        end
    end
    return players
end

function Deck:CanStart()
    if not self:IsAllReady() then 
        return "Nguời chơi chưa sẵn sàng"
    else
        if self:CountPlayers() < 2 then 
            return "Không đủ người chơi"
        else
            return true
        end
    end
end

function Deck:New()
    self.cards = {}
    self.cards = Cards:Create()
    for k, v in pairs(self.slot) do 
        self.slot[k].ready = false
        self.slot[k].hand = {}
        self.slot[k].hit = false
    end
    self.lastWin = self.scores["1st"]
    self.scores = {
        ["1st"] = nil,
        ["2nd"] = nil,
        ["3rd"] = nil,
        ["4th"] = nil
    }
    self.deckCards = {}
    self.started = false
end

function Deck:ChiaBai()
    for i = 1, 13, 1 do 
        
        for k, v in pairs(self.slot) do 
            if v.playerId ~= nil and v.ready then 
                Wait(100)
                local card = self.cards:GetCard()
                table.insert(v.hand, card)
                for k2, v2 in pairs(self.slot) do
                    if v2.playerId ~= nil then 
                        TriggerClientEvent("lr_tienlen:client:dealCards", v2.playerId, k, card[3])
                    end
                end
            end
        end
    end
end

function Deck:HandSort(slot)
    slot = tostring(slot)
    table.sort(self.slot[slot].hand, function(a, b)
        if a[1] == b[1] then 
            return a[2]>b[2]
        else
            return a[1]<b[1] 
        end
    end)
end

function Deck:Start()
    if self.started then 
        return false 
    else 
        local deckStatus = self:CanStart()
        if deckStatus == true then
            self.started = true 
            self.cards:New()
            --[[ for k, v in pairs(self.slot) do 
                if v.playerId ~= nil then 
                    TriggerClientEvent("lr_tienlen:client:newCards", v.playerId, self.cards.cards)
                end
            end ]]
            Wait(1)
            self.cards:Shuffle()
            for k, v in pairs(self.slot) do 
                if v.playerId ~= nil then 
                    TriggerClientEvent("lr_tienlen:client:newCards", v.playerId, self.cards.cards)
                end
            end
            self:TriggerClientEvent("lr_tienlen:client:start")
            self:ChiaBai()
            self:TurnThread()
        else
            self:Notification(deckStatus)
        end
    end
end

--[[ function Deck:ChonNguoiDanh()
    if self.batDau3Bich then 
        local laNhoNhat = nil
        local nguoiDanhTruoc = nil
        for k, v in pairs(self.slot) do 
            if v.ready then 
                for _k, card in pairs(v.hand) do 
                    if laNhoNhat == nil then 
                        laNhoNhat = card
                        nguoiDanhTruoc = k
                    else
                        if laNhoNhat[1] > card[1] then 
                            laNhoNhat = card
                            nguoiDanhTruoc = k
                        elseif laNhoNhat[1] == card[1] and laNhoNhat[2] < card[2] then 
                            laNhoNhat = card
                            nguoiDanhTruoc = k
                        end
                    end
                end
            end
        end
        self.batDau3Bich = false
        self.nguoiDanhTiepTheo = nguoiDanhTruoc
    else
        if self.nguoiVuaToiNhat ~= nil then 
            self.nguoiDanhTiepTheo = self.nguoiVuaToiNhat
            self.nguoiVuaToiNhat = nil
        else
            for i = 1, #self.vongHienTai, 1 do 
                if self.vongHienTai[i] == self.nguoiDanhTiepTheo then
                    if i < #self.vongHienTai then 
                        self.nguoiDanhTiepTheo = self.vongHienTai[i+1]
                    else
                        self.nguoiDanhTiepTheo = self.vongHienTai[1]
                    end
                end
            end
        end
    end
end ]]

function Deck:TriggerClientEvent(eventName, ...)
    for k, v in pairs(self.slot) do 
        if v.playerId then 
            TriggerClientEvent(eventName, v.playerId, ...)
        end
    end
end


function Deck:TurnThread()
    self.playerInTurn = {}
    self.time = self.waitTime
    for k, v in pairs(self.slot) do 
        if v.playerId ~= nil and v.ready then 
            self.playerInTurn[k] = v.playerId
        end
    end
    if self.startWithLowest then
        self.lastTurnSlot = self:GetLowestPlayer()
        self:TriggerClientEvent("lr_tienlen:client:syncTurn", self.lastTurnSlot)
    end
    if self.lastWin then 
        self.lastTurnSlot = self.lastWin
        self:TriggerClientEvent("lr_tienlen:client:syncTurn", self.lastTurnSlot)       
    end
    while self.started do 
        Wait(1000)
        self.time = self.time - 1
        self:TriggerClientEvent("lr_tienlen:client:syncTime", self.time)
        local playerNum = self:CountReadyPlayers()
        local playerFinished = 0
        local lastSlot
        for k, v in pairs(self.slot) do 
            if v.playerId ~= nil and v.ready then
                if #v.hand == 0 then 
                    playerFinished = playerFinished + 1 
                else
                    lastSlot = k
                end
            end
        end
        if playerFinished + 1 == playerNum then 
            if self.scores["1st"] == nil then 
                self.scores["1st"] = lastSlot
            elseif self.scores["2nd"] == nil then 
                self.scores["2nd"] = lastSlot
            elseif self.scores["3rd"] == nil then 
                self.scores["3rd"] = lastSlot
            elseif self.scores["4th"] == nil then 
                self.scores["4th"] = lastSlot
            end
            self:SyncPlayerData()
            self:TriggerClientEvent("lr_tienlen:client:end")
            self:CalcReward()
            Wait(5000)
            self:CheckSpecialCards(lastSlot)
            Wait(20000)
            self:TriggerClientEvent("lr_tienlen:client:removeAllCards")
            self:New()
            break
        end
        if self.time <=0 then 
            if self.lastTurnSlot then 
                if not self.slot[self.lastTurnSlot].hit and not self.startWithLowest then 
                    self:Next(self.lastTurnSlot)
                end
            end
            local cur = self:nextPlayer()
            self:TriggerClientEvent("lr_tienlen:client:syncTurn", cur)
            self.time = self.waitTime

        end
    end
end

function Deck:CalcReward()
    local playerNum = 0
    for k, v in pairs(self.scores) do 
        if v ~= nil then 
            playerNum = playerNum + 1
        end
    end
    if playerNum == 4 then 
        local _1stPlayer = ESX.GetPlayerFromId(self.slot[self.scores["1st"]].playerId)
        _1stPlayer.addMoney(self.nhat * 1.9)
        self:TriggerClientEvent("lr_tienlen:client:addMoney", self.scores["1st"], self.nhat*0.9)
        local _2ndPlayer = ESX.GetPlayerFromId(self.slot[self.scores["2nd"]].playerId)
        _2ndPlayer.addMoney(self.nhat + (self.nhi * 0.9))
        self:TriggerClientEvent("lr_tienlen:client:addMoney", self.scores["2nd"], self.nhi * 0.9)
        self:TriggerClientEvent("lr_tienlen:client:removeMoney", self.scores["3rd"], self.nhi)
        self:TriggerClientEvent("lr_tienlen:client:removeMoney", self.scores["4th"], self.nhat)
    elseif playerNum == 3 then 
        local _1stPlayer = ESX.GetPlayerFromId(self.slot[self.scores["1st"]].playerId)
        _1stPlayer.addMoney(self.nhat * 1.9)
        self:TriggerClientEvent("lr_tienlen:client:addMoney", self.scores["1st"], self.nhat*0.9)
        self:TriggerClientEvent("lr_tienlen:client:removeMoney", self.scores["3rd"], self.nhat)
    elseif playerNum == 2 then 
        local _1stPlayer = ESX.GetPlayerFromId(self.slot[self.scores["1st"]].playerId)
        _1stPlayer.addMoney(self.nhat * 1.9)
        self:TriggerClientEvent("lr_tienlen:client:addMoney", self.scores["1st"], self.nhat*0.9)
        self:TriggerClientEvent("lr_tienlen:client:removeMoney", self.scores["2nd"], self.nhat)
    elseif playerNum == 1 then 
        local _1stPlayer = ESX.GetPlayerFromId(self.slot[self.scores["1st"]].playerId)
        _1stPlayer.addMoney(self.nhat * 1.9)
        self:TriggerClientEvent("lr_tienlen:client:addMoney", self.scores["1st"], self.nhat*0.9)
    end
end

function Deck:CheckSpecialCards(slot)
    local spCards = {}
    for k, v in pairs(self.slot[slot].hand) do 
        if v[1] == 13 then 
            table.insert(spCards, v)
        end
    end
    local u = self:GetUpSlot()
    local xPlayer = ESX.GetPlayerFromId(self.slot[slot].playerId)
    local aP = ESX.GetPlayerFromId(u)

    for k, v in pairs(spCards) do 
        if v[2] == 1 or v[2] == 2 then 
            u.addMoney(self.nhat * 0.9)
            self:TriggerClientEvent("lr_tienlen:client:addMoney", u, self.nhat*0.9)
            xPlayer.removeMoney(self.nhat)
            self:TriggerClientEvent("lr_tienlen:client:removeMoney", slot, self.nhat)
        else
            u.addMoney(self.nhi * 0.9)
            self:TriggerClientEvent("lr_tienlen:client:addMoney", u, self.nhi*0.9)
            xPlayer.removeMoney(self.nhi)
            self:TriggerClientEvent("lr_tienlen:client:removeMoney", slot, self.nhi)
        end
    end
end

function Deck:GetUpSlot()
    if self.scores["4th"] ~= nil then 
        return self.scores["3rd"]
    elseif self.scores["3rd"] ~= nil then 
        return self.scores['2nd']
    elseif self.scores['2nd'] ~= nil then 
        return self.scores['1st']
    end
end

function Deck:GetLowestPlayer()
    local lowestCard
    local pl
    for k, v in pairs(self.slot) do 
        if v.playerId ~= nil and v.ready then 
            for _k, _v in pairs(v.hand) do 
                if lowestCard == nil then 
                    lowestCard = _v
                    pl = k
                else
                    if lowestCard[1] > _v[1] then 
                        lowestCard = _v
                        pl = k
                    elseif lowestCard[1] == _v[1] and lowestCard[2] < _v[2] then 
                        lowestCard = _v
                        pl = k
                    end
                end
            end
        end
    end
    return tostring(pl)
end

function Deck:nextPlayer()
    if self.startWithLowest then 
        self.startWithLowest = false
        local lowestCard
        local nextPlayer
        for k, v in pairs(self.slot) do 
            if v.playerId ~= nil and v.ready then 
                for _k, _v in pairs(v.hand) do 
                    if lowestCard == nil then 
                        lowestCard = _v
                        nextPlayer = k
                    else
                        if lowestCard[1] > _v[1] then 
                            lowestCard = _v
                            nextPlayer = k
                        elseif lowestCard[1] == _v[1] and lowestCard[2] < _v[2] then 
                            lowestCard = _v
                            nextPlayer = k
                        end
                    end
                end
            end
        end
        --self:TriggerClientEvent("lr_tienlen:client:startLowest", k, lowestCard[3])
        if self:CanHit({lowestCard[3]}) then
            self:Hit(nextPlayer, {lowestCard[3]})
        end
        self.slot[nextPlayer].hit = false
        local numLastTurn = tonumber(self.lastTurnSlot)
        local stringLastTurnAdded = tostring(numLastTurn+1)
        while self.playerInTurn[stringLastTurnAdded] == nil do 
            Wait(0)
            
            if tonumber(self.lastTurnSlot) >= tonumber(self:GetLastPlayerInTurn()) then 
                self.lastTurnSlot = "0"
            else
                self.lastTurnSlot = stringLastTurnAdded
            end
            numLastTurn = tonumber(self.lastTurnSlot)
            stringLastTurnAdded = tostring(numLastTurn+1)
        end
        self.lastTurnSlot = tostring(tonumber(self.lastTurnSlot) + 1)
        self.slot[self.lastTurnSlot].hit = false
        return self.lastTurnSlot
    elseif self.lastWin ~= nil then 
        self.playerInTurn = {}
        for k, v in pairs(self.slot) do 
            if v.playerId ~= nil and v.ready then 
                self.playerInTurn[k] = v.playerId
            end
        end
        self.lastTurnSlot = tostring(tonumber(self.lastWin)+1)
        self.slot[self.lastTurnSlot].hit = false
        self.lastWin = nil
        return self.lastTurnSlot
    else
        if self:CountPlayersInTurn() == 1 then 
            local nextPlayer 
            for k, v in pairs(self.playerInTurn) do 
                self.lastTurnSlot = k
            end
            self.playerInTurn = {}
            for k, v in pairs(self.slot) do 
                if v.playerId ~= nil and v.ready then 
                    self.playerInTurn[k] = v.playerId
                end
            end
            self.deckCards = {}
            self:TriggerClientEvent("lr_tienlen:client:flipDesk")
            return self.lastTurnSlot
        else
            local numLastTurn = tonumber(self.lastTurnSlot)
            local stringLastTurnAdded = tostring(numLastTurn+1)
            while self.playerInTurn[stringLastTurnAdded] == nil do 
                Wait(0)
                if tonumber(self.lastTurnSlot) >= tonumber(self:GetLastPlayerInTurn()) then 
                    self.lastTurnSlot = "0"
                else
                    self.lastTurnSlot = stringLastTurnAdded
                end
                numLastTurn = tonumber(self.lastTurnSlot)
                stringLastTurnAdded = tostring(numLastTurn+1)
            end
            self.lastTurnSlot = tostring(tonumber(self.lastTurnSlot) + 1)
            self.slot[self.lastTurnSlot].hit = false
            return self.lastTurnSlot
        end
    end
end

function Deck:Hit(slot, cards)
    slot = tostring(slot)
    self.slot[slot].hit = true
    if self.startWithLowest then 
        self.startWithLowest = false 
    end
    for i = 1, #cards, 1 do 
        for k, v in pairs(self.slot[slot].hand) do 
            if v[3] == cards[i] then 
                table.remove(self.slot[slot].hand, k)
            end
        end
    end
    self.lastTurnSlot = slot
    self:TriggerClientEvent("lr_tienlen:client:hit", slot, cards)
    if #self.slot[slot].hand == 0 then 
        if self.scores["1st"] == nil then 
            self.scores["1st"] = slot
        elseif self.scores["2nd"] == nil then 
            self.scores["2nd"] = slot
        elseif self.scores["3rd"] == nil then 
            self.scores["3rd"] = slot
        elseif self.scores["4th"] == nil then 
            self.scores["4th"] = slot
        end
        self:SyncPlayerData()
    end
    self.time = 0

end


function Deck:CountPlayersInTurn()
    local count = 0 
    for k, v in pairs(self.playerInTurn) do 
        count = count + 1
    end
    return count
end

function Deck:GetLastPlayerInTurn()
    local lastSlot
    for k, v in pairs(self.playerInTurn) do 
        if lastSlot == nil then 
            lastSlot = tonumber(k)
        else
            if lastSlot < tonumber(k) then 
                lastSlot = tonumber(k)
            end
        end
    end
    return tostring(lastSlot)
end

function Deck:MainThread()
    Citizen.CreateThread(function()
        while self.started do 
            Wait(self.waitTime * 1000)
        end
    end)
end

function Deck:Notification(msg)
    print(msg)
end

function Deck:GetCardDatas(index)
    for k, v in pairs(self.slot) do 
        if v.playerId ~= nil then 
            for i = 1, #v.hand, 1 do 
                if v.hand[i][3] == index then 
                    return v.hand[i]
                end
            end
        end
    end
end

function Deck:GetPlayerSlot(playerId)
    for k, v in pairs(self.slot) do 
        if v.playerId ~= nil then 
            if v.playerId == playerId then 
                return k
            end
        end
    end
    return nil
end

function Deck:GetCardData(index, playerId)
    local slot = self:GetPlayerSlot(playerId)
    if slot ~= nil then 
        for k, v in pairs(self.slot[slot].hand) do 
            if v[3] == index then 
                return v
            end
        end
    end
    for k, v in pairs(self.deckCards) do 
        if v[3] == index then 
            return v
        end 
    end
end

function Deck:CanHit(cards)
    local _cards = {}
    for k, v in pairs(cards) do 
        table.insert(_cards, self:GetCardDatas(v))
    end
    if self.startWithLowest then
        local lowestCard
        local nextPlayer
        for k, v in pairs(self.slot) do 
            if v.playerId ~= nil and v.ready then 
                for _k, _v in pairs(v.hand) do 
                    if lowestCard == nil then 
                        lowestCard = _v
                        nextPlayer = k
                    else
                        if lowestCard[1] > _v[1] then 
                            lowestCard = _v
                            nextPlayer = k
                        elseif lowestCard[1] == _v[1] and lowestCard[2] < _v[2] then 
                            lowestCard = _v
                            nextPlayer = k
                        end
                    end
                end
            end
        end
        local hasLowest = false
        for k, v in pairs(_cards) do 
            if v[3] == lowestCard[3] then 
                hasLowest = true
            end
        end
        if hasLowest then 
            if self.cards:IsCardsValid(_cards)~= false then 
                self.deckCards = _cards
                return true 
            else
                return false
            end
        else
            return false
        end
    else
        if self.cards:Compare(_cards, self.deckCards) == true then 
            self.deckCards = _cards
            return true 
        else
            return false
        end
    end
end

function Deck:Next(slot)
    slot = tostring(slot)
    if self.lastTurnSlot == slot then 
        self.playerInTurn[slot] = nil
    end
    self.time = 0
end

function Deck:IsSpecialCards(cards, slot)
    slot = tostring(slot)
    local _cards = {}
    for k, v in pairs(cards) do 
        table.insert(_cards, self:GetCardDatas(v))
    end
    local solvedCards = self.cards:IsCardsValid(_cards)
    if solvedCards == "BONDOITHONG" then 
        self.playerInTurn[slot] = self.slot[slot].playerId
        return true
    end
    return false
end

function Deck:RequestKick(slot, playerId)
    slot = tostring(slot)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if self.slot[slot].playerId ~= nil then
        self.slot[slot].vote = 0
        self:TriggerClientEvent("lr_tienlen:client:requestKick", slot, self.slot[slot].name, xPlayer.name)
    end
end

function Deck:AcceptKick(slot, playerId)
    slot = tostring(slot)
    if self.slot[slot].playerId ~= nil then
        self.slot[slot].vote = self.slot[slot].vote + 1
        --if self.slot[slot].vote > (self:CountPlayers() / 2) then 
            TriggerClientEvent("lr_tienlen:client:kicked", self.slot[slot].playerId)
            self:Leave(slot)
        --end
    end
end

Decks = {}
--[[ test = Deck:Create()
test:New()
test:Join(1, 1)
test:Ready(1)
test:Join(2, 2)
test:Ready(2)
test:Start()
test:HandSort(1)
test:HandSort(2) ]]
for k, v in pairs(Config.Tables) do 
    Decks[k] = Deck:Create(v)
    Decks[k]:New()
end
