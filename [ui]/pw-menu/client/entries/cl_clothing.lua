local GeneralEntries, SubMenu = MenuEntries["general"], {}

local Clothing = {
    {
        id = "clothing:hat",
        title = "Chapeu",
        icon = "#clothing-hat",
        event = "pw-facewear:radial",
        parameters = "hat",
    },
    {
        id = "clothing:googles",
        title = "Oculos",
        icon = "#clothing-googles",
        event = "pw-facewear:radial",
        parameters = "googles",
    },
    {
        id = "clothing:mask",
        title = "Mascara",
        icon = "#clothing-mask",
        event = "pw-facewear:radial",
        parameters = "mask",
    },
    {
        id = "clothing:chain",
        title = "Colar",
        icon = "#clothing-chain",
        event = "pw-facewear:radial",
        parameters = "chain",
    },
    {
        id = "clothing:jacket",
        title = "Jaqueta",
        icon = "#clothing-jacket",
        event = "pw-facewear:radial",
        parameters = "jacket",
    },
    {
        id = "clothing:vest",
        title = "Colete",
        icon = "#clothing-vest",
        event = "pw-facewear:radial",
        parameters = "vest",
    },
    {
        id = "clothing:backpack",
        title = "Mochila",
        icon = "#clothing-backpack",
        event = "pw-facewear:radial",
        parameters = "backpack",
    },
    {
        id = "clothing:pants",
        title = "Calça",
        icon = "#clothing-pants",
        event = "pw-facewear:radial",
        parameters = "pants",
    },
    {
        id = "clothing:shoes",
        title = "Tênis",
        icon = "#clothing-shoes",
        event = "pw-facewear:radial",
        parameters = "shoes",
    },
}

Citizen.CreateThread(function()
    for index, data in ipairs(Clothing) do
        SubMenu[index] = data.id
        MenuItems[data.id] = {data = data}
    end

    GeneralEntries[#GeneralEntries+1] = {
        data = {
            id = "clothing",
            icon = "#clothing",
            title = "Quần áo",
            event = "pw-facewear:clothesMenu",
        },
        -- subMenus = SubMenu,
        isEnabled = function()
            return not isDead and not IsDisabled() and not IsPedInAnyVehicle(PlayerPedId(), false)
        end,
    }
end)

