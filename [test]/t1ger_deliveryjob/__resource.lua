resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

description 'T1GER Delivery Job'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'language.lua',
	'config.lua',
	'server/server.lua',
}

client_scripts {
	'language.lua',
	'config.lua',
	'client/client.lua',
	'client/utils.lua',
}

-- IP LOCK REMOVED BY Barmy#6308