local npcName = "Hattori"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 159,
	lookHead = 95,
	lookBody = 64,
	lookLegs = 70,
	lookFeet = 116,
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


-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	local pos = player:getPosition()
	local weaponTable = nil
	local armorTable = nil
	local jewelryTable = nil
	local specialTable = nil
	
	for e, exchange in pairs(ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS) do 
		if exchange.attr == "weapons" then
		   weaponTable = e
		elseif exchange.attr == "armors" then
		   armorTable = e
		elseif exchange.attr == "jewelry" then
		   jewelryTable = e
		elseif exchange.attr == "special upgrades" then
		   specialTable = e
		   end
	end

	if MsgContains(msg, "upgrade gems") then
		npcHandler:say("You can forge {weapon upgrade gem}, {armor upgrade gem}, {jewelry upgrade gem}, {special upgrade gem}.", npc, player)
		npcHandler:setTopic(playerId, 1)
		
		elseif MsgContains(msg, "weapon upgrade gem") and npcHandler:getTopic(playerId) == 1 then
		
		
		       local isCraftable = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[weaponTable].craftable
			   local description = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[weaponTable].description
			   
			   if isCraftable == false then
				  npcHandler:say("You can't craft this gem. " .. description, npc, player)
				  npcHandler:setTopic(playerId, 1)
			   else
		
		       local amount = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[weaponTable].amount    			   
			   npcHandler:say("To forge {weapon upgrade gem} you will need " .. amount .. "x " .. "{" .. getItemName(weaponTable) .. "}" .. " Are you sure ?", npc, player)
               npcHandler:setTopic(playerId, 2)
			   
			   end
			   
		elseif MsgContains(msg, "yes") and npcHandler:getTopic(playerId) == 2 then	 

			   local amount = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[weaponTable].amount
			   local exchangeTo = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[weaponTable].exchangeTo
			   
			   
			   if player:getItemCount(weaponTable) < amount then
			      local left = amount - player:getItemCount(weaponTable)
				  
				  if left == 1 then
			         npcHandler:say("You can't craft this item, you have to collect " .. left .. " " .. "{" .. getItemName(weaponTable) .. "}" .. " to process this craft.", npc, player)
					 else
					 npcHandler:say("You can't craft this item, you have to collect " .. left .. "x " .. "{" .. getItemName(weaponTable) .. "}" .. " to process this craft.", npc, player)
				  end
				  
               	  npcHandler:setTopic(playerId, 1)
			   else
			      player:removeItem(weaponTable, amount)
                  player:addItem(exchangeTo, 1)
				  pos:sendMagicEffect(CONST_ME_GREEN)
				  npcHandler:say("Congratulations, you have crafted " .. "{" .. getItemName(exchangeTo) .. "}" .. ".", npc, player)
				  npcHandler:setTopic(playerId, 1)
			   end
		
		elseif MsgContains(msg, getItemName(weaponTable)) then 
		       if npcHandler:getTopic(playerId) == 2 or npcHandler:getTopic(playerId) == 1 then
			   local description = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[weaponTable].description
			   npcHandler:say(description, npc, player)
			   end
			   
		
		
		
		elseif MsgContains(msg, "armor upgrade gem") and npcHandler:getTopic(playerId) == 1 then
		
		       local isCraftable = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[armorTable].craftable
			   local description = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[armorTable].description
			   
			   if isCraftable == false then
			   	  npcHandler:say("You can't craft this gem. jjj" .. description, npc, player)
				  npcHandler:setTopic(playerId, 1)
			   else
		          local amount = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[armorTable].amount 	   			   
			      npcHandler:say("To forge {armor upgrade gem} you will need " .. amount .. "x " .. "{" .. getItemName(armorTable) .. "}" .. " Are you sure ?", npc, player)
                  npcHandler:setTopic(playerId, 3)
			   end
			   
		elseif MsgContains(msg, "yes") and npcHandler:getTopic(playerId) == 3 then	 

			   local amount = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[armorTable].amount
			   local exchangeTo = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[armorTable].exchangeTo
			   
			   
			   if player:getItemCount(armorTable) < amount then
			      local left = amount - player:getItemCount(armorTable)
				  
				  if left == 1 then
			         npcHandler:say("You can't craft this item, you have to collect " .. left .. " " .. "{" .. getItemName(armorTable) .. "}" .. " to process this craft.", npc, player)
					 else
					 npcHandler:say("You can't craft this item, you have to collect " .. left .. "x " .. "{" .. getItemName(armorTable) .. "}" .. " to process this craft.", npc, player)
				  end
				  
               	  npcHandler:setTopic(playerId, 1)
			   else
			      player:removeItem(armorTable, amount)
                  player:addItem(exchangeTo, 1)
				  pos:sendMagicEffect(CONST_ME_GREEN)
				  npcHandler:say("Congratulations, you have crafted " .. "{" .. getItemName(exchangeTo) .. "}" .. ".", npc, player)
				  npcHandler:setTopic(playerId, 1)
			   end
		
		elseif MsgContains(msg, getItemName(armorTable)) then 
		       if npcHandler:getTopic(playerId) == 3 or npcHandler:getTopic(playerId) == 1 then
			   local description = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[armorTable].description
			   npcHandler:say(description, npc, player)
			   end
		
		
		elseif MsgContains(msg, "jewelry upgrade gem") and npcHandler:getTopic(playerId) == 1 then
		
		      local isCraftable = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[jewelryTable].craftable
			  local description = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[jewelryTable].description
			   
			   if isCraftable == false then
			   	  npcHandler:say("You can't craft this gem. " .. description, npc, player)
				  npcHandler:setTopic(playerId, 1)
			   else
		          local amount = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[jewelryTable].amount 		   			   
			      npcHandler:say("To forge {jewelry upgrade gem} you will need " .. amount .. "x " .. "{" .. getItemName(jewelryTable) .. "}" .. " Are you sure ?", npc, player)
                  npcHandler:setTopic(playerId, 4)
			   end
			   
		elseif MsgContains(msg, "yes") and npcHandler:getTopic(playerId) == 4 then	 

			   local amount = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[jewelryTable].amount
			   local exchangeTo = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[jewelryTable].exchangeTo
			   
			   
			   if player:getItemCount(jewelryTable) < amount then
			      local left = amount - player:getItemCount(jewelryTable)
				  
				  if left == 1 then
			         npcHandler:say("You can't craft this item, you have to collect " .. left .. " " .. "{" .. getItemName(jewelryTable) .. "}" .. " to process this craft.", npc, player)
					 else
					 npcHandler:say("You can't craft this item, you have to collect " .. left .. "x " .. "{" .. getItemName(jewelryTable) .. "}" .. " to process this craft.", npc, player)
				  end
				  
               	  npcHandler:setTopic(playerId, 1)
			   else
			      player:removeItem(jewelryTable, amount)
                  player:addItem(exchangeTo, 1)
				  pos:sendMagicEffect(CONST_ME_GREEN)
				  npcHandler:say("Congratulations, you have crafted " .. "{" .. getItemName(exchangeTo) .. "}" .. ".", npc, player)
				  npcHandler:setTopic(playerId, 1)
			   end
		
		elseif MsgContains(msg, getItemName(jewelryTable)) then 
		       if npcHandler:getTopic(playerId) == 4 or npcHandler:getTopic(playerId) == 1 then
			   local description = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[jewelryTable].description
			   npcHandler:say(description, npc, player)
			   end
		
				elseif MsgContains(msg, "special upgrade gem") and npcHandler:getTopic(playerId) == 1 then
		
		      local isCraftable = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[specialTable].craftable
			  local description = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[specialTable].description
			   
			   if isCraftable == false then
			   	  npcHandler:say("You can't craft this gem. " .. description, npc, player)
				  npcHandler:setTopic(playerId, 1)
			   else
		          local amount = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[specialTable].amount 		   			   
			      npcHandler:say("To forge {special upgrade gem} you will need " .. amount .. "x " .. "{" .. getItemName(specialTable) .. "}" .. " Are you sure ?", npc, player)
                  npcHandler:setTopic(playerId, 5)
			   end
			   
		elseif MsgContains(msg, "yes") and npcHandler:getTopic(playerId) == 5 then	 

			   local amount = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[specialTable].amount
			   local exchangeTo = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[specialTable].exchangeTo
			   
			   
			   if player:getItemCount(specialTable) < amount then
			      local left = amount - player:getItemCount(specialTable)
				  
				  if left == 1 then
			         npcHandler:say("You can't craft this item, you have to collect " .. left .. " " .. "{" .. getItemName(specialTable) .. "}" .. " to process this craft.", npc, player)
					 else
					 npcHandler:say("You can't craft this item, you have to collect " .. left .. "x " .. "{" .. getItemName(specialTable) .. "}" .. " to process this craft.", npc, player)
				  end
				  
               	  npcHandler:setTopic(playerId, 1)
			   else
			      player:removeItem(specialTable, amount)
                  player:addItem(exchangeTo, 1)
				  pos:sendMagicEffect(CONST_ME_GREEN)
				  npcHandler:say("Congratulations, you have crafted " .. "{" .. getItemName(exchangeTo) .. "}" .. ".", npc, player)
				  npcHandler:setTopic(playerId, 1)
			   end
		
		elseif MsgContains(msg, getItemName(specialTable)) then 
		       if npcHandler:getTopic(playerId) == 5 or npcHandler:getTopic(playerId) == 1 then
			   local description = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[specialTable].description
			   npcHandler:say(description, npc, player)
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

npcHandler:setMessage(MESSAGE_GREET, "Welcome in my smithy. Here you can craft {upgrade gems}.")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
