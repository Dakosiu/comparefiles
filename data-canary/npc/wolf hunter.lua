local npcName = "Wolf Hunter"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 20000
npcConfig.walkRadius = 5

npcConfig.outfit = {
	lookType = 684,
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
    

    if wolfhunterTask:getQuestLogMission(player, 1) < 3 then
	   t = WOLFHUNTER_TASKS[1]["Required Items"]
       itemTable = wolfhunterTask:getItemList(t)
	   money = wolfhunterTask:countMoney(t)
	   messagesTable = WOLFHUNTER_TASKS[1]["Messages"]
       rewardTable = WOLFHUNTER_TASKS[1]["Reward"]    
    else
	   t = WOLFHUNTER_TASKS[2]["Required Items"]
       itemTable = wolfhunterTask:getItemList(t)
	   money = wolfhunterTask:countMoney(t)
	   messagesTable = WOLFHUNTER_TASKS[2]["Messages"]
       rewardTable = WOLFHUNTER_TASKS[2]["Reward"]  
    end   
	
	
	  	
	if MsgContains(msg, "help") or MsgContains(msg, "mission") then
	
	   if wolfhunterTask:getQuestLogMission(player, 2) == 2 then
	      npcHandler:say("I dont need anymore {help}.", npc, player)
		  return false
	   end
	   
	   if wolfhunterTask:getQuestLogMission(player, 1) < 1 then
	      npcHandler:say(messagesTable[1] .. wolfhunterTask:getKillTask(), npc, player)
	      wolfhunterTask:setQuestLogMission(player, 1, 1)
		  wolfhunterTask:setKillTask(player)
	   elseif wolfhunterTask:getQuestLogMission(player, 1) == 1 or wolfhunterTask:getQuestLogMission(player, 1) == 2 then
	      npcHandler:say(messagesTable[2], npc, player)
		  npcHandler:setTopic(playerId, 1)
	   elseif wolfhunterTask:getQuestLogMission(player, 1) == 3 then
	      if wolfhunterTask:getQuestLogMission(player, 2) == 0 then
	         wolfhunterTask:setQuestLogMission(player, 2, 1)
		     npcHandler:say(messagesTable[1] .. itemTable["String"], npc, player)
		  elseif wolfhunterTask:getQuestLogMission(player, 2) == 1 then
		     npcHandler:say(messagesTable[2] .. itemTable["String"], npc, player)
             npcHandler:setTopic(playerId, 1)
		  end
	   end	 
	   
	end
	 
	 
	if MsgContains(msg, "yes") then
	   if npcHandler:getTopic(playerId) == 1 then
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
			     local items = wolfhunterTask:getMissingItemList(missingItems)
			   
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
			  
			if wolfhunterTask:getQuestLogMission(player, 1) == 1 or wolfhunterTask:getQuestLogMission(player, 1) == 2 then
			   if wolfhunterTask:getKills(player) > 0 then
			      npcHandler:say("There are monsters left, you have to kill more " .. wolfhunterTask:getKills(player) .. " wolfs.", npc, player)
				  return false
			   end
			      wolfhunterTask:setQuestLogMission(player, 1, 3)
				  wolfhunterTask:setQuestLogMission(player, 2, 0)
				  npcHandler:say("You have finished first mission.", npc, player)
				  wolfhunterTask:addRewards(player, rewardTable)
				return
			end
			
			if wolfhunterTask:getQuestLogMission(player, 2) == 1 then
				wolfhunterTask:removeItems(player, itemTable["List"])
			   npcHandler:say("You have finished last mission. Now you are allowed to explore {ghost wolf cave}.", npc, player)
			   wolfhunterTask:setQuestLogMission(player, 2, 2)
			   return
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

npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|! im the Wolf Master, i have {mission} for you.")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
