ERLAND_TASKS = {
                    [1] = { 
					        ["Reward"] = { id = 31625, count = 1 },
					        ["Required Items"] = { 
												   { type = "item", id = 5914, count = 100, title = "You can find this item " }, -- tu mozna uzupelnic co npc mowi jak ktos napisze  do npcka o potrzebny skladnik. (usunac title jak nniepotrzebne)
												   { type = "item", id = 5911, count = 100, title = "You can find this item " },
												   { type = "item", id = 5910, count = 100, title = "You can find this item " },
												   { type = "item", id = 5913, count = 100, title = "You can find this item " },
												   { type = "item", id = 5912, count = 100, title = "You can find this item " },
                                                   { type = "item", id = 5909, count = 100, title = "You can find this item " },
												   { type = "item", id = 5920, count = 100, title = "You can find this item " },
												   { type = "item", id = 5890, count = 100, title = "You can find this item " },
												   { type = "item", id = 5882, count = 100, title = "You can find this item " },
												   { type = "item", id = 5948, count = 100, title = "You can find this item " },
												   { type = "item", id = 5877, count = 100, title = "You can find this item " },
												   
												 },
						    ["Messages"] = {
							                  [1] = "Okay, your mission is: bring ",
											  [2] = "Do you have all required items? ",
										   }
						   },
				   }
				   
erlandTask = { }
erlandTask.__newindex = erlandTask
erlandTask.storage = 27301
erlandTask.aid = 6000
				   
function erlandTask:addActionID()
		for index, erlandTasks in pairs(ERLAND_TASKS) do
	        for i, itemTable in pairs(erlandTasks["Required Items"]) do  
			    if itemTable.type == "item" then
				   erlandTask.aid = erlandTask.aid + 1
				   ERLAND_TASKS[index]["Required Items"][i].actionid = erlandTask.aid
				end
		    end
	    end
end
erlandTask:addActionID()

function erlandTask:findByActionID(value)
         
		for index, erlandTasks in pairs(ERLAND_TASKS) do
	        for i, itemTable in pairs(erlandTasks["Required Items"]) do 
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
			
function erlandTask:prepare()
	local questIndex = 1
	while true do
		if (not Quests[questIndex]) then
			Quests[questIndex] = {
				name = "Erland Request",
				startStorageId = erlandTask.storage,
				startStorageValue = 1,
				missions = {
					[1] = {
						name = "Brand New Backpack.",
						storageId = erlandTask.storage,
						missionId = erlandTask.storage,
						startValue = 1,
						endValue = 2,
                        states = {
						          [1] = "Erland asked me to bring " .. erlandTask:getItemList(ERLAND_TASKS[1]["Required Items"], true)["String"],
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

function erlandTask:setMission(player, value)
      
	  if not player then
	     return nil
	  end
	  
	player:setStorageValue(erlandTask.storage, value)
end

function erlandTask:getMission(player)
      
	  if not player then
	     return nil
	  end
	  
	  local value = player:getStorageValue(erlandTask.storage)
	  
	  if value < 1 then
	     value = 0
	  end
	  
	  return value
end

function erlandTask:countItems(t)

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

function erlandTask:getItemList(t, method)

    local str = ""
	local list = {}
		  for index, requireditem in pairs(t) do
		      if requireditem.type == "item" then
		         local id = requireditem.id
			     local count = requireditem.count
				 local itemTable = { ["itemid"] = id, ["count"] = count }
				 table.insert(list, itemTable)
		         if index == erlandTask:countItems(t) and erlandTask:countItems(t) > 1 then
				    if method then
					   str = str .. " and " .. count .. "x " .. getItemName(id) .. "."
					   else
			           str = str .. " and " .. count .. "x " .. "{" .. getItemName(id) .. "}" .. "."
					end
				 else
				    if index == erlandTask:countItems(t) - 1 or erlandTask:countItems(t) == 1 then
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

function erlandTask:getMissingItemList(t)
      
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

function erlandTask:countMoney(t)

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

function erlandTask:removeItems(player, t)
      
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

local globalevent = GlobalEvent("load_Erland")
function globalevent.onStartup()
	erlandTask:prepare()
	
	for index, erlandTasks in pairs(ERLAND_TASKS) do
	    for i, itemTable in pairs(erlandTasks["Required Items"]) do 
            if itemTable.type == "item" then
			   local pos = itemTable.position 
			   if pos then
			      local position = Position(pos.x, pos.y, pos.z)
				  local tile = Tile(position)
				  local items = tile:getItems()
				  for index, item in pairs(items) do
				      item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, itemTable.actionid)
				  end
			   end
			end
	    end
	end
end
globalevent:register()

-- local creaturescript = CreatureEvent("Erland_onLogin")
-- function creaturescript.onLogin(player)
    -- if player:getStorageValue(erlandTask.storage) < 0 then
	   -- player:setStorageValue(erlandTask.storage, 0)
	-- end	
	-- return true
-- end
-- creaturescript:register()

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
         
		local t = erlandTask:findByActionID(item:getActionId()) 
		if not t then
		   return true
		end
		
		local id = t["Table"].id
		local count = t["Table"].count
		local name = getItemName(id)
		local index = t["Index"]
		
		if player:getStorageValue(erlandTask.storage + index) > 0 then
		   player:sendCancelMessage("You have already picked this item.")
		   return true
		end
		
		local pos = player:getPosition()
		player:addItem(id, count)
		pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got a " .. count .. "x " .. name .. ".")
		player:setStorageValue(erlandTask.storage + index, 1)
		
return true
end

for index, erlandTasks in pairs(ERLAND_TASKS) do
	for i, itemTable in pairs(erlandTasks["Required Items"]) do  
		if itemTable.type == "item" then
		   local actionid = itemTable.actionid
		   if actionid then
		      action:aid(actionid)
		   end
		end
    end
end
action:register()




