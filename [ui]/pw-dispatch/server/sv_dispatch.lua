
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local calls = {}

function getCalls()
    return calls
end

local CallSigns = {}
function GetCallsign(id)
    local result = MySQL.query.await([[SELECT callsign FROM users WHERE id = ?]], { id })
    if result[1] ~= nil and result[1].callsign ~= nil then
         return result[1].callsign
    else
        return 0
    end
end

function removeCall(pCallId)
    if calls and calls[pCallId] then
        calls[pCallId] = nil
        return true
    end
    return false
end


function addUnit(player, callid)
    if not calls[callid] then return end
    local xPlayer = ESX.GetPlayerFromIdCard(player)
    local cid = xPlayer.id

    if #calls[callid]["units"] > 0 then
        for i, v in ipairs(calls[callid]["units"]) do
            if v.cid == cid then
                return (#calls[callid]["units"])
            end
        end
    end

    local name = xPlayer.getName()
    local job = xPlayer.getJob()
    local jobName = xPlayer.getJob().name
    local callsign = GetCallsign(xPlayer.id)

    table.insert(calls[callid]["units"], {
        cid = cid,
        fullname = name,
        job = jobName,
        callsign = callsign
    })

    return (#calls[callid]["units"])
end

function removeUnit(player, callid)
    if not calls[callid] then return end
    local xPlayer = ESX.GetPlayerFromIdCard(player)
    local cid = xPlayer.id

    if #calls[callid]["units"] > 0 then
        for i, v in ipairs(calls[callid]["units"]) do
            if v.cid == cid then
                table.remove(calls[callid]["units"], i)
                break
            end
        end
    end

    return (#calls[callid]["units"])
end

function getUnits(callid)
    if not calls[callid] then return end

    return (calls[callid]["units"])
end

function sendCallResponse(player, callid, message, time)
    if not calls[callid] then return false end

    table.insert(calls[callid]["responses"], {
        name = player,
        message = message,
        time = time
    })

    local player = calls[callid]["source"]
    if GetPlayerPing(player) > 0 then
        TriggerClientEvent("dispatch:getCallResponse", player, message)
    end

    return true
end

function getCallReponses(callid)
    if calls[callid] then
        return (calls[callid]["responses"])
    else
        return {}
    end
end

--[[

    Exports

]]

exports("getCalls", getCalls)
exports("removeCall", removeCall)
exports("addUnit", addUnit)
exports("removeUnit", removeUnit)
exports("getUnits", getUnits)
exports("sendCallResponse", sendCallResponse)
exports("getCallReponses", getCallReponses)

--[[

    Events

]]

RegisterNetEvent("dispatch:svNotify")
AddEventHandler("dispatch:svNotify", function(data)
	local newId = #calls + 1

    data["source"] = source
    data["callId"] = newId
    data["units"] = {}
    data["responses"] = {}
    data["time"] = os.time() * 1000

    calls[newId] = data

    TriggerClientEvent("dispatch:clNotify", -1, data, newId, source)

    if data["dispatchCode"] == "911" or data["dispatchCode"] == "311" then
        TriggerClientEvent("erp-dispatch:setBlip", -1, data["dispatchCode"], vector3(data["origin"]["x"], data["origin"]["y"], data["origin"]["z"]), newId)
    end
end)

--[[

    RPCs

]]

RPC.register("pw-dispatch:getCall", function(src, pCall)
    if not pCall then return end

    if calls[pCall] then
        return calls[pCall]
    else
        return
    end
end)



RegisterCommand("setcallsign", function(source, args)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local identifier = xPlayer.getIdentifier()

    if job ~= nil then
        if Config and Config.AllowedJobs and Config.AllowedJobs[job] ~= nil and Config.AllowedJobs[job] == true then
            if args[1] == 'show' then
                local Result = MySQL.Sync.fetchAll('SELECT callsign FROM users WHERE identifier=@identifier', {['@identifier'] = identifier})
                if Result ~= nil and Result[1] ~= nil and Result[1].callsign ~= nil then
                    if Config and Config.Server_Locales[Config.Language]['callsign_show'] ~= nil then
                        AvengersWater('success_notif', _source, Config.Server_Locales[Config.Language]['callsign_show'], Result[1].callsign)
                    else
                        ErrorLocale('callsign_show')
                    end

                else

                    if Config and Config.Server_Locales[Config.Language]['callsign_empty_1'] ~= nil then
                        AvengersWater('error_notif', _source, Config.Server_Locales[Config.Language]['callsign_empty_1'])
                    else
                        ErrorLocale('callsign_empty_1')
                    end
                end

            elseif args[1] == 'set' then

                if args[2] ~= nil then
                    MySQL.Sync.execute('UPDATE users SET callsign=@callsign WHERE identifier=@identifier', {['@callsign'] = args[2], ['@identifier'] = identifier})
                    TriggerClientEvent('cd_dispatch:Callsign', _source, args[2])
                    GlobalInfo[_source].callsign = args[2]

                    if Config and Config.Server_Locales[Config.Language]['callsign_set'] ~= nil then
                        AvengersWater('success_notif', _source, Config.Server_Locales[Config.Language]['callsign_set'], args[2])
                    else
                        ErrorLocale('callsign_set')
                    end
                else
                    if Config and Config.Server_Locales[Config.Language]['callsign_empty_2'] ~= nil then
                        AvengersWater('error_notif', _source, Config.Server_Locales[Config.Language]['callsign_empty_2'])
                    else
                        ErrorLocale('callsign_empty_2')
                    end
                end
            elseif args[1] == 'delete' then
                MySQL.Sync.execute('UPDATE users SET callsign=@callsign WHERE identifier=@identifier', {['@callsign'] = nil, ['@identifier'] = identifier})
                GlobalInfo[_source].callsign = 'NULL'
                if Config and Config.Server_Locales[Config.Language]['callsign_deleted'] ~= nil then
                    AvengersWater('success_notif', _source, Config.Server_Locales[Config.Language]['callsign_deleted'])
                else
                    ErrorLocale('callsign_deleted')
                end
            else
                if Config and Config.Server_Locales[Config.Language]['callsign_invalidformat'] ~= nil then
                    AvengersWater('error_notif', _source, Config.Server_Locales[Config.Language]['callsign_invalidformat'])
                else
                    ErrorLocale('callsign_invalidformat')
                end
            end
        else
            if Config and Config.Server_Locales[Config.Language]['callsign_invalidperms'] ~= nil then
                AvengersWater('error_notif', _source, Config.Server_Locales[Config.Language]['callsign_invalidperms'])
            else
                ErrorLocale('callsign_invalidperms')
            end
        end
    end
end)

