local npcName = "Gary"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 224,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
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
	
		local name = "Lantern Quest"
	
	if MsgContains(msg, "informations") then
       npcHandler:say("What do you want to know about Lantern Quest ? {required items}, {boost}, {active}", npc, player)
	elseif MsgContains(msg, "boost") then
	   if not worldQuests:getExperienceBoost(name) then
	      npcHandler:say("There is no active any boost.", npc, player)
		  return false
	   end
	   npcHandler:say("Experience boost is active, it will expire at: " .. worldQuests:getExperienceBoost(name), npc, player)
	elseif MsgContains(msg, "active") then
	     if not worldQuests:isActive(name) then
		    if worldQuests:isReactivated(name) then
			   if worldQuests:getReactiveTime(name) > os.time() then
        	      local reactive_time = worldQuests:getReactiveTime(name, true)
				  npcHandler:say("Quest is not active, it will reactive at: " .. reactive_time, npc, player)
			   end
			else
			    npcHandler:say("Quest is not active.", npc, player)
			end
		else
		   if worldQuests:isReactivated(name) then
		      local reactive_time = worldQuests:getReactiveTime(name, true)
			  if worldQuests:getReactiveTime(name) > os.time() then
		         npcHandler:say("Quest is active, It will end at: " .. reactive_time, npc, player)
			  end
		   else
		       npcHandler:say("Quest is active." .. reactive_time, npc, player)
		   end
		end
	elseif MsgContains(msg, "required items") then
		local items_list = worldQuests:getRequiredItems(name, true, true)
		npcHandler:say("Items that need to be collect: " .. items_list, npc, player)	
	end
	
	local t = WORLD_QUESTS[name]["Required Items"]
	for id, v in pairs(t) do
	    local title = v.text
		local item_name = getItemName(id)
		if MsgContains(msg, item_name) then
		   npcHandler:say("{" .. item_name .. "}" .. " " .. title, npc, player)
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

npcHandler:setMessage(MESSAGE_GREET, "Hello! |PLAYERNAME| here you can get {informations} about Lantern Quest.")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
