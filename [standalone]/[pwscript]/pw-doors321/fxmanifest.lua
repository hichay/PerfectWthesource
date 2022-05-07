
fx_version 'cerulean'

games {
    'gta5',
    'rdr3'
}

client_scripts {
	'client/cl_*.lua'
}

shared_scripts {
	"shared/*.lua"
}

server_scripts {
	'server/*.lua'
}

ui_page 'html/index.html'
file 'html/index.html'

exports {
	'showInteraction',
    'hideInteraction'

}