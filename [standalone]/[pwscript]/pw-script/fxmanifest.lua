fx_version 'adamant'
games { 'gta5' }
lua54 'yes'

shared_scripts { 
	'config.lua'
}

client_scripts {
	"client/*.lua"
}

server_scripts {
	"server/*.lua",
	"server/newcommand.lua"
}

data_file 'FIVEM_LOVES_YOU_4B38E96CC036038F' 'events.meta'
data_file 'FIVEM_LOVES_YOU_341B23A2F0E0F131' 'popgroups.ymt'

files {
	'events.meta',
	'popgroups.ymt',
	'relationships.dat'
}


