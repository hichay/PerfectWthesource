local GeneralEntries, SubMenu = MenuEntries["general"], {}

local Blips = {
    {
        id = "blips:weeds",
        title = "Cần sa",
        icon = "#blips-weed",
        event = "pw-weeds:ToggleBlips",
    },
    {
        id = "blips:barber",
        title = "Barber Shop",
        icon = "#blips-barber",
        event = "pw-blips:update",
		parameters = "barber",
    },
	{
        id = "blips:clothing",
        title = "Tiệm quần áo",
        icon = "#blips-clothing",
        event = "pw-blips:update",
		parameters = "clothing",
    },
    {
        id = "blips:tattoo",
        title = "Tiệm xăm",
        icon = "#blips-tattoo",
        event = "pw-blips:update",
		parameters = "tattoo",
    },
	{
        id = "blips:market",
        title = "Mercados",
        icon = "#blips-market",
        event = "pw-blips:update",
        parameters = "shop247",
    },
    {
        id = "blips:bank",
        title = "Banco",
        icon = "#blips-bank",
        event = "pw-blips:update",
        parameters = "bank",
    },
    {
        id = "blips:gas",
        title = "Postos",
        icon = "#blips-gas",
        event = "pw-blips:update",
        parameters = "gas",
    },
    {
        id = "blips:pd",
        title = "Departamento Policial",
        icon = "#blips-pd",
        event = "pw-blips:update",
        parameters = "pd",
    },
    {
        id = "blips:hospital",
        title = "Hospital",
        icon = "#blips-hospital",
        event = "pw-blips:update",
        parameters = "hospital",
    },
    {
        id = "blips:ammunation",
        title = "Ammunation",
        icon = "#blips-ammunation",
        event = "pw-blips:update",
        parameters = "ammunation",
    },
    {
        id = "blips:garage",
        title = "Garagem",
        icon = "#blips-garage",
        event = "pw-blips:update",
        parameters = "garage",
    },
    {
        id = "blips:misc",
        title = "Linh tinh",
        icon = "#blips-misc",
        event = "pw-blips:update",
        parameters = "misc",
    },
}

Citizen.CreateThread(function()
    for index, data in ipairs(Blips) do
        SubMenu[index] = data.id
        MenuItems[data.id] = {data = data}
    end

    GeneralEntries[#GeneralEntries+1] = {
        data = {
            id = "blips",
            icon = "#blips",
            title = "Blips"
        },
        subMenus = SubMenu,
        isEnabled = function()
            return not isDead
        end,
    }
end)

