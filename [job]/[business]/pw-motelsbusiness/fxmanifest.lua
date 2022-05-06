fx_version 'bodacious'

game 'gta5'

client_scripts {
    'langs/core.lua',
    'langs/tr.lua',
    'client/gui.lua',
    'client/methods.lua',
    'client/menu.lua',
    'client/core.lua'
}

ui_page "html/main.html"

files({
    "html/main.html",
    "html/main.js",
    "html/style.css",
    "html/assets/imgs/*",
    "html/fonts/*",
    "html/assets/sounds/*"
})

server_scripts {
    '@mysql-async/lib/MySQL.lua', -- if u using mysql remove the comment line
    'langs/core.lua',
    'langs/tr.lua',
    'config.lua',
    'server/BuildData.lua',
    'server/main.lua',
    'server/core.lua',
}

