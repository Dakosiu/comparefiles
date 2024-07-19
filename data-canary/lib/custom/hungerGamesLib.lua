hungerGamesStates = {
	NotStarted = -1,
	Preparing = 0,
	Started = 1,
}

hungerGamesStorages = {
	playerJoinedEvent = 2039430,
	spells = 2039431
}

hungerGamesEvent = {
	fromPos = Position({x = 546, y = 1180, z = 7}),
	toPos = Position({x = 718, y = 1327, z = 7}),
	maxPlayers = 28,
	minPlayers = 2,
	rewards = {
		[1] = {
			{itemId = 3043, count = 50},
		},
		[2] = {
			{itemId = 3043, count = 30},
		},
		[3] = {
			{itemId = 3043, count = 15},
		},
	},
	spells = {
		{name = "Light Healing", words = "exura", flag = 1},
		{name = "Energy Strike", words = "exori vis", flag = 2},
		{name = "Flame Strike", words = "exori flam", flag = 4},
		{name = "Whirlwind Throw", words = "exori hur", flag = 8},
	},
	spellEffect = CONST_ME_TELEPORT_PURPLE,
	spellScrollDescription = "You learned the spell '%s', use the words '%s' to cast it.",
	spellAlreadyObtained = "You already know that spell.",
	
	spellScrollItemId = 6119,
	spellScrollCustomAttribute = "words",
	spawnPos = {
		[1] = {x = 636, y = 1231, z = 7},
		[2] = {x = 633, y = 1231, z = 7},
		[3] = {x = 630, y = 1232, z = 7},
		[4] = {x = 627, y = 1233, z = 7},
		[5] = {x = 624, y = 1236, z = 7},
		[6] = {x = 623, y = 1239, z = 7},
		[7] = {x = 622, y = 1242, z = 7},
		[8] = {x = 622, y = 1245, z = 7},
		[9] = {x = 622, y = 1248, z = 7},
		[10] = {x = 623, y = 1251, z = 7},
		[11] = {x = 624, y = 1254, z = 7},
		[12] = {x = 627, y = 1257, z = 7},
		[13] = {x = 630, y = 1258, z = 7},
		[14] = {x = 633, y = 1259, z = 7},
		[15] = {x = 636, y = 1259, z = 7},
		[16] = {x = 639, y = 1259, z = 7},
		[17] = {x = 642, y = 1258, z = 7},
		[18] = {x = 645, y = 1257, z = 7},
		[19] = {x = 648, y = 1254, z = 7},
		[20] = {x = 649, y = 1251, z = 7},
		[21] = {x = 650, y = 1248, z = 7},
		[22] = {x = 650, y = 1245, z = 7},
		[23] = {x = 650, y = 1242, z = 7},
		[24] = {x = 649, y = 1239, z = 7},
		[25] = {x = 648, y = 1236, z = 7},
		[26] = {x = 645, y = 1233, z = 7},
		[27] = {x = 642, y = 1232, z = 7},
		[28] = {x = 639, y = 1231, z = 7},
	},
	
	teleport = {
		position = Position(937, 1113, 7),
		itemId = 37814,
		actionId = 29221,
		effect = CONST_ME_TELEPORT_RED,
	},
	
	preparingMessage = "[Hunger Games]\nThe teleport has been opened in the temple! You can join as well with the command !hungergames\nThe event starts in 5 minutes.",
	preparingWaitingTime = 5 * 60,
	
	notEnoughPlayersMessage = "[Hunger Games]\nThere were no enough players to start the event. It has been cancelled.",
	
	eventStartedMessage = "[Hunger Games]\nThe event started!",
	eventChannelStartMessage = "The event started, you can fight now and the first wave of monsters will appear in %d minutes.",
	
	chests = {
		itemId = {36980, 1747, 1748, 1749},
		possibleItems = {
			{itemId = 3272, count = 1, chance = 50000},
			{itemId = 3283, count = 1, chance = 30000},
			{itemId = 7774, count = 1, chance = 15000},
			{itemId = 3271, count = 1, chance = 5000},
		},
		totalItems = {15, 15},
		positions = {
			{x = 633, y = 1238, z = 7},
			{x = 639, y = 1238, z = 7},
			{x = 631, y = 1239, z = 7},
			{x = 635, y = 1239, z = 7},
			{x = 637, y = 1239, z = 7},
			{x = 641, y = 1239, z = 7},
			{x = 630, y = 1240, z = 7},
			{x = 642, y = 1240, z = 7},
			{x = 629, y = 1242, z = 7},
			{x = 643, y = 1242, z = 7},
			{x = 635, y = 1243, z = 7},
			{x = 637, y = 1243, z = 7},
			{x = 630, y = 1244, z = 7},
			{x = 634, y = 1244, z = 7},
			{x = 638, y = 1244, z = 7},
			{x = 642, y = 1244, z = 7},
			{x = 630, y = 1246, z = 7},
			{x = 634, y = 1246, z = 7},
			{x = 638, y = 1246, z = 7},
			{x = 642, y = 1246, z = 7},
			{x = 635, y = 1247, z = 7},
			{x = 637, y = 1247, z = 7},
			{x = 629, y = 1248, z = 7},
			{x = 643, y = 1248, z = 7},
			{x = 630, y = 1250, z = 7},
			{x = 642, y = 1250, z = 7},
			{x = 631, y = 1251, z = 7},
			{x = 635, y = 1251, z = 7},
			{x = 637, y = 1251, z = 7},
			{x = 641, y = 1251, z = 7},
			{x = 633, y = 1252, z = 7},
			{x = 639, y = 1252, z = 7},
			{x = 677, y = 1246, z = 7},
			{x = 711, y = 1238, z = 7},
			{x = 705, y = 1222, z = 7},
			{x = 700, y = 1207, z = 7},
			{x = 677, y = 1218, z = 7},
			{x = 667, y = 1217, z = 7},
			{x = 672, y = 1197, z = 7},
			{x = 681, y = 1195, z = 7},
			{x = 665, y = 1186, z = 7},
			{x = 651, y = 1182, z = 7},
			{x = 663, y = 1201, z = 7},
			{x = 644, y = 1196, z = 7},
			{x = 671, y = 1225, z = 7},
			{x = 643, y = 1222, z = 7},
			{x = 643, y = 1209, z = 7},
			{x = 690, y = 1241, z = 7},
			{x = 689, y = 1261, z = 7},
			{x = 675, y = 1254, z = 7},
			{x = 694, y = 1267, z = 7},
			{x = 661, y = 1278, z = 7},
			{x = 674, y = 1275, z = 7},
			{x = 675, y = 1281, z = 7},
			{x = 668, y = 1286, z = 7},
			{x = 635, y = 1284, z = 7},
			{x = 640, y = 1295, z = 7},
			{x = 668, y = 1293, z = 7},
			{x = 650, y = 1289, z = 7},
			{x = 656, y = 1311, z = 7},
			{x = 639, y = 1316, z = 7},
			{x = 633, y = 1297, z = 7},
			{x = 622, y = 1180, z = 7},
			{x = 634, y = 1184, z = 7},
			{x = 634, y = 1196, z = 7},
			{x = 636, y = 1197, z = 7},
			{x = 610, y = 1187, z = 7},
			{x = 595, y = 1198, z = 7},
			{x = 598, y = 1203, z = 7},
			{x = 588, y = 1207, z = 7},
			{x = 587, y = 1207, z = 7},
			{x = 583, y = 1224, z = 7},
			{x = 581, y = 1217, z = 7},
			{x = 576, y = 1226, z = 7},
			{x = 569, y = 1226, z = 7},
			{x = 580, y = 1241, z = 7},
			{x = 585, y = 1232, z = 7},
			{x = 567, y = 1235, z = 7},
			{x = 604, y = 1236, z = 7},
			{x = 596, y = 1233, z = 7},
			{x = 597, y = 1244, z = 7},
			{x = 570, y = 1248, z = 7},
			{x = 564, y = 1243, z = 7},
			{x = 569, y = 1256, z = 7},
			{x = 570, y = 1253, z = 7},
			{x = 559, y = 1270, z = 7},
			{x = 586, y = 1265, z = 7},
			{x = 594, y = 1262, z = 7},
			{x = 604, y = 1276, z = 7},
			{x = 585, y = 1274, z = 7},
			{x = 617, y = 1275, z = 7},
			{x = 624, y = 1284, z = 7},
			{x = 624, y = 1285, z = 7},
			{x = 632, y = 1275, z = 7},
			{x = 596, y = 1292, z = 7},
			{x = 599, y = 1287, z = 7},
			{x = 598, y = 1304, z = 7},
			{x = 615, y = 1311, z = 7},
			{x = 620, y = 1315, z = 7},
			{x = 619, y = 1305, z = 7},
			{x = 626, y = 1297, z = 7},
			{x = 574, y = 1293, z = 7},
			{x = 639, y = 1270, z = 7},
			{x = 695, y = 1198, z = 7},
			{x = 672, y = 1264, z = 7},
			{x = 645, y = 1277, z = 7},
		},
	},
	
	loot = {
		itemId = 2853,
		actionId = 29220,
		waves = {
			delayFromStart = 1 * 60,
			interval = 1 * 60,
			amountPerWave = {10, 20},
		},
		totalItems = {4, 8},
		possibleItems = {
			{itemId = 3272, count = 1, chance = 50000},
			{itemId = 3283, count = 1, chance = 25000},
			{itemId = 7774, count = 1, chance = 12500},
			{words = "exura", chance = 7500},
			{itemId = 3271, count = 1, chance = 5000},
		},
		message = "Loot has been dropped in bags around the map! Next drop in %d minutes.",
	},
	
	startEffect = CONST_ME_HOLY_AREA,
	
	monsterWave = {
		delayFromStart = 1 * 60,
		interval = 1 * 60,
		total = {50, 100},
		monsters = {
			[1] = {"Rotworm"},
			[2] = {"Dragon Hatchling", "Cyclops"},
			[3] = {"Dragon", "Cyclops Drone"},
			[4] = {"Dragon Lord", "Frost Dragon"},
			[5] = {"Demon"},
		},
		message = "A wave of monsters has spawned! Next one in %d minutes.",
	},
	
	eventChannel = 14,
	eventChannelType = TALKTYPE_CHANNEL_R1,
	
	playerDeathMessage = "%s has died! %d competitors remaining!",
	
	eventEndMessage = "[Hunger Games]\nThe event has ended!\nCongratulations to %s, the winner of the hunger games!",
	
	baseStats = {
		vocation = VOCATION_NONE,
		level = 20,
		experience = 98800,
		health = 500,
		mana = 200,
		skills = {
			{skill = SKILL_FIST, tries = 0, value = 20},
			{skill = SKILL_CLUB, tries = 0, value = 20},
			{skill = SKILL_SWORD, tries = 0, value = 20},
			{skill = SKILL_AXE, tries = 0, value = 20},
			{skill = SKILL_DISTANCE, tries = 0, value = 20},
			{skill = SKILL_SHIELD, tries = 0, value = 20},
			{skill = SKILL_FISHING, tries = 0, value = 20},
		},
		magic = {manaspent = 0, value = 5},
		outfit = {
			lookType = 128,
		},
	},
	startingItems = {
		{itemId = 2854, count = 1},
	},
	
	corpseItemId = 22019,
	
	temporalBackpackId = 4011,
	temporalBackpackPosition = Position(944, 1111, 7),
	
	-- From here onwards only temp
	state = hungerGamesStates.NotStarted,
	actualMonsterWave = 1,
	actualLootWave = 1,
	ips = {},
	players = {},
	playerItemsContainer = {},
	events = {},
	spawnedMonsters = {},
}

function hungerGamesEvent:cleanMap()
	for x = hungerGamesEvent.fromPos.x, hungerGamesEvent.toPos.x do
		for y = hungerGamesEvent.fromPos.y, hungerGamesEvent.toPos.y do
			for z = hungerGamesEvent.fromPos.z, hungerGamesEvent.toPos.z do
				local tempTile = Tile(Position(x, y, z))
				if tempTile then
					local items = tempTile:getItems()
					if items then
						for _, item in pairs(items) do
							if ItemType(item:getId()):isPickupable() and ItemType(item:getId()):isMovable() and (item:getActionId() == 0 or item:getId() == hungerGamesEvent.loot.itemId) then
								item:remove()
							end
						end
					end
				end
			end
		end
	end
end

function hungerGamesEvent:resetEvent()
	hungerGamesEvent.state = hungerGamesStates.NotStarted
	hungerGamesEvent.actualMonsterWave = 1
	hungerGamesEvent.actualLootWave = 1
	hungerGamesEvent.ips = {}
	hungerGamesEvent.players = {}
	hungerGamesEvent.playerItemsContainer = {}
	for _, eventId in pairs(hungerGamesEvent.events) do
		stopEvent(eventId)
	end
	hungerGamesEvent.events = {}
	hungerGamesEvent:cleanMap()
	for _, position in pairs(hungerGamesEvent.chests.positions) do
		local tempTile = Tile(position)
		if tempTile then
			for _, id in pairs(hungerGamesEvent.chests.itemId) do
				local tempItem = tempTile:getItemById(id)
				if tempItem then
					for i=1, tempItem:getSize() do
						if tempItem:getItem(0) then
							tempItem:getItem(0):remove()
						end
					end
					break
				end
			end
		end
	end
	for _, mid in pairs(hungerGamesEvent.spawnedMonsters) do
		if Monster(mid) then
			Monster(mid):remove()
		end
	end
	hungerGamesEvent.spawnedMonsters = {}
end

function hungerGamesEvent:generateRandomLoot(container, info)
	local itemsToGenerate = math.random(info.totalItems[1], info.totalItems[2])
	for i = 1, itemsToGenerate do
		local chance = math.random(1, 100000)
		local actualChance = 0
		for _, itemInfo in pairs(info.possibleItems) do
			actualChance = actualChance + itemInfo.chance
			if chance <= actualChance then
				if itemInfo.words then
					local spellScroll = container:addItem(hungerGamesEvent.spellScrollItemId, 1)
					spellScroll:setCustomAttribute(hungerGamesEvent.spellScrollCustomAttribute, itemInfo.words)
					local data
					for _, tempData in pairs(hungerGamesEvent.spells) do
						if tempData.words:lower() == itemInfo.words:lower() then
							data = tempData
							break
						end
					end
					spellScroll:setDescription(string.format(hungerGamesEvent.spellScrollDescription, data.name, data.words))
				else
					container:addItem(itemInfo.itemId, itemInfo.count)
				end
				break
			end
		end
	end
end

function hungerGamesEvent:executeMonsterWave()
	if hungerGamesEvent.state ~= hungerGamesStates.Started then
		return false
	end
	local totalMonsters = 0
	local monstersToSpawn = math.random(hungerGamesEvent.monsterWave.total[1], hungerGamesEvent.monsterWave.total[2])
	local waveToSpawn = math.min(#hungerGamesEvent.monsterWave.monsters, hungerGamesEvent.actualMonsterWave)
	repeat
		local newPos = Position(
			math.random(hungerGamesEvent.fromPos.x, hungerGamesEvent.toPos.x),
			math.random(hungerGamesEvent.fromPos.y, hungerGamesEvent.toPos.y),
			math.random(hungerGamesEvent.fromPos.z, hungerGamesEvent.toPos.z))
		local newMonster = Game.createMonster(hungerGamesEvent.monsterWave.monsters[waveToSpawn][math.random(1, #hungerGamesEvent.monsterWave.monsters[waveToSpawn])], newPos)
		if newMonster then
			table.insert(hungerGamesEvent.spawnedMonsters, newMonster:getId())
			totalMonsters = totalMonsters + 1
		end
	until (totalMonsters >= monstersToSpawn)
	sendChannelMessage(hungerGamesEvent.eventChannel, hungerGamesEvent.eventChannelType, string.format(hungerGamesEvent.monsterWave.message, hungerGamesEvent.monsterWave.interval / 60))
	hungerGamesEvent.actualMonsterWave = hungerGamesEvent.actualMonsterWave + 1
	table.insert(hungerGamesEvent.events, addEvent(function()
		hungerGamesEvent:executeMonsterWave()
	end, hungerGamesEvent.monsterWave.interval * 1000))
end

function hungerGamesEvent:executeLootDrop()
	local totalLoot = 0
	local lootToSpawn = math.random(hungerGamesEvent.loot.waves.amountPerWave[1], hungerGamesEvent.loot.waves.amountPerWave[2])
	repeat
		local newPos = Position(
			math.random(hungerGamesEvent.fromPos.x, hungerGamesEvent.toPos.x),
			math.random(hungerGamesEvent.fromPos.y, hungerGamesEvent.toPos.y),
			math.random(hungerGamesEvent.fromPos.z, hungerGamesEvent.toPos.z))
		local tempTile = Tile(newPos)
		if tempTile and tempTile:hasFlag(TILESTATE_BLOCKSOLID) == false then
			local lootItem = Game.createItem(hungerGamesEvent.loot.itemId, 1, newPos)
			lootItem:setActionId(hungerGamesEvent.loot.actionId)
			hungerGamesEvent:generateRandomLoot(lootItem, hungerGamesEvent.loot)
			totalLoot = totalLoot + 1
		end
	until (totalLoot >= lootToSpawn)
	sendChannelMessage(hungerGamesEvent.eventChannel, hungerGamesEvent.eventChannelType, string.format(hungerGamesEvent.loot.message, hungerGamesEvent.loot.waves.interval / 60))
	hungerGamesEvent.actualLootWave = hungerGamesEvent.actualLootWave + 1
	table.insert(hungerGamesEvent.events, addEvent(function()
		hungerGamesEvent:executeLootDrop()
	end, hungerGamesEvent.loot.waves.interval * 1000))
end


function hungerGamesEvent:prepareEvent()
	if hungerGamesEvent.state ~= hungerGamesStates.NotStarted then
		return false
	end
	hungerGamesEvent.state = hungerGamesStates.Preparing
	broadcastMessage(hungerGamesEvent.preparingMessage)
	local teleport = Game.createItem(hungerGamesEvent.teleport.itemId, 1, hungerGamesEvent.teleport.position)
	teleport:setActionId(hungerGamesEvent.teleport.actionId)
	for _, position in pairs(hungerGamesEvent.chests.positions) do
		local tempTile = Tile(position)
		if tempTile then
			for _, id in pairs(hungerGamesEvent.chests.itemId) do
				local tempItem = tempTile:getItemById(id)
				if tempItem then
					hungerGamesEvent:generateRandomLoot(tempItem, hungerGamesEvent.chests)
					break
				end
			end
		end
	end
	table.insert(hungerGamesEvent.events, addEvent(function()
		hungerGamesEvent:startEvent()
	end, hungerGamesEvent.preparingWaitingTime * 1000))
	return true
end

function hungerGamesEvent:startEvent()
	if hungerGamesEvent.state ~= hungerGamesStates.Preparing then
		return false
	end
	local tpTile = Tile(hungerGamesEvent.teleport.position)
	if tpTile then
		local tp = tpTile:getItemById(hungerGamesEvent.teleport.itemId)
		if tp then	
			tp:remove()
		end
	end
	if table.size(hungerGamesEvent.players) < hungerGamesEvent.minPlayers then
		broadcastMessage(hungerGamesEvent.notEnoughPlayersMessage)
		for pid, stats in pairs(hungerGamesEvent.players) do
			if Player(pid) then
				hungerGamesEvent:leaveEvent(Player(pid))
			end
		end
		hungerGamesEvent:resetEvent()
	else
		hungerGamesEvent.state = hungerGamesStates.Started
		for pid, stats in pairs(hungerGamesEvent.players) do
			Player(pid):getPosition():sendMagicEffect(hungerGamesEvent.startEffect)
			Player(pid):setMoveLocked(false)
		end
		broadcastMessage(hungerGamesEvent.eventStartedMessage)
		table.insert(hungerGamesEvent.events, addEvent(function()
			hungerGamesEvent:executeMonsterWave()
		end, hungerGamesEvent.monsterWave.delayFromStart * 1000))
		table.insert(hungerGamesEvent.events, addEvent(function()
			hungerGamesEvent:executeLootDrop()
		end, hungerGamesEvent.loot.waves.delayFromStart * 1000))
	end
end

function hungerGamesEvent:getStats(player)
	local stats = {}
	stats.vocation = player:getVocation():getId()
	stats.level = player:getLevel()
	stats.experience = player:getExperience()
	stats.health = player:getMaxHealth(true)
	stats.mana = player:getMaxMana(true)
	stats.outfit = player:getOutfit()
	stats.skills = {}
	for skill = SKILL_FIST, SKILL_FISHING do
		stats.skills[skill] = {tries = player:getSkillTries(skill), value = player:getSkillLevel(skill)}
	end
	stats.magic = {manaspent = player:getManaSpent(), value = player:getBaseMagicLevel()}
	return stats
end

function hungerGamesEvent:setStats(player, stats)
	player:setVocation(stats.vocation)
	player:setLevel(stats.level, stats.experience)
	player:setMaxHealth(stats.health)
	player:setMaxMana(stats.mana)
	player:setOutfit(stats.outfit)
	for skill, info in pairs(stats.skills) do
		player:setSkillLevel(skill, info.value, info.tries)
	end
	player:setMagicLevel(stats.magic.value, stats.magic.manaspent)
	return true
end

function hungerGamesEvent:addSpell(player, words)
	local data
	for _, tempData in pairs(hungerGamesEvent.spells) do
		if tempData.words:lower() == words:lower() then
			data = tempData
			break
		end
	end
	if not data then return false end
	
	local tempBit = NewBit(math.max(0, player:getStorageValue(hungerGamesStorages.spells)))
	if tempBit:hasFlag(data.flag) then
		player:sendCancelMessage(hungerGamesEvent.spellAlreadyObtained)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
	tempBit:updateFlag(data.flag)
	player:setStorageValue(hungerGamesStorages.spells, tempBit:getNumber())
	player:say(string.format(hungerGamesEvent.spellScrollDescription, data.name, data.words), TALKTYPE_MONSTER_SAY, false, player)
	player:getPosition():sendMagicEffect(hungerGamesEvent.spellEffect, player)
	return true
end

function hungerGamesEvent:onCastSpell(player, words)
	local data
	for _, tempData in pairs(hungerGamesEvent.spells) do
		if tempData.words:lower() == words:lower() then
			data = tempData
			break
		end
	end
	if not data then 
		player:sendCancelMessage("You can't use this spell on the event.")
		return false
	end
	local spellFlags = NewBit(math.max(0, player:getStorageValue(hungerGamesStorages.spells)))
	if spellFlags:hasFlag(data.flag) then
		return true
	else
		player:sendCancelMessage("You can't use this spell yet, learn it from a spell scroll.")
	end
	return false
end

function hungerGamesEvent:joinEvent(player)
	local ip = player:getIp()
	if table.contains(hungerGamesEvent.ips, ip) then
		player:sendCancelMessage("No MC allowed.")
		return false
	elseif hungerGamesEvent.state ~= hungerGamesStates.Preparing then
		player:sendCancelMessage("The event already started or isn't opened yet.")
		return false
	elseif table.size(hungerGamesEvent.players) >= hungerGamesEvent.maxPlayers then
		player:sendCancelMessage("The event is full.")
		return false
	elseif player:getGroup():getAccess() and player:getAccountType() >= ACCOUNT_TYPE_GOD then
		player:teleportTo(hungerGamesEvent.spawnPos[1])
		return true
	else
		local newPos
		for i=1, #hungerGamesEvent.spawnPos do
			local tempPos = hungerGamesEvent.spawnPos[i]
			local tempTile = Tile(tempPos)
			if not tempTile then return false end
			if not tempTile:getTopCreature() then
				newPos = tempPos
				break
			end
		end
		if not newPos then
			player:sendCancelMessage("There's not a tile available.")
			return false
		end
		
		for _, creature in pairs(player:getSummons()) do
            creature:remove()
        end
		table.insert(hungerGamesEvent.ips, ip)
		hungerGamesEvent:setStats(player, hungerGamesEvent.baseStats)
		Position(hungerGamesEvent.teleport.position):sendMagicEffect(hungerGamesEvent.teleport.effect)
		player:setStorageValue(hungerGamesStorages.playerJoinedEvent, 1)
		player:setStorageValue(hungerGamesStorages.spells, 0)
		local bp = Game.createItem(hungerGamesEvent.temporalBackpackId, 1, hungerGamesEvent.temporalBackpackPosition)
		for slot = CONST_SLOT_HEAD, CONST_SLOT_AMMO do
			local slotItem = player:getSlotItem(slot)
			if slotItem then
				slotItem:moveTo(bp)
			end
		end
		hungerGamesEvent.playerItemsContainer[player:getGuid()] = bp
		hungerGamesEvent.players[player:getGuid()] = hungerGamesEvent:getStats(player)
		player:setMoveLocked(true)
		player:teleportTo(newPos)
		Position(newPos):sendMagicEffect(hungerGamesEvent.teleport.effect)
		player:openChannel(hungerGamesEvent.eventChannel)
		player:removeAllConditions()
		player:registerEvent("hungerGamesDeath")
		for _, item in pairs(hungerGamesEvent.startingItems) do
			player:addItem(item.itemId, item.count)
		end
		return true
	end
end

function hungerGamesEvent:leaveEvent(player, death)
	player:setStorageValue(hungerGamesStorages.playerJoinedEvent, -1)
	local stats = hungerGamesEvent.players[player:getGuid()]
	if stats then
		hungerGamesEvent:setStats(player, stats)
		local items = hungerGamesEvent.playerItemsContainer[player:getGuid()]
		if items then
			local corpse
			if death then
				corpse = Game.createItem(hungerGamesEvent.corpseItemId, 1, player:getPosition())
				corpse:setDescription("You recognize " .. player:getName() .. ".")
			end
			for slot = CONST_SLOT_HEAD, CONST_SLOT_AMMO do
				local slotItem = player:getSlotItem(slot)
				if slotItem then
					if corpse then
						slotItem:moveTo(corpse)
					else
						slotItem:remove()
					end
				end
			end
			if items:getSize() > 0 then
				for i=1, items:getSize() do
					items:getItem(0):moveTo(player)
				end
			end
			items:remove()
			hungerGamesEvent.playerItemsContainer[player:getGuid()] = nil
		end
		hungerGamesEvent.players[player:getGuid()] = nil
		hungerGamesEvent.ips[player:getIp()] = nil
	end
	if not death then
		player:getPosition():sendMagicEffect(hungerGamesEvent.teleport.effect)
	end
	player:teleportTo(player:getTown():getTemplePosition())
	player:getTown():getTemplePosition():sendMagicEffect(hungerGamesEvent.teleport.effect)
	player:setMoveLocked(false)
	player:addHealth(player:getMaxHealth())
	player:addMana(player:getMaxMana())
	player:unregisterEvent("hungerGamesDeath")
	return true
end

function hungerGamesEvent:checkReward(player, remaining)
	local rewards = hungerGamesEvent.rewards[remaining]
	if rewards then	
		for _, reward in pairs(rewards) do
			if reward.itemId then
				player:addItem(reward.itemId, reward.count)
			end
		end
	end
end

function hungerGamesEvent:playerDeath(player)
	local actualPlayers = table.size(hungerGamesEvent.players)
	hungerGamesEvent:leaveEvent(player, true)
	hungerGamesEvent:checkReward(player, actualPlayers)
	if actualPlayers == 2 then
		local remainingPlayer
		for pid, stats in pairs(hungerGamesEvent.players) do
			remainingPlayer = Player(pid)
			break
		end
		hungerGamesEvent:leaveEvent(remainingPlayer)
		hungerGamesEvent:checkReward(remainingPlayer, 1)
		hungerGamesEvent:resetEvent()
		broadcastMessage(string.format(hungerGamesEvent.eventEndMessage, remainingPlayer:getName()))
	else
		sendChannelMessage(hungerGamesEvent.eventChannel, hungerGamesEvent.eventChannelType, string.format(hungerGamesEvent.playerDeathMessage, player:getName(), actualPlayers-1))
	end
	return true
end
			
	
			
		
function hungerGamesEvent:onMoveItem(player, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	-- loot bag
	if item and (item:getId() == hungerGamesEvent.loot.itemId and item:getActionId() == hungerGamesEvent.loot.actionId) then return false end	
	if toCylinder and toCylinder:isItem() and toCylinder:getId() == hungerGamesEvent.loot.itemId and toCylinder:getActionId() == hungerGamesEvent.loot.actionId then
		return false
	end
	-- loot chests
	if item and table.contains(hungerGamesEvent.chests.itemId, item:getId()) then return false end	
	if toCylinder and toCylinder:isItem() and table.contains(hungerGamesEvent.chests.itemId, toCylinder:getId()) then
		return false
	end 
	return true
end
