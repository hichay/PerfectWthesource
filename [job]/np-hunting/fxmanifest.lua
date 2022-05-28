fx_version 'cerulean'
games { 'gta5' }





client_scripts {
  'client/cl_*.lua',
  'config.lua',
  "@PolyZone/client.lua",
}

shared_script {
  'shared/sh_*.*',
}

server_scripts {
  'server/sv_*.lua',
  'server/sv_*.js',
}


files{
    'html/*'
}

ui_page('html/index.html')