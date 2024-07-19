local npcName = "Arena Leader"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 843,
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
	
	
    local playerId = player:getId()
	local pos = player:getPosition()
	local str = "This buff give: "
	
	if MsgContains(msg, "test") then
	   print(bossEvent:getDate())
	   player:addHonorBuff("Gold", 5)
	   player:addHonorBuff("Silver", 5)
	   player:addHonorBuff("Bronze", 5)
	   return true
	end
	
	
    for buffName, v in pairs(HONOR_BUFF_SYSTEM["Honor Buffs"]) do
	    if MsgContains(msg, buffName) then
		   local firstAttribute = false
		   local increaseResist = v.increaseResist 
		   if increaseResist then
		      if not firstAttribute then
			     firstAttribute = true
				 str = str .. " Increase Resist by: " .. increaseResist .. "%"
				 else
				 str = str .. ", Increase Resist by: " .. increaseResist .. "%"
			  end
		   end
		   
		   local increaseDamage = v.increaseResist
		   if increaseDamage then
		      if not firstAttribute then
			     firstAttribute = true
				 str = str .. " Increase Damage by: " .. increaseDamage .. "%"
				 else
				 str = str .. ", Increase Damage by: " .. increaseDamage.. "%"
			  end
		   end
		   
		   local increaseHealing = v.increaseHealing
		   if increaseHealing then
		      if not firstAttribute then
			     firstAttribute = true
				 str = str .. " Increase Healing by: " .. increaseHealing .. "%"
				 else
				 str = str .. ", Increase Healing by: " .. increaseHealing.. "%"
			  end
		   end
		   
		   local increaseSpeed = v.increaseSpeed
		   if increaseSpeed then
		      if not firstAttribute then
			     firstAttribute = true
				 str = str .. " Increase Speed by: " .. increaseSpeed .. "%"
				 else
				 str = str .. ", Increase Speed by: " .. increaseSpeed .. "%"
			  end
		   end
		   
		   local increaseCap = v.increaseCap
		   if increaseCap then
		      if not firstAttribute then
			     firstAttribute = true
				 str = str .. " Increase Cap by: " .. increaseCap .. "%"
				 else
				 str = str .. ", Increase Cap by: " .. increaseCap .. "%"
			  end
		   end
		   
		   local Regeneration = v.Regeneration
		   if Regeneration then
		      if not firstAttribute then
			     firstAttribute = true
				 str = str .. " " .. Regeneration .. " health and mana regeneration"
				 else
				 str = str .. ", " .. Regeneration .. "/s " ..  "health and mana regeneration"
			  end
		   end
           
		   
		   str = str .. ". "
		   
		   str = str .. " It will cost " .. v.requiredCoins .. " {tournament coins}. Are you sure?"
		   npcHandler:say(str, npc, player)
		   npcHandler:setTopic(playerId, 2)
		   local values = { ["Table"] = v, ["Name"] = buffName }
		   players[cid] = values
		   break
		end
		   
	end
	
	if MsgContains(msg, "yes") and npcHandler:getTopic(playerId) == 2 then
		   npcHandler:setTopic(playerId, 0)
	       t = players[cid]["Table"]
		   
		   if not t then
		      print("[Boss Event] - NPC Error: Can't find player in players table.")
			  return true
		   end
			
		   local playerCoins = player:getTournamentCoinsBalance() 
		   local requiredCoins = t.requiredCoins
		   
		   if playerCoins < requiredCoins then
		      npcHandler:say("Sorry, you dont have enough {tournament coins}, You still need: " .. requiredCoins - playerCoins .. " {tournament coins}.", npc, player)
			  players[cid] = nil
		      return true
		   end
		   
		   local buffName = players[cid]["Name"]
		   player:addHonorBuff(buffName, 7)
		   player:setTournamentCoinsBalance(player:getTournamentCoinsBalance() - requiredCoins)
		   
		   player:sendTextMessage(MESSAGE_INFO_DESCR, "You have obtained " .. buffName .. " honor buff.")
		   
		   
    end
	
	
    return true
end

keywordHandler:addKeyword({'tournament coin'}, StdModule.say, {npcHandler = npcHandler, text = "You can obtain them by participating events."})



-- Set to local function "greetCallback"
--npcHandler:setCallback(CALLBACK_GREET, greetCallback)

-- Set to local function "creatureSayCallback"
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Bye message
--npcHandler:setMessage(MESSAGE_FAREWELL, "Yeah, good bye and don't come again!")
-- Walkaway message
--npcHandler:setMessage(MESSAGE_WALKAWAY, "You not have education?")

local str = "Welcome in tournament arena. Here you can obtain Honor Buffs: "
local index = 0
for buffName, v in pairs(HONOR_BUFF_SYSTEM["Honor Buffs"]) do
    index = index + 1
    if index == 3 then
       str = str .. "{" .. buffName .. "}" .. "."
	else
	   str = str .. "{" .. buffName .. "}" .. ", "
	end
end

npcHandler:setMessage(MESSAGE_GREET, str)

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
