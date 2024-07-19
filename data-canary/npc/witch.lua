local npcName = "Witch"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 200000
npcConfig.walkRadius = 5

npcConfig.outfit = {
	lookType = 54,
	lookHead = 114,
	lookBody = 77,
	lookLegs = 94,
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

local diceConfig = {
	[1] = {maxHealth = 50},
	[2] = {maxHealth = 20},
	[3] = {maxHealth = 20},
	[4] = {text = "You won't have a reward this time, though, maybe the next one."},
	[5] = {text = "You won't have a reward this time, though, maybe the next one."},
	[6] = {itemId = 2160, count = 1},
	[7] = {itemId = 2160, count = 1},
	[8] = {text = "You got permanent 3% extra critical damage! Good for you, pal!"},
	[9] = {text = "You got permanent faster mana regeneration! That's nice news.", maxHealth = 5},
	[10] = {text = "Damn you defeated me! I don't want to play anymore with you, you are way too lucky, sorry. But I will reward you with access to my magical soup kettle, maybe you can craft some magic stones there."},
}


local broomConfig = {
                      item_id = 3454, 
					  cost = 1000000
					}

local function getString(player)
	if player:getWitchProgress() >= 10 then 
	   return ""
	end
	
    return "If you win " .. 10 - player:getWitchProgress() .. " times more, i will allow you to use my kettle."
end

-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	
    local playerId = player:getId()

	
	if npcHandler:getTopic(playerId) < 1 then
		if MsgContains(msg, 'game') then
			if player:getStorageValue(800002) == 10 or player:getWitchProgress() >= 10 then
				npcHandler:say('What? You are still here and to make fun of me? You already won, get out of here.', npc, player)
			elseif player:getStorageValue(800002) == -1 then
				npcHandler:say('Sure, we can play a game. It is very simple, you have to choose a number between {1} and {10}. If you guess it correctly, I will reward you depending on how many times you guess it right. The cost is 100cc, do you want to participate? Say {yes} or {no}.', npc, player)
				npcHandler:setTopic(playerId, 1)
			else
				npcHandler:say('We are already playing, right? Remember, a number from {1} to {10}, the cost is 100 cc. You can say it now.', npc, player)
				npcHandler:setTopic(playerId, 2)
			end
		else
			npcHandler:say("What? I don't get what are you saying. Maybe wanna play a {game}?", npc, player)
		end
	elseif npcHandler:getTopic(playerId) == 1 then
		if MsgContains(msg, 'yes') then
			player:setStorageValue(800002, 0)
			npcHandler:say("Ok, then let's start by you telling me a number between {1} and {10}. Remember it will cost you 100 cc.", npc, player)
			npcHandler:setTopic(playerId, 2)
		else
			npcHandler:say("Well, when you have made up your mind, talk to me again about the {game}", npc, player)
			npcHandler:setTopic(playerId, 0)
		end
	elseif npcHandler:getTopic(playerId) == 2 then
		local value = tonumber(msg)
		local check = true
		if not value then
			npcHandler:say("What? That ain't a number, come on, I know it's a game, but don't play with me. If you want to play again, talk to me again about a {game}.", npc, player)
			npcHandler:setTopic(playerId, 0)
		else
			if value < 1 or value > 10 then
				npcHandler:say("Come on, you have to say a number between {1} and {10}.", npc, player)
			else
				if not player:removeMoney(1) then
					npcHandler:say("Don't waste my time, you don't have the money.", npc, player)
					npcHandler:setTopic(playerId, 0)
				else
					local randomNumber = math.random(1, 10)
					if randomNumber == value then
						npcHandler:say("No way! You won this time.", npc, player)
						local actualStorage = player:getStorageValue(800002)
						local data = diceConfig[actualStorage+1]
						if data.maxHealth then
						    local str = { "You get " .. data.maxHealth .. " hp extra forever, consider it a witch's gift.", getString(player) }
							npcHandler:say(str, npc, player)
							player:setMaxHealth(player:getMaxHealth(true) + data.maxHealth)
						elseif data.itemId then
						    local str = { "You get " .. data.count .."x " .. ItemType(data.itemId):getName() .. ", consider it a witch's magical item.", getString(player) } 
							npcHandler:say(str, npc, player)
							player:addItem(data.itemId, data.count)
						end
						if data.text then
							npcHandler:say(data.text, npc, player)
						end
						--player:addAchievementProgress(800002, 1)
						-- local value = player:getWitchProgress()
						-- if value < 10 then
						   -- npcHandler:say("If you win " .. 10 - value .. " times more, i will allow you to use my kettle.", npc, player)
						-- end
						   
						player:addWitchBuff()
						player:addWitchProgress()
						if actualStorage == 9 then
							npcHandler:setTopic(playerId, 0)
						end
					else
						npcHandler:say("Whoops! The dice went to " .. randomNumber .. ". You lost, and I get some free gold! Thank you.", npc, player)
					end
				end
			end
		end			
	end
	
	if MsgContains(msg, 'broom') or MsgContains(msg, 'discoverer') then
	   npcHandler:say("I will never give my own {broom} but i can sell other one for you. It will cost " .. broomConfig.cost .. " money, Are you sure?", npc, player)
	   npcHandler:setTopic(playerId, 102)
	elseif MsgContains(msg, 'yes') then
	   if npcHandler:getTopic(playerId) == 102 then
		  local cost = broomConfig.cost
		  if player:getMoney() < cost then
		     return npcHandler:say("You dont have enough money.", npc, player)
	      end
		  player:removeMoney(cost)
		  player:addItem(broomConfig.item_id)
		  npcHandler:say("Here you are.", npc, player)
		  npcHandler:setTopic(playerId, 0)
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

npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|, you seek something? Maybe a {game}?")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
