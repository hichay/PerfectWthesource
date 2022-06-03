fx_version 'cerulean'
games { 'gta5' }

shared_scripts {
  "shared/sh_*.lua"
}

client_scripts {
  "@pw-sync/client/lib.lua",
  "@pw-lib/client/cl_rpc.lua",
  "client/cl_*.lua",
}

server_scripts {
  "@pw-lib/server/sv_rpc.lua",
  "server/sv_*.lua",
}

exports {
	'GetFuel',
	'SetFuel'
}