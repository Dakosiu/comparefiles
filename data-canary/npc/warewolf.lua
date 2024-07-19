local npcName = "Warewolf"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 20000
npcConfig.walkRadius = 5

npcConfig.outfit = {
	lookType = 730,
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
	local itemTable = nil
	local messagesTable = nil
	local money = 0
	local rewardTable = nil
	local t = nil
	
	local missionId = WarewolfTask:getCurrentMission(player)
	if missionId then
	   t = WAREWOLF_TASKS[missionId]
	   requiredTable = t["Required Items"]
       itemTable = WarewolfTask:getItemList(requiredTable)
	   money = WarewolfTask:countMoney(requiredTable)
	   messagesTable = t["Messages"]
       rewardTable = t["Reward"]   	
	   
	end
	
	  	
	if MsgContains(msg, "help") or MsgContains(msg, "mission") then
	
	   -- if WarewolfTask:getQuestLogMission(player, 2) == 2 then
	    if not missionId then
	        npcHandler:say("I dont need anymore {help}.", npc, player)
		    return false
	    end
	   
	    if WarewolfTask:getQuestLogMission(player, missionId) < 1 then  
		    npcHandler:say(messagesTable[1] .. WarewolfTask:getKillTask(missionId, true) .. ".", npc, player)
			WarewolfTask:setQuestLogMission(player, missionId, 1)
			WarewolfTask:setKillTask(player, missionId)
			return true
		end
		
		if WarewolfTask:getQuestLogMission(player, missionId) == 1 then  
            npcHandler:say("Sorry, you haven't finished hunting yet, you have to kill " .. WarewolfTask:getKills(player) .. " " .. WarewolfTask:getMonsterNameByIndex(missionId) .. "  still.", npc, player)
		    return true
		end
		
		if WarewolfTask:getQuestLogMission(player, missionId) == 2 then 
            WarewolfTask:setQuestLogMission(player, missionId, 3)	
            local messages = {
                                [1] = "Congratulations, you have finished this mission."
                             }								
            if not rewardTable then
			    npcHandler:say(messages, npc, player)
				return true
			end
			
			local rewardString = dakosLib:addReward(player, rewardTable, false, true, true, false, false, true, true)
			dakosLib:addReward(player, rewardTable, false, false, true, false, true, false, false)
			messages[2] = rewardString
			npcHandler:say(messages, npc, player)
		    return true
		end
		
		
		return true
	end
	   
	   
	   
	   -- if WarewolfTask:getQuestLogMission(player, 1) < 1 then
	      -- npcHandler:say(messagesTable[1] .. WarewolfTask:getKillTask(), npc, player)
	      -- WarewolfTask:setQuestLogMission(player, 1, 1)
		  -- WarewolfTask:setKillTask(player)
	   -- elseif WarewolfTask:getQuestLogMission(player, 1) == 1 or WarewolfTask:getQuestLogMission(player, 1) == 2 then
	      -- npcHandler:say(messagesTable[2], npc, player)
		  -- npcHandler:setTopic(playerId, 1)
	   -- elseif WarewolfTask:getQuestLogMission(player, 1) == 3 then
	      -- if WarewolfTask:getQuestLogMission(player, 2) == 0 then
	         -- WarewolfTask:setQuestLogMission(player, 2, 1)
		     -- npcHandler:say(messagesTable[1] .. itemTable["String"], npc, player)
		  -- elseif WarewolfTask:getQuestLogMission(player, 2) == 1 then
		     -- npcHandler:say(messagesTable[2] .. itemTable["String"], npc, player)
             -- npcHandler:setTopic(playerId, 1)
		  -- end
	   -- end	 
	   
	-- end
	 
	 
	-- if MsgContains(msg, "yes") then
	   -- if npcHandler:getTopic(playerId) == 1 then
	      -- local missingItems = {}
		  -- for index, v in pairs(itemTable["List"]) do
		      -- local id = v.itemid
			  -- local count = v.count
			  -- if player:getItemCount(id) < count then
				 -- local missingCount = count - player:getItemCount(id)
			     -- local values = { ["itemid"] = id, ["count"] = missingCount }
				 -- table.insert(missingItems, values)
			  -- end
		  -- end
		      -- if #missingItems > 0 or player:getMoney() < money then
                 -- local str = "You still need: "
			     -- local items = WarewolfTask:getMissingItemList(missingItems)
			   
			     -- if #missingItems > 0 then
			        -- str = str .. items 
			     -- end
			   
			     -- if player:getMoney() < money then
				    -- local missingMoney = money - player:getMoney() 
			        -- if #missingItems > 0 then
			           -- str = str .. " and " .. missingMoney .. "{ money}"
				    -- else
				      -- str = str .. missingMoney .. "{ money}"
				    -- end
			     -- end
			     -- str = str .. " to finish this mission."
			     -- npcHandler:say(str, npc, player)
			     -- return false
			  -- end
			  
			-- if WarewolfTask:getQuestLogMission(player, 1) == 1 or WarewolfTask:getQuestLogMission(player, 1) == 2 then
			   -- if WarewolfTask:getKills(player) > 0 then
			      -- npcHandler:say("There are monsters left, you have to kill more " .. WarewolfTask:getKills(player) .. " wolfs.", npc, player)
				  -- return false
			   -- end
			      -- WarewolfTask:setQuestLogMission(player, 1, 3)
				  -- WarewolfTask:setQuestLogMission(player, 2, 0)
				  -- npcHandler:say("You have finished first mission.", npc, player)
				  -- WarewolfTask:addRewards(player, rewardTable)
				-- return
			-- end
			
			-- if WarewolfTask:getQuestLogMission(player, 2) == 1 then
				-- WarewolfTask:removeItems(player, itemTable["List"])
			   -- npcHandler:say("You have finished last mission. Now you are allowed to explore {ghost wolf cave}.", npc, player)
			   -- WarewolfTask:setQuestLogMission(player, 2, 2)
			   -- return
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

npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|! im the Warewolf, i have {mission} for you.")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
