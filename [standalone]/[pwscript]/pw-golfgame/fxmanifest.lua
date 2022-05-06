version '1.0.0'
author 'freamee'
decription 'Aquiver golf'

client_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua',
    'client/client.lua'
}

server_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/server.lua'
}

dependencies {
    'es_extended',
    'mysql-async'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/js/*.js',
    'html/DEP/*.js',
    'html/img/**',
    'html/ProximaNova.woff'
}

game 'gta5'
fx_version 'adamant'
