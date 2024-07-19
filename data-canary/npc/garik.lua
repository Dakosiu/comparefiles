local npcName = "Garik"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 5000000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 538,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
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

local requiredItems = {
	{5880, 50}, -- iron ore
	{5944, 50}, -- soul orb
}

-- topic list (not configurable)
local topic = {
	welcome = 0,
	questionAsked = 1
}

-- dialogues
local dialogue = {
	-- job, smith
	job = "I do smithing in this {forge}.",
	
	-- forge
	forgeBeforeQuest = "The forge is completing lots of orders daily. Unfortunately, there is one {problem}.",
	forgeCompleted = "Thanks to you, the forge is running at full capacity.",
	
	-- problem, quest, mission
	missionBegin = {
		"I need to forge several weapons for royal elite unit, but the supply transport did not arrive this week...",
		"I am running out of resources and I am unable to order them again because I paid a lot in advance...",
		"Because of that, I cannot reward you with money either. However, I can teach you how to scrap your no longer used equipment...",
		"in order to recover renewable materials from it. Are you interested?"
	},
	missionContinue = "Did you bring the iron ores and soul orbs I asked for?", -- mentions orbs and ores
	missionCompleted = "Your help is no longer needed. Feel free to use my {forge} to recover components from your equipment.",
	
	-- responses to mission->yes/no
	missionAccept = "Great. Bring me 50 iron ores and 50 soul orbs. Once you are ready, ask me for a {mission}.", -- mentions orbs and ores
	missionRefused = "Hm, I see.",
	
	missionOnComplete = "Thank you for your help. As a reward you can come to my forge and scrap the equipment anytime you want.",
	missionNotEnoughItems = "You do not have 50 iron ores and 50 soul orbs I asked for.", -- mentions orbs and ores
}


-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	local currentTopic = npcHandler.topic[playerId] -- read only shortcut, to overwrite current topic, call npcHandler.topic[playerId] = newValue
	
	-- keywords: job, smith
	if MsgContains(msg, "job") or MsgContains(msg, "smith") then
		npcHandler:say(dialogue.job, npc, player)
		npcHandler.topic[playerId] = topic.welcome
		return
	end
	
	-- detect storage from other script
	-- ignore keywords if detection failed
	if not ShredderRequiredStorage then	
		if MsgContains(msg, "mission") or MsgContains(msg, "quest") or MsgContains(msg, "problem") or currentTopic == topic.questionAsked then
			print("[item shredder system] Warning: quest storage not detected. NPC ignored quest keywords.")
			npcHandler.topic[playerId] = topic.welcome
			return
		end
	end
	
	local questStatus = player:getStorageValue(ShredderRequiredStorage[1])
	print("Quest Status: " .. questStatus)
	print("Potrzebne Storage: " .. ShredderRequiredStorage[1])
	-- keyword: forge
	if MsgContains(msg, "forge") then
		if questStatus == -1 then
			npcHandler:say(dialogue.forgeBeforeQuest, npc, player)
			npcHandler.topic[playerId] = topic.welcome
			return
		elseif questStatus == 0 then
			npcHandler:say(dialogue.missionContinue, npc, player)
			npcHandler.topic[playerId] = topic.questionAsked
			return
		end
		
		npcHandler:say(dialogue.forgeCompleted, npc, player)
		npcHandler.topic[playerId] = topic.welcome
		return
	end
	
	-- npc asked a question
	if npcHandler.topic[playerId] ~= 666 then
	if currentTopic == topic.questionAsked then
		if MsgContains(msg, "yes") then
			if questStatus == -1 then
				-- reaction to: do you want to help me? -> yes
				player:setStorageValue(ShredderRequiredStorage[1], 0)
				npcHandler:say(dialogue.missionAccept, npc, player)
				npcHandler.topic[playerId] = topic.welcome
				return
			elseif questStatus == 0 then
				-- reaction to: did you bring the ores? -> yes
				
				-- check item count
				for _, itemData in pairs(requiredItems) do
					if player:getItemCount(itemData[1]) < itemData[2] then
						npcHandler:say(dialogue.missionNotEnoughItems, npc, player)
						npcHandler.topic[playerId] = topic.welcome
						return
					end
				end

				-- set storage
				player:setStorageValue(ShredderRequiredStorage[1], 1)
				
				-- remove items
				for _, itemData in pairs(requiredItems) do
					player:removeItem(itemData[1], itemData[2])
				end
				
				npcHandler:say(dialogue.missionOnComplete, npc, player)
				npcHandler.topic[playerId] = topic.welcome
				return
			else
				-- handle situation when storage was granted from other script when talking with npc
				npcHandler:say(dialogue.missionCompleted, npc, player)
				npcHandler.topic[playerId] = topic.welcome
				return
			end
		end
		
		-- any other response than yes
		npcHandler:say(dialogue.missionRefused, npc, player)
		npcHandler.topic[playerId] = topic.welcome
		return
	end
	end
	
	-- start a quest or continue it
	if MsgContains(msg, "mission") or MsgContains(msg, "quest") or MsgContains(msg, "problem") then
		if questStatus == -1 then
			npcHandler:say(dialogue.missionBegin, npc, player)
			npcHandler.topic[playerId] = topic.questionAsked
			return
		elseif questStatus == 0 then
			npcHandler:say(dialogue.missionContinue, npc, player)
			npcHandler.topic[playerId] = topic.questionAsked
			return
		end
		
		npcHandler:say(dialogue.missionCompleted, npc, player)
		npcHandler.topic[playerId] = topic.welcome
		return
	end
	
	if MsgContains(msg, "clock master") or MsgContains(msg, "clockmaster") or MsgContains(msg, "gear wheel") or MsgContains(msg, "help") then
	
	if clockmasterTask:getQuestLogMission(player, 1) > 0 then
	   t = CLOCKMASTER_TASKS[2]["Required Items"]
       itemTable = clockmasterTask:getItemList(t)
	   money = clockmasterTask:countMoney(t)
	   messagesTable = CLOCKMASTER_TASKS[2]["Messages"]
       rewardTable = CLOCKMASTER_TASKS[2]["Reward"]    
    end 
	
	if clockmasterTask:getQuestLogMission(player, 3) > 0 then
	   t = CLOCKMASTER_TASKS[4]["Required Items"]
       itemTable = clockmasterTask:getItemList(t)
	   money = clockmasterTask:countMoney(t)
	   messagesTable = CLOCKMASTER_TASKS[4]["Messages"]
       rewardTable = CLOCKMASTER_TASKS[4]["Reward"]  
    end   
	
	if clockmasterTask:getQuestLogMission(player, 1) < 1 then
	      npcHandler:say("Sorry? im busy.. i dont need a {help}.", npc, player)
		  return false
	end
	   
	   if clockmasterTask:getQuestLogMission(player, 4) == 2 then
	      npcHandler:say("Hehe thanks for the {crystal} i dont need anymore {help}.", npc, player)
		  return false
	   end
	   
	   if clockmasterTask:getQuestLogMission(player, 1) == 1 and clockmasterTask:getQuestLogMission(player, 2) < 1 then
	      npcHandler:say("Oh, i see you have visited my old friend {clock master}, Okay i can give you " .. "{glooth glider gear wheel}" .. " if you bring me " .. itemTable["String"], npc, player)
		  clockmasterTask:setQuestLogMission(player, 1, 2)
		  clockmasterTask:setQuestLogMission(player, 2, 1)
	   elseif clockmasterTask:getQuestLogMission(player, 2) == 1 then
	      npcHandler:say("Do you have " .. itemTable["String"] .. " for me?", npc, player)
		  npcHandler:setTopic(playerId, 666)
	   elseif clockmasterTask:getQuestLogMission(player, 2) == 2 and clockmasterTask:getQuestLogMission(player, 3) < 1 then
	      npcHandler:say("Okay, your second mission is: You have to talk with {Smaug} and obtain from him {Crystal} and bring it to me.", npc, player)
		  clockmasterTask:setQuestLogMission(player, 3, 1)
	   elseif clockmasterTask:getQuestLogMission(player, 3) == 1 then
	      npcHandler:say("You have to finish smaug request first.", npc, player)
		  return false
	   elseif clockmasterTask:getQuestLogMission(player, 4) == 1 then
	   
		    if clockmasterTask:getQuestLogMission(player, 3) < 3 then
			   npcHandler:say("You have to finish smaug request first.", npc, player)
			   return false
			end
			
			npcHandler:say("Do you have a {Crystal} from {Smaug} that i asked?", npc, player)
			npcHandler:setTopic(playerId, 666)
		end
	end
	
	
	if MsgContains(msg, "yes") then
	   if npcHandler:getTopic(playerId) == 666 then
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
			  --npcHandler:say(messagesTable[3], npc, player)
			  
			  clockmasterTask:setMission(player, clockmasterTask:getMission(player) + 1) 
			  
			  if clockmasterTask:getQuestLogMission(player, 2) == 1 then
			      clockmasterTask:setQuestLogMission(player, 2, 2)
				  npcHandler:say("You have finished first mission.", npc, player)
			  elseif clockmasterTask:getQuestLogMission(player, 4) == 1 then
			     clockmasterTask:setQuestLogMission(player, 3, 3)
				 clockmasterTask:setQuestLogMission(player, 4, 2)
				 clockmasterTask:setQuestLogMission(player, 5, 1)
				 clockmasterTask:setMission(player, clockmasterTask:getMission(player) + 1) 
				 clockmasterTask:addRewards(player, rewardTable)
				 npcHandler:say("Ahh yes.. thats the {crystal} that i wanted, here is your reward. You should return to Clock Master.", npc, player)
			  end
	     end
		npcHandler:setTopic(playerId, 0)
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

npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME| I have a mission and I need you {mission}? Do you want to {help} me? or maybe you wanna ask about {clock master}")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
