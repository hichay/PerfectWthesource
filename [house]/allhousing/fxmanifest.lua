fx_version 'adamant'
games { 'rdr3', 'gta5' }

mod 'allhousing'
version '1.0.7'

client_scripts {
  -- NATIVE UI DEPENDENCY
  -- COMMENT OUT IF NOT USING NATIVEUI
  --'@NativeUILua_Reloaded/src/NativeUIReloaded.lua',

  -- SOURCE
  'config.lua',
  'houses.lua', 
  'labels.lua', 

  'src/utils.lua',  

  'src/client/framework/framework_functions.lua',
  'src/client/menus/menus.lua',
  'src/client/menus/menus_native.lua',
  'src/client/menus/menus_esx.lua',
  'src/client/menus/garage.lua',

  'src/client/functions.lua',
  'src/client/main.lua',
  'src/client/commands.lua',
}

server_scripts {
  -- MYSQL DEPENDENCY
  '@mysql-async/lib/MySQL.lua',

  -- SOURCE
  'config.lua',
  'credentials.lua',
  'houses.lua',  
  'labels.lua', 

  'src/utils.lua',
  
  'src/server/framework/framework_functions.lua',

  'src/server/functions.lua',
  'src/server/main.lua',
}

files {
	'stream/houseshell/shellprops.ytyp',
	'stream/houseshell/shellpropsv2.ytyp',
	'stream/houseshell/shellpropsv3.ytyp',
	'stream/houseshell/shellpropsv4.ytyp',
	'stream/houseshell/shellpropsv5.ytyp',
	'stream/houseshell/shellpropsv2.ytyp',

	'stream/houseshell/shellpropsv7.ytyp',
	'stream/houseshell/shellpropsv8.ytyp',
        'stream/houseshell/shellpropsv9.ytyp',
        'stream/houseshell/shellpropsv10.ytyp',
        'stream/houseshell/shellpropsv5.ytyp',
	'stream/frankelientje/frankelientje.ytyp',
	'stream/tante_shell/tante.ytyp',
	'stream/traphouse_shell/traphouse_shell.ytyp',

	

}

data_file 'DLC_ITYP_REQUEST' 'stream/houseshell/shellprops.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/houseshell/shellpropsv2.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/houseshell/shellpropsv3.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/houseshell/shellpropsv4.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/houseshell/shellpropsv5.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/houseshell/shellpropsv7.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/houseshell/shellpropsv8.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/houseshell/shellpropsv9.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/houseshell/shellpropsv10.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/houseshell/shellpropsv5.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/frankelientje/frankelientje.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/tante_shell/tante.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/traphouse_shell/traphouse_shell.ytyp'






dependencies {
  -- COMMENT OUT IF NOT USING ESX
  'es_extended',

  -- COMMENT OUT IF NOT USING NATIVEUI
  --'NativeUILua_Reloaded',

  'mysql-async',
  'input',
  'mythic_interiors',
  'meta_libs',
}

