
ESX = nil
local itemList, jobList = {}, {}
PW = {}
TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

AddEventHandler('onResourceStart', function()
    MySQL.ready(function ()
        MySQL.Async.fetchAll('SELECT name, label FROM items',{}, function(result)
            itemList = result
        end)

        MySQL.Async.fetchAll('SELECT * FROM jobs ORDER BY name <>  "unemployed", name',{}, function(result)
            for i=1, #result, 1 do
                MySQL.Async.fetchAll('SELECT grade, label FROM job_grades WHERE job_name = @job',{["@job"] = result[i].name}, function(result2)
                    table.insert(jobList, {name = result[i].name, label = result[i].label, ranks = result2})
                end)
            end
        end)
    end)
end)

AddEventHandler("playerConnecting", function(name, setReason, deferrals)
    local player = source
    local identifier
    for k,v in ipairs(GetPlayerIdentifiers(player)) do
        if string.match(v, 'license') then
            identifier = v
            break
        end
    end

    deferrals.defer()
    deferrals.update("Checking Ban Status.")
    
    MySQL.Async.fetchAll('SELECT * FROM bans WHERE license = @license', {
        ['@license'] = identifier
    }, function(result)
        if result[1] then
            if result[1].time ~= 0 then
            	if result[1].time < os.time() then
            		Unban(result[1].license)
            		deferrals.done()
            		return
            	end

            	local time = math.floor((result[1].time - os.time()) / 60)
                deferrals.done("[PW] Bạn tạm thời bị cấm "..time.." phút Vì: "..result[1].reason)
            else
                deferrals.done("[PW] Bạn đã bị cấm vĩnh viễn vì lý do: "..result[1].reason)
            end
        else
            deferrals.done()
        end
    end)
end)


--[Fetch User Rank CallBack]
ESX.RegisterServerCallback("esx_marker:fetchUserRank", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player then
        local playerGroup = player.getGroup()

        if playerGroup then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)

ESX.RegisterServerCallback("PW:getPlayers", function(source,cb)
    local data = {}
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        data[i] = {
            identifier = xPlayer.getIdentifier(),
            playerid = xPlayers[i],
            group = xPlayer.getGroup(),
    	    rpname = xPlayer.getName(),
    	    cash = xPlayer.getMoney(), 
            bank = xPlayer.getAccount("bank").money,
    	    name = GetPlayerName(xPlayers[i])
        }
    end

    cb(data)
end)

ESX.RegisterServerCallback("PW:getItemList", function(source,cb)
    cb(itemList)
 end)

ESX.RegisterServerCallback("PW:getBanList", function(source,cb)
    MySQL.Async.fetchAll('SELECT * FROM bans',{}, function(result)
    	for i=1, #result, 1 do
    		result[i].time = math.floor((result[i].time - os.time()) / 60)
    	end
        	cb(result)
      end)
 end)

ESX.RegisterServerCallback("PW:getJobs", function(source,cb)
    cb(jobList)
 end)

Kick = function(playerID, reason)
    DropPlayer(playerID, reason)
end

Ban = function(playerID, time, reason)
    local xPlayer = ESX.GetPlayerFromId(playerID)
    if time ~= 0 then
    	local timeToSeconds = time * 60
    	time = (os.time() + timeToSeconds)
    end

    MySQL.Async.execute('INSERT INTO bans (license, name, time, reason) VALUES (@license, @name, @time, @reason)',
        {   
            ['license'] = xPlayer.getIdentifier(), 
            ['name'] = GetPlayerName(playerID), 
            ['time'] = time, 
            ['reason'] = reason 
        },
        function(insertId)
            DropPlayer(playerID, "Bạn đã bị cấm")
    end)
end

Unban = function(license)
    MySQL.Async.execute('DELETE FROM bans WHERE license = @license',
        {   
            ['license'] = license, 
        },
        function(insertId)
            print("player unbanned")
    end)
end

AddWeapon = function(playerID, selectedWeapon, ammo)
    xPlayer = ESX.GetPlayerFromId(playerID)
    if xPlayer.hasWeapon(selectedWeapon) then
        xPlayer.addWeaponAmmo(selectedWeapon, 50)
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Đã thêm đạn vào vũ khí của bạn') 
    else
        xPlayer.addWeapon(selectedWeapon, ammo)
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Bạn đã được cho một '..ESX.GetWeaponLabel(selectedWeapon)) 
    end
end

AddCash = function(playerID, amount)
    xPlayer = ESX.GetPlayerFromId(playerID)
    xPlayer.addMoney(amount)
end

AddBank = function(playerID, amount)
    xPlayer = ESX.GetPlayerFromId(playerID)
    xPlayer.addAccountMoney("bank", amount)
end

AddItem = function(playerID, selectedItem, amount)
    local xPlayer = ESX.GetPlayerFromId(playerID)
    xPlayer.addInventoryItem(selectedItem, amount)
end

Teleport = function(targetId, action)
    local xPlayer, xTarget, sourceMessage, targetMessage
    if source ~= 0 then
        if action == "bring" then
            sourceMessage = "Bạn đã mang một người tới"
            targetMessage = "Bạn đã được tele tới"
            xPlayer = ESX.GetPlayerFromId(source)
            xTarget = ESX.GetPlayerFromId(targetId)
        elseif action == "goto" then
            targetMessage = "Bạn đã teleport tới người chơi"
            xPlayer = ESX.GetPlayerFromId(targetId)
            xTarget = ESX.GetPlayerFromId(source)
        end


        if xTarget then
            local targetCoords = xTarget.getCoords()
            local playerCoords = xPlayer.getCoords()
            xTarget.setCoords(playerCoords)
            if sourceMessage then
                TriggerClientEvent('esx:showNotification', xPlayer.source, sourceMessage)
            end
            TriggerClientEvent('esx:showNotification', xTarget.source, targetMessage)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Người chơi không online.')        
        end
    end
end

RegisterNetEvent("PW:GiveWeapon")
AddEventHandler("PW:GiveWeapon", function(playerID, weapon)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanGiveWeapon then
        AddWeapon(playerID, weapon, 10)
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Bạn cho '..GetPlayerName(playerID)..' một '..ESX.GetWeaponLabel(weapon)) 
    else
       Error(source, "noPerms")
    end
end)

RegisterNetEvent("PW:AddItem")
AddEventHandler("PW:AddItem", function(playerID, selectedItem, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanGiveItem then
        AddItem(playerID, selectedItem, amount)
        TriggerClientEvent('esx:showNotification', source, "Cho một "..selectedItem.." cho người chơi "..GetPlayerName(playerID))
    else
       Error(source, "noPerms")
    end
end)


RegisterNetEvent("PW:AddCash")
AddEventHandler("PW:AddCash", function (playerID, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanAddCash then
        AddCash(playerID, amount)
        TriggerClientEvent('esx:showNotification', source, "Add $"..amount.." tiền mặt cho "..GetPlayerName(playerID))
    else
       Error(source, "noPerms")
    end
end)

RegisterNetEvent("PW:AddBank")
AddEventHandler("PW:AddBank", function (playerID, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanAddBank then
        AddBank(playerID, amount)
        TriggerClientEvent('esx:showNotification', source, "Add $"..amount.." cho "..GetPlayerName(playerID).." tiền trong ngân hàng")
    else
       Error(source, "noPerms")
    end
end)

RegisterNetEvent('PW:Kick')
AddEventHandler('PW:Kick', function(playerId, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanKick then
        Kick(playerId, reason)
        TriggerClientEvent('esx:showNotification', source, "Kicked "..GetPlayerName(playerId))
    else
       Error(source, "noPerms")
    end
end)

RegisterNetEvent('PW:Ban')
AddEventHandler('PW:Ban', function(playerId, time, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and (Config.Perms[playerGroup].CanBanTemp and time ~= 0) or (Config.Perms[playerGroup].CanBanPerm and time == 0) then
        Ban(playerId, time, reason)
        TriggerClientEvent('esx:showNotification', source, "Banned "..GetPlayerName(playerId))
    else
       Error(source, "noPerms")
    end
end)

RegisterNetEvent("PW:Promote")
AddEventHandler("PW:Promote", function (playerID, group)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    local targetPlayer = ESX.GetPlayerFromId(playerID)
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanPromote then
        if group ~= "superadmin" or playerGroup == "superadmin" then
            targetPlayer.setGroup(group)
            TriggerClientEvent('esx:showNotification', source, "Bổ nhiệm "..GetPlayerName(playerID).." thành "..group)
        end
    else
       Error(source, "noPerms")
    end
end)

RegisterNetEvent("PW:Announcement")
AddEventHandler("PW:Announcement", function (message)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanAnnounce then
        TriggerClientEvent('chat:addMessage', -1, {color = { 255, 0, 0}, args = {"ANNOUNCEMENT ", message}})
    else
       Error(source, "noPerms")
    end
end)

RegisterNetEvent("PW:Notification")
AddEventHandler("PW:Notification", function (playerID, message)
    local _source = playerID
    TriggerClientEvent('chat:addMessage', _source, {args = {"PW ", message}})
end)

RegisterNetEvent("PW:Teleport")
AddEventHandler("PW:Teleport", function (targetId, action)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanTeleport then
        Teleport(targetId, action)
    else
       Error(source, "noPerms")
    end
end)

RegisterNetEvent("PW:Slay")
AddEventHandler("PW:Slay", function (target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanSlay then
        TriggerClientEvent('PW:Slay', target)
        TriggerClientEvent('esx:showNotification', source, "Đã giết "..GetPlayerName(target))
        TriggerClientEvent('esx:showNotification', target, "Bạn bị giết bởi Admin.")
    else
       Error(source, "noPerms")
    end
end)

RegisterNetEvent("PW:God")
AddEventHandler("PW:God", function (target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanGodmode then
        TriggerClientEvent('PW:God', target)
        TriggerClientEvent('esx:showNotification', source, "You enabled/disabled Godmode for "..GetPlayerName(target))
    else
       Error(source, "noPerms")
    end
end)

RegisterNetEvent("PW:Freeze")
AddEventHandler("PW:Freeze", function (target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanFreeze then
        TriggerClientEvent('PW:Freeze', target)
        TriggerClientEvent('esx:showNotification', source, "You Froze/Unfroze "..GetPlayerName(target))
    else
       Error(source, "noPerms")
    end
end)

RegisterNetEvent("PW:Unban")
AddEventHandler("PW:Unban", function(license)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanUnban then
        Unban(license)
        TriggerClientEvent('esx:showNotification', source, "Unban người chơi. ("..license..")")
    else
       Error(source, "noPerms")
    end
end)

RegisterNetEvent("PW:setJob")
AddEventHandler("PW:setJob", function(target, job, rank)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanSetJob then
        targetPlayer.setJob(job, rank)
        TriggerClientEvent('esx:showNotification', source, "Đổi nghề của  "..GetPlayerName(target).." thành "..job)
        TriggerClientEvent('esx:showNotification', target, "Your job was changed to "..job)
    else
       Error(source, "noPerms")
    end
end)

RegisterNetEvent("PW:revive")
AddEventHandler("PW:revive", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanRevive then
        targetPlayer.triggerEvent('esx_ambulancejob:revive')
        TriggerClientEvent('esx:showNotification', source, "Hồi sinh "..GetPlayerName(target))
        TriggerClientEvent('esx:showNotification', target, "Bạn được hồi sinh bởi admin")
    else
       Error(source, "noPerms")
    end
end)

Error = function(source, message)
    if message == "noPerms" then
        TriggerClientEvent('chat:addMessage', source, {args = {"PW ", " You do not have permission for this."}})
    else
        TriggerClientEvent('chat:addMessage', source, {args = {"PW ", message}})
    end
end

function split(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end