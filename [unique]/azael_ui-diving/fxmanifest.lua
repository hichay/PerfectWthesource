fx_version 'adamant'

game 'gta5'

description 'UI - Diving By. Azael Dev'

version '1.1.4'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/app.js'
}

server_scripts {
	'config.server.lua',
	'server/main.lua'
}

client_scripts {
	'config.client.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	'mysql-async',
	'esx_status'
}
