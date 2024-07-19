if not AILLIKA_MISSIONS then
   AILLIKA_MISSIONS = {}
end

AILLIKA_MISSIONS.config = { 
                            killingStorage = 32311,
							missionStorage = 23133,
                            ["Missions"] = {
							                 [1] = { 
													 requiredItems = { 
											                           { type = "item", id = 7399, count = 1 },
																	   -- { type = "item", id = 5948, count = 1 },
                                                                     },
											         reward = {
													            { type = "money", value = 1000000 },
															  }
                                                   },
							                 [2] = { 
													 requiredItems = { 
											                           { type = "item", id = 3738, count = 1 },
                                                                     },
											         reward = {
																{ type = "outfit scroll", name = "Summoner", addon = 1 },
															  }
                                                   },	
							                 [3] = {  
													 requiredKills = { 
																	   monsterList = { "Frost Dragon" },
																	   kills = 10000,
                                                                     },
											         reward = {
													            { type = "item", id = 8175, count = 1 },
															  }
                                                   },												   
                                           }
                         }
function AILLIKA_MISSIONS:prepare()
	local questIndex = 1
	while true do
		if (not Quests[questIndex]) then
			Quests[questIndex] = {
				name = "Aillika Request",
				startStorageId = self.config.missionStorage + 1,
				startStorageValue = 1,
				missions = {
					[1] = {
						name = "Dragon Trophies",
						storageId = self.config.missionStorage + 1,
						missionId = self.config.missionStorage + 1,
						startValue = 1,
						endValue = 3,
                        states = {
						          [1] = "I have to bring green and red dragon trophies.",
						          [3] = "I have completed this mission.",
                                 },
					},		
					[2] = {
						name = "Mystical Plant",
						storageId = self.config.missionStorage + 2,
						missionId = self.config.missionStorage + 2,
						startValue = 1,
						endValue = 3,
                        states = {
						          [1] = "I have to find a plant that aillika asked me.",
								  [2] = "Ask Aillika for reward",
						          [3] = "I have completed this mission.",
                                 },
					},		
					[3] = {
						name = "Ice Dragons",
						storageId = self.config.missionStorage + 3,
						missionId = self.config.missionStorage + 3,
						startValue = 1,
						endValue = 3,
                        states = {
						          [1] = function(player)
								           local str = ""
								           local kills = AILLIKA_MISSIONS:getKill(player)
										   if kills then
										      str = "You have to kill " .. kills .. " Ice Dragons left."
											  if not HADRIN_MISSIONS:isVisited(player) then
											     str = str .. "\n" .. "I have to visit Hadrin still."
										      end
										      --str = kills 
										   end
								           return string.format(str)
										end,
						          [2] = function(player)
								           local str = "I have finished hunting ice dragons "
								           if not HADRIN_MISSIONS:isVisited(player) then
										      str = str .. "\n" .. "Now i have to visit Hadrin"
										   else
										      str = str .. "I should back to Aillika."
										   end
										   
								           return string.format(str)
										end,
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

function AILLIKA_MISSIONS:getKill(player)
    local value = player:getStorageValue(self.config.killingStorage)
	if value < 0 then
	   value = 0
	end
	return value
end
	
function AILLIKA_MISSIONS:addKill(player)
	local kills = AILLIKA_MISSIONS:getKill(player)
	
	if kills == 0 then
	   return
	end	
	
	
	if player:getStorageValue(self.config.killingStorage) == -1 then
	   return
	end
	
	
    player:setStorageValue(self.config.killingStorage, kills - 1)
	AILLIKA_MISSIONS:updateTracker(player, self.config.missionStorage + 3)
	
	if kills == 1 then
	   player:setStorageValue(self.config.killingStorage, -1)
	   dakosLib:setQuestLogMission(player, AILLIKA_MISSIONS.config.missionStorage, 3, 2)
	   return
    end
	return true
end

function AILLIKA_MISSIONS:updateTasks(player, creature)
	if isInArray(self.config["Missions"][3].requiredKills.monsterList, creature:getName()) or isInArray(self.config["Missions"][3].requiredKills.monsterList, creature:getName():lower()) then
	   AILLIKA_MISSIONS:addKill(player)
	end
end

local creaturescript = CreatureEvent("AILLIKA_MISSIONS_onDeath")
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
	
	local key = AILLIKA_MISSIONS.config.missionStorage
	local currentMission = dakosLib:getQuestCurrentMission(player, key, AILLIKA_MISSIONS.config["Missions"], 3)
	local missionId = dakosLib:getQuestLogMission(player, key, currentMission)
	
	if currentMission ~= 3 then
	   return false
	end
	if missionId ~= 1 then
	   return false
	end
	
	local party = player:getParty() 
	if party then
	   if party:isSharedExperienceEnabled() then
	      local members = party:getMembers()
		  if members then
			 for _, member in pairs(members) do
				AILLIKA_MISSIONS:updateTasks(member, creature)
			 end
		  end
		  local leader = party:getLeader() 
		  if leader then
		     AILLIKA_MISSIONS:updateTasks(leader, creature) 
		  end
	   return true
	   end
	end
	
	AILLIKA_MISSIONS:updateTasks(player, creature)
	return true
end
creaturescript:register()

function AILLIKA_MISSIONS:updateTracker(player, key)
	local missions = player:getMissionsData(key)
	for i = 1, #missions do
		local mission = missions[i]
		if player:hasTrackingQuest(mission.missionId) then
		   player:sendUpdateTrackedQuest(mission)
		   player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your questlog has been updated.")
		end
	end
end

local globalevent = GlobalEvent("AILLIKA_MISSIONS_onStartUp")
function globalevent.onStartup()
	AILLIKA_MISSIONS:prepare()
end
globalevent:register()