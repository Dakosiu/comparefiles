DISCOVERER_TASKS = {
                     ["Missions"] = {
					                  [1] = {
									          subMissions = 2,
									          name = "Kill that witch!",
											  ["Required"] = {
											                   { type = "item", id = 3454, count = 1 },
															 },
											  ["Subtitles"] = {
											                    [1] = "So.. you have to murder a witch and as a proof bring me her {broom}. You can find witch somewhere on swamps",
															    [2] = "Hello again, do you have a broom as a proof that u killed the witch?",
															    [3] = "Congratulations, You have finished your first mission.",
														      },
											},
					                  [2] = {
									          subMissions = 2,
									          name = "Vial with mystery poison",
											  ["Give"] = { 
											               { type = "item", id = 31297, count = 1 }, 
														 },
											  ["Required"] = {
											                   { type = "item", id = 31296, count = 1 },
															 },
											  ["Special Item"] = { 
											                        { type = "item", id = 31296, count = 1, requiredId = 31297, requiredCount = 1, requiredPosition = { x = 890,  y = 1194, z = 9} },
																 },
											  ["Reward"] = { 
											                 --{ type = "item", id = 19107, count = 1 },
															 { type = "experience", value = 5000000 },
														   },
											  ["Subtitles"] = {
											                    [1] = "Okay, take this vial and fill it with poison from the {mystery fountain} that is located somewhere on undergrounds swamps caves",
															    [2] = "Hello again, do you have a mystery vial of poison?",
															    [3] = "Congratulations, You have finished your second mission.",
														      },
											},
					                  [3] = {
									          subMissions = 3,
									          name = "Tavern",
											  ["Special Item"] = { 
											                        { type = "item", requiredId = 31296, requiredCount = 1, requiredPosition = { x = 904, y = 1133, z = 7 } },
																 },
											  ["Required"] = {
											                   --{ type = "item", id = 3454, count = 1 },
															 },
											  ["Subtitles"] = {
											                    [1] = "Now you have poison the tavern, use that mystery poison in tavern, poison the mug.",
															    [2] = "Hello again, do you poured into the mug the mystery poison?",
														      },
											  ["Access"] = {
											                 [1] = { x = 936, y = 1186, z = 9 },
														   }
											},											
									}
					}			
									
									
											                   
discoverTask = { }
discoverTask.__newindex = discoverTask
discoverTask.storage = 19551
discoverTask.actionid = 5613
discoverTask.customAttribute = {
                                 index = "DISCOVER_TASK_INDEX",
							   }








			
function discoverTask:prepare()
	local questIndex = 1
	while true do
		if (not Quests[questIndex]) then
			Quests[questIndex] = {
				name = "Discoverer Issues",
				startStorageId = discoverTask.storage + 1,
				startStorageValue = 1,
				missions = {
					[1] = {
						name = "Witch and her broom.",
						storageId = discoverTask.storage + 1,
						missionId = discoverTask.storage + 1,
						startValue = 1,
						endValue = 2,
                        states = {
						          [1] = "I should visit the witch and.. obtain the broom from her.. maybe there is a way to not killing her." .. "\n" .. "Witch living somewhere on swamps.",
						          [2] = "I have completed this mission.",
                                 },
					},
					[2] = {
						name = "Magicial vial of poison.",
						storageId = discoverTask.storage + 2,
						missionId = discoverTask.storage + 2,
						startValue = 1,
						endValue = 3,
                        states = {
						          [1] = "Discoverer ask me to fil this vial with mystery poison from mystery fountain that is located somewhere on underground swamp caves",
								  [2] = "I have filled vial with mystery poison, i should visit the discoverer.",
						          [3] = "I have completed this mission."
                                 },
					},
					[3] = {
						name = "Visit the tavern.",
						storageId = discoverTask.storage + 3,
						missionId = discoverTask.storage + 3,
						startValue = 1,
						endValue = 3,
                        states = {
						          [1] = "Discoverer ask me to pour mystery poison into the mug in tavern.",
								  [2] = "I have finished my job in tavern, i should visit the discoverer.",
						          [3] = "I have completed this mission."
                                 },
					},					
			    }
			}
			break
		end
		questIndex = questIndex + 1
	end
end


local globalevent = GlobalEvent("load_Discoverer")
function globalevent.onStartup()
	
	discoverTask:prepare()
	
	for index, b in pairs(DISCOVERER_TASKS["Missions"]) do
	    local specialTable = b["Special Item"]
		if specialTable then
	       for i, itemTable in pairs(specialTable) do 
              if itemTable.type == "item" then
			     local pos = itemTable.requiredPosition 
			     if pos then
			        local position = Position(pos.x, pos.y, pos.z)
				    local tile = Tile(position)
				    if tile then
				       local items = tile:getItems()
				       for _, item in pairs(items) do
				           item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, discoverTask.actionid)
						   item:setCustomAttribute(discoverTask.customAttribute.index, index)
				       end
				     end
				  end
			   end
			end
	    end
		local acessTable = b["Access"]
		if acessTable then
	       for i, itemTable in pairs(acessTable) do 
			     local pos = itemTable
			     if pos then
			        local position = Position(pos.x, pos.y, pos.z)
				    local tile = Tile(position)
				    if tile then
				       local items = tile:getItems()
				       for _, item in pairs(items) do
				           item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, discoverTask.actionid + 1)
						   --item:setCustomAttribute(discoverTask.customAttribute.index, index)
				       end
				     end
				  end
			end
	    end
	end
end
globalevent:register()


local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if not target or not target:isItem() then
	   return true
	end
	
	if not target:getAttribute(ITEM_ATTRIBUTE_ACTIONID) then
	   return true
	end
	
	if target:getAttribute(ITEM_ATTRIBUTE_ACTIONID) ~= discoverTask.actionid then
	   return true
	end
	
	local index = target:getCustomAttribute(discoverTask.customAttribute.index)
	if not index or index < 1 then
	   return true
	end
	
	local t = DISCOVERER_TASKS["Missions"][index]
    if not t then
       return true
    end
	
	
    local specialTable = t["Special Item"]
	if specialTable then
	   for i, v in pairs(specialTable) do
	       local id = v.id
	       local count = v.count
		   if id and count then
	          player:addItem(id, count)
		   end
	   end
	end
	
	local t = DISCOVERER_TASKS
	local key = discoverTask.storage
	--dakosLib:setQuestLogMission(player, key, 3, 2)
	   
	if index == 2 then
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got a vial with mystery potion.")
	else
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "You have poisoned this mug.")
	end
	
	local value = dakosLib:getQuestLogMission(player, key, index)
	dakosLib:setQuestLogMission(player, key, index, value + 1)
	

	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	item:remove(1)

return true
end
for index, b in pairs(DISCOVERER_TASKS["Missions"]) do
    specialTable = b["Special Item"]
	if specialTable then
       for i, v in pairs(specialTable) do
           action:id(v.requiredId)
       end
	end
end
action:register()


function discoverTask:getAccess(player)
    
	if player:getStorageValue(discoverTask.actionid + 1) >= 1 then
	   return true
	end
	return false
end

function discoverTask:setAccess(player)
    return player:setStorageValue(discoverTask.actionid + 1, 1)
end



local moveevent = MoveEvent()
moveevent:type("stepin")
function moveevent.onStepIn(creature, item, position, fromPosition)
    
	local player = Player(creature)
	
	if not player then
		return true
	end

	if not discoverTask:getAccess(player) then
	   player:teleportTo(fromPosition)
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "You are not allowed to access this place.")
	   return false
	end
	
	--player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	return true

end
moveevent:aid(discoverTask.actionid + 1)
moveevent:register()




-- DISCOVER_TASKS = {
                    -- [1] = { 
					        -- ["Reward"] = { 
							               -- { type = "item", id = 31297, count = 1 },
										 -- },
							
							-- ["Required Items"] = { 
							                       -- { type = "item", id = 3454, count = 1 },
												 -- },
						    -- ["Messages"] = {
							                  -- [1] = "So.. you have to murder a witch and as a proof bring me her broom.",
											  -- [2] = "Hello again, do you have a broom as a proof that u killed the witch?",
											  -- [3] = "Congratulations, You have finished your first mission.",
										   -- }
						   -- },
                    -- [2] = { 
					        -- ["Reward"] = { 
							               -- { type = "item", id = 8306, count = 1 }
										 -- },
					        -- ["Required Items"] = { 
							                       -- { type = "item", id = 31296, count = 1, position = { x = 889, y = 1193, z = 9 } },
												 -- },
						    -- ["Messages"] = {
							                  -- [1] = "Okay, now you have to bring me a special vial of poison",
											  -- [2] = "Hello again, do you have a special vial of poison that i asked ?",
											  -- [3] = "You have finished your last mission, take this as reward.",
										   -- }
						   -- },				
				-- }



-- discoverTask = { }
-- discoverTask.__newindex = discoverTask
-- discoverTask.storage = 19551
-- discoverTask.aid = 7500
-- discoverTask.access = 7600