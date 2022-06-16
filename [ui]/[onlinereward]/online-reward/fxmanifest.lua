fx_version 'cerulean'
game 'gta5'

files {
	'html/menu.html',
	'html/css/style.css',
	'html/css/scotty.css',
	'html/fonts/SFProText-Regular.png',
	'html/images/check.png',
	'html/images/logo.png',
	'html/images/header.png',
	'html/js/script.js',
	'html/js/scotty.js',
	'html/js/jquery-3.1.0.min.js',
	
	'html/sound/bell.wav',
	'html/sound/gick.mp3',
	
	'html/images/promo/*',
	
}

ui_page {
	'html/menu.html'
}

client_scripts {
	'config.lua',
	'client.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'config_sv.lua',
	'server.lua'
}