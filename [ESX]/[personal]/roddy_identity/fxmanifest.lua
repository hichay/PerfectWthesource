fx_version 'adamant'
game 'gta5'
-- Leaked By: Leaking Hub | J. Snow | leakinghub.com
description 'Roddy\'s Identity'
version 'legacy'
-- Leaked By: Leaking Hub | J. Snow | leakinghub.com
shared_script '@es_extended/imports.lua'
-- Leaked By: Leaking Hub | J. Snow | leakinghub.com
server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/cs.lua',
	'locales/pl.lua',
	'locales/fi.lua',	
	'config.lua',
	'server/main.lua'
}
-- Leaked By: Leaking Hub | J. Snow | leakinghub.com
client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/cs.lua',
	'locales/pl.lua',
	'locales/fi.lua',	
	'config.lua',
	'client/main.lua'
}
-- Leaked By: Leaking Hub | J. Snow | leakinghub.com
ui_page 'html/index.html'
files {
	'html/**'
}

dependency 'es_extended'
