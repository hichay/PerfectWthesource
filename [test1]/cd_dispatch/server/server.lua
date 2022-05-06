GlobalInfo = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


Citizen.CreateThread(function()
    for k, v in pairs(ESX.GetPlayers()) do
	    local identifier =  GetSteamID(v)
		GlobalInfo[v] = {}
		GlobalInfo[v].source = v
		GlobalInfo[v].rp_name, GlobalInfo[v].callsign = GetRoleplayInfo(identifier)
		if Config and Config.UseRadio then
			GlobalInfo[v].radio_channel = 0
		end
		TriggerClientEvent('cd_dispatch:SendSourceName', v, GlobalInfo[v].rp_name)
	end
end)



RegisterServerEvent('cd_dispatch:PlayerLoaded')
AddEventHandler('cd_dispatch:PlayerLoaded', function()
	local _source = source
	local identifier =  GetSteamID(_source)

	GlobalInfo[_source] = {}
	GlobalInfo[_source].source = _source
    GlobalInfo[_source].rp_name, GlobalInfo[_source].callsign = GetRoleplayInfo(identifier)
    --print(GlobalInfo[_source].rp_name, GlobalInfo[_source].callsign)

	if Config and Config.UseRadio then
		GlobalInfo[_source].radio_channel = 0
	end

	TriggerClientEvent('cd_dispatch:SendSourceName', _source, GlobalInfo[_source].rp_name)

end)



AddEventHandler("playerDropped", function()

	GlobalInfo[source] = nil

end)



if Config and Config.CommandName and type(Config.CommandName) == 'string' then

    RegisterCommand(Config.CommandName, function(source, args)
        local _source = source
        local job = ESX.GetPlayerFromId(_source).job.name
        local identifier = GetSteamID(_source)

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

else

    print('dispatch - error 4651525')

end



RegisterServerEvent('cd_dispatch:AddNotification')
AddEventHandler('cd_dispatch:AddNotification', function(t)
	TriggerClientEvent('cd_dispatch:AddNotification', -1, t)
end)



RegisterServerEvent('cd_dispatch:AddResponding')
AddEventHandler('cd_dispatch:AddResponding', function(job, responding, count, SourceName2)
	TriggerClientEvent('cd_dispatch:AddResponding', -1, job, responding, count, SourceName2)
end)



RegisterServerEvent('cd_dispatch:RemoveResponding')
AddEventHandler('cd_dispatch:RemoveResponding', function(job, responding, count, SourceName2)
	TriggerClientEvent('cd_dispatch:RemoveResponding', -1, job, responding, count, SourceName2)
end)



RegisterServerEvent('cd_dispatch:GlobalInfo')
AddEventHandler('cd_dispatch:GlobalInfo', function(job)

	if Config and Config.UsingOnesync then
		GetGlobalCoords(job)
		local finaltable = SortTable(job)
		TriggerClientEvent('cd_dispatch:GlobalInfo', -1, job, finaltable)
	else
		TriggerClientEvent('cd_dispatch:GetNonOnesyncCoords', -1, job)
		Wait(1000)
		local finaltable = SortTable(job)
		TriggerClientEvent('cd_dispatch:GlobalInfo', -1, job, finaltable)
	end
end)



RegisterServerEvent('cd_dispatch:GetCoords')
AddEventHandler('cd_dispatch:GetCoords', function(job)

	if Config and Config.UsingOnesync then
		local coords = GetGlobalCoords2(job)
		Wait(500)
		TriggerClientEvent('cd_dispatch:GetCoords', -1, job, coords)
	else
		TriggerClientEvent('cd_dispatch:GetNonOnesyncCoords', -1, job)
		Wait(1000)
		local coords = GetGlobalCoords2(job)
		TriggerClientEvent('cd_dispatch:GetCoords', -1, job, coords)
	end
end)



RegisterServerEvent('cd_dispatch:GetNonOnesyncCoords')
AddEventHandler('cd_dispatch:GetNonOnesyncCoords', function(coords)

    local _source = source
	
    if GlobalInfo and GlobalInfo[_source] then
        GlobalInfo[_source].coords = {x = coords.x, y = coords.y}
    else
        print('dispatch - error 6844535')
    end
end)





function GetRoleplayInfo(identifier)

	local Result = MySQL.Sync.fetchAll('SELECT firstname, lastname, callsign FROM users WHERE identifier=@identifier', {['@identifier'] = identifier})

	if Result ~= nil and Result[1] ~= nil then
		if Result[1].callsign == nil then
			Result[1].callsign = 'NULL'
		end

		if Result[1].firstname == nil then
			Result[1].firstname = 'Unknown'
		end

		if Result[1].lastname == nil then
			Result[1].lastname = 'Unknown'
		end

		return Result[1].firstname..' '..Result[1].lastname, Result[1].callsign

	else
		return 'Unknown Unknown', 'Unknown'
	end
end



function GetGlobalCoords(job)

    if GlobalInfo then

        for k, v in pairs(GlobalInfo) do

            local getjob = ESX.GetPlayerFromId(v.source).job.name

            if getjob ~= nil then

                if getjob == job then

                    local coords = GetEntityCoords(GetPlayerPed(v.source))

                    if GlobalInfo[v.source] ~= nil then

                        GlobalInfo[v.source].coords = {x = coords.x, y = coords.y}

                    else

                        print('dispatch - error 6874968')

                    end

                end

            else

                print('dispatch - error 6874558')

            end

        end

        Wait(500)

    else

        print('dispatch - error 468536')

    end

end



function GetGlobalCoords2(job)

    local CoordsTable = {}

    if GlobalInfo then

        if Config and Config.UsingOnesync then

            for k, v in pairs(GlobalInfo) do

                local getjob = ESX.GetPlayerFromId(v.source).job.name

                if getjob ~= nil then

                    if getjob == job then

                        local coords = GetEntityCoords(GetPlayerPed(v.source))

                        if GlobalInfo[v.source] and GlobalInfo[v.source].rp_name and coords then

                            table.insert(CoordsTable, {rp_name = GlobalInfo[v.source].rp_name, x = coords.x, y = coords.y})

                        else

                            print('dispatch - error 7896523')

                        end

                    end

                else

                    print('dispatch - error 1235456')

                end

            end

            Wait(500)

            return CoordsTable

        else

            for k, v in pairs(GlobalInfo) do

                local getjob = ESX.GetPlayerFromId(v.source).job.name

                if getjob ~= nil then

                    if getjob == job then

                        if GlobalInfo[v.source] and GlobalInfo[v.source].rp_name and GlobalInfo[v.source].coords and GlobalInfo[v.source].coords.x and GlobalInfo[v.source].coords.y then

                            table.insert(CoordsTable, {rp_name = GlobalInfo[v.source].rp_name, x = GlobalInfo[v.source].coords.x, y = GlobalInfo[v.source].coords.y})

                        else

                            print('dispatch - error 2135488')

                        end

                    end

                else

                    print('dispatch - error 9844654')

                end

            end

            Wait(500)

            return CoordsTable

        end

    else

        print('dispatch - error 1354685')

    end

end



function SortTable(job)

    local Table = {}

    if GlobalInfo then

        for k, v in pairs(GlobalInfo) do

            local getjob = ESX.GetPlayerFromId(v.source).job.name

            if getjob ~= nil then

                if getjob == job then

                    if Config and Config.DefaultCallsignColour and Config.CallsignData and type(Config.CallsignData) == 'table' then

                        local blipcolour = Config.DefaultCallsignColour

                        if v.callsign ~= nil then

                            for i=1, #Config.CallsignData, 1 do

                                if Config.CallsignData[i] and Config.CallsignData[i].blipname and Config.CallsignData[i].blipcolour then

                                    if string.sub(v.callsign, 1, 1) == string.sub(Config.CallsignData[i].blipname, 1, 1) then

                                        blipcolour = Config.CallsignData[i].blipcolour

                                    end

                                else

                                    print('dispatch - error 14654514')

                                end

                            end

                        else

                            print('dispatch - error 4978764')

                        end

                        table.insert(Table, {

                            rp_name = GlobalInfo[v.source].rp_name,

                            callsign = GlobalInfo[v.source].callsign,

                            blipcolour = blipcolour,

                            coords = GlobalInfo[v.source].coords,

                            radio_channel = GlobalInfo[v.source].radio_channel,

                        })

                    else

                        print('dispatch - error 1635684')

                    end

                end

            else

                print('dispatch - error 684698')

            end

        end

        Wait(500)

        return Table

    else

        print('dispatch - error 984464')

    end

end



function GetSteamID(source)

    if source and type(source) == 'number' then

        return GetPlayerIdentifiers(source)[1]

    else

        print('dispatch - error 6587446')

    end

end



function ErrorLocale(locale1)

    print('^3['..GetCurrentResourceName()..'] - ERROR - This locale is missing or incorrect ('..locale1..')^0')

end