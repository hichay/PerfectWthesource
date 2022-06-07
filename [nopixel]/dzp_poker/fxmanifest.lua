fx_version 'bodacious'

game 'gta5'

description 'daZepelin Poker system'

version '1.0.2'

client_scripts {
    'config.lua',
    'ultil.lua',
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'classes/player.lua',
    'functions/functions.lua',
    'server.lua',
    'debugs.lua'
}

ui_page {
    'html/ui.html',
}

files {
    -- UI
    'html/ui.html',
    'html/ui.js',
    'html/ui.css',
    -- Images
    'html/images/*.png',
    'html/images/cards/*.png',
}