fx_version 'cerulean'
games { 'gta5' }

client_script "@pw-sync/client/lib.lua"
client_script "@pw-lib/client/cl_ui.lua"
client_script "@pw-lib/client/cl_polyhooks.lua"

client_scripts {
  '@pw-lib/client/cl_rpc.lua',
  'client/cl_*.lua',
  "@PolyZone/client.lua",
}

shared_script {
  '@pw-lib/shared/sh_util.lua',
  'shared/sh_*.*',
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  '@pw-lib/server/sv_rpc.lua',
  'server/sv_*.lua',
}
