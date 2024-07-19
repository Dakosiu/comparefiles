BOSS24_SYSTEM_CONFIG = {
                         ["Bosses"] = {
						                [1] = {
										        ["Name"] = "Chaosgolem",
										        ["Positions"] = { 
												                  ["Teleport"] = { x = 1128, y = 1083, z = 8 },
																  ["Respawn"] = { x = 1137, y = 1093, z = 9 },
																  ["Exit"] = { x = 1128, y = 1082, z = 9 },
																  ["Timeout"] = { x = 1131, y = 1085, z = 8 }, 
																},
											    ["Scheduler"] = {
												                  ["Time"] = { type = "hours", value = 24 },
												                  ["Reminder"] = { enabled = true, seconds = 10 },
																  ["Kick"] = 30, -- w minutach
																  ["Statue"] = { 
																                 enabled = true, 
																				 id = 746,
																				 position = { x = 1133, y = 1091, z = 9 },
																			   }
																},
					                          },
						                [2] = {
										        ["Name"] = "Grieveserpent",
										        ["Positions"] = { 
												                  ["Teleport"] = { x = 1130, y = 1083, z = 8 },
																  ["Respawn"] = { x = 1164, y = 1092, z = 9 },
																  ["Exit"] = { x = 1166, y = 1068, z = 9},
																  ["Timeout"] = { x = 1131, y = 1085, z = 8 }
																},
											    ["Scheduler"] = {
												                  ["Time"] = { type = "hours", value = 24 },
												                  ["Reminder"] = { enabled = true, seconds = 10 },
																  ["Kick"] = 30, -- w minutach
																  ["Statue"] = { 
																                 enabled = true, 
																				 id = 746,
																				 position = { x = 1162, y = 1074, z = 9 },
																			   }
																},																
											  },		
						                [3] = {
										        ["Name"] = "Frightwraith",
										        ["Positions"] = { 
												                  ["Teleport"] = {x = 1132, y = 1083, z = 8},
																  ["Respawn"] = {x = 1196, y = 1096, z = 9},
																  ["Exit"] = {x = 1195, y = 1077, z = 9},
																  ["Timeout"] = { x = 1131, y = 1085, z = 8 }
																},
											    ["Scheduler"] = {
												                  ["Time"] = { type = "hours", value = 24 },
												                  ["Reminder"] = { enabled = true, seconds = 10 },
																  ["Kick"] = 30, -- w minutach
																  ["Statue"] = { 
																                 enabled = true, 
																				 id = 746,
																				 position = { x = 1198, y = 1079, z = 9 },
																			   }
																},															 
											  },		
						                [4] = {
										        ["Name"] = "Spectralpod",
										        ["Positions"] = { 
												                  ["Teleport"] = {x = 1134, y = 1083, z = 8},
																  ["Respawn"] = {x = 1240, y = 1097, z = 9},
																  ["Exit"] = {x = 1239, y = 1075, z = 9},
																  ["Timeout"] = { x = 1131, y = 1085, z = 8 }
																},
											    ["Scheduler"] = {
												                  ["Time"] = { type = "hours", value = 24 },
												                  ["Reminder"] = { enabled = true, seconds = 10 },
																  ["Kick"] = 30, -- w minutach
																  ["Statue"] = { 
																                 enabled = true, 
																				 id = 746,
																				 position = { x = 1236, y = 1096, z = 9 },
																			   }
																},																 
											  },												  
									  },
						["Missions"] = {
						                 [1] = {
										         ["Name"] = "Unlock entrace to Chaosgolem.",
											   },
										 [2] = {
										         ["Name"] = "Unlock entrace to Grieveserpent.",
												 ["Required"] = { 
												                  { type = "item", id = 29289, count = 1 },
																},
												 ["Required Monsters"] = {
                                                                          [1] = { name = "Chaosgolem", kills = 1 },
                                                                         },
											   },
										 [3] = {
										         ["Name"] = "Unlock entrace to Frightwraith.",
												 ["Required"] = { 
												                  { type = "item", id = 29287, count = 1 },
																},
												 ["Required Monsters"] = {
                                                                          [1] = { name = "Grieveserpent", kills = 1 },
                                                                         },
											   },		
										 [4] = {
										         ["Name"] = "Unlock entrace to Spectralpod.",
												 ["Required"] = { 
												                  { type = "item", id = 9642, count = 11 },
																},
												 ["Required Monsters"] = {
                                                                          [1] = { name = "Frightwraith", kills = 1 },
                                                                         },
											   },
										 [5] = {
										         ["Name"] = "Defeat finall boss.",
												 ["Required"] = { 
												                  { type = "item", id = 9642, count = 11 },
																},
												 ["Required Monsters"] = {
                                                                          [1] = { name = "Spectralpod", kills = 1 },
                                                                         },
												 ["Reward"] = {
												                { type = "item", id = 9642, count = 11 },
															  },
											   },											   
										}				 
					   }
					   
					   
					   
BOSS24_SYSTEM_CONFIG.aid = 233
BOSS24_SYSTEM_CONFIG.storages = {
                                  missionid = 3411,
								  timeleft = 56112,
								  kills = 4511,
								  access = 342,
								  teleport = "BOSS24_TELEPORT_TABLE"
								}
if not BOSS24_SYSTEM_CREATURES then
   BOSS24_SYSTEM_CREATURES = {}
end
								
BOSS24_SYSTEM = {}

function BOSS24_SYSTEM:getTimeString(index)
    local total_seconds = Game.getStorageValue(BOSS24_SYSTEM_CONFIG.storages.timeleft + index) - os.time()
    local time_days     = math.floor(total_seconds / 86400)
    local time_hours    = math.floor(mod(total_seconds, 86400) / 3600)
    local time_minutes  = math.floor(mod(total_seconds, 3600) / 60)
    local time_seconds  = math.floor(mod(total_seconds, 60))

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

function BOSS24_SYSTEM:getTime(index)
    local total_seconds = Game.getStorageValue(BOSS24_SYSTEM_CONFIG.storages.timeleft + index) - os.time()
	local seconds  = math.floor(mod(total_seconds, 60))
    local minutes  = math.floor(mod(total_seconds, 3600) / 60)
    		
	local values = { ["Minutes"] = minutes, ["Seconds"] = seconds }
	return values
end

function BOSS24_SYSTEM:setTime(index)
    local interval = BOSS24_SYSTEM_CONFIG["Bosses"][index]["Scheduler"]["Kick"]
    Game.setStorageValue(BOSS24_SYSTEM_CONFIG.storages.timeleft + index, os.time() + interval * 60)
end

function BOSS24_SYSTEM:getPlayerbyIndex(index)
    
	local t = BOSS24_SYSTEM_CREATURES["Players"]
	if not t then
	   return false
	end
	
	local id = t[index]
	if not id then
	   return false
	end   
	local creature = Creature(id)
	if creature then
	   return creature
	end
	return false
end

function BOSS24_SYSTEM:addPlayer(player, index)
	if not BOSS24_SYSTEM_CREATURES["Players"] then
	   BOSS24_SYSTEM_CREATURES["Players"] = {}
	end
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	local name = BOSS24_SYSTEM:getRequiredBossName(player, index):lower()
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have entered to " .. name .. " boss lair.")
	BOSS24_SYSTEM_CREATURES["Players"][index] = player:getId()
	BOSS24_SYSTEM:setExhaust(player, index)
end

function BOSS24_SYSTEM:removePlayer(index, teleport)
    
	local player = BOSS24_SYSTEM:getPlayerbyIndex(index)
	if not player then
	   return false
	end
	BOSS24_SYSTEM_CREATURES["Players"][index] = nil

	if teleport then
	   local t = BOSS24_SYSTEM_CONFIG["Bosses"][index]["Positions"]["Timeout"]
	   local pos = Position(t.x, t.y, t.z)
	   player:teleportTo(pos)
	end
end
	
function BOSS24_SYSTEM:addStatues()
    
	local t = BOSS24_SYSTEM_CONFIG["Bosses"]
	for i = 1, #t do
	    local schedulerTable = t[i]["Scheduler"]
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
	end
	
end

function BOSS24_SYSTEM:getMonsterbyIndex(index)
    
	local t = BOSS24_SYSTEM_CREATURES["Monsters"]
	if not t then
	   return false
	end
	
	local id = t[index]
	if not id then
	   return false
	end   
	local creature = Creature(id)
	if creature then
	   return creature
	end
	return false
end

function BOSS24_SYSTEM:addMonster(index)
    
	BOSS24_SYSTEM:removeMonster(index)
	
	local positionTable = BOSS24_SYSTEM_CONFIG["Bosses"][index]["Positions"]["Respawn"]
	local name = BOSS24_SYSTEM_CONFIG["Bosses"][index]["Name"]
	local pos = Position(positionTable.x, positionTable.y, positionTable.z)
	local creature = Game.createMonster(name, pos)
	if not creature then
	   return false
	end
	
	if not BOSS24_SYSTEM_CREATURES["Monsters"] then
	   BOSS24_SYSTEM_CREATURES["Monsters"] = {}
	end
	
	BOSS24_SYSTEM_CREATURES["Monsters"][index] = creature:getId()
	
end

function BOSS24_SYSTEM:removeMonster(index)
   
   	local creature = BOSS24_SYSTEM:getMonsterbyIndex(index)
	if creature then
	   creature:remove()
	end
end

function BOSS24_SYSTEM:getAccess(player, index)
    
	if player:getStorageValue(BOSS24_SYSTEM_CONFIG.storages.access + index) >= 1 then
	   return true
	end
	return false
end

function BOSS24_SYSTEM:setAccess(player, missionid, boolean)
    local value = 0
	if boolean then
       value = 1
	end

	player:setStorageValue(BOSS24_SYSTEM_CONFIG.storages.access + missionid, value)
	local name = BOSS24_SYSTEM:getRequiredBossName(player, missionid)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have unlocked entrace to " .. name:lower() .. " boss.")
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
end

function BOSS24_SYSTEM:addToQuestLog()
        
	local questIndex = 1
	while true do
		if (not Quests[questIndex]) then
			Quests[questIndex] = {
		      name = "Charmer Request",
		      startStorageId = BOSS24_SYSTEM_CONFIG.storages.missionid + 1,
              startStorageValue = -1,
			  missions = {}
			}
			break
		end
		questIndex = questIndex + 1
	end
	
	t = BOSS24_SYSTEM_CONFIG["Missions"]
	for i = 1, #t do
	    local bonusTable = BOSS24_SYSTEM_CONFIG.storages.missionid
		local requiredTable = t[i]["Required"]
		local killsTable = t[i]["Required Monsters"]
	    local values = {
		                 name = t[i].Name,
						 storageId = bonusTable + i,
			             missionId = bonusTable + i,
			             startValue = 1,
			             endValue = 4,
						 states = {
					                [1] = function(player)
									         return "Collect " .. BOSS24_SYSTEM:getRequiredString(i, 1)
										  end,
								    [2] = function(player)
									         return "Kill " .. BOSS24_SYSTEM:getMissingMonsters(player, i, false)
										  end,
								    [3] = "I have finished killing the bosses, i should visit the Charmer.",
									[4] = "Mission is complete.",
							      }
					   }
	    table.insert(Quests[questIndex].missions, values)
    end
end

function BOSS24_SYSTEM:getCurrentMission(player)
    
	local t = BOSS24_SYSTEM_CONFIG["Missions"]
	for i = 1, #t do
	    if player:getStorageValue(BOSS24_SYSTEM_CONFIG.storages.missionid + i) < 4 then
		   return i
		end
	end
	return false
end

function BOSS24_SYSTEM:getRequiredString(missionid, state)
    
	local key = BOSS24_SYSTEM_CONFIG.storages.missionid	
	if state == 1 then
	   local t = BOSS24_SYSTEM_CONFIG["Missions"][missionid]["Required"]
	   if not t then
	      return ""
	   end
	   return dakosLib:getRequiredThings(player, t, false)
	elseif state == 2 then
	   local t = BOSS24_SYSTEM_CONFIG["Missions"][missionid]["Required Monsters"]
	   return BOSS24_SYSTEM:getRequiredMonsters(t)
	end	
	return ""
end

function BOSS24_SYSTEM:prepare()
    
	for index, v in pairs(BOSS24_SYSTEM_CONFIG["Bosses"]) do
        local posTable = v["Positions"]
		if posTable then
		   local teleportTable = posTable["Teleport"]
		   if teleportTable then
		      local teleportPos = Position(teleportTable.x, teleportTable.y, teleportTable.z)
			  if teleportPos then
			     local tile = Tile(teleportPos)
				 if tile then
				    local items = tile:getItems()
					if items and #items > 0 then
					   for _, item in pairs(items) do
					       item:setCustomAttribute(BOSS24_SYSTEM_CONFIG.storages.missionid, index)
						   item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, BOSS24_SYSTEM_CONFIG.aid)
						   item:setCustomAttribute(BOSS24_SYSTEM_CONFIG.storages.teleport, "Teleport")
		               end
					end
				end
			 end
		   end
		   local teleportTable = posTable["Exit"]
		   if teleportTable then
		      local teleportPos = Position(teleportTable.x, teleportTable.y, teleportTable.z)
			  if teleportPos then
			     local tile = Tile(teleportPos)
				 if tile then
				    local items = tile:getItems()
					if items and #items > 0 then
					   for _, item in pairs(items) do
					       item:setCustomAttribute(BOSS24_SYSTEM_CONFIG.storages.missionid, index)
						   item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, BOSS24_SYSTEM_CONFIG.aid)
						   item:setCustomAttribute(BOSS24_SYSTEM_CONFIG.storages.teleport, "Exit")
		               end
					end
				end
			 end
		   end		   
		end
	end
end

function BOSS24_SYSTEM:getRequiredMonsters(t)
    local str = ""
	
	if not t then
	   return str
	end
	
	for i, v in pairs(t) do
	    local name = v.name
		local kills = v.kills
		str = str .. kills .. "x " .. name
		if i == 1 or i == #t then
		   str = str .. "."
		else
		   str = str .. ", "
		end
	end
	return str
end

function BOSS24_SYSTEM:getRequiredBossName(player, missionid)		
    
	local t = BOSS24_SYSTEM_CONFIG["Bosses"][missionid]
	
	if not t then
	   return false
	end
    return t["Name"]
end
   
function BOSS24_SYSTEM:setKillTask(player, missionid)
    
	local monsterTable = BOSS24_SYSTEM_CONFIG["Missions"][missionid]["Required Monsters"]
	
	for i = 1, #monsterTable do
	    local key = BOSS24_SYSTEM_CONFIG.storages.kills + i
		local kills = monsterTable[i].kills
		player:setStorageValue(key, kills)
	end
end

function BOSS24_SYSTEM:getMissingMonsters(player, missionid, highlight)
     
	local str = ""
	
	if not missionid then
	   return "EMPTY"
	end
	
	local monsterTable = BOSS24_SYSTEM_CONFIG["Missions"][missionid]["Required Monsters"]
	if not monsterTable then
	   return "EMPTY"
	end
	
	
	for i = 1, #monsterTable do
	    local key = BOSS24_SYSTEM_CONFIG.storages.kills + i
		local name = monsterTable[i].name
		local kills = monsterTable[i].kills
		local player_kills = player:getStorageValue(key)
		if player_kills > 0 then
		   if highlight then
		      str = str .. player_kills .. "x " .. "{" .. name .. "}"
		   else
		      str = str .. player_kills .. "x " .. name
		   end
		   if i == #monsterTable or #monsterTable == 1 then
		      str = str .. "."
		   else
		      str = str .. ", "
		   end
		end
	end
	
	if str == "" then
	   return "EMPTY"
	end
	
	return str
end
	
function BOSS24_SYSTEM:addKill(player, creature)
    local name = creature:getName()
	local index = BOSS24_SYSTEM:getIndexByName(name)
	BOSS24_SYSTEM:kickPlayer(index)
	
	local missionid = BOSS24_SYSTEM:getCurrentMission(player)
	if not missionid then
	   return
	end
	
	local key = BOSS24_SYSTEM_CONFIG.storages.missionid
	local state = dakosLib:getQuestLogMission(player, key, missionid)
	if not state == 2 then
	   return
	end
	
	if BOSS24_SYSTEM:getMissingMonsters(player, missionid, false) == "EMPTY" then
	   return
	end
	
	
	local monsterTable = BOSS24_SYSTEM_CONFIG["Missions"][missionid]["Required Monsters"]
	for i = 1, #monsterTable do
	    local creature_name = creature:getName()
		local name = monsterTable[i].name
		local key2 = BOSS24_SYSTEM_CONFIG.storages.kills + i
		if name:lower() == creature_name:lower() then
		   player:setStorageValue(key2, player:getStorageValue(key2) - 1)
		   BOSS24_SYSTEM:updateTracker(player, key + missionid)
		   if BOSS24_SYSTEM:getMissingMonsters(player, missionid, false) == "EMPTY" then
		      dakosLib:setQuestLogMission(player, key, missionid, state + 1)
		   end   
		   return true
		end
    end
end

function BOSS24_SYSTEM:updateTracker(player, key)

	local missions = player:getMissionsData(key)
	
	for i = 1, #missions do
		local mission = missions[i]
		if player:hasTrackingQuest(mission.missionId) then
		   player:sendUpdateTrackedQuest(mission)
		   player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your questlog has been updated.")
		end
	end
	
end

function BOSS24_SYSTEM:getIndexByName(name)
    
	local t = BOSS24_SYSTEM_CONFIG["Bosses"]
	for i = 1, #t do
	    if t[i]["Name"]:lower() == name:lower() then
		   return i
		end
	end
end

function BOSS24_SYSTEM:kickPlayer(index)
   
   local participant = BOSS24_SYSTEM:getPlayerbyIndex(index)
   local id = 0
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
         BOSS24_SYSTEM:removePlayer(index, true)
      end
	end, 5 * second * 60)
end

function BOSS24_SYSTEM:setExhaust(player, index)
    
	local t = BOSS24_SYSTEM_CONFIG["Bosses"][index]["Scheduler"]["Time"]
	local method = t.type
	local duration = t.value
    local interval = 0
    
    if string.find(method, "msecond") then
       interval = duration
    elseif string.find(method, "second") then
	   interval = duration * 1000
    elseif string.find(method, "minute") then
	   interval = duration * 60
    elseif string.find(method, "hour") then 
	   interval = duration * 60 * 60
    end 

	player:setStorageValue(BOSS24_SYSTEM_CONFIG.storages.timeleft + index, os.time() + interval)
end

function BOSS24_SYSTEM:getExhaust(player, index)
  
  if player:getStorageValue(BOSS24_SYSTEM_CONFIG.storages.timeleft + index) > os.time() then
     return true
  end
  
  return false
end

function BOSS24_SYSTEM:getExhaustString(player, index)
    local total_seconds = player:getStorageValue(BOSS24_SYSTEM_CONFIG.storages.timeleft + index) - os.time()
    local time_days     = math.floor(total_seconds / 86400)
    local time_hours    = math.floor(mod(total_seconds, 86400) / 3600)
    local time_minutes  = math.floor(mod(total_seconds, 3600) / 60)
    local time_seconds  = math.floor(mod(total_seconds, 60))

	local timestring = ""
	if time_days == 0 then
	   timestring = time_hours .. " Hours" .. ", " .. time_minutes .. " Minutes" .. " and " .. time_seconds .. " seconds."
	else
	   timestring = time_days .. " Days" .. ", " .. time_hours .. " Hours" .. ", " .. time_minutes .. " Minutes" .. " and " .. time_seconds .. " seconds."
	end
	
	if time_hours == 0 then
	   timestring = time_minutes .. " Minutes" .. " and " .. time_seconds .. " seconds."
	end
	
	if time_minutes == 0 then
	   timestring = time_seconds .. " seconds."
	end
	return timestring
end

creaturescript = CreatureEvent("BOSS24_SYSTEM_onDeath")
function creaturescript.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)	
    
    if not creature:isMonster() then
        return false
    end
	
    if creature:getMaster() ~= nil then
        return false
    end
	
    local player = Player(mostDamage)
	if not player then
	   return false
	end
		
	local party = player:getParty() 
	if party then
	   if party:isSharedExperienceEnabled() then
	      local members = party:getMembers()
		  if members then
			 for _, member in pairs(members) do
				BOSS24_SYSTEM:addKill(member, creature)
			 end
		  end
		  local leader = party:getLeader() 
		  if leader then
		     BOSS24_SYSTEM:addKill(leader, creature)
		  end
	   return true
	   end
	end
	
	BOSS24_SYSTEM:addKill(player, creature)
	return true
end
creaturescript:register()

local moveevent = MoveEvent()
moveevent:type("stepin")
function moveevent.onStepIn(creature, item, position, fromPosition)
    
	local player = Player(creature)
	
	if not player then
		return true
	end
    
	local index = item:getCustomAttribute(BOSS24_SYSTEM_CONFIG.storages.missionid)
	
	if item:getCustomAttribute(BOSS24_SYSTEM_CONFIG.storages.teleport) == "Exit" then
	   BOSS24_SYSTEM:removePlayer(index, false)
	   return true
	end
	
	if BOSS24_SYSTEM:getExhaust(player, index) then
	   local exhaustString = BOSS24_SYSTEM:getExhaustString(player, index) 
       player:sendTextMessage(MESSAGE_INFO_DESCR, "You have to wait: " .. exhaustString .. "\n" .. "before you can enter again.")
       player:teleportTo(fromPosition)	   
       return false
	end
	
	if not BOSS24_SYSTEM:getAccess(player, index) then
	   player:teleportTo(fromPosition)
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "You are not allowed to access this place.")
	   return false
	end
	
	local participant = BOSS24_SYSTEM:getPlayerbyIndex(index)
	if participant then
	   player:teleportTo(fromPosition)
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "Another warrior is fighting with this boss" .. "\n" .. "Timeleft: " .. BOSS24_SYSTEM:getTimeString(index))
	   return false
	end
	
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	BOSS24_SYSTEM:addMonster(index)
	BOSS24_SYSTEM:addPlayer(player, index)
	BOSS24_SYSTEM:setTime(index)
	
	return true
end
moveevent:aid(BOSS24_SYSTEM_CONFIG.aid)
moveevent:register()


local globalevent = GlobalEvent("load_BOSS24_SYSTEM")
function globalevent.onStartup()
	BOSS24_SYSTEM:addToQuestLog()
	BOSS24_SYSTEM:prepare()
	BOSS24_SYSTEM:addStatues()
end
globalevent:register()

globalevent = GlobalEvent("BOSS24_SYSTEM_displayTimer")
function globalevent.onThink(interval, lastExecution)
   	
	local t = BOSS24_SYSTEM_CONFIG["Bosses"]
	for i = 1, #t do
	    local player = BOSS24_SYSTEM:getPlayerbyIndex(i)
		local boss = BOSS24_SYSTEM:getMonsterbyIndex(i)
		if player and boss then
	       local schedulerTable = t[i]["Scheduler"]
		   if schedulerTable then
	          local statueTable = schedulerTable["Statue"]
		      if statueTable then
		         local enabled = statueTable.enabled
		         if enabled then
		            local posTable = statueTable.position
		            local pos = Position(posTable.x, posTable.y, posTable.z)
		            if pos then			 
		               local timeleft = BOSS24_SYSTEM:getTimeString(i)
		               Game.sendTextOnPosition("You have " .. timeleft .. " to kill this boss.", pos)
					end
			      end
			   end
			end
			if BOSS24_SYSTEM:getTimeString(i) == "" then
			   BOSS24_SYSTEM:removePlayer(i, true)
			end
		end
	end
	
	

	return true
end
globalevent:interval(10 * 1000)
globalevent:register()
   
local creatureevent = CreatureEvent("BOSS24_SYSTEM_onLogout")
function creatureevent.onLogout(player)
   
   	local t = BOSS24_SYSTEM_CONFIG["Bosses"]
	for i = 1, #t do
	    local participant = BOSS24_SYSTEM:getPlayerbyIndex(i)
		if participant then
		   if player:getId() == participant:getId() then
		      BOSS24_SYSTEM:removePlayer(i, true)
		   end
		end
	end
   
return true
end
creatureevent:register()