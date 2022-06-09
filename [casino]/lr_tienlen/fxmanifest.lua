-- Resource Metadata
fx_version 'cerulean'
games { 'gta5' }

author 'LORAX'
description 'Example resource'
version '1.0.1'

-- What to run
client_scripts {
    'config.lua',
    'client/*.lua'
}
server_scripts{
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/*.lua',
    'server/class/*.lua'
}
ui_page{
    'html/index.html'
}

files{
    "html/index.html",
    "html/style.css",
    "html/deckType.js",
    "html/cards.js",
    "html/app.js",
    "html/img/*.png"
}