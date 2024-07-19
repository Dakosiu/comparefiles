local npcName = "Soul Hauler"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 200000
npcConfig.walkRadius = 4

npcConfig.outfit = {
	lookType = 1322,
	lookHead = 115,
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

npcConfig.shop = {
	{ itemName = "morshabaal's extract", clientId = 37810, sell = 1250000 },
	{ itemName = "morshabaal's extract", clientId = 37810, buy = 5000000 },
}

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
	
	-- local selected = false
	
	
	-- if haulerTask:getQuestLogMission(player, 3) >= 2 then
	   -- if HAULER_TASKS[4]["Required Items"] then
	      -- t = HAULER_TASKS[4]["Required Items"]
		  -- else
		  -- t = {}
	   -- end
       -- itemTable = haulerTask:getItemList(t)
	   -- money = haulerTask:countMoney(t)
	   -- messagesTable = HAULER_TASKS[4]["Messages"]
       -- rewardTable = HAULER_TASKS[4]["Reward"] 
	   -- selected = true
	   -- if haulerTask:getQuestLogMission(player, 4) == 3 then
          -- itemTable = haulerTask:getItemList(t)
	      -- money = haulerTask:countMoney(t)
	      -- messagesTable = HAULER_TASKS[5]["Messages"]
          -- rewardTable = HAULER_TASKS[5]["Reward"] 	
       -- end		  
    -- elseif haulerTask:getQuestLogMission(player, 1) < 3 and not selected then
	   -- if HAULER_TASKS[1]["Required Items"] then
	      -- t = HAULER_TASKS[1]["Required Items"]
		  -- else
		  -- t = {}
	   -- end
       -- itemTable = haulerTask:getItemList(t)
	   -- money = haulerTask:countMoney(t)
	   -- messagesTable = HAULER_TASKS[1]["Messages"]
       -- rewardTable = HAULER_TASKS[1]["Reward"]    
    -- elseif haulerTask:getQuestLogMission(player, 1) == 3 and haulerTask:getQuestLogMission(player, 2) < 3 and not selected then
	   -- if HAULER_TASKS[2]["Required Items"] then
	      -- t = HAULER_TASKS[2]["Required Items"]
		  -- else
		  -- t = {}
	   -- end
       -- itemTable = haulerTask:getItemList(t)
	   -- money = haulerTask:countMoney(t)
	   -- messagesTable = HAULER_TASKS[2]["Messages"]
       -- rewardTable = HAULER_TASKS[2]["Reward"]  
    -- elseif haulerTask:getQuestLogMission(player, 2) == 3 and not selected then
	   -- if HAULER_TASKS[3]["Required Items"] then
	      -- t = HAULER_TASKS[3]["Required Items"]
		  -- else
		  -- t = {}
	   -- end
       -- itemTable = haulerTask:getItemList(t)
	   -- money = haulerTask:countMoney(t)
	   -- messagesTable = HAULER_TASKS[3]["Messages"]
       -- rewardTable = HAULER_TASKS[3]["Reward"]  
    -- end   
	
	local itemTable = nil
	local money = nil
	local messageTable = nil
	local rewardTable = nil
	local t = nil
	local currentMission = haulerTask:getCurrentMission(player)
    if currentMission then
	    if HAULER_TASKS[currentMission]["Required Items"] then
	       t = HAULER_TASKS[currentMission]["Required Items"]
		     else
		   t = {}
	    end
		
		itemTable = haulerTask:getItemList(t)
	    money = haulerTask:countMoney(t)
	    messagesTable = HAULER_TASKS[currentMission]["Messages"]
        rewardTable = HAULER_TASKS[currentMission]["Reward"] 
	end
	
	if MsgContains(msg, "hell") or MsgContains(msg, "travel") then
	   if haulerTask:getQuestLogMission(player, 3) < 3 then
	       npcHandler:say("You are not allowed to travel into {hell}, you have to finish {mission} first.", npc, player)
		   return false
	   end
	   
	   npcHandler:say("You will get teleported to {hell}, Are you sure?", npc, player)
	   npcHandler:setTopic(playerId, 666)
	   return
	end
	
	if MsgContains(msg, HAULER_TASKS[2]["Required Monster"].name) then
	   if haulerTask:getQuestLogMission(player, 2) == 1 or haulerTask:getQuestLogMission(player, 2) == 2 then
	      return npcHandler:say("Avaible Demons to hunt: " .. haulerTask:getMonstersName() .. ".", npc, player)
	   end
	end
	
	if MsgContains(msg, "help") or MsgContains(msg, "mission") then
	
	   if not currentMission then
	      npcHandler:say("I dont have anymore {mission} for you.", npc, player)
	      return false
	   end
	   
	    if haulerTask:getQuestLogMission(player, 5) == 3 then
		   if haulerTask:getQuestLogMission(player, 6) < 1 then
	          npcHandler:say(messagesTable[1], npc, player)
		      haulerTask:setQuestLogMission(player, 6, 1)
		      haulerTask:setInfernalSoulsQuest(player)
			  local pos = Position(745, 1128, 9)
			  player:teleportTo(pos)
	       elseif haulerTask:getQuestLogMission(player, 6) == 1 or haulerTask:getQuestLogMission(player, 6) == 2 then
	          npcHandler:say(messagesTable[2], npc, player)
		      npcHandler:setTopic(playerId, 1)
		   end
		   return true
		end
	   
	   	if haulerTask:getQuestLogMission(player, 4) == 3 then
		   if haulerTask:getQuestLogMission(player, 5) < 1 then
	          npcHandler:say(messagesTable[1] .. itemTable["String"] .. ".", npc, player)
		      haulerTask:setQuestLogMission(player, 5, 1)
	       elseif haulerTask:getQuestLogMission(player, 5) == 1 or haulerTask:getQuestLogMission(player, 5) == 2 then
		      npcHandler:say(messagesTable[2] .. itemTable["String"] .. " ?", npc, player)
			  npcHandler:setTopic(playerId, 1)
		   end  
		   return true
		end
	   
	   
	   	if haulerTask:getQuestLogMission(player, 3) == 3 then
	      if haulerTask:getQuestLogMission(player, 4) == 0 then
		  	 haulerTask:setKillTask(player, 4)
		     npcHandler:say(messagesTable[1] .. haulerTask:getKillTask(4) .. " Now you are allowed to enter the {demonic dimension portal}! Good luck.", npc, player)
			 haulerTask:setQuestLogMission(player, 4, 1)
			 player:setStorageValue(haulerTask.bossAccess.storage, 1)
			 player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked demonic dimension portal to Morshabaal lair.")
		  elseif haulerTask:getQuestLogMission(player, 4) == 1 or haulerTask:getQuestLogMission(player, 4) == 2 then
		     npcHandler:say(messagesTable[2] .. "{" .. HAULER_TASKS[4]["Required Monster"].name .. "}" .. " ?", npc, player)
			 npcHandler:setTopic(playerId, 1)

		  end
		  return true
	   end
	   
	   
	   
	   if haulerTask:getQuestLogMission(player, 1) < 1 then
	      npcHandler:say(messagesTable[1], npc, player)
		  haulerTask:setQuestLogMission(player, 1, 1)
		  haulerTask:setStatuesQuest(player)
	   elseif haulerTask:getQuestLogMission(player, 1) == 1 or haulerTask:getQuestLogMission(player, 1) == 2 then
	      npcHandler:say(messagesTable[2], npc, player)
		  npcHandler:setTopic(playerId, 1)
	   elseif haulerTask:getQuestLogMission(player, 1) == 3 and haulerTask:getQuestLogMission(player, 2) < 3 then
	      if haulerTask:getQuestLogMission(player, 2) == 0 then
		  	 haulerTask:setKillTask(player, 2)
		     npcHandler:say(messagesTable[1] .. haulerTask:getKillTask(2), npc, player)
			 haulerTask:setQuestLogMission(player, 2, 1)
		  elseif haulerTask:getQuestLogMission(player, 2) == 1 or haulerTask:getQuestLogMission(player, 2) == 2 then
		     npcHandler:say(messagesTable[2] .. "{" .. HAULER_TASKS[2]["Required Monster"].name .. "}" .. " ?", npc, player)
			 npcHandler:setTopic(playerId, 1)
		  end
	   	elseif haulerTask:getQuestLogMission(player, 2) == 3 then
	      if haulerTask:getQuestLogMission(player, 3) == 0 then
		     npcHandler:say(messagesTable[1] .. itemTable["String"] .. ".", npc, player)
			 haulerTask:setQuestLogMission(player, 3, 1)
		  elseif haulerTask:getQuestLogMission(player, 3) == 1 then
		     npcHandler:say(messagesTable[2] .. itemTable["String"] .. " ?", npc, player)
			 npcHandler:setTopic(playerId, 1)
		  end 
	   end
	end
	 
	if MsgContains(msg, "yes") then
	
	   if npcHandler:getTopic(playerId) == 666 then
	      haulerTask:teleport(player)
		  npcHandler:setTopic(playerId, 0)
		  return
	   end
	   	   
	   if npcHandler:getTopic(playerId) == 1 then
	   

			if haulerTask:getQuestLogMission(player, 6) == 1 or haulerTask:getQuestLogMission(player, 6) == 2 then
			   if haulerTask:getInfernalSouls(player) > 0 then
			      npcHandler:say("You have to find still: " .. haulerTask:getInfernalSouls(player) .. " more infernal souls.", npc, player)
				  return false
			   end
			      haulerTask:setQuestLogMission(player, 6, 3)
				  npcHandler:say(messagesTable[3], npc, player)
				  haulerTask:addRewards(player, rewardTable)
				return
			end
			
			if haulerTask:getQuestLogMission(player, 4) == 1 or haulerTask:getQuestLogMission(player, 4) == 2 then
			   if haulerTask:getKills(player) > 0 then
			      npcHandler:say("There are monsters left, you have to kill " .. haulerTask:getKills(player) .. " more " .. "{" .. HAULER_TASKS[4]["Required Monster"].name .. "}" .. ".", npc, player)
				  return false
			   end
			      haulerTask:setQuestLogMission(player, 4, 3)
				  npcHandler:say(messagesTable[3], npc, player)
				  haulerTask:addRewards(player, rewardTable)
				return
			end
			
			if haulerTask:getQuestLogMission(player, 5) == 1 then
			   local missingItems = dakosLib:getMissingItems(t, player)
			   if missingItems then
			      npcHandler:say("You still need: " .. missingItems, npc, player)
				  return false
			   end
			   haulerTask:setQuestLogMission(player, 5, 3)
			   npcHandler:say(messagesTable[3], npc, player)
			   haulerTask:addRewards(player, rewardTable)
			   return true
			end
			
			
			
			
			
			
			   
		  
	   
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
			     local items = haulerTask:getMissingItemList(missingItems)
			   
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
			
			
			if haulerTask:getQuestLogMission(player, 1) == 1 or haulerTask:getQuestLogMission(player, 1) == 2 then
			   if haulerTask:getStatues(player) > 0 then
			      npcHandler:say("You have to find still: " .. haulerTask:getStatues(player) .. " more demonic faces.", npc, player)
				  return false
			   end
			      haulerTask:setQuestLogMission(player, 1, 3)
				  npcHandler:say(messagesTable[3], npc, player)
				  haulerTask:addRewards(player, rewardTable)
				return
			end
			
			
			if haulerTask:getQuestLogMission(player, 2) == 1 or haulerTask:getQuestLogMission(player, 2) == 2 then
			   if haulerTask:getKills(player) > 0 then
			      npcHandler:say("There are monsters left, you have to kill " .. haulerTask:getKills(player) .. " more " .. "{" .. HAULER_TASKS[2]["Required Monster"].name .. "}" .. ".", npc, player)
				  return false
			   end
			      haulerTask:setQuestLogMission(player, 2, 3)
				  npcHandler:say(messagesTable[3], npc, player)
				  haulerTask:addRewards(player, rewardTable)
				return
			end
			
			if haulerTask:getQuestLogMission(player, 3) == 1 then
			      haulerTask:setQuestLogMission(player, 3, 3)
				  npcHandler:say(messagesTable[3], npc, player)
				  haulerTask:addRewards(player, rewardTable)
				  haulerTask:removeItems(player, itemTable)
				  haulerTask:setQuestLogMission(player, 4, 0)
				return
			end
			
			
		end
			
    end
	
	for index, haulerTasks in pairs(HAULER_TASKS) do
	    if haulerTasks["Required Items"] then
	       for i, itemTable in pairs(haulerTasks["Required Items"]) do 
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

npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|! im the Soul Hauler, the owner of {hell}.")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
