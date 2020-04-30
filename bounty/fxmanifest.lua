fx_version 'bodacious'
games { 'gta5' }

author 'Erratic'
description 'bounty hunter shit'
version '1.0.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/en.lua',
	'config.lua',
    'client/bounty_cl.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/en.lua',
	'config.lua',
    'server/bounty_sv.lua'
}




