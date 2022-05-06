fx_version 'cerulean'
game 'gta5'

description 'Esx_RufiFoodtruck by rufidufix#6767'
files {
	'common/carvariations.meta',
	'common/vehicles.meta',
	'common/*.meta'
}
data_file 'VEHICLE_METADATA_FILE' 'common/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'common/carvariations.meta'

client_scripts {
	 'client_customice_me.lua',
	 'DoNotTouch.lua',
	 'config.lua'
}

server_scripts {
   
	'server_customice_me.lua',
	'DoNotTouch2.lua',
	'crack.lua',
	'config.lua',
	'@mysql-async/lib/MySQL.lua'
	
}