fx_version 'cerulean'
game 'gta5'

author ''
description 'Admin Menu'

ui_page "nui/index.html"

client_scripts {
    'client/cl_*.lua',
    '@pw-lib/client/cl_rpc.lua',
    'shared/sh_config.lua',
}

server_scripts {
    '@pw-lib/server/sv_rpc.lua',
    '@oxmysql/lib/MySQL.lua',
    'server/sv_*.lua',
}

files {
    "nui/index.html",
    "nui/js/*.js",
    "nui/css/*.css",
    "nui/webfonts/*.css",
    "nui/webfonts/*.otf",
    "nui/webfonts/*.ttf",
    "nui/webfonts/*.woff2",
}

dependencies {
    'oxmysql',
}

lua54 'yes'