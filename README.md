# npc_bounty
[Quick video showcase](https://streamable.com/sujyy9)

This is a highly configurable FiveM resource made entirely in Lua. It's comparable to the GTA:O gang attacks.

It features basic co-op functionality and many options to tune it to your liking.

I've also translated the notifications to German.

---

# Prerequisites

- ESX
- A working database

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

---

# Config options:

- Config.Locale - _English or German. More translations might follow_
- Config.policeJob - _The name of your servers police job_
- Config.amountCop - _Amount of players with policeJob needed to start with difficulty 1_
- Config.hideBlip - _For hiding the start location on the map_
- Config.cleanDead - _Cleans up the killed NPCs on mission success/fail_
- Config.printRemaining - _Draws the amount of NPCs remaining. Increases resource usage_
- Config.useMythic - _If you want to use mythic_notify keep this on true_
- Config.progBar - _If you want to use the progressbar keep this on true_
- Config.removeArea - _This will remove the red radius on the map once the enemies spawn_
- Config.aiBlip - _Shows enemies on the map_
- Config.useDirtyMoney - _If this is set to true then you will receive dirty money instead of clean cash when selling Dog Tags_
- Config.waypoint - _Sets a waypoint to the enemies once you're close enough_
- Config.blipSprite - _Change the sprite of the blip if you're drawing it_
- Config.enemies - _Amount of enemies you want to spawn_
- Config.enemyHealth - _Sets the amount of health the enemies spawn with_
- Config.enemyAcc - _The accuracy the enemies will have_
- Config.enemyVest - _Toggle this to give the enemies armor_
- Config.enemyArmor - _Amount of armor you want the enemies to have if the above is true_
- Config.radius - _The search radius you want to draw on the map_
- Config.distance - _Enemies will spawn once you've passed the distance you set here_
- Config.boxProp - _The prop that should spawn on success_
- Config.spawnedEnemy - _The peds that will attack you_
- Config.reward - _Amount of money you will receive by selling Dog Tags_
