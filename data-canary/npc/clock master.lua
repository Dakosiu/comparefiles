local npcName = "Clock Master"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 873,
	lookHead = 95,
	lookBody = 109,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 1,
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
	local pos = player:getPosition()
	local itemTable = nil
	local messagesTable = nil
	local money = 0
	local rewardTable = nil
	local t = nil

	   t = CLOCKMASTER_TASKS[1]["Required Items"]
	   itemTable = clockmasterTask:getItemList(t)
	   money = clockmasterTask:countMoney(t)
	   messagesTable = CLOCKMASTER_TASKS[1]["Messages"]
	   rewardTable = CLOCKMASTER_TASKS[1]["Reward"] 
	  	
	if MsgContains(msg, "mission") or MsgContains(msg, "help") or MsgContains(msg, "gear wheel") then

	   if clockmasterTask:getQuestLogMission(player, 5) == 2 then
	      npcHandler:say("I dont need anymore {help}, the clock is working perfectly now.", npc, player)
	      return false
	   end
	
	   if clockmasterTask:getQuestLogMission(player, 1) == 0 then
	      npcHandler:say("Okay then.. you have to talk with {Garik} and bring me " .. itemTable["String"] .. " from him.", npc, player)
		  clockmasterTask:setMission(player, clockmasterTask:getMission(player) + 1)
		  clockmasterTask:setQuestLogMission(player, 1, 1)
	   elseif clockmasterTask:getQuestLogMission(player, 1) >= 1 then  
	   	  npcHandler:say("Did  you get " .. itemTable["String"] .. " ?", npc, player)
		  if clockmasterTask:getQuestLogMission(player, 4) < 2 then
	         npcHandler:say("You have to finish {garik} request first", npc, player)
		     return false
	      end
		  npcHandler:setTopic(playerId, 1)
	   end
	end
	   
	   
		
	if MsgContains(msg, "yes") then
	   if npcHandler:getTopic(playerId) == 1 then
	      local missingItems = {}
		  for index, v in pairs(itemTable["List"]) do
		      local id = v.itemid
			  local count = v.count
			  if player:getItemCount(id) < count then
				 local missingCount = count - player:getItemCount(id)
			     local values = { ["itemid"] = id, ["count"] = missingCount }
				 table.insert(missingItems, values)
			  end
		  end
		      if #missingItems > 0 or player:getMoney() < money then
                 local str = "You still need: "
			     local items = clockmasterTask:getMissingItemList(missingItems)
			   
			     if #missingItems > 0 then
			        str = str .. items 
			     end
			   
			     if player:getMoney() < money then
				    local missingMoney = money - player:getMoney() 
			        if #missingItems > 0 then
			           str = str .. " and " .. missingMoney .. "{ money}"
				    else
				      str = str .. missingMoney .. "{ money}"
				    end
			     end
			     str = str .. " to finish this mission."
			     npcHandler:say(str, npc, player)
			     return false
			  end
			  clockmasterTask:removeItems(player, itemTable["List"])
			  player:removeMoney(money) 
			  npcHandler:say(messagesTable[3], npc, player)
			  --clockmasterTask:addRewards(player, rewardTable)
			  --local str = clockmasterTask:addRewards(player, rewardTable, true)
			  
			  dakosLib:addReward(player, rewardTable, false, false, true)		      
			  local str = dakosLib:addReward(player, rewardTable, false, true)
			  npcHandler:say("Thats it! now the clock is now fully working! take this key to my house as reward" .. str, npc, player)
			  clockmasterTask:setQuestLogMission(player, 5, 2)
			  --clockmasterTask:setMission(player, clockmasterTask:getMission(player) + 1)
	     end
    end
	
	if MsgContains(msg, "garik") then
	   npcHandler:say("{Garik} its my good friend.. u can find him in forge.", npc, player)
	end
	
	if MsgContains(msg, "smaug") then
	   npcHandler:say("{Smaug} hmm smaug? no i dont know him..", npc, player)
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

npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|! the clock been working non-stop until now.. can you {help} me to repair the clock?")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
