return function()
    -- ESX = nil
    -- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    -- RegisterServerEvent('qb-phone:server:SetCallState')
    -- AddEventHandler('qb-phone:server:SetCallState', function(bool)
        -- local src = source
        -- if (not bool) then
            -- TriggerClientEvent('cs-video-call:custom:clearCallee', src)
        -- end
    -- end)
    
    -- RegisterServerEvent('qb-phone:server:CallContact')
    -- AddEventHandler('qb-phone:server:CallContact', function(TargetData, CallId, AnonymousCall)
        -- local src = source
        -- local Ply = ESX.GetPlayerFromId(src)
        -- local Target = GetPlayerFromPhone(TargetData.number)
        -- if Target ~= nil then
			-- TriggerClientEvent('qb-phone:client:GetCalled', Target.source, character.phone, CallId, AnonymousCall)
            -- TriggerClientEvent('cs-video-call:custom:setCallee', src, Target.source)
            -- TriggerClientEvent('cs-video-call:custom:setCallee', Target.source, src)
        -- end
    -- end)

    -- function GetPlayerFromPhone(phone)
        -- local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE phone = @phone_number', {
            -- ['@phone_number'] = phone
        -- })
    
        -- -- print(result[1].identifier, result[1], 1179)
        
        -- if result[1] and result[1].identifier then
            -- return ESX.GetPlayerFromIdentifier(result[1].identifier)
        -- end
    
        -- return nil
    -- end
    
end
