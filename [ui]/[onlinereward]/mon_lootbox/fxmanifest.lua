fx_version 'cerulean'
game 'gta5'

files {
	'html/menu.html',
	'html/css/style.css',
	'html/css/scotty.css',
	'html/js/script.js',
	'html/js/scotty.js',
	'html/js/jquery-3.1.0.min.js',
	'html/js/jquery-ui.min.js',
	
	'html/sound/preview.mp3',
	'html/sound/roll.mp3',
	'html/sound/unbox.mp3',
	
	'html/images/item_background.jpg',
	-- Vehicles
	'html/images/vehicle/baller.png',
    'html/images/items/*',
}

ui_page {
	'html/menu.html'
}

client_scripts {
	'config.lua',
	'client.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'config_sv.lua',
	'server.lua'
}