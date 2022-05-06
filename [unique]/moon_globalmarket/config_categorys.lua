--[[
    ========== สร้างหมวดหมู่เมนู ==========
]]
Config.Market_Categorys = {
    { 
        name = "food",   -- ชื่ออ้างอิง (ห้ามซ้ำกับอันอื่น ภาษาอังกฤษเท่านั้น)
        label = "อาหาร", -- ชื่อที่แสดง (สามารถใช้ภาษาไทยได้)
    },
    { name = "weapon",      label = "อาวุธ" },
    { name = "tool",        label = "อุปกรณ์" },
    { name = "illegal",     label = "ผิดกฏหมาย" },
}
--[[
    ========== กำหนดไอเทมให้อยู่ในหมวดหมู่เมนู ==========
    ** 1 ไอเทมสามารถกำหนดได้หลายหมวดหมู่ **
]]
Config.Market_Items_Categorys = {
    ['bread']                   = { "food" },
    ['water']                   = { "food" },
    ['phone']                   = { "tool", "illegal" },
    ['carotool']                = { "tool", "illegal" },

    -- Weapons
    ['WEAPON_DAGGER']           = { "weapon" },
    ['WEAPON_BAT']              = { "weapon" },
    ['WEAPON_BOTTLE']           = { "weapon" },
    ['WEAPON_CROWBAR']          = { "weapon" },
    ['WEAPON_FLASHLIGHT']       = { "weapon" },
    ['WEAPON_GOLFCLUB']         = { "weapon" },
    ['WEAPON_HAMMER']           = { "weapon" },
    ['WEAPON_HATCHET']          = { "weapon" },
    ['WEAPON_KNUCKLE']          = { "weapon" },
    ['WEAPON_KNIFE']            = { "weapon" },
    ['WEAPON_MACHETE']          = { "weapon" },
    ['WEAPON_SWITCHBLADE']      = { "weapon" },
    ['WEAPON_NIGHTSTICK']       = { "weapon" },
    ['WEAPON_WRENCH']           = { "weapon" },
    ['WEAPON_BATTLEAXE']        = { "weapon" },
    ['WEAPON_POOLCUE']          = { "weapon" },
    ['WEAPON_STONE_HATCHET']    = { "weapon" },
    ['WEAPON_BAT']              = { "weapon" },
    ['WEAPON_PISTOL']           = { "weapon" },
}