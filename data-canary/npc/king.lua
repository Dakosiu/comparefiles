local npcName = "King"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 514,
	lookHead = 39,
	lookBody = 23,
	lookLegs = 61,
	lookFeet = 64,
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




local config = {
                  _GoldenAccount = false,
                  ticketid = 5957,
                  ["Avaible Rewards"] = {
						                  { type = "item", itemid = "3366", count = 1, chance = 0.5 },
						                  { type = "item", itemid = "3288", count = 1, chance = 0.3 },
										  { type = "item", itemid = "3555", count = 1, chance = 0.1 },
										  { type = "item", itemid = "3587", count = 5, chance = 0.7 },
									    } 
			   }
			   
	   			   
-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	
	if config._GoldenAccount then
       if not player:isGoldenAccount() then
		  npcHandler:say("Sorry, you dont have a golden account.", npc, player)
		  return false
	   end
	end
	
	if MsgContains(msg, 'lottery') or MsgContains(msg, 'ticket') or MsgContains(msg, 'lottery ticket') then
	    local t = config["Avaible Rewards"]
	    local list = dakosLib:getRequiredItems(t)
		npcHandler:say("You can exchange lottery ticket and get one of this special gift: " .. list .. " are you sure? {yes}, {no}", npc, player)
		npcHandler:setTopic(playerId, 1)
	end
	
	if npcHandler:getTopic(playerId) == 1 then
	   if MsgContains(msg, 'yes') then
	      if player:getItemCount(config.ticketid) < 1 then
		      npcHandler:say("Sorry, you dont have a {lottery ticket}.", npc, player)
			  npcHandler:setTopic(playerId, 0)
			  return false
		  end
		  local t = config["Avaible Rewards"]
	      local rewardTable = dakosLib:getSingleReward(t)
	      local id = tonumber(rewardTable["itemid"])
	      local count = tonumber(rewardTable["count"])
		  player:addItem(id, count)
		  player:getPosition():sendMagicEffect(CONST_ME_HEARTS)
		  player:removeItem(config.ticketid, 1)
		  npcHandler:say("Alright! you have received " .. count .. "x " .. "{" .. getItemName(id) .. "}" .. " as reward.", npc, player) 
		  npcHandler:setTopic(playerId, 0)
		  return true
	   end
	   if MsgContains(msg, 'no') then
	      npcHandler:say("then no..", npc, player) 
		  npcHandler:setTopic(playerId, 0)
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

npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|, here you can exchange {lottery ticket} to special gifts.")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
