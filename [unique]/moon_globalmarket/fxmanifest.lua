fx_version 'adamant'
games { 'gta5' }

server_scripts {
	-- Version
	'core/version.lua',
	-- Async, MySQL
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	-- Config
	'config.lua',
	'config_item.lua',
	'config_categorys.lua',
	'config_markets.lua',
	'config_translate.lua',
	'config_discord.lua',
	-- Core
	'core/funcs.lua',
	'core/server.lua'
}

client_scripts {
	-- Version
	'core/version.lua',
    -- Config
	'config.lua',
	'config_item.lua',
	'config_categorys.lua',
	'config_markets.lua',
	'config_translate.lua',
	'config_discord.lua',
	-- Core
	'core/funcs.lua',
	'core/client.lua'
}

ui_page "html/index.html"

files {
	'html/*',
	'html/css/*',
	'html/js/*',
	'html/images/*',
	
	-- fontawesome
	'html/fontawesome/*',
	'html/fontawesome/css/*',
	'html/fontawesome/webfonts/*'
}