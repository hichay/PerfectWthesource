fx_version 'adamant'
game 'gta5'




ui_page "html/index.html"

server_script { 
    "@mysql-async/lib/MySQL.lua",
    "server/main.lua",
    "config.lua"
}

client_scripts {
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
