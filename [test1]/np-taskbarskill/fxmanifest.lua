fx_version 'adamant'
games { 'gta5' }

ui_page 'index.html'

files {
  "index.html",
  "js/scripts.js",
  "js/jquery.js",
  "css/style.css"
}
client_script {
  "client.lua",
}

export "taskBar"
export "closeGuiFail"