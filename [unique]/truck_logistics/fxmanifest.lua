fx_version 'cerulean'
game 'gta5'


ui_page "nui/ui.html"

files {
	"nui/ui.html",
	"nui/panel.js",
	"nui/style.css",
	"nui/img/*"
}

client_scripts {
	'@pw-lib/client/cl_rpc.lua',
	"lang/en.lua",
	
	"config.lua",
	"utils.lua",
	"client.lua",
}

server_scripts {
	'@pw-lib/server/sv_rpc.lua',
	"@oxmysql/lib/MySQL.lua",
	"lang/en.lua",

	"config.lua",
	"server.lua"
}

