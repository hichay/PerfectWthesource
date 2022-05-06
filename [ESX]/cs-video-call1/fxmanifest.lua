fx_version 'bodacious'

game 'gta5'

author 'Critical Scripts | https://criticalscripts.shop'
version '2.0.3'

files {
    'client/hooks/core.lua',
    'client/hooks/core.js',
    'client/hooks/vendor.js',
    'client/hooks/script.js'
}

lua54 'on'

dependency 'yarn'

client_scripts {
    'client/core.lua'
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    'config.lua',
    'server/core.lua',
    'server/proxy.js'
}
