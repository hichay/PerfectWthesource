local AdvStatsTable = {}
local GarageTaxCheck = {}
local PhoneNumbers = {}
local ImpoundData = {}
local PriceData = {}
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



MySQL.ready(function()
    if Config ~= nil then
        if Config.Language and Locales[Config.Language]['saving_cached_data'] ~= nil then
            print('['..GetCurrentResourceName()..'] - '..Locales[Config.Language]['saving_cached_data'])
			print('1')
			
        else
            ErrorLocale('saving_cached_data')
        end
        MySQL.Sync.execute("UPDATE owned_vehicles SET in_garage=0 WHERE in_garage=0")
        if Config.GarageTax then
            MySQL.Sync.execute("UPDATE users SET garage_tax=0 WHERE garage_tax=1")
        end
        if Config.UseMileage then
            Get_ADVSTATS()
            Wait(1000)
        end
        if Config.UseImpound then
            Get_IMPOUNDDATA()
            Wait(1000)
        end
        if Config.UseDatabasePrices then
            Get_PRICEDATA()
            Wait(1000)
            TriggerClientEvent('cd_garage:PriceData', -1, PriceData)
        end
        if Config.Language ~= nil and Locales[Config.Language]['cached_data_saved'] ~= nil then
            print('['..GetCurrentResourceName()..'] - '..Locales[Config.Language]['cached_data_saved'])
			print('2')
        else
            ErrorLocale('cached_data_saved')
        end
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-68465155] [error_status-important] - Send this to the Codesign Team.'})end)
		print(e.c)
		print('3')
    end
end)

function Get_ADVSTATS()
    if Config ~= nil and Config.UseMileage then
        local ADVSTATS = MySQL.Sync.fetchAll('SELECT adv_stats FROM owned_vehicles')
        if ADVSTATS ~= nil then
            for i=1, #ADVSTATS do
                if ADVSTATS[i] ~= nil and ADVSTATS[i].adv_stats ~= nil and #ADVSTATS[i].adv_stats > 0 then
                    local ADVSTATS_2
                    if pcall(function() ADVSTATS_2 = json.decode(ADVSTATS[i].adv_stats) end) then
                        if ADVSTATS_2 ~= nil then
                            if pcall(function() if type(ADVSTATS_2.plate) == 'string' then end end) then
                                if ADVSTATS_2.plate ~= nil then
                                    local plate = ADVSTATS_2.plate
                                    AdvStatsTable[plate] = {}
                                    AdvStatsTable[plate] =  ADVSTATS_2
                                end
                            else
                                local s,e=pcall(
								function()
								error({c='['..GetCurrentResourceName()..'] [error_code-8446152] [error_status-minor] - Send this to the Codesign Team.'})
								end)
								print(e.c)
								print('4')
                            end
                        else
                            local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-9874844] [error_status-minor] - Send this to the Codesign Team.'})
							end)
							print('5')
							print(e.c)
                        end
                    else
                        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-86415156] [error_status-minor] - Send this to the Codesign Team.'})
						end)
						print(e.c)
						print('6')
                    end
                end
            end
            Wait(500)
        else
            local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-6458145] [error_status-important] - Send this to the Codesign Team.'})end)
			print(e.c)
			print('7')
        end
    end
end

function Get_IMPOUNDDATA()
    if Config ~= nil and Config.Impound then
        local IMPOUND_DATA = MySQL.Sync.fetchAll('SELECT plate, vehicle, impound, adv_stats FROM owned_vehicles where impound>0')
        if IMPOUND_DATA ~= nil then
            for i=1, #IMPOUND_DATA do
                ImpoundData[i] = {}
                local propsdata
                if IMPOUND_DATA[i].plate ~= nil and #IMPOUND_DATA[i].plate > 0 and IMPOUND_DATA[i].vehicle ~= nil and #IMPOUND_DATA[i].vehicle > 10 and IMPOUND_DATA[i].impound~= nil and IMPOUND_DATA[i].adv_stats ~= nil and #IMPOUND_DATA[i].adv_stats > 0 then
                    if pcall(function() propsdata = json.decode(IMPOUND_DATA[i].vehicle) end) then
                        if IMPOUND_DATA[i].impound and type(IMPOUND_DATA[i].impound) == 'number' then
                            ImpoundData[i].impound = IMPOUND_DATA[i].impound
                            if IMPOUND_DATA[i].plate and type(IMPOUND_DATA[i].plate) == 'string' then
                                ImpoundData[i].plate = IMPOUND_DATA[i].plate
                                if propsdata.model and type(propsdata.model) == 'number' then
                                    ImpoundData[i].label = propsdata.model
                                    ImpoundData[i].propsdata = propsdata
                                else
                                    local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-79865415] [error_status-minor] - Send this to the CodesignTeam.'})end)
									print(e.c)
									print('8')
                                end
                            else
                                local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-84746951] [error_status-minor] - Send this to the Codesign Team'})end)
								print(e.c)
								print('9')
                            end
                        end
                        if Config.UseMileage then
                            if not pcall(function() ImpoundData[i].adv_stats = json.decode(IMPOUND_DATA[i].adv_stats) end) then
                                local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-8546515] [error_status-minor] - Send this to the Codesign Team.'})
								end)
								print(e.c)
								print('19')
                            end
                        end
                    else
                        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-35646584] [error_status-minor] - Send this to the Codesign Team.'})
						end)
						print(e.c)
						print('29')
                    end
                else
                    local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-86415156] [error_status-minor] - Send this to the Codesign Team.'})end)
					print(e.c)
					print('10')
                end
            end
        else
            local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-46584645] [error_status-important] - Send this to the Codesign Team.'})end)
			print(e.c)
			print('11')
        end
    end
end

function  Get_PRICEDATA()
    if Config ~= nil and Config.UseDatabasePrices then
        local PRICE_DATA = MySQL.Sync.fetchAll('SELECT model, price FROM vehicles')
        if PRICE_DATA ~= nil then
            for i=1, #PRICE_DATA do
                if PRICE_DATA[i].model and type(PRICE_DATA[i].model) == 'string' and PRICE_DATA[i].price and type(PRICE_DATA[i].price) == 'number'then
                    local hash = GetHashKey(PRICE_DATA[i].model)
                    PriceData[hash] = {}
                    PriceData[hash].price = PRICE_DATA[i].price
                else
                    if Config.Debug then
                        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-76985145] [error_status-minor] - Send this to the Codesign Team.'})end)
						print(e.c)
						print('12')
                    end
                end
            end
        else
            local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-468454] [error_status-important] - Send this to the Codesign Team.'})end)
			print(e.c)
			print('13')
        end
    end
end

RegisterServerEvent('cd_garage:PriceData')
AddEventHandler('cd_garage:PriceData', function()
    local _source = source
    TriggerClientEvent('cd_garage:PriceData', _source, PriceData)
end)

RegisterServerEvent('cd_garage:ChangeInGarageState')
AddEventHandler('cd_garage:ChangeInGarageState', function(plate, in_garage, AdvStatsTableClient)
    if plate and in_garage and type(plate) == 'string' and type(in_garage) == 'number' then
        if Config ~= nil and Config.UseMileage then
            if AdvStatsTableClient ~= nil and type(AdvStatsTableClient) == 'table' then
                if AdvStatsTable[plate] ~= nil then
                    AdvStatsTable[plate] =  AdvStatsTableClient
                else
                    AdvStatsTable[plate] = {}
                    AdvStatsTable[plate] =  AdvStatsTableClient
                end
            end
        end
        MySQL.Sync.execute("UPDATE owned_vehicles SET in_garage=@in_garage, state=@state, parking=@pakring WHERE plate=@plate",{['@in_garage'] = in_garage, ['@plate'] = plate, ['@state'] = 'unknown', ['@parking'] = ''})
		
		
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-654465] [error_status-important] - Send this to the Codesign Team.'})end)
		print(e.c)
		print('14')
    end
end)



RegisterServerEvent('cd_garage:PayReturnVehicle')
AddEventHandler('cd_garage:PayReturnVehicle', function(props)
    if Config and props and type(props) == 'table' then
        local _source = source
        if Checks('check_money', _source, Config.ReturnVehiclePrice) then
            MySQL.Sync.execute("UPDATE owned_vehicles SET in_garage=1 WHERE plate=@plate",{['@plate'] = props.plate})
            TriggerClientEvent('cd_garage:PayReturnVehicle', _source, props)
        else
            TriggerClientEvent('cd_garage:ReturnVehicle:Callback', _source)
        end
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-3654611] [error_status-important] - Send this to the Codesign Team.'})end)
		print(e.c)
		print('15')
    end
end)

RegisterServerEvent('cd_garage:StoreVehicle')
AddEventHandler('cd_garage:StoreVehicle', function(propsdata, plate, garage_id, garage_type, adv_stats)
    if Config and propsdata and garage_id and garage_type and type(propsdata) == 'table' and type(garage_id) == 'string' and type(garage_type) == 'string' then
        local _source = source
        local identifier = Checks('get_steam', _source)
        local model = propsdata.model
		TriggerEvent('vehiclemod:server:saveStatus',plate)
        MySQL.Async.execute('UPDATE owned_vehicles SET plate=@newplate WHERE plate=@oldplate', {['@newplate'] = plate, ['@oldplate'] = propsdata.plate})
        propsdata.plate = plate
        Wait(500)
        MySQL.Async.fetchAll("SELECT id,vehicle FROM owned_vehicles where plate=@plate and owner=@owner",{['@plate'] = plate, ['@owner'] = identifier}, function(result)
            if result ~= nil and result[1] ~= nil and result[1].vehicle ~= nil and #result[1].vehicle > 10 then
                local og_model = json.decode(result[1].vehicle).model
                if og_model == model then
                    if Config.UseMileage and adv_stats ~= nil and type(adv_stats) == 'table' then
						local jsonz = {''..result[1].id, garage_id, plate, '999999'}
                        MySQL.Async.execute('UPDATE owned_vehicles SET vehicle=@vehicle, state=@state, parking=@parking, in_garage=1, garage_id=@garage_id, adv_stats=@adv_stats, garage_type=@garage_type WHERE plate=@plate', {
                            ["@vehicle"] = json.encode(propsdata),
							['@state'] = 'garage',							
							['@parking'] = json.encode(jsonz),
                            ["@garage_id"] = garage_id,
                            ["@adv_stats"] = json.encode(adv_stats),
                            ["@garage_type"] = garage_type,
                            ['@plate'] = plate,
							
                        })
                        if AdvStatsTable[plate] ~= nil then
                            AdvStatsTable[plate] =  adv_stats
                        else
                            AdvStatsTable[plate] = {}
                            AdvStatsTable[plate] =  adv_stats
                        end
                    else
                        MySQL.Async.execute('UPDATE owned_vehicles SET vehicle=@vehicle, state=@state, parking=@parking, in_garage=1, garage_id=@garage_id, garage_type=@garage_type WHERE plate=@plate', {
                            ["@vehicle"] = json.encode(propsdata),
							['@state'] = 'garage',
							['@parking'] = json.encode(jsonz),
                            ["@garage_id"] = garage_id,
                            ["@garage_type"] = garage_type,
                            ['@plate'] = plate,
							
                        })
                    end
                    TriggerClientEvent('cd_garage:StoreVehicle', _source)
                else
                    if Config.ExploitLogWebhook ~= nil and Config.ExploitLogWebhook ~= false or (Config.ExploitLogWebhook ~= 'false' or Config.ExploitLogWebhook ~= 'FALSE') then
                        Checks('exploit_log', _source, GetPlayerName(_source), model, og_model, identifier)
                    end
                end
            else
                if Config.Language ~= nil and Locales[Config.Language]['dont_own_vehicle'] ~= nil then
                    Checks('error_notif', _source, Locales[Config.Language]['dont_own_vehicle'])
					print('ko co chu')
                else
                    ErrorLocale('dont_own_vehicle')
                end
            end
        end)
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-3546541] [error_status-important] - Send this to the Codesign Team.'})end)
		print(e.c)
		print('16')
    end
end)

RegisterServerEvent('cd_garage:GarageTax')
AddEventHandler('cd_garage:GarageTax', function(serverid)
    if serverid == nil then
        _source = source
    elseif type(serverid) == 'number' then
        _source = serverid
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-4685415] [error_status-important] - Send this to the Codesign Team.'})end)
		print(e.c)
		print('17')
    end
    if _source and GarageTaxCheck[_source] == nil then
        MySQL.Async.fetchAll("SELECT phone FROM users where identifier=@identifier",{['@identifier'] = Checks('get_steam', _source)}, function(result)
            if result ~= nil and result[1] ~= nil and result[1].phone ~= nil then
                local cantax = true
                if  PhoneNumbers ~= nil then
                    for k, v in pairs (PhoneNumbers) do
                        if v ~= nil and v == result[1].phone then
                            cantax = false
                            break
                        end
                    end
                end

                if cantax then
                    GarageTaxCheck[_source] = true
                    table.insert(PhoneNumbers, result[1].phone)
                    local TaxDisShit = MySQL.Sync.fetchAll('SELECT vehicle FROM owned_vehicles WHERE owner=@owner', {['@owner'] = Checks('get_steam', _source)})
                    if TaxDisShit ~= nil and TaxDisShit[1] ~= nil and TaxDisShit[1].vehicle ~= nil then
                        for i=1, #TaxDisShit do
                            if TaxDisShit[i].vehicle ~= nil then
                                local VehProps = json.decode(TaxDisShit[i].vehicle)
                                local model = VehProps.model
                                TriggerClientEvent('cd_garage:GarageTax', _source, model)
                            end
                        end
                    else
                        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-14655165] [error_status-minor] - Send this to the Codesign Team.'})
						end)
						print(e.c)
                    end
                end
                cantax = nil
            else
                local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-7684532] [error_status-minor] - Send this to the Codesign Team.'})end)
				print(e.c)
				print('18')
            end
        end)
    end
end)

RegisterServerEvent('cd_garage:PayTax')
AddEventHandler('cd_garage:PayTax', function(amount, garagecount)
    if Config and amount and garagecount and type(amount) == 'number' and type(garagecount) == 'number' then
        local _source = source
        Checks('remove_money', _source, amount)
        MySQL.Sync.execute("UPDATE users SET garage_tax =1 WHERE identifier=@identifier",{['@identifier'] = Checks('get_steam', _source)})
        if Config.Language ~= nil and Locales[Config.Language]['pay_tax'] ~= nil or Locales[Config.Language]['vehicles'] ~= nil then
            --Checks('success_notif', _source, Locales[Config.Language]['pay_tax'], '('..garagecount..' '..Locales[Config.Language]['vehicles']..')', '$'..round(amount))
			TriggerEvent("ESX:Notify",source,'('..garagecount..' '..Locales[Config.Language]['vehicles']..')', '$'..round(amount))
        else
            ErrorLocale('pay_tax', 'vehicles')
        end
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-6846512] [error_status-minor] - Send this to the Codesign Team.'})end)
		print(e.c)
		print('19')
    end
end)

RegisterServerEvent('cd_garage:GetVehicleInfo')
AddEventHandler('cd_garage:GetVehicleInfo', function(garage_type)
    local _source = source
    if Config and garage_type ~= nil and type(garage_type) == 'string' then
        local _source = source
        local Result = MySQL.Sync.fetchAll('SELECT plate, vehicle, in_garage, impound, garage_id, adv_stats, garage_type FROM owned_vehicles WHERE owner=@owner and garage_type=@garage_type', {['@owner'] = Checks('get_steam', _source), ['@garage_type'] = garage_type})
        if Result ~= nil and Result[1] ~= nil then
            TriggerClientEvent('cd_garage:GetVehicleInfo', _source, Result)
            if Config.GarageTax then
                TriggerEvent('cd_garage:GarageTax', _source)
            end
        else
            if Config.Language ~= nil and Locales[Config.Language]['no_owned_vehicles'] ~= nil then
                Checks('error_notif', _source, Locales[Config.Language]['no_owned_vehicles'])
				print('ko phai')
            else
                ErrorLocale('no_owned_vehicles')
            end
        end
    else
        local Result = MySQL.Sync.fetchAll('SELECT plate, vehicle, in_garage, impound, garage_id, adv_stats, garage_type FROM owned_vehicles WHERE owner=@owner and garage_type="car"', {['@owner'] = Checks('get_steam', _source)})
        if Result ~= nil and Result[1] ~= nil then
            TriggerClientEvent('cd_garage:GetVehicleInfo', _source, Result)
            if Config.GarageTax then
                TriggerEvent('cd_garage:GarageTax', _source)
            end
        else
            if Config.Language ~= nil and Locales[Config.Language]['no_owned_vehicles'] ~= nil then
                Checks('error_notif', _source, Locales[Config.Language]['no_owned_vehicles'])
				print('ko phai 2')
            else
                ErrorLocale('no_owned_vehicles')
            end
        end
    end
end)

RegisterServerEvent('cd_garage:GetImpoundData')
AddEventHandler('cd_garage:GetImpoundData', function(ImpoundID)
    if ImpoundID and type(ImpoundID) == 'number' then
        local _source = source
        local values = {}
        if ImpoundData ~= nil then
            for i=1, #ImpoundData do
                if ImpoundData[i] ~= nil and ImpoundData[i].impound == ImpoundID then
                    table.insert(values, ImpoundData[i])
                end
            end
        else
            local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-6546854] [error_status-important] - Send this to the Codesign Team.'})end)
			print(e.c)
			print('20')
        end
        Wait(500)
        TriggerClientEvent('cd_garage:GetImpoundData', _source, values)
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-1654658] [error_status-important] - Send this to the Codesign Team.'})end)
		print(e.c)
		print('21')
    end
end)

RegisterServerEvent('cd_garage:ChangeImpoundState')
AddEventHandler('cd_garage:ChangeImpoundState', function(plate, impound, label, props, adv_stats)
    if Config and plate and impound and label and type(plate) == 'string' and type(impound) == 'number' and type(label) == 'string' then
        local _source = source
        local location
        if Config.Impound ~= nil then
            for k, v in pairs (Config.Impound) do
                if v.ImpoundID ~= nil and v.ImpoundID == impound then
                    location = v.blip.name
                    break
                end
            end
        end
        
        if impound > 0 then
            if Config.UseImpoundLogs and Config.ImpoundLogWebhook ~= nil and (Config.ImpoundLogWebhook ~= false or Config.ImpoundLogWebhook ~= 'false' or ConfigImpoundLogWebhook ~= 'FALSE') then
                Checks('impound_log', _source, 'impound', GetPlayerName(_source), label, plate, location)
            end
            if Config.Language ~= nil and Locales[Config.Language]['unimpounded_vehicle'] ~= nil then
                Checks('success_notif', _source, Locales[Config.Language]['unimpounded_vehicle'], plate)
            else
                ErrorLocale('unimpounded_vehicle')
            end
            if props and type(props) == 'table' then
                if Config.UseMileage and adv_stats then
                    if type(adv_stats) == 'table' then
                        table.insert(ImpoundData, {
                            plate = plate,
                            impound = impound,
                            label = label,
                            props = props,
                            adv_stats = adv_stats,
                        })
                    else
                        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-6468415] [error_status-minor] - Send this to the Codesign Team.'})
						end)
						print(e.c)
						print('22')
                    end
                else
                    table.insert(ImpoundData, {
                        plate = plate,
                        impound = impound,
                        label = label,
                        props = props,
                    })
                end
            else
                local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-6854651] [error_status-important] - Send this to the Codesign Team.'})end)
				print(e.c)
				print('23')
            end
        elseif impound == 0 then
            if Config.ImpoundLogWebhook ~= nil and (Config.ImpoundLogWebhook ~= false or Config.ImpoundLogWebhook ~= 'false' or Config.ImpoundLogWebhook ~= 'FALSE') then
                Checks('impound_log', _source, 'unimpound', GetPlayerName(_source), label, plate)
            end
            
            if ImpoundData ~= nil then
                for i=1, #ImpoundData do
                    if ImpoundData[i] ~= nil then
                        if ImpoundData[i].plate == plate then
                            ImpoundData[i] = nil
                            break
                        end
                    end
                end
            else
                local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-8964465] [error_status-important] - Send this to the Codesign Team.'})end)
				print(e.c)
				print('24')
            end
        end
        MySQL.Sync.execute("UPDATE owned_vehicles SET impound=@impound, plate=@plate WHERE plate=@plate",{['@impound'] = impound, ['@plate'] = plate})
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-7769854] [error_status-important] - Send this to the Codesign Team.'})end)
		print(e.c)
		print('251')
    end
end)

RegisterServerEvent('cd_garage:CivUnimpound')
AddEventHandler('cd_garage:CivUnimpound', function(action, data, plate, impound, label)
    if Config and action and data and type(action) == 'string' and type(data) == 'table' then
        local _source = source
        
        if Checks('check_money', _source, Config.CivImpoundFee) then
            if plate and impound and label and type(plate) == 'string' and type(impound) == 'number' and type(label) == 'string' then
                if GetVehicleOwner(_source, plate) then
                    TriggerClientEvent('cd_garage:CivUnimpound', _source, action, data, plate, impound, label)
                else
                    TriggerClientEvent('cd_garage:CivUnimpound', _source, 'disablenui')
                    if Config.Language ~= nil and Locales[Config.Language]['dont_own_vehicle'] ~= nil then
                        Checks('error_notif', _source, Locales[Config.Language]['dont_own_vehicle'])
                    else
                        ErrorLocale('dont_own_vehicle')
                    end
                end
            else
                local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-78964165] [error_status-important] - Send this to the Codesign Team.'})end)
				print(e.c)
				print('26')
            end
        else
            TriggerClientEvent('cd_garage:CivUnimpound', _source, 'disablenui')
            if Config.Language ~= nil and Locales[Config.Language]['not_enough_cash'] ~= nil then
                Checks('error_notif', _source, Locales[Config.Language]['not_enough_cash'])
            else
                ErrorLocale('not_enough_cash')
            end
        end
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-841561365] [error_status-important] - Send this to the Codesign Team.'})end)
		print(e.c)
		print('27')
    end
end)

function GetMaxHealth(plate)
    if plate and type(plate) == 'string' then
        if AdvStatsTable ~= nil then
            if AdvStatsTable[plate] ~= nil then
                if AdvStatsTable[plate].maxhealth ~= nil then
                    return AdvStatsTable[plate].maxhealth
                else
                    return 1000.0
                end
            else
                return 1000.0
            end
        else
            local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-3654654] [error_status-minor] - Send this to the Codesign Team.'})end)
			print(e.c)
			print('28')
            return 1000.0
        end
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-94651654] [error_status-minor] - Send this to the Codesign Team.'})end)
		print(e.c)
		print('29')
        return 1000.0
    end
end

function GetAdvStats(plate)
    if plate and type(plate) == 'string' then
        if AdvStatsTable[plate] ~= nil then
            local ServerTable = {plate = AdvStatsTable[plate].plate, mileage = AdvStatsTable[plate].mileage, maxhealth = AdvStatsTable[plate].maxhealth}
            return ServerTable
        else
            local result = MySQL.Sync.fetchAll('SELECT adv_stats FROM owned_vehicles where plate=@plate',{['@plate'] = plate})
            if result ~= nil and result[1] ~= nil and result[1].adv_stats ~= nil and #result[1].adv_stats > 0 then
                return json.decode(result[1].adv_stats)
            else
                return false
            end
        end
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-984651] [error_status-important] - Send this to the Codesign Team.'})end)
		print(e.c)
		print('30')
        return false
    end
end

function GetGarageCount(source, garage_type)
    if source then
        if garage_type == nil then
            garage_type = 'car'
        elseif type(garage_type) ~= 'string' then
            garage_type = 'car'
        end
        local Result = MySQL.Sync.fetchAll('SELECT owner FROM owned_vehicles WHERE owner=@owner and garage_type=@garage_type', {['@owner'] = GetSteamID(source), ['@garage_type']= garage_type})
        if Result ~= nil and Result[1] ~= nil and Result[1].owner ~= nil then
            return #Result
        else
            return 0
        end
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-7468541] [error_status-important] - Send this to the Codesign Team.'})end)
		print(e.c)
		print('31')
    end
end

function GetGarageLimit(source)
    if source then
        local Result = MySQL.Sync.fetchAll('SELECT garage_limit FROM users WHERE identifier=@identifier', {['@identifier'] = GetSteamID(source)})
        if Result ~= nil and Result[1] ~= nil and Result[1].garage_limit ~= nil then
            return tonumber(Result[1].garage_limit)
        else
            if Config.UseGarageSpace then
                return 100

            else
                return #Config.GarageSpace
            end
        end
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-9874465] [error_status-important] - Send this to the Codesign Team.'})end)
		print(e.c)
		print('32')
        return nil
    end
end

function GetVehicleOwner(source, plate)
    if source and plate and type(plate) == 'string' then
        local Result = MySQL.Sync.fetchAll('SELECT owner FROM owned_vehicles WHERE plate=@plate', {['plate'] = plate})
        if Result ~= nil and Result[1] ~= nil and Result[1].owner ~= nil then
            if Result[1].owner == Checks('get_steam', _source) then
                return true
            else
                return false
            end
        else
            return false
        end
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-6846145] [error_status-important] - Send this to the Codesign Team.'})end)
		print(e.c)
		print('33')
        return false
    end
end

function round( n )
    if n and type(n) == 'number' then
        return math.floor( n + 0.5 )
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-7984651] [error_status-important] - Send this to the Codesign Team.'})end)
		print(e.c)
		print('34')
        return 00000
    end
end

function ErrorLocale(locale1, locale2)
    if locale2 ~= nil then
        print('['..GetCurrentResourceName()..'] - ERROR - 2 locales are missing or incorrect ('..locale1..', '..locale2..')')
    else
        print('['..GetCurrentResourceName()..'] - ERROR - This locale is missing or incorrect ('..locale1..')')
    end
end

RegisterNetEvent('cd_garage:Callback')
AddEventHandler('cd_garage:Callback', function(id, plate)
    if id and plate and type(source) == 'number' and type(plate) == 'string' then
        local _source = source
        local result = GetAdvStats(plate)
        TriggerClientEvent('cd_garage:Callback', _source, id, result)
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-65468541] [error_status-important] - Send this to the Codesign Team.'})end)
		print(e.c)
		print('35')
    end
end)

function Checks(action, source, input1, input2, input3, input4, input5)
	local _source = source
    if action == 'success_notif' then
        if not pcall(function() Success_Notification(_source, input1, input2, input3) end) then
            local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-84165125] [error_status-important] - Send this to the Codesign Team.'})end)
			print(e.c)
			print('36')
        end
    elseif action == 'error_notif' then
        if not pcall(function() Error_Notification(_source, input1, input2) end) then
            local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-465416584] [error_status-important] - Send this to the Codesign Team.'})end)
			print(e.c)
			print('37')
        end
    elseif action == 'impound_log' then
        if not pcall(function() ImpoundVehicleLogs_Config(_source, input1, input2, input3, input4, input5) end) then
            local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-4685115] [error_status-important] - Send this to the Codesign Team.'})end)
			print(e.c)
			print('38')
        end
    elseif action == 'exploit_log' then
        if not pcall(function() ExploitAlertLogs_Config(_source, input1, input2, input3, input4) end) then
            local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-684515] [error_status-important] - Send this to the Codesign Team.'})end)
			print(e.c)
			print('39')
        end
    elseif action == 'check_money' then
        local result
        if pcall(function() result = CheckMoney(_source, input1) end) then
            return result
			
        else
            local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-23516851] [error_status-important] - Send this to the Codesign Team.'})end)
			print(e.c)
			print('41')
        end
    elseif action == 'remove_money' then
        if not pcall(function() RemoveMoney(_source, input1) end) then
            local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-6845165] [error_status-important] - Send this to the Codesign Team.'})end)
			print(e.c)
			print('42')
        end
    elseif action == 'get_steam' then
        local result
		local xplayer = ESX.GetPlayerFromId(1)
        if pcall(function() result = xplayer.identifier end) then
            return result
        else
            local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-24516851] [error_status-important] - Send this to the Codesign Team.'})end)
			print(e.c)
			print('43')
        end
    end
end

function ExploitAlertLogs(message)
    if Config and Config.ExploitLogWebhook and message and type(message) == 'string' then
        PerformHttpRequest(Config.ExploitLogWebhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-483215] [error_status-minor] - Send this to the Codesign Team.'})end)
		print(e.c)
    end
end

function ImpoundVehicleLogs(name, message, color)
    if Config and Config.ImpoundLogWebhook and name and message and color and type(name) == 'string' and type(message) == 'string' and type(color) == 'number' then
        local embeds = {
            {
                ["title"]=message,
                ["type"]="rich",
                ["color"] =color,
                ["footer"]=  {
                ["text"]= "Impound-Log",
            },
            }
        }
        PerformHttpRequest(Config.ImpoundLogWebhook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'applicationjson' })
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-6541654] [error_status-minor] - Send this to the Codesign Team.'})end)
		print(e.c)
    end
end

function TransferVehicleLogs(name, message, color)
    if Config and Config.TransferVehicleLogWebhook and name and message and color and type(name) == 'string' and type(message) == 'string' and type(color) == 'number' then
        local embeds = {
            {
                ["title"]=message,
                ["type"]="rich",
                ["color"] =color,
                ["footer"]=  {
                ["text"]= name,
            },
            }
        }
        PerformHttpRequest(Config.TransferVehicleLogWebhook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] ='application/json' })
    else
        local s,e=pcall(function()error({c='['..GetCurrentResourceName()..'] [error_code-3654665] [error_status-minor] - Send this to the Codesign Team.'})end)
		print(e.c)
    end
end