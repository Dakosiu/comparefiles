if not TASK_SYSTEM then
   TASK_SYSTEM = {}
end

TASK_SYSTEM.taskList = NPCTasks
TASK_SYSTEM.npcList = NPCMissions
					  
TASK_SYSTEM.storages = {
                         index = 5010100,
						 killed = 5020100,
						 started = 5030100 
					   }

if not TASK_SYSTEM.taskListcache then
   TASK_SYSTEM.taskListcache = TASK_SYSTEM.taskList
end

function isFirstMission(name, index)
	local t = TASK_SYSTEM.npcList[name]
	local from = t.fromTask
	if from == index then
	   return true
	end
	return false
end
	
function TASK_SYSTEM:setStartedQuest(player, index, value)
	return player:setStorageValue(self.storages.started + index, value)
end

function TASK_SYSTEM:getStartedQuest(player, index)
	local value = player:getStorageValue(self.storages.started + index)
	if value < 0 then
	   value = 0
	end
	return value
end
	

function TASK_SYSTEM:addToQuestLog()
    local index = 1
	for npcName, v in pairs(self.npcList) do
	    local from = v.fromTask
		local to = v.toTask
	    local newTable = {
		                   name = npcName .. " Request",
					       startstorageid = self.storages.started + from,
					       startstoragevalue = -1,
					       missions = {}
					     }
		local values = {
			             name = "Visit " .. npcName,
						 storageid = self.storages.started + from,
						 startvalue = -1,
						 endvalue = 1,
						 states = {
						            [-1] = "I should visit " .. npcName .. " perhaps he has some missions for me",
						            [1] = "Task is completed."
								  }								          
					   }
		table.insert(newTable.missions, values)						 
		local MissionIndex = 1
		for i = from, to do
		    local values =  { 
			                  name = "Mission " .. MissionIndex,
							  storageid = self.storages.index + i,
							  startvalue = 1,
							  endvalue = 4,
						    }
			local taskTable = TASK_SYSTEM.taskList[i] 
	        local taskType = TASK_SYSTEM:getTaskType(taskTable)
	        local str = ""
	        local count = taskTable.Quantity
	        local requiredTable = taskTable.itemsToBring
	        local creatureTable = taskTable.creature
            if not creatureTable then
		        creatureTable = taskTable.boss
	        end
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
			
			if taskType == "creature" or taskType == "boss" then
                local states = {
                                 [1] = "I should ask " .. npcName .. " about missions.",
                                 [2] = function(player) 
						                local finalCount = count - TASK_SYSTEM:getKills(player, i)
					                    if finalCount < 0 then
					                      finalCount = 0
					                    end
		                                local str = npcName .. " asked me to hunt " .. count .. "x " .. str .. TASK_SYSTEM:getMonstersList(creatureTable, false)
                                        str = str .. "\n" .. "Monsters Left: " .. finalCount .. "."
					                    return str
					                end,
                                 [3] = "Hunting is finished i should visit " .. npcName .. ".",
                                 [4] = "Task is completed."
							   }
                values.states = states
            elseif taskType == "items" then
                local states = {
                                 [1] = "I should ask " .. npcName .. " about missions.",
                                 [2] = function(player) 
		                                   local str = npcName .. " asked me to bring items: " .. dakosLib:getRequiredItems(requiredTable, false)
					                       return str
					                    end,
                                 [3] = "",
                                 [4] = "Task is completed."
                               }
				values.states = states
            end											
			table.insert(newTable.missions, values)
		    MissionIndex = MissionIndex + 1
		end
		table.insert(Quests, newTable)
	end
end


function TASK_SYSTEM:addMissionStates(index, name)
	local states = {}
	states[1] = "I should ask " .. name .. " about mission."
	local taskTable = TASK_SYSTEM.taskList[index] 
	local taskType = TASK_SYSTEM:getTaskType(taskTable)
	local str = ""
	local count = taskTable.Quantity
	local requiredTable = taskTable.itemsToBring
	local creatureTable = taskTable.creature
    if not creatureTable then
		creatureTable = taskTable.boss
	end
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
		
	if taskType == "creature" or taskType == "boss" then
        states[1] = "I should ask " .. name .. " about missions."
	    states[2] = function(player) 
						local finalCount = count - TASK_SYSTEM:getKills(player, index)
					    if finalCount < 0 then
					       finalCount = 0
					    end
		                local str = name .. " asked me to hunt " .. count .. "x " .. str .. TASK_SYSTEM:getMonstersList(creatureTable, false)
                        str = str .. "\n" .. "Monsters Left: " .. finalCount .. "."
					    return str
					end
		states[3] = "Hunting is finished i should visit " .. name .. "."
		states[4] = "Task is completed."
        return states
    end
	
	if taskType == "items" then
	   states[1] = "I should ask " .. name .. " about missions."
	   states[2] = name .. " asked me to bring items: " .. dakosLib:getRequiredItems(requiredTable)
	   states[3] = ""
	   states[4] = "Task is completed."
	   return states
	end
	return false
end
	   
	   
	
	
	
	
				   		   
function TASK_SYSTEM:setTaskNpcName()
    for i, v in pairs(self.npcList) do
	    local from = v.fromTask
		local to = v.toTask
		for z, b in ipairs(self.taskListcache) do
		    if z >= from and z <= to then
			   self.taskListcache[z].npcName = i
	        end
		end
	end
end

function TASK_SYSTEM:setMonsterIndexes()
	if not self.monsterIndex then
	   self.monsterIndex = {}
	end
		
	for i, v in ipairs(self.taskListcache) do
	    local creatureTable = v.creature
		if creatureTable then
		    for z, b in ipairs(creatureTable) do
		        local name = b:lower()
		        if not self.monsterIndex[name] then
			       self.monsterIndex[name] = {}
			    end
				table.insert(self.monsterIndex[name], i)
		    end
	    end
	    creatureTable = v.boss
		if creatureTable then
		    for z, b in ipairs(creatureTable) do
		        local name = b:lower()
		        if not self.monsterIndex[name] then
			       self.monsterIndex[name] = {}
			    end
				table.insert(self.monsterIndex[name], i)
		    end
	    end		
	end
end

function TASK_SYSTEM:convertRewards()
    for i, v in ipairs(self.taskListcache) do
		local rewardTable = v.reward
		local newTable = {}
		for z, b in pairs(rewardTable) do
		    if z == "statsPoint" then
				local values = { type = "stats points", value = b }
				table.insert(newTable, values)
			elseif z == "experience" then
				local values = { type = "experience", value = b }
				table.insert(newTable, values)
			elseif z == "items" then
			    local index = 0
				local pair = {}
				local lastItem = 0
				local isId = false
			    for c, n in ipairs(b) do
				    if not isId then
					    lastItem = n
					    isId = true
					elseif isId then
						local values = { type = "item", itemid = lastItem, count = n }
						table.insert(newTable, values)
						isId = false
					end
				end 
		    end
			v.reward = newTable
		end
	end
end

function TASK_SYSTEM:convertRequiredItems()
    for i, v in ipairs(self.taskListcache) do
        local requiredTable = v.itemsToBring
		if requiredTable then
		    local newTable = {}
		    local isId = false
			local lastItem = 0
		    for c, n in ipairs(requiredTable) do
				if not isId then
					lastItem = n
					isId = true
				elseif isId then
					local values = { type = "item", itemid = lastItem, count = n }
					table.insert(newTable, values)
					isId = false
				end	
            end
			v.itemsToBring = newTable
        end
    end
end			    
   
function TASK_SYSTEM:getMonsterIndex(name)
	return self.monsterIndex[name]
end

function TASK_SYSTEM:updateTask(player, name)
    
	if not self.monsterIndex then
	   return true
	end
	
	local t = self.monsterIndex[name]
	if not t then
	   return true
	end
	for i, v in ipairs(t) do
	    if TASK_SYSTEM:getNpcMissionState(player, v) == 2 then
		   TASK_SYSTEM:addKills(player, v, 1, name)
		end
	end
	return true
end
	
function TASK_SYSTEM:getKills(player, index)
    local value = player:getStorageValue(self.storages.killed + index)
	if value < 0 then
	   value = 0
	end
	return value
end

function TASK_SYSTEM:addKills(player, index, value, name )
    local count = TASK_SYSTEM:getKills(player, index)
	if not value then
	   value = 1
	end
	
	player:setStorageValue(self.storages.killed + index, count + value)
	count = TASK_SYSTEM:getKills(player, index)
	local maxKills = TASK_SYSTEM:getTaskKills(player, index)
	local npcName = self.taskListcache[index]["npcName"]
	
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "[" .. npcName .. "]" .. ": " .. "You have killed " .. count .. "/" .. maxKills .. " " .. name .. ".")
	if count >= maxKills then
	   player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "[" .. npcName .. "]" .. ": " .. "You have finished hunting " .. name .. " report back to npc.")
	   TASK_SYSTEM:setNpcMissionState(player, index, 3)
	end
	
end

-- function TASK_SYSTEM:setTaskKills(player, index, value)
    -- return player:setStorageValue(self.storages.kills, value)
-- end

function TASK_SYSTEM:getTaskKills(player, index)
    local t = self.taskListcache[index]
	return t.Quantity
end

function TASK_SYSTEM:getMonstersList(t, highLight)
    -- if t.creatureList then
	   -- return t.creatureList
	-- end
	
	local str = ""
	for i, v in ipairs(t) do
	    if highLight then
		   str = str .. "{"
		end
	    str = str .. v
	    if highLight then
		   str = str .. "}"
		end		
	    if i == #t then
		   str = str .. "."
		else
		   str = str .. ", "
		end
	end
	t.creatureList = str
	return t.creatureList
end

function TASK_SYSTEM:getNpcMission(player, name)
	local t = self.npcList[name]
	if not t then
	   return false
	end
	
	local from = t.fromTask
	local to = t.toTask
    
    for index = from, to do	
	    local value = TASK_SYSTEM:getNpcMissionState(player, index)
		if value < 4 then
		   return { ["Id"] = index, ["State"] = value }
		end
		if value == 4 and index == to then
		   return false
		end
	end
	return false
end

function TASK_SYSTEM:setNpcMissionState(player, index, value)
	return player:setStorageValue(self.storages.index + index, value)
end

function TASK_SYSTEM:getNpcMissionState(player, index)
    if not player then
	   return 0
	end
    local value = player:getStorageValue(self.storages.index + index)
    if value <= 0 then
       value = 0
	end
	return value
end

function TASK_SYSTEM:getTaskType(t)
    if t.creature then
	   return "creature"
	elseif t.itemsToBring then
	   return "items"
	elseif t.boss then
	   return "boss"
	end
	return false
end



local globalevent = GlobalEvent("load_TASK_SYSTEM")
function globalevent.onStartup()
	TASK_SYSTEM:setTaskNpcName()
    TASK_SYSTEM:setMonsterIndexes()
    TASK_SYSTEM:convertRewards()
	TASK_SYSTEM:convertRequiredItems()
	TASK_SYSTEM:addToQuestLog()
end
globalevent:register()	

local creaturescript = CreatureEvent("TASK_SYSTEM_onDeath")
function creaturescript.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)	
    
	local player = Player(killer)
	if not player then
	   return true
	end
    local name = creature:getName():lower()
    TASK_SYSTEM:updateTask(killer, name)
	return true
end
creaturescript:register()

-- local talk = TalkAction("/taskreset", "!taskreset")

-- function talk.onSay(player, words, param)
    -- local storage = TASK_SYSTEM.storages.index + 1
	-- print("Storage: " .. player:getStorageValue(storage))
    -- player:say("Elo")
    -- for index = 1, 7 do
       -- TASK_SYSTEM:setNpcMissionState(player, index, 0)
       -- player:setStorageValue(TASK_SYSTEM.storages.killed + index, -1)
	   -- player:setStorageValue(TASK_SYSTEM.storages.started + index, -1)
    -- end
	
-- end

-- talk:separator(" ")
-- talk:register()
	
   
	

   
   
   
