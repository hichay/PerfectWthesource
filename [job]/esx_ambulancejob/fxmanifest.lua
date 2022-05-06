fx_version 'adamant'

game 'gta5'

description 'ESX Ambulance Job'

version '1.2.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'locales/cs.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'locales/cs.lua',
	'config.lua',
	'client/main.lua',
	'client/job.lua',
	'client/vehicle.lua',
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
	'esx_skin'
}
