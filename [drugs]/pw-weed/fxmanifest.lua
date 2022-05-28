fx_version 'cerulean'
games {'gta5'}

client_scripts {
    '@pw-lib/client/cl_rpc.lua',
    "@pw-lib/client/cl_ui.lua",
    'config.lua',
    'cl_weedpack.lua',
    'client.lua',
    'cl_weed.lua',
    'cl_recycle.lua',
}

server_script {
    '@pw-lib/server/sv_rpc.lua',
    'config.lua',
    'server.lua'
    
}
