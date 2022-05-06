--[[
    ========== ตั้งค่าเกี่ยวกับไอเทม ==========
]]
Config.Market_Items_Control_Default = {
    price_min       = 1,      -- ราคาต่ำที่สุดสามารถตั้งได้
    price_max       = -1,     -- ราคาสูงสุดที่สามารถตั้งได้ (-1 ไม่จำกัดราคา)
    count_min       = 1,      -- จำนวนไอเทมต่ำสุดที่ลงขายได้ต่อ 1 ไอเทม
    count_max       = -1,     -- จำนวนไอเทมสูงสุดที่ลงขายได้ต่อ 1 ไอเทม (-1 ไม่จำกัดจำนวน)
}

---------- สามารถกำหนดแบบแยกแต่ละไอเทมได้ ----------
Config.Market_Items_Control_Custom = {
    -- ['bread'] = {
    --     price_min           =   100,
    --     price_max           =   500,
    --     count_min           =   5,
    --     count_max           =   10,
    --     price_money         =   true, -- false = ไม่สามารถตั้งขายเป็นเงินเขียวได้
    --     price_black_money   =   true,  -- false = ไม่สามารถตั้งขายเป็นเงินแดงได้
    --     jobs                =   { "police", "ambulance" } --กำหนดให้ลงขายได้เฉพาะหน่วยงาน/อาชีพที่กำหนด
    -- },
    -- ['water'] = {
    --     price_min           =   10,
    --     price_max           =   1000,
    --     count_max           =   50
    -- }
}

--[[
    ========== ตั้งค่าไอเทมที่จะไม่ให้ลงขาย ==========
]]
Config.Market_Items_Sell_BL = {
    --"bread",
    --"water"
}