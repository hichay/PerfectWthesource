fx_version 'bodacious'
games { 'rdr3', 'gta5' }

description "Weapons"


client_scripts {
  "client.lua",
  "pickups.lua",
  "melee.lua"
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
  "server.lua"
}

server_export 'getWeaponMetaData'
server_export "updateWeaponMetaData"

exports {
  'toName',
  'findModel'
}