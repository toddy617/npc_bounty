# npc_bounty
[Quick video showcase](https://streamable.com/sujyy9)

This is a (somewhat) highly configurable FiveM resource made entirely in Lua. It's comparable to the GTA:O gang attacks.

It features basic co-op functionality and many options to tune it to your liking.

I've also translated the notifications to German.

# Table of contents

[Prerequisites](https://github.com/TTVErraticAlcoholic/npc_bounty/blob/master/ReadMeFirst.md#prerequisites)

[Optional resources](https://github.com/TTVErraticAlcoholic/npc_bounty/blob/master/ReadMeFirst.md#optional-resources)

[How to install](https://github.com/TTVErraticAlcoholic/npc_bounty/blob/master/ReadMeFirst.md#how-to-install)

[Config options](https://github.com/TTVErraticAlcoholic/npc_bounty/blob/master/ReadMeFirst.md#config-options)

[How to add new locations](https://github.com/TTVErraticAlcoholic/npc_bounty/blob/master/ReadMeFirst.md#how-to-add-new-locations)

[How to add more languages](https://github.com/TTVErraticAlcoholic/npc_bounty/blob/master/ReadMeFirst.md#how-to-add-more-languages)

---

# Prerequisites

- ESX
- A working database
- OneSync enabled on your FiveM server

---

# Optional resources: 

Install these like any other resource and set this in the config

```lua
Config.useMythic = true
Config.progBar = true
```

_[Mythic_notify](https://github.com/JayMontana36/mythic_notify)_

_[Progress Bars 1.0](https://forum.cfx.re/t/release-progress-bars-1-0-standalone/526287)_

---

# How to install:

1. Download the resource from [GitHub](https://github.com/TTVErraticAlcoholic/npc_bounty)
2. Unzip it
3. Put it in your resource folder
4. Add "start npc_bounty" to your server.cfg
5. Run bounty.sql
6. Done

---

# Config options:

- Config.Locale - __English or German. More translations might follow__
- Config.policeJob - __The name of your servers police job__
- Config.amountCop - __Amount of players with policeJob needed to start with difficulty 1__
- Config.hideBlip - __For hiding the start location on the map__
- Config.cleanDead - __Cleans up the killed NPCs on mission success/fail__
- Config.printRemaining - __Draws the amount of NPCs remaining. Increases resource usage__
- Config.useMythic - __If you want to use mythic__notify keep this on true__
- Config.progBar - __If you want to use the progressbar keep this on true__
- Config.removeArea - __This will remove the red radius on the map once the enemies spawn__
- Config.aiBlip - __Shows enemies on the map__
- Config.useDirtyMoney - __If this is set to true then you will receive dirty money instead of clean cash when selling Dog Tags__
- Config.waypoint - __Sets a waypoint to the enemies once you're close enough__
- Config.blipSprite - __Change the sprite of the blip if you're drawing it__
- Config.enemies - __Amount of enemies you want to spawn__
- Config.enemyHealth - __Sets the amount of health the enemies spawn with__
- Config.enemyAcc - __The accuracy the enemies will have__
- Config.enemyVest - __Toggle this to give the enemies armor__
- Config.enemyArmor - __Amount of armor you want the enemies to have if the above is true__
- Config.radius - __The search radius you want to draw on the map__
- Config.distance - __Enemies will spawn once you've passed the distance you set here__
- Config.boxProp - __The prop that should spawn on success__
- Config.spawnedEnemy - __The peds that will attack you__
- Config.reward - __Amount of money you will receive by selling Dog Tags__

---

# How to add new locations:

1. Download a tool like vMenu or set Config.getCoords to true and use the command
2. Find a suitable location for the middle of the area based on your radius
3. Find a suitable location for enemies to spawn. Make sure you have enough space so they don't spawn inside stuff
4. Find a good location for the crate spawn. (Optional) Hide it well
5. Done

---

# How to add more languages:

1. Open the locales folder
2. Create a new file in the locales folder and name it "yourlanguage".lua
3. Translate the locales from English/German to your preferred language
4. Add "yourlanguage".lua to the client_scripts and server_scripts in the fxmanifest.lua
5. Done

Your fxmanifest should look like the one below

![Your fxmanifest should look like this](https://i.imgur.com/1Z2Tky1.png)

