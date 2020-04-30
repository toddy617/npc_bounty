ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local usedIntel = false
local hiddencoords = Config.hiddencoords

ESX.RegisterServerCallback('bounty:getlocation', function(source, cb)
    cb(hiddencoords)
end)

RegisterServerEvent("bounty:GiveItem")
AddEventHandler("bounty:GiveItem", function(x,y,z)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local myPed = GetPlayerPed(_source)
	local myPos = GetEntityCoords(myPed)
	local dist = #(vector3(x,y,z) - myPos)
	if dist <= 3 then
    	xPlayer.addInventoryItem("dogtags", 1)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert:long', _source, { type = 'error', text = _U'dist_check'})
	end
end)

if Config.useItem then
	ESX.RegisterUsableItem('intel', function(source)
	    local xPlayer = ESX.GetPlayerFromId(source)
	    xPlayer.removeInventoryItem('intel', 1)
	    TriggerClientEvent('bounty:intel', source)
	end)
end

RegisterServerEvent("bounty:syncMission")
AddEventHandler("bounty:syncMission", function(missionData)
	local missionData = missionData
	--tprint(missionData, 1)          -- Prints locations table and which one is active in the server console 
	TriggerClientEvent('bounty:syncMissionClient', -1, missionData)
end)

RegisterServerEvent("bounty:delivery")
AddEventHandler("bounty:delivery", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local check = xPlayer.getInventoryItem('dogtags').count

    if check >= 1 then
    	xPlayer.addMoney(Config.reward)
    	xPlayer.removeInventoryItem('dogtags', 1)
    	TriggerClientEvent('mythic_notify:client:SendAlert:long', _source, { type = 'inform', text = _U'dollar'..Config.reward.._U'payment'})
    else
    	TriggerClientEvent('mythic_notify:client:SendAlert:long', _source, { type = 'error', text = _U'no_tags'})
    end
end)

function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    elseif type(v) == 'boolean' then
      print(formatting .. tostring(v))
    else
      print(formatting .. v)
    end
  end
end


-------------------------------------------------------

--[[RegisterServerEvent("bounty:synccoop")
AddEventHandler("bounty:synccoop", function(players)
	print("IN SERVER SYNCCOOP")
	for j=1,#players do
		print(j,players[j])
		TriggerClientEvent('bounty:startcoop', players[j])
	end
	print("Skipped loop")
end)]]