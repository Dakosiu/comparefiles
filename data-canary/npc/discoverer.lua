local npcName = "Discoverer"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 1094,
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


-- On creature say callback

local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	
    local playerId = player:getId()
	local pos = player:getPosition()
	
	
	local t = DISCOVERER_TASKS
	local key = discoverTask.storage
	local maxMissionId = 2
	local missionTable = t["Missions"]
	local currentMission = dakosLib:getQuestCurrentMission(player, key, missionTable, maxMissionId)
	
	
	   if dakosLib:getQuestLogMission(player, key, 3) == 3 then
	      npcHandler:say("You have already finished all missions", npc, player)
		  return true
	   end
	   
	   

	   if dakosLib:getQuestLogMission(player, key, 1) < 2 then
		  local missionid = 1
	      local subtitlesTable = missionTable[missionid]["Subtitles"]
	      local requiredTable = missionTable[missionid]["Required"]
	   
	      if MsgContains(msg, "help") or MsgContains(msg, "mission") or MsgContains(msg, "broom") or MsgContains(msg, "witch") then
	         if dakosLib:getQuestLogMission(player, key, missionid) == 0 then
		        npcHandler:say(subtitlesTable[1], npc, player)
			    dakosLib:setQuestLogMission(player, key, missionid, 1)
		     elseif dakosLib:getQuestLogMission(player, key, missionid) == 1 then
		        npcHandler:say(subtitlesTable[2], npc, player)
			    npcHandler:setTopic(playerId, 1)
			end
			elseif MsgContains(msg, "yes") then
			    if npcHandler:getTopic(playerId) == 1 then
                   local missing = dakosLib:getMissingItems(requiredTable, player)
				   if missing then
				      npcHandler:say("Dont fool me!, you still need " .. missing .. " as proof that u killed that terrible witch.", npc, player)
					  return true
				   end
				   dakosLib:removeItems(requiredTable, player)
				   npcHandler:say(subtitlesTable[3], npc, player)
				   dakosLib:setQuestLogMission(player, key, missionid, 2)
				end
			end
	    elseif dakosLib:getQuestLogMission(player, key, 2) < 3 then
			local missionid = 2
		    local subtitlesTable = missionTable[missionid]["Subtitles"]
	        local requiredTable = missionTable[missionid]["Required"]
			local giveTable = missionTable[missionid]["Give"]
			local rewardTable = missionTable[missionid]["Reward"]
	      if MsgContains(msg, "help") or MsgContains(msg, "mission") then
	         if dakosLib:getQuestLogMission(player, key, missionid) == 0 then
		        npcHandler:say(subtitlesTable[1], npc, player)
			    dakosLib:setQuestLogMission(player, key, missionid, 1)
				dakosLib:addMissionItem(player, giveTable)
		     elseif dakosLib:getQuestLogMission(player, key, missionid) > 0 then
		        npcHandler:say(subtitlesTable[2], npc, player)
			    npcHandler:setTopic(playerId, 1)
			end
			elseif MsgContains(msg, "yes") then
			    if npcHandler:getTopic(playerId) == 1 then
				   if dakosLib:getQuestLogMission(player, key, missionid) == 1 then
				      npcHandler:say("Sorry? you have a mission to do, You have to fil this vial with poison.", npc, player)
					  return true
				   end
                   local missing = dakosLib:getMissingItems(requiredTable, player)
				   if missing then
				      npcHandler:say("you still need " .. missing .. ".", npc, player)
					  return true
				   end
				   npcHandler:say(subtitlesTable[3], npc, player)
				   dakosLib:setQuestLogMission(player, key, missionid, 3)
				   local str = dakosLib:addReward(player, rewardTable, false, true, true)
				   npcHandler:say(str .. " for this mission.", npc, player)
				   dakosLib:addReward(player, rewardTable, false, false, true)
				   
				end
			end	
	    elseif dakosLib:getQuestLogMission(player, key, 3) < 3 then
			local missionid = 3
		    local subtitlesTable = missionTable[missionid]["Subtitles"]
	        local requiredTable = missionTable[missionid]["Required"]
			local giveTable = missionTable[missionid]["Give"]
	      if MsgContains(msg, "help") or MsgContains(msg, "mission") then
	         if dakosLib:getQuestLogMission(player, key, missionid) == 0 then
		        npcHandler:say(subtitlesTable[1], npc, player)
			    dakosLib:setQuestLogMission(player, key, missionid, 1)
				dakosLib:addMissionItem(player, giveTable)
		     elseif dakosLib:getQuestLogMission(player, key, missionid) > 0 then
		        npcHandler:say(subtitlesTable[2], npc, player)
			    npcHandler:setTopic(playerId, 1)
			end
			elseif MsgContains(msg, "yes") then
			    if npcHandler:getTopic(playerId) == 1 then
				   if dakosLib:getQuestLogMission(player, key, missionid) == 1 then
				      npcHandler:say("Sorry? you have a mission to do, You have to pour into the mug this mystery poison in tavern.", npc, player)
					  return true
				   end
				   --dakosLib:removeItems(requiredTable, player)
				   npcHandler:say(subtitlesTable[3], npc, player)
				   dakosLib:setQuestLogMission(player, key, missionid, 3)
				   discoverTask:setAccess(player)
				   npcHandler:say("Ahh you are such bad person.. people like you deserve to be in HELL!!", npc, player)
				   
				end
			end				
		end
		  
		     
			 
		  
	
		
	-- for i, v in pairs(missionTable) do
	    
	    -- local requiredTable = v["Required"]
		-- local subtitlesTable = v["Subtitles"]
	    -- if currentMission == i or i == 3 then
	       -- if MsgContains(msg, "help") or MsgContains(msg, "mission") then
		      -- if dakosLib:getQuestLogMission(player, key, i) < 1 then
			     -- npcHandler:say(subtitlesTable[1], npc, player)
				 -- dakosLib:setQuestLogMission(player, key, i, 1)
				 -- local giveItemsTable = v["Give"]
				 -- if giveItemsTable then
				    -- dakosLib:addMissionItem(player, giveItemsTable)
				 -- end	
			  -- elseif dakosLib:getQuestLogMission(player, key, i) == 1 then
			  
			    -- if i == 3 then
				    -- npcHandler:say(subtitlesTable[2], npc, player)
					-- npcHandler:setTopic(playerId, 1)
					-- return true
			    -- end
			     
			     -- npcHandler:say(subtitlesTable[2], npc, player)
			     -- local isMissing = dakosLib:getMissingItems(requiredTable, player)
				 -- if isMissing then
				    -- if i == 1 then
				       -- npcHandler:say("Dont fool me!, you still need " .. isMissing .. " as proof that u killed that terrible witch.", npc, player)
					-- else
					   -- npcHandler:say("You still need " .. isMissing .. " to finish this mission.", npc, player)
					-- end
		            -- return true
				 -- end
				 -- npcHandler:say(subtitlesTable[3], npc, player)
				 -- dakosLib:setQuestLogMission(player, key, i, 2)
				 -- if i ~= 2 then
                    -- dakosLib:removeItems(requiredTable, player)
			     -- end
			  -- end
			-- elseif MsgContains(msg, "yes") then
			    -- if npcHandler:getTopic(playerId) == 1 then
				   -- if dakosLib:getQuestLogMission(player, key, 3) < 4 then
				      -- if dakosLib:getQuestLogMission(player, key, 3) == 2 then
				         -- npcHandler:say("You have a mission to do.", npc, player)
					     -- return true
				      -- end
				      -- npcHandler:say("Ahh you are such bad person.. people like you deserve to be in HELL!!", npc, player)
				      -- dakosLib:setQuestLogMission(player, key, i, 4)
				      -- npcHandler:setTopic(playerId, 0)
					-- end
				-- end  
				
			-- end
		-- end
	-- end			 
				 
				 
		      
		   
	
	
	
	
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

npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|! im the Discoverer, i have {mission} for you.")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
