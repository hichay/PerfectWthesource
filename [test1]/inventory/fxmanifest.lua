fx_version 'bodacious'
games { 'gta5' }


ui_page 'nui/ui.html'

files {
	"nui/ui.html",
	"nui/pricedown.ttf",
	"nui/default.png",
	"nui/background.png",
	"nui/weight-hanging-solid.png",
	"nui/hand-holding-solid.png",
	"nui/search-solid.png",
	"nui/invbg.png",
	"nui/styles.css",
	"nui/scripts.js",
	"nui/debounce.min.js",
	"nui/loading.gif",
	"nui/loading.svg",
	"nui/icons/*"
  }
client_scripts {
	'client.js',
	'functions.lua',
	'cl_vehicleweights.js',	
	"@PolyZone/client.lua"
	
}

server_scripts {
	'server_degradation.js',
	'server_shops.js',
	'server.js',
	'server.lua'
}

shared_script 'shared_list.js'
export 'hasEnoughOfItem'
server_export 'hasEnoughOfItem'
exports{
  'getQuantity',
  'GetCurrentWeapons',
  'getCash',
  'getJobsss',		
  'GetItemInfo'
}


dependencies {
    "PolyZone"
}
