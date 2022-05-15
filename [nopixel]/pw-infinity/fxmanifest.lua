fx_version "cerulean"
games { "gta5" }

shared_scripts {
    "shared/*.*",
}

server_scripts {
    "@pw-lib/server/sv_rpc.lua",
    "server/sv_config.lua",
    "server/*.*",
}

client_scripts {
    "@pw-lib/client/cl_rpc.lua",
    "client/classes/*.*",
    "client/*.*",
}










