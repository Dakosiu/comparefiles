local npcName = "Azar"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 962,
	lookHead = 962,
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

local function startedTasksList(player)
   
			  
   local list = ""
			  
   for i = 1, #AZAR_TASKS do
       if player:getStorageValue(AZAR_STORAGES.checkTask + i) == 1 then
	      local name = AZAR_TASKS[i].name 
		  if i == #AZAR_TASKS then
	      list = list .. "{" .. name .. " Task" .. "}" .. "."
		  else
		  list = list .. "{" .. name .. " Task" .. "}" .. ", "
		  end
	   end
   end

   return list
   
end

local function finishedTasksList(player)

   if not player then
      return nil
   end
   
   local count = 0
   
   local list = ""
   
    for i = 1, #AZAR_TASKS do
       if player:getStorageValue(AZAR_STORAGES.checkTask + i) >= 2 then
	      count = count + 1
	      local name = AZAR_TASKS[i].name 
		  if i == #AZAR_TASKS then
	      list = list .. "{" .. name .. " Task" .. "}" .. "."
		  else
		  list = list .. "{" .. name .. " Task" .. "}" .. ", "
		  end
	   end
   end
   
   local values = { ["Task Count"] = count, ["List"] = list }
   
   return values
end
	
local function addRewards(cid, player, t, number)


   -- if not t then
      -- return nil
   -- end
   
		     -- local items = {}
			 -- local experience = 0
			 -- local tibiacoins = 0
			 -- local tournamentcoins = 0
			 
			 -- local points = 0
			 
			 -- local str = "You have received: "
			 
			 -- local backpack_obtained = false
			 -- local backpack_method = false
			 
		     -- for _, rewardTable in pairs(t["Rewards"]) do
			    -- if rewardTable.type == "experience" then
				   -- player:addExperience(rewardTable.value, true)
				   -- experience = experience + rewardTable.value
				-- elseif rewardTable.type == "tournament coin" then
				   -- player:setTournamentCoinsBalance(player:getTournamentCoinsBalance() + rewardTable.value)
				   -- tournamentcoins = tournamentcoins + rewardTable.value
				-- elseif rewardTable.type == "tibia coin" then
				   -- player:addTibiaCoins(rewardTable.value)
				   -- tibiacoins = tibiacoins + rewardTable.value
				-- elseif rewardTable.type == "item" then
				   -- local canObtained = false
				   -- local chance = rewardTable.chance
				   
				   -- if chance then
				      -- local rnd = math.random(1, 100)
					  -- if rnd <= chance then
					  -- canObtained = true
					  -- end
				   -- else
					  -- canObtained = true
				   -- end
				   
				   -- local id = rewardTable.item_id
				   -- local count = rewardTable.count
				   -- if canObtained then
				            -- player:addItem(id, count)
				   -- end
				   -- local values = { [id] = { ["Count"] = count } }
				   -- if canObtained then
				      -- table.insert(items, values)
				   -- end
				-- end
			 -- end
			 
			 -- if experience > 0 then
			    -- if #items == 0 and tournamentcoins == 0 and tibiacoins == 0 then
			       -- str = str .. "Experience: " .. experience .. "."
				-- else
				   -- if #items > 0 then
				      -- str = str .. "Experience: " .. experience .. ", Items: "
				   -- elseif tournamentcoins > 0 then
				      -- str = str .. "Experience: " .. experience .. ", Tournament Coins: "
				   -- elseif tibiacoins > 0 then
				      -- str = str .. "Experience: " .. experience .. ", Tibia Coins: "
				   -- end
				-- end
				-- else
				-- if #items > 0 then
				   -- str = str .. "Items: "
				-- elseif tournamentcoins > 0 then
				   -- str = str .. "Tournament Coins: "
				-- elseif tibiacoins > 0 then
				   -- str = str .. "Tibia Coins: "
				-- end
			 -- end
			 
             -- local indexReward = 1			 
			 -- for _, itemTable in pairs(items) do
				 
			     -- for id, v in pairs(itemTable) do
				     -- local count = v["Count"]
					 -- if indexReward == #items then
					    -- if tournamentcoins == 0 and tibiacoins == 0 then
						   -- str = str .. count .. "x " .. getItemName(id) .. "."
						   -- else
						   -- str = str .. count .. "x " .. getItemName(id) .. ", "
						-- end
						-- else
						   -- str = str .. count .. "x " .. getItemName(id) .. ", "
				     -- end
                     -- indexReward = indexReward + 1
				 -- end
			 -- end
			 
			 -- if tournamentcoins > 0 then
			    -- if tibiacoins == 0 then
			       -- str = str .. "Tournament Coins: " .. tournamentcoins .. "."
				   -- else
				   -- str = str .. "Tournament Coins: " .. tournamentcoins .. ", "
				-- end
			-- end
			 
			 -- if tibiacoins > 0 then
			    -- str = str .. "Tibia Coins: " .. tibiacoins .. "."
		     -- end
			 
	-- npcHandler:say(str, cid, player)
	
	-- player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	
	player:setStorageValue(AZAR_STORAGES.checkTask + number, 3)
	azarTask:updateTracker(player, AZAR_STORAGES.checkTask + number, true)
	player:setStorageValue(AZAR_STORAGES.checkTask + number, -1)


	
	local count = player:getStorageValue(AZAR_STORAGES.countTask)
    player:setStorageValue(AZAR_STORAGES.countTask, count-1)
	player:setStorageValue(AZAR_STORAGES.killTask + number, 0)

	if player:getStorageValue(AZAR_STORAGES.countTask) <= 0 then
	   player:setStorageValue(AZAR_STORAGES.start, -1)
	end
			 
end


local function getTableByName(name)
    for i,v in ipairs(AZAR_SHOP.config) do
	    if not v.name then
		    local id = v.id
			if id then
			    v.name = getItemName(id)
			end
		end
	    if string.find(name:lower(), v.name:lower()) then
		    return v
		end
	end
	return false
end


-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)

	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	local playerId = player:getId()
    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or npc
	
	
	if MsgContains(msg, "exchange") or MsgContains(msg, "rewards") then
	    local stringRewards = dakosLib:addReward(player, AZAR_SHOP.config, false, true, true, false, true, true, true)
        local str = {}
		str[1] = "Avaible Items: " .. stringRewards
		str[2] = "You have: " .. player:getAzarPoints() .. " {boss tasks points}."
		npcHandler:say(str, npc, player)
		npcHandler:setTopic(playerId, 55)
		return true
	end
	
	if npcHandler:getTopic(playerId) == 55 then
	    local t = getTableByName(msg)
		if t then
	        npcHandler:say("It will cost " .. t.required_points .. " {boss tasks points}." .. " Are you sure? {yes}, {no}", npc, player)
			AZAR_SHOP.customers[playerId] = t
			npcHandler:setTopic(playerId, 56)
			return true
		end
		return true
	end
    
	if npcHandler:getTopic(playerId) == 56 then
		if MsgContains(msg, "no") then
		    npcHandler:say("Then no..", npc, player)
		    npcHandler:setTopic(playerId, 0)
			AZAR_SHOP.customers[playerId] = nil
			return true
		end
		if MsgContains(msg, "yes") then
		    local t = AZAR_SHOP.customers[playerId]
			local cost = t.required_points
			if player:getAzarPoints() < cost then
                npcHandler:say("Sorry, you dont have enough {boss tasks points}.", npc, player)
				return true
			end
			
			local rewards = {}
			table.insert(rewards, t)
			
			player:removeAzarPoints(cost)
			dakosLib:addReward(player, rewards, false, false, true, false, true, false, true)
			
			
			npcHandler:say("Here you are.", npc, player)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
			AZAR_SHOP.customers[playerId] = nil
			npcHandler:setTopic(playerId, 0)
			return true
		end	
	    return true
	end
	
	
	
	
	local count = player:getStorageValue(AZAR_STORAGES.countTask)
	
	if count == nil or count == -1 then
	count = 0
	player:setStorageValue(AZAR_STORAGES.countTask, 0)
	end

	if npcHandler:getTopic(playerId) == 7 then
	   for i = 1, #AZAR_TASKS do
	       if MsgContains(msg, AZAR_TASKS[i].name) then
		      player:setStorageValue(AZAR_STORAGES.index, i)
			    local selectedTask = player:getStorageValue(AZAR_STORAGES.index)
			  
			  	local checkTask = player:getStorageValue(AZAR_STORAGES.checkTask + selectedTask)
				local t = AZAR_TASKS[selectedTask]
				
				if checkTask == 2 then
				   local rewardTable = t["Rewards"]
				   local rewardString = dakosLib:addReward(player, rewardTable, false, true, false, false, false, true, true)
				   npcHandler:say(rewardString, npc, player)
				   dakosLib:addReward(player, rewardTable, false, false, true, false, false, false, true)
		           addRewards(npc, player, t, selectedTask)
				   npcHandler:setTopic(playerId, 7)
				   return false
				end
			  
			    if checkTask == 1 then
			       local kills = player:getStorageValue(AZAR_STORAGES.killTask + selectedTask)
				   if kills < 0 then
				      kills = 0
			       end
			       npcHandler:say("You are already doing this task, you still need to kill " .. AZAR_TASKS[selectedTask].kills - kills .. " " .. "{" .. AZAR_TASKS[selectedTask].name:lower() .. "}" .. " type of monsters.", npc, player)
				   npcHandler:setTopic(playerId, 7)
				 return false
			    end
			  
			  npcHandler:say("You have to kill " .. AZAR_TASKS[selectedTask].kills .. " " .. "{" .. AZAR_TASKS[selectedTask].name:lower() .. "}" ..  " type of monsters." .. " Are you sure ?", npc, player)
			  npcHandler:setTopic(playerId, 8)
			  break
		   end
	   end
	end
	
	if npcHandler:getTopic(playerId) == 8 then
	   if MsgContains(msg, "no") then
	      npcHandler:say("Then no..", npc, player)
		  npcHandler:setTopic(playerId, 7)
	   elseif MsgContains(msg, "yes") then
	      local selectedTask = player:getStorageValue(AZAR_STORAGES.index)
		  
		  if player:getLevel() < AZAR_TASKS[selectedTask].minLevel then
		     npcHandler:say("You need " .. AZAR_TASKS[selectedTask].minLevel .. " level for this task.", npc, player)
			 npcHandler:setTopic(playerId, 7)
			 return false
	      end
		  
		  if player:getLevel() > AZAR_TASKS[selectedTask].maxLevel then
		     npcHandler:say("You'r level is too high for this task.", npc, player)
			 npcHandler:setTopic(playerId, 7)
			 return false
	      end
		  
	      player:setStorageValue(AZAR_STORAGES.checkTask + selectedTask, 1)
		  
		  local count = player:getStorageValue(AZAR_STORAGES.countTask)
		  if count < 0 then
		     count = 0
		  end
          player:setStorageValue(AZAR_STORAGES.countTask, count+1)
	      player:setStorageValue(AZAR_STORAGES.start, 1)
		  
		  npcHandler:say("You have accepted this task.", npc, player)
		  npcHandler:setTopic(playerId, 7)
       end
   end

    if isInArray({"task", "tasks", "help"}, msg:lower()) then
	    if count < AZAR_TASKS._maxTasksForPlayer then
		   if AZAR_TASKS._reportTaskMode == "window" then
              modalWindow:sendToPlayer(player)
		   else
	   local taskList = ""
	   local count = 0
	   for i = 1, #AZAR_TASKS do
	       local level = player:getLevel()
	       local checkTask = player:getStorageValue(AZAR_STORAGES.checkTask + i)
	
	       --if checkTask < 4 then
		      if level >= AZAR_TASKS[i].minLevel and level <= AZAR_TASKS[i].maxLevel then
			     local taskName = AZAR_TASKS[i].name
				 if i == #AZAR_TASKS then
			        taskList = taskList .. "{" .. taskName .. "}" .. "."
				 else
				    taskList = taskList .. "{" .. taskName .. "}" .. ", "
				 end
				 count = count + 1
	          end
	       --end
	   end
	       if count < 1 then
		      npcHandler:say("There is no avaible tasks for you..", npc, player)
			  npcHandler:setTopic(playerId, 6)
		   else
	          npcHandler:say("Here is list of avaible tasks: " .. taskList, npc, player)
	          npcHandler:setTopic(playerId, 7)
		   end
			  
		   end
		else
		npcHandler:say("You cant do more than " .. AZAR_TASKS._maxTasksForPlayer .. " tasks in same time." .. " Type {active tasks} to check current selected tasks.", npc, player)
		npcHandler:setTopic(playerId, 6)
		return false
    end
	end
	
	
	if npcHandler:getTopic(playerId) == 6 then
	   if MsgContains(msg, 'active task') or MsgContains(msg, 'active tasks') then
	      local message = ""
		  local cnt = 0

	      for i = 1, #AZAR_TASKS do
		      local index = AZAR_TASKS[i][dificultValue] 
			  local checkTask = player:getStorageValue(AZAR_STORAGES.checkTask + i)
			  
			  local kill = player:getStorageValue(AZAR_STORAGES.killTask + i)
			  if kill == nil or kill == -1 then
		      kill = 0
		      end
				 
			  if checkTask == 1 then
			        cnt = cnt + 1
			        if cnt == count then
			        message = message .. " and " .. AZAR_TASKS[i].name .. "[" .. kill .. "/" .. index.kills .. "]" .. "."
					else
					message = message .. AZAR_TASKS[i].name .. "[" .. kill .. "/" .. index.kills .. "] "
				    end
			  end
		  end
	      npcHandler:say("Active Tasks: " .. message, npc, player)
		end
	end
			  
	if MsgContains(msg, 'cancel') or MsgContains(msg, 'reset') then
	   if count > 0 then
	      npcHandler:say("Here is list of tasks that you have started " .. startedTasksList(player) .. " so which task do you wanna cancel?", npc, player)
	      npcHandler:setTopic(playerId, 4)
	   else
		  npcHandler:say("You dont have any task to reset!", npc, player)
		  return false
	   end
	end
	   
	local selectt = false  
	if npcHandler:getTopic(playerId) == 4 then
	   for i = 1, #AZAR_TASKS do
	       if selectt == false then
			  if MsgContains(msg, string.lower(AZAR_TASKS[i].name .. " task")) then
		         local checkTask = player:getStorageValue(AZAR_STORAGES.checkTask + i)
			           if checkTask == 1 then
			              if selectt == false then
			                 index = AZAR_TASKS[i]
			                 npcHandler:say("This will lose all progress with " .. "{" .. AZAR_TASKS[i].name .. " Task." .. "}" .. " Are you sure?", npc, player)
			                 tsk = nil
			                 npcHandler:setTopic(playerId, 5)
			                 tsk = i
			                 selectt = true
			              end
			           end
			  end
	       end
	    end
	end

	if npcHandler:getTopic(playerId) == 5 then
	   if MsgContains(msg, string.lower("yes")) then
		  player:setStorageValue(AZAR_STORAGES.checkTask + tsk, 0)
          player:setStorageValue(AZAR_STORAGES.killTask + tsk, 0)
		  local count = player:getStorageValue(AZAR_STORAGES.countTask)
          player:setStorageValue(AZAR_STORAGES.countTask, count-1)
		  npcHandler:say("{" .. AZAR_TASKS[tsk].name .. "}" .. " Canceled." .. " You have: " .. player:getStorageValue(AZAR_STORAGES.countTask) .. "/" .. AZAR_TASKS._maxTasksForPlayer .. " selected tasks." .. " Now you can select {task}.", npc, player)
	   end
	end
		
	if MsgContains(msg, 'report') then
	   local values = finishedTasksList(player)
	   local taskCount = values["Task Count"]
	   
	   if taskCount < 1 then
	      npcHandler:say("You dont have any task to finish.", npc, player)
		  return false
	   end
	   
	   local list = values["List"]
	   npcHandler:say("Here is list of tasks that you can finish " .. list, npc, player)
	   npcHandler:setTopic(playerId, 3)
	end
	   
    if npcHandler:getTopic(playerId) == 3 then
	for i = 1, #AZAR_TASKS do

	if MsgContains(msg, string.lower(AZAR_TASKS[i].name .. " task")) then 
		local taskNumber = i
        
		
        local index = AZAR_TASKS[taskNumber]
	
	    local kill = player:getStorageValue(AZAR_STORAGES.killTask + taskNumber)
	    local checkTask = player:getStorageValue(AZAR_STORAGES.checkTask + taskNumber)
		
        if checkTask < 1 or checkTask == 3 then
		npcHandler:say("You dont have this task.", npc, player)
		npcHandler:setTopic(playerId, 1)
		end
		
		
	    if kill < index.kills then
		   if kill == nil or kill == -1 then
		   kill = 0
		   end
		   npcHandler:say("You still need to kill " .. index.kills - kill .. " " .. "{" .. index.name:lower() .. "}" .. " type of monsters.", npc, player)
		   npcHandler:setTopic(playerId, 1)
		   return false
	    end
		 local rewardTable = index["Rewards"]
		 local rewardString = dakosLib:addReward(player, rewardTable, false, true, false, false, false, true, true)
		 npcHandler:say(rewardString, npc, player)
		 dakosLib:addReward(player, rewardTable, false, false, true, false, false, false, true)
				   
		addRewards(npc, player, index, taskNumber)
		npcHandler:setTopic(playerId, 1)
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

npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|! i have some {tasks} for you, dont forget to {report} after!, I {exchange} task boss points for wonderful {rewards}")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
