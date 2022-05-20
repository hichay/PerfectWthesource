fx_version "cerulean"
games { "gta5" }

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/vendor/fontawesome-free/all.min.css',
    'html/js/script.js',
    'html/js/demo/datables-demo.js',
    'html/vendor/bootstrap/bootstrap.bundle.min.js',
    'html/vendor/datatables/dataTables.bootstrap4.min.js',
    'html/vendor/datatables/jquery.dataTables.min.js',
    'html/vendor/jquery/jquery.min.js',
    'html/vendor/jquery-easing/jquery.easing.min.js',
}

client_scripts {
	'@pw-lib/client/cl_rpc.lua',
    'client/functions.lua',
    'client/client.lua',
    'client/nui.lua',
    'client/keys.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',    
	'@pw-lib/server/sv_rpc.lua',
    'config.lua',
    'server/server.lua',
    'server/coords.lua',
    'server/keys.lua',
}



exports{
  'HasVehicleKey'
}