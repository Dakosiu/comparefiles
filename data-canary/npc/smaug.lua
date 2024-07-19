local npcName = "Smaug"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookTypeEx = 11400,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
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
    --creature:setOutfit({lookTypeEx = 11400})
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

local GOLDEN_OUTFIT = {
	storage = 68942,
	cost = 100,
}

local FOOD = {
	storage = 68943,
	itemRequired = {36844, 10},
	itemObtained = {2463, 1},
}

-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	
    local playerId = player:getId()
	
		if npcHandler:getTopic(playerId) == 0 then
		if MsgContains(msg, 'golden outfit') then
			if player:getStorageValue(GOLDEN_OUTFIT.storage) == -1 then
				npcHandler:say("Look, you don't look like you have the money for the golden outfit, but if you can prove you deserve it, I will give it to you for " .. GOLDEN_OUTFIT.cost .. " diaments. Is it a deal? Answer clearly, {yes} or {no}.", npc, player)
				npcHandler:setTopic(playerId, 1)
			else
				npcHandler:say("Why do you bring this topic? You have proven to me you have some money, not many are able to do that.", npc, player)
			end
		elseif MsgContains(msg, 'food') then
			if player:getStorageValue(FOOD.storage) == -1 then
				npcHandler:say("I often get hungry here. Bring me " .. FOOD.itemRequired[2] .. "x " .. ItemType(FOOD.itemRequired[1]):getName() .. " and I will reward you. Do you have it with you? Answer clearly with {yes} or {no}.", npc, player)
				npcHandler:setTopic(playerId, 2)
			else
				npcHandler:say("You already got me some food, thank you for that.", npc, player)
			end
		--else
		--	npcHandler:say("What are you talking about? If it's not about the {golden outfit} or {food} I'm not interested.", npc, player)
		end
	elseif npcHandler:getTopic(playerId) == 1 then
		if MsgContains(msg, 'yes') then
			if player:removeItem(ITEM_DIAMOND_COIN, GOLDEN_OUTFIT.cost) then
				player:addAchievement("A rich man in the bay")
				player:setStorageValue(GOLDEN_OUTFIT.storage, 1)
				player:addOutfitAddon(1210, 3)
				player:addOutfitAddon(1211, 3)
				npcHandler:say("You have proven to me you deserve this outfit. You impress me, human, I shall give you the outfit and take the diaments, thank you for this generous donation.", npc, player)
			else
				npcHandler:say("Come on, you don't have the money, you are just a simple mortal, aside from that, poor.", npc, player)
			end
		else
			npcHandler:say("Then why are you even talking to me about it?", npc, player)
		end
		npcHandler:setTopic(playerId, 0)
	elseif npcHandler:getTopic(playerId) == 2 then
		if MsgContains(msg, 'yes') then
			if player:removeItem(FOOD.itemRequired[1], FOOD.itemRequired[2]) then
				npcHandler:say("Thank you, I will feast on that. Here, " .. FOOD.itemObtained[2] .. "x " .. ItemType(FOOD.itemObtained[1]):getName() .. " just for you.", npc, player)
				player:addItem(FOOD.itemObtained[1], FOOD.itemObtained[2])
				player:setStorageValue(FOOD.storage, 1)
			else	
				npcHandler:say("Don't make me talk about food if you won't give me any, get out of my sight.", npc, player)
			end
		else
			npcHandler:say("Then why are you here if you won't give it to me.", npc, player)
		end
		npcHandler:setTopic(playerId, 0)
	end
	
	
		   t = CLOCKMASTER_TASKS[3]["Required Items"]
       itemTable = clockmasterTask:getItemList(t)
	   money = clockmasterTask:countMoney(t)
	   messagesTable = CLOCKMASTER_TASKS[3]["Messages"]
       rewardTable = CLOCKMASTER_TASKS[3]["Reward"]   
	  	
	if MsgContains(msg, "help") or MsgContains(msg, "gear wheel") or MsgContains(msg, "mission") or MsgContains(msg, "garik") then
	
	   if clockmasterTask:getQuestLogMission(player, 3) < 1 then
	      npcHandler:say("Sorry?, i dont need any help.", npc, player)
	      return false
	   end
	
	   if clockmasterTask:getQuestLogMission(player, 3) == 3 then
	      npcHandler:say("I dont have any business with you anymore.. leave me alone!", npc, player)
	      return false
	   end
	 
	   if clockmasterTask:getQuestLogMission(player, 3) == 1 then
	      npcHandler:say("Oh, i see ... {Garik} send you to me, Okay your mission is: bring me " .. itemTable["String"], npc, player)
		  clockmasterTask:setQuestLogMission(player, 3, 2)
	   elseif clockmasterTask:getQuestLogMission(player, 3) == 2 then
	      npcHandler:say("Do you have " .. itemTable["String"] .. " for me?", npc, player)
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
			  npcHandler:say(messagesTable[3], npc, player)
			  clockmasterTask:addRewards(player, rewardTable)
			  npcHandler:say("Here is the crystal that you asked for.. go back and meet the Garik again.", npc, player)
			  clockmasterTask:setMission(player, clockmasterTask:getMission(player) + 1) 
			  clockmasterTask:setQuestLogMission(player, 3, 3)
			  clockmasterTask:setQuestLogMission(player, 4, 1)
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

npcHandler:setMessage(MESSAGE_GREET, "How dare you disturb me, I only talk to people who are worth it and are filthy rich! What do you want? Do you see that {golden outfit}? Do you want to buy it from me? Or are you here to bring me some {food} as an offering?, or maybe you wanna ask about {garik} ?")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
