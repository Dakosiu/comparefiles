local npcName = "Alladyn"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 146,
	lookHead = 114,
	lookBody = 0,
	lookLegs = 86,
	lookFeet = 115,
	lookAddons = 3,
	lookMount = 689
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
     
	if alladynTask:getQuestLogMission(player, 1) < 2 then
	   t = ALLADYN_TASKS[1]["Required Items"]
	   itemTable = alladynTask:getItemList(t)
	   money = alladynTask:countMoney(t)
	   messagesTable = ALLADYN_TASKS[1]["Messages"]
	   rewardTable = ALLADYN_TASKS[1]["Reward"] 
	else
	   t = ALLADYN_TASKS[2]["Required Items"]
	   itemTable = alladynTask:getItemList(t)
	   money = alladynTask:countMoney(t)
	   messagesTable = ALLADYN_TASKS[2]["Messages"]
       rewardTable = ALLADYN_TASKS[2]["Reward"]    
	end
	  	
	if MsgContains(msg, "mission") or MsgContains(msg, "help") or MsgContains(msg, "report") then
	
	   if alladynTask:getQuestLogMission(player, 2) == 2 then
	      npcHandler:setTopic(playerId, 0)
	      return npcHandler:say("I dont need anymore help.", npc, player)
	   end
	   
	   	   --- mission 1
	   if alladynTask:getQuestLogMission(player, 1) == 0 then
	      if money > 0 then
	         npcHandler:say(messagesTable[1] .. itemTable["String"] .. " and " .. money .. " {money}.", npc, player)
		  else
		     npcHandler:say(messagesTable[1] .. itemTable["String"], npc, player)
		  end
		  alladynTask:setQuestLogMission(player, 1, 1)
		  npcHandler:setTopic(playerId, 1)
	   elseif alladynTask:getQuestLogMission(player, 1) == 1 then
	      if money > 0 then
	         npcHandler:say(messagesTable[2] .. itemTable["String"] .. " and " .. money .. " {money}.", npc, player)
		  else
		     npcHandler:say(messagesTable[2] .. itemTable["String"], npc, player)
		  end
		  npcHandler:setTopic(playerId, 1)
	   --- mission 2
	   elseif alladynTask:getQuestLogMission(player, 1) == 2 then
	          if alladynTask:getQuestLogMission(player, 2) == 0 then
			     if money > 0 then
			        npcHandler:say(messagesTable[1] .. itemTable["String"] .. " and " .. money .. " {money}.", npc, player)
				 else
				    npcHandler:say(messagesTable[1] .. itemTable["String"], npc, player)
				 end
		         alladynTask:setQuestLogMission(player, 2, 1)
		         npcHandler:setTopic(playerId, 1)
			  elseif alladynTask:getQuestLogMission(player, 2) == 1 then
			     if money > 0 then
			        npcHandler:say(messagesTable[2] .. itemTable["String"] .. " and " .. money .. " {money}.", npc, player)
				 else
				    npcHandler:say(messagesTable[2] .. itemTable["String"], npc, player)
				 end
		         npcHandler:setTopic(playerId, 1)
			 end
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
			     local items = alladynTask:getMissingItemList(missingItems)
			   
			     if #missingItems > 0 then
			        str = str .. items 
			     end
			   
			     if player:getMoney() < money then
				    local missingMoney = money - player:getMoney() 
			        if #missingItems > 0 and missingMoney > 0 then
			           str = str .. " and " .. missingMoney .. "{ money}"
					elseif #missingItems > 0 and missingMoney <= 0 then
					   str = str
				    else
				      str = str .. missingMoney .. "{ money}"
				    end
			     end
			     str = str .. " to finish this mission."
			     npcHandler:say(str, npc, player)
			     return false
			  end
			  alladynTask:removeItems(player, itemTable["List"])
			  player:removeMoney(money) 
			  npcHandler:say(messagesTable[3], npc, player)
			  alladynTask:addRewards(player, rewardTable)
			  --if alladynTask:getMission(player) > 2 then
			  if alladynTask:getQuestLogMission(player, 1) == 2 then
			     npcHandler:say("You have received: full oriental outfit.", npc, player)
			     else
				 npcHandler:say("You have received: magic carpet mount.", npc, player)
			  end
			  
			  if alladynTask:getQuestLogMission(player, 1) == 1 then
			     alladynTask:setQuestLogMission(player, 1, 2)
				-- alladynTask:setQuestLogMission(player, 2, 1)
			  elseif alladynTask:getQuestLogMission(player, 2) == 1 then
			     alladynTask:setQuestLogMission(player, 2, 2)
			  end
			  
			  alladynTask:setMission(player, alladynTask:getMission(player) + 1)
	     end
    end
	
	for index, alladynTasks in pairs(ALLADYN_TASKS) do
	    for i, itemTable in pairs(alladynTasks["Required Items"]) do 
		       
			if itemTable.type == "item" then
			   local title = itemTable.title
			   local id = itemTable.id
			   local name = getItemName(id)
			   if title then
			      if MsgContains(msg, name) then
				     npcHandler:say("{" .. name .. "} " .. title, npc, player)
				  end
			   end
			end
	    end
    end
	
	if MsgContains(msg, "reward") then
	   npcHandler:say("If you {help} me you can get {magic carpet} and {oriental full outfit}", npc, player)
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

npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|! how did you found me, anyway if you {help} me to DESTROY green djins i can {reward} you... dont forget to {report} your mission.")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
