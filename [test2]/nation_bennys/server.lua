ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local using_bennys = {}


ESX.RegisterServerCallback('nation:checkPermission',function(source, cb)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "tuner" or xPlayer.job.name == "tuner1" then
        cb(true)
    elseif Config.TunerOnly then
        cb(false)
        --TriggerClientEvent("Bennys:Notify",source,"Lỗi","Chỉ có mechanic mới có thể vào menu",7000)
		TriggerClientEvent("ESX:Notify", source,"Không có quyền hạn", "info")
    elseif not Config.TunerOnly then
        cb(true)
    end
end)


ESX.RegisterServerCallback('nation:checkPayment',function(source, cb, amount)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    local bankey = xPlayer.getAccount('bank').money
    local cash = xPlayer.getMoney()
    if not Config.TunerOnly and bankey >= amount then
        if Config.societymoney then
            local societyAccount = nil
            TriggerEvent(
                "esx_addonaccount:getSharedAccount",
                Config.society_name,
                function(account)
                    societyAccount = account
                end)
                societyAccount.addMoney(amount)
        end
        xPlayer.removeAccountMoney('bank', amount)
        TriggerClientEvent("Bennys:Notify",source,"Thành công","Thành công <b>Nâng cấp</b><br>Chi phí <b>$"..tonumber(amount).." $ <b>.",7000)
        cb(true)
    elseif not Config.TunerOnly and cash >= amount then
        if Config.societymoney then
            local societyAccount = nil
            TriggerEvent(
                "esx_addonaccount:getSharedAccount",
                Config.society_name,
                function(account)
                    societyAccount = account
                end)
                societyAccount.addMoney(amount)
        end
        xPlayer.removeMoney(amount)
        TriggerClientEvent("Bennys:Notify",source,"Thành công","Thành công <b>Nâng cấp</b><br>Chi phí <b>$"..tonumber(amount).." $ <b>.",7000)
        cb(true)
    elseif Config.TunerOnly and bankey >= amount or Config.TunerOnly and cash >= amount then
        if Config.societymoney then
            local societyAccount = nil
            TriggerEvent(
            "esx_addonaccount:getSharedAccount",
            Config.society_name,
            function(account)
                societyAccount = account
            end)
            societyAccount.removeMoney(amount)
            TriggerClientEvent("Bennys:Notify",source,"sucesso","Upgrade <b>Succeess Faggot</b><br>Total Cost <b>$"..tonumber(amount).." $ <b>.",7000)
            cb(true)
        else
            if bankey >= amount then
                xPlayer.removeAccountMoney('bank', amount)
                TriggerClientEvent("Bennys:Notify",source,"sucesso","Upgrade <b>Succeess Faggot</b><br>Total Cost <b>$"..tonumber(amount).." $ <b>.",7000)
                cb(true)
            elseif cash >= amount then
                xPlayer.removeMoney(amount)
                TriggerClientEvent("Bennys:Notify",source,"sucesso","Upgrade <b>Succeess</b><br>Total Cost <b>$"..tonumber(amount).." $ <b>.",7000)
                cb(true)
            end
        end
    else
        TriggerClientEvent("Bennys:Notify",source,"negado","You dont have a freaking money.",7000)
        cb(false)
    end
end)

RegisterServerEvent("nation:removeVehicle")
AddEventHandler("nation:removeVehicle",function(vehicle)
    using_bennys[vehicle] = nil
    return true
end)

ESX.RegisterServerCallback('nation:checkVehicle',function(source, cb, vehicle)
    if using_bennys[vehicle] then
        cb(false)
    else
    using_bennys[vehicle] = true
        cb(true)
    end
end)

AddEventHandler('playerDropped', function (reason)
    print('Player ' .. GetPlayerName(source) .. ' dropped (Reason: ' .. reason .. ')')
end)
  
-- RegisterServerEvent('saveVehicle')
-- AddEventHandler('saveVehicle', function(plate,props)
    -- local source = source
	-- local xPlayer = ESX.GetPlayerFromId(source)
    -- if props.plate == nil then
    -- props.plate = plate
    -- end
	-- MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		-- ['@plate'] = props.plate
	-- }, function(result)
		-- print('wqur')
		-- if result[1] ~= nil then
            -- local vehicle = json.decode(result[1].props)
			-- print(props.model)
			-- if props.model == vehicle.model then
				-- print('true')
				-- MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
					-- ['@plate'] = props.plate,
					-- ['@vehicle'] = json.encode(props)
				-- })
			-- else
				-- print(('NOOB: %s attempted to upgrade vehicle with mismatching vehicle model!'):format(xPlayer.identifier))
			-- end
		-- end
	-- end)
-- end)

RegisterServerEvent('saveVehicle')
AddEventHandler('saveVehicle', function(plate,props)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    if props.plate == nil then
    props.plate = plate
    end
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = props.plate
	}, function(result)
		print('wqur')
		if result[1] ~= nil then
            local vehicle = json.decode(result[1].vehicle)
			if props.model == vehicle.model then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
					['@plate'] = props.plate,
					['@vehicle'] = json.encode(props)
				})
			else
				print(('NOOB: %s attempted to upgrade vehicle with mismatching vehicle model!'):format(xPlayer.identifier))
			end
		end
	end)
end)


RegisterServerEvent("nation:syncApplyMods")
AddEventHandler("nation:syncApplyMods",function(vehicle_tuning,vehicle)
    TriggerClientEvent("nation:applymods_sync",-1,vehicle_tuning,vehicle)
end)