--local npcName = "Thel Gilius"
local npcName = "Charmer"
local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
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


-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	local key = BOSS24_SYSTEM_CONFIG.storages.missionid
    local missionid = BOSS24_SYSTEM:getCurrentMission(player)
	
	local requiredMessage = dakosLib:getRequiredThings(player, t, true)
	if MsgContains(msg, "challenge") or MsgContains(msg, "mission") or MsgContains(msg, "task") then
	
	   if not missionid then
	      npcHandler:say("You have finished all {challenges} already.", npc, player)
		  return true
	   end
	   
	   if missionid == #BOSS24_SYSTEM_CONFIG["Missions"] then
	      if missionState == 0 then
		      dakosLib:setQuestLogMission(player, key, missionid, missionState + 1)
		      local killString = BOSS24_SYSTEM:getRequiredString(missionid, 2)
		      BOSS24_SYSTEM:setKillTask(player, missionid)
			  BOSS24_SYSTEM:updateTracker(player, key + missionid)	
			  local strValue = { "I see you have finished all challenges, okay i have for you the last final {mission}, you have to kill " .. killString}
			  npcHandler:say(strValue, npc, player)	
	      elseif missionState == 1 then
		      npcHandler:say("Have you finished your {mission}? {yes}, {no}", npc, player)
		      npcHandler:setTopic(playerId, 3)  
		  end
		  return true
	   end
	   
	   local missionState = dakosLib:getQuestLogMission(player, key, missionid)
	   if missionState == 0 then
	      if missionid == 1 then
		     BOSS24_SYSTEM:setAccess(player, missionid, true)
			 dakosLib:setQuestLogMission(player, key, missionid, 4)
			 dakosLib:setQuestLogMission(player, key, missionid + 1, 1)
			 local requiredTable = BOSS24_SYSTEM_CONFIG["Missions"][missionid + 1]["Required"]
			 local requiredList = dakosLib:getRequiredThings(player, requiredTable, true)	
             local name = BOSS24_SYSTEM:getRequiredBossName(player)				 
			 local strValue = { "Okay, you have started first challenge", "at first mission you need to bring me " .. requiredList }
			 npcHandler:say(strValue, npc, player)
	      else
			 local requiredTable = BOSS24_SYSTEM_CONFIG["Missions"][missionid]["Required"]
			 local requiredList = dakosLib:getRequiredThings(player, requiredTable, true)				
			 local strValue = { "Okay, in this {challenge}", "at first mission you need to bring me " .. requiredList .. "." }	
			 npcHandler:say(strValue, npc, player)
		     dakosLib:setQuestLogMission(player, key, missionid, 1)
		  end
	   else
	      npcHandler:say("Have you finished your {mission}? {yes}, {no}", npc, player)
		  npcHandler:setTopic(playerId, 2)  
       end		  	
	elseif MsgContains(msg, "yes") then
	    if npcHandler:getTopic(playerId) == 2 then
		   local missionState = dakosLib:getQuestLogMission(player, key, missionid)
		   if missionState == 1 then
		      local requiredTable = BOSS24_SYSTEM_CONFIG["Missions"][missionid]["Required"]
			  local missingList = dakosLib:getMissingThings(player, requiredTable, true)
			  if missingList then
		         npcHandler:say("You still need " .. missingList .. ".", npc, player)
				 return true
			  end
			  dakosLib:removeThings(player, requiredTable)
		      dakosLib:setQuestLogMission(player, key, missionid, missionState + 1)
		      local killString = BOSS24_SYSTEM:getRequiredString(missionid, 2)
		      BOSS24_SYSTEM:setKillTask(player, missionid)
			  BOSS24_SYSTEM:updateTracker(player, key + missionid)
			  local strValue = { "Congratulations, you have finished first mission of this {challenge}.", "at second mission you have to kill " .. killString }
		      npcHandler:say(strValue, npc, player)
			  npcHandler:setTopic(playerId, 0)
           elseif missionState == 2 then			    
			    local missingMonsters = BOSS24_SYSTEM:getMissingMonsters(player, missionid, true)
		        npcHandler:say("You still need to kill " .. missingMonsters, npc, player)
		   elseif missionState == 3 then
			    local missingMonsters = BOSS24_SYSTEM:getMissingMonsters(player, missionid, true)
		        if not missingMonsters == "EMPTY" then
		           npcHandler:say("You still need to kill " .. missingMonsters, npc, player)
		           return true
		        end
		   		BOSS24_SYSTEM:setAccess(player, missionid, true)
		        local strValue = { "Congratulations, you have finished second mission of this {challenge}", "You have finished this challenge." }
		        npcHandler:say(strValue, npc, player)
		        dakosLib:setQuestLogMission(player, key, missionid, missionState + 1)
                npcHandler:setTopic(playerId, 0)				
		   end
		elseif npcHandler:getTopic(playerId) == 3 then
			    local missingMonsters = BOSS24_SYSTEM:getMissingMonsters(player, missionid, true)
		        if not missingMonsters == "EMPTY" then
		           npcHandler:say("You still need to kill " .. missingMonsters, npc, player)
		           return true
		        end
		   		--BOSS24_SYSTEM:setAccess(player, missionid, true)
		        local strValue = { "Congratulations, you have finished final mission" }
		        npcHandler:say(strValue, npc, player)
		        dakosLib:setQuestLogMission(player, key, missionid, missionState + 1)
                npcHandler:setTopic(playerId, 0)
        end		
	end
    return true
end
-- Set to local function "creatureSayCallback"
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Bye message
--npcHandler:setMessage(MESSAGE_FAREWELL, "Yeah, good bye and don't come again!")
-- Walkaway message
--npcHandler:setMessage(MESSAGE_WALKAWAY, "You not have education?")

npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|! You have finally found me, i have some {challenges} for you")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
