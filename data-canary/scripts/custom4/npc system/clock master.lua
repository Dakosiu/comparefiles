CLOCKMASTER_TASKS = {
                    [1] = { 
					        ["Reward"] = { 
							               { type = "experience", value = 100000 },
										   { type = "missionbonus", value = 1 },
										   { type = "key", id = 29304, actionid = 451, name = "Clock Master Key", description = "This key is a gift from clock master." },
										 },
							
					        ["Required Items"] = { 
							                       { type = "item", id = 21906, count = 1 }
												 },
						    ["Messages"] = {
							                  [1] = "Okay, your first mission is: bring ",
											  [2] = "Do you have all required items? ",
											  [3] = "Congratulations, You have finished your first mission.",
										   }
						   },
                    [2] = { 
					        ["Reward"] = { 
							               ---{ type = "missionbonus", value = 1 },
										 },
					        ["Required Items"] = { 
							                       { type = "item", id = 8775, count = 100 },
												   { type = "item", id = 14112, count = 1 },
												 },
						    ["Messages"] = {
							                  [1] = "Okay, your second mission is: bring ",
											  [2] = "Do you have all required items? ",
											  [3] = "Congratulations, You have finished your second mission.",
										   }
						   },
                    [3] = { 
					        ["Reward"] = { 
							               { type = "item", id = 39036, count = 1 },
										   { type = "missionbonus", value = 1 },
										 },
					        ["Required Items"] = { 
							                       { type = "item", id = 4086, count = 1 },
												 },
						    ["Messages"] = {
							                  [1] = "Okay, your second mission is: bring ",
											  [2] = "Do you have all required items? ",
											  [3] = "Congratulations, You have finished your second mission.",
										   }
						   },
                    [4] = { 
					        ["Reward"] = { 
							               { type = "item", id = 21906, count = 1 },
										 },
					        ["Required Items"] = { 
							                       { type = "item", id = 39036, count = 1 },
												 },
						    ["Messages"] = {
							                  [1] = "Okay, your second mission is: bring ",
											  [2] = "Do you have all required items? ",
											  [3] = "Congratulations, You have finished your second mission.",
										   }
						   },					
				}
				   
clockmasterTask = { }
clockmasterTask.__newindex = clockmasterTask
clockmasterTask.storage = 9711
clockmasterTask.aid = 6300
				   
function clockmasterTask:addActionID()
		for index, clockmasterTasks in pairs(CLOCKMASTER_TASKS) do
	        for i, itemTable in pairs(clockmasterTasks["Required Items"]) do  
			    if itemTable.type == "item" then
				   clockmasterTask.aid = clockmasterTask.aid + 1
				   CLOCKMASTER_TASKS[index]["Required Items"][i].actionid = clockmasterTask.aid
				end
		    end
	    end
end
clockmasterTask:addActionID()

function clockmasterTask:findByActionID(value)
         
		for index, clockmasterTasks in pairs(CLOCKMASTER_TASKS) do
	        for i, itemTable in pairs(clockmasterTasks["Required Items"]) do 
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
			
function clockmasterTask:prepare()
	local questIndex = 1
	while true do
		if (not Quests[questIndex]) then
			Quests[questIndex] = {
				name = "Clockmaster history",
				startStorageId = clockmasterTask.storage + 1,
				startStorageValue = 0,
				missions = {
					[1] = {
						name = "Visit Garik.",
						storageId = clockmasterTask.storage + 1,
						missionId = clockmasterTask.storage + 1,
						startValue = 1,
						endValue = 2,
                        states = {
						          [1] = "The Clockmaster said i should visit garik",
						          [2] = "I have completed this mission."
                                 },
					},
					[2] = {
						name = "Getting the gold bar.",
						storageId = clockmasterTask.storage + 2,
						missionId = clockmasterTask.storage + 2,
						startValue = 1,
						endValue = 2,
                        states = {
						          [1] = "Garik asked me to bring " .. clockmasterTask:getItemList(CLOCKMASTER_TASKS[2]["Required Items"], true)["String"],
						          [2] = "I have completed this mission."
                                 },
					},
					[3] = {
						name = "Smaug Request",
						storageId = clockmasterTask.storage + 3,
						missionId = clockmasterTask.storage + 3,
						startValue = 1,
						endValue = 3,
                        states = {
						          [1] = "Garik said that i should visit smaug and obtain from him the Crystal.",
						          [2] = "Smaug asked me to bring " .. clockmasterTask:getItemList(CLOCKMASTER_TASKS[3]["Required Items"], true)["String"],
								  [3] = "I have completed this mission."
                                 },
					},
					[4] = {
						name = "Bring the Crystal to Garik",
						storageId = clockmasterTask.storage + 4,
						missionId = clockmasterTask.storage + 4,
						startValue = 1,
						endValue = 2,
                        states = {
						          [1] = "I have obtained a " .. getItemName(CLOCKMASTER_TASKS[3]["Reward"][1].id) .. " i should back to Garik.",
								  [2] = "I have completed this mission."
                                 },
					},
					[5] = {
						name = "Return to Clock Master",
						storageId = clockmasterTask.storage + 5,
						missionId = clockmasterTask.storage + 5,
						startValue = 1,
						endValue = 2,
                         states = {
						            [1] = "Finally i have got a " .. getItemName(CLOCKMASTER_TASKS[4]["Reward"][1].id) .. " i should back to Clock Master.",
								    [2] = "I have completed this mission.",
                                  },
					},
				}
			}
			break
		end
		questIndex = questIndex + 1
	end
end


function clockmasterTask:setMission(player, value)
      
	  if not player then
	     return nil
	  end
	  
	player:setStorageValue(clockmasterTask.storage, value)
end

function clockmasterTask:getMission(player)
      
	  if not player then
	     return nil
	  end
	  
	  local value = player:getStorageValue(clockmasterTask.storage)
	  
	  if value < 1 then
	     value = 0
	  end
	  
	  return value
end


function clockmasterTask:setQuestLogMission(player, index, value)
      
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
	  
	player:setStorageValue(clockmasterTask.storage + index, value)
end

function clockmasterTask:getQuestLogMission(player, index)
      
	  if not player then
	     return nil
	  end
	  
	  if not index then
	     print("INDEX NOT FOUND")
		 return nil
	  end
	  
	  local value = player:getStorageValue(clockmasterTask.storage + index)
	  
	  if value < 1 then
	     value = 0
	  end
	  
	  return value
end

function clockmasterTask:countItems(t)

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

function clockmasterTask:getItemList(t, method)

    local str = ""
	local list = {}
		  for index, requireditem in pairs(t) do
		      if requireditem.type == "item" then
		         local id = requireditem.id
			     local count = requireditem.count
				 local itemTable = { ["itemid"] = id, ["count"] = count }
				 table.insert(list, itemTable)
		         if index == clockmasterTask:countItems(t) and clockmasterTask:countItems(t) > 1 then
				    if method then
					   str = str .. " and " .. count .. "x " .. getItemName(id) .. "."
					   else
			           str = str .. " and " .. count .. "x " .. "{" .. getItemName(id) .. "}" .. "."
					end
				 else
				    if index == clockmasterTask:countItems(t) - 1 or clockmasterTask:countItems(t) == 1 then
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

function clockmasterTask:getMissingItemList(t)
      
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

function clockmasterTask:countMoney(t)

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

function clockmasterTask:removeItems(player, t)
      
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

-- function clockmasterTask:addRewards(player, t)
         
		-- if not t then
		   -- return nil
	    -- end
		 
		-- if not player then
		   -- return nil
		-- end
		 
		-- local list = {}
		-- local str = "You have received: "
		-- local items = 0
		 
		-- for index, rewardTable in pairs(t) do
		     -- if rewardTable.type == "item" then
			    -- items = items + 1
			    -- local id = rewardTable.id
				-- local count = rewardTable.count
				-- player:addItem(id, count)
		      	-- if index == clockmasterTask:countItems(t) and clockmasterTask:countItems(t) > 1 then
				    -- if method then
					   -- str = str .. " and " .. count .. "x " .. getItemName(id) .. "."
					   -- else
			           -- str = str .. " and " .. count .. "x " .. "{" .. getItemName(id) .. "}" .. "."
					-- end
				 -- else
				    -- if index == clockmasterTask:countItems(t) - 1 or clockmasterTask:countItems(t) == 1 then
					   -- if method then
					      -- str = str .. count .. "x " .. getItemName(id)
					   -- else
				          -- str = str .. count .. "x " .. "{" .. getItemName(id) .. "}"
					   -- end
					-- else
					   -- if method then
					      -- str = str .. count .. "x " .. getItemName(id) .. ", "
					   -- else
					      -- str = str .. count .. "x " .. "{" .. getItemName(id) .. "}" .. ", "
					   -- end
					-- end
			    -- end  
		    -- end
		-- end
		
		-- if items > 0 then
		   -- str = str .. " and "
		-- end

		-- for index, rewardTable in pairs(t) do
		    -- if rewardTable.type == "addon" then
			   -- local male = rewardTable.value.male
			   -- local female = rewardTable.value.female
			   -- player:addOutfitAddon(male, 1)
		       -- player:addOutfitAddon(male, 2)
			   -- player:addOutfitAddon(female, 1)
		       -- player:addOutfitAddon(female, 2)
			-- elseif rewardTable.type == "mount" then
			   -- local id = rewardTable.value
			   -- player:addMount(id)
		    -- end
		-- end	
-- end

function clockmasterTask:countExperience(t)

      if not t then
         return nil
      end

      local value = 0

      for index, requireditem in pairs(t) do
          if requireditem.type == "experience" then
		     value = value + requireditem.value
		  end
	  end
	   
	  return value
end

function clockmasterTask:addRewards(player, t, text)
            
      if not t then
         return nil
      end
	  
	  local list = "You have received: "
	  
	  local itemslist = 0
	  
	  for index, v in pairs(t) do
	      if v.type == "item" then
		     itemslist = itemslist + 1
	  	     local id = v.id
		     local count = v.count
			 if not text then
			    player:addItem(id, count)
		     end
			 if index == clockmasterTask:countItems(t) or clockmasterTask:countItems(t) == 1 then
			    list = list .. count .. "x " .. getItemName(id)
		     else
			    list = list .. count .. "x " .. getItemName(id) .. ", "
			 end
		  end
	  end
	  
	  local experience = clockmasterTask:countExperience(t)
	  
	  if experience > 0 then
	     if itemslist < 1 then
	        list = list .. experience .. " experience."
			else
			list = list .. " and " .. experience .. " experience."
	     end
		 player:addExperience(experience)
	  end
	  
	  if text then
	     return list
      end
end


local globalevent = GlobalEvent("load_Clockmaster")
function globalevent.onStartup()
	clockmasterTask:prepare()
	
	for index, clockmasterTasks in pairs(CLOCKMASTER_TASKS) do
	    for i, itemTable in pairs(clockmasterTasks["Required Items"]) do 
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

local creaturescript = CreatureEvent("Clockmaster_onLogin")
function creaturescript.onLogin(player)
    -- if player:getStorageValue(clockmasterTask.storage) < 0 then
	   -- player:setStorageValue(clockmasterTask.storage, 0)
	-- end	
	return true
end
creaturescript:register()

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
         
		local t = clockmasterTask:findByActionID(item:getActionId()) 
		if not t then
		   return true
		end
		
		local id = t["Table"].id
		local count = t["Table"].count
		local name = getItemName(id)
		local index = t["Index"]
		
		if player:getStorageValue(clockmasterTask.storage + index) > 0 then
		   player:sendCancelMessage("You have already picked this item.")
		   return true
		end
		
		local pos = player:getPosition()
		player:addItem(id, count)
		pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got a " .. count .. "x " .. name .. ".")
		player:setStorageValue(clockmasterTask.storage + index, 1)
		
return true
end

for index, clockmasterTasks in pairs(CLOCKMASTER_TASKS) do
	for i, itemTable in pairs(clockmasterTasks["Required Items"]) do  
		if itemTable.type == "item" then
		   local actionid = itemTable.actionid
		   if actionid then
		      action:aid(actionid)
		   end
		end
    end
end
action:register()




