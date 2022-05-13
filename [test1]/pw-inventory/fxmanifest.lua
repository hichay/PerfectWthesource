fx_version 'cerulean'
games {'gta5'}


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
  "nui/i18n.js",
  "nui/scripts.js",
  "nui/debounce.min.js",
  "nui/loading.gif",
  "nui/loading.svg",
  "nui/icons/*"
}



shared_script 'shared_list.js'
shared_script '@pw-lib/shared/sh_cacheable.js'
  
client_scripts {
	"@pw-lib/client/cl_rpc.js",
    "@pw-lib/client/cl_rpc.lua",
	'client/client.js',
	'client/cl_vehicleweights.js',
	'client/cl_*.lua',
	"@PolyZone/client.lua"
	
	
	
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/server_degradation.js',
	'server/server_shops.js',
	'server/server.js',
	'server/server.lua'
	
}




exports{
  'getFreeSpace',
  'hasEnoughOfItem',
  'getQuantity',
  'GetCurrentWeapons',
  'GetItemInfo',
  'GetInfoForFirstItemOfName',
  'getFullItemList',
}

