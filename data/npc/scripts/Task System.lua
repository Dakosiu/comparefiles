local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end

function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end

function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

function onThink() npcHandler:onThink() end

local voices = {
    {text = 'Hello there, adventurer! Looking for some quests ? I\'m your man!'}
}
npcHandler:addModule(VoiceModule:new(voices))


if not npcPlayers then
   npcPlayers = {}
end   

local function setTaskInformations(player, name, value)
    if not npcPlayers[name] then
       npcPlayers[name] = {}
    end
	
	npcPlayers[name][player:getId()] = value
end

local function getTaskInformations(player, name)
    if not npcPlayers[name] then
	   return false
	end
	return npcPlayers[name][player:getId()]
end
	
local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then 
	   return false 
	end
	
    local player = Player(cid)
	local name = getCreatureName(getNpcCid())
	local npcTable = TASK_SYSTEM.npcList[name]
	
    if msgcontains(msg, 'tasks') or msgcontains(msg, 'mission') or msgcontains(msg, 'help') or msgcontains(msg, 'task') then
	    local missionTable = TASK_SYSTEM:getNpcMission(player, name)
	    if not missionTable then
	       npcHandler:say("Sorry, you have finished all {missions} from me..", cid)
		   return true
	    end		
		

		local id = missionTable["Id"]
		local state = missionTable["State"]
		local taskTable = TASK_SYSTEM.taskListcache[id]
		local rewardTable = taskTable.reward
		local storage = taskTable.Storage
		local taskType = TASK_SYSTEM:getTaskType(taskTable)
		local count = taskTable.Quantity
		local creatureTable = taskTable.creature
		if not creatureTable then
		   creatureTable = taskTable.boss
		end
		local requiredTable = taskTable.itemsToBring
		local lastMessage = taskTable.lastMessage
		
		if isFirstMission(name, id) then
		    if TASK_SYSTEM:getStartedQuest(player, id) == 0 then
		        TASK_SYSTEM:setStartedQuest(player, id, 1)
		        TASK_SYSTEM:setNpcMissionState(player, id, 1)
		        missionTable = TASK_SYSTEM:getNpcMission(player, name)
		        id = missionTable["Id"]
		        state = missionTable["State"]
	     	end
		end
		
		local str = ""
		if taskType == "creature" then
		    if #creatureTable == 1 then 
			    str = "monster: " 
		    else
			    str = "one of these monsters: "
		    end		
        elseif taskType == "boss" then		
 		    if #creatureTable == 1 then 
			    str = "boss: " 
		    else
			    str = "one of these bosses: "
		    end	
        end			
		
		if state == 1 then
		    if taskType == "creature" or taskType == "boss" then
			    npcHandler:say("You have to kill " .. count .. "x " .. str .. TASK_SYSTEM:getMonstersList(creatureTable, true) .. " Do you accept this {mission}?", cid)
		        npcHandler.topic[cid] = 2
				local values = { ["Id"] = id, ["Type"] = taskType, ["Count"] = count }
				setTaskInformations(player, name, values)
				return true
			end
			if taskType == "items" then
			   local requiredItems = dakosLib:getRequiredItems(requiredTable, true)
			   npcHandler:say("You have to bring me these items: " .. requiredItems .. " Do you accept this {mission}?", cid)
			   npcHandler.topic[cid] = 2
			   local values = { ["Id"] = id, ["Type"] = taskType }
			   setTaskInformations(player, name, values)	
               return true
            end			   		   
		elseif state == 2 then
		    if taskType == "creature" or taskType == "boss" then
			   npcHandler:say("You didnt finish hunting, you have left to kill " .. count - TASK_SYSTEM:getKills(player, id) .. "x " .. str .. TASK_SYSTEM:getMonstersList(creatureTable, true), cid)
			   return true
			end
			if taskType == "items" then
			   local requiredItems = dakosLib:getRequiredItems(requiredTable, true)
			   npcHandler:say("You have to bring me " .. requiredItems .. " Do you have {items} that i asked?", cid)
			   npcHandler.topic[cid] = 3
			   local values = { ["Id"] = id, ["Type"] = taskType }
			   setTaskInformations(player, name, values)
			   return true
			end 
		elseif state == 3 then
		    if not lastMessage then
			   lastMessage = "I see you have finished hunting, here is you reward"
			end
			local rewardString =  dakosLib:addReward(player, rewardTable, true, true)
			dakosLib:addReward(player, rewardTable, false, false)
			TASK_SYSTEM:setNpcMissionState(player, id, 4)
			npcHandler:say(lastMessage .. ", here is your reward for helping me: " .. rewardString, cid)
			if TASK_SYSTEM:getNpcMission(player, name) then
			   TASK_SYSTEM:setNpcMissionState(player, id + 1, 1)
			end
		end
	    return true
    end
	
	if npcHandler.topic[cid] == 2 then
	    if msg:lower() == "yes" then
		    local playerTable = getTaskInformations(player, name)
	        local id = playerTable["Id"]
			local taskType = playerTable["Type"]
			local count = playerTable["Count"]
		    local taskTable = TASK_SYSTEM.taskListcache[id]
		    local customMessage = taskTable.TakeTaskMessage
		    if not customMessage then
			   customMessage("Alright, good luck with your {task}.")
			end
			-- if taskType == "creature" or taskType == "boss" then
			   -- --TASK_SYSTEM:setTaskKills(player, id, count)
			-- end
			   
			TASK_SYSTEM:setNpcMissionState(player, id, 2)
			npcHandler:say(customMessage, cid)
			npcHandler.topic[cid] = 0
			setTaskInformations(player, name, nil)
			return true
		end
		if msg:lower() == "no" then
		    npcHandler:say("Then no...", cid)
			npcHandler.topic[cid] = 0
			setTaskInformations(player, name, nil)		   
		    return true
		end
		return true
	end
	
	if npcHandler.topic[cid] == 3 then
	    if msg:lower() == "yes" then
		    local playerTable = getTaskInformations(player, name)
	        local id = playerTable["Id"]
			local taskTable = TASK_SYSTEM.taskListcache[id]
			local requiredTable = taskTable.itemsToBring
			local rewardTable = taskTable.reward
		   	local missingItems = dakosLib:getMissingItems(requiredTable, player)
			if missingItems then
			    npcHandler:say("You still missing: " .. missingItems, cid)
				npcHandler.topic[cid] = 0
			    setTaskInformations(player, name, nil)	
			    return true
	        end
			local rewardString = dakosLib:addReward(player, rewardTable, true, true)
			dakosLib:addReward(player, rewardTable, false, false)
			TASK_SYSTEM:setNpcMissionState(player, id, 4)
			dakosLib:removeItems(requiredTable, player)
			if not lastMessage then
			   lastMessage = "I see you have collected {items} that i requested"
			end
			npcHandler:say(lastMessage .. ", here is your reward for helping me: " .. rewardString, cid)
			setTaskInformations(player, name, nil)
			if TASK_SYSTEM:getNpcMission(player, name) then
			end
			TASK_SYSTEM:setNpcMissionState(player, id + 1, 1)
			npcHandler.topic[cid] = 0
			return true
		end
		if msg:lower() == "no" then
		    npcHandler:say("Then no...", cid)
			npcHandler.topic[cid] = 0
			setTaskInformations(player, name, nil)		   
		    return true
		end		      
	    return true
	end
	return true
end

keywordHandler:addKeyword({'quests'}, StdModule.say, {
    npcHandler = npcHandler,
    text = "I can give you some good rewards in trade of some tasks."
})

npcHandler:setMessage(MESSAGE_GREET,
                      "Hey |PLAYERNAME|, can you help me in some {tasks} ?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye and come again, |PLAYERNAME|.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
