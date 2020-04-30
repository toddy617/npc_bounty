ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

ESX.PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(0) end
    ESX.TriggerServerCallback('bounty:getlocation', function(servercoords)
        coords = servercoords
    end)
end)

local coords
local usedItem = false
local active = false
local blip
local cleanDead
local enroute
local radius
local enemies = {}
local box2
local location = nil
--local rand = math.random(#Config.locations)
local rand = 3 -- This is for testing locations only. Don't unhash this if you don't know what this does

-- Hash this out if useItem is false and you want the starting location to have a blip
--[[Citizen.CreateThread(function()
	while not coords do
		Citizen.Wait(1000)
	end
	marker = AddBlipForCoord(coords.x, coords.y, coords.z)	
	SetBlipSprite(marker, 90)       -- blip sprites: https://wiki.gtanet.work/index.php?title=Blips
	SetBlipScale(marker, 0.9)
    SetBlipAsShortRange(marker, true)
    BeginTextCommandSetBlipName("STRING")
    EndTextCommandSetBlipName(marker)
    SetBlipColour(marker, 4)
end)]]

RegisterNetEvent('bounty:intel')
AddEventHandler('bounty:intel', function(source)
	if not usedItem then
		usedItem = true
		phoneAnim()
		main()
	else
		exports['mythic_notify']:DoLongHudText('inform', _U'used')
	end
end)

if not Config.useItem then
	Citizen.CreateThread(function()
		while not coords do
			Citizen.Wait(1000)
		end
		local sleep
		while true do
			sleep = 5
			local player = GetPlayerPed(-1)
			local playercoords = GetEntityCoords(player)
			local dist = #(vector3(playercoords.x, playercoords.y, playercoords.z)-vector3(coords.x, coords.y, coords.z))
			if not Config.locations[rand]['active'] then
				if dist < 10 then
					sleep = 5
					DrawText3Ds(coords.x, coords.y, coords.z, _U'press_start')
					DrawMarker(1, coords.x, coords.y, coords.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.5, 2.5, 0.2, 0, 255, 100, 100, false, true, 2, false, false, false, false)
					if IsControlJustPressed(1, 51) then
						main()
					end				
				elseif dist < 3 then
					sleep = 5
					DrawText3Ds(coords.x, coords.y, coords.z, _U'unavailable')
				else
					sleep = 1500
				end
			end
			Citizen.Wait(sleep)
		end
	end)
end

RegisterNetEvent('bounty:syncMissionClient')
AddEventHandler('bounty:syncMissionClient', function(missionData)
  locations = missionData
end)

function main()
	TriggerServerEvent('bounty:syncMission', locations)
	active = true
	location = Config.locations[rand]
	Config.locations[rand]['active'] = true
	SetNewWaypoint(location.addBlip.x,location.addBlip.y)
	addBlip(location.addBlip.x,location.addBlip.y,location.addBlip.z)
	exports['mythic_notify']:DoLongHudText('inform', _U'search_area')
	local player = GetPlayerPed(-1)
	local playerpos
	enroute = true
	Citizen.CreateThread(function()
		while enroute == true do
			Citizen.Wait(200)
			playerpos = GetEntityCoords(player)
			local disttocoord = #(vector3(location.enemy.x, location.enemy.y, location.enemy.z)-vector3(playerpos.x,playerpos.y,playerpos.z))
			if disttocoord < 200 then
				exports['mythic_notify']:DoLongHudText('inform', _U'kill_all')
				spawnPed(location.enemy.x,location.enemy.y,location.enemy.z)
				--RemoveBlip(radius)					-- Unhash this if you want the red circle to disappear once you're at the location
				enroute = false
				return
			else
				Citizen.Wait(1000)
			end
		end
	end)
	Citizen.CreateThread(function()
		while active do 
		Citizen.Wait(1000)
			if IsEntityDead(player) then
				Citizen.Wait(1000)
				clearmission()
				return
			else
				local targetDead = checkisdead()
				if targetDead == Config.enemies then
					exports['mythic_notify']:DoLongHudText('inform', _U'killed_all')
					Citizen.Wait(2000)
					clearmission()
					success(location.crate.x, location.crate.y, location.crate.z, location.crate.h)
				end
			end
		end
	end)
end



function success(x,y,z,h)
	local box = GetHashKey("prop_mb_crate_01b")
	box2 = CreateObject(box, x,y,z-1, true, true, false)
	local crate = false
	local player = GetPlayerPed(-1)
	FreezeEntityPosition(box2, true)
	SetEntityHeading(box2, h)
	Citizen.CreateThread(function()
		while not crate do 
			local sleep = 5
			local playercoords = GetEntityCoords(player)
			local disttocoord = #(vector3(x,y,z)-vector3(playercoords.x, playercoords.y, playercoords.z))
			if disttocoord <= 3 then
				sleep = 5
				DrawText3Ds(x,y,z, _U'search_crate')
				if IsControlJustPressed(1, 51) then
					crate = true
					FreezeEntityPosition(GetPlayerPed(-1), true)
					exports['progressBars']:startUI(5500, _U'searching')
					playAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 6000)
					Citizen.Wait(5000)
					DoScreenFadeOut(1000)
					Citizen.Wait(1500)
					DoScreenFadeIn(2000)
					FreezeEntityPosition(GetPlayerPed(-1), false)
					DeleteEntity(box2)
					exports['mythic_notify']:DoLongHudText('success', _U'receive_tags')
					TriggerServerEvent('bounty:GiveItem', location.crate.x, location.crate.y, location.crate.z, location.crate.h)
					Citizen.Wait(2000)
					Config.locations[rand]['active'] = false
					TriggerServerEvent('bounty:syncMission', locations)
				end
			else
				sleep = 1200
			end
			Citizen.Wait(sleep)
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		sleep = 5
		local player = GetPlayerPed(-1)
		local playercoords = GetEntityCoords(player)
		local disttocoord = #(vector3(2475.588, -384.1472, 94.39928)-vector3(playercoords.x, playercoords.y, playercoords.z))
		if disttocoord < 3 then
			DrawText3Ds(2475.588, -384.1472, 94.39928, _U'deliver_tags')
			if IsControlJustPressed(1, 51) then
				TriggerServerEvent('bounty:delivery')
				Citizen.Wait(2000)
			end
		else
			sleep = 1500
		end
	Citizen.Wait(sleep)
	end
end)

function phoneAnim()
	local player = GetPlayerPed(-1)
    local x,y,z = table.unpack(GetEntityCoords(player))
	exports['mythic_notify']:DoLongHudText('inform', _U'on_use')
	exports['progressBars']:startUI(8000, _U'decipher')
	playAnim('cellphone@', 'cellphone_text_read_base', 8000)
	Citizen.Wait(500)
	prop = CreateObject(GetHashKey('prop_npc_phone_02'), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    Citizen.Wait(8000)
    DeleteObject(prop)
end

function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Citizen.Wait(0) 
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end

function clearmission()
	RemoveBlip(radius)
	RemoveBlip(blip)
	usedItem = false
	active = false
	if Config.cleanDead then
		for a = 1, #enemies do
			if DoesEntityExist(enemies[a]) then
				DeleteEntity(enemies[a])
			end
		end
	end
	enemies = {}
	exports['mythic_notify']:DoLongHudText('inform', _U'search_evidence')
end

function checkisdead()
	local dead = 0
	for a = 1, #enemies do
		if IsEntityDead(enemies[a]) then
			dead = dead + 1
		end
	end
	return dead
end

function addBlip(x,y,z)
	radius = AddBlipForRadius(x, y, z, Config.radius)
	blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, 433)
	SetBlipColour(blip, 1)
	SetBlipHighDetail(radius, true)
	SetBlipColour(radius, 1)
	SetBlipAlpha (radius, 128)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U'mission_area')
	EndTextCommandSetBlipName(blip)
end

function spawnPed(x,y,z)
	local ped = GetHashKey("s_m_y_blackops_01")
	RequestModel(ped)

	while not HasModelLoaded(ped) do
		Citizen.Wait(0)
	end	

	for i=1,Config.enemies do
		local rnum = math.random(-10,40)
		local pick = math.random(1,5)
		
		local wep
		local enemy

		if pick == 1 then
			enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
			wep = GetHashKey(Config.weapon1)
		elseif pick == 2 then
			enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
			wep = GetHashKey(Config.weapon2)
		elseif pick == 3 then
			enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
			wep = GetHashKey(Config.weapon3)
		elseif pick == 4 then
			enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
			wep = GetHashKey(Config.weapon4)
		else 
			enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
			wep = GetHashKey(Config.weapon5)
		end

		SetPedFleeAttributes(enemy, 0, 0)
		SetPedCombatAttributes(enemy, 46, true)
		SetPedCombatAbility(enemy, 100)
		SetPedCombatMovement(enemy, 2)
		SetPedCombatRange(enemy, 2)
		SetPedKeepTask(enemy, true)
		GiveWeaponToPed(enemy, wep, 500, false, true)
		TaskShootAtEntity(enemy, GetPlayerPed(-1), -1, GetHashKey("FIRING_PATTERN_FULL_AUTO"))
		SetEntityMaxHealth(enemy, 400)
		SetEntityHealth(enemy, 400)
		SetPedAccuracy(enemy, 40)
		SetPedAsCop(enemy, true)
		SetPedDropsWeaponsWhenDead(enemy,false)
		TaskCombatPed(enemy, GetPlayerPed(-1), 0, 16)
		table.insert(enemies, enemy)
		--SetPedAiBlip(enemy, true)                 -- Unhash if you want enemies to show up on the map
	end
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

