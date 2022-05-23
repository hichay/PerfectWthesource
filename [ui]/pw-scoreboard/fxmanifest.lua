fx_version 'cerulean'
game 'gta5'

description 'QB-Scoreboard'
version '1.0.0'

ui_page 'html/ui.html'

shared_scripts { 
	'config.lua'
}

client_script {
	'@pw-lib/client/cl_rpc.lua',
	'client.lua'
}

server_script {
	"@oxmysql/lib/MySQL.lua",
	'@pw-lib/server/sv_rpc.lua',
	'server.lua'
	
}


files {
    'html/*'
}