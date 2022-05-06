fx_version 'adamant'
game 'gta5'

author 'Opod'

mod 'opod-artheist'
version '1.1.0'

client_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua',
    'utils.lua',
    'client/functions.lua',
    'client/client.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua',
    'credentials.lua',
    'utils.lua',
    'server/server.lua',
    'server/callbacks.lua',
}