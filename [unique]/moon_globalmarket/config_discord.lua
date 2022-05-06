Config.DC = {}
--[[
    ===== ซื้อไอเทม =====
]]
Config.DC.Market_Buy_Item = {
    enabled = false,   -- true = เปิดใช้งาน
    url_webhook = '',
    template = {
        color = 0xFF6400,
        title = 'ซื้อไอเทม',
        desc = [[
            **Identifier:** %s | %s
            **Owner:** %s
            **Item:** %s | %s
            **Count:** %s
            **Price:** %s | %s (%s)
            **VAT Price:** %s
        ]]
    }
}
--[[
    ===== ลงขายไอเทม =====
]]
Config.DC.Market_Sell_Item = {
    enabled = false,    -- true = เปิดใช้งาน
    url_webhook = '',
    template = {
        color = 0xCCFF00,
        title = 'ลงขาย',
        desc = [[
            **Identifier:** %s | %s
            **Item:** %s | %s
            **Count:** %s
            **Price:** %s | %s (%s)
            **VAT Price:** %s
        ]]
    }
}
--[[
    ===== ยกเลิกขายไอเทม =====
]]
Config.DC.Market_Items_Selling_Cancel = {
    enabled = false,    -- true = เปิดใช้งาน
    url_webhook = '',
    template = {
        color = 0xFF0000,
        title = 'ยกเลิกขาย',
        desc = [[
            **Identifier:** %s | %s
            **Item:** %s | %s
            **Count:** %s
            **Price:** %s | %s
        ]]
    }
}
--[[
    ===== ถอนเงิน =====
]]
Config.DC.Market_WithDraw_Money = {
    enabled = false,    -- true = เปิดใช้งาน
    url_webhook = '',
    template = {
        color = 0xFF3366,
        title = 'ถอนเงิน',
        desc = [[
            **Identifier:** %s | %s
            **Money:** %s
            **Black Money:** %s
        ]]
    }
}

