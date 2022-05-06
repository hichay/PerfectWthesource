fx_version 'adamant'

game 'gta5'

dependencies {
    "PolyZone"
}

ui_page 'html/index.html'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/list.lua',	
    'client/cl_main.lua',	
    'client/main.lua'
}

files {
	'html/index.html',
	'html/css/style.css',
	'html/css/all.css',
	'html/js/all.js',
	'html/js/script.js'
}