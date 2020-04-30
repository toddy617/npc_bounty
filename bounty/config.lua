Config = {}
Config.Locale = 'en' -- Language of the resource. Currently available: en, de

Config.useItem = true -- change this if you want to use an item to start missions or use a hidden location - (true/false)
Config.hiddencoords = vector3(234.933, -2056.778, 17.98385) -- if useItem is false then you will have to set the coords for the hidden location here - (x,y,z) 
Config.cleanDead = false -- change this if you want the peds to be deleted once they die - (true/false)
Config.enemies = 10 -- change this to the amount of enemies you want to spawn at a location - (10-20 enemies recommended)
Config.radius = 500.0 -- change this to increase/decrease the radius of the search area - (float value)

-- Change the weapons the peds spawn with. Make sure the weapons aren't blacklisted or else this won't work
Config.weapon1 = "WEAPON_APPISTOL"
Config.weapon2 = "WEAPON_ASSAULTRIFLE"
Config.weapon3 = "WEAPON_CARBINERIFLE_MK2"
Config.weapon4 = "WEAPON_ASSAULTSHOTGUN"
Config.weapon5 = "WEAPON_PUMPSHOTGUN"

-- Amount of money you get for selling Dog Tags
Config.reward = 2000

Config.locations = {
	[1] = { 
		addBlip = {x = 2667.334, y = 2669.441, z = 79.88748}, -- This changes the location of the blip on the map
		enemy = {x = 2612.81, y = 2810.234, z = 33.69377},    -- Location of enemy spawns
		crate = {x = 2657.274, y = 2807.249, z = 34.15653},   -- Location of the crates. Always include heading.
		active = false, 									  -- Don't touch this
	},
	[2] = { 
		addBlip = {x = 1438.831, y = -2353.163, z = 66.89214},				
		enemy = {x = 1539.24, y = -2100.481, z = 77.15993},					
		crate = {x = 1508.386, y = -2156.067, z = 77.65121, h = 271.52},	
		active = false,														
	},														  -- Location 2 and 3 have the same blip location but different enemy/crate spawns.
	[3] = {																	
		addBlip= {x = 1438.831, y = -2353.163, z = 66.89214},				
		enemy = {x = 1128.841, y = -2307.9, z = 30.71902},					
		crate = {x = 1074.854, y = -2319.52, z = 30.30385, h = 82.56},		
		active = false,														
	},																			
	[4] = {
		addBlip = {x = 443.8298, y = -2934.208, z = 6.064885},
		enemy = {x = 136.176, y = -3106.581, z = 5.894944},
		crate = {x = 950.4691, y = -2599.586, z = 10.11571, h = 185.22},
		active = false,
	},
}
