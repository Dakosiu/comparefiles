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

-- function discoverTask:getKills(player)
    -- local storage = discoverTask.storage - 100
	
	-- if player:getStorageValue(storage) < 0 then
	   -- return -1
	-- end
	
	-- return player:getStorageValue(storage)
-- end

-- function discoverTask:getKillTask()
        
    -- local str = ""
    
	-- if not DISCOVER_TASKS[1]["Required Monster"] then
	   -- return ""
	-- end
	
    -- local name = DISCOVER_TASKS[1]["Required Monster"].name
	-- local count = DISCOVER_TASKS[1]["Required Monster"].count
	
	-- str = str .. count .. " " .. name
	
	-- return str
-- end


-- function discoverTask:setKillTask(player)
	-- if not DISCOVER_TASKS[1]["Required Monster"] then
	   -- return
	-- end
	-- local storage = discoverTask.storage - 100
	-- local count = DISCOVER_TASKS[1]["Required Monster"].count
	-- return player:setStorageValue(storage, count)
-- end
   

-- function discoverTask:setKills(player)
    -- local storage = discoverTask.storage - 100
	
	-- if player:getStorageValue(storage) <= 0 then
	   -- return
	-- end
	
	-- return player:setStorageValue(storage, player:getStorageValue(storage) - 1)
-- end

-- function discoverTask:startup()
    	
	-- for index, disovererTasks in pairs(DISCOVER_TASKS) do
	    -- for i, itemTable in pairs(disovererTasks["Required Items"]) do 
            -- if itemTable.type == "item" then
			   -- local pos = itemTable.position 
			   -- if pos then
			      -- local position = Position(pos.x, pos.y, pos.z)
				  -- local tile = Tile(position)
				  -- if tile then
				     -- local ground = tile:getGround()
					 -- if ground then
					    -- ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, itemTable.actionid)
				     -- end
				     -- local items = tile:getItems()
				     -- for index, item in pairs(items) do
				         -- item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, itemTable.actionid)
				     -- end
				   -- end
			   -- end
			-- end
	    -- end
	-- end
	
-- end

-- function discoverTask:getAccess(player, item)

    -- if not player then
	   -- return nil
	-- end
	
	-- if not item then
	   -- return nil
	-- end
		
	-- if item:getAttribute(ITEM_ATTRIBUTE_ACTIONID) == discoverTask.access then
	   -- if discoverTask:getQuestLogMission(player, 2) == 2 then
	      -- return true
	   -- end
	-- end
	
	-- return false
-- end


-- function discoverTask:addActionID()
		-- for index, discoverTasks in pairs(DISCOVER_TASKS) do
	        -- for i, itemTable in pairs(discoverTasks["Required Items"]) do  
			    -- if itemTable.type == "item" then
				   -- discoverTask.aid = discoverTask.aid + 1
				   -- DISCOVER_TASKS[index]["Required Items"][i].actionid = discoverTask.aid
				-- end
		    -- end
	    -- end
-- end
-- discoverTask:addActionID()

-- function discoverTask:findByActionID(value)
         
		-- for index, discoverTasks in pairs(DISCOVER_TASKS) do
	        -- for i, itemTable in pairs(discoverTasks["Required Items"]) do 
                -- if itemTable.type == "item" then
                   -- if itemTable.actionid == value then
				      -- local values = { ["Index"] = i, ["Table"] = itemTable }
                      -- return values
                   -- end
                -- end
            -- end
        -- end

-- return nil
-- end		
			
-- function discoverTask:prepare()
	-- local questIndex = 1
	-- while true do
		-- if (not Quests[questIndex]) then
			-- Quests[questIndex] = {
				-- name = "Discoverer Issues",
				-- startStorageId = discoverTask.storage + 1,
				-- startStorageValue = 1,
				-- missions = {
					-- [1] = {
						-- name = "Witch and her broom.",
						-- storageId = discoverTask.storage + 1,
						-- missionId = discoverTask.storage + 1,
						-- startValue = 1,
						-- endValue = 2,
                        -- states = {
						          -- [1] = "I should visit the witch and.. obtain the broom from her.. maybe there is a way to not killing her.",
						          -- [2] = "I have completed this mission.",
                                 -- },
					-- },
					-- [2] = {
						-- name = "Magicial vial of poison.",
						-- storageId = discoverTask.storage + 2,
						-- missionId = discoverTask.storage + 2,
						-- startValue = 1,
						-- endValue = 2,
                        -- states = {
						          -- [1] = "Discoverer ask me to bring: " .. discoverTask:getItemList(DISCOVER_TASKS[2]["Required Items"], true)["String"],
						          -- [2] = "I have completed this mission."
                                 -- },
					-- },
			    -- }
			-- }
			-- break
		-- end
		-- questIndex = questIndex + 1
	-- end
-- end

-- function discoverTask:setMission(player, value)
      
	  -- if not player then
	     -- return nil
	  -- end
	  
	-- player:setStorageValue(discoverTask.storage, value)
-- end

-- function discoverTask:getMission(player)
      
	  -- if not player then
	     -- return nil
	  -- end
	  
	  -- local value = player:getStorageValue(discoverTask.storage)
	  
	  -- if value < 1 then
	     -- value = 0
	  -- end
	  
	  -- return value
-- end


-- function discoverTask:setQuestLogMission(player, index, value)
      
	  -- if not player then
	     -- print("PLAYER NOT FOUND")
	     -- return nil
	  -- end
	  
	  -- if not value then
	     -- print("VALUE NOT FOUND")
		 -- return nil
	  -- end
	  
	  -- if not index then
	     -- print("INDEX NOT FOUND")
		 -- return nil
	  -- end
	  
	-- player:setStorageValue(discoverTask.storage + index, value)
-- end

-- function discoverTask:getQuestLogMission(player, index)
      
	  -- if not player then
	     -- return nil
	  -- end
	  
	  -- if not index then
	     -- print("INDEX NOT FOUND")
		 -- return nil
	  -- end
	  
	  -- local value = player:getStorageValue(discoverTask.storage + index)
	  
	  -- if value < 1 then
	     -- value = 0
	  -- end
	  
	  -- return value
-- end

-- function discoverTask:countItems(t)

      -- if not t then
         -- return nil
      -- end

      -- local value = 0

      -- for index, requireditem in pairs(t) do
          -- if requireditem.type == "item" then
		     -- value = value + 1
		  -- end
	   -- end
	   
	  -- return value
-- end

-- function discoverTask:getItemList(t, method)

    -- local str = ""
	-- local list = {}
		  -- for index, requireditem in pairs(t) do
		      -- if requireditem.type == "item" then
		         -- local id = requireditem.id
			     -- local count = requireditem.count
				 -- local itemTable = { ["itemid"] = id, ["count"] = count }
				 -- table.insert(list, itemTable)
		         -- if index == discoverTask:countItems(t) and discoverTask:countItems(t) > 1 then
				    -- if method then
					   -- str = str .. " and " .. count .. "x " .. getItemName(id) .. "."
					   -- else
			           -- str = str .. " and " .. count .. "x " .. "{" .. getItemName(id) .. "}" .. "."
					-- end
				 -- else
				    -- if index == discoverTask:countItems(t) - 1 or discoverTask:countItems(t) == 1 then
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
		  
	-- local values = { ["String"] = str, ["List"] = list }
    -- return values
-- end	

-- function discoverTask:getMissingItemList(t)
      
	  -- if not t then
	     -- return nil
	  -- end
	  
	  -- local str = ""
	  -- for index, missingItem in pairs(t) do
	      -- local id = missingItem["itemid"]
		  -- local count = missingItem["count"]
		  
		     -- if index == #t and #t > 1 then
			        -- str = str .. " and " .. count .. "x " .. "{" .. getItemName(id) .. "}"
				 -- else
				    -- if index == #t - 1 or #t == 1 then
				       -- str = str .. count .. "x " .. "{" .. getItemName(id) .. "}"
					-- else
					   -- str = str .. count .. "x " .. "{" .. getItemName(id) .. "}" .. ", "
					-- end
		     -- end
	   -- end  
	   
	-- return str
-- end

-- function discoverTask:countMoney(t)

      -- if not t then
         -- return nil
      -- end

      -- local value = 0

      -- for index, requireditem in pairs(t) do
          -- if requireditem.type == "money" then
		     -- value = value + requireditem.value
		  -- end
	  -- end
	   
	  -- return value
-- end

-- function discoverTask:removeItems(player, t)
      
      -- if not player then 
         -- return nil
      -- end
      
      -- if not t then
         -- return nil
      -- end
   	  
	  -- for index, v in pairs(t) do
	      -- local id = v["itemid"]
		  -- local count = v["count"]
	      -- player:removeItem(id, count)
	  -- end
	  -- local pos = player:getPosition()
	  -- pos:sendMagicEffect(CONST_ME_MAGIC_RED)

-- end

-- function discoverTask:countExperience(t)

      -- if not t then
         -- return nil
      -- end

      -- local value = 0

      -- for index, requireditem in pairs(t) do
          -- if requireditem.type == "experience" then
		     -- value = value + requireditem.value
		  -- end
	  -- end
	   
	  -- return value
-- end

-- function discoverTask:addRewards(player, t, text)
            
      -- if not t then
         -- return nil
      -- end
	  
	  -- local list = "You have received: "
	  
	  -- for index, v in pairs(t) do
	      -- if v.type == "item" then
	  	     -- local id = v.id
		     -- local count = v.count
			 -- if not text then
			    -- player:addItem(id, count)
		     -- end
			 -- if index == discoverTask:countItems(t) or discoverTask:countItems(t) == 1 then
			    -- list = list .. count .. "x " .. getItemName(id)
		     -- else
			    -- list = list .. count .. "x " .. getItemName(id) .. ", "
			 -- end
		  -- end
	  -- end
	  
	  -- local experience = discoverTask:countExperience(t)
	  
	  -- if experience > 0 then
	     -- list = list .. " and " .. experience .. " experience."
	  -- end
	  
	  -- if text then
	     -- return list
      -- end
-- end

-- local globalevent = GlobalEvent("load_Discoverer")
-- function globalevent.onStartup()
	-- discoverTask:prepare()
	
	-- for index, discoverTasks in pairs(DISCOVER_TASKS) do
	    -- for i, itemTable in pairs(discoverTasks["Required Items"]) do 
            -- if itemTable.type == "item" then
			   -- local pos = itemTable.position 
			   -- if pos then
			      -- local position = Position(pos.x, pos.y, pos.z)
				  -- local tile = Tile(position)
				  -- if tile then
				     -- local ground = tile:getGround()
					 -- ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, itemTable.actionid)
				     -- local items = tile:getItems()
				     -- for index, item in pairs(items) do
				         -- item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, itemTable.actionid)
				     -- end
				   -- end
			   -- end
			-- end
	    -- end
	-- end
-- end
-- globalevent:register()

-- local creaturescript = CreatureEvent("Discoverer_onLogin")
-- function creaturescript.onLogin(player)
    -- player:registerEvent("Discoverer_onKill")
	
    -- -- if player:getStorageValue(discoverTask.storage) < 0 then
	   -- -- player:setStorageValue(discoverTask.storage, 0)
	-- --end	
	-- return true
-- end
-- creaturescript:register()

-- creatureevent = CreatureEvent("Discoverer_onKill")
-- function creatureevent.onKill(player, target)
    
	-- if not player then
	   -- return true
	-- end
	
	-- if not target then
	   -- return true
	-- end
	
	-- if not DISCOVER_TASKS[1]["Required Monster"] then
	   -- return true
	-- end
	
	-- if discoverTask:getQuestLogMission(player, 1) == 1 then
	   -- local name = target:getName():lower()
	   

	   -- if name == DISCOVER_TASKS[1]["Required Monster"].name:lower() then
	      -- discoverTask:setKills(player)
		  
		  -- if discoverTask:getKills(player) == 0 then
	         -- player:say("CONGRATULATIONS YOU HAVE KILLED ALL WOLFS")
		  -- return true
	      -- end
		  -- player:say("There still left " .. discoverTask:getKills(player))
	   -- end
    -- end
	
	-- return true
-- end
-- creatureevent:register()
	
-- local action = Action()
-- function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
         
		-- local t = discoverTask:findByActionID(item:getActionId()) 
		-- if not t then
		   -- return true
		-- end
		
		-- local id = t["Table"].id
		-- local count = t["Table"].count
		-- local name = getItemName(id)
		-- local index = t["Index"]
		
		-- if player:getStorageValue(discoverTask.storage - 50) > 0 then
		   -- player:sendCancelMessage("You have already picked this item.")
		   -- return true
		-- end
		
		-- local pos = player:getPosition()
		-- player:addItem(id, count)
		-- pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		-- player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got a " .. count .. "x " .. name .. ".")
		-- player:setStorageValue(discoverTask.storage - 50, 1)
		
-- return true
-- end

-- for index, discoverTasks in pairs(DISCOVER_TASKS) do
	-- for i, itemTable in pairs(discoverTasks["Required Items"]) do  
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

	-- if not discoverTask:getAccess(player, item) then
	   -- player:teleportTo(fromPosition)
	   -- player:sendTextMessage(MESSAGE_INFO_DESCR, "You are not allowed to access this place.")
	   -- return false
	-- end
	
	-- player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	-- return true

-- end
-- moveevent:aid(discoverTask.access)
-- moveevent:register()

-- local globalevent = GlobalEvent("Discoverer - Prepare")
-- function globalevent.onStartup()
	-- discoverTask:startup()
	-- return true
-- end
-- globalevent:register()