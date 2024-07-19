-- -- CREATE TABLE `worldquests_data` (
  -- -- `name` varchar(255) NOT NULL,
  -- -- `active` INT NOT NULL,
  -- -- `reactive` INT NOT NULL,
  -- -- `reactive_time` BIGINT NOT NULL,
  -- -- `items` text NOT NULL,
  -- -- `experience_boost` BIGINT NOT NULL,
  -- -- PRIMARY KEY (`name`)
-- -- )


-- WORLD_QUESTS =  {
                    -- ["Lantern Quest"] = { 
					                    -- ["Re-Active"] = { enabled = true, _onlyReactiveOnFinished = false, interval = { value = 5, type = "minutes" } },  --- type  minutes, seconds, hours
				                        -- ["Scheduler"] = {
						                                  -- ["Everyday"] = { "03:28", "08:15" },
										                -- },
										-- ["NPC"] = { name = "Gary", 
										            -- lookType = 128,
													-- ["Messages"] =  {
													                  -- ["onReceiveQuest"] = function(text)
																      -- return "Okay, Brave Warrior, as u hear from the King my lantern is broken and i'll need some ingredients to repair my lantern" .. text
                                                                      -- end,
																    -- }
												  -- },
										-- ["Text"] = function(name)
								                   -- return "Brave warriors, The King ask you to help " .. name .. ", his lantern is broken and need some ingredients to repair the lantern.."
									               -- end,
					                    -- ["Burners"] = { 
										                -- { 32351, 31792, 7 }, --- tutaj pozycje pieca
													  -- },  
				                        -- ["Required Items"] = {
				                                                -- [5891] = {
																           -- text = "You can find this item by hunting monsters or just harvest it from the nearby trees.",
															               -- count = 1,
																	       -- ["Monsters Drop"] = { 
																		                         -- ["Every"] = { chance = 30, count = { min = 1, max = 2 } }, -- every = każdy
																							   -- },
																		   -- ["Harvest"] = { 
																		                  -- { tree_id = 3626, transfer_to = 3624, cooldown = 30 },
																						 -- },
																		 -- },
				                                                -- [5890] = {
																           -- text = "You can find this item by hunting rat type of monsters.",
															               -- count = 1,
																		   -- ["Monsters Drop"] = { 
																		                         -- ["Rat"] = { chance = 30, count = { min = 1, max = 2 } },
																								 -- ["Cave Rat"] = { chance = 40, count = { min = 1, max = 3 } },
																							   -- }
																		 -- },
															 -- },
				                        -- ["Rewards"] = {
								                        -- ["Boosts"] = { 
								                                       -- ["Experience"] = { duration = 1, type = "hours", multiplier = 0.5 },  --- type  minutes, seconds, hours
												                     -- }
								                      -- },
				                        -- }
			    -- }
				   
				                   

-- worldQuests = { }
-- worldQuests.__newindex = worldQuests
-- worldQuests.storageid = 12774
-- worldQuests.database = "`worldquests_data`"
-- worldQuests.name = "WORLD_QUESTS_NAME"
-- worldQuests.itemAttributes = { name = "WORLD_QUEST_NAME" }

-- Harvesting = { }
-- Burner = { }
-- Burner.itemAttributes = { name = "BURNER_QUEST_NAME" }


-- local function tablelength(t)
  -- local count = 0
  -- for _ in pairs(t) do count = count + 1 end
  -- return count
-- end

-- function Burner:isBurner(item)
    -- if not item then
	   -- return nil
	-- end
	
	-- if worldQuests:getItemAttribute(item, Burner.itemAttributes.name) then
	   -- return true
	-- end
	-- return false
-- end

-- function Burner:isValidId(burner, find_id)
    
	-- if not find_id or not burner then
	   -- return nil
	-- end
	
	-- local name = worldQuests:getItemAttribute(burner, Burner.itemAttributes.name)
	-- if not name then
	   -- return nil
	-- end
	
	-- local t = WORLD_QUESTS[name]["Required Items"]
	-- if not t then
	   -- return nil
	-- end

	-- for id, v in pairs(t) do
	    -- if id == find_id then
		   -- return true
		-- end
    -- end
	-- return false
-- end

-- function Burner:isCurrentIndex(burner, find_id)
    
	-- if not find_id or not burner then
	   -- return nil
	-- end
	
	-- local name = worldQuests:getItemAttribute(burner, Burner.itemAttributes.name)
	-- if not name then
	   -- return nil
	-- end
	
	-- local t = worldQuests:getRequiredItems(name)
	-- if not t then
	   -- return nil
	-- end
	
	-- local index = 1
    -- for id, v in pairs(t) do
	    -- if v.current < v.count then
		   -- break
		-- end
		-- index = index + 1
    -- end
	
	-- local idIndex = worldQuests:getIdIndex(name, find_id)
	
	-- if index == idIndex then
	   -- return true
	-- end
	-- return false
-- end
	
-- function Harvesting:getTreeTransform(TreeID)
    
	-- if not TreeID then
	   -- return nil
	-- end
	
	-- for name in pairs(WORLD_QUESTS) do
	    -- local requiredTable = WORLD_QUESTS[name]["Required Items"]
	    -- if requiredTable then
	       -- for id, itemTable in pairs(requiredTable) do
	           -- local harvestTable = itemTable["Harvest"]
		       -- if harvestTable then
		          -- for index, v in pairs(harvestTable) do 
		              -- local treeid = v.tree_id
					  -- if treeid == TreeID then
					     -- local values = { ["transform_to"] = v.transfer_to, ["cooldown"] = v.cooldown, ["quest name"] = name, ["reward"] = id }
						 -- return values
					  -- end
		          -- end
		       -- end
	       -- end
	    -- end
    -- end
	-- return 0
-- end

-- function Harvesting:harvestTree(item, player)
    
	-- if not item then
	   -- return nil
	-- end
	
	-- if not player then
	   -- return nil
	-- end
	
	-- local itemid = item:getId()
	-- local treeTable = Harvesting:getTreeTransform(itemid)
	-- if not treeTable then
	   -- return false
	-- end
	
	-- local name = treeTable["quest name"]
	-- if not name then
	   -- return false
	-- end
	
	-- if not worldQuests:isActive(name) then
	   -- return player:sendCancelMessage("You cannot harvest this tree right now.")
	-- end
	
	-- local TransformTo = treeTable["transform_to"]
	-- if not TransformTo then
	   -- return false
	-- end

	-- local cooldown = treeTable["cooldown"]
	-- if not cooldown then
	   -- return false
	-- end
			
	-- local reward = treeTable["reward"]
	-- if not reward then
	   -- return false
	-- end
		
	-- item:transform(TransformTo)
	-- local pos = player:getPosition()
	-- pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	-- local rewardItem = player:addItem(reward, 1)
	-- if rewardItem then
	   -- worldQuests:setItemAttribute(rewardItem, worldQuests.itemAttributes.name, name)
	-- end
	-- local minute = 1000 * 60
	-- addEvent(function()
	    -- if item then
           -- item:transform(itemid)
		-- end
    -- end, cooldown * minute)
-- end

-- function worldQuests:setItemAttribute(item, attribute, value)
    -- if not item or not attribute or not value then
	   -- return nil
	-- end
	-- return item:setCustomAttribute(attribute, value)
-- end

-- function worldQuests:getItemAttribute(item, attribute)
   -- if not item or not attribute then
      -- return nil
   -- end
   
   -- return item:getCustomAttribute(attribute)
-- end

-- function worldQuests:getIdIndex(name, find_id)
    -- if not name or not find_id then
	   -- return nil
	-- end
	-- local t = WORLD_QUESTS[name]["Required Items"]
	-- if not t then
	   -- return nil
	-- end
	-- local index = 1
	-- for id, v in pairs(t) do
	    -- if id == find_id then
		   -- return index
		-- end
		-- index = index + 1
    -- end
	-- return false
-- end

-- function worldQuests:isQuestInDatabase(name)
    
	-- if not name then 
	   -- return nil
	-- end
	
	-- local data = db.storeQuery("SELECT `name`" .. " FROM " .. worldQuests.database)
	-- if not data then
	   -- return false
	-- end
	
	-- repeat
	   -- local resultName = result.getString(data, "name")
	   -- if name == resultName then
	      -- result.free(data);
	      -- return true
	   -- end
	-- until not result.next(data)
	-- result.free(data);
	-- return false
-- end

-- function worldQuests:createString(t, update, updateValue)
		
	-- local str = ""
	
	-- if not t then
	   -- return str
	-- end

    -- local index = 1
    -- for id, itemTable in pairs(t) do
        -- local count = itemTable.count
        -- local current = itemTable.current
		-- if not current then
		   -- current = 0
	    -- end
		-- if update then
		   -- if id == update then
		      -- if updateValue then
			     -- current = current + updateValue
			  -- else
			     -- current = current + 1
		      -- end
		   -- end
		-- end
		-- if current > count then
		   -- current = count
		-- end
        -- local values = id .. ":" .. count .. "@" .. current
		-- if index < tablelength(t) then
		   -- str = str .. values .. "#"
	    -- else
		   -- str = str .. values
		-- end
        -- index = index + 1 
    -- end
	-- return str
-- end

-- function worldQuests:getRequiredItems(name, method, config)

	-- if not name then
	   -- if method then
	      -- return ""
	   -- end
	   -- return nil
	-- end
	
	-- if config then
	   -- local items_str = ""
	   -- local t = WORLD_QUESTS[name]["Required Items"]
	   -- local length = tablelength(t)
	   -- local index = 1
	   -- for id, v in pairs(t) do
	       -- if index == length then
	          -- items_str = items_str .. "{" .. getItemName(id) .. "}" .. "."
		   -- else
		      -- items_str = items_str .. "{" .. getItemName(id) .. "}" .. ", "
		   -- end
		   -- index = index + 1
	   -- end
	   -- return items_str
	-- end
	   
	
	-- if not worldQuests:isQuestInDatabase(name) then
	   -- if method then
	      -- return ""
	   -- end
	   -- return false
	-- end
	
	-- local str = ""
	-- local data = db.storeQuery("SELECT `items`" .. " FROM " .. worldQuests.database .. " WHERE " .. "`name` = " .. '"' .. name .. '"')
	-- if data then
	   -- str = result.getString(data, "items")
	   -- result.free(data)
	-- end
	

	-- local itemsTable = {}
	-- for i in string.gmatch(str, "[^#]+") do
       -- local id = i:sub(1, i:find(":", 1, true) - 1)
	   -- id = tonumber(id)
       -- local count = string.match(i, ":(.*)")
       -- count = count:sub(1, count:find("@", 1, true) - 1)
	   -- count = tonumber(count)
       -- local current = string.match(i, "@(.*)")
	   -- current = tonumber(current)
	   -- itemsTable[id] = { ["count"] = count, ["current"] = current }
    -- end
	

	-- if method then
	   -- local index = 1
	   -- local itemsString = "\n" .. "Collect in order: " .. "\n"
	   -- local length = tablelength(itemsTable)
	   -- local index = 1
	   -- for id, v in pairs(itemsTable) do
	       -- local count = v.count
		   -- local current = v.current
		   -- local collected = count - current
		   -- if index == length then
		      -- itemsString = itemsString .. "#" .. index .. " " .. "[" .. current .. "/" .. count .. "]" .. " " .. getItemName(id) .. "."
		   -- else
		      -- itemsString = itemsString .. "#" .. index .. " " .. "[" .. current .. "/" .. count .. "]" .. " " .. getItemName(id) .. "." .. "\n"
		   -- end
           -- index = index + 1	   
	   -- end
	   -- return itemsString
	-- end
	
	
	-- return itemsTable
-- end

-- function worldQuests:getRequiredItem(name, find_id)
    -- if not name then
	   -- return nil
    -- end
	 
	-- if not find_id then
	   -- return nil
    -- end
	
	-- local itemsTable = worldQuests:getRequiredItems(name)
	-- if not itemsTable then
	   -- return false
    -- end
	-- local itemString = "You have collected "
	
    -- for id, itemTable in pairs(itemsTable) do
        -- local count = itemTable.count
        -- local current = itemTable.current
		-- if id == find_id then
		   -- itemString = itemString .. getItemName(id) .. " " .. "[" .. current .. "/" .. count .. "]" .. "."
		   -- local values = { ["itemid"] = id, ["count"] = count, ["current"] = current, ["string"] = itemString}
		   -- return values
		-- end
    -- end
	-- return false
-- end
	
-- function worldQuests:updateItem(name, id, value)
    
	-- if not name then
	   -- return nil
	-- end
	
	-- if not worldQuests:isQuestInDatabase(name) then
	   -- return false
	-- end
    
	-- local t = worldQuests:getRequiredItems(name)
	-- if not t then
	   -- return false
	-- end
	
	-- if not value then
	   -- value = 1
	-- end
	
	-- local str = worldQuests:createString(t, id, value)
	-- return db.query("UPDATE " .. worldQuests.database .. " SET `items` = " .. '"' .. str .. '"' .. " WHERE `name` = " .. '"' .. name .. '"')
-- end

-- function worldQuests:addQuestToDataBase(name)
	-- if not name then
	   -- return nil
	-- end
	-- if worldQuests:isQuestInDatabase(name) then
	   -- return worldQuests:reset(name)
	-- end 
	-- local str = ""
    -- local t = WORLD_QUESTS[name]["Required Items"]	
	-- if t then
	   -- str = worldQuests:createString(t)
	   -- db.query("INSERT INTO " .. worldQuests.database .. " (`name`, `active`, `reactive`, `reactive_time`, `items`, `experience_boost`) " .. "VALUES " .. "(" .. '"' .. name .. '"' .. ", " .. 0 .. ", " .. ", " .. 0 .. ", " .. 0 .. ", " .. '"' .. str .. '"' .. ", " .. 10 .. ");")
       -- return worldQuests:reset(name)
	-- end
	-- return false
-- end

-- function worldQuests:setActive(name, method)
    
	-- if not name then
	   -- return nil
	-- end
	
	-- if not worldQuests:isQuestInDatabase(name) then
	   -- return false
	-- end
    	
	-- local active = 0
	-- if method then
	   -- active = 1
	-- end

	
	
	-- return db.query("UPDATE " .. worldQuests.database .. " SET `active` = " .. active .. " WHERE `name` = " .. '"' .. name .. '"')
-- end

-- function worldQuests:delete(name)
	-- if not index then
	   -- return nil
	-- end
	-- return db.query("DELETE FROM " .. worldQuests.database .. " WHERE `name` = " .. '"' .. name .. '"')
-- end

-- function worldQuests:reset(name)
    -- if not name then
	   -- return nil
	-- end
	
	-- if not worldQuests:isQuestInDatabase(name) then
	   -- return false
	-- end
	
	-- local str = ""
    -- local t = WORLD_QUESTS[name]["Required Items"]	
	-- if t then
	   -- str = worldQuests:createString(t)
	   -- db.query("UPDATE " .. worldQuests.database .. " SET `items` = " .. '"' .. str .. '"' .. ", " .. "`active` = " .. 0 .. ", " .. "`reactive` = " .. 0 .. ", " .. "`reactive_time` = " .. 0 .. ", " .. "`experience_boost` = " .. 0 .. " WHERE `name` = " .. '"' .. name .. '"')
	   -- worldQuests:setActive(name, true)
	   -- worldQuests:setPlayersStorage(name, false, true)	
	   -- worldQuests:sendMessage(name .. " has started !")

	-- local reactiveTable = WORLD_QUESTS[name]["Re-Active"]
	-- if reactiveTable then
	   -- if reactiveTable.enabled then
		  -- local intervalTable = reactiveTable.interval
		  -- if intervalTable then
		     -- local duration = intervalTable.value
		     -- local method = intervalTable.type
		     -- local interval = 0
		     -- local onlyReactiveOnFinished = reactiveTable._onlyReactiveOnFinished
		     -- if string.find(method, "second") then
			    -- interval = duration
		     -- elseif string.find(method, "minute") then
			    -- interval = duration * 60
		     -- elseif string.find(method, "hour") then 
			    -- interval = duration * 60 * 60
		     -- end
             
             -- if not onlyReactiveOnFinished then
			    -- interval = interval + os.time()
			    -- db.query("UPDATE " .. worldQuests.database .. " SET `reactive` = " .. 1 .. ", " .. "`reactive_time` = " .. interval .. " WHERE `name` = " .. '"' .. name .. '"')
             -- end				
		  -- end
	   -- end
	-- end

	
	-- end
	-- return false
-- end

-- function worldQuests:isActive(name)

	-- if not name then
	   -- return nil
	-- end
	
	-- if not worldQuests:isQuestInDatabase(name) then
	   -- return false
	-- end
	
	-- local active = 0
	
	-- local data = db.storeQuery("SELECT active FROM " .. worldQuests.database .. " WHERE name = " .. '"' .. name .. '"')
	-- if data then
	   -- active = result.getNumber(data, "active")
	   -- result.free(data)
	-- end
	
	-- if active == 1 then
	   -- return true
	-- end
	-- return false
-- end

-- function worldQuests:isReactivated(name)

	-- if not name then
	   -- return nil
	-- end
	
	-- if not worldQuests:isQuestInDatabase(name) then
	   -- return false
	-- end
	
	-- local value = 0
	
	-- local data = db.storeQuery("SELECT reactive FROM " .. worldQuests.database .. " WHERE name = " .. '"' .. name .. '"')
	-- if data then
	   -- value = result.getNumber(data, "reactive")
	   -- result.free(data)
	-- end
	
	-- if value == 1 then
	   -- return true
	-- end
	-- return false
-- end

-- function worldQuests:sendMessage(message)
	-- for _, player in ipairs(Game.getPlayers()) do
		-- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
	-- end
-- end

-- function worldQuests:prepare()
	-- for name in pairs(WORLD_QUESTS) do
	    -- local burnersTable = WORLD_QUESTS[name]["Burners"]
		-- if burnersTable then
		   -- for index, burner in pairs(burnersTable) do
		       -- local x = burner[1]
			   -- local y = burner[2]
			   -- local z = burner[3]
			   -- local pos = Position(x, y, z)
			   -- if pos then
			      -- local tile = Tile(pos)
				  -- if tile then
				     -- local items = tile:getItems()
					 -- if items then
					    -- for i, item in pairs(items) do
						    -- worldQuests:setItemAttribute(item, Burner.itemAttributes.name, name)
					    -- end
				     -- end
				  -- end
			   -- end
			-- end
	    -- end
    -- end
	-- worldQuests:addToQuestLog()
-- end

-- function worldQuests:updateTracker(name, player)
    
	-- if not name then
	   -- return nil
	-- end
	
	-- local index = 1
	-- for questName in pairs(WORLD_QUESTS) do
	    -- if questName == name then
	        -- if worldQuests:isActive(questName) then
		   	    -- local key = worldQuests.storageid + index
			    -- if not player then
	               -- for _, player in ipairs(Game.getPlayers()) do
	                  -- local missions = player:getMissionsData(key)
		              -- for i = 1, #missions do
		                  -- local mission = missions[i]
		                  -- if player:hasTrackingQuest(mission.missionId) then
						     -- if not ON_REQUEST_QUESTLOG_TABLE[player:getId()] or ON_REQUEST_QUESTLOG_TABLE[player:getId()] < 1 then
		                        -- player:sendUpdateTrackedQuest(mission)
							 -- end
		                  -- end
	                  -- end
	               -- end
	            -- else
				    -- local missions = player:getMissionsData(key)
	                -- for i = 1, #missions do
		               -- local mission = missions[i]
		               -- if player:hasTrackingQuest(mission.missionId) then
		                  -- player:sendUpdateTrackedQuest(mission)
		               -- end
					-- end
	            -- end
		    -- end
		-- end
		-- index = index + 1
	-- end	
-- end

-- function worldQuests:addToQuestLog()

	-- local index = 1
	-- local questIndex = 1
	-- for questName, v in pairs(WORLD_QUESTS) do
	    -- while true do  
		    -- if (not Quests[questIndex]) then
			    -- Quests[questIndex] = {
			                           -- name = "World Quests",
				                       -- startStorageId = worldQuests.storageid,
				                       -- startStorageValue = 1,
				                       -- missions = {}
			                         -- }				 
			    -- break
	        -- end
			-- questIndex = questIndex + 1
		-- end
		-- local npcTable = v["NPC"]
		-- local npcName = ""
		
		-- if npcTable then
		   -- npcName = npcTable.name
		-- end
		   
		-- local values = { 
		                 -- name = questName,
	                     -- storageId = worldQuests.storageid + index,
		                 -- missionId = worldQuests.storageid + index,
		                 -- startValue = 1,
					     -- endValue = 2,
		                 -- states = {
								    -- [1] = function(player)
								       -- if not worldQuests:getRequiredItems(questName) then
									      -- return v["Text"](npcName)
									   -- end
									   -- return v["Text"](npcName) .. "\n" .. worldQuests:getRequiredItems(questName, true)
									-- end,
								    -- [2] = function(player)
									   -- return "Congratulations Warrios, the quest is finished."
									-- end,
						         -- }
				       -- }
	    -- table.insert(Quests[questIndex].missions, values)
		-- index = index + 1
    -- end
-- end

-- function worldQuests:getPlayerByGUID(guid)
     -- local resultx = db.storeQuery("SELECT `name` FROM `players` WHERE `id` = " .. guid)
     -- if resultx then
         -- name = result.getDataString(resultx, 'name')
         -- result.free(resultx)
		 
		 -- local player = Player(name)
		 -- if player then
		    -- local id = player:getId()
            -- return id
	    -- end
     -- end
     -- return false
-- end

-- function worldQuests:setIndex()
    
	-- local index = 1
	-- for questName, v in pairs(WORLD_QUESTS) do
	    -- WORLD_QUESTS[questName].index = index
    -- end
-- end
-- worldQuests:setIndex()    
	
-- function worldQuests:setPlayersStorage(name, value, reset)
	
	-- local playerGUIDT = {}
    -- local playerData = db.storeQuery("SELECT `id` FROM `players`")
   
    -- if playerData then
        -- repeat
            -- local guid = result.getNumber(playerData, "id")
            -- table.insert(playerGUIDT, guid)
        -- until not result.next(playerData)
		-- result.free(playerData)
    -- end
		
	-- if not worldQuests:isActive(name) then
	   -- return false
	-- end
	
	-- local index = WORLD_QUESTS[name].index
	-- for i = 1, #playerGUIDT do
		-- local guid = playerGUIDT[i]
		-- local key = worldQuests.storageid + index
		-- local player = Player(worldQuests:getPlayerByGUID(guid))
		-- if player then
		   	-- if reset then
			   -- player:setStorageValue(key, -1) 
			-- end
			-- if player:getStorageValue(worldQuests.storageid) < 1 then
		       -- player:setStorageValue(worldQuests.storageid, 1)
			   -- end
		    -- if player:getStorageValue(key) < 1 then
		       -- player:setStorageValue(key, 1)
			-- end		
			-- if value and value > 0 then
			   -- player:setStorageValue(key, value)
			-- end
		-- else
		    -- local data = db.storeQuery("SELECT `key`" .. " FROM " .. "`player_storage`" .. " WHERE " .. "`key` = " .. worldQuests.storageid .. " AND " .. "`player_id` = " .. guid)
	        -- if not data then
	           -- db.query("INSERT INTO " .. "`player_storage`" .. " (`player_id`, `key`, `value`) " .. "VALUES " .. "(" .. guid .. ", " .. worldQuests.storageid .. ", " .. 1 .. ");")
	        -- else
			   -- db.query("UPDATE " .. "`player_storage`" .. " SET `value` = " .. 1 .. " WHERE `player_id` = " .. guid .. " AND " .. "`key` = " .. worldQuests.storageid)
			-- end
			-- result.free(data)
			   
		    -- if reset then
		   	   -- local data = db.storeQuery("SELECT `key`" .. " FROM " .. "`player_storage`" .. " WHERE " .. "`key` = " .. key .. " AND " .. "`player_id` = " .. guid)
	           -- if not data then
	              -- db.query("INSERT INTO " .. "`player_storage`" .. " (`player_id`, `key`, `value`) " .. "VALUES " .. "(" .. guid .. ", " .. key .. ", " .. -1 .. ");")
	           -- else
			      -- db.query("UPDATE " .. "`player_storage`" .. " SET `value` = " .. -1 .. " WHERE `player_id` = " .. guid .. " AND " .. "`key` = " .. key)
			   -- end
			   -- result.free(data)
			-- end
			-- if value and value > 0 then
			   -- local data = db.storeQuery("SELECT `key`" .. " FROM " .. "`player_storage`" .. " WHERE " .. "`key` = " .. key .. " AND " .. "`player_id` = " .. guid)
	           -- if not data then
	              -- db.query("INSERT INTO " .. "`player_storage`" .. " (`player_id`, `key`, `value`) " .. "VALUES " .. "(" .. guid .. ", " .. key .. ", " .. value .. ");")
	           -- else
			      -- db.query("UPDATE " .. "`player_storage`" .. " SET `value` = " .. value .. " WHERE `player_id` = " .. guid .. " AND " .. "`key` = " .. key)
			   -- end
			   -- result.free(data)
			-- else
			   -- local data = db.storeQuery("SELECT `key`" .. " FROM " .. "`player_storage`" .. " WHERE " .. "`key` = " .. key .. " AND " .. "`player_id` = " .. guid)
	           -- if not data then
	              -- db.query("INSERT INTO " .. "`player_storage`" .. " (`player_id`, `key`, `value`) " .. "VALUES " .. "(" .. guid .. ", " .. key .. ", " .. 1 .. ");")
	           -- else
			      -- db.query("UPDATE " .. "`player_storage`" .. " SET `value` = " .. 1 .. " WHERE `player_id` = " .. guid .. " AND " .. "`key` = " .. key)
			   -- end
			   -- result.free(data)
			-- end
		-- end
	-- end
	
-- end

-- function worldQuests:isFinished(name)
    
	-- if not name then
	   -- return nil
	-- end
	
	-- if not worldQuests:isActive(name) then
	   -- return false
	-- end
	
	-- local t = worldQuests:getRequiredItems(name)
	-- if not t then
	   -- return false
	-- end
    
	-- for id, itemTable in pairs(t) do
	    -- local count = itemTable.count
		-- local current = itemTable.current
		-- if current < count then
		   -- return false
		-- end
    -- end
	
	-- worldQuests:sendMessage("Congratulations Warrios!, " .. name .. " is finished." .. " World Experience Boost is active.")
	-- worldQuests:setExperienceBoost(name)
	-- worldQuests:setPlayersStorage(name, 2)

	-- local reactiveTable = WORLD_QUESTS[name]["Re-Active"]
	-- if reactiveTable then
	   -- if reactiveTable.enabled then
	      -- worldQuests:setActive(name, false, true)
		  -- local intervalTable = reactiveTable.interval
		  -- if intervalTable then
		     -- local duration = intervalTable.value
		     -- local method = intervalTable.type
		     -- local interval = 0
		     -- local onlyReactiveOnFinished = reactiveTable._onlyReactiveOnFinished
		     -- if string.find(method, "second") then
			    -- interval = duration
		     -- elseif string.find(method, "minute") then
			    -- interval = duration * 60
		     -- elseif string.find(method, "hour") then 
			    -- interval = duration * 60 * 60
		     -- end
             
             -- if onlyReactiveOnFinished then
			    -- interval = interval + os.time()
			    -- db.query("UPDATE " .. worldQuests.database .. " SET `reactive` = " .. 1 .. ", " .. "`reactive_time` = " .. interval .. " WHERE `name` = " .. '"' .. name .. '"')
             -- end				
		  -- end
	   -- end
	-- end

	-- return true
-- end

-- function worldQuests:getReactiveTime(name, method)

    -- if not name then
       -- return nil
	-- end
	
	-- if not worldQuests:isQuestInDatabase(name) then
	   -- return false
	-- end

	-- local duration = 0
	-- local data = db.storeQuery("SELECT reactive_time FROM " .. worldQuests.database .. " WHERE name = " .. '"' .. name .. '"')
	-- if data then
	   -- duration = result.getNumber(data, "reactive_time")
	   -- result.free(data)
	-- end
		
	-- local time_string = ""

    -- local time_left = duration - os.time()
    -- local hours = string.format("%02.f", math.floor(time_left / 3600))
    -- local mins = string.format("%02.f", math.floor(time_left / 60 - (hours * 60)))
    -- local secs = string.format("%02.f", math.floor(time_left  - hours * 3600 - mins * 60))

    -- if hours == "00" then
       -- time_string = mins .. " Minutes" .. " and " .. secs .. " Seconds" .. "."
    -- else
       -- time_string = hours .. " Hours" .. ", " .. mins .. " Minutes" .. " and " .. secs .. " Seconds" .. "."
    -- end
	
	-- if method then
	   -- return time_string
	-- end
    
	-- return duration
-- end

-- function worldQuests:setExperienceBoost(name)
    
	-- if not name then
	   -- return nil
	-- end
	
	-- if not worldQuests:isQuestInDatabase(name) then
	   -- return false
	-- end
	
	-- local interval = 0
	
	-- local t = WORLD_QUESTS[name]
	-- if t then
	       -- local rewardsTable = t["Rewards"]
		   -- if rewardsTable then
		      -- local boostTable = rewardsTable["Boosts"]
			  -- if boostTable then
			     -- local experienceTable = boostTable["Experience"]
				 -- if experienceTable then
				    -- local duration = experienceTable.duration
					-- local method = experienceTable.type
					-- local multiplier = experienceTable.multiplier
					
					-- if string.find(method, "second") then
					   -- interval = duration + os.time()
					-- elseif string.find(method, "minute") then
					   -- interval = duration * 60 + os.time()
					-- elseif string.find(method, "hour") then 
					   -- interval = duration * 60 * 60 + os.time()
					-- end
				 -- end
			  -- end
		   -- end
	-- end
	
	-- return db.query("UPDATE " .. worldQuests.database .. " SET `experience_boost` = " .. interval .. " WHERE `name` = " .. '"' .. name .. '"')
-- end

-- function worldQuests:getExperienceBoost(name)
  
    -- if not name then
       -- return nil
	-- end
	
	-- if not worldQuests:isQuestInDatabase(name) then
	   -- return false
	-- end
	
	-- local t = {}
    
	-- local duration = 0
	-- local data = db.storeQuery("SELECT experience_boost FROM " .. worldQuests.database .. " WHERE name = " .. '"' .. name .. '"')
	-- if data then
	   -- duration = result.getNumber(data, "experience_boost")
	   -- result.free(data)
	-- end
	-- t["duration"] = duration
	
	-- if t["duration"] < os.time() then
	   -- return false
	-- end
	
	-- local time_string = ""

    -- local time_left = t["duration"] - os.time()
    -- local hours = string.format("%02.f", math.floor(time_left / 3600))
    -- local mins = string.format("%02.f", math.floor(time_left / 60 - (hours * 60)))
    -- local secs = string.format("%02.f", math.floor(time_left  - hours * 3600 - mins * 60))

    -- if hours == "00" then
       -- time_string = mins .. " Minutes" .. " and " .. secs .. " Seconds" .. "."
    -- else
       -- time_string = hours .. " Hours" .. ", " .. mins .. " Minutes" .. " and " .. secs .. " Seconds" .. "."
    -- end
    
	-- t["string duration"] = time_string
	-- return t
-- end
	
-- function worldQuests:getAllBoostsMultiplier()
	-- local t = {} 
	-- local value = 0
	-- for questName, v in pairs(WORLD_QUESTS) do
	    -- if worldQuests:getExperienceBoost(questName) then
		   -- local rewardsTable = v["Rewards"]
		   -- if rewardsTable then
		      -- local boostTable = rewardsTable["Boosts"]
			  -- if boostTable then
			     -- local experienceTable = boostTable["Experience"]
				 -- if experienceTable then
					-- local multiplier = experienceTable.multiplier
                    -- value = value + multiplier
				 -- end
			  -- end
		  -- end
		-- end
	-- end
	-- t["experience boost"] = value
	-- return t
-- end

-- function worldQuests:getAllBoostsString()
    
	-- local str = ""
	-- local t = {} 
	-- local value = 0
	-- local index = 1
	-- for questName, v in pairs(WORLD_QUESTS) do
	    -- if worldQuests:getExperienceBoost(questName) then
		   -- local rewardsTable = v["Rewards"]
		   -- if rewardsTable then
		      -- local boostTable = rewardsTable["Boosts"]
			  -- if boostTable then
			     -- local experienceTable = boostTable["Experience"]
				 -- if experienceTable then
					-- local multiplier = experienceTable.multiplier
                    -- value = value + multiplier
					-- str = str .. "[" .. questName .. "]" .. "\n" .. "Experience Boost: " .. multiplier .. "%" .. " " .. "\n" .. "It will expire at: " .. worldQuests:getExperienceBoost(questName)["string duration"] .. "\n"
				 -- end
			  -- end
		  -- end
		-- end
		-- index = index + 1
	-- end	
	-- return str 
-- end
	
-- function Position.sendAnimatedText(self, message)
    -- local specs = Game.getSpectators(self, false, true, 9, 9, 8, 8)
    -- if #specs > 0 then
        -- for i = 1, #specs do
            -- local player = specs[i]
            -- player:say(message, TALKTYPE_MONSTER_SAY, false, player, self)
        -- end
    -- end
-- end


-- local action = Action()
-- function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- Harvesting:harvestTree(item, player)
	-- return true
-- end
-- for name in pairs(WORLD_QUESTS) do
	-- local requiredTable = WORLD_QUESTS[name]["Required Items"]
	-- if requiredTable then
	   -- for id, itemTable in pairs(requiredTable) do
	       -- local harvestTable = itemTable["Harvest"]
		   -- if harvestTable then
		      -- for index, v in pairs(harvestTable) do 
		          -- action:id(v.tree_id)
		      -- end
		   -- end
	   -- end
	-- end
-- end
-- action:register()

-- local talk = TalkAction("/lanternquest", "!lanternquest")
-- function talk.onSay(player, words, param)
	-- local questName = "Lantern Quest"
	-- worldQuests:addQuestToDataBase(questName)
	-- return false
-- end
-- talk:separator(" ")
-- talk:register()

-- talk = TalkAction("/testek", "!testek")
-- function talk.onSay(player, words, param)
	-- local name = "Lantern Quest"
	-- print("Pozostalo czasu do resetu " .. worldQuests:getReactiveTime(name, true))
	-- local ostime = os.time()
	-- print("OS TIME " .. ostime)
	-- print("RESET TIME " .. worldQuests:getReactiveTime(name)) 
	-- return false
-- end
-- talk:separator(" ")
-- talk:register()


-- talk = TalkAction("/worldboosts", "!worldboosts")
-- function talk.onSay(player, words, param)
	  
   -- local title = "World Quests - Boosts"
   -- local str = worldQuests:getAllBoostsString()
   -- local message = str
   
   -- local window = ModalWindow(1201, title, message)
   -- window:addButton(100, "Ok") 
   -- window:setDefaultEnterButton(100)
   -- window:setDefaultEscapeButton(100)
   
   -- if str == "" then
      -- player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "There is no active world boosts.")
	  -- return false
   -- end
   
   -- window:sendToPlayer(player)
   -- return false
-- end
-- talk:separator(" ")
-- talk:register()

-- local globalevent = GlobalEvent("load_worldquests")
-- function globalevent.onStartup()
    -- worldQuests:prepare()
-- end
-- globalevent:register()


-- local _isChecked = false
-- globalevent = GlobalEvent("worldQuests_Scheduler")
-- function globalevent.onThink(interval, lastExecution)	
	-- local currentTime = os.date("%H:%M")
	-- local currentDay = os.date("%A")
	-- for name in pairs(WORLD_QUESTS) do
	
	    -- if not _isChecked then
		   -- local SchedulerTable = WORLD_QUESTS[name]["Scheduler"]
		   -- if SchedulerTable then
		      -- if day == "Everyday" or day == currentDay then
	             -- if isInArray(timeTable, currentTime) then
				    -- worldQuests:addQuestToDataBase(name)
			     -- end
			  -- end
		   -- end
		   -- _isChecked = true
		   	-- addEvent(function()
               -- _isChecked = false
            -- end, 1000 * 60)
		-- end

	    -- if worldQuests:isReactivated(name) then
		   -- if worldQuests:getReactiveTime(name) < os.time() then
		      -- worldQuests:reset(name)
		   -- end
		   -- if worldQuests:getReactiveTime(name) > os.time() then
		   -- print("Pozostalo do resetu : " .. worldQuests:getReactiveTime(name, true))
		   -- end
        -- end
		
    -- end		
	
	
	-- return true
-- end
-- globalevent:interval(1000)
-- globalevent:register()

-- local creatureevent = CreatureEvent("worldquests_onDeath")
-- function creatureevent.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
    
	-- local name = creature:getName():lower()
    -- for questName in pairs(WORLD_QUESTS) do
	    -- if worldQuests:isActive(questName) then
	       -- local requiredTable = WORLD_QUESTS[questName]["Required Items"]
	       -- if requiredTable then
	          -- for id, itemTable in pairs(requiredTable) do
	              -- local monstersTable = itemTable["Monsters Drop"]
				  -- if monstersTable then
				     -- for monsterName, v in pairs(monstersTable) do
						 -- if monsterName:lower() == name or monsterName == "Every" then
							-- local number = math.random(0, 100)
							-- local chance = v.chance
							-- if number <= chance then
							   -- local count = math.random(v.count.min, v.count.max)
						       -- corpse:addItem(id, count)
							-- end
					     -- end
				     -- end
			      -- end
			  -- end
	       -- end
		-- end
	-- end
-- end
-- creatureevent:register()




-- for questName, v in pairs(WORLD_QUESTS) do
    -- local npcTable = v["NPC"]
	-- if npcTable then
	   -- local name = npcTable.name
	   -- local looktype = npcTable.lookType
	   -- local internalNpcName = name
	   -- local npcType = Game.createNpcType(internalNpcName)
	   -- local npcConfig = {}
       -- npcConfig.name = internalNpcName
       -- npcConfig.description = internalNpcName
       -- npcConfig.health = 100
       -- npcConfig.maxHealth = npcConfig.health
       -- npcConfig.walkInterval = 2000
       -- npcConfig.walkRadius = 2
       -- npcConfig.outfit = {
	                        -- lookType = looktype,
	                        -- lookHead = 0,
	                        -- lookBody = 0,
	                        -- lookLegs = 0,
	                        -- lookFeet = 0,
	                        -- lookAddons = 0
                          -- }

        -- npcConfig.flags = {
	                        -- floorchange = false
                          -- }

        -- local keywordHandler = KeywordHandler:new()
        -- local npcHandler = NpcHandler:new(keywordHandler)

        -- npcType.onThink = function(npc, interval)
	    -- npcHandler:onThink(npc, interval)
        -- end

        -- npcType.onAppear = function(npc, creature)
	    -- npcHandler:onAppear(npc, creature)
        -- end

        -- npcType.onDisappear = function(npc, creature)
	    -- npcHandler:onDisappear(npc, creature)
        -- end

        -- npcType.onMove = function(npc, creature, fromPosition, toPosition)
	    -- npcHandler:onMove(npc, creature, fromPosition, toPosition)
        -- end

        -- npcType.onSay = function(npc, creature, type, message)
	    -- npcHandler:onSay(npc, creature, type, message)
        -- end

        -- npcType.onCloseChannel = function(npc, creature)
	    -- npcHandler:onCloseChannel(npc, creature)
        -- end

        -- local function creatureSayCallback(npc, creature, type, message)
	          -- local player = Player(creature)
	          -- local playerId = player:getId()
              
	          -- if not npcHandler:checkInteraction(npc, creature) then
		         -- return false
	          -- end

	-- local name = "Lantern Quest"
	
	-- if MsgContains(message, "informations") then
       -- npcHandler:say("What do you want to know about Lantern Quest ? {required items}, {boost}, {active}", npc, creature)
	-- elseif MsgContains(message, "boost") then
	   -- if not worldQuests:getExperienceBoost(name) then
	      -- npcHandler:say("There is no active any boost.", npc, creature)
		  -- return false
	   -- end
	   -- npcHandler:say("Experience boost is active, it will expire at: " .. worldQuests:getExperienceBoost(name), npc, creature)
	-- elseif MsgContains(message, "active") then
	     -- if not worldQuests:isActive(name) then
		    -- if worldQuests:isReactivated(name) then
			   -- if worldQuests:getReactiveTime(name) > os.time() then
        	      -- local reactive_time = worldQuests:getReactiveTime(name, true)
				  -- npcHandler:say("Quest is not active, it will reactive at: " .. reactive_time, npc, creature)
			   -- end
			-- else
			    -- npcHandler:say("Quest is not active.", npc, creature)
			-- end
		-- else
		   -- if worldQuests:isReactivated(name) then
		      -- local reactive_time = worldQuests:getReactiveTime(name, true)
			  -- if worldQuests:getReactiveTime(name) > os.time() then
		         -- npcHandler:say("Quest is active, It will end at: " .. reactive_time, npc, creature)
			  -- end
		   -- else
		       -- npcHandler:say("Quest is active." .. reactive_time, npc, creature)
		   -- end
		-- end
	-- elseif MsgContains(message, "required items") then
		-- local items_list = worldQuests:getRequiredItems(name, true, true)
		-- npcHandler:say("Items that need to be collect: " .. items_list, npc, creature)	
	-- end
	
	-- local t = WORLD_QUESTS[name]["Required Items"]
	-- for id, v in pairs(t) do
	    -- local title = v.text
		-- local item_name = getItemName(id)
		-- if MsgContains(message, item_name) then
		   -- npcHandler:say("{" .. item_name .. "}" .. " " .. title, npc, creature)
		-- end
    -- end
			  
	    -- return true
    -- end
		
        -- npcHandler:setMessage(MESSAGE_GREET, "Hello! |PLAYERNAME| can you {help} me")
        -- npcHandler:setMessage(MESSAGE_FAREWELL, "Goodbye.")
        -- npcHandler:setMessage(MESSAGE_WALKAWAY, "Goodbye.")

        -- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
        -- npcHandler:addModule(FocusModule:new())
        -- npcType:register(npcConfig)
    -- end
-- end