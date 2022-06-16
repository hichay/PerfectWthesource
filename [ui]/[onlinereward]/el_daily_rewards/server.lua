ESX = nil
local timecache,collecting = {},{}
local inloop = false

Citizen.CreateThread(function()
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    while ESX==nil do Wait(0) end
end)

function getSteamIdentifier(identifiers)
	for k,v in ipairs(identifiers) do
		if v:find("steam") then return v end
	end
	return nil
end

function copyTbl(obj) -- why? because lua is kinda cancer with table copying
	if type(obj) ~= 'table' then return obj end
	local res = {}
	for k, v in pairs(obj) do res[copyTbl(k)] = copyTbl(v) end
	return res
end

function giveItem(it,xPlayer)
	if not it or not xPlayer then return end
	if it.type==1 and it.value then
		xPlayer.addMoney(it.value)
	elseif it.type==2 and it.item and it.count then
		xPlayer.addInventoryItem(it.item,it.count)
		TriggerClientEvent("player:receiveItem",source,it.item,it.count)
	elseif it.type==3 and it.weapon and it.ammo then
		TriggerClientEvent("free:giveWpn",xPlayer.source,it.weapon,it.ammo)
	end
end

function claimRewardsx(xPlayer,count)
	if count == 1 then
		for k,v in ipairs(Config.rewards1) do
			giveItem(v,xPlayer)
		end
	elseif count == 2 then
		for u,i in ipairs(Config.rewards2) do
			giveItem(i,xPlayer)
		end
	elseif count == 3 then
		for h,j in ipairs(Config.rewards3) do
			giveItem(j,xPlayer)
		end
	elseif count == 4 then
		for a,b in ipairs(Config.rewards4) do
			giveItem(b,xPlayer)
		end
	elseif count == 5 then
		for c,d in ipairs(Config.rewards5) do
			giveItem(d,xPlayer)
		end
	elseif count == 6 then
		for e,f in ipairs(Config.rewards6) do
			giveItem(f,xPlayer)
		end
	end
end

RegisterServerEvent("free:collect")
AddEventHandler("free:collect", function(t)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		if inloop == false then
			inloop = true
			local identifier = xPlayer.identifier
			local now = os.time()
			local nextcollect = os.time() + 86400
			local dtzero = {year=os.date('%Y', os.time()), month=os.date('%m', os.time()), day=os.date('%d', os.time()), hour=0, min=0, sec=0}
			local nextdayzero = os.time(dtzero) + 86400
			local timefirstreward = 3600;
			local timesecondreward = 3600*2;
			local timethirdreward = 3600*3;
			local timefourreward = 3600*4;
			local timefivereward = 3600*5;
			local timesixreward = 3600*6;

			MySQL.Async.fetchAll('SELECT * FROM `online_reward` WHERE `identifier`=@identifier;', {['@identifier'] = identifier}, function(collect)
				if collect[1] then
					if collect[1].next_collect < now then
						MySQL.Async.execute('UPDATE `online_reward` SET `next_collect`=@nextcollect,`count_time`=@counttime,`times_collected`=@timescollected WHERE `identifier`=@identifier', {["@identifier"] = identifier, ["@nextcollect"] = nextdayzero, ["@counttime"] = 0, ["@timescollected"] = 0}, nil)
						TriggerClientEvent("free:setTimeout", _source, now+60,collect[1].count_time+60)
					else
						if now-collect[1].timestamp >= 30 then
							if collect[1].count_time+60 >= timefirstreward and collect[1].times_collected < 1 then
								claimRewardsx(xPlayer,1)
								TriggerClientEvent("esx:showNotification",_source,Config.claimed)
								-- TriggerClientEvent("free:toggleFreeMenu", _source, false)
								MySQL.Async.execute('UPDATE `online_reward` SET `count_time`=@counttime,`times_collected`=@timescollected,`timestamp`=@timestamp WHERE `identifier`=@identifier', {["@identifier"] = identifier, ["@nextcollect"] = nextdayzero, ["@counttime"] = collect[1].count_time+60, ["@timestamp"] = now, ["@timescollected"] = collect[1].times_collected+1}, nil)
							elseif collect[1].count_time+60 >= timesecondreward and collect[1].times_collected < 2 then
								claimRewardsx(xPlayer,2)
								TriggerClientEvent("esx:showNotification",_source,Config.claimed)
								-- TriggerClientEvent("free:toggleFreeMenu", _source, false)
								MySQL.Async.execute('UPDATE `online_reward` SET `count_time`=@counttime,`times_collected`=@timescollected,`timestamp`=@timestamp WHERE `identifier`=@identifier', {["@identifier"] = identifier, ["@nextcollect"] = nextdayzero, ["@counttime"] = collect[1].count_time+60, ["@timestamp"] = now, ["@timescollected"] = collect[1].times_collected+1}, nil)
							elseif collect[1].count_time+60 >= timethirdreward and collect[1].times_collected < 3 then
								claimRewardsx(xPlayer,3)
								TriggerClientEvent("esx:showNotification",_source,Config.claimed)
								-- TriggerClientEvent("free:toggleFreeMenu", _source, false)
								MySQL.Async.execute('UPDATE `online_reward` SET `count_time`=@counttime,`times_collected`=@timescollected,`timestamp`=@timestamp WHERE `identifier`=@identifier', {["@identifier"] = identifier, ["@nextcollect"] = nextdayzero, ["@counttime"] = collect[1].count_time+60, ["@timestamp"] = now, ["@timescollected"] = collect[1].times_collected+1}, nil)
							elseif collect[1].count_time+60 >= timefourreward and collect[1].times_collected < 4 then
								claimRewardsx(xPlayer,4)
								TriggerClientEvent("esx:showNotification",_source,Config.claimed)
								-- TriggerClientEvent("free:toggleFreeMenu", _source, false)
								MySQL.Async.execute('UPDATE `online_reward` SET `count_time`=@counttime,`times_collected`=@timescollected,`timestamp`=@timestamp WHERE `identifier`=@identifier', {["@identifier"] = identifier, ["@nextcollect"] = nextdayzero, ["@counttime"] = collect[1].count_time+60, ["@timestamp"] = now, ["@timescollected"] = collect[1].times_collected+1}, nil)
							elseif collect[1].count_time+60 >= timefivereward and collect[1].times_collected < 5 then
								claimRewardsx(xPlayer,5)
								TriggerClientEvent("esx:showNotification",_source,Config.claimed)
								-- TriggerClientEvent("free:toggleFreeMenu", _source, false)
								MySQL.Async.execute('UPDATE `online_reward` SET `count_time`=@counttime,`times_collected`=@timescollected,`timestamp`=@timestamp WHERE `identifier`=@identifier', {["@identifier"] = identifier, ["@nextcollect"] = nextdayzero, ["@counttime"] = collect[1].count_time+60, ["@timestamp"] = now, ["@timescollected"] = collect[1].times_collected+1}, nil)
							elseif collect[1].count_time+60 >= timesixreward and collect[1].times_collected < 6 then
								claimRewardsx(xPlayer,6)
								TriggerClientEvent("esx:showNotification",_source,Config.claimed)
								-- TriggerClientEvent("free:toggleFreeMenu", _source, false)
								MySQL.Async.execute('UPDATE `online_reward` SET `count_time`=@counttime,`times_collected`=@timescollected,`timestamp`=@timestamp WHERE `identifier`=@identifier', {["@identifier"] = identifier, ["@nextcollect"] = nextdayzero, ["@counttime"] = collect[1].count_time+60, ["@timestamp"] = now, ["@timescollected"] = collect[1].times_collected+1}, nil)
							else
								MySQL.Async.execute('UPDATE `online_reward` SET `count_time`=@counttime,`timestamp`=@timestamp WHERE `identifier`=@identifier', {["@identifier"] = identifier, ["@nextcollect"] = nextdayzero, ["@counttime"] = collect[1].count_time+60, ["@timestamp"] = now, ["@timescollected"] = collect[1].times_collected+1}, nil)
							end
						end
						TriggerClientEvent("free:setTimeout", _source, now+60,collect[1].count_time+60)

					end
				else
					TriggerClientEvent("esx:showNotification",_source,Config.claimed)
					TriggerClientEvent("free:setTimeout", _source, now+60,0)
					TriggerClientEvent("free:toggleFreeMenu", _source, false)
					MySQL.Async.execute('INSERT INTO `online_reward` (`identifier`, `next_collect`, `times_collected`, `count_time`) VALUES (@identifier, @nextcollect, 0,0);', {['@identifier'] = identifier, ['@nextcollect'] = nextdayzero}, nil)
				end
				inloop = false
			end)
		end
		collecting[_source]=nil
	else
		TriggerClientEvent("free:toggleFreeMenu", _source, false)
	end
end)
