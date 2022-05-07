fx_version "cerulean"

games {"gta5"}

description "NoPixel Peek Interactions"


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

client_script "@pw-array/Array.lua"
client_script "@pw-lib/client/cl_ui.lua"

client_scripts {
	"client/cl_*.lua",
	'@pw-lib/client/cl_rpc.lua',
	"client/entries/cl_*.lua",
}
