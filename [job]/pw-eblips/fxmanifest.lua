fx_version "cerulean"
games { "gta5" }

shared_script {
    "shared/*",
}

server_scripts {
    "@pw-lib/server/sv_rpc.lua",
    "@pw-lib/server/sv_infinity.lua",
    "server/*",
}

client_scripts {
    "@pw-lib/client/cl_rpc.lua",
    "@pw-infinity/client/classes/blip.lua",
    "@pw-lib/client/cl_infinity.lua",
    "client/*",
}