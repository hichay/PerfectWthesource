fx_version 'bodacious'
games { 'gta5' }

author 'Codesign#2715'
description 'Garage'
version '1.1'

client_scripts {
    'locales.lua',
    'config.lua',
    'client/*.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'locales.lua',
    'config.lua',
    'server/change_me.lua',
    'server/server.lua'
}

ui_page {
    'html/index.html',
}
files {
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js',
    'html/images/**/*.png',
}

server_exports {
    'GetGarageLimit',
    'GetGarageCount',
    'GetMaxHealth',
    'GetVehicleOwner',
}

exports {
    'GetGarageType',
    'GetAdvStats',
}