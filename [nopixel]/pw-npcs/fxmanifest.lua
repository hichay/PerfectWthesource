fx_version "cerulean"
games { "gta5" }

shared_scripts {
    "@pw-lib/shared/sh_util.lua",
    "shared/*.*"
}

server_scripts {
    "server/*.*"
}

client_scripts {
    "@pw-lib/client/cl_flags.lua",
    "@pw-lib/client/cl_rpc.lua",
    "client/classes/*.*",
    "client/*.*",
}