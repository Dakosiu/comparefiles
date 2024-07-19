local internalNpcName = "Lubo"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 150
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 115,
	lookBody = 39,
	lookLegs = 96,
	lookFeet = 118,
	lookAddons = 3
}

npcConfig.flags = {
	floorchange = false
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcConfig.shop = {
	{ itemName = "backpack", clientId = 2854, buy = 25 },
	{ itemName = "golden backpack", clientId = 2871, buy = 25 },
	{ itemName = "blue backpack", clientId = 2869, buy = 25 },
	{ itemName = "brocade backpack", clientId = 8860, buy = 25 },
	{ itemName = "camouflage backpack", clientId = 2872, buy = 25 },
	{ itemName = "demon backpack", clientId = 9601, buy = 25 },
	{ itemName = "golden backpack", clientId = 2871, buy = 25 },
	{ itemName = "green backpack", clientId = 2865, buy = 25 },
	{ itemName = "grey backpack", clientId = 2870, buy = 25 },
	{ itemName = "orange backpack", clientId = 2870, buy = 25 },
	{ itemName = "purple backpack", clientId = 2868, buy = 25 },
	{ itemName = "red backpack", clientId = 2867, buy = 25 },
	{ itemName = "yellow backpack", clientId = 2866, buy = 25 },
	{ itemName = "closed trap", clientId = 3481, buy = 280, sell = 75 },
	{ itemName = "crowbar", clientId = 3304, buy = 260, sell = 50 },
	{ itemName = "machete", clientId = 3308, buy = 35, sell = 6 },
	{ itemName = "pick", clientId = 3456, buy = 50, sell = 15 },
	{ itemName = "present", clientId = 2856, buy = 10 },
	{ itemName = "red apple", clientId = 3585, buy = 3 },
	{ itemName = "rope", clientId = 3003, buy = 50, sell = 15 },
	{ itemName = "scythe", clientId = 3453, buy = 50, sell = 10 },
	{ itemName = "shovel", clientId = 3457, buy = 50, sell = 8 },
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "name") then
		return npcHandler:say("Me Yasir.", npc, creature)
	elseif MsgContains(message, "job") then
		return npcHandler:say("Tje hari ku ne finjala. {Ariki}?", npc, creature)
	elseif MsgContains(message, "passage") then
		return npcHandler:say("Soso yana. <shakes his head>", npc, creature)
	end
	return true
end

npcHandler:setMessage(MESSAGE_FAREWELL, "Si, jema ze harun. <waves>")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
