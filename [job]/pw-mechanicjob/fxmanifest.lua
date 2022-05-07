fx_version 'cerulean'
game 'gta5'

description 'QB-MechanicJob'
version '1.0.0'

client_scripts {
	'@pw-lib/client/cl_rpc.lua',
	'config.lua',
	'client/main.lua',
	'client/towvehicle.lua',
	'client/menu.lua',
}

server_scripts {
	'@pw-lib/server/sv_rpc.lua',
	'@pw-lib/server/sv_rpc.lua',
	'@oxmysql/lib/MySQL.lua',
    'server/main.lua',
	'config.lua',
}

exports {
	'GetVehicleStatusList',
	'GetVehicleStatus',
	'SetVehicleStatus',
}
