fx_version 'adamant'

game 'gta5'

description 'Discord Server Logs (WEBHOOK)'

version '1.0.0'

server_script {
	'config.lua',	
	'config.events.lua',
	'server/main.lua'
}

client_script {
	'config.lua',
	'config.events.lua',
	'client/main.lua'
}

dependencies {
	'es_extended'
}
