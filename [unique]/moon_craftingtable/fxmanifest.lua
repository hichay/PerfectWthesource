--[[
	resource: scotty-crafting
	desc: โต๊ะคราฟสำหรับใช้งานใน esx
	author: Scotty1944
	contact: https://www.facebook.com/Scotty1944/
	warning: หากนำไปขายต่อหรือแจกจ่าย หรือใช้ร่วมกันเกิน 1 server จะถูกยกเลิก license ทันที
]]

fx_version 'adamant'

game 'gta5'

description 'Scotty: Crafting Table'

client_scripts {
	'config.lua',
	'client.lua'
}

server_scripts {
	'config.lua',
	'config_sv.lua',
	'server.lua'
}

files {
	'stream/sarabun.gfx',
	
	'html/menu.html',
	'html/css/style.css',
	'html/css/scotty.css',
	'html/js/script.js',
	'html/js/scotty.js',
	'html/js/jquery-3.1.0.min.js',
	'html/sound/success.ogg',
	'html/sound/failed.ogg',
}

ui_page 'html/menu.html'