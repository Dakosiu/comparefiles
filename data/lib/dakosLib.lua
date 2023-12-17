dakosLib = {}

function dakosLib:addReward(player, t, returnStringOnly, highLight)
    
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

	local keys = {}
	local _keysDisplayed = false
	
	local _missionBonusDisplayed = false
	local missionBonus = 0
	
	local daily_task_points = 0
	local _dtpDisplayed = false
	
	local statPoints = 0
	local _statPointsDisplayed = false
	
	local wings = {}
	local _wingsDisplayed = false
	
	local shadders = {}
	local _shaddersDisplayed = false
	
	local auras = {}
	local _aurasDisplayed = false
	
	local outfits = {}
	local _outfitsDisplayed = false
	
	local mounts = {}
	local _mountsDisplayed = false
	
	local stats = {}
	local _statsDisplayed = false
	
	local talents = {}
	local _talentsDisplayed = false
	
	local soul = 0
	local _soulDisplayed = false
	
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
		elseif v.type == "wings" then
			local id = v.id
			local name = v.name
			local values = { ["id"] = id, ["name"] = name }
			table.insert(wings, values)
		    if not _wingsDisplayed then	
			   displayThings = displayThings + 1
			   _wingsDisplayed = true
			end
		elseif v.type == "shadder" or v.type == "shadders" or v.type == "shader" then
			local id = v.id
			local name = v.name
			local values = { ["id"] = id, ["name"] = name }
			table.insert(shadders, values)
		    if not _shaddersDisplayed then	
			   displayThings = displayThings + 1
			   _shaddersDisplayed = true
			end	
		elseif v.type == "auras" or v.type == "aura" then
			local id = v.id
			local name = v.name
			local values = { ["id"] = id, ["name"] = name }
			table.insert(auras, values)
		    if not _aurasDisplayed then	
			   displayThings = displayThings + 1
			   _aurasDisplayed = true
			end		
		elseif v.type == "mount" then
			local id = v.id
			local name = v.name
			local values = { ["id"] = id, ["name"] = name }
			table.insert(mounts, values)
		    if not _mountsDisplayed then	
			   displayThings = displayThings + 1
			   _mountsDisplayed = true
			end				
		elseif v.type == "outfit" then
			local name = v.name
			local male = v.male
			local female = v.female
			local addon = v.addon
			if not addon then
			   addon = 0
			end
			local values = { ["male"] = male, ["female"] = female, ["addon"] = addon, ["name"] = name }
			table.insert(outfits, values)
		    if not _outfitsDisplayed then	
			   displayThings = displayThings + 1
			   _outfitsDisplayed = true
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
		elseif v.type == "stats_points" or v.type == "stat_point" or v.type == "stats_points" or v.type == "stats points" then
		   local value = v.value
		   if not value then
		      value = v.count
		   end
		   statPoints = statPoints + value
		   if not _statPointsDisplayed then
		      displayThings = displayThings + 1
			  _statPointsDisplayed = true
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
		   if not chance then
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
		elseif v.type == "stats" then
           local name = v.name
		   local chance = v.chance
		   local value = v.value
		   if not chance or skipChance then
		      chance = 100
		   end
		   if chance < 1 then
		      chance = chance * 100
		   end
		   local values = { ["name"] = name, ["value"] = value }
		   local rand = math.random(0, 100)
		   if rand <= chance then		  
		      table.insert(stats, values)
		      if not _statsDisplayed then
		         displayThings = displayThings + 1
			     _statsDisplayed = true
		      end
		   end
		elseif v.type == "talent" then
           local name = v.name
		   local chance = v.chance
		   local value = v.value
		   if not chance or skipChance then
		      chance = 100
		   end
		   if chance < 1 then
		      chance = chance * 100
		   end
		   local values = { ["name"] = name, ["value"] = value }
		   local rand = math.random(0, 100)
		   if rand <= chance then		  
		      table.insert(talents, values)
		      if not _talentsDisplayed then
		         displayThings = displayThings + 1
			     _talentsDisplayed = true
		      end
		   end	
		elseif v.type == "soul" then
           local name = "soul"
		   local chance = v.chance
		   local value = v.value
		   if not chance or skipChance then
		      chance = 100
		   end
		   if chance < 1 then
		      chance = chance * 100
		   end
		   local values = { ["name"] = name, ["value"] = value }
		   local rand = math.random(0, 100)
		   if rand <= chance then		  
		      soul = soul + value
		      if not _soulDisplayed then
		         displayThings = displayThings + 1
			     _soulDisplayed = true
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
		        player:addItem(id, count)
		    end
		  
		    str = str .. count .. "x "
		 	if highLight then
			   str = str .. "{" 
		    end	
		    str = str .. getItemName(id)
			if highLight then
			   str = str .. "}" 
		    end	
			if #items ~= index then
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
	
	if #wings > 0 then
	   for index, wing in ipairs(wings) do
	       local id = wing.id
		   local name = wing.name:lower()
		   if not returnStringOnly then
		      player:addWing(id)
		   end
		   if #wings == index then
		      str = str .. name
		   else
		      str = str .. name .. ", "
		   end
		end
	    displayThings = displayThings - 1
		
	    if displayThings == 0 then
	       str = str .. "."
	    else
	       str = str .. ", "
        end
    end
	
	if #shadders > 0 then
	   for index, shadder in ipairs(shadders) do
	       local id = shadder.id
		   local name = shadder.name:lower()
		   if not returnStringOnly then
		      player:addShader(id)
		   end
		   if #shadders == index then
		      str = str .. name
		   else
		      str = str .. name .. ", "
		   end
		end
	    displayThings = displayThings - 1
		
	    if displayThings == 0 then
	       str = str .. "."
	    else
	       str = str .. ", "
        end
    end
	
	if #auras > 0 then
	   for index, aura in ipairs(auras) do
	       local id = aura.id
		   local name = aura.name:lower()
		   if not returnStringOnly then
		      player:addAura(id)
		   end
		   if #auras == index then
		      str = str .. name
		   else
		      str = str .. name .. ", "
		   end
		end
	    displayThings = displayThings - 1
		
	    if displayThings == 0 then
	       str = str .. "."
	    else
	       str = str .. ", "
        end
    end
	
	if #outfits > 0 then
	   for index, outfit in ipairs(outfits) do
	       local male = outfit.male
		   local female = outfit.female
		   local addon = outfit.addon
		   local name = outfit.name:lower()
		   if not returnStringOnly then
		      player:addOutfit(male)
			  player:addOutfit(female)
			  if addon > 0 then
			     player:addOutfitAddon(male, addon)
				 player:addOutfitAddon(female, addon)
		      end
		   end
		   if #outfits == index then
		      str = str .. name
		   else
		      str = str .. name .. ", "
		   end
		end
	    displayThings = displayThings - 1
		
	    if displayThings == 0 then
	       str = str .. "."
	    else
	       str = str .. ", "
        end
    end
	
	if #mounts > 0 then
	   for index, mount in ipairs(mounts) do
	       local id = mount.id
		   local name = mount.name:lower()
		   if not returnStringOnly then
		      player:addMount(id)
		   end
		   if #mounts == index then
		      str = str .. name
		   else
		      str = str .. name .. ", "
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
		  if #items == index then
	         str = str .. count .. "x " .. getItemName(id)
		  else
		     str = str .. count .. "x " .. getItemName(id) .. ", "
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
	    else
	       str = str .. ", "
        end
	end
	
	if experience > 0 then
	   if not returnStringOnly then
	      player:addExperience(experience)
	   end

	   str = str .. experience 
	   	if highLight then
		   str = str .. "{" 
		end	
	    str = str .. " experience"
	   	if highLight then
		   str = str .. "}" 
		end			
	    displayThings = displayThings - 1
		
	    if displayThings == 0 then
	       str = str .. "."
	    else
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
	    else
	       str = str .. ", "
        end
	end
	
	if premium_points > 0 then
	      if not returnStringOnly then
		     db.query("UPDATE `accounts` set `premium_points` = `premium_points` - " .. premium_points .. " WHERE `id` = " .. player:getAccountId())
		  end
	      str = str .. premium_points .. " premium point"
	   if premium_points > 1 then
	      str = str .. "'s"
	   end
	    displayThings = displayThings - 1
		
	    if displayThings == 0 then
	       str = str .. "."
	    else
	       str = str .. ", "
        end
	end	
	
	if statPoints > 0 then
	      if not returnStringOnly then
		     --db.executeQuery("UPDATE `accounts` set `premium_points` = `premium_points` - " .. premium_points .. " WHERE `id` = " .. player:getAccountId())
			 --player:addStatsPoint(statPoints)
			 StatSystem.addPoints(player, statPoints)
		  end
	      str = str .. statPoints 
		    if highLight then
		      str = str .. "{" 
		    end	
		    str = str .. " stats point"
			
	        if statPoints > 1 then
	           str = str .. "'s"
	        end
			if highLight then
		       str = str .. "}" 
		    end	
	    displayThings = displayThings - 1
		
	    if displayThings == 0 then
	       str = str .. "."
	    else
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
	    else
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
	    else
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
	    else
	       str = str .. ", "
        end
	end
	
	if #stats > 0 then
	   for index, stat in pairs(stats) do
	       local value = stat.value
		   local name = stat.name
		   if not returnStringOnly then
			  ADD_STATS_POINT_SYSTEM:addAbilityPoints(player, name, value)
		   end
		   name = name:lower() .. " stats"
		   str = str .. value .. " "
		   if highLight then
		      str = str .. "{" 
		   end
		      str = str .. name 
		   if highLight then
			  str = str .. "}" 
		   end		  
		   if #stats ~= index then
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
	
	
	if #talents > 0 then
	   for index, talent in pairs(talents) do
	       local value = talent.value
		   if value < 1 then
		      value = value * 100
		   end
		   local name = talent.name
		   if not returnStringOnly then
		      ADD_STATS_POINT_SYSTEM:addTalent(player, name, value)
			  ADD_STATS_POINT_SYSTEM:updateTalent(player, name)
			  --ADD_STATS_POINT_SYSTEM:addAbilityPoints(player, name, value)
		   end
		   name = name:lower()
		   if highLight then
		      str = str .. "{" 
		   end
		      str = str .. name .. " increased by " .. value .. "%"
		   if highLight then
			  str = str .. "}" 
		   end		  
		   if #talents ~= index then
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
	
	if soul > 0 then
	   if not returnStringOnly then
	      player:addSoul(soul)
	   end
	   str = str .. "+" .. soul .. " soul restored"
	    displayThings = displayThings - 1
		
	    if displayThings == 0 then
	       str = str .. "."
	    else
	       str = str .. ", "
        end
	end
	
	if returnStringOnly then
	   return str
	end

end

function dakosLib:getRequiredItems(t, highLight)
    
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
		       str = str .. " and " .. count .. "x " 
			    if highLight then 
			      str = str .. "{" 
				end
			    str = str .. getItemName(id) 
			    if highLight then 
				   str = str .. "}"
				end
		    else
		    if index == #t - 1 or #t == 1 then
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
	    end
		str = str .. "."
		return str
    end
	return false
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
		str = str .. "."
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