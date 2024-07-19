if not JEWEL_BOX_EVENT then
   JEWEL_BOX_EVENT = {}
end


ADDON_SCROLL_SYSTEM = {}
ADDON_SCROLL_SYSTEM.config = {
                               [1] = { 
							           name = "Veteran Paladin",
									   male = 1204,
									   female = 1205
									 }
						     }

ADDON_SCROLL_SYSTEM.itemid = 10028
ADDON_SCROLL_SYSTEM.aid = 5007
ADDON_SCROLL_SYSTEM.customAttribute = {
                                        index =  "ADDON_SCROLL_INDEX",
										addons = "ADDON_SCROLL_VALUE"
									  }
									  
ABILITY_SCROLL_SYSTEM = {}
ABILITY_SCROLL_SYSTEM.config = {
                                 [1] = { 
							             name = "Scroll of Inteligence",
										 description = "mysterious scroll that gives 100 mana for 20 minutes.",
									     abilities = { 
										               manaGain = { value = 100, duration = { type = "minutes", value = 20 } } 
													 }
									   },
                                 [2] = { 
							             name = "Scroll of Strength",
										 description = "mysterious scroll that gives 100 health for 20 minutes.",
									     abilities = { 
										               healthGain = { value = 100, duration = { type = "minutes", value = 20 } } 
													 }
									   },
                                 [3] = {
                                         name = "Floki Scroll",
										 description = "mysterious scroll that reduce 5% received damage for 20 minutes.",
										 abilities = {
										               increaseProtection = { value = 0.05, duration = { type = "minute", value = 20 } }
													 }
									   },
                                 [4] = {
                                         name = "Scroll of Damage",
										 description = "mysterious scroll that increase damage by 5% for 20 minutes.",
										 abilities = {
										               increaseDamage = { value = 0.05, duration = { type = "minutes", value = 20 } }
													 }
                                        },													 
                                 [5] = {
                                         name = "Scroll of Knowledge",
										 description = "mysterious scroll that increase your experience gain by 30% for 20 minutes.",
										 abilities = {
										               increaseExperience = { value = 0.3, duration = { type = "minutes", value = 20 } }
													 }
                                       }													 
						       }

ABILITY_SCROLL_SYSTEM.itemid = 28650
ABILITY_SCROLL_SYSTEM.aid = 5008
ABILITY_SCROLL_SYSTEM.customAttribute = {
                                          index =  "ABILITY_SCROLL_INDEX"
									    }									  
ABILITY_SCROLL_SYSTEM.storages = {
                                   	["manaGain"] = 5006111,
                                    ["healthGain"] = 5006112,
                                    ["increaseProtection"] = 5006113,
									["increaseDamage"] = 5006114,
									["increaseExperience"] = 5006115
								 }
									  


EXERCISE_WEAPON_BOX = {}
EXERCISE_WEAPON_BOX.config = {
                               { type = "item", id = 28557, count = 500 },
							   { type = "item", id = 28556, count = 500 },
                               { type = "item", id = 28555, count = 500 },
							   { type = "item", id = 28554, count = 500 },
                               { type = "item", id = 42379, count = 500 },							   
                               { type = "item", id = 28553, count = 500 }
							 }							   
							   
EXERCISE_WEAPON_BOX.itemid = 32226

JEWEL_BOX_EVENT.config = {
                           ["General"] = {
										   monstersList = { "Bony Sea Devil", "Brachiodemon", "Branchy Crawler", "Capricious Phantom", "Cloak of Terror", "Courage Leech", "Distorted Phantom", "Druid's Apparition", "Hazardous Phantom", "Infernal Demon", "Infernal Phantom", "Knight's Apparition", "Many Faces", "Mould Phantom", "Paladin's Apparition", "Rotten Golem", "Sorcerer's Apparition", "Turbulent Elemental", "Vibrant Phantom" },
                                           monstersDrop = { type = "item", id = 7527, count = 1, chance = 0.007 } 		  
										 },
						   ["NPC"] = {
						               [7527] = { 
									              required = 10,
												  avaibleRewards = { 
												                     { type = "outfit scroll", name = "Veteran Paladin", addon = 0, chance = 0.9 },
																	 { type = "outfit scroll", name = "Veteran Paladin", addon = 1, chance = 0.5 },
																	 { type = "outfit scroll", name = "Veteran Paladin", addon = 2, chance = 0.5 },
														             { type = "ability scroll", name = "Scroll of Inteligence", chance = 0.9 },
														             { type = "ability scroll", name = "Scroll of Strength", chance = 0.09 },
														             { type = "ability scroll", name = "Floki Scroll", chance = 0.07 },
														             { type = "ability scroll", name = "Scroll of Damage", chance = 0.99 },
												                     { type = "ability scroll", name = "Scroll of Knowledge", chance = 0.8 },
														             { type = "item", id = 32771, count = 1, chance = 0.02 },
														             { type = "item", id = 19365, count = 1, chance = 0.05 },
														             { type = "item", name = "supreme health potion", count = 20, chance = 0.01 },
														             { type = "item", name = "ultimate mana potion", count = 20, chance = 0.06 },
														             { type = "item", name = "ultimate spirit potion", count = 20, chance = 0.5 },
														             { type = "key", id = 23733, actionid = 5752, name = "Event Key", description = "Key for entrace Goshnar's Hatred Boss lair.", chance = 0.9 },
																	 { type = "item", id = EXERCISE_WEAPON_BOX.itemid, count = 1, chance = 0.5 },
																	 { type = "item", id = 28485, count = 1, chance = 0.9 },
																	 { type = "item", id = 28484, count = 1, chance = 0.9 },
																	 { type = "item", id = 25718, count = 1, chance = 0.9 }
																    }
												},
						               [19365] = { 
									              required = 1,
												  avaibleRewards = { 
												                     { type = "item", id = 42329, count = 1, chance = 0.05 },
																	 { type = "item", id = 42333, count = 1, chance = 0.05 },
																	 { type = "item", id = 42332, count = 1, chance = 0.05 },
																	 { type = "item", id = 42330, count = 1, chance = 0.05 },
																   }
												}												
                                     },
							["Boss"] = {
							             ["Name"] = "Cave Rat",
								         ["Positions"] = { 
										                    ["Entrace"] = { x = 969, y = 1133, z = 7 },
												            ["Teleport"] = { x = 971, y = 1131, z = 6 },
															["Respawn"] = { x = 979, y = 1131, z = 6 },
															--["Exit"] = { x = 1128, y = 1082, z = 9 },
															["Timeout"] = { x = 931, y = 1114, z = 7 }, 
														 },										 
							             ["Scheduler"] = { 
										 					["Reminder"] = { enabled = true, seconds = 10 },
															["Kick"] = 2, -- w minutach
															["Statue"] = { 
																           enabled = true, 
																		   id = 746,
																		   position = { x = 976, y = 1131, z = 6 },
																		 }
														}
										}

					     } 
						 
JEWEL_BOX_EVENT.customAttribute = "GOSHNAR_KEY"
JEWEL_BOX_EVENT.bossStorageTime = 54112117


local talkaction = TalkAction("!jewel")
function talkaction.onSay(player)
    
	local t = JEWEL_BOX_EVENT.config["NPC"][7527].avaibleRewards
    JEWEL_BOX_EVENT:addRewards(player, t, false, false, true)
    
    return false
end
talkaction:register()

																				 
function ADDON_SCROLL_SYSTEM:getIndexByName(name)
    for i, v in ipairs(self.config) do
	    if v.name == name or v.name:lower() == name:lower() then
		   return i
		end
	end
	return false
end

function ADDON_SCROLL_SYSTEM:generateScroll(name, thing, addons)
    local item = Game.createItem(self.itemid, 1)
	if not item then
	   return false
	end
	item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, self.aid)
	local index = ADDON_SCROLL_SYSTEM:getIndexByName(name) 
	item:setAttribute(ITEM_ATTRIBUTE_NAME, "Outfit Scroll")
	
	
	local str = ""
	name = name:lower()
	if addons == 0 then
	   str = str .. name .. " outfit."
	elseif addons == 1 then
	   str = str .. "first addon for " .. name .. " outfit."
	elseif addons == 2 then
	   str = str .. "second addon for " .. name .. " outfit."
	elseif addons == 3 then
	   str = str .. "full addon for " .. name .. " outfit."	   
	end
	
	item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, str)
	item:setCustomAttribute(self.customAttribute.index, index)
	item:setCustomAttribute(self.customAttribute.addons, addons)
	return item
end

function ADDON_SCROLL_SYSTEM:getDescription(item)
    if not item:getId() == self.itemid then
	   return false
	end
	
	local index = item:getCustomAttribute(self.customAttribute.index) 
	if not index then
	   return false
	end
	
	local name = self.config[index].name:lower()
	local addons = item:getCustomAttribute(self.customAttribute.addons) 
	local str = "It Contains: " .. "\n"
	if addons == 0 then
	   str = str .. name .. " outfit."
	elseif addons == 1 then
	   str = str .. "first addon for " .. name .. " outfit."
	elseif addons == 2 then
	   str = str .. "second addon for " .. name .. " outfit."
	elseif addons == 3 then
	   str = str .. "full addon for " .. name .. " outfit."	   
	end
	return str
end

function ABILITY_SCROLL_SYSTEM:getIndexByName(name)
    for i, v in ipairs(self.config) do
	    if v.name == name or v.name:lower() == name:lower() then
		   return i
		end
	end
	return false
end

function ABILITY_SCROLL_SYSTEM:generateScroll(name)
	--local item = thing:addItem(self.itemid)
	local item = Game.createItem(self.itemid, 1)
	if not item then
	   return false
	end

	local index = self:getIndexByName(name)
	local t = self.config[index]
	local name = t.name
	local description = t.description
	item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, self.aid)
	item:setCustomAttribute(self.customAttribute.index, index)
	item:setAttribute(ITEM_ATTRIBUTE_NAME, name)
	item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, description)
	return item
end

function ABILITY_SCROLL_SYSTEM:setBoostStorage(player, t, name)
    
	local method = t.type
	local duration = t.value
    local interval = 0
	
    if string.find(method, "second") then
	   interval = duration
    elseif string.find(method, "minute") then
	   interval = duration * 60
    elseif string.find(method, "hour") then 
	   interval = duration * 60 * 60
    end 
		
    local storage = self.storages[name]
	player:setStorageValue(storage, interval + os.time())
end

function ABILITY_SCROLL_SYSTEM:getBoostStorage(player, name)
   local storage = self.storages[name]
   if player:getStorageValue(storage) > os.time() then
      return true
   end
  
   return false
end

function ABILITY_SCROLL_SYSTEM:getBoostString(player, name)
  local storage = self.storages[name]
  local time_left = player:getStorageValue(storage) - os.time()
    
  local days = math.floor(time_left/86400)
  local remaining = time_left % 86400
  local hours = math.floor(remaining/3600)
  remaining = remaining % 3600
  local minutes = math.floor(remaining/60)
  remaining = remaining % 60
  local seconds = remaining
  
  str = ""
  
  local isStarted = false
  
  if days > 0 then
     str = str .. days .. " days"
	 isStarted = true
  end
  
  if hours > 0 then
     if isStarted then
	    str = str .. ", "
	 end
	 str = str .. hours .. " hours"
	 isStarted = true
  end

  if minutes > 0 then
     if isStarted then
	    str = str .. ", "
	 end
	 str = str .. minutes .. " minutes"
	 isStarted = true
  end
  
  if seconds > 0 then
     if days == 0 and hours == 0 and minutes == 0 then
	    str = seconds .. " seconds"
     elseif minutes > 0 then
	    str = str .. " and " .. seconds .. " seconds"
	 end
  end
  
   str = str .. "."
   return str
end

function ABILITY_SCROLL_SYSTEM:addBoost(player, name, t)
	local storage = self.storages[name]
	local durationTable = t.duration
	local value = t.value
	if name == "manaGain" then	
	   local subid = 8022
	   
	   if player:getCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, subid) then
	      player:sendCancelMessage("You have already activated this boost.")
		  return false
	   end
	   
	   local interval = dakosLib:getInterval(durationTable)
	   local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	   condition:setParameter(CONDITION_PARAM_STAT_MAXMANAPOINTS, value)
	   condition:setParameter(CONDITION_PARAM_SUBID, subid)
	   condition:setTicks(interval)
	   player:addCondition(condition)
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "Your mana is increased by " .. value .. ".")
	elseif name == "healthGain" then
	   local subid = 8023
	   if player:getCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, subid) then
	      player:sendCancelMessage("You have already activated this boost.")
		  return false
	   end
	   local interval = dakosLib:getInterval(durationTable)
	   local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	   condition:setParameter(CONDITION_PARAM_STAT_MAXHITPOINTS, value)
	   condition:setParameter(CONDITION_PARAM_SUBID, subid)
	   condition:setTicks(interval)
	   player:addCondition(condition)
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "Your health is increased by " .. value .. ".")	
    elseif name == "increaseProtection" then
       if ABILITY_SCROLL_SYSTEM:getBoostStorage(player, name) then
	      player:sendCancelMessage("You have already activated this boost.")
		  return false
       end	      
	   
	   ABILITY_SCROLL_SYSTEM:setBoostStorage(player, durationTable, name)
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "You have now receieve " .. value * 100 .. "% less damage.")
    elseif name == "increaseDamage" then
	   if ABILITY_SCROLL_SYSTEM:getBoostStorage(player, name) then
	      player:sendCancelMessage("You have already activated this boost.")
		  return false
       end
	   ABILITY_SCROLL_SYSTEM:setBoostStorage(player, durationTable, name)
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "Your damage is increased by " .. value * 100 .. "%.")	   
    elseif name == "increaseExperience" then
	   if ABILITY_SCROLL_SYSTEM:getBoostStorage(player, name) then
	      player:sendCancelMessage("You have already activated this boost.")
		  return false
       end
	   ABILITY_SCROLL_SYSTEM:setBoostStorage(player, durationTable, name)
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "Your experience gain is increased by " .. value * 100 .. "%.")	  	   
	end
	return true
end	

function ABILITY_SCROLL_SYSTEM:getRatio(name, abilityName)
    local index = ABILITY_SCROLL_SYSTEM:getIndexByName(name)
	local t = self.config[index]
	local ability = t.abilities[abilityName]
	
	return ability.value
end
	
function JEWEL_BOX_EVENT:getPlayer()
    if not self.participants then
	   return false
	end
	
	local id = self.participants.player
	if not id then
	   return false
	end
	local player = Player(id)
	if player then
	   return player
	end
	return false
end

function JEWEL_BOX_EVENT:getBoss()
    if not self.participants then
	   return false
	end
	
	local id = self.participants.boss
	if not id then
	   return false
	end
	local monster = Monster(id)
	if monster then
	   return monster
	end
	return false
end

function JEWEL_BOX_EVENT:addPlayer(player)
	if self:getPlayer() then
	   return false
	end
	
	if not self.participants then
	   self.participants = {}
	end
	
	self.participants.player = player:getId()
	
	local posTable = self.config["Boss"]["Positions"]["Teleport"]
	local x = posTable.x
	local y = posTable.y
	local z = posTable.z
    local pos = Position(x, y, z)
    player:teleportTo(pos)
    pos:sendMagicEffect(CONST_ME_TELEPORT)	
	return true
end

function JEWEL_BOX_EVENT:addBoss()
	local monster = self:getBoss()
	if monster then
	   monster:remove()
	end
	   	
	if not self.participants then
	   self.participants = {}
	end
	
	local name = self.config["Boss"]["Name"]
	local posTable = self.config["Boss"]["Positions"]["Respawn"]
	local x = posTable.x
	local y = posTable.y
	local z = posTable.z
    local pos = Position(x, y, z)
	
	monster = Game.createMonster(name, pos)
	if not monster then
	   return false
	end
	self.participants.boss = monster:getId()
	return true
end

function JEWEL_BOX_EVENT:removePlayer(player)
    if not self.participants then
	   return false
	end
	self.participants.player = nil
	local posTable = self.config["Boss"]["Positions"]["Timeout"]
	local x = posTable.x
	local y = posTable.y
	local z = posTable.z
    local pos = Position(x, y, z)
    player:teleportTo(pos)
    pos:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

function JEWEL_BOX_EVENT:isPlayerParticipant(player)
    if not self.participants then
	   return false
	end
	
	local participantPlayer = JEWEL_BOX_EVENT:getPlayer()
	if participantPlayer then
	   if participantPlayer:getId() == player:getId() then
	      return true
	   end
	end
	return false
end

function JEWEL_BOX_EVENT:isEventMonster(name)
	for i, v in pairs(self.config["General"].monstersList) do
	    if v == name or v:lower() == name:lower() then
		   return true
		end
	end
	return false
end

function JEWEL_BOX_EVENT:getMonstersCount()
    if not self.config["Monsters"] then
       self.config["Monsters"] = 0
	end
	return self.config["Monsters"]
end
	
function JEWEL_BOX_EVENT:addMonster()
    if not self.config["Monsters"] then
	   self.config["Monsters"] = 0
	end
	self.config["Monsters"] = self.config["Monsters"] + 1
	return true
end

function JEWEL_BOX_EVENT:resetMonstersCount()
	self.config["Monsters"] = 0
	return true
end

function JEWEL_BOX_EVENT:processLoot(damageMap)
    for attackerId, damage in pairs(damageMap) do
        local tmpPlayer = Player(attackerId)
		local t = self.config["General"].monstersDrop
        if tmpPlayer then
		   local itemEx = Game.createItem(t.id, t.count)
		   if tmpPlayer:addItemEx(itemEx) ~= RETURNVALUE_NOERROR then
		      tmpPlayer:sendCancelMessage("You have looted an event jewel case but you do not have cap or space to take this.")
			  tmpPlayer:sendTextMessage(MESSAGE_INFO_DESCR, "You have looted an event jewel case but you do not have cap or space to take this.")
		   else
		      tmpPlayer:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)  
		   end
        end		   
		   --dakosLib:addReward(tmpPlayer, t, false, false, true, false)
		   --tmpPlayer:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	end
    return true
end

local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function JEWEL_BOX_EVENT:getAvaibleExchanges()
	local str = ""
	local t = self.config["NPC"]
	local length = tablelength(t)
	local index = 1
	for i, v in pairs(t) do
	    str = str .. "{" .. getItemName(i) .. "}"
		if index == length then
		   str = str .. "."
		else
		   str = str .. ", "
		end
		index = index + 1
	end
	return str
end

function JEWEL_BOX_EVENT:processReward(player, t)
    
	local list = {}
	
	for i, v in pairs(t) do
		if not v.chance then
		   v.chance = 100
		end
	    table.insert(list, v)
    end
	
	table.sort(list, function(a, b) return a.chance < b.chance end)
	
	local list2 = {}
	local attempts = 0
	while #list2 == 0 and attempts < 99 do
	    local lastChance = 0
	    local rand = math.random(0, 100)		
	    for i, v in pairs(list) do
			local chance = v.chance
		    if not chance then
		       chance = 100
		    end
		    if chance < 1 then
		       chance = chance * 100
		    end	
			
			if rand <= chance then
			   if lastChance == 0 or v.chance <= lastChance then
			      list2[#list2 + 1] = v
				  lastChance = v.chance
			   end
			end
		end
		attempts = attempts + 1
	end
	
	local rewardTable = nil
	if #list2 == 0 then
	   rewardTable = list[math.random(#list)]
	else
	   table.sort(list2, function(a, b) return a.chance < b.chance end)
	   rewardTable = list2[math.random(#list2)]
	end
	
	
	local t2 = {}
	table.insert(t2, rewardTable)
	return t2
end

function JEWEL_BOX_EVENT:getTimeString()
    local total_seconds = Game.getStorageValue(JEWEL_BOX_EVENT.bossStorageTime) - os.time()
    local time_days     = math.floor(total_seconds / 86400)
    local time_hours    = math.floor(mod(total_seconds, 86400) / 3600)
    local time_minutes  = math.floor(mod(total_seconds, 3600) / 60)
    local time_seconds  = math.floor(mod(total_seconds, 60))
	
	if os.time() > Game.getStorageValue(JEWEL_BOX_EVENT.bossStorageTime) then
	   return false
	end

	local timestring = ""
	if time_days == 0 then
	   timestring = time_hours .. " Hours" .. ", " .. time_minutes .. " Minutes" .. " and " .. time_seconds .. " seconds."
	end
	
	if time_hours == 0 then
	   timestring = time_minutes .. " Minutes" .. " and " .. time_seconds .. " seconds."
	end
	
	if time_minutes == 0 then
	   timestring = time_seconds .. " seconds."
	end

	return timestring
end

function JEWEL_BOX_EVENT:getTime()
    local total_seconds = Game.getStorageValue(JEWEL_BOX_EVENT.bossStorageTime) - os.time()
	local seconds  = math.floor(mod(total_seconds, 60))
    local minutes  = math.floor(mod(total_seconds, 3600) / 60)
    		
	local values = { ["Minutes"] = minutes, ["Seconds"] = seconds }
	return values
end

function JEWEL_BOX_EVENT:setTime()
    local interval = JEWEL_BOX_EVENT.config["Boss"]["Scheduler"]["Kick"]
    Game.setStorageValue(JEWEL_BOX_EVENT.bossStorageTime, os.time() + interval * 60)
end

function JEWEL_BOX_EVENT:kickPlayerSchedule()
   
   local participant = self:getPlayer()
   if not participant then
      return false
   end
   
   local second = 0
   if DEVELOPER_MODE then
      second = 100
	  else
	  second = 1000
   end
   
   id = participant:getId()
   
   participant:sendTextMessage(MESSAGE_STATUS_WARNING, "You will be teleported from boss lair in 5 minutes.")
   
   addEvent(function()
   local player = Creature(id)
   if player then
      player:sendTextMessage(MESSAGE_STATUS_WARNING, "You will be teleported from boss lair in 3 minutes.")
   end
   end, 2 * second * 60)
   
   addEvent(function()
   local player = Creature(id)
   if player then
      player:sendTextMessage(MESSAGE_STATUS_WARNING, "You will be teleported from boss lair in 2 minutes.")
   end
   end, 3 * second * 60)

   addEvent(function()
   local player = Creature(id)
   if player then
      player:sendTextMessage(MESSAGE_STATUS_WARNING, "You will be teleported from boss lair in 1 minute.")
   end
   end, 4 * second * 60)
   
   addEvent(function()
      local player = Creature(id)
      if player then
         self:removePlayer(player)
      end
	end, 5 * second * 60)
end

function JEWEL_BOX_EVENT:addStatues()
    
	local t = self.config["Boss"]
	--for i = 1, #t do
	    local schedulerTable = t["Scheduler"]
		if schedulerTable then
	       local statueTable = schedulerTable["Statue"]
		   if statueTable then
		      local enabled = statueTable.enabled
		      if enabled then
		         local id = statueTable.id
		         local posTable = statueTable.position
		         local pos = Position(posTable.x, posTable.y, posTable.z)
		         if pos then
		            local tile = Tile(pos)
			        if tile then
			           local statue = tile:getItemById(id)
				       if not statue then
				          statue = Game.createItem(id, 1, pos)
			           end
					end
			     end
			  end
		  end
       end
	--end
	
end

function JEWEL_BOX_EVENT:addRewards(container, t, returnStringOnly, highLight, skipChance, multiTable)
    
	if not t then
	   return nil
	end
	
	local items = { }
	local itemsEx = {}
	local itemsStackable = {}
	local outfitScrolls = {}
	local abilityScrolls = {}
	local keys = {}

	
	local _itemsDisplayed = false
	local _outfitScrollsDisplayed = false
	local _abilityScrollsDisplayed = false
	local _keysDisplayed = false
	
	local canContinue = true
	local displayThings = 0
	local str = ""
	
	
	if multiTable then
	    for multi, t in pairs(multiTable) do
	    for index, v in pairs(t) do
		local chance = v.chance
		if not chance or skipChance then
		   chance = 100
		end
		if chance < 1 then
		   chance = chance * 100
		end
		
		
	    if v.type == "item" then
	       local id = v.itemid
		   if not id then
		      id = v.id
		   end
		   if not id then
		      id = dakosLib:getItemIdByName(v.name)
		   end
		   local count = v.count
		   local values = { ["id"] = id, ["count"] = count }
		   local chance = v.chance
		   local name = getItemName(id)
		   if not chance or skipChance then
		      chance = 100
		   end
		   if chance < 1 then
		      chance = chance * 100
		   end		
		   local rand = math.random(0, 100)
		   if rand <= chance then			  
			  local itemEx = Game.createItem(id, count)
			  if container:addItemEx(itemEx, false) > 0 then
			     canContinue = false
			  else
			     local itemtype = ItemType(id)
				 if itemtype:isStackable() then
				    table.insert(itemsStackable, values)
			     else
			        table.insert(itemsEx, itemEx)
			     end
			  end
		   end
		   table.insert(items, values)
		   if not _itemsDisplayed then
		      displayThings = displayThings + 1
			  _itemsDisplayed = true
		      end
		elseif v.type == "outfit scroll" then
           local name = v.name
           local addon = v.addon
           if not addon then
              addon = 0
           end
		   local chance = v.chance
		   if not chance or skipChance then
		      chance = 100
		   end
		   if chance < 1 then
		      chance = chance * 100
		   end
		   local values = { ["name"] = name, ["addon"] = addon }
		   local rand = math.random(0, 100)
		   if rand <= chance then
		      local itemEx = ADDON_SCROLL_SYSTEM:generateScroll(name, container, addon)
			  if container:addItemEx(itemEx, false) > 0 then
			     canContinue = false
			  else
			     table.insert(itemsEx, itemEx)
		      end
		      table.insert(outfitScrolls, values)
		      if not _outfitScrollsDisplayed then
		         displayThings = displayThings + 1
			     _outfitScrollsDisplayed = true
		      end
		   end			
		elseif v.type == "ability scroll" then
           local name = v.name
		   local chance = v.chance
		   if not chance or skipChance then
		      chance = 100
		   end
		   if chance < 1 then
		      chance = chance * 100
		   end
		   local values = { ["name"] = name }
		   local rand = math.random(0, 100)
		   if rand <= chance then
		      local itemEx = ABILITY_SCROLL_SYSTEM:generateScroll(name)
			  if container:addItemEx(itemEx, false) > 0 then
			     canContinue = false
			  else
			     table.insert(itemsEx, itemEx)
		      end			  
		      table.insert(abilityScrolls, values)
		      if not _abilityScrollsDisplayed then
		         displayThings = displayThings + 1
			     _abilityScrollsDisplayed = true
		      end
		   end        
	    elseif v.type == "key" then
	       local id = v.itemid
		   if not id then
		      id = v.id
		   end
		   if not id then
		      id = dakosLib:getItemIdByName(v.name)
		   end
		   
		   local count = 1

		   local values = { ["id"] = id, ["count"] = count, ["actionid"] = v.actionid, ["name"] = v.name, ["description"] = v.description }
		   local chance = v.chance
		   if not chance or skipChance then
		      chance = 100
		   end
		   if chance < 1 then
		      chance = chance * 100
		   end
		   local rand = math.random(0, 100)
		   if rand <= chance then
		      local itemEx = dakosLib:generateKey(id, v.actionid, v.name, v.description)
			  if container:addItemEx(itemEx, false) > 0 then
			     canContinue = false
			  else
			     table.insert(itemsEx, itemEx)
		      end		   
		      table.insert(keys, values)
		      if not _keysDisplayed then
		         displayThings = displayThings + 1
			     _keysDisplayed = true
		      end
		    end		
		end
    end	    
		
		end
    else
	    for index, v in pairs(t) do
		local chance = v.chance
		if not chance or skipChance then
		   chance = 100
		end
		if chance < 1 then
		   chance = chance * 100
		end
		
		
	    if v.type == "item" then
	       local id = v.itemid
		   if not id then
		      id = v.id
		   end
		   if not id then
		      id = dakosLib:getItemIdByName(v.name)
		   end
		   local count = v.count
		   local values = { ["id"] = id, ["count"] = count }
		   local chance = v.chance
		   local name = getItemName(id)
		   if not chance or skipChance then
		      chance = 100
		   end
		   if chance < 1 then
		      chance = chance * 100
		   end		
		   local rand = math.random(0, 100)
		   if rand <= chance then		  
			  local itemEx = Game.createItem(id, count)
			  if container:addItemEx(itemEx, false) > 0 then
			     canContinue = false
			  else
			     local itemtype = ItemType(id)
				 if itemtype:isStackable() then
				    table.insert(itemsStackable, values)
			     else
			        table.insert(itemsEx, itemEx)
			     end
			  end
		   end
		   table.insert(items, values)
		   if not _itemsDisplayed then
		      displayThings = displayThings + 1
			  _itemsDisplayed = true
		      end
		elseif v.type == "outfit scroll" then
           local name = v.name
           local addon = v.addon
           if not addon then
              addon = 0
           end
		   local chance = v.chance
		   if not chance or skipChance then
		      chance = 100
		   end
		   if chance < 1 then
		      chance = chance * 100
		   end
		   local values = { ["name"] = name, ["addon"] = addon }
		   local rand = math.random(0, 100)
		   if rand <= chance then
		      local itemEx = ADDON_SCROLL_SYSTEM:generateScroll(name, container, addon)
			  if container:addItemEx(itemEx, false) > 0 then
			     canContinue = false
			  else
			     table.insert(itemsEx, itemEx)
		      end
		      table.insert(outfitScrolls, values)
		      if not _outfitScrollsDisplayed then
		         displayThings = displayThings + 1
			     _outfitScrollsDisplayed = true
		      end
		   end			
		elseif v.type == "ability scroll" then
           local name = v.name
		   local chance = v.chance
		   if not chance or skipChance then
		      chance = 100
		   end
		   if chance < 1 then
		      chance = chance * 100
		   end
		   local values = { ["name"] = name }
		   local rand = math.random(0, 100)
		   if rand <= chance then
		      local itemEx = ABILITY_SCROLL_SYSTEM:generateScroll(name)
			  if container:addItemEx(itemEx, false) > 0 then
			     canContinue = false
			  else
			     table.insert(itemsEx, itemEx)
		      end			  
		      table.insert(abilityScrolls, values)
		      if not _abilityScrollsDisplayed then
		         displayThings = displayThings + 1
			     _abilityScrollsDisplayed = true
		      end
		   end        
	    elseif v.type == "key" then
	       local id = v.itemid
		   if not id then
		      id = v.id
		   end
		   if not id then
		      id = dakosLib:getItemIdByName(v.name)
		   end
		   
		   local count = 1

		   local values = { ["id"] = id, ["count"] = count, ["actionid"] = v.actionid, ["name"] = v.name, ["description"] = v.description }
		   local chance = v.chance
		   if not chance or skipChance then
		      chance = 100
		   end
		   if chance < 1 then
		      chance = chance * 100
		   end
		   local rand = math.random(0, 100)
		   if rand <= chance then
		      local itemEx = dakosLib:generateKey(id, v.actionid, v.name, v.description)
			  if container:addItemEx(itemEx, false) > 0 then
			     canContinue = false
			  else
			     table.insert(itemsEx, itemEx)
		      end		   
		      table.insert(keys, values)
		      if not _keysDisplayed then
		         displayThings = displayThings + 1
			     _keysDisplayed = true
		      end
		    end		
		
		
		
		end
    end
	
    end	
	
	
	
	for q, n in pairs(itemsEx) do
	    n:remove()
    end
	
	for q, n in pairs(itemsStackable) do
	    local id = n.id
		local count = n.count
		container:removeItem(id, count)
    end
	

	if not canContinue then
	   return false
	end
	
	if #items > 0 then
	  --local backpack = player:addItem(1998)
	  for index, item in pairs(items) do
	      local id = item.id
	      local count = item.count
		  if not returnStringOnly then
		     local itemEx = Game.createItem(id, count)
			 container:addItemEx(itemEx, false)
		  end
		  if #items == index then
	         --str = str .. count .. "x " .. getItemName(id)
			 str = str .. count .. "x "
			 if highLight then
			    str = str .. "{" 
		     end
			 str = str .. getItemName(id)
			 if highLight then
			    str = str .. "}" 
		     end			 
		  else
		     str = str .. count .. "x "
			 if highLight then
			    str = str .. "{" 
		     end
			 str = str .. getItemName(id)
			 if highLight then
			    str = str .. "}" 
		     end
		     str = str .. ", "
		  end
	   end
	    displayThings = displayThings - 1
	    if displayThings == 0 then
	       str = str .. "."
	    else
	       str = str .. ", "
        end
	end
	
	if #outfitScrolls > 0 then
	    for index, scroll in pairs(outfitScrolls) do
	        local name = scroll.name
	        local addon = scroll.addon
		    if not returnStringOnly then
		       local itemEx = ADDON_SCROLL_SYSTEM:generateScroll(name, container, addon)
			   container:addItemEx(itemEx, false)
		    end
		    --if not string.find(str, name) then
            
			if highLight then
			   str = str .. "{" 
			end
			str = str .. "outfit scroll" .. "(" .. name .. ")"
			if highLight then
			   str = str .. "}"
			end
			if #outfitScrolls ~= index then
			   str = str .. ", "
			end
        end
			
	    displayThings = displayThings - 1
	    if displayThings == 0 then
	       str = str .. "."
	    else
	       str = str .. ", "
        end
	end
	
	if #abilityScrolls > 0 then
	    for index, scroll in pairs(abilityScrolls) do
	        local name = scroll.name
		    if not returnStringOnly then
			   local itemEx = ABILITY_SCROLL_SYSTEM:generateScroll(name)
		       container:addItemEx(itemEx, false)
		    end
		    name = name:lower()
		    if highLight then
		       str = str .. "{" 
		    end
		    str = str .. name 
		    if highLight then
			   str = str .. "}" 
		    end		  
		    if #abilityScrolls ~= index then
		       str = str .. ", "
	        end
	    end
	    displayThings = displayThings - 1
	    if displayThings == 0 then
	       str = str .. "."
	    else
	       str = str .. ", "
        end
	end
	
	if #keys > 0 then
	   for index, key in pairs(keys) do
	       local id = key.id
	       local count = key.count
		   local actionid = key.actionid
		   local name = key.name
		   local description = key.description
		   if not returnStringOnly then
		      local itemEx = dakosLib:generateKey(id, actionid, name, description)
			  container:addItemEx(itemEx, false)
		   end
		   name = name:lower()
		   if highLight then
		      str = str .. "{" 
		   end
		      str = str .. name 
		   if highLight then
			  str = str .. "}" 
		   end		  
		   if #keys ~= index then
		       str = str .. ", "
	       end
	    end
	    displayThings = displayThings - 1
	    if displayThings == 0 then
	       str = str .. "."
	    else
	       str = str .. ", "
        end
	end
	
	
	return str
end	
		
		
	
	
	
	


local creaturescript = CreatureEvent("onDeath_JEWEL_BOX_EVENT")
function creaturescript.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
    
	if creature:isPlayer() then
	   if JEWEL_BOX_EVENT:isPlayerParticipant(creature) then
	      JEWEL_BOX_EVENT:removePlayer(creature)
	   end
	   return true
	end
	
	local boss = JEWEL_BOX_EVENT:getBoss()
	if boss then
	    if boss:getId() == creature:getId() then
	       JEWEL_BOX_EVENT:kickPlayerSchedule()
	    end
	    return true
    end
	
	
	local name = creature:getName()
	if not JEWEL_BOX_EVENT:isEventMonster(name) then
	   return true
	end
	
	local jewelConfig = JEWEL_BOX_EVENT.config["General"]
	
	
	for attackerId, damage in pairs(creature:getDamageMap()) do
        local tmpPlayer = Player(attackerId)
		local t = jewelConfig.monstersDrop
        if tmpPlayer then
		   local chance = t.chance 
		   if chance < 1 then
		      chance = chance * 1000
		   end
		   local rand = math.random(0, 1000)
		   if rand <= chance then
		      local itemEx = Game.createItem(t.id, t.count)
		      if tmpPlayer:addItemEx(itemEx) ~= RETURNVALUE_NOERROR then
		         tmpPlayer:sendCancelMessage("You have looted an event jewel case but you do not have cap or space to take this.")
			     tmpPlayer:sendTextMessage(MESSAGE_INFO_DESCR, "You have looted an event jewel case but you do not have cap or space to take this.")
		      else
		         tmpPlayer:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)  
		      end
		    end
        end
    end		
		
	
	-- JEWEL_BOX_EVENT:addMonster()
	-- local count = JEWEL_BOX_EVENT:getMonstersCount()
	-- --print("Monsters Count To Process Loot: " .. count)
	-- local maxKills = JEWEL_BOX_EVENT.config["General"].monstersToKill
	-- if count >= maxKills then
	   -- local damageMap = creature:getDamageMap()
	   -- JEWEL_BOX_EVENT:processLoot(damageMap)
	   -- JEWEL_BOX_EVENT:resetMonstersCount()
	-- end
	
	
	return true
end
creaturescript:register()

local creatureevent = CreatureEvent("onHealthChange_JEWEL_BOX_EVENT")
function creatureevent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	    if not attacker or not creature then
	       return primaryDamage, primaryType, secondaryDamage, secondaryType
	    end
	   
	    local ratio = 0
	    if attacker:isPlayer() then
	        local damageBoost = ABILITY_SCROLL_SYSTEM:getBoostStorage(attacker, "increaseDamage")
		    if damageBoost then
		       ratio = ratio + ABILITY_SCROLL_SYSTEM:getRatio("Scroll of Damage", "increaseDamage")
		    end
		end 

		if creature:isPlayer() then
		   local protectionBoost = ABILITY_SCROLL_SYSTEM:getBoostStorage(creature, "increaseProtection")
		   if protectionBoost then
			  ratio = ratio - ABILITY_SCROLL_SYSTEM:getRatio("Floki Scroll", "increaseProtection")
		   end
		end
		
		if ratio > 0 then
		   primaryDamage = primaryDamage + (primaryDamage * ratio)
		   secondaryDamage = secondaryDamage + (secondaryDamage * ratio)
        elseif ratio ~= 0 then
		   primaryDamage = primaryDamage - (primaryDamage * ratio)
		   secondaryDamage = secondaryDamage - (secondaryDamage * ratio)
		end
		
   return primaryDamage, primaryType, secondaryDamage, secondaryType
end
creatureevent:register()

creaturescript = CreatureEvent("onLogin_JEWEL_BOX_EVENT")
function creaturescript.onLogin(player)
   player:registerEvent("onHealthChange_JEWEL_BOX_EVENT")
   player:registerEvent("onDeath_JEWEL_BOX_EVENT")
   return true
end
creaturescript:register()

creaturescript = CreatureEvent("onLogout_JEWEL_BOX_EVENT")
function creaturescript.onLogin(player)
   if JEWEL_BOX_EVENT:isPlayerParticipant(player) then
      JEWEL_BOX_EVENT:removePlayer(player)
   end
   return true
end
creaturescript:register()


local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
	local t = EXERCISE_WEAPON_BOX.config
	local processReward = JEWEL_BOX_EVENT:processReward(player, t)
	local rewardString = dakosLib:addReward(player, processReward, false, true, true, false, true, false, true)
	 --npcHandler:say("Congratulations! You have received " .. rewardString, npc, player)
	dakosLib:addReward(player, processReward, false, false, true, false, false, false, true)
	
	
	player:sendCancelMessage("You have got " .. rewardString .. " from training weapon box.")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got " .. rewardString .. " from training weapon box.")
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	item:remove(1)
	
    return true
end
action:id(EXERCISE_WEAPON_BOX.itemid)
action:register()



action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local index = item:getCustomAttribute(ABILITY_SCROLL_SYSTEM.customAttribute.index)
	local t = ABILITY_SCROLL_SYSTEM.config[index]
	
	local abilitiesTable = t.abilities
	for i, v in pairs(abilitiesTable) do
	    if not ABILITY_SCROLL_SYSTEM:addBoost(player, i, v) then
		   return true
		end
	end
	
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	item:remove(1)
	return true
end
action:aid(ABILITY_SCROLL_SYSTEM.aid)
action:register()

action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
	local index = item:getCustomAttribute(ADDON_SCROLL_SYSTEM.customAttribute.index)
	local t = ADDON_SCROLL_SYSTEM.config[index]
	local male = t.male
	local female = t.female
	local addons = item:getCustomAttribute(ADDON_SCROLL_SYSTEM.customAttribute.addons)
	local name = t.name
	
	if addons == 0 then
	   if player:hasOutfit(male) or player:hasOutfit(female) then
	      player:sendCancelMessage("Sorry, You have already this outfit.")
		  return true
	   end
	   
	elseif addons > 0 then    
	   if player:hasOutfit(male, addons) or player:hasOutfit(female, addons) then
	      player:sendCancelMessage("Sorry, You have already this addon for this outfit.")
		  return true
	   end
	end
    
	local str = "You have received "
	if addons == 0 then
	   str = str .. name .. " outfit."
	   player:addOutfit(male)
	   player:addOutfit(female)
	elseif addons == 1 then
	   str = str .. name .. " first addon."
	   player:addOutfitAddon(male, 1)
	   player:addOutfitAddon(female, 1)
	elseif addons == 2 then
	   str = str .. name .. " second addon."
	   player:addOutfitAddon(male, 2)
	   player:addOutfitAddon(female, 2)
	elseif addons == 3 then
 	   str = str .. name .. " full addon."
	   player:addOutfitAddon(male, 3)
	   player:addOutfitAddon(female, 3)      	
	end
	
	
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	item:remove()
    return false
end
action:aid(ADDON_SCROLL_SYSTEM.aid)
action:register()

action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
	local t = JEWEL_BOX_EVENT.config["Boss"]
	local posTable = t["Positions"]["Entrace"]
	local x = posTable.x
	local y = posTable.y
	local z = posTable.z
	local pos = Position(x, y, z)
	-- if toPosition ~= pos then
	   -- return true
	-- end
	
	
	if JEWEL_BOX_EVENT:getPlayer() then
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "Another warrior is fighting with this boss" .. "\n" .. "Timeleft: " .. JEWEL_BOX_EVENT:getTimeString())
	   return true
	end
	
	local name = t["Name"]
	
	JEWEL_BOX_EVENT:setTime()
	JEWEL_BOX_EVENT:addPlayer(player)
	JEWEL_BOX_EVENT:addBoss()
	--JEWEL_BOX_EVENT:kickPlayerSchedule()
	--JEWEL_BOX_EVENT:addBoss()
	--JEWEL_BOX_EVENT:teleportPlayer()
	fromPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have entered to " .. name:lower() .. " lair.")
	item:remove()
	
    return false
end
action:aid(5752)
action:register()

local globalevent = GlobalEvent("load_JEWEL_BOX_EVENT")
function globalevent.onStartup()
	JEWEL_BOX_EVENT:addStatues()
end
globalevent:register()

globalevent = GlobalEvent("JEWEL_BOX_EVENT_displayTimer")
function globalevent.onThink(interval, lastExecution)
   	
	local t = JEWEL_BOX_EVENT.config["Boss"]
	--for i = 1, #t do
	    local player = JEWEL_BOX_EVENT:getPlayer()
		local boss = JEWEL_BOX_EVENT:getBoss()
		if player and boss then
	       local schedulerTable = t["Scheduler"]
		   if schedulerTable then
	          local statueTable = schedulerTable["Statue"]
		      if statueTable then
		         local enabled = statueTable.enabled
		         if enabled then
		            local posTable = statueTable.position
		            local pos = Position(posTable.x, posTable.y, posTable.z)
		            if pos then			 
		               local timeleft = JEWEL_BOX_EVENT:getTimeString()
					   if timeleft then
		                  Game.sendTextOnPosition("You have " .. timeleft .. " to kill this boss.", pos)
					   end
					end
			      end
			   end
			end
			if not JEWEL_BOX_EVENT:getTimeString() then
			   JEWEL_BOX_EVENT:removePlayer(player)
			end
		end
	--end
	
	

	return true
end
globalevent:interval(10 * 1000)
globalevent:register()