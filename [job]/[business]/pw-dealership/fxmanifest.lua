fx_version 'bodacious'
game 'gta5'

ui_page('nui/og.html')

client_script{
    "@pw-lib/client/cl_ui.lua",
    '@pw-lib/client/cl_rpc.lua',
    "lang/*.lua",

    'utils.lua',
    'client.lua',
    'config.lua',
}

server_script {
    "@oxmysql/lib/MySQL.lua",
    '@pw-lib/server/sv_rpc.lua',
    "lang/*.lua",

    'config.lua',
    'sv_show.lua',
	'server.lua',
	'server_utils.lua',
}

files {
    'nui/lang/*',
    'nui/images/*',
    'nui/images/cars/*',

    'nui/og.html',
    'nui/og.css',
    'nui/og.js'
}