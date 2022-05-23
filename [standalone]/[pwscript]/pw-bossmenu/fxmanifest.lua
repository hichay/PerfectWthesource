fx_version "cerulean"
games { "gta5" }

ui_page 'html/index.html'

files {
    'html/*',
    'html/assets/*',
}
server_scripts {
	"@pw-lib/server/sv_rpc.lua",
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server/server.lua'
}

client_scripts {
	"@pw-lib/client/cl_rpc.lua",
	"@pw-lib/client/cl_ui.lua",
	"@pw-sync/client/lib.lua",
	'config.lua',
	'client/client.lua'
}

server_export "GetAccount"
