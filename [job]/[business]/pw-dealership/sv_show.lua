function GetOSSep()
	if os.getenv('HOME') then
		return '/'
	else
		return '\\'
	end
end
local serverConfig = {}
serverConfig = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'displayloc.json'))


RegisterServerEvent('lc_server:SaveDisplayLocation')
AddEventHandler('lc_server:SaveDisplayLocation', function(slot, name, position, vehicle)
    local src = source
    local dispos = position
    local newdisplay = {}

    if serverConfig[name] == nil then
        newdisplay = { 
            [slot] = {       
                position = position,   
                model = vehicle   
            }      
        }
        local display = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'displayloc.json'))
        display[name] = newdisplay
        SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'displayloc.json', json.encode(display), -1)
        serverConfig[name] = newdisplay
        serverConfig = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'displayloc.json'))
        TriggerClientEvent('pw-dealership:client:syncConfig', source, 1, serverConfig)
        
    else
        newdisplay = {        
            position = position,   
            model = vehicle         
        }
        local display = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'displayloc.json'))
        display[name][slot] = newdisplay
        SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'displayloc.json', json.encode(display), -1)
        serverConfig[name] = newdisplay
        serverConfig = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'displayloc.json'))
        TriggerClientEvent('pw-dealership:client:syncConfig', -1, 1, serverConfig)
        
    end
    
end)

CreateThread(function()
    Wait(1000)
    TriggerEvent('pw-dealership:server:setFirstData')
end)


RegisterServerEvent('pw-dealership:server:setFirstData')
AddEventHandler('pw-dealership:server:setFirstData', function()
    TriggerClientEvent('pw-dealership:client:syncConfig', -1, 1, serverConfig)
end)