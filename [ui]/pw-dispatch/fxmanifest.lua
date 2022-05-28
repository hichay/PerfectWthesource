fx_version "cerulean"
games { "gta5" }

ui_page "html/index.html"

files {
	"html/*.html",
	"html/*.js",
	"html/*.css",
}

shared_scripts {
	"@pw-lib/shared/sh_util.lua",
	"shared/*",
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"@pw-lib/server/sv_rpc.lua",
    "server/*",
}

client_scripts {
	"@pw-lib/client/cl_rpc.lua",
	'@pw-lib/client/cl_ui.lua',	
	"client/*",
}