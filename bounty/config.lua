Config = {}
Config.Locale = 'en' -- Language of the resource - (en, de)

Config.policeJob = "police" -- change this to the name of the police job on your server - (name, not label)
Config.amountCop = 1 -- change this to increase/decrease the amount of police needed to start the mission with Difficulty 1 or 2
Config.useItem = true -- change this if you want to use an item to start missions or use a hidden location - (true/false)
Config.hideBlip = true -- -- change this if useItem is false and you want the starting location to have a blip - (true/false)
Config.cleanDead = false -- change this if you want the peds to be deleted once they die - (true/false)
Config.removeArea = false -- change this if you want the red circle to disappear once you're at the location - (true/false)
Config.aiBlip = true -- change this if you want the enemies to have a blip on the map - (true/false)
Config.useDirtyMoney = false -- change this if you want to receive dirty money for selling dog tags - (true/false)
Config.blipSprite = 90 -- if hideBlip is false then change this to your preferred sprite - (list of sprites: https://wiki.gtanet.work/index.php?title=Blips)
Config.enemies = 10 -- change this to the amount of enemies you want to spawn at a location - (10-20 enemies recommended)
Config.radius = 500.0 -- change this to increase/decrease the radius of the search area - (float value)
Config.distance = 200 -- change this to increase/decrease the distance at which the enemies spawn - (might see enemies pop in with lower values)
Config.hiddencoords = vector3(1100.461, -2285.486, 30.13453) -- if useItem is false then you will have to set the coords for the hidden location here - (x,y,z)
Config.boxProp = "prop_mb_crate_01b" -- change the prop that will be used as a lootable source. Adjust crate x,y,z,h accordingly - (list of props: https://plebmasters.de/?app=objects)
Config.spawnedEnemy = "s_m_y_blackops_01" -- change the ped that will spawn and attack you - (list of peds: https://wiki.rage.mp/index.php?title=Peds)

-- Change the weapons the peds spawn with on difficulty 1.  Make sure the weapons aren't blacklisted on your server - (List of guns: https://forum.cfx.re/t/list-of-weapon-spawn-names-after-hours/90750)
Config.difficulty1_1 = "WEAPON_REVOLVER_MK2"
Config.difficulty1_2 = "WEAPON_PISTOL"
Config.difficulty1_3 = "WEAPON_COMBATPISTOL"
Config.difficulty1_4 = "WEAPON_HEAVYPISTOL"
Config.difficulty1_5 = "WEAPON_SNSPISTOL"
	
-- Change the weapons the peds spawn with on difficulty 2.
Config.difficulty2_1 = "WEAPON_COMBATMG_MK2"
Config.difficulty2_2 = "WEAPON_ASSAULTRIFLE"
Config.difficulty2_3 = "WEAPON_CARBINERIFLE_MK2"
Config.difficulty2_4 = "WEAPON_ASSAULTSHOTGUN"
Config.difficulty2_5 = "WEAPON_PUMPSHOTGUN"

-- Amount of money you get for selling Dog Tags
Config.reward = 2000

Config.locations = {
	[1] = { 
		addBlip = {x = 2667.334, y = 2669.441, z = 79.88748}, -- This changes the location of the blip on the map
		enemy = {x = 2612.81, y = 2810.234, z = 33.69377},    -- Location of enemy spawns. I recommend finding a somewhat hidden spot for the enemy spawn so you don't see them pop in
		crate = {x = 2657.274, y = 2807.249, z = 34.15653, h = 271.52},  -- Location of the crates. Always include heading. Try hiding it.
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
