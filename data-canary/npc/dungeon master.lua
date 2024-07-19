local npcName = "Dungeon Master"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000000
npcConfig.walkRadius = 4

npcConfig.outfit = {
	lookType = 1094,
	lookHead = 114,
	lookBody = 77,
	lookLegs = 94,
	lookFeet = 0,
	lookAddons = 3,
	lookMount = 0
}

npcConfig.flags = {
	floorchange = false
}



-- Create keywordHandler and npcHandler
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

-- onThink
npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

-- onAppear
npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

-- onDisappear
npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

-- onMove
npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

-- onSay
npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

-- onPlayerCloseChannel
npcType.onCloseChannel = function(npc, player)
	npcHandler:onCloseChannel(npc, player)
end

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end

-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end

-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

-- Function called by the callback "npcHandler:setCallback(CALLBACK_GREET, greetCallback)" in end of file
local function greetCallback(npc, player)
	npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|, you need more info about {canary}?")
	return true
end

-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	
    local playerId = player:getId()

	if msg:lower() == "dungeons" then
		npcHandler:say("I can give you access to the {Dungeon I}, {Dungeon II} or the {Dungeon III}. Which one you want?", npc, player)
	else
	
	if MsgContains(msg:lower(), 'dungeon iii') then
	   local data = dungeonData[3]
	   if player:getLevel() < data.level then
	      npcHandler:say("I'm sorry you don't have enough level.", npc, player)
		  return true
	   end
	   local accessStorage = player:getStorageValue(data.accessStorage)
	   if accessStorage == #data.questTrackerInfo then
	      npcHandler:say("You already have access to the dungeon, go ahead and use the portal if you want.", npc, player)
		  return true
	   end
	   
	   if accessStorage == 1 then
	      npcHandler:say("Do you have a {map} that i need? {yes}, {no}", npc, player)
		  npcHandler:setTopic(playerId, 1)
		  return true
	   end
	   
	   local accessKey = data.accessStorage
	   player:setStorageValue(accessKey, 1)
	   npcHandler:say(data.startAccessMessage, npc, player)
	   
	   if player:getStorageValue(dungeonQuestStorage) < 1 then
	      player:setStorageValue(dungeonQuestStorage, 1)
	   end

	   return true
	end
	
	if MsgContains(msg:lower(), 'map') then
	   local data = dungeonData[3]
	   local accessStorage = player:getStorageValue(data.accessStorage)
	   if accessStorage == 1 then
	      npcHandler:say("Do you have a {map} that i need? {yes}, {no}", npc, player)
		  npcHandler:setTopic(playerId, 1)
		  return true
	   end
	end
	
	if MsgContains(msg:lower(), 'yes') then
	   if npcHandler:getTopic(playerId) == 1 then
	      local data = dungeonData[3]
		  local requiredItem = data.requiredItem
		  local accessKey = data.accessStorage
		  if player:getItemCount(requiredItem) < 1 then
		     npcHandler:say("You dont have this item.", npc, player)
			 return true
	      end
		  player:setStorageValue(accessKey, 2)
		  player:removeItem(requiredItem, 1)
		  npcHandler:say(data.accessCompletedMessage, npc, player)
		  npcHandler:setTopic(playerId, 0)
	      return true
		end
	end
		  
		  
	
	
		local found = false
		for _, data in pairs(dungeonData) do
			if msg:lower() == data.name:lower() then
				if player:getLevel() < data.level then
					npcHandler:say("I'm sorry you don't have enough level.", npc, player)
				else
					local accessStorage = player:getStorageValue(data.accessStorage)
					if accessStorage == 1 then
						npcHandler:say("You already started the access, return to me when you complete it.", npc, player)
					elseif accessStorage == #data.questTrackerInfo-1 then
						if player:removeItem(data.itemDropped[1], data.itemDropped[2]) then
							npcHandler:say(data.accessCompletedMessage, npc, player)
							player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
							if data.taskStorage then
								player:setStorageValue(data.taskStorage, data.requiredKills+1)
							end
							player:setStorageValue(data.accessStorage, #data.questTrackerInfo)
						else
							npcHandler:say("I'm not sure you have progressed on your mission. Any proof?", npc, player)
						end
					elseif accessStorage == #data.questTrackerInfo then
						npcHandler:say("You already have access to the dungeon, go ahead and use the portal if you want.", npc, player)
					else
						player:setStorageValue(dungeonQuestStorage, 1)
						player:setStorageValue(data.accessStorage, 1)
						if data.taskStorage then
							player:setStorageValue(data.taskStorage, 0)
						end
						npcHandler:say(data.startAccessMessage, npc, player)
					end
				end
				found = true
				break
			end
		end
		if not found then
			npcHandler:say("I'm sorry, I have nothing to say about that.", npc, player)
		end
	end
	
	
    return true
end

-- Set to local function "greetCallback"
--npcHandler:setCallback(CALLBACK_GREET, greetCallback)

-- Set to local function "creatureSayCallback"
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Bye message
--npcHandler:setMessage(MESSAGE_FAREWELL, "Yeah, good bye and don't come again!")
-- Walkaway message
--npcHandler:setMessage(MESSAGE_WALKAWAY, "You not have education?")

npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|, you seek access to the {dungeons}?")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
