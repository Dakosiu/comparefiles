--local npcName = "Thel Gilius"
local npcName = "Thel Gilius"
local npcType = Game.createNpcType(npcName)
local npcConfig = {}

--npcConfig.name = npcName
npcConfig.name = 'Thel gilius'
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = 100
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 1282,
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
    --npc:setHiddenHealth(true)
	--print("Npc Name: " .. npc:getName())
	--npc:setHealth(npc:getMaxHealth() / 2)
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


local players = {}

if not DAILY_PLAYERS_RESTART_CACHE then
   DAILY_PLAYERS_RESTART_CACHE = {}
end

-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
    
	--if npcHandler:getTopic(playerId) < 2 then
	
	
	if msg == "report" then
	    local activeTasks = DAILY_TASK_MONSTER_SYSTEM:getFinishableTasks(player)
	    if not activeTasks then
	       npcHandler:say("You dont have any task to report", npc, player)
		   return true
	    end
		npcHandler:say("Here is a list of tasks that you can can report: " .. activeTasks, npc, player)
		npcHandler:setTopic(playerId, 2)
		return true
	end
	
	-- if msg == "active tasks" then
	    -- local activeTasks = DAILY_TASK_MONSTER_SYSTEM:getActiveTasks(player)
		
	 
	if msg == "reset" or msg == "cancel" then
	    local activeTasks = DAILY_TASK_MONSTER_SYSTEM:getActiveTasks(player)
	    if not activeTasks then
	       npcHandler:say("You dont have any active task to reset.", npc, player)
		   return true
	    end
		npcHandler:say("Here is your active tasks list that can be canceled " .. activeTasks, npc, player)
		npcHandler:setTopic(playerId, 700)
	    return true
	end
	
	if npcHandler:getTopic(playerId) == 700 and msg ~= "task" then
	    local index = DAILY_TASK_MONSTER_SYSTEM:getIndexByName(msg)
	    if index then
		   npcHandler:say("You will lose all progress for " .. "{" .. msg .. " Task" .. "}." .. " Are you sure? {yes}, {no}", npc, player)
		   npcHandler:setTopic(playerId, 701)
		   DAILY_PLAYERS_RESTART_CACHE[player:getId()] = index
		   return true
		end
	elseif npcHandler:getTopic(playerId) == 701 then
	    if msg == "no" then
		   npcHandler:say("Then no..", npc, player)
		   npcHandler:setTopic(playerId, 0)
		   return true
		elseif msg == "yes" then
		   local index = DAILY_PLAYERS_RESTART_CACHE[player:getId()]
		   local difficult = DAILY_TASK_MONSTER_SYSTEM:getDificultSelected(player, index)
		   DAILY_TASK_MONSTER_SYSTEM:setTaskProgress(player, index, difficult, TASK_CANCELED)
	       npcHandler:say("Task has been restarted.", npc, player)
	       npcHandler:setTopic(playerId, 0)
		   DAILY_PLAYERS_RESTART_CACHE[player:getId()] = nil
		   return true
		end
		return true
	end
	
	   
    if msg == "task" or msg == "tasks" or msg == "mission" or msg == "help" then
	      local list = DAILY_TASK_MONSTER_SYSTEM:getAvaibleTaskList(player)
		  if not list then
		     npcHandler:say("I Dont have any task for your level, sorry!", npc, player)
			 return true
	      end
	      npcHandler:say(list, npc, player)
	      npcHandler:setTopic(playerId, 2)
	
	elseif npcHandler:getTopic(playerId) == 2 then
	    
	    local t = DAILY_TASK_MONSTER_CONFIG["Tasks"]
	    for i = 1, #t do
		   local name = t[i].name
		   if MsgContains(msg, name) then
		   		players[playerId] = {}
			    players[playerId].name = name
			    players[playerId].index = i
		      local dif = DAILY_TASK_MONSTER_SYSTEM:getDificultSelected(player, i)
			  if dif and DAILY_TASK_MONSTER_SYSTEM:getTaskInfoProgress(player, i, dif) == "report" then
				 local rewardTable = DAILY_TASK_MONSTER_SYSTEM:getRewardTable(player, i)
				 local rewardString = dakosLib:addReward(player, rewardTable, false, true)
				 npcHandler:say("I see you have finished hunting the monsters. " .. rewardString, npc, player)
				 dakosLib:addReward(player, rewardTable, false, false, true)
				 local dificult = DAILY_TASK_MONSTER_SYSTEM:getDificultSelected(player, i)
				 DAILY_TASK_MONSTER_SYSTEM:setTaskProgress(player, i, dificult, TASK_FINISHED)
			     npcHandler:setTopic(playerId, 1)
				 return true
			  end
			  
			  
			  if not DAILY_TASK_MONSTER_SYSTEM:isTaskStarted(player, i) then
			     if DAILY_TASK_MONSTER_SYSTEM:reachedSameTimeLimit(player) then
		            npcHandler:say("Sorry, You can't take more tasks in same time than " .. DAILY_TASK_MONSTER_CONFIG._maxTasksSameTime .. ".", npc, player)
	                return true
			     end
		      end
			  
              if player:getStorageValue(DAILY_TASK_MONSTER_CONFIG.storages.countTask) >= DAILY_TASK_MONSTER_CONFIG._maxTasksForPlayer then	 		  
			     if not DAILY_TASK_MONSTER_SYSTEM:isAnyDificultStarted(player, i) then
				    npcHandler:say("Sorry, You have reached limit for daily tasks. Comeback tommorow", npc, player)
					npcHandler:setTopic(playerId, 1)
					return true
			     end
			  end
		      
			  if DAILY_TASK_MONSTER_SYSTEM:isTaskStarted(player, i) then
			     local dificult = DAILY_TASK_MONSTER_SYSTEM:getDificultSelected(player, i)
			     npcHandler:say("You have already started this type of task, dificult: " .. " {" .. dificult .. "}. monsters to kill left " .. DAILY_TASK_MONSTER_SYSTEM:getKillsProgress(player, i) .. ".", npc, player)
                 npcHandler:setTopic(playerId, 1)
				 return true
			  end
		      
		      npcHandler:say("Okay, select your dificulty {easy}, {medium}, {hard}", npc, player)

			  npcHandler:setTopic(playerId, 3)
	       end
		end	
	elseif npcHandler:getTopic(playerId) == 3 then
	   if MsgContains(msg, "easy") then
	      local index = players[playerId].index
		  local kills = DAILY_TASK_MONSTER_SYSTEM:getRequiredKills(player, index, "easy")
		  local otherDificult = DAILY_TASK_MONSTER_SYSTEM:isOtherDificultStarted(player, index, "easy")
		  -- if DAILY_TASK_MONSTER_SYSTEM:reachedDailyLimit(player, index, "easy") then
		      -- npcHandler:say("You have already done all dificulties in this task.", npc, player)
		      -- npcHandler:setTopic(playerId, 1)
		      -- return true
		  -- end

		  if otherDificult then
		      npcHandler:say("You have already started this type of task, dificult: " .. " {" .. otherDificult .. "}. monsters to kill left " .. DAILY_TASK_MONSTER_SYSTEM:getKillsProgress(player, index) .. ".", npc, player)
		      npcHandler:setTopic(playerId, 1)
		      return true	
          end
		  if DAILY_TASK_MONSTER_SYSTEM:getTaskInfoProgress(player, index, "easy") == "finished" then
		     npcHandler:say("You have already finished this task today.", npc, player)
			 return true
	      end

		  npcHandler:say("You will need to kill " .. kills .. " " .. players[playerId].name .. " type of monsters, Are you sure? {yes}, {no}", npc, player)
		  players[playerId].dificult = "easy"
		  npcHandler:setTopic(playerId, 4)
	   elseif MsgContains(msg, "medium") then
	      local index = players[playerId].index
		  local kills = DAILY_TASK_MONSTER_SYSTEM:getRequiredKills(player, index, "medium")
		  local otherDificult = DAILY_TASK_MONSTER_SYSTEM:isOtherDificultStarted(player, index, "medium")
		  
		  -- if DAILY_TASK_MONSTER_SYSTEM:reachedDailyLimit(player, index, "medium") then
		      -- npcHandler:say("You have already done all difilcuties in this task.", npc, player)
		      -- npcHandler:setTopic(playerId, 1)
		      -- return true
		  -- end
		  
		  if otherDificult then
		      npcHandler:say("You have already started this type of task, dificult: " .. " {" .. otherDificult .. "}. monsters to kill left " .. DAILY_TASK_MONSTER_SYSTEM:getKillsProgress(player, index) .. ".", npc, player)
		      npcHandler:setTopic(playerId, 1)
		      return true	
          end
		  if DAILY_TASK_MONSTER_SYSTEM:getTaskInfoProgress(player, index, "medium") == "finished" then
		     npcHandler:say("You have already finished this task today.", npc, player)
			 return true
	      end
		  npcHandler:say("You will need to kill " .. kills .. " " .. players[playerId].name .. " type of monsters, Are you sure? {yes}, {no}", npc, player)
		  players[playerId].dificult = "medium"
		  npcHandler:setTopic(playerId, 4)	
	   elseif MsgContains(msg, "hard") then
	      local index = players[playerId].index
		  local kills = DAILY_TASK_MONSTER_SYSTEM:getRequiredKills(player, index, "hard")
		  local otherDificult = DAILY_TASK_MONSTER_SYSTEM:isOtherDificultStarted(player, index, "hard")
		  
		  -- if DAILY_TASK_MONSTER_SYSTEM:reachedDailyLimit(player, index, "hard") then
		      -- npcHandler:say("You have already done all difilcuties in this task.", npc, player)
		      -- npcHandler:setTopic(playerId, 1)
		      -- return true
		  -- end
		  
		  if otherDificult then
		      npcHandler:say("You have already started this type of task, dificult: " .. " {" .. otherDificult .. "}. monsters to kill left " .. DAILY_TASK_MONSTER_SYSTEM:getKillsProgress(player, index) .. ".", npc, player)
		      npcHandler:setTopic(playerId, 1)
		      return true	
          end
		  if DAILY_TASK_MONSTER_SYSTEM:getTaskInfoProgress(player, index, "hard") == "finished" then
		     npcHandler:say("You have already finished this task today.", npc, player)
			 return true
	      end
		  npcHandler:say("You will need to kill " .. kills .. " " .. players[playerId].name .. " type of monsters, Are you sure? {yes}, {no}", npc, player)
		  players[playerId].dificult = "hard"
		  npcHandler:setTopic(playerId, 4)		  
	   end
	elseif npcHandler:getTopic(playerId) == 4 then
	    if MsgContains(msg, "yes") then
	       local index = players[playerId].index
		   local dificult = players[playerId].dificult
		   local otherDificult = DAILY_TASK_MONSTER_SYSTEM:isOtherDificultStarted(player, index, dificult)
		   if DAILY_TASK_MONSTER_SYSTEM:getTaskInfoProgress(player, index, dificult) == "progress" then
		      npcHandler:say("You are already started this task.", npc, player)
		      npcHandler:setTopic(playerId, 1)
		      return true
		   elseif DAILY_TASK_MONSTER_SYSTEM:getTaskInfoProgress(player, index, dificult) == "finished" then
		      npcHandler:say("You are already finished this task.", npc, player)
		      npcHandler:setTopic(playerId, 1)
		      return true
			elseif otherDificult then
		      npcHandler:say("You have already started this type of task, dificult: " .. " {" .. otherDificult .. "}. monsters to kill left " .. DAILY_TASK_MONSTER_SYSTEM:getKillsProgress(player, index) .. ".", npc, player)
		      npcHandler:setTopic(playerId, 1)
		      return true	
            end		
            local kills = DAILY_TASK_MONSTER_SYSTEM:getRequiredKills(player, index, dificult)
            local name = players[playerId].name
			npcHandler:say("Okay!, visit me again when you kill " .. kills .. " " .. name .. " type of monsters, Good luck!.", npc, player)
			DAILY_TASK_MONSTER_SYSTEM:setTaskProgress(player, index, dificult, TASK_PROGRESS)
			DAILY_TASK_MONSTER_SYSTEM:setKillsProgress(player, index, kills)
			npcHandler:setTopic(playerId, 1)
		end
	end
	
	local t = DAILY_TASK_MONSTER_CONFIG["Mission Bonuses"]
	if msg == "bonus task" or msg == "bonus mission" then
	   if BONUS_TASK_MONSTER_SYSTEM:getQuestLogMission(player, #t) == BONUS_FINISHED then
	      npcHandler:say("Sorry, I dont have more {bonus tasks} for you.", npc, player)
	      return true
	   end
	end
	   
	--local previousIndex = 0
	for i = 1, #t do 
	    local currentMission = BONUS_TASK_MONSTER_SYSTEM:getCurrentMission(player)	

		if BONUS_TASK_MONSTER_SYSTEM:getQuestLogMission(player, i) == BONUS_READY_TO_FINISH then
		   if msg == "bonus task" or msg == "bonus mission" then
		      local rewardTable = t[i]["Rewards"] 		      
			  local rewardString = dakosLib:addReward(player, rewardTable, false, true)
			  npcHandler:say("I see you have finished hunting the monsters. " .. rewardString, npc, player)
			  dakosLib:addReward(player, rewardTable, false, false, true)
			  BONUS_TASK_MONSTER_SYSTEM:setQuestLogMission(player, i, BONUS_FINISHED)
		      npcHandler:setTopic(playerId, 1)
			  return true
			end
		end
		
		
		
		local requiredTable = t[i]["Required"]
				
	    if currentMission == i then
	       if BONUS_TASK_MONSTER_SYSTEM:getQuestLogMission(player, i) == BONUS_NOT_SELECTED then
		      if msg == "bonus task" or msg == "bonus mission" then
			     if currentMission == 1 then
				    npcHandler:say("Huh? {bonus task}? .. Oh, I have some {bonus missions}. Do you wanna hear about {bonus missions} more? {yes}, {no}", npc, player)
					npcHandler:setTopic(playerId, 9)
				 else
				    npcHandler:say("To unlock next mission you will need " .. dakosLib:getRequiredThings(player, requiredTable, true) .. " Do you accept this mission? {yes}, {no}", npc, player)
					npcHandler:setTopic(playerId, 10)
				 end
			  elseif msg == "yes" then
			     if npcHandler:getTopic(playerId) == 9 then
				    npcHandler:say("To unlock next mission you will need " .. dakosLib:getRequiredThings(player, requiredTable, true) .. " Do you wanna unlock bonus mission? {yes}, {no}", npc, player)
				    npcHandler:setTopic(playerId, 10)
				 elseif npcHandler:getTopic(playerId) == 10 then
				    local requiredList = dakosLib:getMissingThings(player, requiredTable, true)
					if requiredList then
					   npcHandler:say("You still need " .. requiredList .. " To unlock this mission.", npc, player)
					   return true
					end
					
					dakosLib:removeThings(player, requiredTable)
					BONUS_TASK_MONSTER_SYSTEM:setQuestLogMission(player, i, BONUS_PAY)
					
					if i == 1 then
				         npcHandler:say("Okay, your first mission is kill " .. BONUS_TASK_MONSTER_SYSTEM:getRequiredKillsString(player, i, true) .. " Do you accept this mission? {yes}, {no}", npc, player)
					else
					     npcHandler:say("Okay, your next mission is kill " .. BONUS_TASK_MONSTER_SYSTEM:getRequiredKillsString(player, i, true) .. " Do you accept this mission? {yes}, {no}", npc, player)
					end
					npcHandler:setTopic(playerId, 11)
			    end    
			  end
			elseif BONUS_TASK_MONSTER_SYSTEM:getQuestLogMission(player, i) == BONUS_PAY then
			    if msg == "bonus task" or msg == "bonus mission" then
			       if i == 1 then
				      npcHandler:say("Okay, your first mission is kill " .. BONUS_TASK_MONSTER_SYSTEM:getRequiredKillsString(player, i, true) .. " Do you accept this mission? {yes}, {no}", npc, player)
			       else
				      npcHandler:say("Okay, your next mission is kill " .. BONUS_TASK_MONSTER_SYSTEM:getRequiredKillsString(player, i, true) .. " Do you accept this mission? {yes}, {no}", npc, player)
			       end
			       npcHandler:setTopic(playerId, 11)
			    elseif msg == "yes" then
			      if npcHandler:getTopic(playerId) == 11 then
			         npcHandler:say("You have accepted this task, Good luck with hunting.", npc, player)
				     BONUS_TASK_MONSTER_SYSTEM:setRequiredKills(player, i)
				     BONUS_TASK_MONSTER_SYSTEM:setQuestLogMission(player, i, BONUS_SELECTED)
			      end
			    end
			elseif BONUS_TASK_MONSTER_SYSTEM:getQuestLogMission(player, i) == BONUS_SELECTED then
			    if msg == "bonus task" or msg == "bonus mission" then
				   npcHandler:say("You have still " .. BONUS_TASK_MONSTER_SYSTEM:getRequiredKillsString(player, i) .. " left to kill.", npc, player)
				   return true
				end
			end
		end
		--previousIndex = previousIndex + 1
	end
	
    return true
end	
-- Set to local function "creatureSayCallback"
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Bye message
--npcHandler:setMessage(MESSAGE_FAREWELL, "Yeah, good bye and don't come again!")
-- Walkaway message
--npcHandler:setMessage(MESSAGE_WALKAWAY, "You not have education?")

npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|! i have some {tasks} for you, you can also {cancel} task, do not forget to {report} after finishing hunting.")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
