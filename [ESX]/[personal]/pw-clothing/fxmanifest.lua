fx_version 'cerulean'
game 'gta5'

description 'Clothing'

ui_page 'nui/index.html'

shared_scripts  {
	'shared/sh_*.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@pw-lib/server/sv_rpc.lua',
	'server/sv_*.lua'
}

client_scripts {
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
	'@pw-lib/client/cl_rpc.lua',
    'client/cl_*.lua'
}
files {
	'nui/index.html',
	'nui/css/*.css',
	'nui/js/**.js',
	'nui/img/*.png'
}

lua54 'yes'