ALLADYN_TASKS = {
                    [1] = { 
					        ["Reward"] = { 
							               
										   { type = "mount", value = 66 },
										   { type = "missionbonus", value = 1 }
										 },
							
					        ["Required Items"] = { 
							                       { type = "item", id = 5909, count = 50, title = "you can obtain this item by hunting ghost."},
							                       { type = "item", id = 5912, count = 50, title = "you can obtain this item by hunting blue djinn."},
							                       { type = "item", id = 5911, count = 50, title = "you can obtain this item by hunting hero."},
												   { type = "item", id = 5914, count = 50, title = "you can obtain this item by hunting mummy."},
							                       { type = "item", id = 5913, count = 50, title = "you can obtain this item by hunting ghoul."},
												   { type = "item", id = 5910, count = 100, title = "you can obtain this item by hunting green djinn."},
												   { type = "item", id = 3238, count = 1, position = { x = 1211, y = 1253, z = 7 }, title = "you can find this in human corpse near oasis in a desert."},
												 },
						    ["Messages"] = {
							                  [1] = "Okay, your first mission is: bring ",
											  [2] = "Do you have all required items? ",
											  [3] = "Congratulations, You have finished your first mission.",
										   }
						   },
                    [2] = { 
					        ["Reward"] = { 
							               { type = "addon", value = { male = 150, female = 146 } },
										   { type = "missionbonus", value = 1 }
										 },
					        ["Required Items"] = { 
							                       { type = "item", id = 5910, count = 50, title = "you can obtain this item by hunting green djinn."},
												   -- { type = "item", id = 22540, count = 1, position = { x = 32075, y = 31901, z = 6 }, title = "test5" },
												   -- { type = "item", id = 12401, count = 1, position = { x = 32075, y = 31901, z = 6 }, title = "test6"},
												   -- { type = "money", value = 600000 },
												 },
						    ["Messages"] = {
							                  [1] = "Okay, your second mission is: bring ",
											  [2] = "Do you have all required items? ",
											  [3] = "Congratulations, You have finished your second mission.",
										   }
						   }
				   }
				   
alladynTask = { }
alladynTask.__newindex = alladynTask
alladynTask.storage = 37660
alladynTask.aid = 6100

function alladynTask:setQuestLogMission(player, index, value)
      
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
	  
	player:setStorageValue(alladynTask.storage + index, value)
end

function alladynTask:getQuestLogMission(player, index)
      
	  if not player then
	     return nil
	  end
	  
	  if not index then
	     print("INDEX NOT FOUND")
		 return nil
	  end
	  
	  local value = player:getStorageValue(alladynTask.storage + index)
	  
	  if value < 1 then
	     value = 0
	  end
	  
	  return value
end
   
function alladynTask:addActionID()
		for index, alladynTasks in pairs(ALLADYN_TASKS) do
	        for i, itemTable in pairs(alladynTasks["Required Items"]) do  
			    if itemTable.type == "item" then
				   alladynTask.aid = alladynTask.aid + 1
				   ALLADYN_TASKS[index]["Required Items"][i].actionid = alladynTask.aid
				end
		    end
	    end
end
alladynTask:addActionID()

function alladynTask:findByActionID(value)
         
		for index, alladynTasks in pairs(ALLADYN_TASKS) do
	        for i, itemTable in pairs(alladynTasks["Required Items"]) do 
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
			
function alladynTask:prepare()
	local questIndex = 1
	while true do
		if (not Quests[questIndex]) then
			Quests[questIndex] = {
				name = "Alladyn Tasks",
				startStorageId = alladynTask.storage + 1,
				startStorageValue = 1,
				missions = {
					[1] = {
						name = "Mission 1.",
						storageId = alladynTask.storage + 1,
						missionId = alladynTask.storage + 1,
						startValue = 1,
						endValue = 2,
                        states = {
						          [1] = "The alladyn asked me to bring " .. alladynTask:getItemList(ALLADYN_TASKS[1]["Required Items"], true)["String"],
						          [2] = "I have completed this mission.",
                                 },
					},
					[2] = {
						name = "Mission 2.",
						storageId = alladynTask.storage + 2,
						missionId = alladynTask.storage + 2,
						startValue = 1,
						endValue = 2,
                        states = {
						          [1] = "The alladyn asked me to bring " .. alladynTask:getItemList(ALLADYN_TASKS[2]["Required Items"], true)["String"],
						          [2] = "I have completed this mission."
                                 },
					},
				}
			}
			break
		end
		questIndex = questIndex + 1
	end
end

function alladynTask:setMission(player, value)
      
	  if not player then
	     return nil
	  end
	  
	player:setStorageValue(alladynTask.storage, value)
end

function alladynTask:getMission(player)
      
	  if not player then
	     return nil
	  end
	  
	  local value = player:getStorageValue(alladynTask.storage)
	  
	  if value < 1 then
	     value = 0
	  end
	  
	  return value
end

function alladynTask:countItems(t)

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

function alladynTask:getItemList(t, method)

    local str = ""
	local list = {}
		  for index, requireditem in pairs(t) do
		      if requireditem.type == "item" then
		         local id = requireditem.id
			     local count = requireditem.count
				 local itemTable = { ["itemid"] = id, ["count"] = count }
				 table.insert(list, itemTable)
		         if index == alladynTask:countItems(t) and alladynTask:countItems(t) > 1 then
				    if method then
					   str = str .. " and " .. count .. "x " .. getItemName(id) .. "."
					   else
			           str = str .. " and " .. count .. "x " .. "{" .. getItemName(id) .. "}" .. "."
					end
				 else
				    if index == alladynTask:countItems(t) - 1 or alladynTask:countItems(t) == 1 then
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

function alladynTask:getMissingItemList(t)
      
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

function alladynTask:countMoney(t)

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

function alladynTask:removeItems(player, t)
      
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

function alladynTask:addRewards(player, t)
         
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
		      	if index == alladynTask:countItems(t) and alladynTask:countItems(t) > 1 then
				    if method then
					   str = str .. " and " .. count .. "x " .. getItemName(id) .. "."
					   else
			           str = str .. " and " .. count .. "x " .. "{" .. getItemName(id) .. "}" .. "."
					end
				 else
				    if index == alladynTask:countItems(t) - 1 or alladynTask:countItems(t) == 1 then
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
		   str = str " and "
		end

		for index, rewardTable in pairs(t) do
		    if rewardTable.type == "addon" then
			   local male = rewardTable.value.male
			   local female = rewardTable.value.female
			   player:addOutfitAddon(male, 1)
		       player:addOutfitAddon(male, 2)
			   player:addOutfitAddon(female, 1, true)
		       player:addOutfitAddon(female, 2, true)
			elseif rewardTable.type == "mount" then
			   local id = rewardTable.value
			   player:addMount(id)
			elseif rewardTable.type == "missionbonus" then
			   local value = rewardTable.value
			   player:addMissionBonus(value) 
		    end
		end	
end

local globalevent = GlobalEvent("load_Alladyn")
function globalevent.onStartup()
	alladynTask:prepare()
	
	for index, alladynTasks in pairs(ALLADYN_TASKS) do
	    for i, itemTable in pairs(alladynTasks["Required Items"]) do 
            if itemTable.type == "item" then
			   local pos = itemTable.position 
			   if pos then
			      local position = Position(pos.x, pos.y, pos.z)
				  local tile = Tile(position)
				  if tile then
				     local ground = tile:getGround()
					 if ground then
					    ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, itemTable.actionid)
				     end
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

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
         
		local t = alladynTask:findByActionID(item:getActionId()) 
		if not t then
		   return true
		end
		
		local id = t["Table"].id
		local count = t["Table"].count
		local name = getItemName(id)
		local index = t["Index"]
		
		if player:getStorageValue(alladynTask.storage + index) > 0 then
		   player:sendCancelMessage("You have already picked this item.")
		   return true
		end
		
		local pos = player:getPosition()
		player:addItem(id, count)
		pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got a " .. count .. "x " .. name .. ".")
		player:setStorageValue(alladynTask.storage + index, 1)
		
return true
end

for index, alladynTasks in pairs(ALLADYN_TASKS) do
	for i, itemTable in pairs(alladynTasks["Required Items"]) do  
		if itemTable.type == "item" then
		   local actionid = itemTable.actionid
		   if actionid then
		      action:aid(actionid)
		   end
		end
    end
end
action:register()



