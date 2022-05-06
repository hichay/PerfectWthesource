fx_version 'adamant'
games { 'gta5' }

ui_page('html/index.html') --THIS IS IMPORTENT


files({
    'html/index.html',
	'html/js/script.js',
	'html/css/style.css',
	'html/img/*',

	'html/fonts/helveticaneue.ttf'
})

server_scripts {
    	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/server.lua'
}

client_scripts {
    	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/client.lua'
}

dependencies {
	'es_extended'
}