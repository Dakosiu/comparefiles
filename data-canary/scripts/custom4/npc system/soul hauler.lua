HELL_DESTINATION = { 1009, 1020, 7 }

HAULER_TASKS = {
                    [1] = { 
					        ["Reward"] = { 
							               --{ type = "experience", value = 100000 },
										   --{ type = "money", value = 50000 },
										 },
							
							["Required Items"] = { },
							
							["Required Statues"] = {
							                         [1] = { 918, 1124, 10 },
													 [2] = { 904, 1130, 10 },
													 [3] = { 897, 1147, 9 },
													 [4] = { 870, 1125, 10 },
													 [5] = { 860, 1137, 9 },
												   },
							   
						    ["Messages"] = {
							                  [1] = "Okay, You have to find and touch 5 demonic faces.",
											  [2] = "Did you finished your mission?",
											  [3] = "Congratulations, You have finished your first mission.",
										   }
						   },
                    [2] = { 
					        ["Reward"] = { 
										 },
							["Required Monster"] = { 
							                         name = "Demons",
							                         monsterCount = 3,
							                         monsterList = { "Demon", "Askarak Demon", "Askarak Lord", "Askarak Prince", "Shaburak Demon", "Shaburak Lord", "Shaburak Prince"  },
												   },
						    ["Messages"] = {
							                  [1] = "Okay, now you have to kill: ",
											  [2] = "Have you killed all ",
											  [3] = "Congratulations, You have finished your second mission.",
										   }
						   },
                    [3] = { 
					        ["Reward"] = { 
							               --{ type = "", id = 8300, count = 1 }
										 },
					        ["Required Items"] = { 
							                       { type = "item", id = 7393, count = 1, title = "You can obtain this item from demons task." },
												 },
						    ["Messages"] = {
							                  [1] = "Okay, your next mission is: bring ",
											  [2] = "Do you have all required items? ",
											  [3] = "Congratulations, You have finished this mission. Now you can travel to {hell} anytime.",
										   }
						   },	
                    [4] = { 
					        ["Reward"] = { 
							               --{ type = "", id = 8300, count = 1 }
										 },
							["Required Monster"] = { 
							                         name = "Morshabaals",
							                         monsterCount = 5,
							                         monsterList = { "Morshabaal" },
												   },
							-- ["Positions"] = {
							                  -- entry = { x = 872, y = 1123, z = 10 },
											  -- destination = { x = 843, y = 1122, z = 11 },
											  -- bossPosition = { x = 839, y = 1125, z = 11 },
											  -- exitPosition = { x = 843, y = 1121, z = 11 },
											  -- exitDestination = {x = 872, y = 1124, z = 10}
											-- },
						    ["Messages"] = {
							                  [1] = "Okay, now you have to kill: ",
											  [2] = "Have you killed all ",
											  [3] = "Congratulations, You have finished this mission.",
										   }
						   },
                    [5] = { 
					        ["Reward"] = { 
							               --{ type = "", id = 8300, count = 1 }
										 },
					        ["Required Items"] = { 
							                       { type = "item", id = 37810, count = 1, title = "You can obtain this item from morshabaal." },
												 },
						    ["Messages"] = {
							                  [1] = "Okay, your next mission is: bring ",
											  [2] = "Do you have all required items? ",
											  [3] = "Congratulations, You have finished this mission.",
										   }
						   },
                    [6] = { 
					        ["Reward"] = { 
							               --{ type = "", id = 8300, count = 1 }
										 },
							["Required Statues"] = {
							                         [1] = { 727, 1074, 10},
													 [2] = { 720, 1099, 9},
													 [3] = { 738, 1101, 9},
													 [4] = { 765, 1134, 10}
												   },
						    ["Messages"] = {
							                  [1] = "I see you are ready... Okay, now you have to find 4 infernal souls, touch them and back to me!",
											  [2] = "Did you finished your mission?",
											  [3] = "Congratulations, You have finished this mission. Now you can go to NPCNAME that allow you to discover the {hell} much deeper.",
										   }
						   },						   
				}
				
				
			
				   
haulerTask = { }
haulerTask.__newindex = haulerTask
haulerTask.bosses = {
                         ["Bosses"] = {
						                [1] = {
										        ["Name"] = "Morshabaal",
										        ["Positions"] = { 
												                  ["Teleport"] = { x = 872, y = 1123, z = 10 },
																  ["Respawn"] = { x = 839, y = 1125, z = 11 },
																  ["Exit"] = { x = 843, y = 1121, z = 11 },
																  ["Timeout"] = { x = 872, y = 1124, z = 10 }
																},
											    ["Scheduler"] = {
												                  ["Time"] = { type = "hours", value = 4 },
												                  ["Reminder"] = { enabled = true, seconds = 10 },
																  ["Kick"] = 1, -- w minutach
																  ["Statue"] = { 
																                 enabled = true, 
																				 id = 746,
																				 position = { x = 844, y = 1128, z = 11 }
																			   }
																},
					                          },
									  },								  
				    }
					
haulerTask.bossesConfig = {
                            timeleft = 16112,
							kills = 44511,
							access = 6800,
							teleport = "HAULER_BOSS_TELEPORT_TABLE",
                          }							
					
haulerTask.storage = 58873
haulerTask.aid = 6700
haulerTask.access = 6800
haulerTask.statues = 6900
haulerTask.bossAccess = {
                          key = "MORSHABAAL_BOSS_TELEPORT",
						  index = "MORSHABAAL_BOSS_INDEX",
						  exit = "MORSHABAAL_BOSS_EXIT",
						  storage = 412131
						}
haulerTask.infernalSouls = 50331

if not haulerTask.creatures then
   haulerTask.creatures = {}
end

function haulerTask:removeMonster(index)
   
   	local creature = haulerTask:getMonsterbyIndex(index)
	if creature then
	   creature:remove()
	end
end

function haulerTask:addBossStatues()
    
	local t = haulerTask.bosses["Bosses"]
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

function haulerTask:getMonsterbyIndex(index)
    
	local t = haulerTask.creatures["Monsters"]
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

function haulerTask:addMonster(index)
    
	haulerTask:removeMonster(index)
	
	local positionTable = haulerTask.bosses["Bosses"][index]["Positions"]["Respawn"]
	local name = haulerTask.bosses["Bosses"][index]["Name"]
	local pos = Position(positionTable.x, positionTable.y, positionTable.z)
	creature = Game.createMonster(name, pos)
	if not creature then
	   return false
	end
	
	if not haulerTask.creatures["Monsters"] then
	   haulerTask.creatures["Monsters"] = {}
	end
	
	haulerTask.creatures["Monsters"][index] = creature:getId()
	
end

function haulerTask:getTimeString(index)
    local total_seconds = Game.getStorageValue(haulerTask.bossesConfig.timeleft + index) - os.time()
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

function haulerTask:getTime(index)
    local total_seconds = Game.getStorageValue(haulerTask.bossesConfig.timeleft + index) - os.time()
	local seconds  = math.floor(mod(total_seconds, 60))
    local minutes  = math.floor(mod(total_seconds, 3600) / 60)
    		
	local values = { ["Minutes"] = minutes, ["Seconds"] = seconds }
	return values
end

function haulerTask:setTime(index)
    local interval = haulerTask.bosses["Bosses"][index]["Scheduler"]["Kick"]
    Game.setStorageValue(haulerTask.bossesConfig.timeleft + index, os.time() + interval * 60)
end

function haulerTask:kickPlayer(index)
   
   local participant = haulerTask:getPlayerbyIndex(index)
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
         haulerTask:removePlayer(index, true)
      end
	end, 5 * second * 60)
end

function haulerTask:getPlayerbyIndex(index)
    
	local t = haulerTask.creatures["Players"]
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

function haulerTask:addPlayer(player, index)
	if not haulerTask.creatures["Players"] then
	   haulerTask.creatures["Players"] = {}
	end
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	local name = haulerTask:getRequiredBossName(player, index):lower()
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have entered to " .. name .. " boss lair.")
	if not haulerTask.creatures["Players"][index] or haulerTask.creatures["Players"][index] ~= player:getId() then
	   haulerTask.creatures["Players"][index] = player:getId()
	end
	haulerTask:setExhaust(player, index)

end

function haulerTask:getRequiredBossName(player, index)		
    
	local t = haulerTask.bosses["Bosses"][index]
	
	if not t then
	   return false
	end
    return t["Name"]
end

function haulerTask:removePlayer(index, teleport)
    
	local player = haulerTask:getPlayerbyIndex(index)
	if not player then
	   return false
	end
	haulerTask.creatures["Players"][index] = nil

	if teleport then
	   local t = haulerTask.bosses["Bosses"][index]["Positions"]["Timeout"]
	   local pos = Position(t.x, t.y, t.z)
	   player:teleportTo(pos)
	end
end

function haulerTask:setExhaust(player, index)
    
	--local t = haulerTask.bosses["Bosses"][index]["Scheduler"]["Time"]
	local t = haulerTask.bosses["Bosses"][index]["Scheduler"]["Time"]
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

	player:setStorageValue(haulerTask.bossesConfig.timeleft + index, os.time() + interval)
end

function haulerTask:getExhaust(player, index)
  
  if player:getStorageValue(haulerTask.bossesConfig.timeleft + index) > os.time() then
     return true
  end
  
  return false
end

function haulerTask:getExhaustString(player, index)
    local total_seconds = player:getStorageValue(haulerTask.bossesConfig.timeleft + index) - os.time()
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

function haulerTask:teleport(player)
    if not player then
	   return nil
	end
	local x = HELL_DESTINATION[1]
	local y = HELL_DESTINATION[2]
	local z = HELL_DESTINATION[3]
	local destination = Position(x, y, z)
	if destination then
	   player:teleportTo(destination)
	   player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
end

function haulerTask:bossTeleport()
	
	local posTable = haulerTask.bosses["Bosses"][1]["Positions"]["Teleport"]
	if posTable then
	    local pos = Position(posTable.x, posTable.y, posTable.z)
		if pos then
		local tile = Tile(pos)
		  if tile then
		  	local ground = tile:getGround()
			-- if ground then
			   -- ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, haulerTask.access)
			   -- ground:setCustomAttribute(haulerTask.bossAccess.key, 1)
			   -- ground:setCustomAttribute(haulerTask.bossAccess.index, 1)
			   -- ground:setCustomAttribute(haulerTask.bossAccess.exit, 1)
			-- end
		    local items = tile:getItems()
			if items then
			   local item = items[1]
			   item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, haulerTask.access)
			   item:setCustomAttribute(haulerTask.bossAccess.key, 1)
			   item:setCustomAttribute(haulerTask.bossAccess.index, 1)
			   end
			end
		end
	end
	posTable = haulerTask.bosses["Bosses"][1]["Positions"]["Exit"]
	if posTable then
	    local pos = Position(posTable.x, posTable.y, posTable.z)
		if pos then
		local tile = Tile(pos)
		  if tile then
		    local items = tile:getItems()
			if items then
			   local item = items[1]
			   item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, haulerTask.access)
			   item:setCustomAttribute(haulerTask.bossAccess.key, 1)
			   item:setCustomAttribute(haulerTask.bossAccess.index, 1)
			   item:setCustomAttribute(haulerTask.bossAccess.exit, 1)
			   end
			end
		end
	end	
end
	   
function haulerTask:getMonstersName()
    local str = ""
	
	for index, name in pairs(HAULER_TASKS[2]["Required Monster"].monsterList) do
	    if index == #HAULER_TASKS[2]["Required Monster"].monsterList then
	       str = str .. name
		else
		   str = str .. name .. ", "
		end
    end
	
	return str
end

function haulerTask:addStatues()
	for index, config in pairs(HAULER_TASKS[1]["Required Statues"]) do
	    local x = config[1]
		local y = config[2]
		local z = config[3]
		local pos = Position(x, y, z)
		if pos then
		   local tile = Tile(pos)
		   if tile then
		      local items = tile:getItems()
			  if items then
			     for i, item in pairs(items) do
				     item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, haulerTask.statues)
					 item:setCustomAttribute("DEMONIC_STATUES_INDEX", index)
			     end
			  end
			end
	    end
   end
end

function haulerTask:addInfernalSouls()
	for index, config in pairs(HAULER_TASKS[6]["Required Statues"]) do
	    local x = config[1]
		local y = config[2]
		local z = config[3]
		local pos = Position(x, y, z)
		if pos then
		   local tile = Tile(pos)
		   if tile then
		      local items = tile:getItems()
			  if items then
			     for i = 1, #items do
				     local item = items[i]
				     item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, haulerTask.statues)
					 item:setCustomAttribute("INFERNAL_SOUL", index)
			     end
			  end
			end
	    end
   end
end

function haulerTask:setStatuesQuest(player)
    if not player then
	   return nil
	end
    local count = #HAULER_TASKS[1]["Required Statues"]
	return player:setStorageValue(haulerTask.storage + 50, count)
end

function haulerTask:setInfernalSoulsQuest(player)
    if not player then
	   return nil
	end
    local count = #HAULER_TASKS[6]["Required Statues"]
	return player:setStorageValue(haulerTask.storage + 30, count)
end

function haulerTask:getStatues(player)
    if not player then
	   return nil
	end
	return player:getStorageValue(haulerTask.storage + 50)
end

function haulerTask:setStatues(player)
    if not player then
	   return nil
	end
    local count = #HAULER_TASKS[1]["Required Statues"]
	return player:setStorageValue(haulerTask.storage + 50, haulerTask:getStatues(player) - 1)
end

function haulerTask:setInfernalSouls(player)
    if not player then
	   return nil
	end
    local count = #HAULER_TASKS[6]["Required Statues"]
	return player:setStorageValue(haulerTask.storage + 30, haulerTask:getInfernalSouls(player) - 1)
end

function haulerTask:getInfernalSouls(player)
    if not player then
	   return nil
	end
	return player:getStorageValue(haulerTask.storage + 30)
end
	
function haulerTask:updateTracker(player, key, logg)
    
	if logg then
	end
	
	local missions = player:getMissionsData(key)
	
	for i = 1, #missions do
		local mission = missions[i]
		if player:hasTrackingQuest(mission.missionId) then
		   player:sendUpdateTrackedQuest(mission)
		   player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your questlog has been updated.")
		end
	end
	
end

function haulerTask:getKills(player)
    local storage = haulerTask.storage - 100
	
	if player:getStorageValue(storage) < 0 then
	   return -1
	end
	
	return player:getStorageValue(storage)
end

function haulerTask:getKillTask(index)
        
    local str = ""
    
    local name = HAULER_TASKS[index]["Required Monster"].name
	local count = HAULER_TASKS[index]["Required Monster"].monsterCount
	
	str = str .. count .. " " .. name
	
	return str
end

function haulerTask:setKillTask(player, index)
	local storage = haulerTask.storage - 100
	local count = HAULER_TASKS[index]["Required Monster"].monsterCount
	return player:setStorageValue(storage, count)
end
   
function haulerTask:setKills(player)
    local storage = haulerTask.storage - 100
	
	if player:getStorageValue(storage) <= 0 then
	   return
	end
	
	return player:setStorageValue(storage, player:getStorageValue(storage) - 1)
end

function haulerTask:startup()
	for index, config in pairs(HAULER_TASKS) do
	   	   for i, rewardTable in pairs(config["Reward"]) do
		    if rewardTable.type == "access" then
			   local name = rewardTable.name
			   local x = rewardTable.position[1]
		       local y = rewardTable.position[2]
			   local z = rewardTable.position[3]
			   local pos = Position(x, y, z)
			   local tile = Tile(pos)
			   if tile then
			      local ground = tile:getGround()
				  if ground then
					 ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, haulerTask.access)
				  end
			   end
			end
		end
	end
	haulerTask:addStatues()
	haulerTask:addInfernalSouls()
	haulerTask:bossTeleport()
end

function haulerTask:getAccess(player, item)

    if not player then
	   return nil
	end
	
	if not item then
	   return nil
	end
		
	if item:getAttribute(ITEM_ATTRIBUTE_ACTIONID) == haulerTask.access then
	   if haulerTask:getQuestLogMission(player, 2) == 2 then
	      return true
	   end
	end
	
	return false
end

function haulerTask:addActionID()

		for index, haulerTasks in pairs(HAULER_TASKS) do
		   if not haulerTasks["Required Items"] then
		      break
		   end
	        for i, itemTable in pairs(haulerTasks["Required Items"]) do  
			    if itemTable.type == "item" then
				   haulerTask.aid = haulerTask.aid + 1
				   HAULER_TASKS[index]["Required Items"][i].actionid = haulerTask.aid
				end
		    end
	    end
end
--haulerTask:addActionID()

function haulerTask:findByActionID(value)
         
		for index, haulerTasks in pairs(HAULER_TASKS) do
		   	if not haulerTasks["Required Items"] then
		       break
		    end
	        for i, itemTable in pairs(haulerTasks["Required Items"]) do 
                if itemTable.type == "item" then
                   if itemTable.actionid == value then
				      local values = { ["Index"] = i, ["Table"] = itemTable }
                      return values
                   end
                end
            end
        end

return nil
end		
			
function haulerTask:prepare()
	local questIndex = 1
	while true do
		if (not Quests[questIndex]) then
			Quests[questIndex] = {
				name = "Soul Hauler Request",
				startStorageId = haulerTask.storage + 1,
				startStorageValue = 1,
				missions = {
					[1] = {
						name = "The Demonic Faces.",
						storageId = haulerTask.storage + 1,
						missionId = haulerTask.storage + 1,
						startValue = 1,
						endValue = 3,
                        states = {
						          [1] = function(player)
								           return string.format("I have to find and touch " .. haulerTask:getStatues(player) .. " demonic faces.")
										end,
								  [2] = "report to Soul Hauler.",
						          [3] = "I have completed this mission.",
                                 },
					},
					[2] = {
						name = "Killing the " .. HAULER_TASKS[2]["Required Monster"].name .. ".",
						storageId = haulerTask.storage + 2,
						missionId = haulerTask.storage + 2,
						startValue = 1,
						endValue = 3,
                        states = {
						          [1] = function(player)
								           return string.format("I have to kill " .. haulerTask:getKills(player) .. " " .. HAULER_TASKS[2]["Required Monster"].name .. "." .. "\n" .. "Avaible Monsters: " .. haulerTask:getMonstersName() .. ".")
										end,
								  [2] = "report to Soul Hauler.",
						          [3] = "I have completed this mission.",
                                 },
					},
					[3] = {
						name = "Bring the demon trophy.",
						storageId = haulerTask.storage + 3,
						missionId = haulerTask.storage + 3,
						startValue = 1,
						endValue = 3,
                        states = {
						          [1] = "bring " .. haulerTask:getItemList(HAULER_TASKS[3]["Required Items"], true)["String"],
						          [3] = "I have completed this mission.",
                                 },
					},
					[4] = {
						name = "Kill the boss.",
						storageId = haulerTask.storage + 4,
						missionId = haulerTask.storage + 4,
						startValue = 1,
						endValue = 3,
                        states = {
						          [1] = function(player)
								           return string.format("I have to kill " .. haulerTask:getKills(player) .. " " .. HAULER_TASKS[4]["Required Monster"].name .. ".")
										end,
								  [2] = "report to Soul Hauler.",
						          [3] = "I have completed this mission.",
                                 },
					},
					[5] = {
						name = "Bring the morshabaal extract.",
						storageId = haulerTask.storage + 5,
						missionId = haulerTask.storage + 5,
						startValue = 1,
						endValue = 3,
                        states = {
						          [1] = "bring " .. haulerTask:getItemList(HAULER_TASKS[5]["Required Items"], true)["String"],
						          [3] = "I have completed this mission.",
                                 },
					},
					[6] = {
						name = "The Infernal Souls",
						storageId = haulerTask.storage + 6,
						missionId = haulerTask.storage + 6,
						startValue = 1,
						endValue = 3,
                        states = {
						          [1] = function(player)
								           return string.format("I have to find and touch " .. haulerTask:getInfernalSouls(player) .. " infernal souls.")
										end,
								  [2] = "report to Soul Hauler.",
						          [3] = "I have completed this mission.",
                                 },
					},					
			    }
			}
			break
		end
		questIndex = questIndex + 1
	end
end

function haulerTask:getCurrentMission(player)

    for i = 1, #HAULER_TASKS do
	    if haulerTask:getQuestLogMission(player, i) < 3 then
		   return i
		end
	end
	
	return false
end

function haulerTask:setMission(player, value)
      
	  if not player then
	     return nil
	  end
	  
	player:setStorageValue(haulerTask.storage, value)
end

function haulerTask:getMission(player)
      
	  if not player then
	     return nil
	  end
	  
	  local value = player:getStorageValue(haulerTask.storage)
	  
	  if value < 1 then
	     value = 0
	  end
	  
	  return value
end

function haulerTask:setQuestLogMission(player, index, value)
      
	  if not player then
	     print("PLAYER NOT FOUND")
	     return nil
	  end
	  
	  if not value then
	     print("VALUE NOT FOUND")
		 return nil
	  end
	  
	  if not index then
	     print("INDEX NOT FOUND")
		 return nil
	  end
	  
	player:setStorageValue(haulerTask.storage + index, value)
end

function haulerTask:getQuestLogMission(player, index)
      
	  if not player then
	     return nil
	  end
	  
	  if not index then
	     print("INDEX NOT FOUND")
		 return nil
	  end
	  
	  local value = player:getStorageValue(haulerTask.storage + index)
	  
	  if value < 1 then
	     value = 0
	  end
	  
	  return value
end

function haulerTask:countItems(t)

      if not t then
         return nil
      end

      local value = 0

      for index, requireditem in pairs(t) do
          if requireditem.type == "item" then
		     value = value + 1
		  end
	   end
	   
	  return value
end

function haulerTask:getItemList(t, method)

    local str = ""
	local list = {}
		  for index, requireditem in pairs(t) do
		      if requireditem.type == "item" then
		         local id = requireditem.id
			     local count = requireditem.count
				 local itemTable = { ["itemid"] = id, ["count"] = count }
				 table.insert(list, itemTable)
		         if index == haulerTask:countItems(t) and haulerTask:countItems(t) > 1 then
				    if method then
					   str = str .. " and " .. count .. "x " .. getItemName(id) .. "."
					   else
			           str = str .. " and " .. count .. "x " .. "{" .. getItemName(id) .. "}" .. "."
					end
				 else
				    if index == haulerTask:countItems(t) - 1 or haulerTask:countItems(t) == 1 then
					   if method then
					      str = str .. count .. "x " .. getItemName(id)
					   else
				          str = str .. count .. "x " .. "{" .. getItemName(id) .. "}"
					   end
					else
					   if method then
					      str = str .. count .. "x " .. getItemName(id) .. ", "
					   else
					      str = str .. count .. "x " .. "{" .. getItemName(id) .. "}" .. ", "
					   end
					end
			    end
		     end
		  end
		  
	local values = { ["String"] = str, ["List"] = list }
    return values
end	

function haulerTask:getMissingItemList(t)
      
	  if not t then
	     return nil
	  end
	  
	  local str = ""
	  for index, missingItem in pairs(t) do
	      local id = missingItem["itemid"]
		  local count = missingItem["count"]
		  
		     if index == #t and #t > 1 then
			        str = str .. " and " .. count .. "x " .. "{" .. getItemName(id) .. "}"
				 else
				    if index == #t - 1 or #t == 1 then
				       str = str .. count .. "x " .. "{" .. getItemName(id) .. "}"
					else
					   str = str .. count .. "x " .. "{" .. getItemName(id) .. "}" .. ", "
					end
		     end
	   end  
	   
	return str
end

function haulerTask:countMoney(t)

      if not t then
         return nil
      end

      local value = 0

      for index, requireditem in pairs(t) do
          if requireditem.type == "money" then
		     value = value + requireditem.value
		  end
	  end
	   
	  return value
end

function haulerTask:removeItems(player, t)
      
      if not player then 
         return nil
      end
      
      if not t then
         return nil
      end
   	  
	  for index, v in pairs(t) do
	      local id = v["itemid"]
		  if not id then
		     id = v["id"]
		  end
		  if not id then
		     id = v.id
		  end
		  local count = v["count"]
		  if not count then
		     count = v.count
		  end
	      player:removeItem(id, count)
	  end
	  local pos = player:getPosition()
	  pos:sendMagicEffect(CONST_ME_MAGIC_RED)

end

function haulerTask:addRewards(player, t)
         
		if not t then
		   return nil
	    end
		 
		if not player then
		   return nil
		end
		 
		local list = {}
		local str = "You have received: "
		local items = 0
		 
		for index, rewardTable in pairs(t) do
		     if rewardTable.type == "item" then
			    items = items + 1
			    local id = rewardTable.id
				local count = rewardTable.count
				player:addItem(id, count)
		      	if index == haulerTask:countItems(t) and haulerTask:countItems(t) > 1 then
				    if method then
					   str = str .. " and " .. count .. "x " .. getItemName(id) .. "."
					   else
			           str = str .. " and " .. count .. "x " .. "{" .. getItemName(id) .. "}" .. "."
					end
				 else
				    if index == haulerTask:countItems(t) - 1 or haulerTask:countItems(t) == 1 then
					   if method then
					      str = str .. count .. "x " .. getItemName(id)
					   else
				          str = str .. count .. "x " .. "{" .. getItemName(id) .. "}"
					   end
					else
					   if method then
					      str = str .. count .. "x " .. getItemName(id) .. ", "
					   else
					      str = str .. count .. "x " .. "{" .. getItemName(id) .. "}" .. ", "
					   end
					end
			    end  
		    end
		end
		
		if items > 0 then
		   str = str .. " and "
		end

		for index, rewardTable in pairs(t) do
		    if rewardTable.type == "addon" then
			   local male = rewardTable.value.male
			   local female = rewardTable.value.female
			   player:addOutfitAddon(male, 1)
		       player:addOutfitAddon(male, 2)
			   player:addOutfitAddon(female, 1)
		       player:addOutfitAddon(female, 2)
			elseif rewardTable.type == "mount" then
			   local id = rewardTable.value
			   player:addMount(id)
		    end
		end	
end

local globalevent = GlobalEvent("load_Soulhauler")
function globalevent.onStartup()
	haulerTask:prepare()

	for index, haulerTasks in pairs(HAULER_TASKS) do
	    if not haulerTasks["Required Items"] then
		   break
		end
	    for i, itemTable in pairs(haulerTasks["Required Items"]) do 
            if itemTable.type == "item" then
			   local pos = itemTable.position 
			   if pos then
			      local position = Position(pos.x, pos.y, pos.z)
				  local tile = Tile(position)
				  if tile then
				     local items = tile:getItems()
				     for index, item in pairs(items) do
				         item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, itemTable.actionid)
				     end
				   end
			   end
			end
	    end
	end
end
globalevent:register()

local creaturescript = CreatureEvent("Soulhauler_onLogin")
function creaturescript.onLogin(player)
    player:registerEvent("Soulhauler_onKill")
	return true
end
creaturescript:register()

creatureevent = CreatureEvent("Soulhauler_onKill")
function creatureevent.onKill(player, target)
    
	if not player then
	   return true
	end
	
	if not target then
	   return true
	end
	
	if haulerTask:getQuestLogMission(player, 2) == 1 then
	   local name = target:getName()
	   if isInArray(HAULER_TASKS[2]["Required Monster"].monsterList, name) or isInArray(HAULER_TASKS[2]["Required Monster"].monsterList, name:lower()) then
	      haulerTask:setKills(player)
		  if haulerTask:getKills(player) == 0 then
		     haulerTask:setQuestLogMission(player, 2, 2)
		  end
		  haulerTask:updateTracker(player, haulerTask.storage + 2)
	   end
       return true
    end
	
	if haulerTask:getQuestLogMission(player, 4) == 1 then
	   local name = target:getName()
	   if isInArray(HAULER_TASKS[4]["Required Monster"].monsterList, name) or isInArray(HAULER_TASKS[4]["Required Monster"].monsterList, name:lower()) then
	      haulerTask:setKills(player)
		  if haulerTask:getKills(player) == 0 then
		     haulerTask:setQuestLogMission(player, 4, 2)
		  end
		  haulerTask:updateTracker(player, haulerTask.storage + 4)
		  haulerTask:kickPlayer(1)
	   end
       return true
    end
	
	return true
end
creatureevent:register()
	
local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
         
		local t = haulerTask:findByActionID(item:getActionId()) 
		if not t then
		   return true
		end
		
		local id = t["Table"].id
		local count = t["Table"].count
		local name = getItemName(id)
		local index = t["Index"]
		
		if player:getStorageValue(haulerTask.storage + index) > 0 then
		   player:sendCancelMessage("You have already picked this item.")
		   return true
		end
		
		local pos = player:getPosition()
		player:addItem(id, count)
		pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got a " .. count .. "x " .. name .. ".")
		player:setStorageValue(haulerTask.storage + index, 1)
		
return true
end
for index, haulerTasks in pairs(HAULER_TASKS) do
	    if not haulerTasks["Required Items"] then
		   break
		end
	for i, itemTable in pairs(haulerTasks["Required Items"]) do  
		if itemTable.type == "item" then
		   local actionid = itemTable.actionid
		   if actionid then
		      action:aid(actionid)
		   end
		end
    end
end
action:register()

action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
        

		local pos = player:getPosition()
        local index = item:getCustomAttribute("INFERNAL_SOUL")		
		if index then
		   if haulerTask:getQuestLogMission(player, 6) > 1 then
		      player:sendCancelMessage("You can't use this infernal soul anymore.")
		      fromPosition:sendMagicEffect(CONST_ME_POOF)
		      return true
		   end

		   if haulerTask:getInfernalSouls(player) <= 0 then
		      player:sendCancelMessage("You are not allowed to touch this item.")
		      return true
		   end
		   
		   -- if player:getStorageValue(haulerTask.infernalSouls + index) >= 1 then
		      -- player:sendCancelMessage("You can't use this infernal soul anymore.")
			  -- return true
		   -- end
		   
		
		   haulerTask:setInfernalSouls(player)
		   pos:sendMagicEffect(CONST_ME_MAGIC_RED)
		   player:sendTextMessage(MESSAGE_INFO_DESCR, "You have touch the infernal soul.")
		   local count = haulerTask:getInfernalSouls(player)
		   if count == 0 then
		      haulerTask:setQuestLogMission(player, 6, 2)
		   end
		   haulerTask:updateTracker(player, haulerTask.storage + 6)
		   player:setStorageValue(haulerTask.infernalSouls + index, 1)
		   return true
		end
				
		index = item:getCustomAttribute("DEMONIC_STATUES_INDEX")
		if not index then
		   return false
		end
		local storage = haulerTask.storage + 51
		
		if haulerTask:getQuestLogMission(player, 1) > 1 or player:getStorageValue(storage + index) == 1 then
		   player:sendCancelMessage("You can't use this face anymore.")
		   fromPosition:sendMagicEffect(CONST_ME_POOF)
		   return true
		end
		
		if haulerTask:getStatues(player) <= 0 then
		   player:sendCancelMessage("You are not allowed to touch this item.")
		   return true
		end
		
		haulerTask:setStatues(player)
		pos:sendMagicEffect(CONST_ME_MAGIC_RED)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have touch the demonic face.")
		local count = haulerTask:getStatues(player)
		if count == 0 then
		   haulerTask:setQuestLogMission(player, 1, 2)
		end
		haulerTask:updateTracker(player, haulerTask.storage + 1)

		
return true
end
action:aid(haulerTask.statues)
action:register()

local moveevent = MoveEvent()
moveevent:type("stepin")
function moveevent.onStepIn(creature, item, position, fromPosition)
    
	local player = Player(creature)
	
	if not player then
		return true
	end
	
	
	if item:getCustomAttribute(haulerTask.bossAccess.key) then	
 
        local index = item:getCustomAttribute(haulerTask.bossAccess.index)
	   
	   	if item:getCustomAttribute(haulerTask.bossAccess.exit) then
	       haulerTask:removePlayer(index, true)
	       return true
	    end
		
	   if player:getStorageValue(haulerTask.bossAccess.storage) < 1 then
          player:teleportTo(fromPosition)
	      player:sendTextMessage(MESSAGE_INFO_DESCR, "You are not allowed to access this place.")
	      return false
	   end	 
	   
	   if haulerTask:getExhaust(player, index) then
	      local exhaustString = haulerTask:getExhaustString(player, index) 
          player:sendTextMessage(MESSAGE_INFO_DESCR, "You have to wait: " .. exhaustString .. "\n" .. "before you can enter again.")
          --player:teleportTo(fromPosition)	   
          --return false
	   end
		
	   local participant = haulerTask:getPlayerbyIndex(index)
	   if participant then
	      player:teleportTo(fromPosition)
	      player:sendTextMessage(MESSAGE_INFO_DESCR, "Another warrior is fighting with this boss" .. "\n" .. "Timeleft: " .. haulerTask:getTimeString(index))
	      return false
	   end
	
	   haulerTask:addMonster(index)
	   haulerTask:addPlayer(player, index)
	   haulerTask:setTime(index)
	
       return true
    end	

	if not haulerTask:getAccess(player, item) then
	   player:teleportTo(fromPosition)
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "You are not allowed to access this place.")
	   return false
	end
	
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	return true

end
moveevent:aid(haulerTask.access)
moveevent:register()

local globalevent = GlobalEvent("Soul Hauler - Prepare")
function globalevent.onStartup()
	haulerTask:startup()
	haulerTask:addBossStatues()
	return true
end
globalevent:register()


globalevent = GlobalEvent("haulerTask_displayTimer")
function globalevent.onThink(interval, lastExecution)
   	
	local t = haulerTask.bosses["Bosses"]
	for i = 1, #t do
	    local player = haulerTask:getPlayerbyIndex(i)
		local boss = haulerTask:getMonsterbyIndex(i)
		if player and boss then
		   local timeleft = haulerTask:getTimeString(i)
		   if haulerTask:getTimeString(i) == "" then
			  haulerTask:removePlayer(i, true)
			  player:sendTextMessage(MESSAGE_STATUS_WARNING, "Timeout!, You have been kicked from boss lair.")
			  return true
		   end
	       local schedulerTable = t[i]["Scheduler"]
		   if schedulerTable then
	          local statueTable = schedulerTable["Statue"]
		      if statueTable then
		         local enabled = statueTable.enabled
		         if enabled then
		            local posTable = statueTable.position
		            local pos = Position(posTable.x, posTable.y, posTable.z)
		            if pos then			 
		               Game.sendTextOnPosition("You have " .. timeleft .. " to kill this boss.", pos)
					end
			      end
			   end
			end
		end
	end

	return true
end
globalevent:interval(10 * 1000)
globalevent:register()
   
local creatureevent = CreatureEvent("haulerTask_onLogout")
function creatureevent.onLogout(player)
   
   	local t = haulerTask.bosses["Bosses"]
	for i = 1, #t do
	    local participant = haulerTask:getPlayerbyIndex(i)
		if participant then
		   if player:getId() == participant:getId() then
		      haulerTask:removePlayer(i, true)
		   end
		end
	end
   
return true
end
creatureevent:register()

