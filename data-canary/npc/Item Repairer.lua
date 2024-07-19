local npcName = "Item Repairer"

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

if not ITEM_REPAIRER then
    ITEM_REPAIRER = {}
end

ITEM_REPAIRER.config = {				 
				            [42384] = {
                                        newItem = 24967,					
				                        required = { 
										              { type = "money", value = 500000 }
												   }
						              }
			           }




function ITEM_REPAIRER:getRepairList()
    if self.itemList then
	    return self.itemList
	end
	
	self.itemList = ""
	
	local isFirst = true
	for i, v in pairs(self.config) do
	    local name = getItemName(i)
		v.itemId = i
		if not self.configCache then
		    self.configCache = {}
		end
		self.configCache[name] = v
	    if not isFirst then
	        self.itemList = self.itemList .. ", "
		end
		self.itemList = self.itemList .. "{" .. name .. "}"
	end
	self.itemList = self.itemList .. "."
	return self.itemList
end
ITEM_REPAIRER:getRepairList()

-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	
	
	if MsgContains(msg, "repair") then
	    npcHandler:say("Here is a item list that i can repair: " .. ITEM_REPAIRER:getRepairList(), npc, player)
		return true
	end
	
	local v = ITEM_REPAIRER.configCache[msg]
	if v then
	    local requiredTable = v.required
		local requiredString = dakosLib:addReward(player, requiredTable, false, true, true, false, true, true, true)
		local finalString = "I can {repair} this item for " .. requiredString .. " Do you agree? " .. "{yes}" .. ", " .. "{no}"
		npcHandler:say(finalString, npc, player)
		if not ITEM_REPAIRER.customers then
		    ITEM_REPAIRER.customers = {}
		end
		ITEM_REPAIRER.customers[playerId] = v
		npcHandler:setTopic(playerId, 2)
		return true
	end
	
	
	
	if npcHandler:getTopic(playerId) == 2 then
	    if MsgContains(msg, "no") then
		    npcHandler:setTopic(playerId, 0)
			npcHandler:say("Then no..", npc, player)
			ITEM_REPAIRER.customers[playerId] = nil
			return true
		end
		if MsgContains(msg, "yes") then
		    local playerTable = ITEM_REPAIRER.customers[playerId]
			local itemId = playerTable.itemId
			if player:getItemCount(itemId) < 1 then
			    npcHandler:say("Sorry, you dont have this item.", npc, player)
				return true
			end
			
			local requiredTable = playerTable.required
			local missingString = dakosLib:getMissingThings(player, requiredTable, true)
			if missingString then
			    npcHandler:say("Sorry, You still need: " .. missingString, npc, player)
				return true
			end
			
			local newId = playerTable.newItem
		    dakosLib:removeThings(player, requiredTable)
			player:removeItem(itemId , 1)
			player:addItem(newId, 1)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
			npcHandler:say("Here you are.", npc, player)
			ITEM_REPAIRER.customers[playerId] = nil
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



npcHandler:setMessage(MESSAGE_GREET, "Hello, here u can {repair} items")
npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
