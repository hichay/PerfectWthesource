version '1.2.0'
author 'CoDev <https://github.com/CoDevFiveM>'

fx_version 'cerulean'
game 'gta5'

client_scripts {
    'cl_config.lua',
    'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'sv_config.lua',
    'server.lua'
}

ui_page 'html/main.html'

files {
    'html/main.html'
}


dependencies {
	'es_extended',
	'esx_billing'
}