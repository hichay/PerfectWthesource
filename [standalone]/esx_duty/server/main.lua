ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('duty:onoff')
AddEventHandler('duty:onoff', function(job)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    
    if job == 'police' then
        xPlayer.setJob('off' ..job, grade)
		
		TriggerClientEvent('rflx_pdblips:goOffDuty',-1)
        TriggerClientEvent('esx:showNotification', _source, _U('offduty'))
        TriggerClientEvent('rflx_pdblips:toggleDuty', source, false)
        local sendToDiscord = 'Người chơi ' .. xPlayer.getName() .. ' đã offduty '
        TriggerEvent('moon_discordlogs:sendToDiscord','OnDutyPL', sendToDiscord, _source, '^8') 
        --TriggerEvent('moon_discordlogs:sendToDiscord', source,'UseItem', sendToDiscord, source, '^3') 
	elseif job == 'ambulance' then	
		xPlayer.setJob('off' ..job, grade)
		TriggerClientEvent('rflx_pdblips:goOffDuty',-1)
        TriggerClientEvent('esx:showNotification', _source, _U('offduty'))
		TriggerClientEvent('rflx_pdblips:toggleDuty', source, false)
        local sendToDiscord = 'Người chơi ' .. xPlayer.getName() .. ' đã offduty '
        TriggerEvent('moon_discordlogs:sendToDiscord','OffdutyAm', sendToDiscord, _source, '^8') 
    elseif job == 'offpolice' then
        xPlayer.setJob('police', grade)
		TriggerClientEvent('rflx_pdblips:goOnDuty', -1)
		TriggerClientEvent('rflx_pdblips:toggleDuty', source, true)
        TriggerClientEvent('esx:showNotification', _source, _U('onduty'))
        local sendToDiscord = 'Người chơi ' .. xPlayer.getName() .. ' đã onduty Cảnh sát'
        TriggerEvent('moon_discordlogs:sendToDiscord','OffdutyPL', sendToDiscord, _source, '^3') 
    elseif job == 'offambulance' then
        xPlayer.setJob('ambulance', grade)
		TriggerClientEvent('rflx_pdblips:goOnDuty', -1)
		TriggerClientEvent('rflx_pdblips:toggleDuty', source, true)
        local sendToDiscord = 'Người chơi ' .. xPlayer.getName() .. ' đã onduty Bác sĩ'
		TriggerEvent('moon_discordlogs:sendToDiscord','OnDutyAm', sendToDiscord, _source, '^3') 
        TriggerClientEvent('esx:showNotification', _source, _U('onduty'))
    end

end)