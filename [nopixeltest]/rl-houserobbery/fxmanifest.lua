fx_version 'adamant'
games { 'gta5' }

client_scripts {
    "client/client.lua",
	"config.lua",
	"client/safeCracking.lua"
}

server_scripts {
    "config.lua",
	"server/server.lua",
}

data_file 'DLC_ITYP_REQUEST' 'stream/v_int_shop.ytyp'

files {
 'stream/v_int_shop.ytyp'
}