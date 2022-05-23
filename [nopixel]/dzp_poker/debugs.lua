DebugGame = false

DebugStrings = {
    Combos = {
        [9] = 'High Card',
        [8] = 'Pair',
        [7] = 'Two Pairs',
        [6] = 'Three of a kind',
        [5] = 'Straight',
        [4] = 'Flush',
        [3] = 'Full House',
        [2] = 'Four Of A kind',
        [1] = 'Straight flush',
    }, 
    Cards = {
        [11] = 'J',
        [12] = 'Q',
        [13] = 'K',
        [14] = 'A' 
    }
}


-- RegisterCommand('dbgame', function()
--     DebugGame = true
--     for i = 2, 10 do
--         DebugStrings.Cards[i] = i
--     end
--     for i = 1, 3 do
--         TriggerEvent('dzp_poker:joinPoker', true, i)
--     end
-- end, false)