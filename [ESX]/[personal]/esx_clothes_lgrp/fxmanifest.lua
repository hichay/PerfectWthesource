fx_version 'adamant'
game 'gta5'
description 'LGRP - Zarządzanie Ubraniami'
version '1.0.0'

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'locales/en.lua',
	'locales/pl.lua',
	'client/cl_main.lua'
}

exports {
	'OpenESXMenu'
}

dependencies {
	'es_extended',
	'esx_skin'
}