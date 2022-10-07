ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')
local MutedPlayers = {}
local ChattedPlayers = {}
-- this is a built-in event, but somehow needs to be registered
RegisterNetEvent('playerJoining')

exports('addMessage', function(target, message)
    if not message then
        message = target
        target = -1
    end

    if not target or not message then return end

    TriggerClientEvent('chat:addMessage', target, message)
end)

local hooks = {}
local hookIdx = 1

exports('registerMessageHook', function(hook)
    local resource = GetInvokingResource()
    hooks[hookIdx + 1] = {
        fn = hook,
        resource = resource
    }

    hookIdx = hookIdx + 1
end)

local modes = {
    {
        name = 'game',
        displayName = 'Game',
        color = '#ffff',
        hidden = true,
        isGlobal = false,
        isChannel = true,
    },
    {
        name = 'ooc',
        displayName = 'OOC',
        color = '#ffff',
        hidden = false,
        isGlobal = false,
        isChannel = true,
    },
--[[ {
name = 'hidden',
displayName = 'Hidden',
color = '#ffff',
hidden = true,
isGlobal = false,
isChannel = false,
},
{
name = 'dispatch',
displayName = 'Dispatch',
color = '#ffff',
hidden = true,
isGlobal = false,
isChannel = false,
}, ]]



}


local function getMatchingPlayers(seObject)
    local players = GetPlayers()
    local retval = {}

    for _, v in ipairs(players) do
        if IsPlayerAceAllowed(v, seObject) then
            retval[#retval + 1] = v
        end
    end

    return retval
end

exports('registerMode', function(modeData)
    if not modeData.name or not modeData.displayName or not modeData.cb then
        return false
    end

    local resource = GetInvokingResource()

    modes[modeData.name] = modeData
    modes[modeData.name].resource = resource

    local clObj = {
        name = modeData.name,
        displayName = modeData.displayName,
        color = modeData.color or '#fff',
        isChannel = modeData.isChannel,
        isGlobal = modeData.isGlobal,
    }

    if not modeData.seObject then
        TriggerClientEvent('chat:addMode', -1, clObj)
    else
        for _, v in ipairs(getMatchingPlayers(modeData.seObject)) do
            TriggerClientEvent('chat:addMode', v, clObj)
        end
    end

    return true
end)

local function unregisterHooks(resource)
    local toRemove = {}

    for k, v in pairs(hooks) do
        if v.resource == resource then
            table.insert(toRemove, k)
        end
    end

    for _, v in ipairs(toRemove) do
        hooks[v] = nil
    end

    toRemove = {}

    for k, v in pairs(modes) do
        if v.resource == resource then
            table.insert(toRemove, k)
        end
    end

    for _, v in ipairs(toRemove) do
        TriggerClientEvent('chat:removeMode', -1, {
            name = v
        })

        modes[v] = nil
    end
end

local function routeMessage(source, author, message, mode, fromConsole)

    local xPlayer = ESX.GetPlayerFromId(source)
    if source >= 1 then
        --author = GetPlayerName(source)
        author = xPlayer.getName()
    end

    local outMessage = {
        color = { 255, 255, 255 },
        multiline = true,
        args = { message },
        channel = mode
    }

    if author ~= "" then
        outMessage.args = { author, message }
    end

    if mode and modes[mode] then
        local modeData = modes[mode]

        if modeData.seObject and not IsPlayerAceAllowed(source, modeData.seObject) then
            return
        end
    end

    local messageCanceled = false
    local routingTarget = -1

    local hookRef = {
        updateMessage = function(t)
            -- shallow merge
            for k, v in pairs(t) do
                if k == 'template' then
                    outMessage['template'] = v:gsub('%{%}', outMessage['template'] or '@default')
                elseif k == 'params' then
                    if not outMessage.params then
                        outMessage.params = {}
                    end

                    for pk, pv in pairs(v) do
                        outMessage.params[pk] = pv
                    end
                else
                    outMessage[k] = v
                end
            end
        end,

        cancel = function()
            messageCanceled = true
        end,

        setSeObject = function(object)
            routingTarget = getMatchingPlayers(object)
        end,

        setRouting = function(target)
            routingTarget = target
        end
    }

    for _, hook in pairs(hooks) do
        if hook.fn then
            hook.fn(source, outMessage, hookRef)
        end
    end

    if modes[mode] then
        local m = modes[mode]

        m.cb(source, outMessage, hookRef)
    end

    if messageCanceled then
        return
    end

    TriggerEvent('chatMessage', source, #outMessage.args > 1 and outMessage.args[1] or '', outMessage.args[#outMessage.args])

    if not WasEventCanceled() then
        if type(routingTarget) ~= 'table' then
            --if mode == 'ooc' then
                local idnumber = xPlayer.getIdCard()
                if ChattedPlayers[idnumber] then
                    if os.time() < ChattedPlayers[idnumber] then

                        TriggerClientEvent('chatMessage', source, "SYSTEM" , 4, ("^0 Bạn có thể chat OOC lại sau ^1%s giây"):format(math.floor(ChattedPlayers[idnumber] - os.time())))
						--TriggerClientEvent('chatMessage', source, "OOC" , 4, ("^0 Bạn có thể chat OOC lại sau ^1%s giây"):format(math.floor(ChattedPlayers[idnumber] - os.time())))
                        return
                    end
                end
                ChattedPlayers[idnumber] = os.time() + math.floor(30)
                --TriggerClientEvent('chat:addMessage', routingTarget, outMessage)
				TriggerClientEvent('chatMessage', -1, "OOC | "..author.." ["..idnumber.."]" , {163, 62, 48}, message, 'ooc')
            --end
        else
            for _, id in ipairs(routingTarget) do
                --TriggerClientEvent('chat:addMessage', id, outMessage)
                local idnumber = xPlayer.getIdCard()
                if ChattedPlayers[idnumber] then
                    if os.time() < ChattedPlayers[idnumber] then

                        TriggerClientEvent('chatMessage', source, "SYSTEM" , 4, ("^0 Bạn có thể chat OOC lại sau ^1%s giây"):format(math.floor(ChattedPlayers[idnumber] - os.time())))
						TriggerClientEvent('chatMessage', source, "OOC" , 4, ("^0 Bạn có thể chat OOC lại sau ^1%s giây"):format(math.floor(ChattedPlayers[idnumber] - os.time())))
                        return
                    end
                end
                ChattedPlayers[idnumber] = os.time() + math.floor(30)
                TriggerClientEvent('chatMessage', -1, "OOC | "..author.." ["..idnumber.."]" , {163, 62, 48}, message, 'ooc')
            end
        end
    end

    if not fromConsole then
        print(author .. '^7' .. (modes[mode] and (' (' .. modes[mode].displayName .. ')') or '') .. ': ' .. message .. '^7')
    end
end


AddEventHandler('_chat:messageEntered', function(author, color, message, mode)
    if not message or not author then
        return
    end

    local source = source
    routeMessage(source, author, message, mode)
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    -- route the message as if it were a /command
    routeMessage(source, name, '/' .. command, nil, true)

    CancelEvent()
end)

-- player join messages
AddEventHandler('playerJoining', function()
    if GetConvarInt('chat_showJoins', 1) == 0 then
        return
    end
    TriggerClientEvent('chatMessage', -1, '', { 158, 71, 158 }, '^2* ' .. GetPlayerName(source) .. ' vừa connect.' )
end)

AddEventHandler('playerDropped', function(reason)
    if GetConvarInt('chat_showQuits', 1) == 0 then
        return
    end
	
    TriggerClientEvent('chatMessage', -1, '', { 158, 71, 158 } ,'^2* ' .. GetPlayerName(source) ..' vừa thoát (' .. reason .. ')')
end)

RegisterCommand('say', function(source, args, rawCommand)
    routeMessage(source, (source == 0) and 'console' or GetPlayerName(source), rawCommand:sub(5), nil, true)
end)

-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    local source = source
    refreshCommands(source)
    for _, modeData in pairs(modes) do
        local clObj = {
            name = modeData.name,
            displayName = modeData.displayName,
            color = modeData.color or '#fff',
            isChannel = modeData.isChannel,
            isGlobal = modeData.isGlobal,
        }

        if not modeData.seObject or IsPlayerAceAllowed(source, modeData.seObject) then
            TriggerClientEvent('chat:addMode', source, clObj)
        end
    end
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)

AddEventHandler('onResourceStop', function(resName)
    unregisterHooks(resName)
end)

RegisterCommand("mute", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'mod' or xPlayer.getGroup() == "admin" then
        local target = tonumber(args[1])
        local tPlayer = ESX.GetPlayerFromIdCard(target)
        local time = tonumber(args[2])
        local reason = ''

        for i=3, #args, 1 do
            if i > 1 then
                reason = reason .. ' '
                reason = reason .. args[i]
            end
        end

        if tPlayer then
            ChattedPlayers[tPlayer.getIdCard()] = os.time() + time
            TriggerClientEvent('chatMessage', -1,("^1SYSTEM :^0 ^3%s^0 [%s] đã bị mute OOC trong ^1%s giây\nLý do: %s - [%s]"):format(tPlayer.name, tPlayer.getIdCard(target) ,math.floor(time), reason, xPlayer.getName()), {77, 36, 92})
        else
            xPlayer.showNotification("Sai lệnh. /mute [id] [thời-gian-tính theo giây] [lý do]")
        end
    end
end)

RegisterCommand("unmute", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'mod' or xPlayer.getGroup() == "admin" then
        local target = tonumber(args[1])
        local tPlayer = ESX.GetPlayerFromIdCard(target)
        if tPlayer then
            ChattedPlayers[tPlayer.getIdCard()] = 0
            TriggerClientEvent('chatMessage', -1, ("^1SYSTEM :^0 ^3%s^0 [%s] Đã được Unmute OOC\nNgười unmute: %s"):format(tPlayer.name, tPlayer.getIdCard(target) ,xPlayer.getName()), {77, 36, 92})
        else
            xPlayer.showNotification("Sai lệnh. /unmute [id]")
        end
    end
end)

RegisterCommand('ooc', function(source, args, rawCommand)
    if source == 0 then
        print('chat: cant use in rcon!')
        return
    end

    args = table.concat(args, ' ')
    if string.sub(args, 1, string.len('/')) ~= '/' then
        CancelEvent()
        local xPlayer = ESX.GetPlayerFromId(source)
        local name = xPlayer.getName()
        local idnumber = xPlayer.getIdCard()

        if ChattedPlayers[idnumber] then
            if os.time() < ChattedPlayers[idnumber]then
                TriggerClientEvent('chatMessage', source, "SYSTEM" , 4, ("^4 Bạn có thể chat OOC lại sau ^1%s giây"):format(math.floor(ChattedPlayers[idnumber] - os.time())))
                return
            end
        end

        TriggerClientEvent('chatMessage', -1, "OOC | "..name.." ["..idnumber.."]" , {163, 62, 48}, args, 'ooc')
        ChattedPlayers[idnumber] = os.time() + math.floor(30)

    end

end, false)


