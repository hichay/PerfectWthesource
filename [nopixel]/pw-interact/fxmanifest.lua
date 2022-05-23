fx_version "cerulean"
games {"gta5"}


ui_page "html/index.html"

files {
	"html/*.html",
	"html/*.css",
	"html/*.js",
	"html/*.png",
}


shared_scripts {
	"shared/sh_*.lua",
}

server_scripts {
	"server/sv_*.lua",
}


client_scripts {
	"@pw-lib/client/cl_ui.lua",
	"@pw-array/Array.lua",	
	"client/cl_*.lua",
	'@pw-lib/client/cl_rpc.lua',
	"client/entries/cl_*.lua",
}
