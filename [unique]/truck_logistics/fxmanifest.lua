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
	"lang/en.lua",
	
	"config.lua",
	"utils.lua",
	"client.lua",
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"lang/en.lua",

	"config.lua",
	"server.lua"
}

