fx_version 'cerulean'
game 'gta5'

files {
	"html/index.html",
	"html/jquery.countdown.min.js",
	"html/config.js",
	"html/script.js",
	"html/style.css",
	"html/boxx/A.png",
	"html/boxx/B.png",
	"html/boxx/C.png",
	"html/boxx/D.png",
	"html/boxx/E.png",
	"html/boxx/F.png",
	"html/boxx/firegif.gif",
}

ui_page 'html/index.html'

server_scripts {
	"config.lua",
	"server.lua",
	"@oxmysql/lib/MySQL.lua"
}
client_scripts {
	"client.lua"
}
