local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

ESX = nil
QBCore = nil
local isOnwer = false
local ShowingNotification = false

Citizen.CreateThread(function()
    if Config.Framework == 'esx' then
        while ESX == nil do
            TriggerEvent(Config.TrigEv, function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    end
    if Config.Framework == 'qbus' then
        while QBCore == nil do
            TriggerEvent(Config.TrigEv, function(obj) QBCore = obj end)
            Citizen.Wait(0)
        end
    end
end)

CreateThread(function()
	while true do
		Wait(0)
		if NetworkIsPlayerActive(PlayerId()) then
			TriggerServerEvent('dzp_poker:onPlayerJoined')
			break
		end
	end
end)

Citizen.CreateThread(function()
    Citizen.Wait(2000)
    SendNUIMessage({
        type = 'setResourceName',
        resourceName = GetCurrentResourceName()
    })
    SendNUIMessage({
        type = 'setDefaultStrings',
        language = Config.Language,
        stringsData = Config.Strings
    })
end)

------------------------
-- Client wide variables
------------------------
local talkingTimeout = 0
local display = false
local joinTimeout = 10000
local chairsSpawned = false
local Chairs = {}

------------------------
-- NUI functions -------
------------------------
function setCard(cardNum, cardId)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = 'setCard',
        cardNum = cardNum,
        cardId = cardId
    })
end

function joinGame()
    display = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = 'joinGame'
    })
end

function leaveGame()
    display = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'leaveGame'
    })
end

function hideCards()
    SendNUIMessage({
        type = 'hideCards',
        cardNum = cardNum
    })
end

function startTurn(checkAvailable, callAmount)
    PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)
    SendNUIMessage({
        type = 'startTurn',
        checkAvailable = checkAvailable,
        callAmount = callAmount,
        timer = Config.MoveTimer
    })
end

function finishTurn()
    SendNUIMessage({
        type = 'finishTurn'
    })
end

function unRevealCards()
    SendNUIMessage({
        type = 'unRevealCards',
    })
end

-- Sets moves from nui input and sends tpo server.
-- data.move        -   move type (check, fold, bet, exit);
-- data.betValue    -   amount to bet (only used for bet move).
RegisterNUICallback('setMove', function(data)
    TriggerServerEvent('dzp_poker:setButtonClick', data)
end)

-- NUI errors
RegisterNUICallback('NUIerror', function(data)
    ShowNotificationMsg(data.message)
end)

-- Disable nui focus while talking
RegisterNUICallback('NUItalk', function()
    talkingTimeout = 1200
end)

RegisterNUICallback('NUILoaded', function()
    SendNUIMessage({
        type = 'setDefaultStrings',
        language = Config.Language,
        stringsData = Config.Strings
    })
end)

RegisterNetEvent('dzp_poker:addCard')
AddEventHandler('dzp_poker:addCard', function(cardNum, cardId)
    setCard(cardNum, cardId)
end)



-- Sets player NUI turn phase on/off (enables/disables buttons)
-- isInTurn         -   toggle (bool)
-- checkAvailable   -   enable check/call button (bool)
RegisterNetEvent('dzp_poker:setTurn')
AddEventHandler('dzp_poker:setTurn', function(isInTurn, checkAvailable, callAmount)
    local check = true
    
    if checkAvailable ~= nil then
        check = checkAvailable
    end

    if isInTurn then
        startTurn(check, callAmount)
    else
        finishTurn()
    end
end)

-- Sends game status to NUI
RegisterNetEvent('dzp_poker:updateStatus')
AddEventHandler('dzp_poker:updateStatus', function(data)
    SendNUIMessage({
        type = 'setStatus',
        data = data
    })
end)

-- Sends player bet to NUI
RegisterNetEvent('dzp_poker:setPlayerUIBet')
AddEventHandler('dzp_poker:setPlayerUIBet', function(slot, betAmount, playerName)
    SendNUIMessage({
        type = 'setBet',
        slot = slot,
        betAmount = betAmount,
        playerName = playerName
    })
end)

-- Hides all cards
RegisterNetEvent('dzp_poker:resetCards')
AddEventHandler('dzp_poker:resetCards', function()
    hideCards()
    unRevealCards()
end)

-- Reveals cards after game
RegisterNetEvent('dzp_poker:revealCards')
AddEventHandler('dzp_poker:revealCards', function(player, cardNum, cardId)
    SendNUIMessage({
        type = 'revealCards',
        player = player,
        cardNum = cardNum,
        cardId = cardId
    })
end)

-- Hides other players cards on new game
RegisterNetEvent('dzp_poker:unRevealCards')
AddEventHandler('dzp_poker:unRevealCards', function()
    SendNUIMessage({
        type = 'unRevealCards',
    })
end)

------------------------
-- Variables manipulation
------------------------
-- Rotates chairs in array. Used to rotate dealer and blinds




------------------------
-- Stuff needed for game
------------------------
-- Disables cinematic camera when at the table
Citizen.CreateThread(function()
    if Config.DisableCinematicCamera then
        while true do
            Citizen.Wait(15000)
            if display then
                N_0xf4f2c0d4ee209e20()
            end
        end
    end
end)

-- Disables most input when at the table
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if display then
            local playerPed = PlayerPedId()
            DisableControlAction(0, 1, true) -- Disable pan
            DisableControlAction(0, 2, true) -- Disable tilt
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, Keys["W"], true) -- W
            DisableControlAction(0, Keys["A"], true) -- A
            DisableControlAction(0, 31, true) -- S (fault in Keys table!)
            DisableControlAction(0, 30, true) -- D (fault in Keys table!)

            DisableControlAction(0, Keys["R"], true) -- Reload
            DisableControlAction(0, Keys["SPACE"], true) -- Jump
            DisableControlAction(0, Keys["Q"], true) -- Cover
            DisableControlAction(0, Keys["TAB"], true) -- Select Weapon
            DisableControlAction(0, Keys["F"], true) -- Also 'enter'?

            DisableControlAction(0, Keys["F1"], true) -- Disable phone
            DisableControlAction(0, Keys["F2"], true) -- Inventory
            DisableControlAction(0, Keys["F3"], true) -- Animations
            DisableControlAction(0, Keys["F6"], true) -- Job

            DisableControlAction(0, Keys["V"], true) -- Disable changing view
            DisableControlAction(0, Keys["C"], true) -- Disable looking behind
            DisableControlAction(0, Keys["X"], true) -- Disable clearing animation
            DisableControlAction(2, Keys["P"], true) -- Disable pause screen

            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle

            DisableControlAction(2, Keys["LEFTCTRL"], true) -- Disable going stealth

            DisableControlAction(0, 47, true) -- Disable weapon
            DisableControlAction(0, 264, true) -- Disable melee
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true) -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
        end
    end
end)


-- Disable NUI focus when talking
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if talkingTimeout >= 0 then
            talkingTimeout = talkingTimeout - 100
            SetNuiFocus(false, false)
        elseif display then
            SetNuiFocus(true, true)
        end
    end
end)

-- Sits ped down on chair (object)
-- object   -   chair for player to sit on
function sit(object)
	local pos = GetEntityCoords(object)
    local objectCoords = pos.x .. pos.y .. pos.z
	local playerPed = PlayerPedId()
    TaskStartScenarioAtPosition(playerPed, 'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER',  pos.x, pos.y, pos.z + 0.4, GetEntityHeading(object) + 180.0, 0, true, true)
	Citizen.Wait(1000)
end

-- Leaves chair
function leaveSit()
	local playerPed = PlayerPedId()
	ClearPedTasks(playerPed)

    SetEntityCoords(playerPed, Config.MarkerCoords)
    FreezeEntityPosition(playerPed, false)
end

AddEventHandler("pw-inventory:itemUsed", function(item)
    if not isPlacing and item == "ace" then
        isPlacing = true
        placeObject("prop_proxy_chateau_table", function(pPlaced, pCoords, pHeading)
            if pPlaced then
                --TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_HAMMERING", 0, true)
                TriggerEvent("inventory:removeItem","ace",1)
                local finished = exports["pw-taskbar"]:taskBar(2000, "Đặt bàn", false, true, false, false, nil, 5.0, PlayerPedId())
                ClearPedTasks(PlayerPedId())
                
            else
                TriggerEvent("DoLongHudText", "Ko thể đặt hoặc bạn đã hủy")
            end
            isPlacing = false
        end)
    end    
end)    

RegisterNetEvent('dzp_poker:updateState')
AddEventHandler('dzp_poker:updateState', function(state)
    isOnwer = state
end)
print(isOnwer)
function isOwner()
    return isOnwer
end
local Inte = {
  data = {
    {
        id = 'Remove_tabale',
        label = 'Thu hồi bàn',
        icon = 'hand-holding',
        event = 'dzp_poker:takeTableBack',
        parameters = {},
    },
  },
  options = {
    distance = { radius = 2.5 },
    isEnabled = function(pEntity, pContext)
      return isOwner()
    end,
  },
}
exports["pw-interact"]:AddPeekEntryByModel({`prop_proxy_chateau_table`}, Inte.data, Inte.options)

local Interact = {
    data = {
      {
          id = 'Pokce_play',
          label = 'Chơi Poker',
          icon = 'hand',
          event = 'dzp_poker:playPoker',
          parameters = {},
      },
      {
        id = 'tienlen_play',
        label = 'Chơi Tiến Lên',
        icon = 'hand',
        event = 'lr_tienlen:client:OpenTable',
        parameters = {},
      },
    },
    options = {
      distance = { radius = 2.5 },
    },
}

exports["pw-interact"]:AddPeekEntryByModel({`prop_proxy_chateau_table`}, Interact.data, Interact.options)

RegisterNetEvent('dzp_poker:playPoker')
AddEventHandler('dzp_poker:playPoker', function()

    TriggerServerEvent('dzp_poker:joinPoker')
end)

-- Creates chairs and table
Citizen.CreateThread(function()
    for i = 1, #Config.ChairsData do
        local coords = nil
        if Config.SetChairsByOffset then
            local x = Config.Table.x + Config.ChairsData[i].xOffset
            local y = Config.Table.y + Config.ChairsData[i].yOffset
            coords = vector3(x, y, Config.Table.z)
        else
            coords = vector3(Config.ChairsData[i].x, Config.ChairsData[i].y, Config.ChairsData[i].z)
        end
        SpawnObject(Config.ChairHash, coords, function(chair)
            Chairs[i] = chair
            FreezeEntityPosition(chair, true)
            SetEntityAsMissionEntity(chair, true, false)
            SetEntityCollision(chair, true, true)
            SetEntityHeading(chair, Config.ChairsData[i].h)

            -- print(GetEntityHeading(chair))
        end, false)
    end
    chairsSpawned = true
    local tableCoords = vector3(Config.Table.x, Config.Table.y, Config.Table.z)
    SpawnObject(Config.TableHash, tableCoords, function(table)
        FreezeEntityPosition(table, true)
        SetEntityAsMissionEntity(table, true, false)
        SetEntityCollision(table, true, true)
    end, false)
end) 

-- Thread for button
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(ped)
        --DrawMarker(1, Config.MarkerCoords.x, Config.MarkerCoords.y, Config.MarkerCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 200, 255, 200, 200)
        if #(coords - Config.MarkerCoords) < 5.5 then
            --ShowHelpNotification(Config.Strings[Config.Language]['join_table'])
            if not ShowingNotification then
                ShowingNotification = true
                exports["pw-interaction"]:showInteraction("[E] để ngồi vào bàn")
            end
            if IsControlJustReleased(0, 38) then
                exports["pw-interaction"]:hideInteraction()
				ShowingNotification = false
                TriggerServerEvent('dzp_poker:joinPoker')
            end
        else
            if ShowingNotification then
                exports["pw-interaction"]:hideInteraction()
			    ShowingNotification = false
            end
        end
    end
end)

-- Thread for blip
--[[ Citizen.CreateThread(function()
	pokerBlip = AddBlipForCoord(Config.BlipCoords)
	SetBlipDisplay(pokerBlip, Config.BlipDisplay or 4)
	SetBlipSprite(pokerBlip, Config.BlipSprite or 267)
	SetBlipColour(pokerBlip, Config.BlipColor or 49)
	SetBlipScale(pokerBlip, Config.BlipScale or 0.8)
	SetBlipAsShortRange(pokerBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config.Strings[Config.Language]['blip_name'])
	EndTextCommandSetBlipName(pokerBlip)
end) ]]

function PokerRequestModel(model, cb)
	if not HasModelLoaded(model) and IsModelInCdimage(model) then
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
	end

	if cb ~= nil then
		cb()
	end
end

function SpawnObject(model, coords, cb, networked)
    
	local vector = type(coords) == "vector3" and coords or vec(coords.x, coords.y, coords.z)
	networked = networked == nil and true or false
	CreateThread(function()
		PokerRequestModel(model)
		
		-- The below has to be done just for CreateObject since for some reason CreateObjects model argument is set
		-- as an Object instead of a hash so it doesn't automatically hash the item
		model = type(model) == 'number' and model or GetHashKey(model)
		local obj = CreateObject(model, vector.xyz, networked, false, true)
		if cb then
			cb(obj)
		end
	end)
end

function ShowHelpNotification(msg, thisFrame, beep, duration)
	AddTextEntry('dzpHelpNotification', msg)

	if thisFrame then
		DisplayHelpTextThisFrame('dzpHelpNotification', false)
	else
		if beep == nil then beep = true end
		BeginTextCommandDisplayHelp('dzpHelpNotification')
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end

-- If you want to switch ESX.ShowNotification with something else:
-- 1) Comment out the function
-- 2) add your own
RegisterNetEvent('dzp:Notification')
AddEventHandler('dzp:Notification', function(msg)
    TriggerEvent('DoLongHudText',msg)
end)

-- If you want to switch ESX.ShowNotification with something else:
-- 1) Comment out the function
-- 2) add your own
function ShowNotificationMsg(msg)
	--ShowNotification(msg)
    TriggerEvent('DoLongHudText',msg)
end