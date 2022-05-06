fx_version 'cerulean'
game 'gta5'

description 'QB-Scoreboard'
version '1.0.0'

ui_page 'html/ui.html'

shared_scripts { 
	'config.lua'
}

client_script 'client.lua'
server_script 'server.lua'

server_script '@mysql-async/lib/MySQL.lua'

files {
    'html/*'
}