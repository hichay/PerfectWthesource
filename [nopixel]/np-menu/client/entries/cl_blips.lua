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
        event = "hairDresser:ToggleHair",
    },
	{
        id = "blips:clothing",
        title = "Tiệm quần áo",
        icon = "#blips-clothing",
        event = "hairDresser:ToggleClothing",
    },
    {
        id = "blips:tattoo",
        title = "Tiệm xăm",
        icon = "#blips-tattoo",
        event = "tattoo:ToggleTattoo",
    },
    {
        id = "blips:bank",
        title = "Banco",
        icon = "#blips-bank",
        event = "caue-blips:update",
        parameters = "bank",
    },
    {
        id = "blips:gas",
        title = "Postos",
        icon = "#blips-gas",
        event = "caue-blips:update",
        parameters = "gas",
    },
    {
        id = "blips:pd",
        title = "Departamento Policial",
        icon = "#blips-pd",
        event = "caue-blips:update",
        parameters = "pd",
    },
    {
        id = "blips:hospital",
        title = "Hospital",
        icon = "#blips-hospital",
        event = "caue-blips:update",
        parameters = "hospital",
    },
    {
        id = "blips:market",
        title = "Mercados",
        icon = "#blips-market",
        event = "caue-blips:update",
        parameters = "market",
    },
    {
        id = "blips:ammunation",
        title = "Ammunation",
        icon = "#blips-ammunation",
        event = "caue-blips:update",
        parameters = "ammunation",
    },
    {
        id = "blips:garage",
        title = "Garagem",
        icon = "#blips-garage",
        event = "caue-blips:update",
        parameters = "garage",
    },
    {
        id = "blips:misc",
        title = "Misc",
        icon = "#blips-misc",
        event = "caue-blips:update",
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

