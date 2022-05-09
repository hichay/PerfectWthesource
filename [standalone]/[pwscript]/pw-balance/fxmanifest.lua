fx_version 'adamant'
game 'gta5'

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"@pw-lib/server/sv_rpc.lua",
	"config.lua",
	"server/sv_*.lua",
}

client_scripts {
	"config.lua",
	"client/money.lua",
}

ui_page {
	'html/ui.html'
}

files {
	'html/*.html',
	'html/ui.html',
	'html/css/main.css',
	'html/css/pricedown_bl-webfont.ttf',
	'html/css/pricedown_bl-webfont.woff',
	'html/css/pricedown_bl-webfont.woff2',
	'html/css/gta-ui.ttf',
	'html/js/app.js',
	'html/css/pdown.ttf',
	'html/css/*.css',
	'html/css/*.ttf',
	'html/css/*.woff',
	'html/css/*.woff2',
}	