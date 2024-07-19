WAREWOLF_TASKS = {
                    [1] = { 
					        --["Name"] = "Gloom Wolf Hunting"
					        -- ["Reward"] = { 
							               -- { type = "experience", value = 100000 },
										   -- { type = "item", id = 3043, count = 5 },
										 -- },
							
							["Required Items"] = { },
							
					        ["Required Monster"] = { name = "Gloom Wolf", count = 200 },
							                       
						    ["Messages"] = {
							                  [1] = "Okay, your first mission is: kill ",
											  [2] = "Have you killed all monsters? ",
											  --[3] = "Congratulations, You have finished your first mission.",
										   }
						   },
                    [2] = { 
					        -- ["Reward"] = { 
							               -- { type = "experience", value = 100000 },
										   -- { type = "item", id = 3043, count = 5 },
										 -- },
							
							["Required Items"] = { },
							
					        ["Required Monster"] = { name = "Ghost Wolf", count = 300 },
							                       
						    ["Messages"] = {
							                  [1] = "Okay, your second mission is: kill ",
											  [2] = "Have you killed all monsters? ",
											  --[3] = "Congratulations, You have finished your first mission.",
										   }
						   },
                    [3] = { 
					        ["Reward"] = { 
							               { type = "mount", name = "Crystal Wolf", id = 16 },
										 },
							
							["Required Items"] = { },
							
					        ["Required Monster"] = { name = "Crystal Wolf", count = 30 },
							                       
						    ["Messages"] = {
							                  [1] = "Okay, your last mission is: kill ",
											  [2] = "Have you killed all monsters? ",
											  --[3] = "Congratulations, You have finished your first mission.",
										   }
						   },						   
                    -- [2] = { 
					        -- ["Reward"] = { 
							               -- { type = "access", name = "ghost wolf access", position = { 919, 1051, 8 } }
										 -- },
					        -- ["Required Items"] = { 
							                       -- { type = "item", id = 10318, count = 1 },
												 -- },
						    -- ["Messages"] = {
							                  -- [1] = "Okay, your second mission is: bring ",
											  -- [2] = "Do you have all required items? ",
											  -- [3] = "Congratulations, You have finished your second mission. Now you can hunt ghost wolves.",
										   -- }
						   -- },				
				}
				   
WarewolfTask = { }
WarewolfTask.__newindex = WarewolfTask
WarewolfTask.storage = 48111
WarewolfTask.aid = 6433
WarewolfTask.access = 11318

function WarewolfTask:updateTracker(player, key, logg)
    
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

function WarewolfTask:getKills(player)
    local storage = WarewolfTask.storage - 100
	
	if player:getStorageValue(storage) < 0 then
	   return -1
	end
	
	return player:getStorageValue(storage)
end

function WarewolfTask:getKillTask(missionId, highlight)
        
    local str = ""
    
	local t = WAREWOLF_TASKS[missionId]
	
    local name = t["Required Monster"].name
	local count = t["Required Monster"].count
	
	local str2 = "{" .. name .. "}"
	if highlight then
	    name = str2
	end
	str = str .. count .. " " .. name
	
	return str
end

function WarewolfTask:setKillTask(player, index)
	local storage = WarewolfTask.storage - 100
	local count = WAREWOLF_TASKS[index]["Required Monster"].count
	return player:setStorageValue(storage, count)
end
   
function WarewolfTask:setKills(player)
    local storage = WarewolfTask.storage - 100
	
	if player:getStorageValue(storage) <= 0 then
	   return
	end
	
	return player:setStorageValue(storage, player:getStorageValue(storage) - 1)
end

function WarewolfTask:startup()
	-- for index, config in pairs(WAREWOLF_TASKS) do
	    -- for i, rewardTable in pairs(config["Reward"]) do
		    -- if rewardTable.type == "access" then
			   -- local name = rewardTable.name
			   -- local x = rewardTable.position[1]
		       -- local y = rewardTable.position[2]
			   -- local z = rewardTable.position[3]
			   -- local pos = Position(x, y, z)
			   -- local tile = Tile(pos)
			   -- if tile then
			      -- local ground = tile:getGround()
				  -- if ground then
					 -- ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, WarewolfTask.access)
				  -- end
			   -- end
			-- end
		-- end
	-- end
	
end

function WarewolfTask:getAccess(player, item)

    if not player then
	   return nil
	end
	
	if not item then
	   return nil
	end
		
	if item:getAttribute(ITEM_ATTRIBUTE_ACTIONID) == WarewolfTask.access then
	   if WarewolfTask:getQuestLogMission(player, 2) == 2 then
	      return true
	   end
	end
	
	return false
end

function WarewolfTask:addActionID()
		for index, warewolfTasks in pairs(WAREWOLF_TASKS) do
	        for i, itemTable in pairs(warewolfTasks["Required Items"]) do  
			    if itemTable.type == "item" then
				   WarewolfTask.aid = WarewolfTask.aid + 1
				   WAREWOLF_TASKS[index]["Required Items"][i].actionid = WarewolfTask.aid
				end
		    end
	    end
end
WarewolfTask:addActionID()

function WarewolfTask:findByActionID(value)
         
		for index, warewolfTasks in pairs(WAREWOLF_TASKS) do
	        for i, itemTable in pairs(warewolfTasks["Required Items"]) do 
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
			
function WarewolfTask:prepare()
	local questIndex = 1
	while true do
		if (not Quests[questIndex]) then
			Quests[questIndex] = {
				name = "Warewolf Request",
				startStorageId = WarewolfTask.storage + 1,
				startStorageValue = 1,
				missions = {
					[1] = {
						name = "Killing Gloom Wolf's",
						storageId = WarewolfTask.storage + 1,
						missionId = WarewolfTask.storage + 1,
						startValue = 1,
						endValue = 3,
                        states = {
						          [1] = function(player)
								           return string.format("I have to kill " .. WarewolfTask:getKills(player) .. " " .. WAREWOLF_TASKS[1]["Required Monster"].name .. "s.")
										end,
								  [2] = "report to Warewolf.",
						          [3] = "I have completed this mission.",
                                 },
					},
					[2] = {
						name = "Killing Ghost Wolf's",
						storageId = WarewolfTask.storage + 2,
						missionId = WarewolfTask.storage + 2,
						startValue = 1,
						endValue = 3,
                        states = {
						          [1] = function(player)
								           return string.format("I have to kill " .. WarewolfTask:getKills(player) .. " " .. WAREWOLF_TASKS[2]["Required Monster"].name .. "s.")
										end,
								  [2] = "report to Warewolf.",
						          [3] = "I have completed this mission.",
                                 },
					},
					[3] = {
						name = "Killing Crystal Wolf's",
						storageId = WarewolfTask.storage + 3,
						missionId = WarewolfTask.storage + 3,
						startValue = 1,
						endValue = 3,
                        states = {
						          [1] = function(player)
								           return string.format("I have to kill " .. WarewolfTask:getKills(player) .. " " .. WAREWOLF_TASKS[3]["Required Monster"].name .. "s.")
										end,
								  [2] = "report to Warewolf.",
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



function WarewolfTask:getCurrentMission(player)
    for i, v in ipairs(WAREWOLF_TASKS) do
	    if WarewolfTask:getQuestLogMission(player, i) < 3 then
		    return i
		end
	end
	return false
end


function WarewolfTask:setMission(player, value)
      
	  if not player then
	     return nil
	  end
	  
	player:setStorageValue(WarewolfTask.storage, value)
end

function WarewolfTask:getMission(player)
      
	  if not player then
	     return nil
	  end
	  
	  local value = player:getStorageValue(WarewolfTask.storage)
	  
	  if value < 1 then
	     value = 0
	  end
	  
	  return value
end

function WarewolfTask:setQuestLogMission(player, index, value)
      
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
	  
	player:setStorageValue(WarewolfTask.storage + index, value)
end

function WarewolfTask:getQuestLogMission(player, index)
      
	  if not player then
	     return nil
	  end
	  
	  if not index then
	     print("INDEX NOT FOUND")
		 return nil
	  end
	  
	  local value = player:getStorageValue(WarewolfTask.storage + index)
	  
	  if value < 1 then
	     value = 0
	  end
	  
	  return value
end

function WarewolfTask:countItems(t)

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

function WarewolfTask:getItemList(t, method)

    local str = ""
	local list = {}
		  for index, requireditem in pairs(t) do
		      if requireditem.type == "item" then
		         local id = requireditem.id
			     local count = requireditem.count
				 local itemTable = { ["itemid"] = id, ["count"] = count }
				 table.insert(list, itemTable)
		         if index == WarewolfTask:countItems(t) and WarewolfTask:countItems(t) > 1 then
				    if method then
					   str = str .. " and " .. count .. "x " .. getItemName(id) .. "."
					   else
			           str = str .. " and " .. count .. "x " .. "{" .. getItemName(id) .. "}" .. "."
					end
				 else
				    if index == WarewolfTask:countItems(t) - 1 or WarewolfTask:countItems(t) == 1 then
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

function WarewolfTask:getMissingItemList(t)
      
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

function WarewolfTask:countMoney(t)

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

function WarewolfTask:removeItems(player, t)
      
      if not player then 
         return nil
      end
      
      if not t then
         return nil
      end
   	  
	  for index, v in pairs(t) do
	      local id = v["itemid"]
		  local count = v["count"]
	      player:removeItem(id, count)
	  end
	  local pos = player:getPosition()
	  pos:sendMagicEffect(CONST_ME_MAGIC_RED)

end

function WarewolfTask:addRewards(player, t)
         
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
		      	if index == WarewolfTask:countItems(t) and WarewolfTask:countItems(t) > 1 then
				    if method then
					   str = str .. " and " .. count .. "x " .. getItemName(id) .. "."
					   else
			           str = str .. " and " .. count .. "x " .. "{" .. getItemName(id) .. "}" .. "."
					end
				 else
				    if index == WarewolfTask:countItems(t) - 1 or WarewolfTask:countItems(t) == 1 then
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

function WarewolfTask:getMonsterNameByIndex(i)
    local t = WAREWOLF_TASKS[i]
	if not t then
	    return false
	end
	local monsterTable = t["Required Monster"]
	return "{" .. monsterTable.name .. "}"
end

local globalevent = GlobalEvent("load_Warewolf")
function globalevent.onStartup()
	WarewolfTask:prepare()
	
	for index, warewolfTasks in pairs(WAREWOLF_TASKS) do
	    for i, itemTable in pairs(warewolfTasks["Required Items"]) do 
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

local creaturescript = CreatureEvent("Warewolf_onLogin")
function creaturescript.onLogin(player)
    player:registerEvent("Warewolf_onKill")
    -- if player:getStorageValue(WarewolfTask.storage) < 0 then
	   -- player:setStorageValue(WarewolfTask.storage, 0)
	-- end	
	return true
end
creaturescript:register()

creatureevent = CreatureEvent("Warewolf_onKill")
function creatureevent.onKill(player, target)
    
	if not player then
	   return true
	end
	
	if not target then
	   return true
	end
	
	local missionId = WarewolfTask:getCurrentMission(player)
	if not missionId then
	    return true
	end
	
	if not missionId then
	    return true
	end
	
	local t = WAREWOLF_TASKS[missionId]
	if not t then
	    return true
	end
	
	local monstersTable = t["Required Monster"]
	if not monstersTable then
	    return true
	end
	
	if not target:getName():lower() == monstersTable.name:lower() then
	    return true
	end
	
	
	if WarewolfTask:getQuestLogMission(player, missionId) == 1 then
	    WarewolfTask:setKills(player)
	    if WarewolfTask:getKills(player) == 0 then
		    WarewolfTask:setQuestLogMission(player, missionId, 2)
		end
		WarewolfTask:updateTracker(player, WarewolfTask.storage + missionId)
	end
	return true
end
creatureevent:register()
	
-- local action = Action()
-- function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
         
		-- local t = WarewolfTask:findByActionID(item:getActionId()) 
		-- if not t then
		   -- return true
		-- end
		
		-- local id = t["Table"].id
		-- local count = t["Table"].count
		-- local name = getItemName(id)
		-- local index = t["Index"]
		
		-- if player:getStorageValue(WarewolfTask.storage + index) > 0 then
		   -- player:sendCancelMessage("You have already picked this item.")
		   -- return true
		-- end
		
		-- local pos = player:getPosition()
		-- player:addItem(id, count)
		-- pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		-- player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got a " .. count .. "x " .. name .. ".")
		-- player:setStorageValue(WarewolfTask.storage + index, 1)
		
-- return true
-- end

-- for index, warewolfTasks in pairs(WAREWOLF_TASKS) do
	-- for i, itemTable in pairs(warewolfTasks["Required Items"]) do  
		-- if itemTable.type == "item" then
		   -- local actionid = itemTable.actionid
		   -- if actionid then
		      -- action:aid(actionid)
		   -- end
		-- end
    -- end
-- end
-- action:register()

-- local moveevent = MoveEvent()
-- moveevent:type("stepin")
-- function moveevent.onStepIn(creature, item, position, fromPosition)
    
	-- local player = Player(creature)
	
	-- if not player then
		-- return true
	-- end

	-- if not WarewolfTask:getAccess(player, item) then
	   -- player:teleportTo(fromPosition)
	   -- player:sendTextMessage(MESSAGE_INFO_DESCR, "You are not allowed to access this place.")
	   -- return false
	-- end
	
	-- player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	-- return true

-- end
-- moveevent:aid(WarewolfTask.access)
-- moveevent:register()

-- local globalevent = GlobalEvent("Wolf Hunter - Prepare")
-- function globalevent.onStartup()
	-- WarewolfTask:startup()
	-- return true
-- end
-- globalevent:register()


