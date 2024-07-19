WOLFHUNTER_TASKS = {
                    [1] = { 
					        ["Reward"] = { 
							               { type = "experience", value = 100000 },
										   { type = "item", id = 3043, count = 5 },
										 },
							
							["Required Items"] = { },
							
					        ["Required Monster"] = { name = "Wolf", count = 25 },
							                       
						    ["Messages"] = {
							                  [1] = "Okay, your first mission is: kill ",
											  [2] = "Have you killed all monsters? ",
											  [3] = "Congratulations, You have finished your first mission.",
										   }
						   },
                    [2] = { 
					        ["Reward"] = { 
							               { type = "access", name = "ghost wolf access", position = { 919, 1051, 8 } }
										 },
					        ["Required Items"] = { 
							                       { type = "item", id = 10318, count = 1 },
												 },
						    ["Messages"] = {
							                  [1] = "Okay, your second mission is: bring ",
											  [2] = "Do you have all required items? ",
											  [3] = "Congratulations, You have finished your second mission. Now you can hunt ghost wolves.",
										   }
						   },				
				}
				   
wolfhunterTask = { }
wolfhunterTask.__newindex = wolfhunterTask
wolfhunterTask.storage = 58111
wolfhunterTask.aid = 6500
wolfhunterTask.access = 10318

function wolfhunterTask:updateTracker(player, key, logg)
    
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

function wolfhunterTask:getKills(player)
    local storage = wolfhunterTask.storage - 100
	
	if player:getStorageValue(storage) < 0 then
	   return -1
	end
	
	return player:getStorageValue(storage)
end

function wolfhunterTask:getKillTask(highlight)
        
    local str = ""
    
    local name = WOLFHUNTER_TASKS[1]["Required Monster"].name
	local count = WOLFHUNTER_TASKS[1]["Required Monster"].count
	
	local str2 = "{" .. name .. "}"
	
	if highlight then
	    name = str2
	end
	str = str .. count .. " " .. name
	
	return str
end

function wolfhunterTask:setKillTask(player)
	local storage = wolfhunterTask.storage - 100
	local count = WOLFHUNTER_TASKS[1]["Required Monster"].count
	return player:setStorageValue(storage, count)
end
   
function wolfhunterTask:setKills(player)
    local storage = wolfhunterTask.storage - 100
	
	if player:getStorageValue(storage) <= 0 then
	   return
	end
	
	return player:setStorageValue(storage, player:getStorageValue(storage) - 1)
end

function wolfhunterTask:startup()
	for index, config in pairs(WOLFHUNTER_TASKS) do
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
					 ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, wolfhunterTask.access)
				  end
			   end
			end
		end
	end
	
end

function wolfhunterTask:getAccess(player, item)

    if not player then
	   return nil
	end
	
	if not item then
	   return nil
	end
		
	if item:getAttribute(ITEM_ATTRIBUTE_ACTIONID) == wolfhunterTask.access then
	   if wolfhunterTask:getQuestLogMission(player, 2) == 2 then
	      return true
	   end
	end
	
	return false
end

function wolfhunterTask:addActionID()
		for index, wolfhunterTasks in pairs(WOLFHUNTER_TASKS) do
	        for i, itemTable in pairs(wolfhunterTasks["Required Items"]) do  
			    if itemTable.type == "item" then
				   wolfhunterTask.aid = wolfhunterTask.aid + 1
				   WOLFHUNTER_TASKS[index]["Required Items"][i].actionid = wolfhunterTask.aid
				end
		    end
	    end
end
wolfhunterTask:addActionID()

function wolfhunterTask:findByActionID(value)
         
		for index, wolfhunterTasks in pairs(WOLFHUNTER_TASKS) do
	        for i, itemTable in pairs(wolfhunterTasks["Required Items"]) do 
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
			
function wolfhunterTask:prepare()
	local questIndex = 1
	while true do
		if (not Quests[questIndex]) then
			Quests[questIndex] = {
				name = "Wolf Hunter Request",
				startStorageId = wolfhunterTask.storage + 1,
				startStorageValue = 1,
				missions = {
					[1] = {
						name = "Killing the Wolves.",
						storageId = wolfhunterTask.storage + 1,
						missionId = wolfhunterTask.storage + 1,
						startValue = 1,
						endValue = 3,
                        states = {
						          [1] = function(player)
								           return string.format("I have to kill " .. wolfhunterTask:getKills(player) .. " " .. WOLFHUNTER_TASKS[1]["Required Monster"].name .. "s.")
										end,
								  [2] = "report to Wolf Hunter.",
						          [3] = "I have completed this mission.",
                                 },
					},
					[2] = {
						name = "Obtain the skin.",
						storageId = wolfhunterTask.storage + 2,
						missionId = wolfhunterTask.storage + 2,
						startValue = 1,
						endValue = 2,
                        states = {
						          [1] = "Wolf Hunter asked me to bring " .. wolfhunterTask:getItemList(WOLFHUNTER_TASKS[2]["Required Items"], true)["String"],
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

function wolfhunterTask:setMission(player, value)
      
	  if not player then
	     return nil
	  end
	  
	player:setStorageValue(wolfhunterTask.storage, value)
end

function wolfhunterTask:getMission(player)
      
	  if not player then
	     return nil
	  end
	  
	  local value = player:getStorageValue(wolfhunterTask.storage)
	  
	  if value < 1 then
	     value = 0
	  end
	  
	  return value
end

function wolfhunterTask:setQuestLogMission(player, index, value)
      
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
	  
	player:setStorageValue(wolfhunterTask.storage + index, value)
end

function wolfhunterTask:getQuestLogMission(player, index)
      
	  if not player then
	     return nil
	  end
	  
	  if not index then
	     print("INDEX NOT FOUND")
		 return nil
	  end
	  
	  local value = player:getStorageValue(wolfhunterTask.storage + index)
	  
	  if value < 1 then
	     value = 0
	  end
	  
	  return value
end

function wolfhunterTask:countItems(t)

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

function wolfhunterTask:getItemList(t, method)

    local str = ""
	local list = {}
		  for index, requireditem in pairs(t) do
		      if requireditem.type == "item" then
		         local id = requireditem.id
			     local count = requireditem.count
				 local itemTable = { ["itemid"] = id, ["count"] = count }
				 table.insert(list, itemTable)
		         if index == wolfhunterTask:countItems(t) and wolfhunterTask:countItems(t) > 1 then
				    if method then
					   str = str .. " and " .. count .. "x " .. getItemName(id) .. "."
					   else
			           str = str .. " and " .. count .. "x " .. "{" .. getItemName(id) .. "}" .. "."
					end
				 else
				    if index == wolfhunterTask:countItems(t) - 1 or wolfhunterTask:countItems(t) == 1 then
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

function wolfhunterTask:getMissingItemList(t)
      
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

function wolfhunterTask:countMoney(t)

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

function wolfhunterTask:removeItems(player, t)
      
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

function wolfhunterTask:addRewards(player, t)
         
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
		      	if index == wolfhunterTask:countItems(t) and wolfhunterTask:countItems(t) > 1 then
				    if method then
					   str = str .. " and " .. count .. "x " .. getItemName(id) .. "."
					   else
			           str = str .. " and " .. count .. "x " .. "{" .. getItemName(id) .. "}" .. "."
					end
				 else
				    if index == wolfhunterTask:countItems(t) - 1 or wolfhunterTask:countItems(t) == 1 then
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

local globalevent = GlobalEvent("load_Wolfhunter")
function globalevent.onStartup()
	wolfhunterTask:prepare()
	
	for index, wolfhunterTasks in pairs(WOLFHUNTER_TASKS) do
	    for i, itemTable in pairs(wolfhunterTasks["Required Items"]) do 
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

local creaturescript = CreatureEvent("Wolfhunter_onLogin")
function creaturescript.onLogin(player)
    player:registerEvent("Wolfhunter_onKill")
    -- if player:getStorageValue(wolfhunterTask.storage) < 0 then
	   -- player:setStorageValue(wolfhunterTask.storage, 0)
	-- end	
	return true
end
creaturescript:register()

creatureevent = CreatureEvent("Wolfhunter_onKill")
function creatureevent.onKill(player, target)
    
	if not player then
	   return true
	end
	
	if not target then
	   return true
	end
	
	if wolfhunterTask:getQuestLogMission(player, 1) == 1 then
	   local name = target:getName():lower()
	   if name == WOLFHUNTER_TASKS[1]["Required Monster"].name:lower() then
	      wolfhunterTask:setKills(player)
		  if wolfhunterTask:getKills(player) == 0 then
		     wolfhunterTask:setQuestLogMission(player, 1, 2)
		  end
		  wolfhunterTask:updateTracker(player, wolfhunterTask.storage + 1)
	   end
    end
	
	return true
end
creatureevent:register()
	
local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
         
		local t = wolfhunterTask:findByActionID(item:getActionId()) 
		if not t then
		   return true
		end
		
		local id = t["Table"].id
		local count = t["Table"].count
		local name = getItemName(id)
		local index = t["Index"]
		
		if player:getStorageValue(wolfhunterTask.storage + index) > 0 then
		   player:sendCancelMessage("You have already picked this item.")
		   return true
		end
		
		local pos = player:getPosition()
		player:addItem(id, count)
		pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got a " .. count .. "x " .. name .. ".")
		player:setStorageValue(wolfhunterTask.storage + index, 1)
		
return true
end

for index, wolfhunterTasks in pairs(WOLFHUNTER_TASKS) do
	for i, itemTable in pairs(wolfhunterTasks["Required Items"]) do  
		if itemTable.type == "item" then
		   local actionid = itemTable.actionid
		   if actionid then
		      action:aid(actionid)
		   end
		end
    end
end
action:register()

local moveevent = MoveEvent()
moveevent:type("stepin")
function moveevent.onStepIn(creature, item, position, fromPosition)
    
	local player = Player(creature)
	
	if not player then
		return true
	end

	if not wolfhunterTask:getAccess(player, item) then
	   player:teleportTo(fromPosition)
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "You are not allowed to access this place.")
	   return false
	end
	
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	return true

end
moveevent:aid(wolfhunterTask.access)
moveevent:register()

local globalevent = GlobalEvent("Wolf Hunter - Prepare")
function globalevent.onStartup()
	wolfhunterTask:startup()
	return true
end
globalevent:register()


