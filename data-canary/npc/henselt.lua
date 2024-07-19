local npcName = "Henselt"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 541,
	lookHead = 1115,
	lookBody = 114,
	lookLegs = 39,
	lookFeet = 20,
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
	
		if (MsgContains(msg, "daily") or MsgContains(msg, "boss")) then
		local storage = player:getStorageValue(Storage.DailyBoss.Mission01)

		if (storage < 1) then
			npcHandler:say("Oh! It's look like you need to defeat mini-boss " .. dailyBossConfig.miniBossName .. "! Do you want to try it now?", npc, player)
			npcHandler:setTopic(playerId, 1)
		elseif (storage == 1) then
			npcHandler:say("Oh! It's look like you still need to defeat mini-boss " .. dailyBossConfig.miniBossName .. "! Do you want to try it now?", npc, player)
			npcHandler:setTopic(playerId, 2)
		else
			npcHandler:say("Oh! It's look like you defeated mini-boss " .. dailyBossConfig.miniBossName .. "! Now just wait until 08:00 A.M. or 08:00 P.M. and go into boss teleport.", npc, player)
		end
	elseif (MsgContains(msg, "yes")) then
		if (npcHandler:getTopic(playerId) == 1) then
		    if miniDailyBoss:getPlayer() then
			    npcHandler:say("Someone currently fighting with boss, Timeleft: " .. miniDailyBoss:getTimeString(), npc, player)
			   return false
		    end
			npcHandler:say("Good luck!", npc, player)
			player:setStorageValue(Storage.DailyBoss.Mission01, 1)
			miniDailyBoss:addMonster()
			player:teleportTo(dailyBossConfig.bossFightPos, true)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			miniDailyBoss:addPlayer(player)
			miniDailyBoss:setTime()
			miniDailyBoss:addStatue()
		elseif (npcHandler:getTopic(playerId) == 2) then
			if miniDailyBoss:getPlayer() then
			   npcHandler:say("Someone currently fighting with boss, Timeleft: " .. miniDailyBoss:getTimeString(), npc, player)
			   return false
		    end
			
			npcHandler:say("Good luck!", npc, player)
			miniDailyBoss:addMonster()
			player:teleportTo(dailyBossConfig.bossFightPos, true)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			miniDailyBoss:addPlayer(player)
			miniDailyBoss:setTime()
			miniDailyBoss:addStatue()
		end
	elseif (MsgContains(msg, "no")) then
		npcHandler:say("Sure.", npc, player)
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

npcHandler:setMessage(MESSAGE_GREET, "Hello, do you want to make {daily}")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
