fx_version 'bodacious'
games { 'gta5' }



ui_page 'index.html'

files {
  	
  "index.html",
  "js/script.js",	
  "js/jquery.js",
  "css/style.css"
}
client_script {
  "config.lua",
  "client/client.lua",
  "client/menu.lua",
}

server_script {
  "server/server.lua",

}

export "FishingGame"
export "testFunc"
