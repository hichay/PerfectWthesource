fx_version 'cerulean'
games { 'gta5' }

author 'Lorax <admin@lorraxs.com>'
description 'LR Core'
version '1.0.0'

-- What to run
client_scripts {
    '@pw-lib/client/cl_rpc.lua',
    'config.lua',
    'client/main.lua',
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@pw-lib/server/sv_rpc.lua',
    'config.lua',
    'server/platform.lua',
    'server/main.lua',
}
files {
    'html/build/*.html',
    'html/build/*.png',
    'html/build/static/**/*',
    'Platforms.json'
} 
ui_page 'html/build/index.html'