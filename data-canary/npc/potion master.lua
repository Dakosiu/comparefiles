local internalNpcName = "Potion Master"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 138,
	lookHead = 59,
	lookBody = 70,
	lookLegs = 93,
	lookFeet = 76,
	lookAddons = 0
}

npcConfig.flags = {
	floorchange = false
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

local items = {
	[VOCATION.BASE_ID.SORCERER] = 3074,
	[VOCATION.BASE_ID.DRUID] = 3066
}

local players = {}

local discount = 0.20


local function creatureSayCallback(npc, creature, type, msg)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

   	local playerId = player:getId()
	local t = REFILLABLE_POTION_SYSTEM.cache
	
	if MsgContains(msg, "refill") then
	   local list = dakosLib:getStringListFromTable(t, true)
	   npcHandler:say("Here is a list of refillable potions in my labolatory: " .. list, npc, player)
	   npcHandler:setTopic(playerId, 1)
	-- elseif MsgContains(msg, "upgrade") then
	   -- local list = dakosLib:getStringListFromTable(t, true)
	   -- npcHandler:say("Here is a list of upgradeable potions in my labolatory: " .. list, npc, player)
	   -- npcHandler:setTopic(playerId, 3)
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
			      b.value = b.value - (b.value * discount)
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
	
	-- local itemId = items[player:getVocation():getBaseId()]
	-- if MsgContains(message, 'first rod') or MsgContains(message, 'first wand') then
		-- if player:isMage() then
			-- if player:getStorageValue(Storage.firstMageWeapon) == -1 then
				-- npcHandler:say('So you ask me for a {' .. ItemType(itemId):getName() .. '} to begin your adventure?', npc, creature)
				-- npcHandler:setTopic(playerId, 1)
			-- else
				-- npcHandler:say('What? I have already gave you one {' .. ItemType(itemId):getName() .. '}!', npc, creature)
			-- end
		-- else
			-- npcHandler:say('Sorry, you aren\'t a druid either a sorcerer.', npc, creature)
		-- end
	-- elseif MsgContains(message, 'yes') then
		-- if npcHandler:getTopic(playerId) == 1 then
			-- player:addItem(itemId, 1)
			-- npcHandler:say('Here you are young adept, take care yourself.', npc, creature)
			-- player:setStorageValue(Storage.firstMageWeapon, 1)
		-- end
		-- npcHandler:setTopic(playerId, 0)
	-- elseif MsgContains(message, 'no') and npcHandler:getTopic(playerId) == 1 then
		-- npcHandler:say('Ok then.', npc, creature)
		-- npcHandler:setTopic(playerId, 0)
	-- end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|! here you can {buy} and {refill} potions.")

npcConfig.shop = {
	{ itemName = "animate dead rune", clientId = 3203, buy = 375 },
	{ itemName = "avalanche rune", clientId = 3161, buy = 57 },
	{ itemName = "blank rune", clientId = 3147, buy = 20 },
	{ itemName = "chameleon rune", clientId = 3178, buy = 210 },
	{ itemName = "convince creature rune", clientId = 3177, buy = 80 },
	{ itemName = "crystal ball", clientId = 3076, buy = 650 },
	{ itemName = "cure poison rune", clientId = 3153, buy = 65 },
	{ itemName = "desintegrate rune", clientId = 3197, buy = 26 },
	{ itemName = "destroy field rune", clientId = 3148, buy = 15 },
	{ itemName = "durable exercise rod", clientId = 35283, buy = 945000, count = 1800 },
	{ itemName = "durable exercise wand", clientId = 35284, buy = 945000, count = 1800 },
	{ itemName = "energy bomb rune", clientId = 3149, buy = 203 },
	{ itemName = "energy field rune", clientId = 3164, buy = 38 },
	{ itemName = "energy wall rune", clientId = 3166, buy = 85 },
	{ itemName = "exercise rod", clientId = 28556, buy = 262500, count = 500 },
	{ itemName = "exercise wand", clientId = 28557, buy = 262500, count = 500 },
	{ itemName = "explosion rune", clientId = 3200, buy = 31 },
	{ itemName = "fire bomb rune", clientId = 3192, buy = 147 },
	{ itemName = "fire field rune", clientId = 3188, buy = 28 },
	{ itemName = "fire wall rune", clientId = 3190, buy = 61 },
	{ itemName = "fireball rune", clientId = 3189, buy = 30 },
	{ itemName = "great fireball rune", clientId = 3191, buy = 57 },
	{ itemName = "hailstorm rod", clientId = 3067, buy = 15000 },
	{ itemName = "heavy magic missile rune", clientId = 3198, buy = 12 },
	{ itemName = "holy missile rune", clientId = 3182, buy = 16 },
	{ itemName = "icicle rune", clientId = 3158, buy = 30 },
	{ itemName = "intense healing rune", clientId = 3152, buy = 95 },
	{ itemName = "lasting exercise rod", clientId = 35289, buy = 7560000, count = 14400 },
	{ itemName = "lasting exercise wand", clientId = 35290, buy = 7560000, count = 14400 },
	{ itemName = "life crystal", clientId = 3061, sell = 75 },
	{ itemName = "life ring", clientId = 3052, buy = 1000 },
	{ itemName = "light magic missile rune", clientId = 3174, buy = 4 },
	{ itemName = "magic wall rune", clientId = 3180, buy = 116 },
	{ itemName = "ultimate healing rune", clientId = 3160, buy = 175 },
	{ itemName = "ultimate health potion", clientId = 7643, buy = 303 },
	{ itemName = "ultimate mana potion", clientId = 23373, buy = 350 },
	{ itemName = "ultimate spirit potion", clientId = 23374, buy = 350 },
	{ itemName = "great health potion", clientId = 239, buy = 180 },
	{ itemName = "great mana potion", clientId = 238, buy = 115 },
	{ itemName = "great spirit potion", clientId = 7642, buy = 182 },
	{ itemName = "mana potion", clientId = 268, buy = 44 },
	{ itemName = "health potion", clientId = 266, buy = 40 },
	{ itemName = "mind stone", clientId = 3062, sell = 150 },
	{ itemName = "moonlight rod", clientId = 3070, buy = 1000 },
	{ itemName = "necrotic rod", clientId = 3069, buy = 5000 },
	{ itemName = "northwind rod", clientId = 8083, buy = 7500 },
	{ itemName = "paralyze rune", clientId = 3165, buy = 700 },
	{ itemName = "poison bomb rune", clientId = 3173, buy = 85 },
	{ itemName = "poison field rune", clientId = 3172, buy = 21 },
	{ itemName = "poison wall rune", clientId = 3176, buy = 52 },
	{ itemName = "snakebite rod", clientId = 3066, buy = 500 },
	{ itemName = "soulfire rune", clientId = 3195, buy = 46 },
	{ itemName = "spellbook of enlightenment", clientId = 8072, sell = 3500 },
	{ itemName = "spellbook of lost souls", clientId = 8075, sell = 17500 },
	{ itemName = "spellbook of mind control", clientId = 8074, sell = 12000 },
	{ itemName = "spellbook of warding", clientId = 8073, sell = 7500 },
	{ itemName = "spellwand", clientId = 651, sell = 299 },
	{ itemName = "springsprout rod", clientId = 8084, buy = 18000 },
	{ itemName = "stalagmite rune", clientId = 3179, buy = 12 },
	{ itemName = "stone shower rune", clientId = 3175, buy = 37 },
	{ itemName = "sudden death rune", clientId = 3155, buy = 135 },
	{ itemName = "terra rod", clientId = 3065, buy = 10000 },
	{ itemName = "thunderstorm rune", clientId = 3202, buy = 47 },
	{ itemName = "ultimate healing rune", clientId = 3160, buy = 175 },
	{ itemName = "underworld rod", clientId = 8082, buy = 22000 },
	{ itemName = "wand of cosmic energy", clientId = 3073, buy = 10000 },
	{ itemName = "wand of decay", clientId = 3072, buy = 5000 },
	{ itemName = "wand of draconia", clientId = 8093, buy = 7500 },
	{ itemName = "wand of dragonbreath", clientId = 3075, buy = 1000 },
	{ itemName = "wand of inferno", clientId = 3071, buy = 15000 },
	{ itemName = "wand of starstorm", clientId = 8092, buy = 18000 },
	{ itemName = "wand of voodoo", clientId = 8094, buy = 22000 },
	{ itemName = "wand of vortex", clientId = 3074, buy = 500 },
	{ itemName = "wild growth rune", clientId = 3156, buy = 160 }
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

npcType:register(npcConfig)