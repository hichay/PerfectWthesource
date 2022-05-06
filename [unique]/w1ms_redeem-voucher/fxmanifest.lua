fx_version 'adamant'

game 'gta5'

version '1.1.0'

description 'w1ms_redeem-voucher'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client/main.lua'
}

ui_page "html/ui.html"

files {
    "html/ui.html",
    "html/*.js",
    "html/*.css"
}

dependencies {
	'pNotify'
}
