dungeonStorages = {
	inDungeon = 47770,
}

dungeonConfig = {
	[1] = {
		cooldownStorage = 466678,
		accessStorage = {45550, 3},
		teleportAid = 45550,
		teleportExitAid = 45551,
		exitPos = Position(924, 875, 6),
		cooldown = 2 * 60 * 60,
		monsters = {"Orlyg", "Njal", "Gellir",},
		boss = "Jarl Bork",
		baseChance = 50,
		fullPartyChance = 100,
		totalMonsters = 150,
		maxDungeonTime = 30 * 60,
	},
	[2] = {
		cooldownStorage = 466679,
		accessStorage = {45552, 3},
		--accessParty = {444476, 1},
		teleportAid = 45553,
		teleportExitAid = 45554,
		exitPos = Position(943, 894, 6),
		cooldown = 2 * 60 * 60,
		monsters = {"demonic dust demon", "evil doer", "grim goliath grouper",},
		boss = "The Unwelcome",
		baseChance = 50,
		fullPartyChance = 100,
		totalMonsters = 300,
		maxDungeonTime = 30 * 60,
	},
	[3] = {
		cooldownStorage = 466680,
		accessStorage = {45553, 2},
		--accessParty = {444476, 1},
		teleportAid = 45553,
		teleportExitAid = 45554,
		exitPos = Position(943, 894, 6),
		cooldown = 2 * 60 * 60,
		monsters = {"Rat", "Cave Rat"},
		boss = "The Unwelcome",
		baseChance = 50,
		fullPartyChance = 100,
		totalMonsters = 300,
		maxDungeonTime = 30 * 60,
	},
}

dungeonMaps = {
	[1] = {
		number = 1,
		fromPos = Position(897, 1365, 1),
		toPos = Position(1026, 1436, 7),
		enterPos = Position(1025, 1409, 6),
		
		spawnedMonsters = {},
		playersInside = {},
		playersWhoEntered = {},
		cleanMapEvent = nil,
		boss = nil,
	},
	[2] = {
		number = 1,
		fromPos = Position(900, 1451, 1),
		toPos = Position(1027, 1526, 7),
		enterPos = Position(1025, 1494, 6),
		
		spawnedMonsters = {},
		playersInside = {},
		playersWhoEntered = {},
		cleanMapEvent = nil,
		boss = nil,
	},
	[3] = {
		number = 1,
		fromPos = Position(899, 1536, 1),
		toPos = Position(1023, 1610, 7),
		enterPos = Position(1025, 1580, 6),
		
		spawnedMonsters = {},
		playersInside = {},
		playersWhoEntered = {},
		cleanMapEvent = nil,
		boss = nil,
	},
	[4] = {
		number = 1,
		fromPos = Position(898, 1622, 1),
		toPos = Position(1021, 1696, 7),
		enterPos = Position(1025, 1666, 6),
		
		spawnedMonsters = {},
		playersInside = {},
		playersWhoEntered = {},
		cleanMapEvent = nil,
		boss = nil,
	},
	[5] = {
		number = 2,
		fromPos = Position(700, 940, 13),
		toPos = Position(845, 1020, 13),
		enterPos = Position(722, 947, 13),
		
		spawnedMonsters = {},
		playersInside = {},
		playersWhoEntered = {},
		cleanMapEvent = nil,
		boss = nil,
	},
}



DUNGEON_SYSTEM = {}


DUNGEON_SYSTEM.aid = 45550
DUNGEON_SYSTEM.index = "DUNGEON_SYSTEM_INDEX"

function DUNGEON_SYSTEM:addQuestLog()
	local questIndex = 1
	while true do
		if (not Quests[questIndex]) then
			Quests[questIndex] = {
			name = "Dungeon Access",
			startStorageId = 45549,
			startStorageValue = 1,
			missions = {
				[1] = {
					name = "Dungeon I Access",
					storageId = 45551,
					missionId = 3001,
					startValue = 0,
					endValue = 101,
					description = function(player)
						local value = player:getStorageValue(45550)
						if value == 1 then
							return string.format(
							"You are hunting Black Knights for the access.\nYou currently have killed %d / 100",
							(math.max(player:getStorageValue(45551), 0)))
						elseif value == 2 then
							return "You got a key from the Black Knights, you should return it to get the Access to the First Dungeon."
						else
							return "You completed the access to the Dungeon I."
						end
					end
				},
				[2] = {
					name = "Dungeon II Access",
					storageId = 45552,
					missionId = 3002,
					startValue = 1,
					endValue = 3,
					states = {
						[1] = "You are searching for the wife of the dungeon master. She was last seen at the Nightmares.",
						[2] = "You found the corpse of the dungeon master's wife. You took her necklace as proof.",
						[3] = "You completed the access to the Dungeon II.",
					},
				},
				[3] = {
					name = "Dungeon III Access",
					storageId = 45553,
					missionId = 3003,
					startValue = 1,
					endValue = 2,
					states = {
						[1] = dungeonData[3].questTrackerInfo[1],
						[2] = dungeonData[3].questTrackerInfo[2]
					},
				},
			 }
			}
			break
		end
		questIndex = questIndex + 1
	end
end

function DUNGEON_SYSTEM:prepare()
    
	local t = dungeonData
	for i = 1, #t do
	    local pos = t[i].tpPos
		if pos then
		   local tile = Tile(pos)
		   if tile then
		      local items = tile:getItems()
			  if items and #items > 0 then
			     for _, item in pairs(items) do
				     item:setCustomAttribute(DUNGEON_SYSTEM.index, i)
			         item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, DUNGEON_SYSTEM.aid)
				 end
			  end
		   end
		end
	end
	
end

function DUNGEON_SYSTEM:getIndex(item)
	return item:getCustomAttribute(DUNGEON_SYSTEM.index) or false
end
    
local globalevent = GlobalEvent("load_Dungeons")
function globalevent.onStartup()
	DUNGEON_SYSTEM:prepare()
	DUNGEON_SYSTEM:addQuestLog()
end
globalevent:register()



function DUNGEON_SYSTEM:sendRemainingEnemiesCounter(player, amount, total)
	local msg = NetworkMessage()
	msg:addByte(0x8B) 
	msg:addU32(player:getId())
	msg:addByte(14)
	msg:addByte(total > amount and 1 or 0)
	if total > amount then
		msg:addByte(2)
		msg:addByte(0)
		msg:addU16(total-amount)
	end
	msg:sendToPlayer(player)
	player:sendTextMessage(MESSAGE_GUILD, "A monster has died in the dungeon. You've slain "..amount.."/"..total..".", 9)
end

local function clearRoom(mapData)
	for _, id in pairs(mapData.spawnedMonsters) do
		if Monster(id) then
			Monster(id):remove()
		end
	end
	mapData.spawnedMonsters = {}
	for _, pid in pairs(mapData.playersInside) do
		if Player(pid) then
			Player(pid):teleportTo(dungeonConfig[mapData.number].exitPos)
			Player(pid):sendTextMessage(MESSAGE_GUILD, "You took too long to win the dungeon.", 9)
			Player(pid):unregisterEvent("dungeonKill")
			Player(pid):unregisterEvent("dungeonDeath")
			Player(pid):setStorageValue(dungeonStorages.inDungeon, -1)
		end
	end
	mapData.playersInside = {}
	mapData.playersWhoEntered = {}
	stopEvent(mapData.cleanMapEvent)
	mapData.cleanMapEvent = nil
	if mapData.boss then
		if Monster(mapData.boss) then
			Monster(mapData.boss):remove()
		end
	end
	mapData.boss = nil
end

local dungeonTeleport = MoveEvent()

function dungeonTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		creature:teleportTo(fromPosition, true)
		return false
	end
	
	local index = DUNGEON_SYSTEM:getIndex(item)
	local data = dungeonConfig[index]

	
	if not data or not index then
		creature:teleportTo(fromPosition, true)
		return false
	end
	
	-- if player:getStorageValue(data.cooldownStorage) > os.time() then
		-- player:sendCancelMessage("You still have to wait until you can do this dungeon again.")
		-- creature:teleportTo(fromPosition, true)
		-- --return false
	-- end
	
	if data.accessStorage and player:getStorageValue(data.accessStorage[1]) < data.accessStorage[2] then
		player:sendCancelMessage("You don't have access to this dungeon.")
		creature:teleportTo(fromPosition, true)
		return false
	end
	
	if data.accessItem and player:getItemCount(data.accessItem[1]) < data.accessItem[2] then
		player:sendCancelMessage("You don't have the necessary item to this dungeon.")
		creature:teleportTo(fromPosition, true)
		return false
	end
	
	-- if data.accessParty then
	   -- if player:getStoragValue(data.accessParty[1]) < data.accessParty[2] then
		  -- --canEntry = false
		  -- reasonStr = "You dont' have access to this dungeon."
		  -- player:sendCancelMessage(reasonStr)
		  -- creature:teleportTo(fromPosition, true)
		  -- return false
	   -- end
	-- end
	
	local participants = {}
	
	local actualMap
	local party = player:getParty()
	if party then
	
	    local leader = party:getLeader()
		if leader ~= player then
		   player:sendCancelMessage("Only party leader can enter the dungeon.")
		   creature:teleportTo(fromPosition, true)
		   return false
		end
	
	    local reasonStr = ""
		for _, member in pairs(party:getMembers()) do
			if data.accessStorage then 
			   local reasonStr = ""
			   if member:getStorageValue(data.accessStorage[1]) < data.accessStorage[2] then
			      reasonStr = "One of player do not have access to this dungeon."
				  player:sendCancelMessage(reasonStr)
				  creature:teleportTo(fromPosition, true)
				  return false
			   end
			   if not member:getTile():hasFlag(TILESTATE_PROTECTIONZONE) and member ~= leader then
				  reasonStr = "All party members must be in protection zone."
				  player:sendCancelMessage(reasonStr)			
                  creature:teleportTo(fromPosition, true)
                  return false
               end	
			   if member:getStorageValue(data.cooldownStorage) > os.time() then
		          player:sendCancelMessage("One of player did this dungeon and have to wait.")
		          creature:teleportTo(fromPosition, true)
		          return false
			   end
	        end
			
			if not actualMap then
			   if player ~= member and member:getStorageValue(dungeonStorages.inDungeon) ~= -1 then
				  actualMap = member:getStorageValue(dungeonStorages.inDungeon)
				  --break
			   end
			end
        end	

    		
	if not actualMap then
	   local leader = party:getLeader()			
	   if leader ~= player and leader:getStorageValue(dungeonStorages.inDungeon) ~= -1 then
		  actualMap = leader:getStorageValue(dungeonStorages.inDungeon)
	   end
	end

			
	end

	
	local mapData = actualMap and dungeonMaps[actualMap] or nil
	if not actualMap then
		for ind, map in pairs(dungeonMaps) do
			if map.number == index then
				if #map.playersInside == 0 then
					actualMap = ind
					break
				end
			end
		end
		if not actualMap then
			creature:teleportTo(fromPosition, true)
			player:sendCancelMessage("All dungeon instances are ocuppied right now.")
			return false
		end
		mapData = dungeonMaps[actualMap]
		while (#mapData.spawnedMonsters < data.totalMonsters) do
			local randomPosition = Position(math.random(mapData.fromPos.x, mapData.toPos.x),
				math.random(mapData.fromPos.y, mapData.toPos.y),
				math.random(mapData.fromPos.z, mapData.toPos.z))
			local newMonster = Game.createMonster(data.monsters[math.random(1, #data.monsters)], randomPosition)
			if newMonster then
				table.insert(mapData.spawnedMonsters, newMonster:getId())
			end
		end
		addEvent(clearRoom, dungeonConfig[mapData.number].maxDungeonTime * 1000, mapData)
	else
		if table.contains(mapData.playersWhoEntered, player:getId()) then
			creature:teleportTo(fromPosition, true)
			player:sendCancelMessage("You cannot rejoin a dungeon where you died or you left.")
			return false
		end
		if mapData.number ~= index then
			creature:teleportTo(fromPosition, true)
			player:sendCancelMessage("Your team is already in a dungeon, and it's not this one.")
			return false
		end
	end
	
	if party then
	   for _, member in pairs(party:getMembers()) do
	       	if data.accessItem then
		       member:removeItem(data.accessItem[1], data.accessItem[2])
	        end
	        member:setStorageValue(data.cooldownStorage, os.time() + data.cooldown)
	        member:teleportTo(mapData.enterPos)
	        item:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	        mapData.enterPos:sendMagicEffect(CONST_ME_TELEPORT)
	        member:setStorageValue(dungeonStorages.inDungeon, actualMap)
	        member:openChannel(9)
	        member:registerEvent("dungeonKill")
	        member:registerEvent("dungeonDeath")
	        table.insert(mapData.playersInside, member:getId())
	        table.insert(mapData.playersWhoEntered, member:getId())
		end
		local leader = party:getLeader()
		if data.accessItem then
		   leader:removeItem(data.accessItem[1], data.accessItem[2])
	    end
	    leader:setStorageValue(data.cooldownStorage, os.time() + data.cooldown)
	    leader:teleportTo(mapData.enterPos)
	    item:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	    mapData.enterPos:sendMagicEffect(CONST_ME_TELEPORT)
	    leader:setStorageValue(dungeonStorages.inDungeon, actualMap)
	    leader:openChannel(9)
	    leader:registerEvent("dungeonKill")
	    leader:registerEvent("dungeonDeath")
	    table.insert(mapData.playersInside, leader:getId())
	    table.insert(mapData.playersWhoEntered, leader:getId())
	return true
    end
	
	if data.accessItem then
		player:removeItem(data.accessItem[1], data.accessItem[2])
	end
	player:setStorageValue(data.cooldownStorage, os.time() + data.cooldown)
	player:teleportTo(mapData.enterPos)
	item:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	mapData.enterPos:sendMagicEffect(CONST_ME_TELEPORT)
	player:setStorageValue(dungeonStorages.inDungeon, actualMap)
	player:openChannel(9)
	player:registerEvent("dungeonKill")
	player:registerEvent("dungeonDeath")
	table.insert(mapData.playersInside, player:getId())
	table.insert(mapData.playersWhoEntered, player:getId())
	return true
end

dungeonTeleport:type("stepin")
dungeonTeleport:aid(DUNGEON_SYSTEM.aid)
dungeonTeleport:register()

local dungeonExit = MoveEvent()

function dungeonExit.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		creature:teleportTo(fromPosition, true)
		return false
	end
	local data = dungeonMaps[player:getStorageValue(dungeonStorages.inDungeon)]
	if data then
		if #data.playersInside > 0 then
			for i=1, #data.playersInside do
				if data.playersInside[i] == player:getId() then
					table.remove(data.playersInside, i)
					break
				end
			end
		end
		player:teleportTo(dungeonConfig[data.number].exitPos)
		item:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		dungeonConfig[data.number].exitPos:sendMagicEffect(CONST_ME_TELEPORT)
		player:unregisterEvent("dungeonKill")
		player:unregisterEvent("dungeonDeath")
		player:setStorageValue(dungeonStorages.inDungeon, -1)
		if #data.playersInside == 0 then
			clearRoom(data)
		end
	end
	return true
end

local lastid = 0
dungeonExit:type("stepin")
for id, data in pairs(dungeonConfig) do
    if lastid == 0 or lastid ~= data.teleportExitAid then
	   dungeonExit:aid(data.teleportExitAid)
	   lastid = data.teleportExitAid
	end
end
dungeonExit:register()

local dungeonKill = CreatureEvent("dungeonKill")
function dungeonKill.onKill(player, target, lastHit)
	local data = dungeonMaps[player:getStorageValue(dungeonStorages.inDungeon)]
	if data and #data.spawnedMonsters > 0 then
		local found = false
		for i=1, #data.spawnedMonsters do
			if data.spawnedMonsters[i] == target:getId() then
				table.remove(data.spawnedMonsters, i)
				found = true
			end
		end
		if found then
			for _, pid in pairs(data.playersInside) do
				DUNGEON_SYSTEM:sendRemainingEnemiesCounter(Player(pid), dungeonConfig[data.number].totalMonsters - #data.spawnedMonsters, dungeonConfig[data.number].totalMonsters)
			end
			if #data.spawnedMonsters == 0 then
				if math.random(1, 100) <= (#data.playersInside >= 4 and dungeonConfig[data.number].fullPartyChance or dungeonConfig[data.number].baseChance) then
					while true do
						local randomPosition = Position(math.random(data.fromPos.x, data.toPos.x),
						math.random(data.fromPos.y, data.toPos.y),
						math.random(data.fromPos.z, data.toPos.z))
						local newMonster = Game.createMonster(dungeonConfig[data.number].boss, randomPosition)
						if newMonster then
							data.boss = newMonster:getId()
							break
						end
					end
					for _, pid in pairs(data.playersInside) do
						Player(pid):sendTextMessage(MESSAGE_GUILD, "The boss has spawned somewhere on the dungeon!", 9)
					end
				else
					for _, pid in pairs(data.playersInside) do
						Player(pid):sendTextMessage(MESSAGE_GUILD, "You were not lucky, the boss did not appear this time!", 9)
					end
				end
			end
		end
	end
	return true
end
dungeonKill:register()

local dungeonDeath = CreatureEvent("dungeonDeath")
function dungeonDeath.onDeath(player)
	local data = dungeonMaps[player:getStorageValue(dungeonStorages.inDungeon)]
	if data and #data.playersInside > 0 then
		for i=1, #data.playersInside do
			if data.playersInside[i] == player:getId() then
				table.remove(data.playersInside, i)
				break
			end
		end
		if #data.playersInside == 0 then
			clearRoom(data)
		end
	end
	player:setStorageValue(dungeonStorages.inDungeon, -1)
	return true
end
dungeonDeath:register()

local wifeCorpse = Action()

function wifeCorpse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local data = dungeonData[2]
	if player:getStorageValue(data.accessStorage) ~= 1 then
		return false
	end
	player:setStorageValue(data.accessStorage, 2)
	player:addItem(data.itemDropped[1], data.itemDropped[2])
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, data.corpseMessage)
	return true
end

wifeCorpse:aid(dungeonData[2].accessStorage)
wifeCorpse:register()

local accessKill = CreatureEvent("accessKill")
function accessKill.onKill(player, target)
	if not player:isPlayer() then return true end
	local data = dungeonData[1]
	if player:getStorageValue(data.accessStorage) == 1 then
		if table.contains(data.monsters, target:getName()) then
			local value = player:getStorageValue(data.taskStorage)
			if value == data.requiredKills - 1 then
				player:setStorageValue(data.accessStorage, 2)
				player:setStorageValue(data.taskStorage, data.requiredKills)
				player:addItem(data.itemDropped[1], data.itemDropped[2])
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, data.taskMessage)
			else
				player:setStorageValue(data.taskStorage, math.max(value, 0) + 1)
			end
		end
	end
	return true
end
accessKill:register()

local creatureevent = CreatureEvent("acessRegister")
function creatureevent.onLogin(player)
	local data = dungeonMaps[player:getStorageValue(dungeonStorages.inDungeon)]
	if data and #data.playersInside > 0 then
		for i=1, #data.playersInside do
			if data.playersInside[i] == player:getId() then
				table.remove(data.playersInside, i)
				player:teleportTo(player:getTown():getTemplePosition())
				break
			end
		end
		if #data.playersInside == 0 then
			clearRoom(data)
		end
	end
  player:setStorageValue(dungeonStorages.inDungeon, -1)
  player:registerEvent("dungeonKill")
  player:registerEvent("accessKill")
  return true
end
creatureevent:register()
