fx_version "cerulean"
games { "gta5" }

shared_script {
    "@pw-lib/shared/sh_util.lua",
    "shared/*",
}

server_scripts {
    "@pw-lib/server/sv_rpc.lua",
    "server/doors/*",
    "server/elevators/*",
    "server/*",
}

client_scripts {
	'@pw-lib/client/cl_rpc.lua',
	'@pw-lib/client/cl_rpc.lua',
	'@pw-lib/client/cl_ui.lua',
    "@pw-lib/client/cl_rpc.lua",
    "@pw-lib/client/cl_polyhooks.lua",
    "client/*",
}