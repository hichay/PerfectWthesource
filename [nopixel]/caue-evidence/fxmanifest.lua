fx_version "cerulean"
games { "gta5" }

shared_script {
    "@pw-lib/shared/sh_util.lua",
    "@pw-lib/shared/sh_cacheable.lua",
    "shared/*",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "@pw-lib/server/sv_rpc.lua",
    "server/*",
}

client_scripts {
    "@pw-lib/client/cl_rpc.lua",
    "client/*",
    'client/**/clm_*.lua',
}