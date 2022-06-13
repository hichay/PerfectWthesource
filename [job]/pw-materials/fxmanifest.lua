fx_version 'cerulean'
game 'gta5'

shared_scripts {
    'config.lua',    

}

client_scripts {
 '@pw-lib/client/cl_rpc.lua',
 'config.lua',
 'client/client.lua',
 'client/recycle.lua',
 'client/scrapyard.lua',
 'client/cl_*.lua',
 'client/trashcans.lua',
 'client/props.lua',
}

server_scripts {
 '@pw-lib/server/sv_rpc.lua',   
 'config.lua',
 'server/sv_*.lua',
 'server/server.lua',
}

exports {
 'IsNearScrapYard',
}
