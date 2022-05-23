fx_version "cerulean"
games { "gta5" }

shared_script {
    "@pw-lib/shared/sh_util.lua",
    "shared/*",
}

server_scripts {
    "@pw-lib/server/sv_rpc.lua",
    "server/*",
}

client_scripts {
    "@pw-lib/client/cl_rpc.lua",
    "client/*",
}