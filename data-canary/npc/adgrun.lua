local npcName = "Adgrun"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 1206,
	lookHead = 95,
	lookBody = 109,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 3,
	lookMount = 1209
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

local function getRequiredMoney()
    local reviveTable = SUMMON_SYSTEM_CONFIG.revive["Required"]
	local cost = 0
	
	for i, v in pairs(reviveTable) do
	    if v.type == "money" then
		   cost = cost + v.value
		end
	end
	return cost
end

-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)

	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	local playerId = player:getId()
	
	if MsgContains(msg, "revive") then
	   npcHandler:say("It will cost you " .. getRequiredMoney() .. " money, Are you sure? {yes}, {no}", npc, player)
	   npcHandler:setTopic(playerId, 1)
    end
	
	if MsgContains(msg, "no") and npcHandler:getTopic(playerId) == 1 then
	   npcHandler:say("Then no..", npc, player)
	   npcHandler:setTopic(playerId, 0)
	   return true
	end
	
	if MsgContains(msg, "yes") and npcHandler:getTopic(playerId) == 1 then
	   if player:getMoney() < getRequiredMoney() then
	      npcHandler:say("You dont have enough money.", npc, player)
		  return true
	   end
	   if not SUMMON_SYSTEM:modalWindow(player, 4) then
	      npcHandler:say("You dont have any summon to revive!", npc, player)
		  return true
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

npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|! i am a Summon Master, here you can {revive} your summon.")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
