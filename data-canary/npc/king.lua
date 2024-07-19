local npcName = "King"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 514,
	lookHead = 39,
	lookBody = 23,
	lookLegs = 61,
	lookFeet = 64,
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




-- local config = {
                  -- _GoldenAccount = false,
                  -- ticketid = 5957,
                  -- ["Avaible Rewards"] = {
						                  -- { type = "item", itemid = "3366", count = 1, chance = 0.5 },
						                  -- { type = "item", itemid = "3288", count = 1, chance = 0.3 },
										  -- { type = "item", itemid = "3555", count = 1, chance = 0.1 },
										  -- { type = "item", itemid = "3587", count = 5, chance = 0.7 },
									    -- } 
			   -- }
			   
	   			   
-- On creature say callback

local function getTableByName(name)
    for i,v in ipairs(KING_NPC_SYSTEM.config["Shop"]) do
	    if not v.name then
		    local id = v.id
			if id then
			    v.name = getItemName(id)
			end
		end
	    if string.find(name:lower(), v.name:lower()) then
		    return v
		end
	end
	return false
end


local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	
	if MsgContains(msg, 'exchange') then
	    npcHandler:say("You can {exchange} tournament coins to {abilities} and {other stuff}.", npc, player)
		return true
	end
	
	if MsgContains(msg, 'abilities') then
	    local groupString = KING_NPC_SYSTEM:getAvaibleGroups()
		npcHandler:say("Abilities List: " .. groupString, npc, player)
		npcHandler:setTopic(playerId, 1)
		return true
	end
	
	if MsgContains(msg, 'other') then
	    local shopTable = KING_NPC_SYSTEM.config["Shop"]
		print(dump(shopTable))
	    local stringRewards = dakosLib:addReward(player, shopTable, false, true, true, false, true, true, true)
		print("String Reward: " .. stringRewards)
		local str = {} 
		str[1] = "Avaible Things: " .. stringRewards
		str[2] = "You have " .. player:getTournamentCoinsBalance() .. " {tournament coins}."
		npcHandler:say(str, npc, player)
		npcHandler:setTopic(playerId, 2)
		return true
	end
	
	
	if npcHandler:getTopic(playerId) == 1 then
	    KING_NPC_SYSTEM:sendWindowByName(player, msg)
		npcHandler:setTopic(playerId, 0)
	    return true
	end
	
	if npcHandler:getTopic(playerId) == 2 then
		local t = getTableByName(msg) 
		if t then
	        npcHandler:say("It will cost " .. t.required_coins .. " {tournament coins}." .. " Are you sure? {yes}, {no}", npc, player)
			KING_NPC_SYSTEM.customers[playerId] = t
			npcHandler:setTopic(playerId, 3)
			return true
		end
		return true
	end
	
    if npcHandler:getTopic(playerId) == 3 then
		if MsgContains(msg, "no") then
		    npcHandler:say("Then no..", npc, player)
		    npcHandler:setTopic(playerId, 0)
			KING_NPC_SYSTEM.customers[playerId] = nil
			return true
		end
		if MsgContains(msg, "yes") then
		    local t = KING_NPC_SYSTEM.customers[playerId]
			local cost = t.required_coins
			if player:getTournamentCoinsBalance() < cost then
                npcHandler:say("Sorry, you dont have enough {tournament coins}.", npc, player)
				return true
			end
			
			local rewards = {}
			table.insert(rewards, t)
			
			player:setTournamentCoinsBalance(player:getTournamentCoinsBalance() - cost)
			dakosLib:addReward(player, rewards, false, false, true, false, true, false, true)
			
			
			npcHandler:say("Here you are.", npc, player)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
			KING_NPC_SYSTEM.customers[playerId] = nil
			npcHandler:setTopic(playerId, 0)
			return true
		end	
	    return true
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

--npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|, here you can exchange {lottery ticket} to special gifts.")
npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME| here you can {exchange} tournament coins.")
npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
