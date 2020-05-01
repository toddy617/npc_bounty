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
