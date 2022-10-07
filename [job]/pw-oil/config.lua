Config = {}
local Platforms = json.decode(LoadResourceFile(GetCurrentResourceName(), "Platforms.json"))
Config.Platforms = Platforms
Config.DefaultQuantity = 1000

Config.Seller = {
    coords = vector3(1521.5197753906, -2114.2438964844, 76.804397583008),
    heading = 275.16198730469,
    model = "g_m_m_chiboss_01"
}


Config.Levels = {

    ['oil'] = {
        550, 1250
    },

}