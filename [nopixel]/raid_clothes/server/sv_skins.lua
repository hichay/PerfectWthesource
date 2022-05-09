RPC.register("pw-clothes:getHex", function(src)
    local ids = GetIds(src)
    local hex = ""

    if ids.hex then
        hex = ids.hex
    end

    return hex
end)