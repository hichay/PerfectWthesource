--[[
	resource: scotty-stolen-vehicle
	desc: ขโมยรถไปขาย
	author: Scotty1944
	contact: https://www.facebook.com/Scotty1944/
	warning: หากนำไปขายต่อหรือแจกจ่าย หรือใช้ร่วมกันเกิน 1 server จะถูกยกเลิก license ทันที
]]

fx_version 'adamant'

game 'gta5'

author 'Scotty1944'
description 'Scotty: Stolen Vehicle'
version '1.0'

client_scripts {
	'client.lua'
}

server_scripts {
	'config.lua',
	'config_sv.lua',
	'server.lua'
}

files {
	'stream/sarabun.gfx',
	
	'ui/menu.html',
	'ui/css/style.css',
	'ui/js/script.js',
	'ui/sound/vc.mp3',
	'ui/sound/vc2.mp3',
}

ui_page {
	'ui/menu.html'
}