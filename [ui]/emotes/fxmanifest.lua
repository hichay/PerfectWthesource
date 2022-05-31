fx_version 'adamant'
games { 'gta5' }

client_script "@warmenu/warmenu.lua"


client_scripts {
	"@pw-sync/client/lib.lua",
    "@pw-lib/client/cl_flags.lua",
	"client.lua",
	"cl_menu.lua",
	"sitchair.lua",
	"safecracking.lua",
	
}

dependencies {
	'es_extended'
}
