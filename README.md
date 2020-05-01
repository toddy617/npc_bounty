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

- Config.Locale - English or German. More translations might follow
- Config.policeJob - The name of your servers police job
- Config.amountCop - Amount of players with policeJob needed to start with difficulty 1
- Config.hideBlip - For hiding the start location on the map
- Config.cleanDead - Cleans up the killed NPCs on mission success/fail
- Config.printRemaining - Draws the amount of NPCs remaining. Increases resource usage.
- Config.useMythic - If you want to use mythic_notify keep this on true
- Config.progBar - If you want to use the progressbar keep this on true
- Config.removeArea - This will remove the red radius
- Config.aiBlip
- Config.useDirtyMoney
- Config.waypoint
- Config.blipSprite
- Config.enemies
- Config.enemyHealth
- Config.enemyAcc
- Config.enemyVest
- Config.enemyArmor
- Config.radius
- Config.distance
- Config.boxProp
- Config.spawnedEnemy
- Config.reward
