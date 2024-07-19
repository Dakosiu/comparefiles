local npcName = "Aillika"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 138,
	lookHead = 0,
	lookBody = 125,
	lookLegs = 87,
	lookFeet = 0,
	lookAddons = 3,
	--lookMount = 1209
}



npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 10000,
	chance = 50,
	{ text = "I speak only with banshees.", yell = false }
}



if not aillika_outfits then
   aillika_outfits = {}
end
   
-- Create keywordHandler and npcHandler
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

-- onThink
npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
	--local creature = Creature(npc:getId())
	--creature:say("Lol")
end

local function changeOutfit(npc_id)
   
   local npc = Creature(npc_id)
   if not npc then
      return
   end
   
   local outfits = { 78, 122, 54, 138 }
   
   local selectedOutfit = outfits[math.random(1, #outfits)]
   if aillika_outfits.lastOutfit then
      while selectedOutfit == aillika_outfits.lastOutfit do
         selectedOutfit = outfits[math.random(1, #outfits)]
	     last_outfit = selectedOutfit
      end
   end
   npc:getPosition():sendMagicEffect(32)
   npc:getPosition():sendMagicEffect(36)
   local newOutfit = npcConfig.outfit
   newOutfit.lookType = selectedOutfit
   npc:setOutfit(newOutfit)
   aillika_outfits.lastOutfit = selectedOutfit
   addEvent(changeOutfit, 5000, npc:getId())
end
   
-- onAppear
local isEnabled = false
npcType.onAppear = function(npc, creature)
	   if not aillika_outfits.enabled then
	      changeOutfit(npc:getId())
		  aillika_outfits.enabled = true
	   end
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
	--npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|, you need more info about {canary}?")
	npcHandler:setMessage(MESSAGE_GREET, "Sorry!??")
	
	return true
end




										

-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)

	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	
	local playerId = player:getId()
    local key = AILLIKA_MISSIONS.config.missionStorage
	local currentMission = dakosLib:getQuestCurrentMission(player, key, AILLIKA_MISSIONS.config["Missions"], 3)
	local missionId = dakosLib:getQuestLogMission(player, key, currentMission)
	local missionTable = AILLIKA_MISSIONS.config["Missions"][currentMission]
	--local messageTable = missionTable.messages


	if MsgContains(msg, "mission") then
	
	    if currentMission == 0 then
		   npcHandler:say("Sorry!, You have finished all requests from me.", npc, player)
		   return true
		end	  


        if currentMission == 1 then
	       if missionId <= 0 then
	          npcHandler:say("Three years will pass, and a brave solider, after a hard fight, will free the world from the clutches of the evil dragon. Then Zakaria World will develop like never before. However, if this doesn't happen, {Zakaria will fall}.", npc, player)
			  npcHandler:setTopic(playerId, 2)
		   elseif missionId == 1 then
		      npcHandler:say("But remember the stranger, not only one brave daredevil ran away and laid down his weapons against the red dragon. {Bring me the red dragon trophy}. To free the world from danger once and for all.", npc, player)
			  npcHandler:setTopic(playerId, 3)
		   end
		elseif currentMission == 2 then
		    if missionId <= 0 then
			   npcHandler:say("I have the impression that there is an additional heart in my body, belonging to the sound and having its own rhythm. I knew that you would come and you would not leave your people {in need}.", npc, player)
			   npcHandler:setTopic(playerId, 4)
			elseif missionId == 1 then
			   npcHandler:say("Follow southeast into the swamps! {Be careful}!", npc, player)
			   npcHandler:setTopic(playerId, 5)
			elseif missionId == 2 then
		      local t = missionTable.reward
		      local rewardString = dakosLib:addReward(player, t, false, true)
			  dakosLib:addReward(player, t, false, false, true, false)
			  local str = {}
			  table.insert(str, "Ahh, I think i forgot to reward you for your job. This is your reward.")
			  table.insert(str, rewardString)	  
              npcHandler:say(str, npc, player)
              dakosLib:setQuestLogMission(player, key, currentMission, 3)
			end
		elseif currentMission == 3 then
		    if missionId <= 0 then
		       npcHandler:say("We gather strength, we are getting closer to the journey. You must make our way easier so that I can find my old friend. A dwarf tired of the day's march named {Hadrin}.", npc, player)
			   npcHandler:setTopic(playerId, 7)
			elseif missionId == 1 or missionId == 2 then
			   npcHandler:say("Have you killed all the {dragons}? And did you find {Hadrin}? {yes}, {no}", npc, player)
			   npcHandler:setTopic(playerId, 8)
			end
        end			
		
		
	elseif MsgContains(msg, "Zakaria will fall") then
	    if npcHandler:getTopic(playerId) == 2 then
		   npcHandler:say("But remember the stranger, not only one brave daredevil ran away and laid down his weapons against the red dragon. {Bring me the red dragon trophy}. To free the world from danger once and for all.", npc, player)
	       dakosLib:setQuestLogMission(player, key, currentMission, 1)
		   npcHandler:setTopic(playerId, 3)
		end
	elseif MsgContains(msg, "Bring me the red dragon trophy") then
	    if npcHandler:getTopic(playerId) == 3 then
		   -- check items
		   local t = missionTable.requiredItems
		   local missingItems = dakosLib:getMissingThings(player, t, true)
		   if missingItems then
		       npcHandler:say("You still need: " .. missingItems, npc, player)
			   return true
		   end
		   npcHandler:say("A broad smile lit the mage's face. Excellent! Now I can continue my task. Thanks to your help, we magicians will become stronger! But this is just the beginning of the tasks for you. Now rest and come when you're ready to get next mission", npc, player)
	       dakosLib:setQuestLogMission(player, key, currentMission, 3)
		   npcHandler:setTopic(playerId, 0)
		   dakosLib:removeThings(player, t)
		   dakosLib:addReward(player, missionTable.reward)
		end	
	elseif MsgContains(msg, "in need") then
	    if npcHandler:getTopic(playerId) == 4 then
		   npcHandler:say("Good answer my stranger. Has Zakaria become your new home? Isn't it hard to pass by indifferently? It's been 2 years since my team went on an expedition. To complete the potion that will allow you to deal with another beast, you need a very old plant that grows only in swamps.It will not be that simple, the plant changes its appearance every now and then. Old books say (When you meet it, you'll know that it’s going about it. Please {bring me this plant}, {more informations about plant}", npc, player)
	       dakosLib:setQuestLogMission(player, key, currentMission, 1)
		   npcHandler:setTopic(playerId, 5)
		end
	elseif MsgContains(msg, "more informations about plant") then
        if npcHandler:getTopic(playerId) == 5 then	
		   npcHandler:say("You can find this plant by following southeast into the swamps! {Be careful}!", npc, player)
		   return true
		end
	elseif MsgContains(msg, "bring me this plant") or MsgContains(msg, "Be careful") then
    	if npcHandler:getTopic(playerId) == 5 then
		   npcHandler:say("Are you alive? You see ? You hear? You have it right? {yes}, {no}", npc, player)
		   --Suddenly, Aillik's delicate body fell to the ground in front of you, breaking him out of his trance. Terrified, he stretched out his hand for the plant", npc, player)
		   npcHandler:setTopic(playerId, 6)
		end
	elseif MsgContains(msg, "yes") then	
	    if npcHandler:getTopic(playerId) == 6 then
		   local t = missionTable.requiredItems
		   local missingItems = dakosLib:getMissingThings(player, t, true)
		   if missingItems then
		       npcHandler:say("Sorry? You dont have the plant that i asked for.", npc, player)
			   return true
		   end
		   dakosLib:removeThings(player, t)
		   --dakosLib:addReward(player, missionTable.reward)
		   npcHandler:say("Suddenly, Aillik's delicate body fell to the ground in front of you, breaking him out of his trance. Terrified, he stretched out his hand for the plant", npc, player)
		   dakosLib:setQuestLogMission(player, key, currentMission, 2)
		elseif npcHandler:getTopic(playerId) == 8 then
		   local count = player:getStorageValue(AILLIKA_MISSIONS.config.killingStorage)
		   local visited = HADRIN_MISSIONS:isVisited(player)
		   local strError = ""
		   if count > 0 then
		      strError = strError .. "You still need to kill " .. count .. " {frost dragon's}"
			  if not visited then
			     strError = strError .. " and you have still to visit my friend {Hadrin}"
			  end
			  strError = strError .. "."
		      npcHandler:say(strError, npc, player)
			  return true
		   end
		   if not visited then
		      npcHandler:say("I see you have finished hunting but you have to still visit my friend {Hadrin}", npc, player)
			  return true
		   end
		   local t = missionTable.reward
		   local rewardString = dakosLib:addReward(player, t, false, true)
		   dakosLib:addReward(player, t, false, false, true, false)

		   local str = {}
		   table.insert(str, "Here's your reward Thank You!, Now I have to see my old friend.")
           table.insert(str, rewardString)		   
		   dakosLib:setQuestLogMission(player, key, currentMission, 3)
		   npcHandler:say(str, npc, player)
		   npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(msg, "reward") then
        if currentMission == 2 then
           if missionId == 2 then
		      local t = missionTable.reward
		      local rewardString = dakosLib:addReward(player, t, false, true)
			  dakosLib:addReward(player, t, false, false, true, false)
			  local str = {}
			  table.insert(str, "That's what it was all about. Let me say nothing but start preparing the potion. Goodbye our helper. Come when you regain strength for the trip and you are ready for further tasks. This is your reward.")
              table.insert(str, rewardString)			  
              npcHandler:say(str, npc, player)
              dakosLib:setQuestLogMission(player, key, currentMission, 3)
           end
        end	
    elseif MsgContains(msg, "hadrin") then		
	    if npcHandler:getTopic(playerId) == 7 then
		   local monsterTable = missionTable.requiredKills
		   local count = monsterTable.kills
		   npcHandler:say("In the midst of the freezing wind, only the sound of constant frost was heard. Where (the {ice dragons}). Where you haven't been yet. You have to find him and kill " .. count .. " {Frost Dragons}.", npc, player)
		   dakosLib:setQuestLogMission(player, key, currentMission, 1)
		   player:setStorageValue(AILLIKA_MISSIONS.config.killingStorage, count)
		   
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
--npcHandler:setMessage(MESSAGE_WALKAWAY, "You not have education?"

--npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|! i have some {tasks} for you, dont forget to {report} after!")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
