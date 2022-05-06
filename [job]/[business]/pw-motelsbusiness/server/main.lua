ExecuteSQL = function (query, cb)
    local rtndata = {}
    if Cfg.SqlType == "mysql" then
      if MySQL then
          return MySQL.Sync.execute(query, {})
      end
    elseif Cfg.SqlType == "ghmattimysql" then
        return exports['ghmattimysql']:executeSync(query, {})
    else
      error(_U['notsupporteddatabase'])
    end
    return rtndata
end

function GetProperty(id, Prop)
    local text = "**"..Prop.."** \n" ..GetPlayerName(id).." ("..id..")"
    if Cfg.LogSystem == 'custom' then
        
        if GetResourceState('mx-logsystem') ~= 'missing' then
            text = exports['mx-logsystem']:GetProperty(id, Prop)
        else
            print('^1 [PW-MOTELS] ^0 : '.._U['nothavemx_log'])
        end
    elseif Cfg.LogSystem == 'standart' then
        for k,v in pairs(GetPlayerIdentifiers(id)) do
            if string.sub(v, tonumber('1'), string.len("steam:")) == "steam:" then
                text = text.."\n**".._U['log_steam'].."** \n"..v
            elseif string.sub(v, tonumber('1'), string.len("license:")) == "license:" then
                text = text.."\n**".._U['log_license'].."** \n"..v
            end
        end
    end
    return text
end
  
function Identifier(player)
    if Cfg.identifierType == "citizenid" then
        return player.citizenid
    elseif Cfg.identifierType == "identifier" then
        return player.identifier
    else
        return false
    end
end

function AccessCheck(player)
    if Cfg.QBCore then
        for i = 1, #Cfg.AdminOptions.privatePermissions do
            if ESX.Functions.HasPermission(player.source, Cfg.AdminOptions.privatePermissions[i]) then
                return true
            end
        end 
    else
        for i = 1, #Cfg.AdminOptions.privatePermissions do
            if player.getGroup() == Cfg.AdminOptions.privatePermissions[i] then
                return true
            end
        end
    end
    return false
end

Notification = function(player, msg)
    if type(Cfg.notify.arg) == 'table' then
        if Cfg.notify.arg.text then
            Cfg.notify.arg.text = '%s'
            Cfg.notify.arg.text = tostring(Cfg.notify.arg.text):format(msg)
        end
    elseif type(Cfg.notify.arg) == 'string' then
        Cfg.notify.arg = '%s'
        Cfg.notify.arg = tostring(Cfg.notify.arg):format(msg)
    end
    TriggerClientEvent(Cfg.notify.event, player, Cfg.notify.arg, Cfg.notify.arg2)
end

local StringCharset = {}
local NumberCharset = {}

for i = tonumber('48'),  tonumber('57') do table.insert(NumberCharset, string.char(i)) end
for i = tonumber('65'),  tonumber('90') do table.insert(StringCharset, string.char(i)) end
for i = tonumber('97'), tonumber('122') do table.insert(StringCharset, string.char(i)) end

RandomStr = function(length)
	if length > tonumber('0') then
		return RandomStr(length-tonumber('1')) .. StringCharset[math.random(tonumber('1'), #StringCharset)]
	else
		return ''
	end
end

RandomInt = function(length)
	if length > tonumber('0') then
		return RandomInt(length-tonumber('1')) .. NumberCharset[math.random(tonumber('1'), #NumberCharset)]
	else
		return ''
	end
end

function PlayerName(player)
    local veri = {}
    if not Cfg.QBCore then
        if player then
            if Cfg.charinfosystem then
                if Cfg.identifierType == "citizenid" then
                    local result = FetchSQL("SELECT charinfo FROM users WHERE citizenid = '"..Identifier(player).."'")
                    if result and result[tonumber('1')] then
                        local data = json.decode(result[tonumber('1')].charinfo)
                        veri.firstname = data.firstname or '...'
                        veri.lastname = data.lastname or '...'
                    else
                        print('^1 [PW-MOTELS] ^0 '.._U['notfoundedplayer'])
                    end
                elseif Cfg.identifierType == "identifier" then
                    local result = FetchSQL("SELECT charinfo FROM users WHERE identifier = '"..Identifier(player).."'")
                    if result and result[tonumber('1')] then
                        local data = json.decode(result[tonumber('1')].charinfo)
                        veri.firstname = data.firstname or '...'
                        veri.lastname = data.lastname or '...'
                    else
                        print('^1 [PW-MOTELS] ^0 '.._U['notfoundedplayer'])
                    end
                end
            else
                if Cfg.identifierType == "citizenid" then
                    local result = FetchSQL("SELECT firstname, lastname FROM users WHERE citizenid = '"..Identifier(player).."'")
                    if result and result[tonumber('1')] then
                        veri.firstname = result[tonumber('1')].firstname or '...'
                        veri.lastname = result[tonumber('1')].lastname or '...'
                    else
                        print('^1 [PW-MOTELS] ^0 '.._U['notfoundedplayer'])
                    end
                elseif Cfg.identifierType == "identifier" then
                    local result = FetchSQL("SELECT firstname, lastname FROM users WHERE identifier = '"..Identifier(player).."'")
                    if result and result[tonumber('1')] then
                        veri.firstname = result[tonumber('1')].firstname or '...'
                        veri.lastname = result[tonumber('1')].lastname or '...'
                    else
                        print('^1 [PW-MOTELS] ^0 '.._U['notfoundedplayer'])
                    end
                end
            end
        else
            print('^1 [PW-MOTELS] ^0 ESX !'.._U['notfoundedplayer'])
        end
    else
        if player then
            local result = FetchSQL("SELECT charinfo FROM players WHERE citizenid = '"..Identifier(player).."'")
            if result and result[tonumber('1')] then
                local data = json.decode(result[tonumber('1')].charinfo)
                veri.firstname = data.firstname or '...'
                veri.lastname = data.lastname or '...'
            else
                print('^1 [PW-MOTELS] ^0 '.._U['notfoundedplayer'])
            end
        else
            print('^1 [PW-MOTELS] ^0 ESX !'.._U['notfoundedplayer'])
        end
    end 
    return veri
end

function GetPlayerFrom(player)
    if not Cfg.QBCore then
        if player then
            if Cfg.identifierType == "citizenid" then
                return ESX.GetPlayerFromCitizenId(player)
            elseif Cfg.identifierType == "identifier" then
                return ESX.GetPlayerFromIdentifier(player)
            else
                return nil
            end
        end
    else
        if player then
            return ESX.Functions.GetPlayerByCitizenId(player) and ESX.Functions.GetPlayerByCitizenId(player).PlayerData or nil
        end
    end
    return nil
end

function GetMoney(id)
    if not Cfg.QBCore then
        return ESX.GetPlayerFromId(id).getMoney()
    else
        return ESX.Functions.GetPlayer(id).PlayerData.money.cash
    end
    return nil
end

function RemoveMoney(id, price)
    if not Cfg.QBCore then
        return ESX.GetPlayerFromId(id).removeMoney(price)
    else
        return ESX.Functions.GetPlayer(id).Functions.RemoveMoney('cash', price)
    end
    return nil
end

function AddMoney(id, price)
    if not Cfg.QBCore then
        return ESX.GetPlayerFromId(id).addMoney(price)
    else
        return ESX.Functions.GetPlayer(id).Functions.AddMoney('cash', price)
    end
    return nil
end

function AddAccountMoney(id, type, money)
    if not Cfg.QBCore then
        return ESX.GetPlayerFromId(id).addAccountMoney(type, money)
    else
        return ESX.Functions.GetPlayer(id).Functions.AddMoney(type, money)
    end
    return nil
end

function AddInventoryItem(id, ...)
    if not Cfg.QBCore then
        return ESX.GetPlayerFromId(id).addInventoryItem(...)
		
    else
        return ESX.Functions.GetPlayer(id).Functions.AddItem(...)
    end
    return nil
end

function GetPermissionName(method)
    if method == "kick" then
        return _U['reception_employeeKickGrade']
    elseif method == "change" then
        return _U['reception_employeeChangeGrade']
    elseif method == "timerefresh" then
        return _U['reception_employeeTimeRefGrade']
    elseif method == "createnewkey" then
        return _U['reception_employeeCreateNewKeyGrade']
    elseif method == "sendmessage" then
        return _U['reception_employeeSendMessageGrade']
    elseif method == "takeplayer" then
        return _U['reception_employeeTakePlayer']
    elseif method == "showrequests" then
        return _U['reception_employeeShowRequests']
    elseif method == "takeMoney" then
        return _U['reception_employeeTakeSocietyMoney']
    elseif method == "depositMoney" then
        return _U['reception_employeeDepositSocietyMoney']
    elseif method == "updateStatus" then
        return _U['reception_employeeUpdateStatus']
    else
        return ""
    end
end

function GetRequestName(method)
    if method == "requestRefreshTime" then
        return _U['reception_requestRefreshTime']
    elseif method == "requestChangeRoom" then
        return _U['reception_requestChangeRoom']
    elseif method == "requestEmployee" then
        return _U['reception_requestgetEmployee']
    elseif method == "requestKey" then
        return _U['reception_requestKey']
    else
        return ""
    end
end

function SendLog(source, value, name, color, webhook)
    if Cfg.LogSystem == 'custom' then
        TriggerEvent('mx-logsystem:sendMotelWebhook', source, value, name, color, webhook)
    else
        local connect = {
            {
                ["color"] = color,
    
                ["footer"] = {
                    ["text"] = "Made By MOXHA#4250",
                },
    
                ["author"] = {
                  ["name"] = "MOTEL - LOG",
                },
    
                ["fields"] = {
                    {
                        ["name"] = name,
                        ["value"] = value,
                        ["inline"] = true
                    },
                }
            }
        }
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "MOXHA", embeds = connect, avatar_url = "https://cdn.discordapp.com/attachments/744160373099462727/788702900272627732/Screenshot_1.png"}), { ['Content-Type'] = 'application/json' })  
    end
end
  
FetchSQL = function (query, dat)
    local rtndata = {}
    if Cfg.SqlType == "mysql" then
        if MySQL then
            return MySQL.Sync.fetchAll(query, dat or {})
        else
            error(_U['notsupporteddatabase'])
        end
      elseif Cfg.SqlType == "ghmattimysql" then
        return exports['ghmattimysql']:executeSync(query, dat or {})
    else
        error(_U['notsupporteddatabase'])
    end
    return false
end
  
function GetTimer(target)
    local text = "0"
    if PlayersMotels[target] then
        if PlayersMotels[target].rentcycle then
            if PlayersMotels[target].rentcycle <= tonumber('60000') then
                text = tostring(math.floor(PlayersMotels[target].rentcycle/tonumber('1000')))..' '.._U['second']
            elseif PlayersMotels[target].rentcycle > tonumber('60000') and PlayersMotels[target].rentcycle < tonumber('3600000') then
                text = tostring(math.floor(PlayersMotels[target].rentcycle/tonumber('60000')))..' '.._U['minute']
            elseif PlayersMotels[target].rentcycle >= tonumber('3600000') and PlayersMotels[target].rentcycle < 86400000 then
                text = tostring(Round(PlayersMotels[target].rentcycle/3600000))..' '.._U['hour']
            elseif PlayersMotels[target].rentcycle >= 86400000 then
                text = tostring(math.floor(PlayersMotels[target].rentcycle/86400000))..' '.._U['day']
            end
        end
    end
    return text
end

function Round(number)
    local power = 10^1
    return math.floor(number * power) / power
end