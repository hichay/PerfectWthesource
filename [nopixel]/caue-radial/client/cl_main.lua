ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
	CurrentJob = ESX.GetPlayerData().job.name
end)

MenuTypes, MenuEntries, MenuItems = {"general", "peds", "vehicles", "objects", "k9", "judge"}, {}, {}
local closedFromAction = false

for _, menuType in ipairs(MenuTypes) do
    MenuEntries[menuType] = {}
end

-- Menu state
local showMenu = false

-- Keybind Lookup table
local keybindControls = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local MAX_MENU_ITEMS = 7

--[[

    Functions

]]

function CloseMenu(withNoFocus)
    showMenu = false

    if not withNoFocus then
        SetNuiFocus(false, false)
    end

    SendNUIMessage({
        state = "destroy"
    })
end

function IsMenuWanted(pMenu, pEntity)
    return pMenu == "general" or
        (pMenu == "peds" and pEntity == 1) or
        (pMenu == "vehicles" and pEntity == 2) or
        (pMenu == "objects" and pEntity == 3) or
        (pMenu == "judge" and CurrentJob == "judge")
end

function GetSubMenuEntries(pItems, pEntity, pContext)
    local items = {}

    local previous, current = items, {}

    for index, item in ipairs(pItems) do
        local entry = MenuItems[item]

        if entry and (not entry["isEnabled"] or entry["isEnabled"](pEntity, pContext)) then

            local subMenu = MenuItems[item]["data"]

            current[#current+1] = subMenu

            if index % MAX_MENU_ITEMS == 0 and index < (#pItems - 1) then
                previous[MAX_MENU_ITEMS + 1] = {
                    id = "_more",
                    title = "More",
                    icon = "#more",
                    items = current
                }
                previous = current
                current = {}
            end
        end
    end

    if #current > 0 then
        previous[MAX_MENU_ITEMS + 1] = {
            id = "_more",
            title = "More",
            icon = "#more",
            items = current
        }
    end

    if items[MAX_MENU_ITEMS + 1] then
        items = items[MAX_MENU_ITEMS + 1].items
    end

    return items
end

function GetMenuEntries(pEntity, pContext)
    local menus = {}

    for _, menuType in ipairs(MenuTypes) do
        if IsMenuWanted(menuType, pContext.type) then
            for _, entry in ipairs(MenuEntries[menuType]) do
                if entry.isEnabled(pEntity, pContext) then
                    local menu = entry.data

                    if entry.subMenus ~= nil and #entry.subMenus > 0 then
                        menu.items = GetSubMenuEntries(entry.subMenus, pEntity, pContext)
                    end

                    menus[#menus+1] = menu
                end
            end
        end
    end

    return menus
end

--[[

    Events

]]

RegisterNetEvent("menu:menuexit")
AddEventHandler("menu:menuexit", function()
    CloseMenu()
end)

--[[

    NUI

]]

-- Callback function for closing menu
RegisterNUICallback("closemenu", function(data, cb)
    -- Clear focus and destroy UI
    CloseMenu(data.withNoFocus)

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    -- Send ACK to callback function
    cb("ok")
end)

-- Callback function for when a slice is clicked, execute command
RegisterNUICallback("triggerAction", function(data, cb)
    -- Clear focus and destroy UI
    closedFromAction = true
    CloseMenu()

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    -- Run command
    if (data.action) then
        if data.parameters == nil then
            data.parameters = {}
        end

        TriggerEvent(data.action, data.parameters, data.entity or 0, data.context or {})
    end

    -- Send ACK to callback function
    cb("ok")
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    local keyBind = "F1"
    while true do
        Citizen.Wait(0)
        if IsControlPressed(1, keybindControls[keyBind]) and GetLastInputMethod(2) and showMenu then
            showMenu = false
            SetNuiFocus(false, false)
        end
        if IsControlPressed(1, keybindControls[keyBind]) and GetLastInputMethod(2) then
            if (not isCuffed and not recentlyCuffed) or ((isPolice or isMedic) and isDead) then
                showMenu = true
                PlayerCoords = GetEntityCoords(PlayerPedId())

                local entity = exports["pw-interact"]:GetCurrentEntity()
                local context = GetEntityContext(entity)
                local entries = GetMenuEntries(entity, context)

                SendNUIMessage({
                    state = "show",
                    resourceName = 'caue-radial',
                    data = entries,
                    entity = entity,
                    context = context,
                    menuKeyBind = keyBind
                })

                SetCursorLocation(0.5, 0.5)
                SetNuiFocus(true, true)
                -- Play sound
                PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
            end

            while showMenu == true do Citizen.Wait(100) end
            Citizen.Wait(100)
            while IsControlPressed(1, keybindControls[keyBind]) and GetLastInputMethod(2) do Citizen.Wait(100) end
        end
    end
end)