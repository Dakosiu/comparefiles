FISHERMAN_TASKS = {
                    [1] = { 
					        ["Reward"] = { id = 3483, count = 1 },
					        ["Required Items"] = { 
							                       { type = "item", id = 6097, count = 1, position = { x = 993, y = 1106, z = 7 }, title = "can be found in skeleton corpse on beach where are pirates.." },
												   { type = "item", id = 20206, count = 1, position = { x = 994, y = 1106, z = 7 }, title = "can be found in boar cave.." },
												   { type = "item", id = 11445, count = 1, position = { x = 995, y = 1106, z = 7 }, title = "can be found in turtle island.." },
												   { type = "money", value = 300000 },
												 },
						    ["Messages"] = {
							                  [1] = "Okay, your first mission is: bring ",
											  [2] = "Do you have all required items? ",
											  [3] = "Congratulations, You have finished your first mission.",
										   }
						   },
                    [2] = { 
					        ["Reward"] = { id = 9306, count = 1 },
					        ["Required Items"] = { 
							                       { type = "item", id = 3483, count = 1 },
												   { type = "item", id = 3492, count = 500, title = "can be found by skinning minotaurs " },
												   { type = "money", value = 1000000 },
												 },
						    ["Messages"] = {
							                  [1] = "Okay, your second mission is: bring ",
											  [2] = "Do you have all required items? ",
											  [3] = "Congratulations, You have finished your second mission.",
										   }
						   }
				   }
				   
FISHERMAN_SHOVEL = {
                     worm_id = 3492,
					 ["Positions"] = {
					                   ["From Position"] = { 1063, 1135, 7 },
									   ["To Position"] = { 1068, 1141, 7 } 
									 }
					}
				   
fishermanTask = { }
fishermanTask.__newindex = fishermanTask
fishermanTask.storage = 52700
fishermanTask.aid = 5564

-- function fishermanTask:canDigWorm(position)
    
    -- local x = position.x
	-- local y = position.y
	-- local z = position.z
	
	
	-- for i, v in pairs(FISHERMAN_SHOVEL["Positions"]) do
	    -- if v.x == x and v.y == y and v.z == z then
		   -- return true
		-- end
	-- end
	
	-- return false
-- end


function fishermanTask:setDigingGrounds()
    
	local fromTable = FISHERMAN_SHOVEL["Positions"]["From Position"]
	local from = Position(fromTable[1], fromTable[2], fromTable[3])
	local toTable = FISHERMAN_SHOVEL["Positions"]["To Position"]
	local to = Position(toTable[1], toTable[2], toTable[3])

    for x = from.x, to.x do
        for y = from.y, to.y do
            for z = from.z, to.z do
			    local pos = Position(x, y, z)
				if pos then
				   local tile = Tile(pos)
				   if tile then
				      local ground = tile:getGround()
					  if ground then
					     ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, fishermanTask.aid + 1)
					  end
				    end
			    end
			end
		end
	end
end

		
function fishermanTask:setQuestLogMission(player, index, value)
      
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
	  
	player:setStorageValue(fishermanTask.storage + index, value)
end

function fishermanTask:getQuestLogMission(player, index)
      
	  if not player then
	     return nil
	  end
	  
	  if not index then
	     print("INDEX NOT FOUND")
		 return nil
	  end
	  
	  local value = player:getStorageValue(fishermanTask.storage + index)
	  
	  if value < 1 then
	     value = 0
	  end
	  
	  return value
end
		   
function fishermanTask:addActionID()
		for index, fishermanTasks in pairs(FISHERMAN_TASKS) do
	        for i, itemTable in pairs(fishermanTasks["Required Items"]) do  
			    if itemTable.type == "item" then
				   fishermanTask.aid = fishermanTask.aid + 1
				   FISHERMAN_TASKS[index]["Required Items"][i].actionid = fishermanTask.aid
				end
		    end
	    end
end
fishermanTask:addActionID()

function fishermanTask:findByActionID(value)
         
		for index, fishermanTasks in pairs(FISHERMAN_TASKS) do
	        for i, itemTable in pairs(fishermanTasks["Required Items"]) do 
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
			
function fishermanTask:prepare()
	local questIndex = 1
	while true do
		if (not Quests[questIndex]) then
			Quests[questIndex] = {
				name = "Fisherman Tasks",
				startStorageId = fishermanTask.storage + 1,
				startStorageValue = 1,
				missions = {
					[1] = {
						name = "Mission 1.",
						storageId = fishermanTask.storage + 1 ,
						missionId = fishermanTask.storage + 1,
						startValue = 1,
						endValue = 2,
                        states = {
						          [1] = "The fisherman asked me to bring " .. fishermanTask:getItemList(FISHERMAN_TASKS[1]["Required Items"], true)["String"],
						          [2] = "I have completed this mission."
                                 },
					},
					[2] = {
						name = "Mission 2.",
						storageId = fishermanTask.storage + 2,
						missionId = fishermanTask.storage + 2,
						startValue = 1,
						endValue = 2,
                        states = {
						          [1] = "The fisherman asked me to bring " .. fishermanTask:getItemList(FISHERMAN_TASKS[2]["Required Items"], true)["String"],
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

function fishermanTask:setMission(player, value)
      
	  if not player then
	     return nil
	  end
	  
	player:setStorageValue(fishermanTask.storage, value)
end

function fishermanTask:getMission(player)
      
	  if not player then
	     return nil
	  end
	  
	  local value = player:getStorageValue(fishermanTask.storage)
	  
	  if value < 1 then
	     value = 0
	  end
	  
	  return value
end

function fishermanTask:countItems(t)

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

function fishermanTask:getItemList(t, method)

    local str = ""
	local list = {}
		  for index, requireditem in pairs(t) do
		      if requireditem.type == "item" then
		         local id = requireditem.id
			     local count = requireditem.count
				 local itemTable = { ["itemid"] = id, ["count"] = count }
				 table.insert(list, itemTable)
		         if index == fishermanTask:countItems(t) and fishermanTask:countItems(t) > 1 then
				    if method then
					   str = str .. " and " .. count .. "x " .. getItemName(id) .. "."
					   else
			           str = str .. " and " .. count .. "x " .. "{" .. getItemName(id) .. "}" .. "."
					end
				 else
				    if index == fishermanTask:countItems(t) - 1 or fishermanTask:countItems(t) == 1 then
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

function fishermanTask:getMissingItemList(t)
      
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

function fishermanTask:countMoney(t)

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

function fishermanTask:removeItems(player, t)
      
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

function fishermanTask:startup()
    	
	for index, fishermanTasks in pairs(FISHERMAN_TASKS) do
	    for i, itemTable in pairs(fishermanTasks["Required Items"]) do 
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
					 if items then
				        for index, item in pairs(items) do
				            item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, itemTable.actionid)
				        end
				     end
				   end
			   end
			end
	    end
	end
	
end

local globalevent = GlobalEvent("load_Fisherman")
function globalevent.onStartup()
    fishermanTask:setDigingGrounds()
	fishermanTask:prepare()
	fishermanTask:startup()
end
globalevent:register()

local creaturescript = CreatureEvent("Fisherman_onLogin")
function creaturescript.onLogin(player)
    if player:getStorageValue(fishermanTask.storage) < 0 then
	   player:setStorageValue(fishermanTask.storage, 0)
	end	
	return true
end
creaturescript:register()

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
         
		local t = fishermanTask:findByActionID(item:getActionId()) 
		if not t then
		   return true
		end
		
		local id = t["Table"].id
		local count = t["Table"].count
		local name = getItemName(id)
		local index = t["Index"]
		
		if player:getStorageValue(fishermanTask.storage + index + 3) > 0 then
		   player:sendCancelMessage("You have already picked this item.")
		   return true
		end
		
		local pos = player:getPosition()
		player:addItem(id, count)
		pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got a " .. count .. "x " .. name .. ".")
		player:setStorageValue(fishermanTask.storage + index + 3, 1)
		
return true
end

for index, fishermanTasks in pairs(FISHERMAN_TASKS) do
	for i, itemTable in pairs(fishermanTasks["Required Items"]) do  
		if itemTable.type == "item" then
		   local actionid = itemTable.actionid
		   if actionid then
		      action:aid(actionid)
		   end
		end
    end
end
action:register()



