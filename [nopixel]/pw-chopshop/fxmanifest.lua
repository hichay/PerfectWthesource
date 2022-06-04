fx_version 'cerulean'
game 'gta5'
lua54 'yes'


client_scripts {
    "@pw-lib/client/cl_rpc.lua",
    '@pw-sync/client/lib.lua',
	'client/*.lua',
}

server_scripts {
    "@pw-lib/server/sv_rpc.lua",    
	'server/*.lua'
}
