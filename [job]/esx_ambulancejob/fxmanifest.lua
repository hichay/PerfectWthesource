fx_version "cerulean"
games { "gta5" }

shared_scripts {
    "@pw-lib/shared/sh_util.lua",
    "@pw-lib/shared/sh_ids.lua",
	"shared/*.lua"
}


server_scripts {
	"@pw-lib/server/sv_rpc.lua",
	'@es_extended/locale.lua',
	'@oxmysql/lib/MySQL.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	"@pw-lib/client/cl_rpc.lua",
	"@pw-lib/client/cl_ui.lua",
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua',
	'client/job.lua',
	'client/cl_*.lua',
}

ui_page 'html/ui.html'

files {
	'html/**',
	"images/*"
}

dependencies {
	'es_extended',
}

exports{
  'GetPlayerDead'
}