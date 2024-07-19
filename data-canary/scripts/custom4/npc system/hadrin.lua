if not HADRIN_MISSIONS then
   HADRIN_MISSIONS = {}
end

HADRIN_MISSIONS.config = { 
                            killingStorage = 32411,
							missionStorage = 23433,
							visitedStorage = 21533,
                            ["Missions"] = {	
							                 [1] = { 
											         type = "kill", 
													 requiredKills = { 
																	   [1] = { 
																	           name = "Wyrms",
																	           monsterList = { "Wyrm" },
																	           kills = 2000,
																			 },
																	   [2] = { 
																	           name = "Elder Wyrms",
																	           monsterList = { "Elder Wyrm" },
																	           kills = 1000,
																			 },																			 
                                                                     },
											         reward = {
													            { type = "mount", name = "Ursagrodon", id = 38 },
															  }
                                                   },												   
                                           }
                         }
						 

function HADRIN_MISSIONS:isVisited(player)
   if player:getStorageValue(self.config.visitedStorage) == 1 then
      return true
   end
   return false
end   

function HADRIN_MISSIONS:setVisited(player)
   return player:setStorageValue(self.config.visitedStorage, 1)
end

function HADRIN_MISSIONS:setKills(player)
	for i, v in ipairs(self.config["Missions"][1].requiredKills) do
	    player:setStorageValue(self.config.killingStorage + i, v.kills)
	end
end

function HADRIN_MISSIONS:getKills(player)
    
	local str = "You have to kill "
	local started = false
	for i, v in ipairs(self.config["Missions"][1].requiredKills) do
	    if started then
		   str = str .. ", "
		end
	    local count = HADRIN_MISSIONS:getKill(player, i)
		local name = v.name
		if count > 0 then
		   str = str .. count .. " " .. name
		   if not started then
		      started = true
		   end
		end
	end
	
	if not started then
	   return false
	end
	
	return str
end

function HADRIN_MISSIONS:prepare()
	local questIndex = 1
	while true do
		if (not Quests[questIndex]) then
			Quests[questIndex] = {
				name = "Hadrin Request",
				startStorageId = HADRIN_MISSIONS.config.missionStorage + 1,
				startStorageValue = 2,
				missions = {
					[1] = {
						name = "Killing the wyrms.",
						storageId = HADRIN_MISSIONS.config.missionStorage + 1,
						missionId = HADRIN_MISSIONS.config.missionStorage + 1,
						startValue = 2,
						endValue = 4,
                        states = {
						          [2] = function(player)
								           local str = ""
								           local kills = HADRIN_MISSIONS:getKills(player)
										   if kills then
										      str = kills
										   end
								           return string.format(str)
										end,
								  [3] = "I have finished hunting wyrms that Hadrin asked me, i should visit him and report mission.",
						          [4] = "I have completed this mission.",
                                 },
					},					
			    }
			}
			break
		end
		questIndex = questIndex + 1
	end
end

function HADRIN_MISSIONS:getRequiredKills(player)
    
	local str = "You have to kill "
	local started = false
	for i, v in ipairs(self.config["Missions"][1].requiredKills) do
	    if started then
		   str = str .. ", "
		end
		str = str .. v.kills .. " " .. "{" .. v.name .. "}"

		if not started then
		   started = true
		end
	end
	str = str .. "."
	return str
end



function HADRIN_MISSIONS:getKill(player, index)
    local value = player:getStorageValue(self.config.killingStorage + index)
	if value < 0 then
	   value = 0
	end
	return value
end
	
function HADRIN_MISSIONS:addKill(player, index)
	local kills = HADRIN_MISSIONS:getKill(player, index)
	if kills == 0 then
	   return
	end	
    return player:setStorageValue(self.config.killingStorage + index, kills - 1)
end

function HADRIN_MISSIONS:updateTasks(player, creature)
	for i, v in ipairs(HADRIN_MISSIONS.config["Missions"][1].requiredKills) do
	    local index = i
		local monsterList = v.monsterList
	    if isInArray(monsterList, creature:getName()) or isInArray(monsterList, creature:getName():lower()) then
	       HADRIN_MISSIONS:addKill(player, index)
	       local key = HADRIN_MISSIONS.config.missionStorage + 1
	       HADRIN_MISSIONS:updateTracker(player, key)
		   countKills = HADRIN_MISSIONS:getKills(player)
		   if not countKills then
		      dakosLib:setQuestLogMission(player, HADRIN_MISSIONS.config.missionStorage, 1, 3)
		   end
		   return true
		end
	end
end

function HADRIN_MISSIONS:updateTracker(player, key)
	local missions = player:getMissionsData(key)
	for i = 1, #missions do
		local mission = missions[i]
		if player:hasTrackingQuest(mission.missionId) then
		   player:sendUpdateTrackedQuest(mission)
		   player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your questlog has been updated.")
		end
	end
end

local creaturescript = CreatureEvent("HADRIN_MISSIONS_onDeath")
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
	
	local key = HADRIN_MISSIONS.config.missionStorage
	local missionId = dakosLib:getQuestLogMission(player, key, 1)
	
	
	
	if missionId ~= 2 then
	   return false
	end
	
	local party = player:getParty() 
	if party then
	   if party:isSharedExperienceEnabled() then
	      local members = party:getMembers()
		  if members then
			 for _, member in pairs(members) do
				HADRIN_MISSIONS:updateTasks(member, creature)
			 end
		  end
		  local leader = party:getLeader() 
		  if leader then
		     HADRIN_MISSIONS:updateTasks(leader, creature) 
		  end
	   return true
	   end
	end
	
	HADRIN_MISSIONS:updateTasks(player, creature)
	return true
end
creaturescript:register()

local globalevent = GlobalEvent("HADRIN_MISSIONS_onStartUp")
function globalevent.onStartup()
	HADRIN_MISSIONS:prepare()
end
globalevent:register()