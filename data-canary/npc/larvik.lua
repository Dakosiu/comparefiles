local npcName = "Larvik"

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
	lookHead = 95,
	lookBody = 109,
	lookLegs = 114,
	lookFeet = 114,
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

local EASY_TASK_NUMBER = 1
local MEDIUM_TASK_NUMBER = 2
local HARD_TASK_NUMBER = 3

-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	
    local playerId = player:getId()
	
	 
	local getInformation = DROP_INFORMATIONS:getInformations(msg) 
	if getInformation then
	   npcHandler:say(getInformation, npc, player)
       return true
	end
	  

	
    if MsgContains(msg, "world mission") then
	   npcHandler:say("World Missions give global experience bonus that is activated always at wednesday, every mission that players do from me increase this boost. Currently bonus experience at Wednesday will be " .. larvikTask:getMultiplier() * 100 .. "%.", npc, player)
	   return true
	end

	
	if MsgContains(msg, "mission") then 
	   if player:getStorageValue(larvikTask.isDoingTask + HARD_TASK_NUMBER) == 2 then
	      npcHandler:say("You have already finished all {world missions} for today, come back tommorow.", npc, player)
		  return false
	   end
	   npcHandler:say("You can do 3 types of world tasks {easy}, {medium} and {hard}.", npc, player)
    end

	if MsgContains(msg, "report") then 
	   if player:getStorageValue(larvikTask.isDoingTask + HARD_TASK_NUMBER) == 2 then
	      npcHandler:say("You have already finished all {world missions} for today, come back tommorow.", npc, player)
		  return false
	   end
	   npcHandler:say("Which type of task do you wish to {report}?, {easy}, {medium} and {hard}.", npc, player)
	   npcHandler:setTopic(playerId, 10)
    end
	
	if MsgContains(msg, "easy") then 
	   
	   if npcHandler:getTopic(playerId) == 10 then
	        if player:getStorageValue(larvikTask.isDoingTask + EASY_TASK_NUMBER) < 1 then
			    npcHandler:say("You dont have this task.", npc, player)
			    --npcHandler:setTopic(playerId, 0)
				return true
			end
	   end
	   
	   
       if player:getStorageValue(larvikTask.isDoingTask + EASY_TASK_NUMBER) == 1 then
	      local taskNumber = player:getStorageValue(larvikTask.selectedTask + EASY_TASK_NUMBER)
	      local t = LARVIK_TASKS["Easy"][taskNumber]["Required Items"]
		  local itemTable = larvikTask:getItemList(t)
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
		  
		  if #missingItems > 0 then
		     local str = "You are aleady doing {easy} task, you have to collect still: " .. larvikTask:getMissingItemList(missingItems) .. "."
			 -- if npcHandler:getTopic(playerId) == 10 then
			    -- str = "you have to collect still: " .. larvikTask:getMissingItemList(missingItems) .. "."
			 -- end
	         npcHandler:say(str, npc, player)
		     return false
		  end
		  
		  larvikTask:removeItems(player, itemTable["List"])
		  local rewardTable = LARVIK_TASKS["Easy"][taskNumber]["Reward"]
		  local str = larvikTask:addRewards(player, rewardTable, "medium")
		  larvikTask:addRewards(player, rewardTable)
		  npcHandler:say(str, npc, player)
		  player:setStorageValue(larvikTask.isDoingTask + EASY_TASK_NUMBER, 2)
		  player:setStorageValue(larvikTask.selectedTask + EASY_TASK_NUMBER, 0)
		  player:setStorageValue(larvikTask.selectedTaskEasy + taskNumber, 2)
		  return
	   end
	   
	   if player:getStorageValue(larvikTask.isDoingTask + EASY_TASK_NUMBER) == 2 then
	      npcHandler:say("You have already finished {easy} task.", npc, player)
		  return false
	   end
	   
	   local taskNumber = math.random(1, #LARVIK_TASKS["Easy"])
	   player:setStorageValue(larvikTask.selectedTask + EASY_TASK_NUMBER, taskNumber)
	   player:setStorageValue(larvikTask.isDoingTask + EASY_TASK_NUMBER, 1)
	   player:setStorageValue(larvikTask.selectedTaskEasy + taskNumber, 1)
	   player:setStorageValue(larvikTask.start, 1)
	   local t = LARVIK_TASKS["Easy"][taskNumber]["Required Items"]
	   npcHandler:say("You have to collect: " .. larvikTask:getItemList(t)["String"], npc, player)
	   
	   
	   
	end
	
	if MsgContains(msg, "medium") then

	   if npcHandler:getTopic(playerId) == 10 then
	        if player:getStorageValue(larvikTask.isDoingTask + MEDIUM_TASK_NUMBER) < 1 then
			    npcHandler:say("You dont have this task.", npc, player)
			    --npcHandler:setTopic(playerId, 0)
				return true
			end
	   end
	   
	   if player:getStorageValue(larvikTask.isDoingTask + EASY_TASK_NUMBER) ~= 2 then
	      npcHandler:say("You have to finish {easy} task first.", npc, player)
		  return false
	   end
	   
       if player:getStorageValue(larvikTask.isDoingTask + MEDIUM_TASK_NUMBER) == 1 then
	      local taskNumber = player:getStorageValue(larvikTask.selectedTask + MEDIUM_TASK_NUMBER)
	      local t = LARVIK_TASKS["Medium"][taskNumber]["Required Items"]
		  local itemTable = larvikTask:getItemList(t)
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
		  
		  if #missingItems > 0 then
	         npcHandler:say("You are aleady doing {medium} task, you have to collect still: " .. larvikTask:getMissingItemList(missingItems) .. ".", npc, player)
		     return false
		  end
		  
		  larvikTask:removeItems(player, itemTable["List"])
		  local rewardTable = LARVIK_TASKS["Medium"][taskNumber]["Reward"]
		  local str = larvikTask:addRewards(player, rewardTable, "hard")
		  larvikTask:addRewards(player, rewardTable)
		  npcHandler:say(str, npc, player)
		  player:setStorageValue(larvikTask.isDoingTask + MEDIUM_TASK_NUMBER, 2)
		  player:setStorageValue(larvikTask.selectedTask + MEDIUM_TASK_NUMBER, 0)
		  player:setStorageValue(larvikTask.selectedTaskMedium + taskNumber, 2)

		  return
	   end
	   
	   if player:getStorageValue(larvikTask.isDoingTask + MEDIUM_TASK_NUMBER) == 2 then
	      npcHandler:say("You have already finished {medium} task.", npc, player)
		  return false
	   end
	   
	   local taskNumber = math.random(1, #LARVIK_TASKS["Medium"])
	   player:setStorageValue(larvikTask.selectedTask + MEDIUM_TASK_NUMBER, taskNumber)
	   player:setStorageValue(larvikTask.isDoingTask + MEDIUM_TASK_NUMBER, 1)
	   
	   player:setStorageValue(larvikTask.start, 1)
	   player:setStorageValue(larvikTask.selectedTaskMedium + taskNumber, 1)
	   local t = LARVIK_TASKS["Medium"][taskNumber]["Required Items"]
	   npcHandler:say("You have to collect: " .. larvikTask:getItemList(t)["String"], npc, player)
	end
	
	if MsgContains(msg, "hard") then 

	   if npcHandler:getTopic(playerId) == 10 then
	        if player:getStorageValue(larvikTask.isDoingTask + HARD_TASK_NUMBER) < 1 then
			    npcHandler:say("You dont have this task.", npc, player)
			    --npcHandler:setTopic(playerId, 0)
				return true
			end
	   end
	   
	   if player:getStorageValue(larvikTask.isDoingTask + MEDIUM_TASK_NUMBER) ~= 2 then
	      npcHandler:say("You have to finish {medium} task first.", npc, player)
		  return false
	   end
	   
	   
	   
       if player:getStorageValue(larvikTask.isDoingTask + HARD_TASK_NUMBER) == 1 then
	      local taskNumber = player:getStorageValue(larvikTask.selectedTask + HARD_TASK_NUMBER)
	      local t = LARVIK_TASKS["Hard"][taskNumber]["Required Items"]
		  local itemTable = larvikTask:getItemList(t)
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
		  
		  if #missingItems > 0 then
	         npcHandler:say("You are aleady doing {hard} task, you have to collect still: " .. larvikTask:getMissingItemList(missingItems) .. ".", npc, player)
		     return false
		  end
		  
		  larvikTask:removeItems(player, itemTable["List"])
		  local rewardTable = LARVIK_TASKS["Hard"][taskNumber]["Reward"]
		  local str = larvikTask:addRewards(player, rewardTable, "finish")
		  larvikTask:addRewards(player, rewardTable)
		  npcHandler:say(str, npc, player)
		  player:setStorageValue(larvikTask.isDoingTask + HARD_TASK_NUMBER, 2)
		  player:setStorageValue(larvikTask.selectedTask + HARD_TASK_NUMBER, 0)
		  player:setStorageValue(larvikTask.selectedTaskHard + taskNumber, 2)
		  return
	   end
	   
	   if player:getStorageValue(larvikTask.isDoingTask + HARD_TASK_NUMBER) == 2 then
	      npcHandler:say("You have already finished {hard} task.", npc, player)
		  return false
	   end
	   
	   local taskNumber = math.random(1, #LARVIK_TASKS["Hard"])
	   player:setStorageValue(larvikTask.selectedTask + HARD_TASK_NUMBER, taskNumber)
	   player:setStorageValue(larvikTask.isDoingTask + HARD_TASK_NUMBER, 1)
	   player:setStorageValue(larvikTask.start, 1)
	   player:setStorageValue(larvikTask.selectedTaskHard + taskNumber, 1)
	   local t = LARVIK_TASKS["Hard"][taskNumber]["Required Items"]
	   npcHandler:say("You have to collect: " .. larvikTask:getItemList(t)["String"], npc, player)
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

npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|! i have some {mission} for you. dont forget to {report} after finnish... these missions are {world missions} that give bonuses to every player on the server ! you can get more info about {world missions} by typing {world missions}")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
