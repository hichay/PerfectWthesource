fx_version "cerulean"
games { "gta5" }


shared_scripts {
    "@pw-lib/shared/sh_util.lua",
    "@pw-lib/shared/sh_ids.lua",
	"shared/*.lua"
}

server_scripts {
	"@pw-lib/server/sv_rpc.lua",
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua',
	'server/another.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	"@pw-lib/client/cl_rpc.lua",
    "@pw-lib/client/cl_lib.lua",
	"@pw-lib/client/cl_ui.lua",
	'locales/en.lua',
	'arres_ani.lua',
	"shared/*",
	'config.lua',
	'client/main.lua',
	'client/menu.lua',
	'client/function.lua',
	'client/vehicle.lua',
	'client/cl_*.lua'
}

