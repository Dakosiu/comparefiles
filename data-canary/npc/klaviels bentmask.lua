local npcName = "Klaviels Bentmask"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 297,
	lookHead = 962,
	lookBody = 109,
	lookLegs = 114,
	lookFeet = 114,
	--lookAddons = 3,
	--lookMount = 1209
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

-- On creature say callback
if not Klaviels then
   Klaviels = {}
   Klaviels.customers = {}
end

local function creatureSayCallback(npc, player, type, msg)

    
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	local playerId = player:getId()
    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or npc
	
	local mainTable = JEWEL_BOX_EVENT.config["NPC"]
	if MsgContains(msg, "exchange") then
	   npcHandler:say("You can exchange " .. JEWEL_BOX_EVENT:getAvaibleExchanges(), npc, player)
	   return true
	end
	
	local id = dakosLib:getItemIdByName(msg)
	local exchangeTable = mainTable[id]
	if exchangeTable then
	   local count = exchangeTable.required
	   local rewardsTable = exchangeTable.avaibleRewards
	   local RewardsString = dakosLib:addReward(player, rewardsTable, false, true, true, false, true, true, true)
	   local strTable = { 
	                      [1] = "You can exchange " .. count .. "x " .. "{" .. msg .. "}" .. " for one of this randomly reward:",
						  [2] = "You can receive: " .. RewardsString,
						  [3] = "Do you wanna process exchanging? {yes}, {no}"
						}
	   npcHandler:say(strTable, npc, player)
	   Klaviels.customers[playerId] = id 
	   npcHandler:setTopic(playerId, 2)
	   return true
	end
	
	if npcHandler:getTopic(playerId) == 2 then
	   if MsgContains(msg, "no") then
	      npcHandler:setTopic(playerId, 0)
	      Klaviels.customers[playerId] = nil
		  npcHandler:say("Then no...", npc, player)
	  elseif MsgContains(msg, "yes") then
	      local id = Klaviels.customers[playerId]
		  local name = getItemName(id)
		  local exchangeTable = mainTable[id]
		  local count = exchangeTable.required
	      npcHandler:say("Each {exchange} will cost " .. count .. " {" .. name .. "}" .. " How many " .. "{" .. name .. "}" .. " do you wanna to {exchange}?", npc, player)
		  npcHandler:setTopic(playerId, 3)
	  end
	  return true
	end
	
	
	if npcHandler:getTopic(playerId) == 3 then
	   local value = tonumber(msg)
	   local id = Klaviels.customers[playerId]
	   local exchangeTable = mainTable[id]
	   local count = exchangeTable.required
	   local avaibleRewards = exchangeTable.avaibleRewards
	   local name = "{" .. getItemName(id) .. "}"
	   
	   if not value or value < 0 then      
	      npcHandler:say("What?, You have to tell me how many " .. name .. " you wanna exchange..", npc, player)
		  return true
	   end
	   
	   
	   local cost = value * count
	  
	   if player:getItemCount(id) < cost then
	      npcHandler:say("Sorry, you dont have enough " .. name .. ".", npc, player)
		  return true
	   end
	  
	   local rewardsTable = {}
	   
	   for i = 1, value do
	      local t = JEWEL_BOX_EVENT:processReward(player, avaibleRewards)
		  table.insert(rewardsTable, t)
	   end
	   
	   local rewardString = JEWEL_BOX_EVENT:addRewards(player, t, true, true, true, rewardsTable)
	   if not rewardString then
		  npcHandler:say("Sorry, you don't have enough space or capacity to get items.", npc, player)
		  return true
	   end
	  
	   npcHandler:say("You have received: " .. rewardString, npc, player)	  
	   JEWEL_BOX_EVENT:addRewards(player, t, false, false, true, rewardsTable)
	   player:removeItem(id, cost)
	   
	end
	
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|! here you can {exchange} items")
npcHandler:addModule(FocusModule:new())
npcType:register(npcConfig)
