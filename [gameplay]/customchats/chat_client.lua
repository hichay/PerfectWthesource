ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local function trim(s)
  return s:match'^%s*(.*%S)' or ''
end

local chatInputActive = false
AddEventHandler('chatbox_wheelmenu', function(toggle)
    chatInputActive = toggle
end)

-- proximity chat
RegisterNetEvent('sendGlobalMessage')
AddEventHandler('sendGlobalMessage', function(name, message, avatar, awesome, noimage)
    if noimage == nil then
		print('ươ')
        local URLS = {}
        local pattern = "https?://[%w-_%.%?%.:/%+=&]+"
        :: start ::
        local a, b =message:find(pattern)
        if a and b then
            local url = message:sub(a, b)
            message = message:sub(1, a-1)..message:sub(b+1, message:len())
            if url:find(".jpg") or url:find(".jpeg") or url:find(".png") or url:find(".bmp") or url:find(".gif") or url:find(".webp") or url:find(".svg") then
                table.insert(URLS, url)
            end
            goto start
        end
        for k,url in pairs(URLS) do
            message = message.."<img class='chatImage' src='"..url.."' onerror='imageerror(this)'>"
        end
    end

    TriggerEvent('chatMessage',name, {255, 255, 255}, message, avatar, awesome)
end)

-- custom chat
local hidechat = false
AddEventHandler('ui:toggle', function(toggle)
    hidechat = not toggle
    if not toggle then
        SendNUIMessage({action = "hidechat"})
    end
end)

AddEventHandler('customchats:hidechat', function()
    SendNUIMessage({action = "hidechat"})
end)

RegisterNetEvent('chatMessage')
AddEventHandler('chatMessage', function(name, color, message, avatar, awesome)
	print(name,message,avatar)
    SendNUIMessage({
        avatar = avatar or "https://www.darkrpth.com/images/logo.png",
        name = name,
        color = color,
        message = message,
        awesome = awesome or "",
        hidechat = hidechat,
		safezone = ESX.getMapPosition(),
    })
end)

RegisterNUICallback('chatResult', function(data, cb)
    ExitChat()
	if data.message:sub(1, 1) == '/' then
		ExecuteCommand(data.message:sub(2))
	else
        TriggerEvent("TextChatLocal", data.message, GetEntityCoords(PlayerPedId()))
        TriggerServerEvent('chatMessageEntered', data.message)
    end
end)

RegisterCommand('+customchats', function()
    if not NetworkIsInSession() or not NetworkIsPlayerActive(PlayerId()) then
        return
    end
    if not chatInputActive then
        chatInputActive = true
        TriggerEvent("chatbox_wheelmenu", chatInputActive)
        SetNuiFocus(chatInputActive)
        SendNUIMessage({
            meta = 'openChatBox',
            safezone = ESX.getMapPosition(),
        })
        ESX.Streaming.RequestAnimDict("random@arrests")
        TaskPlayAnim(PlayerPedId(), "random@arrests", "generic_radio_chatter", 8.0001, -8.0001, -1 , 49, 0, 0, 0, 0)
    end
end, false)
RegisterCommand('-customchats', function()
end, false)
RegisterKeyMapping('+customchats', 'Chat', 'keyboard', 't')

function ExitChat()
    SetNuiFocus(false)
    StopAnimTask(PlayerPedId(), "random@arrests", "generic_radio_chatter", -1)
    Citizen.Wait(400)
    chatInputActive = false
    TriggerEvent("chatbox_wheelmenu", chatInputActive)
end
RegisterNUICallback('exit', function()
    ExitChat()
end)
RegisterCommand('+customchats_exit', function()
    if chatInputActive then
        ExitChat()
    end
end, false)
RegisterCommand('-customchats_exit', function()
end, false)
RegisterKeyMapping('+customchats_exit', 'Chat Exit', 'keyboard', 'ESCAPE')

local CurrentTextPlayersCount = {}
local TextHight = {}
local StreamImageID = {
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false,
    [6] = false,
    [7] = false,
    [8] = false,
}
RegisterNetEvent('ProximityTextChatLocal')
AddEventHandler('ProximityTextChatLocal', function(sender, message, type)
    local playerId = GetPlayerFromServerId(sender)
	print(sender)
    --if playerId ~= -1 then
		print('dsa')
        local playerPed = GetPlayerPed(playerId)
        local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(playerPed))
        if dist < 40 then
            local playerData = ESX.GetPlayerData()
			--TriggerEvent('table',ESX.GetPlayerData())
            local textTime = GetGameTimer()
            if CurrentTextPlayersCount[sender] == nil then
                CurrentTextPlayersCount[sender] = 0
            else
                CurrentTextPlayersCount[sender] = CurrentTextPlayersCount[sender]+1
            end

            if TextHight[textTime] == nil then
                TextHight[textTime] = {sender=sender, count=CurrentTextPlayersCount[sender]}
            else
                TextHight[textTime].count = CurrentTextPlayersCount[sender]
            end
            if type == "Tchat" then
				-- reporter - mecano -ambulance -twitter - police
                if GetPedDrawableVariation(playerPed, 1) == 0 then
                    TriggerEvent('sendGlobalMessage', "[^*^3"..playerData.id.."^r] "..sender , message, "https://www.pngrepo.com/png/61216/512/thief.png")
                else -- Mask
                    TriggerEvent('sendGlobalMessage', "^1Ẩn danh", message, "https://www.pngrepo.com/png/61216/512/thief.png")
                end
            end

            if dist < 20 then
                local scale = 0.08
                local width = 1280
                local height = 720
                local form = nil
                local duiObj = nil
                local imageURL = nil
                local pattern = "https?://[%w-_%.%?%.:/%+=&]+"
                local a, b =message:find(pattern)
                local streamImage = 0
                if a and b then
                    imageURL = message:sub(a, b)
                    if imageURL:find(".jpg") or imageURL:find(".jpeg") or imageURL:find(".png") or imageURL:find(".bmp") or imageURL:find(".gif") or imageURL:find(".webp") or imageURL:find(".svg") then
                        duiObj = CreateDui(imageURL, width, height)
                        ::start::
                        streamImage = streamImage+1
                        if StreamImageID[streamImage] and streamImage < 10 then
                            goto start
                        end
                        StreamImageID[streamImage] = true
                        form = Scaleform.Request('generic_texture_renderer_chat'..streamImage)
                        form:CallFunction("SET_TEXTURE", 'meows', 'woof', 0, 0, width, height)
                        CreateRuntimeTextureFromDuiHandle(CreateRuntimeTxd('meows'), 'woof', GetDuiHandle(duiObj))
                        message = message:sub(1, a-1)..message:sub(b+1, message:len())
                        CurrentTextPlayersCount[sender] = CurrentTextPlayersCount[sender]+7
                    end
                end

                while GetGameTimer() - textTime < 10000 do
                    local coords = GetOffsetFromEntityInWorldCoords(playerPed, false)
                    local heading = GetGameplayCamRot().z
                    local xVector = math.sin(math.rad(heading+90.0)) * -1.0000
                    local yVector = math.cos(math.rad(heading+90.0))
                    if imageURL then
                        local scale = scale* (1/GetGameplayCamFov())*50
                        form:Render3D({x=coords.x+xVector, y=coords.y+yVector, z=coords.z+2.1+(0.15*TextHight[textTime].count)}, {x=0.0, y=0.0, z=heading*-1}, scale*1, scale*(9/16), 1)
                    end
                    if message ~= "" and message ~= " " then
                        if type == "twitter" then
                            Draw3DText(coords.x, coords.y, coords.z+1.1+(0.15*TextHight[textTime].count), "🐦 "..message)
                        else
                            Draw3DText(coords.x, coords.y, coords.z+1.1+(0.15*TextHight[textTime].count), "💬 "..message)
                        end
                    end
                    Citizen.Wait(1)
                end
                for k,v in pairs(TextHight) do
                    if v.sender == sender then
                        if imageURL then
                            TextHight[k].count = TextHight[k].count-8
                        else
                            TextHight[k].count = TextHight[k].count-1
                        end
                    end
                end
                TextHight[textTime] = nil

                if imageURL then
                    DestroyDui(duiObj)
                    form:Dispose()
                    StreamImageID[streamImage]= false
                    CurrentTextPlayersCount[sender] = CurrentTextPlayersCount[sender]-8
                else
                    CurrentTextPlayersCount[sender] = CurrentTextPlayersCount[sender]-1
                end

                if CurrentTextPlayersCount[sender] < 0 then
                    CurrentTextPlayersCount[sender] = nil
                end
            end
        end
    --end
end)

Citizen.CreateThread(function()
    RegisterFontFile('DarkRP') -- the name of your .gfx, without .gfx
    fontId = RegisterFontId('DarkRP')

    SetTextChatEnabled(false)
end)

function Draw3DText(x, y, z, text)
    local onScreen,_x,_y=SetDrawOrigin(x,y,z)
    if onScreen then
        local px,py,pz=table.unpack(GetGameplayCamCoords())
        local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)
        local scale = (1/dist)*4
        local fov = (1/GetGameplayCamFov())*100
        local scale = scale*fov
        SetTextScale(0.0*scale, 0.25*scale)
        SetTextFont(ESX.FontId)
        SetTextProportional(true)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextCentre(true)
        SetTextEntry("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(_x,_y)
        ClearDrawOrigin()
    end
end

AddEventHandler('IsPauseMenuActive', function(toggle)
    SendNUIMessage({
        action = 'toggle_chat',
        toggle = toggle,
    })
end)


