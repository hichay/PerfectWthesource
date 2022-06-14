fx_version 'cerulean'
games {'gta5'}
shared_script {
    "@pw-lib/shared/sh_util.lua",
    "shared/*",
}

client_scripts {
    '@pw-lib/client/cl_rpc.lua',
    "@pw-lib/client/cl_ui.lua",
    'client/cl_*.lua',
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    '@pw-lib/server/sv_rpc.lua',
    'server/*.lua'
    
}
