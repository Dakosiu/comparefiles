local npcName = "Hadrin"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 70,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}



npcConfig.flags = {
	floorchange = false,
	hiddenhealth = true
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
	-- npc:setName('<font color="#FFFFFF">Tibia</font>')
	-- print("Npc Name: " .. npc:getName())
	-- --npc:setHiddenHealth(true)
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
    
	local str = "Welcome!"
	
	if not HADRIN_MISSIONS:isVisited(player) then
	   str = str .. " You are sent by Aillika. You don't have to answer, I know the answer. "
	   HADRIN_MISSIONS:setVisited(player)
    end
	
    local key = HADRIN_MISSIONS.config.missionStorage
	local missionId = dakosLib:getQuestLogMission(player, key, 1)
	
	if missionId == 0 then
       str = str .. " Do you want to be useful? I kill {ice dragons} with my axe, they are not a problem for me. Go and kill a primitive dragon relative! {Wyrms}. Will you help me? {yes}, {no}"
	elseif missionId < 4 then
	   str = "Hello again " .. player:getName() .. " i have {mission} for you."
	else
	   str = "Hello " .. player:getName() .. "."
	end
	
	npcHandler:setMessage(MESSAGE_GREET, str)
	return true
end




										

-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	local playerId = player:getId()
	local key = HADRIN_MISSIONS.config.missionStorage
	local missionId = dakosLib:getQuestLogMission(player, key, 1)
	
	
	if MsgContains(msg, "mission") then
	   if missionId == 4 then
	      npcHandler:say("Thanks, you have already helped me.", npc, player)
		  return true
	   elseif missionId == 0 then
	      local requiredString = HADRIN_MISSIONS:getRequiredKills(player)
	      npcHandler:say(requiredString .. " Will you help me with these {wyrms}? {yes}, {no}", npc, player)
		  dakosLib:setQuestLogMission(player, key, 1, 1)
		  npcHandler:setTopic(playerId, 1)
	   elseif missionId == 2 then
	      local countKills = HADRIN_MISSIONS:getKills(player)
		  if countKills then
	         npcHandler:say(countKills .. " left.", npc, player)
		  end
	   elseif missionId == 3 then
	      local t = HADRIN_MISSIONS.config["Missions"][1].reward
		  local rewardString = dakosLib:addReward(player, t, false, true)
		  dakosLib:addReward(player, t, false, false, true)
	      local str = {}
		  table.insert(str, "Congratulations! you have finished killing the {wyrms}, here is your {reward}")
		  table.insert(str, rewardString)
		  table.insert(str, "Old Dwarf, Rich Dwarf!")
	      npcHandler:say(str, npc, player)
		  npcHandler:setTopic(playerId, 0)
          dakosLib:setQuestLogMission(player, key, 1, 4)
		  return true
	   end
	end
	
	if MsgContains(msg, "yes") then
	   if npcHandler:getTopic(playerId) == 0 then
	      if missionId == 0 then
	         local requiredString = HADRIN_MISSIONS:getRequiredKills(player)
	         npcHandler:say(requiredString .. " Will you help me with these {wyrms} ? {yes}, {no}", npc, player)
		     dakosLib:setQuestLogMission(player, key, 1, 1)
		     npcHandler:setTopic(playerId, 1)
		  end
	   elseif npcHandler:getTopic(playerId) == 1 then
	      npcHandler:say("Come back to me when you finish your hunting! Good luck.", npc, player)
		  HADRIN_MISSIONS:setKills(player)
		  dakosLib:setQuestLogMission(player, key, 1, 2)
		  npcHandler:setTopic(playerId, 0)
	   end
	end
    return true
end

--Set to local function "greetCallback"
npcHandler:setCallback(CALLBACK_GREET, greetCallback)

-- Set to local function "creatureSayCallback"
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Bye message
--npcHandler:setMessage(MESSAGE_FAREWELL, "Yeah, good bye and don't come again!")
-- Walkaway message
--npcHandler:setMessage(MESSAGE_WALKAWAY, "You not have education?"

--npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|! i have some {tasks} for you, dont forget to {report} after!")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
