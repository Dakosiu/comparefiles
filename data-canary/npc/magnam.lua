local npcName = "Magnam"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 962,
	lookHead = 962,
	lookBody = 109,
	lookLegs = 114,
	lookFeet = 114
	-- lookAddons = 3,
	-- lookMount = 1209
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

--npcHandler:setTopic(playerId, 1)
--npcHandler:getTopic(playerId)
-- On creature say callback

local players = {}

local function creatureSayCallback(npc, player, type, msg)

	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	local playerId = player:getId()
	local t = REFILLABLE_POTION_SYSTEM.cache
	
	if MsgContains(msg, "refill") then
	   local list = dakosLib:getStringListFromTable(t, true)
	   npcHandler:say("Here is a list of refillable potions in my labolatory: " .. list, npc, player)
	   npcHandler:setTopic(playerId, 1)
	elseif MsgContains(msg, "upgrade") then
	   local list = dakosLib:getStringListFromTable(t, true)
	   npcHandler:say("Here is a list of upgradeable potions in my labolatory: " .. list, npc, player)
	   npcHandler:setTopic(playerId, 3)
    end

	
	if npcHandler:getTopic(playerId) == 1 then
	   for name, v in pairs(REFILLABLE_POTION_SYSTEM.cache) do
	       if MsgContains(msg, name) then
		      if not players[playerId] then
			     players[playerId] = {}
			  end
              local id = dakosLib:getItemIdByName(name)
			  local item = player:getItemById(id, true)
			  if not item then
			     npcHandler:say("You dont have this item.", npc, player)
				 return false
			  end
              players[playerId].itemid = id
			  local level = REFILLABLE_POTION_SYSTEM:getLevel(item)
			  if level > 0 then
			     players[playerId].requireditems = REFILLABLE_POTION_SYSTEM.cache[name]["Level " .. level]["Refill"]["Required Items"]
			  else
			     players[playerId].requireditems = REFILLABLE_POTION_SYSTEM.cache[name]["Normal"]["Refill"]["Required Items"]
		      end

	          local t = players[playerId].requireditems
			  local leftCharges = item:getRefil()
			  local maxCharges = REFILLABLE_POTION_SYSTEM:getMaxCharges(item)
			  for _, b in pairs(t) do
			     b.value = REFILLABLE_POTION_SYSTEM:getDiscount(b.value, leftCharges, maxCharges)
			  end
			  
			  npcHandler:say("To refill this potion you will need: " .. dakosLib:getRequiredItems(t, player) .. " Are you sure? {yes}, {no}", npc, player)
			  
			  npcHandler:setTopic(playerId, 2)
			end
	   end
	elseif npcHandler:getTopic(playerId) == 3 then
	   for name, v in pairs(REFILLABLE_POTION_SYSTEM.cache) do
	       if MsgContains(msg, name) then
		      if not players[playerId] then
			     players[playerId] = {}
			  end
              local id = dakosLib:getItemIdByName(name)
			  local item = player:getItemById(id, true)
			  if not item then
			     npcHandler:say("You dont have this item.", npc, player)
				 return false
			  end
			  
			  local isRefillable = REFILLABLE_POTION_SYSTEM:isRefillable(item)
			  if not isRefillable then
			     npcHandler:say("this item is not refillable.", npc, player)
				 return false
			  end
			  
              players[playerId].itemid = id
			  local level = REFILLABLE_POTION_SYSTEM:getLevel(item)
			  
			  local levelTable = nil
			  
			  if level == 0 then
			     levelTable = REFILLABLE_POTION_SYSTEM.cache[name]["Level 1"]
				 if not levelTable then
				    npcHandler:say("Sorry, This potion reached max upgrade level.", npc, player)
				    return false
			     end
			     players[playerId].requireditems = REFILLABLE_POTION_SYSTEM.cache[name]["Level 1"]["Upgrade"]["Required Items"]
		      else
			     levelTable = REFILLABLE_POTION_SYSTEM.cache[name]["Level " .. level + 1]
				 if not levelTable then
				    npcHandler:say("Sorry, This potion reached max upgrade level.", npc, player)
				    return false
			     end				 
			     players[playerId].requireditems = REFILLABLE_POTION_SYSTEM.cache[name]["Level " .. level + 1]["Upgrade"]["Required Items"]
		      end
			  
			  local requiredLevel = levelTable.requiredLevel
			  if requiredLevel then
			     if player:getLevel() < requiredLevel then
				    npcHandler:say("Sorry, you need to be atleast " .. requiredLevel .. " level to process this upgrade.", npc, player)
					return false
			     end
			  end
			  
			  local increaseCharges = levelTable.increaseCharges
			  if increaseCharges then
			     players[playerId].increaseCharges = increaseCharges
			  else
			     players[playerId].increaseCharges = 0
			  end
				 
		      
	          local t = players[playerId].requireditems
			  
			  if not t then
			     npcHandler:say("Sorry, This potion reached max upgrade level.", npc, player)
				 return false
		      end
			  
			  npcHandler:say("To refill this potion you will need: " .. dakosLib:getRequiredItems(t, player) .. " Are you sure? {yes}, {no}", npc, player)
			  npcHandler:setTopic(playerId, 4)
			end
	   end
    end	   
	
	if MsgContains(msg, "yes") then
	   if npcHandler:getTopic(playerId) == 2 then
	      local t = players[playerId].requireditems
		  local check = dakosLib:getMissingItems(t, player)
		  if check then
			 str = " to refill this potion."
			 npcHandler:say("You still need: " .. check .. str, npc, player)
			 return false
		  end
	      local id = players[playerId].itemid
		  local item = player:getItemById(id, true)
		  if item then
		     local value = REFILLABLE_POTION_SYSTEM:getMaxCharges(item)
             item:setRefil(value)			 
		  end
		  npcHandler:say("Your potion has been refilled.", npc, player)
		  npcHandler:setTopic(playerId, 1)
		  dakosLib:removeItems(t, player)
	   elseif npcHandler:getTopic(playerId) == 4 then
	      local t = players[playerId].requireditems
		  local check = dakosLib:getMissingItems(t, player)
		  if check then
			 str = " to upgrade this potion."
			 npcHandler:say("You still need: " .. check .. str, npc, player)
			 return false
		  end
	      local id = players[playerId].itemid
		  local item = player:getItemById(id, true)
		  local level = 0
		  if item then
		     level = REFILLABLE_POTION_SYSTEM:getLevel(item)
			 REFILLABLE_POTION_SYSTEM:addLevel(item)
			 local increaseCharges = players[playerId].increaseCharges
			 if increaseCharges and increaseCharges > 0 then
			    REFILLABLE_POTION_SYSTEM:addMaxCharges(item, increaseCharges)
		     end
             			 
		  end
		  if level == 0 then
		     npcHandler:say("Your potion has been upgraded from normal state to level 1.", npc, player)
		   else
		     npcHandler:say("Your potion has been upgraded from " .. level .. " level to " .. level + 1 .. " level.", npc, player)
		  end
	     
		  dakosLib:removeItems(t, player)
		  npcHandler:setTopic(playerId, 3)
	   end
	end
	

	
	
	
	-- if (MsgContains(msg, "special potions" or MsgContains(msg, "potions"))) then
	    -- local list = ""
		-- for name, v in pairs(REFILLABLE_POTION_SYSTEM.cache) do
		    -- list = list .. "{" .. name .. "}"
	    -- end
		
	    -- npcHandler:say("Alright, here you can {upgrade} or {refill}: " .. list .. ".", npc, player)
	-- end
	
	
	-- if MsgContains(msg, "refill") then
	   -- local list = ""
	   -- for name, v in pairs(REFILLABLE_POTION_SYSTEM.cache) do
	       -- list = list .. "{" .. name .. "}"
	   -- end
	   -- npcHandler:say("Alright, here is a list of refillable potions: " .. list .. ".", npc, player)
	   -- npcHandler:setTopic(playerId, 1)
	-- end  
	
	-- if npcHandler:getTopic(playerId) == 1 then
	    -- for name, v in pairs(REFILLABLE_POTION_SYSTEM.cache) do
	       -- if MsgContains(msg, name) then
		      -- if not players[playerId] then
			     -- players[playerId] = {}
			  -- end
			  -- local id = dakosLib:getItemIdByName(name)
			  -- players[playerId].itemid = id
			  -- players[playerId].requireditems = REFILLABLE_POTION_SYSTEM.cache[name]["Refill"]["Required Items"]
			  -- local t = players[playerId].requireditems
		      -- npcHandler:say("Refil this potion will cost " .. dakosLib:getRequiredItems(t, player) .. " Are you sure? {yes}, {no}", npc, player)
			  -- npcHandler:setTopic(playerId, 2)
            -- end
	    -- end	
	-- end
	

	
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|! Welcome in my laboratory, here you can {refill} and {upgrade} special refillable potions.")
npcHandler:addModule(FocusModule:new())
-- Register npc
npcType:register(npcConfig)
