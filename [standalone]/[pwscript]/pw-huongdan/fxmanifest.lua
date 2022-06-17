fx_version 'adamant'
game 'gta5'




ui_page "html/index.html"
shared_script {
    'shared/*.lua'
}
server_script { 
    '@pw-lib/server/sv_rpc.lua',
    "@oxmysql/lib/MySQL.lua",
    "server/main.lua",
    "config.lua"
}

client_scripts {
    '@pw-lib/client/cl_rpc.lua',
    'shared/*.lua',
	"client/main.lua",
    "config.lua"
}

files {
    "html/*.js",
    "html/*.html",
    "html/*.css",
    "html/img/*.png",
    "html/img/*.jpg"
}
