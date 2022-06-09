function GetPlayerTable(playerId)
    for k, v in pairs(Decks) do 
        local slot = v:GetPlayerSlot(playerId)
        if slot ~= nil then 
            return ({
                tableIndex = k,
                slot = slot
            })
        end
    end
    return nil
end