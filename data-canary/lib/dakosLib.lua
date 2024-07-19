dakosLib = {}

MISSION_NOT_TAKEN = 0
MISSION_PROGRESS = 1
MISSION_READY_TO_FINISH = 2 
MISSION_FINISHED = 3




-- SKILLS_STORAGE = 2373110
-- SKILLS_SUBID = {
                 -- [1] = 300,
				 -- [2] = 301
			   -- }

-- SKILLS_TABLE = {
                 -- [1] = { type = SKILL_FIST, param = CONDITION_PARAM_SKILL_FIST },
				 -- [2] = { type = SKILL_CLUB, param = CONDITION_PARAM_SKILL_CLUB },
				 -- [3] = { type = SKILL_SWORD, param = CONDITION_PARAM_SKILL_SWORD },
				 -- [4] = { type = SKILL_AXE, param = CONDITION_PARAM_SKILL_AXE },
				 -- [5] = { type = SKILL_DISTANCE, param = CONDITION_PARAM_SKILL_DISTANCE },
				 -- [6] = { type = SKILL_SHIELD, param = CONDITION_PARAM_SKILL_SHIELD },
				 -- [7] = { type = SKILL_FISHING, param = CONDITION_PARAM_SKILL_FISHING },
				 -- [8] = { type = SKILL_MAGLEVEL, param = CONDITION_PARAM_STAT_MAGICPOINTS }
				-- }

-- function dakosLib:getSkill(player, skillId)
    -- local value = player:getStorageValue(SKILLS_STORAGE + skillId)
	-- if value < 0 then
	    -- value = 0
	-- end
	-- return value
-- end

-- function dakosLib:addSkill(player, skillId, value)
	-- local old = dakosLib:getSkill(player, skillId)
	-- player:setStorageValue(SKILLS_STORAGE + skillId, old + value)
-- end

-- function dakosLib:updateSkills(player)
    -- local subid = SKILLS_SUBID[1]
    -- local condition = Condition(CONDITION_ATTRIBUTES)
    -- condition:setParameter(CONDITION_PARAM_SUBID, subid)
    -- condition:setParameter(CONDITION_PARAM_TICKS, -1)
	-- for i, v in ipairs(SKILLS_TABLE) do
	    -- local skillId = v.type
		-- local value = dakosLib:getSkill(player, skillId)
		-- if value > 0 then
		    -- condition:setParameter(v.param, value)
		-- end
	-- end
	-- player:addCondition(condition)
-- end
	    
	    



function dakosLib:getInterval(t)
	local method = t.type
	local duration = t.value
	
	interval = duration
    if string.find(method, "msecond") then
       interval = duration
    elseif string.find(method, "second") then
	   interval = duration * 1000
    elseif string.find(method, "minute") then
	   interval = duration * 1000 * 60
    elseif string.find(method, "hour") then 
	   interval = duration * 1000 * 60 * 60
    end 
    return interval
end

function dakosLib:getTimeString(value)
	local time_left = value
	
	local h = string.format("%02.f", math.floor(time_left / (60*60*1000)))
    time_left = string.format("%02.f", math.floor(time_left - h*(60*60*1000)))
    local m = string.format("%02.f", math.floor(time_left / (60*1000)))
    time_left = string.format("%02.f", math.floor(time_left - m*(60*1000)))
    local s = string.format("%02.f", math.floor(time_left / 1000))
    time_left = string.format("%02.f", math.floor(time_left - s*1000))

	if h == "00" then
       time_string = m .. " Minutes" .. " and " .. s .. " Seconds" .. "."
    else
       time_string = h .. " Hours" .. ", " .. m .. " Minutes" .. " and " .. s .. " Seconds" .. "."
    end
	return time_string
end

function dakosLib:convertTimeToNumber(value)
	local timestring = value
	timestring = timestring:gsub(':', '')
	timestring = string.format("%u", timestring)
	return tonumber(timestring)
end
	


function dakosLib:setQuestLogMission(player, key, missionid, value)
      
	  if not player then
	     print("PLAYER NOT FOUND")
	     return nil
	  end
	  
	  if not value then
	     print("VALUE NOT FOUND")
		 return nil
	  end
	  
	  if not missionid then
	     print("MISSIONID NOT FOUND")
		 return nil
	  end
	  	
	  
	player:setStorageValue(key + missionid, value)
end

function dakosLib:getQuestLogMission(player, key, missionid)
      
	  if not player then
	     return nil
	  end
	  
	  if not missionid then
	     print("MISSIONID NOT FOUND")
		 return nil
	  end
	  
	  local value = player:getStorageValue(key + missionid)
	  
	  if value < 1 then
	     value = 0
	  end
	  
	  return value
end

function dakosLib:getQuestCurrentMission(player, key, missionTable, maxMissionId)
     
	  if not player then
	     return nil
	  end
	  
	  for i = 1, # missionTable do
	      local m = missionTable[i].subMissions
		  if m then
		     maxMissionId = m
		  end
		  if dakosLib:getQuestLogMission(player, key, i) < maxMissionId then
		     return i
	      end
	  end
	  return 0
end
	
function dakosLib:addKey(player, id, actionid, name, description)
    
	local key = player:addItem(id, 1)
	if not key then
	   return true
	end
	
	if actionid then
	   key:setAttribute(ITEM_ATTRIBUTE_ACTIONID, actionid)
	end
	
	if name then
	   key:setAttribute(ITEM_ATTRIBUTE_NAME, name)
	end
	
	if description then
	   key:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, description)
	end
end

function dakosLib:generateKey(id, actionid, name, description)
    
	local key = Game.createItem(id, 1)
	if not key then
	   return true
	end
	
	if actionid then
	   key:setAttribute(ITEM_ATTRIBUTE_ACTIONID, actionid)
	end
	
	if name then
	   key:setAttribute(ITEM_ATTRIBUTE_NAME, name)
	end
	
	if description then
	   key:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, description)
	end
	return key
end
	
function dakosLib:getItemIdByName(name)
    
	if not name then
	   return nil
	end
	
	local it = ItemType(name)
	if not it then
	   return nil
	end
	
	return it:getId()
end

function dakosLib:addMissionItem(player, t)
    
	if not player or not t then
	   return nil
	end
	
	local str = ""
	
	for i, v in pairs(t) do
	    local id = v.itemid
		if not id then
		   id = v.id
		end
		if not id then
		   id = dakosLib:getItemIdByName(v.name)
		end
		local count = v.count
		player:addItem(id, count)
	end
end
	
function dakosLib:getMissingItems(t, player)
    
	if not t or not player then
	   return nil
	end
	
    local missingItems = {}
		
	for index, v in pairs(t) do
	    local id = v.itemid
		if not id then
		   id = v.id
		end
		if not id then
		   id = dakosLib:getItemIdByName(v.name)
		end
		
		local count = v.value
		if not count then
		   count = v.count
		end
		if id and count then
		   if player:getItemCount(id) < count then
		      local missingCount = count - player:getItemCount(id)
		      local values = { ["itemid"] = id, ["count"] = missingCount }
		      table.insert(missingItems, values)
		   end
		end
	end	
		
	if #missingItems > 0 then
	    local str = ""
	    for index, missingItem in pairs(missingItems) do
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
	return false
end

function dakosLib:getRequiredItems(t)
    
	if not t then
	   return nil
	end
	
    local requiredItems = {}

	for index, v in pairs(t) do
	    local id = v.itemid
		if not id then
		   id = v.id
		end
		if not id then
		   id = dakosLib:getItemIdByName(v.name)
		end
		local count = v.count
		if not count then
		   count = v.value
		end
		if id and count then
		   local values = { ["itemid"] = id, ["count"] = count }
		   table.insert(requiredItems, values)
		end
	end
		
	if #requiredItems > 0 then
	    local str = ""
	    for index, requiredItem in pairs(requiredItems) do
	        local id = tonumber(requiredItem["itemid"])
	        local count = tonumber(requiredItem["count"])
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
	return false
end

function dakosLib:removeItems(t, player)	
    
	if not t or not player then
	   return nil
	end
	
	for index, v in pairs(t) do
	    local id = v.itemid
		if not id then
		   id = v.id
		end
		if not id then
		   id = dakosLib:getItemIdByName(v.name)
		end
		local count = v.value
		if not count then
		   count = v.count
		end
		if id and count then
           player:removeItem(id, count)
        end
    end
	return true
end

function dakosLib:getTableLength(t)
	local count = 0
    for _ in pairs(t) do 
	    count = count + 1 
	end
    return count
end

function dakosLib:getStringListFromTable(t, highlight)
   
   if not t then
      return false
   end
   
   local list = ""
   local index = 1
   local length = dakosLib:getTableLength(t)
   for name, v in pairs(t) do
       if highlight then
	      list = list .. "{"
	   end
	   list = list .. name
       if highlight then
	      list = list .. "}"
	   end	   
	   if index == length then
	      list = list .. "."
		  break
	   else
	      if length > 1 and index == length - 1 then
		     list = list .. " and "
		  else
	         list = list .. ", "
	      end
	   end
	   index = index + 1
   end	   
   return list
end

function dakosLib:addReward(player, t, customString, returnStringOnly, skipText, customContainer, skipPrefix, highLight, skipChance)
    
	if not t then
	   return nil
	end
	
	local items = { }
	local _itemsDisplayed = false
	
	local levels = 0
	local _LevelDisplayed = false

	local fists = 0
	local _FistDisplayed = false
	
	local clubs = 0
	local _ClubDisplayed = false
	
	local swords = 0
	local _SwordDisplayed = false

	local axes = 0
	local _AxeDisplayed = false

	local distances = 0
	local _DistanceDisplayed = false

	local shieldings = 0
	local _ShieldingDisplayed = false
	
	local fishings = 0
	local _FishingDisplayed = false

	local mlevels = 0
	local _MLevelDisplayed = false
	
	local experience = 0
	local _experienceDisplayed = false
	
	local premium_points = 0
	local _ppDisplayed = false
	
	local money = 0
	local _moneyDisplayed = false
	
	local _experienceBonusDisplayed = false
	local experienceBonus = 0

	local keys = {}
	local _keysDisplayed = false
	
	local _missionBonusDisplayed = false
	local missionBonus = 0
	
	local daily_task_points = 0
	local _dtpDisplayed = false
	
	local outfitScrolls = {}
	local _outfitScrollsDisplayed = false
	
	local abilityScrolls = {}
	local _abilityScrollsDisplayed = false
	
	local displayThings = 0
	
	local str = ""
	if not skipPrefix then
	   str = "You have received: "
	end
	
	
	for index, v in pairs(t) do
	    if v.type == "item" then
	       local id = v.itemid
		   if not id then
		      id = v.id
		   end
		   if not id then
		      id = dakosLib:getItemIdByName(v.name)
		   end
		   local count = v.count
		   local values = { ["id"] = id, ["count"] = count }
		   local chance = v.chance
		   if not chance or skipChance then
		      chance = 100
		   end
		   if chance < 1 then
		      chance = chance * 100
		   end
		   local rand = math.random(0, 100)
		   if rand <= chance then
		      table.insert(items, values)
		      if not _itemsDisplayed then
		         displayThings = displayThings + 1
			     _itemsDisplayed = true
		      end
		   end
		elseif v.type == "outfit scroll" then
           local name = v.name
           local addon = v.addon
           if not addon then
              addon = 0
           end
		   local chance = v.chance
		   if not chance or skipChance then
		      chance = 100
		   end
		   if chance < 1 then
		      chance = chance * 100
		   end
		   local values = { ["name"] = name, ["addon"] = addon }
		   local rand = math.random(0, 100)
		   if rand <= chance then
		      table.insert(outfitScrolls, values)
		      if not _outfitScrollsDisplayed then
		         displayThings = displayThings + 1
			     _outfitScrollsDisplayed = true
		      end
		   end
		elseif v.type == "ability scroll" then
           local name = v.name
		   local chance = v.chance
		   if not chance or skipChance then
		      chance = 100
		   end
		   if chance < 1 then
		      chance = chance * 100
		   end
		   local values = { ["name"] = name }
		   local rand = math.random(0, 100)
		   if rand <= chance then
		      table.insert(abilityScrolls, values)
		      if not _abilityScrollsDisplayed then
		         displayThings = displayThings + 1
			     _abilityScrollsDisplayed = true
		      end
		   end		   
		elseif v.type == "level" then
		   local value = v.value
		   levels = levels + value
		   if not _LevelDisplayed then
		      displayThings = displayThings + 1
			  _LevelDisplayed = true
		   end
		elseif v.type == "fist" then
		   local value = v.value
		   fists = fists + value
		   if not _FistDisplayed then
		      displayThings = displayThings + 1
			  _FistDisplayed = true
		   end			   
		elseif v.type == "club" then
		   local value = v.value
		   clubs = clubs + value
		   if not _ClubDisplayed then
		      displayThings = displayThings + 1
			  _ClubDisplayed = true
		   end		
		elseif v.type == "sword" then
		   local value = v.value
		   swords = swords + value
		   if not _SwordDisplayed then
		      displayThings = displayThings + 1
			  _SwordDisplayed = true
		   end			  
		elseif v.type == "axe" then
		   local value = v.value
		   axes = axes + value
		   if not _AxeDisplayed then
		      displayThings = displayThings + 1
			  _AxeDisplayed = true
		   end		
		elseif v.type == "distance" then
		   local value = v.value
		   distances = distances + value
		   if not _DistanceDisplayed then
		      displayThings = displayThings + 1
			  _DistanceDisplayed = true
		   end
		elseif v.type == "shielding" then
		   local value = v.value
		   shieldings = shieldings + value
		   if not _ShieldingDisplayed then
		      displayThings = displayThings + 1
			  _ShieldingDisplayed = true
		   end	
		elseif v.type == "fishing" then
		   local value = v.value
		   fishings = fishings + value
		   if not _FishingDisplayed then
		      displayThings = displayThings + 1
			  _FishingDisplayed = true
		   end			
		elseif v.type == "mlevel" or v.type == "magic level" then
		   local value = v.value
		   mlevels = mlevels + value
		   if not _MLevelDisplayed then
		      displayThings = displayThings + 1
			  _MLevelDisplayed = true
		   end				   
		elseif v.type == "experience" then
		   local value = v.value
		   experience = experience + value
		   if not _experienceDisplayed then
		      displayThings = displayThings + 1
			  _experienceDisplayed = true
		   end
		elseif v.type == "points" or v.type == "premium_points" or v.type == "premium points" or v.type == "pp" then
		   local value = v.value
		   premium_points = premium_points + value
		   if not _ppDisplayed then
		      displayThings = displayThings + 1
			  _ppDisplayed = true
		   end
		elseif v.type == "task_points" or v.type == "task points" or v.type == "daily points" or v.type == "dp" then
		   local value = v.value
		   daily_task_points = daily_task_points + value
		   if not _dtpDisplayed then
		      displayThings = displayThings + 1
			  _dtpDisplayed = true
		   end		   
		elseif v.type == "money" then
		   local value = v.value
		   money = money + value
		   if not _moneyDisplayed then
		      displayThings = displayThings + 1
			  _moneyDisplayed = true
		   end
		elseif v.type == "experience_bonus" or v.type == "experience bonus" then
		   local value = v.value
		   experienceBonus = experienceBonus + value
		   if not _experienceBonusDisplayed then
		      displayThings = displayThings + 1
			  _experienceBonusDisplayed = true
		   end
		elseif v.type == "mission_bonus" or v.type == "mission bonus" then
		   local value = v.value
		   missionBonus = missionBonus + value
		   if not _missionBonusDisplayed then
		      displayThings = displayThings + 1
			  _missionBonusDisplayed = true
		   end	
	    elseif v.type == "key" then
	       local id = v.itemid
		   if not id then
		      id = v.id
		   end
		   if not id then
		      id = dakosLib:getItemIdByName(v.name)
		   end
		   
		   local count = 1

		   local values = { ["id"] = id, ["count"] = count, ["actionid"] = v.actionid, ["name"] = v.name, ["description"] = v.description }
		   local chance = v.chance
		   if not chance or skipChance then
		      chance = 100
		   end
		   if chance < 1 then
		      chance = chance * 100
		   end
		   local rand = math.random(0, 100)
		   if rand <= chance then
		      table.insert(keys, values)
		      if not _keysDisplayed then
		         displayThings = displayThings + 1
			     _keysDisplayed = true
		      end
		   end		   
		end
	end
		
	if #items > 0 then
	  --local backpack = player:addItem(1998)
	  for index, item in pairs(items) do
	      local id = item.id
	      local count = item.count
		  if not returnStringOnly then
		     if not customContainer then
		        player:addItem(id, count)
		     else
			    customContainer:addItem(id, count)
			 end
		  end
		  if #items == index then
	         --str = str .. count .. "x " .. getItemName(id)
			 str = str .. count .. "x "
			 if highLight then
			    str = str .. "{" 
		     end
			 str = str .. getItemName(id)
			 if highLight then
			    str = str .. "}" 
		     end			 
		  else
		     str = str .. count .. "x "
			 if highLight then
			    str = str .. "{" 
		     end
			 str = str .. getItemName(id)
			 if highLight then
			    str = str .. "}" 
		     end
		     str = str .. ", "
		  end
	   end
	   displayThings = displayThings - 1
	  if displayThings == 0 then
	     str = str .. "."
	  elseif displayThings == 1 then
	     str = str .. " and "
	  elseif displayThings > 1 then
	     str = str .. ", "
	  end
	end
	
	if #outfitScrolls > 0 then
	  --local backpack = player:addItem(1998)
	  for index, scroll in pairs(outfitScrolls) do
	      local name = scroll.name
	      local addon = scroll.addon
		  if not returnStringOnly then
		     if not customContainer then
			    ADDON_SCROLL_SYSTEM:generateScroll(name, player, addon)
		        --player:addItem(id, count)
		     else
			    ADDON_SCROLL_SYSTEM:generateScroll(name, customContainer, addon)
			    --customContainer:addItem(id, count)
			 end
		  end
		if not string.find(str, name) then
		  if #outfitScrolls == index then
		     if highLight then
			    str = str .. "{" 
		     end
	         str = str .. "outfit scroll" .. "(" .. name .. ")"
		     if highLight then
			    str = str .. "}" 
		     end			 
		  else
		  	 if highLight then
			    str = str .. "{" 
		     end
		     str = str .. "outfit scroll" .. "(" .. name .. ")"
			  if highLight then
			    str = str .. "}" 
		     end
			 --str = str .. ", "
		  end
		 
	   
	   displayThings = displayThings - 1
	  if displayThings == 0 then
	     str = str .. "."
	  else
	     str = str .. ", "
      end
	 end
	end 
	  -- elseif displayThings == 1 then
	     -- str = str .. " and "
	  -- elseif displayThings > 1 then
	     -- str = str .. ", "
	  -- end
	end
	
	if #abilityScrolls > 0 then
	  --local backpack = player:addItem(1998)
	  for index, scroll in pairs(abilityScrolls) do
	      local name = scroll.name
		  if not returnStringOnly then
		     if not customContainer then
			    ABILITY_SCROLL_SYSTEM:generateScroll(name, player)
		        --player:addItem(id, count)
		     else
			    ABILITY_SCROLL_SYSTEM:generateScroll(name, customContainer)
			    --customContainer:addItem(id, count)
			 end
		  end
		  name = name:lower()
		  if highLight then
		     str = str .. "{" 
		  end
		  str = str .. name 
		  if highLight then
			 str = str .. "}" 
		  end		  
		  if #abilityScrolls ~= index then
		     str = str .. ", "
	      end
	   end
	   displayThings = displayThings - 1
	  if displayThings == 0 then
	     str = str .. "."
	  else
	     str = str .. ", "
      end
	end
	
	
	if #keys > 0 then
	  --local backpack = player:addItem(1998)
	  for index, key in pairs(keys) do
	      local id = key.id
	      local count = key.count
		  local actionid = key.actionid
		  local name = key.name
		  local description = key.description
		  if not returnStringOnly then
		     dakosLib:addKey(player, id, actionid, name, description)
		     --player:addItem(id, count)
		  end
		  name = name:lower()
		  if #keys == index then
			 if highLight then
		        str = str .. "{" 
		     end
			 str = str .. name
			 if highLight then
		        str = str .. "}" 
		     end
		  else
			  if highLight then
		         str = str .. "}" 
		      end
			  str = str .. name
			  if highLight then
		         str = str .. "}" 
		      end
			  str = str .. ", "
		  end
	   end
	   displayThings = displayThings - 1
	  if displayThings == 0 then
	     str = str .. "."
	  else
	     str = str .. ", "
      end
	end
	
	if levels > 0 then
	      if not returnStringOnly then
		     player:addLevel(levels)
	      end
	      str = str .. levels .. " level"
	   if levels > 1 then
	      str = str .. "'s"
	   end
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end
	
	if fists > 0 then
	      if not returnStringOnly then
		     local skillId = SKILL_FIST
		     --dakosLib:addSkill(player, skillId, fists)

              player:setSkillLevel(skillId, player:getSkillLevel(skillId) + fists)			 
	      end
	      str = str .. fists .. " fist fighting"
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end
	
	if clubs > 0 then
	      if not returnStringOnly then
		        local skillId = SKILL_CLUB
		        player:setSkillLevel(skillId, player:getSkillLevel(skillId) + clubs)		 
	      end
	      str = str .. clubs .. " club fighting"
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end
	
	if swords > 0 then
	      if not returnStringOnly then
		    local skillId = SKILL_SWORD
		     player:setSkillLevel(skillId, player:getSkillLevel(skillId) + swords)	 
	      end
	      str = str .. swords .. " sword fighting"
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end	
	
	if axes > 0 then
	      if not returnStringOnly then
		        local skillId = SKILL_AXE
		        player:setSkillLevel(skillId, player:getSkillLevel(skillId) + axes)		 
	      end
	      str = str .. axes .. " axe fighting"
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end	
	
	if distances > 0 then
	      if not returnStringOnly then
		        local skillId = SKILL_DISTANCE
		        player:setSkillLevel(skillId, player:getSkillLevel(skillId) + distances)		 
	      end
	      str = str .. distances .. " distance fighting"
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end
	
	if shieldings > 0 then
	      if not returnStringOnly then
		        local skillId = SKILL_SHIELD
		        player:setSkillLevel(skillId, player:getSkillLevel(skillId) + shieldings)		 
	      end
	      str = str .. shieldings .. " shielding"
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end
	
	if fishings > 0 then
	      if not returnStringOnly then
		        local skillId = SKILL_FISHING
		        player:setSkillLevel(skillId, player:getSkillLevel(skillId) + fishings)		 
	      end
	      str = str .. fishings .. " fishing"
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end
	
	if mlevels > 0 then
	      if not returnStringOnly then
		        local skillId = SKILL_MAGLEVEL
		        --player:setSkillLevel(skillId, player:getSkillLevel(skillId) + mlevels)	
				player:setMagicLevel(player:getMagicLevel() + mlevels)
	      end
	      str = str .. mlevels .. " magic level"
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end
	
	if experience > 0 then
	   if not returnStringOnly then
	      player:addExperience(experience)
	   end
	   str = str .. experience .. " experience"
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end

	if money > 0 then
	   if not returnStringOnly then
	      player:addMoney(money)
	   end
	   str = str .. money .. " money"
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end
	
	if premium_points > 0 then
	      if not returnStringOnly then
		     db.executeQuery("UPDATE `accounts` set `premium_points` = `premium_points` - " .. premium_points .. " WHERE `id` = " .. player:getAccountId())
		  end
	      str = str .. premium_points .. " premium point"
	   if premium_points > 1 then
	      str = str .. "'s"
	   end
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end	
	
	if daily_task_points > 0 then
	      if not returnStringOnly then
		     --db.executeQuery("UPDATE `accounts` set `premium_points` = `premium_points` - " .. premium_points .. " WHERE `id` = " .. player:getAccountId())
			 local value = player:getDailyTaskPoints()
			 player:setDailyTaskPoints(value + daily_task_points)
		  end
	      str = str .. daily_task_points .. " daily task point"
	   if daily_task_points > 1 then
	      str = str .. "'s"
	   end
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end	
	
	if experienceBonus > 0 then
	   if not returnStringOnly then
	      player:addExperienceBonus(experienceBonus)
	   end
	   str = str .. experienceBonus * 100 .. "% permament experience bonus"
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end

	if missionBonus > 0 then
	   if not returnStringOnly then
	      player:addMissionBonus(missionBonus)
	   end
	   str = str .. " max health/mana increased by " .. 50 * missionBonus
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end
	
	if customString then
	   str = str .. " " .. customString
	end
	
	if returnStringOnly then
	   return str
	end
	
	if not skipText then
	   player:sendTextMessage(MESSAGE_INFO_DESCR, str)
	end

end

function dakosLib:getRequiredThings(player, t, highlight)
    
	if not t then
	   return ""
	end
	
	local items = { }
	local _itemsDisplayed = false
	
	local killsTable = {}
	local _killsDisplayed = false
	
	local levels = 0
	local _LevelDisplayed = false
	local experience = 0
	local _experienceDisplayed = false
	local premium_points = 0
	local _ppDisplayed = false
	local money = 0
	local _moneyDisplayed = false
	local _experienceBonusDisplayed = false
	local experienceBonus = 0
	local _missionBonusDisplayed = false
	local missionBonus = 0
	local daily_task_points = 0
	local _dtpDisplayed = false
	local displayThings = 0
	local str = ""
	
	for index, v in pairs(t) do
	    if v.type == "item" then
	       local id = v.itemid
		   if not id then
		      id = v.id
		   end
		   if not id then
		      id = dakosLib:getItemIdByName(v.name)
		   end
		   local count = v.count
		   local values = { ["id"] = id, ["count"] = count }
		   local chance = v.chance
		   if not chance then
		      chance = 100
		   end
		   if chance < 1 then
		      chance = chance * 100
		   end
		   local rand = math.random(0, 100)
		   if rand <= chance then
		      table.insert(items, values)
		      if not _itemsDisplayed then
		         displayThings = displayThings + 1
			     _itemsDisplayed = true
		      end
		   end
	    elseif v.type == "kill" then
		   local name = v.name
		   local count = v.value
		   local values = { ["name"] = name, ["count"] = count }
		   table.insert(killsTable, values)
		      if not _killsDisplayed then
		         displayThings = displayThings + 1
			     _killsDisplayed = true
		      end
		elseif v.type == "level" then
		   local value = v.value
		   levels = levels + value
		   if not _LevelDisplayed then
		      displayThings = displayThings + 1
			  _LevelDisplayed = true
		   end
		elseif v.type == "experience" then
		   local value = v.value
		   experience = experience + value
		   if not _experienceDisplayed then
		      displayThings = displayThings + 1
			  _experienceDisplayed = true
		   end
		elseif v.type == "points" or v.type == "premium_points" or v.type == "premium points" or v.type == "pp" then
		   local value = v.value
		   premium_points = premium_points + value
		   if not _ppDisplayed then
		      displayThings = displayThings + 1
			  _ppDisplayed = true
		   end
		elseif v.type == "task_points" or v.type == "task points" or v.type == "daily points" or v.type == "dp" then
		   local value = v.value
		   daily_task_points = daily_task_points + value
		   if not _dtpDisplayed then
		      displayThings = displayThings + 1
			  _dtpDisplayed = true
		   end		   
		elseif v.type == "money" then
		   local value = v.value
		   money = money + value
		   if not _moneyDisplayed then
		      displayThings = displayThings + 1
			  _moneyDisplayed = true
		   end
		elseif v.type == "experience_bonus" or v.type == "experience bonus" then
		   local value = v.value
		   experienceBonus = experienceBonus + value
		   if not _experienceBonusDisplayed then
		      displayThings = displayThings + 1
			  _experienceBonusDisplayed = true
		   end
		elseif v.type == "mission_bonus" or v.type == "mission bonus" then
		   local value = v.value
		   missionBonus = missionBonus + value
		   if not _missionBonusDisplayed then
		      displayThings = displayThings + 1
			  _missionBonusDisplayed = true
		   end		   
		end
	end
		
	if #items > 0 then
	  --local backpack = player:addItem(1998)
	  for index, item in pairs(items) do
	      local id = item.id
	      local count = item.count
		  if #items == index then
		     if highlight then
			    str = str .. count .. "x " .. "{" .. getItemName(id) .. "}"
			 else
	            str = str .. count .. "x " .. getItemName(id)
			 end
		  else
		     if highlight then
			    str = str .. count .. "x " .. "{" .. getItemName(id) .. "}" .. ", "
			 else
		        str = str .. count .. "x " .. getItemName(id) .. ", "
			 end
		  end
	   end
	   displayThings = displayThings - 1
	  if displayThings == 0 then
	     str = str .. "."
	  elseif displayThings == 1 then
	     str = str .. " and "
	  elseif displayThings > 1 then
	     str = str .. ", "
	  end
	end
	
	
	if #killsTable > 0 then
	
	   if displayThings == 0 then
	      str = str .. "kill "
	   elseif displayThings == 1 then
	      str = str .. " kill "
	   elseif displayThings > 1 then
	      str = str .. ", kill "
	   end
	  --local backpack = player:addItem(1998)
	  for index, k in pairs(killsTable) do
	      local name = k.name
	      local count = k.count
		  
		  if #killsTable == index then
		     if highlight then
			    str = str .. count .. "x " .. "{" .. name .. "}"
			 else
	            str = str .. count .. "x " .. name
			 end
		  else
		     if highlight then
			    str = str .. count .. "x " .. "{" .. name .. "}" .. ", "
			 else
		        str = str .. count .. "x " .. name .. ", "
			 end
		  end
	   end
	   displayThings = displayThings - 1
	  if displayThings == 0 then
	     str = str .. "."
	  elseif displayThings == 1 then
	     str = str .. " and "
	  elseif displayThings > 1 then
	     str = str .. ", "
	  end
	end
	
	if levels > 0 then
	      str = str .. levels .. " level"
	   if levels > 1 then
	      str = str .. "'s"
	   end
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end
	
	if experience > 0 then
	   str = str .. experience .. " experience"
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end

	if money > 0 then
	   str = str .. money .. " money"
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end
	
	if premium_points > 0 then
	      str = str .. premium_points .. " premium point"
	   if premium_points > 1 then
	      str = str .. "'s"
	   end
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end	
	
	if daily_task_points > 0 then
	      if highlight then
		     str = str .. daily_task_points .. " {daily task point}"
		  else
	         str = str .. daily_task_points .. " daily task point"
	      end
	   if daily_task_points > 1 then
	      if highlight then
		     str = str .. "{'s}"
		  else
	         str = str .. "'s"
		  end
	   end
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end	
	
	if experienceBonus > 0 then
	   str = str .. experienceBonus * 100 .. "% permament experience bonus"
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end

	if missionBonus > 0 then
	   str = str .. " max health/mana increased by " .. 50 * missionBonus
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end
	
	return str

end

function dakosLib:getMissingThings(player, t, highlight)
    
	if not t then
	   return nil
	end
	
	local items = { }
	local _itemsDisplayed = false
	local levels = 0
	local _LevelDisplayed = false
	local experience = 0
	local _experienceDisplayed = false
	local premium_points = 0
	local _ppDisplayed = false
	local money = 0
	local _moneyDisplayed = false
	local _experienceBonusDisplayed = false
	local experienceBonus = 0
	local _missionBonusDisplayed = false
	local missionBonus = 0
	local daily_task_points = 0
	local _dtpDisplayed = false
	local displayThings = 0
	local str = ""
	
	for index, v in pairs(t) do
	    if v.type == "item" then
	       local id = v.itemid
		   if not id then
		      id = v.id
		   end
		   if not id then
		      id = dakosLib:getItemIdByName(v.name)
		   end
		   
		   local count = v.count
		   if not count then
		      count = v.value
		   end
		   
		   local playerCount = player:getItemCount(id)
		   if playerCount < count then
		      local finalCount = count - playerCount
			  local values = { ["id"] = id, ["count"] = finalCount }
			  table.insert(items, values)
		      if not _itemsDisplayed then
		         displayThings = displayThings + 1
			     _itemsDisplayed = true
		      end
		   end

		elseif v.type == "points" or v.type == "premium_points" or v.type == "premium points" or v.type == "pp" then
		   local value = v.value
		   local playerValue = player:getPremiumPoints()
		   if playerValue < value then
		      local finalValue = value - playerValue
		      premium_points = premium_points + finalValue
		      if not _ppDisplayed then
		         displayThings = displayThings + 1
			     _ppDisplayed = true
		      end
		   end
		elseif v.type == "task_points" or v.type == "task points" or v.type == "daily points" or v.type == "dp" then
		   local value = v.value
		   local playerValue = player:getDailyTaskPoints()
		   if playerValue < value then
		      local finalValue = value - playerValue
		      daily_task_points = daily_task_points + finalValue
		      if not _dtpDisplayed then
		         displayThings = displayThings + 1
			     _dtpDisplayed = true
		      end
		   end
		   
		elseif v.type == "money" then
		   local value = v.value
		   money = money + value
		   if not _moneyDisplayed then
		      displayThings = displayThings + 1
			  _moneyDisplayed = true
		   end
		elseif v.type == "experience_bonus" or v.type == "experience bonus" then
		   local value = v.value
		   experienceBonus = experienceBonus + value
		   if not _experienceBonusDisplayed then
		      displayThings = displayThings + 1
			  _experienceBonusDisplayed = true
		   end
		elseif v.type == "mission_bonus" or v.type == "mission bonus" then
		   local value = v.value
		   missionBonus = missionBonus + value
		   if not _missionBonusDisplayed then
		      displayThings = displayThings + 1
			  _missionBonusDisplayed = true
		   end		   
		end
	end
		
	if #items > 0 then
	  --local backpack = player:addItem(1998)
	  for index, item in pairs(items) do
	      local id = item.id
	      local count = item.count
		  if #items == index then
		     if highlight then
			    str = str .. count .. "x " .. "{" .. getItemName(id) .. "}"
			 else
	            str = str .. count .. "x " .. getItemName(id)
			 end
		  else
		     if highlight then
			    str = str .. count .. "x " .. "{" .. getItemName(id) .. "}" .. ", "
			 else
		        str = str .. count .. "x " .. getItemName(id) .. ", "
			 end
		  end
	   end
	   displayThings = displayThings - 1
	  if displayThings == 0 then
	     str = str .. "."
	  elseif displayThings == 1 then
	     str = str .. " and "
	  elseif displayThings > 1 then
	     str = str .. ", "
	  end
	end
	
	if levels > 0 then
	      str = str .. levels .. " level"
	   if levels > 1 then
	      str = str .. "'s"
	   end
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end
	
	if experience > 0 then
	   str = str .. experience .. " experience"
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end

	if money > 0 then
	   str = str .. money .. " money"
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end
	
	if premium_points > 0 then
	      str = str .. premium_points .. " premium point"
	   if premium_points > 1 then
	      str = str .. "'s"
	   end
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end	
	
	if daily_task_points > 0 then
	      if highlight then
		     str = str .. daily_task_points .. " {daily task point}"
		  else
	         str = str .. daily_task_points .. " daily task point"
	      end
	   if daily_task_points > 1 then
	      if highlight then
		     str = str .. "{'s}"
		  else
	         str = str .. "'s"
		  end
	   end
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end	
	
	if experienceBonus > 0 then
	   str = str .. experienceBonus * 100 .. "% permament experience bonus"
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end

	if missionBonus > 0 then
	   str = str .. " max health/mana increased by " .. 50 * missionBonus
	   displayThings = displayThings - 1
	   if displayThings == 0 then
	      str = str .. "."
	   elseif displayThings == 1 then
	      str = str .. " and "
	   elseif displayThings > 1 then
	      str = str .. ", "
	   end
	end
	
	if str == "" then
	   return false
	end
	
	return str

end

function dakosLib:removeThings(player, t)
    
	if not t then
	   return nil
	end
	
	local items = { }
	local _itemsDisplayed = false
	local premium_points = 0
	local _ppDisplayed = false
	local money = 0
	local _moneyDisplayed = false	
	local daily_task_points = 0
	local _dtpDisplayed = false
	
	local displayThings = 0
	
	for index, v in pairs(t) do
	    if v.type == "item" then
	       local id = v.itemid
		   if not id then
		      id = v.id
		   end
		   if not id then
		      id = dakosLib:getItemIdByName(v.name)
		   end
		   local count = v.count
		   local values = { ["id"] = id, ["count"] = count }
		   table.insert(items, values)
		elseif v.type == "points" or v.type == "premium_points" or v.type == "premium points" or v.type == "pp" then
		   local value = v.value
		   premium_points = premium_points + value
		elseif v.type == "task_points" or v.type == "task points" or v.type == "daily points" or v.type == "dp" then
		   local value = v.value
		   daily_task_points = daily_task_points + value	   
		elseif v.type == "money" then
		   local value = v.value
		   money = money + value	   
		end
	end
		
	if #items > 0 then
	  --local backpack = player:addItem(1998)
	  for index, item in pairs(items) do
	      local id = item.id
	      local count = item.count
		  player:removeItem(id, count)
	   end
	end

	if money > 0 then
	   player:removeMoney(money)
	end
	
	if premium_points > 0 then
	   db.executeQuery("UPDATE `accounts` set `premium_points` = `premium_points` - " .. -premium_points .. " WHERE `id` = " .. player:getAccountId())
	end	
	
	if daily_task_points > 0 then
       local value = player:getDailyTaskPoints()
	   player:setDailyTaskPoints(value - daily_task_points)
	end
end

function dakosLib:getSingleReward(t)
    
	if not t then
	   return
	end
	
	local list = t
	table.sort(list, function(a, b) return a.chance < b.chance end)
	local list2 = {}
	
	local attempts = 0
	while #list2 == 0 and attempts < 100 do
	    local lastChance = 0
	    local rand = math.random(0, 100)
	    for i, v in pairs(list) do
			local chance = v.chance
		    if not chance then
		       chance = 100
		    end
		    if chance < 1 then
		       chance = chance * 100
		    end	
			
			if rand <= chance then
			   if lastChance == 0 or v.chance <= lastChance then
			      list2[#list2 + 1] = v
				  lastChance = v.chance
			   end
			end
		end
		attempts = attempts + 1
	end
	table.sort(list2, function(a, b) return a.chance < b.chance end)
	
	local rewardTable = list2[math.random(#list2)]
	return rewardTable
end


local PLAYER_EXHAUSTS = { }

function dakosLib:addSingleReward(player, t)
    
	if not player or not t then
	   return
	end
	
	local list = t
	table.sort(list, function(a, b) return a.chance < b.chance end)
	local list2 = {}
	
	local attempts = 0
	while #list2 == 0 and attempts < 40 do
	    local lastChance = 0
	    local rand = math.random(0, 100)
	    for i, v in pairs(list) do
			local chance = v.chance
		    if not chance then
		       chance = 100
		    end
		    if chance < 1 then
		       chance = chance * 100
		    end	
			
			if rand <= chance then
			   if lastChance == 0 or v.chance <= lastChance then
			      list2[#list2 + 1] = v
				  lastChance = v.chance
			   end
			end
		end
		attempts = attempts + 1
	end
	table.sort(list2, function(a, b) return a.chance < b.chance end)
	
	local rewardTable = list2[math.random(#list2)]
	local id = rewardTable.itemid
	local count = rewardTable.count
	player:addItem(id, count)
	
	local str = "You have received " .. count .. "x " .. getItemName(id)
	
	player:sendTextMessage(MESSAGE_INFO_DESCR, str)
end


function dakosLib:setExhaust(tableName, player, method, duration)
    

    if not PLAYER_EXHAUSTS[tableName] then
       PLAYER_EXHAUSTS[tableName] = {}
     end

    if not PLAYER_EXHAUSTS[tableName][player:getGuid()] then
       PLAYER_EXHAUSTS[tableName][player:getGuid()] = {}
    end
	
  
    local interval = 0
     
    if string.find(method, "msecond") then
       interval = duration
    elseif string.find(method, "second") then
	   interval = duration * 1000
    elseif string.find(method, "minute") then
	   interval = duration * 1000 * 60
    elseif string.find(method, "hour") then 
	   interval = duration * 1000 * 60 * 60
    end 
    PLAYER_EXHAUSTS[tableName][player:getGuid()] = systemTime() + interval
end

function dakosLib:getExhaust(tableName, player)
    
  if not PLAYER_EXHAUSTS[tableName] then
     return false
  end
  
  if not PLAYER_EXHAUSTS[tableName][player:getGuid()] then
     return false
  end
  
  if PLAYER_EXHAUSTS[tableName][player:getGuid()] > systemTime() then
     return true
  end
  
  return false
end

function dakosLib:getExhaustString(tableName, player) 
    
	if not PLAYER_EXHAUSTS[tableName] then
       return "not set"
    end
  
	local duration = PLAYER_EXHAUSTS[tableName][player:getGuid()]
	if not duration then
	   return "not set"
	end
	
	if duration < systemTime() then
	   return "not set"
	end

	
	local time_string = ""
	local time_left = ""
	
	time_left = duration - systemTime()
	
	local h = string.format("%02.f", math.floor(time_left / (60*60*1000)))
    time_left = string.format("%02.f", math.floor(time_left - h*(60*60*1000)))
    local m = string.format("%02.f", math.floor(time_left / (60*1000)))
    time_left = string.format("%02.f", math.floor(time_left - m*(60*1000)))
    local s = string.format("%02.f", math.floor(time_left / 1000))
    time_left = string.format("%02.f", math.floor(time_left - s*1000))

	if h == "00" then
       time_string = m .. " Minutes" .. " and " .. s .. " Seconds" .. "."
    else
       time_string = h .. " Hours" .. ", " .. m .. " Minutes" .. " and " .. s .. " Seconds" .. "."
    end
    
	return time_string
end



    
	