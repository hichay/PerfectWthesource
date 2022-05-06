fx_version 'adamant'

game 'gta5'

ui_page "html/index.html"

client_scripts {
    "client/main.lua",
    "client/trunk.lua",
    "client/emotes_triggers.lua",
	"config.lua",
}

server_scripts {
    "server/main.lua",
    "config.lua",
    "server/trunk.lua",
}

files {
    'html/index.html',
    'html/css/main.css',
    'html/css/RadialMenu.css',
    'html/js/main.js',
    'html/js/RadialMenu.js',
    'html/css/all.css',	
    'html/js/all.js',	
}