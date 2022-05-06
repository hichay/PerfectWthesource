ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('qb-cityhall:server:requestId')
AddEventHandler('qb-cityhall:server:requestId', function(identityData)
    local src = source
    local Player = ESX.GetPlayerFromId(src)


    local info = {}
    if identityData.item == "id_card" then
        Player.addInventoryItem(identityData.item, 1)


    end

   

end)



RegisterServerEvent('esx_joblisting:setJob')
AddEventHandler('esx_joblisting:setJob', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('SELECT whitelisted FROM jobs WHERE name = @name', {
		['@name'] = job,
	}, function(result)
		if not result[1].whitelisted then
			xPlayer.setJob(job, tostring(0))
		else
			print(('esx_joblisting: %s attempted to set a whitelisted job! (lua injector)'):format(xPlayer.identifier))
		end
		
	end)

end)