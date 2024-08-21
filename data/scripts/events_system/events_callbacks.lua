local evmaps = EVENTS_MAPS
local evconfig = EVENTS_CONFIG

survivalEventChests = Action()
function survivalEventChests.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local getText = ""
	for i, child in ipairs(getEventRooms()) do
		if child.chests then
			for iChest, childChest in ipairs(child.chests) do
				if evconfig.chestActionId + (i * 100) + iChest == item:getActionId() then
					for iReward,childReward in pairs(childChest.reward) do
						local getItemType = ItemType(childReward.id)
						local getStack = 1
						if childReward.stack and type(childReward.stack) == "table" then
							getStack = math.random(childReward.stack[1],childReward.stack[2])
						elseif childReward.stack then
							getStack = childReward.stack
						end
						player:addItem(childReward.id, getStack)
						if string.len(getText) > 0 then
							getText = getText .. ", ".. getStack .." ".. getItemType:getName()
						else
							getText = getStack .." ".. getItemType:getName()
						end
						item:setActionId(0)
						if item:getId() == 355 then
							item:transform(857)
						elseif item:getId() == 356 then
							item:transform(856)
						end
					end
				end
			end
		end
	end
	
	if string.len(getText) > 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found ".. getText .."!")
	end
	
	hotkeys:sendUpdate(player)
	
	return false
end
--survivalEventChests:register()
--Registered in system after rooms have been created

survivalEventDoors = Action()
function survivalEventDoors.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local roomId = playerRoomMemory[player:getId()] and playerRoomMemory[player:getId()].roomId
	if not roomId then print("SURVIVAL EVENT: onUse bug") return false end
	
	if eventRoomMemory[roomId].status < 2 then return false end
	
	local transformId = EVENTS_DOORS[item:getId()]
	if transformId then
		item:transform(transformId)
	end

	return false
end

for doorId, _ in pairs(EVENTS_DOORS) do
	survivalEventDoors:id(doorId)
end
survivalEventDoors:register()

function getEventName(name)
    if name == "Survival" or name == "x4 All vs All" or name == "1 vs 1" then
        return "Survival"
    end
    return name
end

survivalEventDeath = CreatureEvent("survivalEventDeath")
function survivalEventDeath.onPrepareDeath(player, killer)

	
	local roomId = playerRoomMemory[player:getId()] and playerRoomMemory[player:getId()].roomId
	if not roomId then return true end
	
	local getConfig = getEventRoom(roomId)
	if not getConfig then print("SURVIVAL EVENT: "..player:getName().." onPrepareDeath bug with room:"..tostring(roomId)) return true end
	if eventRoomMemory[roomId].status < 1 then 
	    QUEUE_ROOM_SYSTEM:removePlayer(player)
	    return true 
	end
	
	local getPlayers = eventRoomMemory[roomId].players	
	if evconfig.dbs.playersLog then
		for i,child in pairs(player:getDamageMap()) do
			if child.attackerName and string.len(child.attackerName) > 1 then
				if os.mtime() - child.ticks < evconfig.assistData.duration*1000 then
					if not killer or (killer and killer:getId() ~= i) and playerRoomMemory[i] then
						playerRoomMemory[i].asistance = playerRoomMemory[i].asistance and playerRoomMemory[i].asistance + 1 or 1
					end
					DIVISION_SYSTEM:addPoints(player, evconfig.assistData.points)
					local resultAsistance = db.storeQuery("SELECT `event_name`, `points`, `kills_asistance` FROM `"..evconfig.dbs.playersLog.."` WHERE `player_id` = " .. child.attackerGuid .. " AND `event_name` = ".. db.escapeString(getEventName(getConfig.name)) .."")
					if resultAsistance == false then
						db.query(string.format("INSERT INTO `"..evconfig.dbs.playersLog.."`(`player_id`, `event_name`, `points`, `kills_total`, `kills_combo`, `kills_asistance`, `reward_taken`) VALUES (%s, %s, %s, %s, %s, %s, %s)", child.attackerGuid, db.escapeString(getEventName(getConfig.name)), evconfig.assistData.points, 0, 0, 1, 0))
					else
						local getPoints = result.getNumber(resultAsistance, "points") + evconfig.assistData.points
						local getAsistance = result.getNumber(resultAsistance, "kills_asistance") + 1
						db.query("UPDATE `"..evconfig.dbs.playersLog.."` SET `kills_asistance`='".. getAsistance .."', `points`='".. getPoints .."' WHERE `player_id` = " .. child.attackerGuid .. " AND `event_name` = ".. db.escapeString(getEventName(getConfig.name)) .."");
					end
					result.free(resultAsistance)
				end
			end
		end
	end
	
	--if not playerRoomMemory[killer:getId()].kills then print("SURVIVAL EVENT: onDeath killer bug") return false end
	if killer and playerRoomMemory[killer:getId()] then
		playerRoomMemory[killer:getId()].kills = playerRoomMemory[killer:getId()].kills and playerRoomMemory[killer:getId()].kills + 1 or 1
	end
	
	if getConfig.playerEvents then
		for _i, ev in ipairs(getConfig.playerEvents) do
			player:unregisterEvent(ev)
		end
	end
					
	if player:findEvent() then 
		player:addHealth(player:getMaxHealth())
		player:addMana(player:getMaxMana())
		DAILY_SYSTEM:addProgress(player, "Daily")
		QUEUE_ROOM_SYSTEM:removePlayer(player)
		return false 
	end
	
	hotkeys:sendUpdate(player)
	QUEUE_ROOM_SYSTEM:removePlayer(player)
	
	return true
end
survivalEventDeath:type('preparedeath')
survivalEventDeath:register()

survivalEventLogout = CreatureEvent("survivalEventLogout")
function survivalEventLogout.onLogout(player)
	
	local roomId = playerRoomMemory[player:getId()] and playerRoomMemory[player:getId()].roomId
	if not roomId then return true end
	local getConfig = getEventRoom(roomId)
	if not getConfig then print("SURVIVAL EVENT: "..player:getName().." onLogout bug with room:"..tostring(roomId)) return true end
	if eventRoomMemory[roomId].status < 1 then return true end
	local getPlayers = eventRoomMemory[roomId].players
	if evconfig.dbs.playersLog then
			local getRewardPoints = getConfig.players[getPlayers].points or 0
			local kills = playerRoomMemory[player:getId()].kills or 0
			local getKillsPoints = evconfig.killsCombo[kills] and evconfig.killsCombo[kills] or 0
			
						
			local resultPoints = db.storeQuery("SELECT `event_name`, `points`, `kills_total`, `kills_combo`, `kills_asistance` FROM `"..evconfig.dbs.playersLog.."` WHERE `player_id` = " .. player:getGuid() .. " AND `event_name` = ".. db.escapeString(getEventName(getConfig.name)) .."")
			if resultPoints == false then	
				db.query(string.format("INSERT INTO `"..evconfig.dbs.playersLog.."`(`player_id`, `event_name`, `points`, `kills_total`, `kills_combo`, `kills_asistance`, `reward_taken`) VALUES (%s, %s, %s, %s, %s, %s, %s)", player:getGuid(), db.escapeString(getEventName(getConfig.name)), getKillsPoints, kills, kills, 0, 0))
			else
				local getPoints = result.getNumber(resultPoints, "points") + getRewardPoints + getKillsPoints
				local getKills = result.getNumber(resultPoints, "kills_total") + kills
				local getCombo = result.getNumber(resultPoints, "kills_combo")
				if getCombo < kills then
					getCombo = kills
				end
				db.query("UPDATE `"..evconfig.dbs.playersLog.."` SET `kills_total`='".. getKills .."', `kills_combo`='".. getCombo .."', `points`='".. getPoints .."' WHERE `player_id` = " .. player:getGuid() .. " AND `event_name` = ".. db.escapeString(getEventName(getConfig.name)) .."");
			end
			result.free(resultPoints)
			playerRoomMemory[player:getId()].kills = 0
			
	end
	
	for i,child in pairs(eventRoomMemory[roomId].members) do
		if child.name:lower() == player:getName():lower() then
			child.place = getPlayers
		end
	end
	
	
	getPlayers = getPlayers - 1
	eventRoomMemory[roomId].players = getPlayers
	
	
	local playerTable = QUEUE_ROOM_SYSTEM:getPlayerEvent(player)
	local eventName = playerTable.eventName
	if getPlayers < 2 then
		addEvent(finishRoomEvent,50,eventName,roomId)
	end
	
	hotkeys:sendUpdate(player)
	
	return true
end
survivalEventLogout:type('logout')
survivalEventLogout:register()

survivalEventBarrelDeath = CreatureEvent("BarrelDeath")
function survivalEventBarrelDeath.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)

	creature:getPosition():sendMagicEffect(85)

	local player = killer or mostDamageKiller
	if not player then
		return true
	end
	
	local roomId = playerRoomMemory[player:getId()] and playerRoomMemory[player:getId()].roomId
	if not roomId then return true end
	local getConfig = getEventRoom(roomId)
	
	local barrelPosition = creature:getPosition()
	
	local random_number = math.random(1, 100)
	if random_number < 50 then
		local monster_type = getRandomOption("monsters")
		if monster_type then
			Game.createMonster(monster_type, barrelPosition, false, true)
		end
	else
		local chest_type = getRandomOption("chests")
		if chest_type then
			local chest = Game.createItem(chest_type, 1, barrelPosition)
			if chest and getConfig.spontaneousChests then
				table.insert(getConfig.spontaneousChests, {
					pos = chest:getPosition(),
					usedBy = nil
				})
				
				chest:setActionId(evconfig.chestActionId)
			end
		end
	end	
	
	return true
end
survivalEventBarrelDeath:register()

survivalEventSponChestUse = Action()
function survivalEventSponChestUse.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local roomId = playerRoomMemory[player:getId()] and playerRoomMemory[player:getId()].roomId
	if not roomId then return true end
	local getConfig = getEventRoom(roomId)

	local chest_type = item:getId()
	if not roomId or not getConfig or not table.contains({355, 356}, chest_type) then
		return true
	end

	local chest = nil
	for _, chestData in ipairs(getConfig.spontaneousChests) do
		if chestData.pos == item:getPosition() then
			chest = chestData
			break
		end
	end
	
	if not chest or chest.usedBy then
		return true
	end
	
	chest.usedBy = player:getGuid()
	
	local text = ""
	local minAmount = chest_type == 355 and 1 or 2
	local maxAmount = chest_type == 355 and 3 or 4
	for _, rewardId in ipairs(getConfig.spontaneousChestRewards) do
		local amount = math.random(minAmount, maxAmount)
		local rewardItemType = ItemType(rewardId)
		local rewardItemName = rewardItemType:getName() 
		player:addItem(rewardId, amount)
		
		text = string.len(text) > 0 and text .. ", " or text	
		text = text .. (amount > 1 and amount .. "x " or "") .. rewardItemName
	end
	
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, ("You have found %s!"):format(text))
	
	item:setActionId(0)
	if item:getId() == 355 then
		item:transform(857)
	elseif item:getId() == 356 then
		item:transform(856)
	end
	
	hotkeys:sendUpdate(player)
end

survivalEventSponChestUse:aid(evconfig.chestActionId)
survivalEventSponChestUse:register()

zoneDamageThink = CreatureEvent("event_zone_damage")
function zoneDamageThink.onThink(creature, interval)
	local roomId = playerRoomMemory[creature:getId()] and playerRoomMemory[creature:getId()].roomId
	if not roomId then return true end
	
	local getConfig = getEventRoom(roomId)
	local currentStage = getConfig.stages[getConfig.stage]
	if not currentStage.zones then
		return true
	end

	local insideZone = false
	local allZones = type(currentStage.zones) == 'string' and true or false
	local ppos = creature:getPosition()
	
	if not allZones then
		for _, zone in ipairs(currentStage.zones) do
			if ppos.x >= zone.from.x and ppos.x <= zone.to.x
			and ppos.y >= zone.from.y and ppos.y <= zone.to.y
			and ppos.z >= zone.from.z and ppos.z <= zone.to.z then
				insideZone = true
				break
			end
		end
	end
	
	if not insideZone then 
		local damage = currentStage.hpDamagePerTick
		doTargetCombat(0, creature:getId(), COMBAT_PHYSICALDAMAGE, -damage, -damage, CONST_ME_NONE)
	end
	
	return true
end
zoneDamageThink:register()

HIGHSCORE_OPCODE = 151
AUTOTRAVEL_OPCODE = 218
highscoreOpcode = CreatureEvent("highscoreOpcode")
function highscoreOpcode.onExtendedOpcode(player, opcode, buffer)
    local status, json_data = pcall(function()
        return json.decode(buffer)
    end)
    if not status then
        return false
    end
    local action = json_data['action']
    local data = json_data['data']
    if opcode == HIGHSCORE_OPCODE then
		if action == "openHighscore" then
			getHighscoreInfo(player)
		end
    

    elseif opcode == AUTOTRAVEL_OPCODE then
        if action == "teleportTo" then
			local eventName = data["room"]
			local vocation_string = data['vocation']
			player:findEvent(eventName, true, tostring(vocation_string))
        end
    end
end
highscoreOpcode:register()

survivalEventLogin = CreatureEvent("survivalEventLogin")
function survivalEventLogin.onLogin(player, room, vocation)
	player:registerEvent("survivalEventDeath")
	player:registerEvent("survivalEventLogout")
	player:registerEvent("highscoreOpcode")
	--room = "Racing"
	--local cScanner = os.mtime()
	--print(cScanner)
	player:teleportTo(evmaps["Social"].pos)
	player:prepareEventCharacter(vocation)
	player:sendAttributes(player)
	hotkeys:sendUpdate(player)
    return true
end
survivalEventLogin:type('login')
survivalEventLogin:register()
