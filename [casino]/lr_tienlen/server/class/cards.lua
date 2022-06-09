Cards = {}
Cards.__index = Cards

function Cards:Create()
    local o = {}
    setmetatable(o, Cards)
    o.cards = {}
    o.handLabel = {
        [1]  = "3",
        [2]  = "4",
        [3]  = "5",
        [4]  = "6",
        [5]  = "7",
        [6]  = "8",
        [7]  = "9",
        [8]  = "10",
        [9]  = "J",
        [10] = "Q",
        [11] = "K",
        [12] = "A",
        [13] = "2"
    }
    o.suitLabel = {
        [1] = "H",
        [2] = "D",
        [3] = "C",
        [4] = "S"
    }
    return o
end

function Cards:Shuffle()
    local t = self.cards
    local j
    for i = #t, 2, -1 do 
        j= math.random(i)
        t[i], t[j] = t[j], t[i]
    end
    self.cards = t
end

function Cards:GetCard()
    local card = self.cards[#self.cards]
    table.remove(self.cards, #self.cards)
    return card
end

function Cards:New()
    self.cards = {}
    local index = 1
    for i = 1, 13, 1 do 
        for j = 1, 4, 1 do 
            table.insert(self.cards, {i, j, index})
            index = index + 1
        end
    end
end

function Cards:GetLabel(card)
    local label = self.handLabel[card[1]]..self.suitLabel[card[2]]
    return label
end

function Cards:IsCardsValid(cards)

    table.sort(cards, function(a, b)
        if a[1] == b[1] then 
            return a[2]>b[2]
        else
            return a[1]<b[1] 
        end
    end)
    print(json.encode(cards))
    if #cards == 0 then return false end
    if #cards == 1 then return "MOTLA" end
    if #cards == 2 then 
        if cards[1][1] == cards[2][1] then 
            return "DOI"
        else
            return false
        end
    end
    if #cards == 3 then 
        if cards[1][1] == cards[2][1] and cards[1][1] == cards[3][1] then
            return "KHAP"
        end 
    end
    if #cards == 4 then 
        if cards[1][1] == cards[2][1] and cards[1][1] == cards[3][1] and cards[1][1] == cards[4][1] then
            return "TUQUY"
        end 
    end
    if #cards %2 == 0 and cards[1][1] == cards[2][1] and #cards >= 6 then 
        local danhSachDoi = {}
        local tatCaDoi = true
        for i = 1, #cards, 2 do 
            if cards[i][1] == cards[i+1][1] then 
                table.insert(danhSachDoi, cards[i][1])
            else
                tatCaDoi = false
                break 
            end
        end
        if tatCaDoi then
            local curCheck
            local lienNhau = true
            for i = 1, #danhSachDoi, 1 do 
                if curCheck == nil then 
                    curCheck = danhSachDoi[i]
                elseif curCheck + 1 == danhSachDoi[i] then 
                    curCheck = danhSachDoi[i]
                else
                    lienNhau = false
                end
            end 
            if lienNhau then
                if #danhSachDoi == 3 then
                    return "BADOITHONG"
                elseif #danhSachDoi == 4 then 
                    return "BONDOITHONG"
                elseif #danhSachDoi == 5 then 
                    return "NAMDOITHONG"
                end
            end
        end
    end
    local curCheck
    local lienNhau = true
    for i = 1, #cards, 1 do 
        if curCheck == nil then 
            curCheck = cards[i][1]
        else
            if curCheck + 1 == cards[i][1] then 
                curCheck = cards[i][1]
            else
                lienNhau = false
            end
        end
    end
    if lienNhau then 
        return "SANH"..#cards
    end
    return false
end

function Cards:Compare(cards, deck)
    print(json.encode(cards).." Compare")
    
    local solved1 = self:IsCardsValid(cards)
    local solved2 = self:IsCardsValid(deck)
    if #deck == 0 then 
        if solved1 ~= false then
            return true
        else
            return false
        end
    end
    if solved1 ~= false and solved2 ~= false then 
        if #deck == 1 and deck[1][1] == 13 then 
            if solved1 == "BADOITHONG" or solved1 == "BONDOITHONG" or solved1 == "TUQUY" then 
                return true
            end
        end
        if solved2 == "DOI" and deck[1][1] == 13 then 
            if solved1 == "BONDOITHONG" then 
                return true
            end
        end
        if solved1 ~= solved2 then 
            return false
        else
            if solved1 == solved2 then 
                if cards[#cards][1] > deck[#deck][1] then 
                    return true
                elseif cards[#cards][1] == deck[#deck][1] and cards[#cards][2] < deck[#deck][2] then 
                    return true
                else 
                    return false
                end
            end
        end
    else
        return false
    end
end

--[[ 
test = Cards:Create()
test:New()
test:Shuffle()
local card1 = test:GetCard() ]]
--[[ print(test:IsCardsValid({{4,2}, {2,3},{2,4}, {3,2}, {5,1}, {6,1}, {7,2}})) ]]
--[[ print(test:IsCardsValid({{4,2}}))
print(test:Compare({{4,3}}, {{4,2}})) ]]