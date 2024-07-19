local npcName = "Mount Seller"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 128,
	lookHead = 17,
	lookBody = 54,
	lookLegs = 114,
	lookFeet = 0,
	lookAddons = 3,
	lookMount = 379
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


local table = {
  ["Azudocus"] = {price = 100, id = 44},
  ["Blazebringer"] = {price = 100, id = 9},
  ["Glooth Glider"] = {price = 100, id = 71},
  ["Prismatic unicorn"] = {price = 100, id = 115},
  ["Midnight Panther"] = {price = 100, id = 5},
  ["Antelope"] = {price = 100, id = 163}
  
}
local talkState = {}


-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	
    local playerId = player:getId()

     local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or player
   
     local t = table[msg]
     if t then
         npcHandler:say("Do you want to pay "..t.price.." zakaria coins for "..msg.." mount?", npc, player)
         talkState[talkUser] = 1
         xmsg = msg
     elseif MsgContains(msg, "yes") and talkState[talkUser] == 1 then
         t = table[xmsg]
         if getPlayerPremiumDays(player) >= 1 then
             if not getPlayerMount(player, t.id) then
                if player:removeItem(32771, t.price) then
                     doPlayerAddMount(player, t.id)
                     npcHandler:say("You lost "..t.price.." zc! for mount!", npc, player)
                 else
                     npcHandler:say("Sorry, you do not have zakaria coins!", npc, player)
                 end
             else
                 npcHandler:say("You already have this mount!", npc, player)
             end
         else
             npcHandler:say("You must be Premium!", npc, player)
         end
         talkState[talkUser] = 0
     else
         npcHandler:say('What? Please told me a correct name of mount!', npc, player)
         talkState[talkUser] = 0
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

npcHandler:setMessage(MESSAGE_GREET, "Welcome |PLAYERNAME|! I selling mounts: {Azudocus}, {Blazebringer}, {Antelope}, {Glooth Glider}, {Midnight Panther}, {Prismatic unicorn}.")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
