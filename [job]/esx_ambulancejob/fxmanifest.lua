fx_version "cerulean"
games { "gta5" }

shared_scripts {
    "@pw-lib/shared/sh_util.lua",
    "@pw-lib/shared/sh_ids.lua",
	"shared/*.lua"
}


server_scripts {
	"@pw-lib/server/sv_rpc.lua",
	'@oxmysql/lib/MySQL.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	"@pw-lib/client/cl_rpc.lua",
	"@pw-lib/client/cl_ui.lua",
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua',
	'client/job.lua',
	'client/vehicle.lua',
	'client/cl_vehicles.lua',
}

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

dependencies {
	'es_extended',
}

exports{
  'GetPlayerDead'
}