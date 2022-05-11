function GetOSSep()
	if os.getenv('HOME') then
		return '/'
	else
		return '\\'
	end
end
local serverConfig = {}
serverConfig['showroom'] = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'displayloc.json'))
--[[ RegisterCommand("testshit", function(source, args, rawCommand)
    
    local slot = 'slot_10'
    local showroomname = 'dealer_1'
    local newdisplay = {}
    print(serverConfig['showroom'][showroomname])
    if serverConfig['showroom'][showroomname] == nil then -- kiểm tra trong database có sẵn có giá trị này không
        print('không')
        --tạo giá trị json mới với thông tin
        newdisplay = { 
            [slot] = {       
                position = vector3(100.0,777.0,123.0),   
                model = 't20' 
            }         
        }

    local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'displayloc.json'))
    garages[showroomname] = newdisplay -- lưu cái file với giá trị
    SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'displayloc.json', json.encode(garages), -1)
    serverConfig['showroom'][showroomname] = newdisplay -- cập nhật lại cho server biết

    else 
        print('tồn tại nen thay dổi')
        newdisplay = {
             
            position = vector3(111.0,999.0,8888.0),
            model = 'b40'
            
        }
        local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'displayloc.json'))
        garages[showroomname][slot] = newdisplay
        SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'displayloc.json', json.encode(garages), -1)
    end
end, false) ]]

RegisterServerEvent('lc_server:SaveDisplayLocation')
AddEventHandler('lc_server:SaveDisplayLocation', function(slot, name, position, vehicle)
    local src = source
    local dispos = position
    local newdisplay = {}
    local carslot = 'slot_'..slot
 
    if serverConfig['showroom'][name] == nil then
        print('add lần đầu và thêm slot')
        newdisplay = { 
            [carslot] = {       
                position = vector4(dispos[1],dispos[2],dispos[3],dispos[4]),   
                model = vehicle   
            }      
        }
        local display = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'displayloc.json'))
        display[name] = newdisplay
        SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'displayloc.json', json.encode(display), -1)
        serverConfig['showroom'][name] = newdisplay
    else
        print('thay đổi giá trị')
        newdisplay = {        
            position = vector4(dispos[1],dispos[2],dispos[3],dispos[4]),   
            model = vehicle         
        }
        local display = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'displayloc.json'))
        display[name][carslot] = newdisplay
        SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'displayloc.json', json.encode(display), -1)
        serverConfig['showroom'][name] = newdisplay
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