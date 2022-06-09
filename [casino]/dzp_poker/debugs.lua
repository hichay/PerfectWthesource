DebugGame = false

DebugStrings = {
    Combos = {
        [9] = 'Mậu thầu',
        [8] = 'Một đôi',
        [7] = 'Hai đôi (Thú)',
        [6] = 'Sám',
        [5] = 'Sảnh',
        [4] = 'Thùng',
        [3] = 'Cù lũ',
        [2] = 'Tứ quý',
        [1] = 'Sảnh thùng',
    }, 
    Cards = {
        [11] = 'J',
        [12] = 'Q',
        [13] = 'K',
        [14] = 'A' 
    }
}


RegisterCommand('dbgame', function()
    DebugGame = true
    for i = 2, 10 do
        DebugStrings.Cards[i] = i
    end
    for i = 1, 3 do
        TriggerEvent('dzp_poker:joinPoker', true, i)
    end
end, false)