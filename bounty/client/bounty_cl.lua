ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

ESX.PlayerData = ESX.GetPlayerData()
end)

local onDuty
local coords
local usedItem = false
local active = false
local blip
local cleanDead
local enroute
local radius
local marker
local enemies = {}
local box2
local inUse = false
local location = nil
--local rand = math.random(#Config.locations)
local rand = 8 -- This is for testing locations only. Don't unhash this if you don't know what this does

if not Config.hideBlip then
	Citizen.CreateThread(function()
		while not coords do
			Citizen.Wait(1000)
		end
		marker = AddBlipForCoord(coords.x, coords.y, coords.z)	
		SetBlipSprite(marker, Config.blipSprite)
		SetBlipScale(marker, 0.9)      
	    SetBlipAsShortRange(marker, true)
	    BeginTextCommandSetBlipName("STRING")
	    EndTextCommandSetBlipName(marker)
	    SetBlipColour(marker, 4)
	    if Config.hideBlip then
			RemoveBlip(marker)
		end
	end)
end

Citizen.CreateThread(function()
	while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(0) end
    ESX.TriggerServerCallback('bounty:getlocation', function(servercoords)
        coords = servercoords
    end)
end)

RegisterNetEvent('bounty:synctable')
AddEventHandler('bounty:synctable', function(bool)
    inUse = bool
end)

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
			if not inUse then
				if dist < 10 then
					sleep = 5
					DrawText3Ds(coords.x, coords.y, coords.z, _U'press_start')
					DrawMarker(1, coords.x, coords.y, coords.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.5, 2.5, 0.2, 0, 255, 100, 100, false, true, 2, false, false, false, false)
					if IsControlJustPressed(1, 51) then
						main()
					end		
				end		
			elseif dist < 10 then
				sleep = 5
				DrawText3Ds(coords.x, coords.y, coords.z, _U'unavailable')
			else
				sleep = 3000
			end
			Citizen.Wait(sleep)
		end
	end)
end

RegisterNetEvent('bounty:onDuty')
AddEventHandler('bounty:onDuty', function(copsOn)
	onDuty = copsOn 
end)

RegisterNetEvent('bounty:syncMissionClient')
AddEventHandler('bounty:syncMissionClient', function(missionData)
  locations = missionData
  inUse = missionData
end)

function main()
	TriggerServerEvent('bounty:updatetable', true)
	inUse = true
	location = Config.locations[rand]
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
			if disttocoord < Config.distance then
				exports['mythic_notify']:DoLongHudText('inform', _U'kill_all')
				spawnPed(location.enemy.x,location.enemy.y,location.enemy.z)
				enroute = false
				if Config.removeArea then
					RemoveBlip(radius)	
				end			
				return
			else
				Citizen.Wait(1000)
			end
		end
	end)
	Citizen.CreateThread(function()
		while inUse do 
		Citizen.Wait(1000)
			if IsEntityDead(player) then
				Citizen.Wait(1000)
				clearmission()
				return
			else
				local howmany = checkisdead()
				if howmany == Config.enemies then
					Citizen.Wait(2000)
					clearmission()
					success(location.crate.x, location.crate.y, location.crate.z, location.crate.h)
				end
			end
		end
	end)
end

function success(x,y,z,h)
	local box = GetHashKey(Config.boxProp)
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
	inUse = false
	TriggerServerEvent('bounty:updatetable', false)
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
	local ped = GetHashKey(Config.spawnedEnemy)
	RequestModel(ped)
	while not HasModelLoaded(ped) do
		Citizen.Wait(0)
	end	

	ESX.TriggerServerCallback("bounty:getCops", function(getCops)
		if Config.waypoint then 
    		SetNewWaypoint(x, y)
    	end
		for i=1,Config.enemies do
			local rnum = math.random(10,50)
			local pick = math.random(1,5)
			local wep
			local enemy

			if onDuty >= Config.amountCop then
				--Difficulty 1
				if pick == 1 then
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty1_1)
				elseif pick == 2 then
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty1_2)
				elseif pick == 3 then
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty1_3)
				elseif pick == 4 then
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty1_4)
				else 
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty1_5)
				end

			elseif onDuty < Config.amountCop then
				--Difficulty 2
				if pick == 1 then
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty2_1)
				elseif pick == 2 then
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty2_2)
				elseif pick == 3 then
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty2_3)
				elseif pick == 4 then
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty2_4)
				else 
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty2_5)
				end
			end

			SetPedFleeAttributes(enemy, 0, 0)
			SetPedCombatAttributes(enemy, 46, true)
			SetPedCombatAbility(enemy, 100)
			SetPedCombatMovement(enemy, 2)
			SetPedCombatRange(enemy, 2)
			SetPedKeepTask(enemy, true)
			GiveWeaponToPed(enemy, wep, 500, false, true)
			TaskShootAtEntity(enemy, GetPlayerPed(-1), -1, GetHashKey("FIRING_PATTERN_FULL_AUTO"))
			SetEntityMaxHealth(enemy, Config.enemyHealth)
			SetEntityHealth(enemy, Config.enemyHealth)
			SetPedAccuracy(enemy, Config.enemyAcc)
			SetPedAsCop(enemy, true)
			SetPedDropsWeaponsWhenDead(enemy,false)
			TaskCombatPed(enemy, GetPlayerPed(-1), 0, 16)
			table.insert(enemies, enemy)
			if Config.enemyVest then
				SetPedArmour(enemy, Config.enemyArmor)
			end
			if Config.aiBlip then
				SetPedAiBlip(enemy, true) 
			end               
		end
	end)
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
