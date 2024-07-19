function Player.getExperienceItems(self)

local percentage = 0

for i = CONST_SLOT_HEAD, CONST_SLOT_AMMO do
    local item = self:getSlotItem(i)
	      if item then

	         local it = ItemType(item:getId()) 
				      if self:getItemAbilityEnabled(i) then
			             if it:getExperience() and it:getExperience() > 0 then
				            percentage = percentage + it:getExperience()
		                 end
					  end
          end
end

return percentage
end


HONOR_POINTS_GOLD_BUFF_ACTIVE_STORAGE = 456432
HONOR_POINTS_SILVER_BUFF_ACTIVE_STORAGE = HONOR_POINTS_GOLD_BUFF_ACTIVE_STORAGE + 1
HONOR_POINTS_BRONZE_BUFF_ACTIVE_STORAGE = HONOR_POINTS_SILVER_BUFF_ACTIVE_STORAGE + 1
HONOR_POINTS_SPEED_STORAGE = HONOR_POINTS_BRONZE_BUFF_ACTIVE_STORAGE + 1
HONOR_POINTS_REGENERATION_STORAGE = HONOR_POINTS_SPEED_STORAGE + 1
HONOR_POINTS_CAP_STORAGE = HONOR_POINTS_REGENERATION_STORAGE + 1
HONOR_POINTS_CONDITION_REMOVED_GOLD = HONOR_POINTS_CAP_STORAGE + 1
HONOR_POINTS_CONDITION_REMOVED_SILVER = HONOR_POINTS_CONDITION_REMOVED_GOLD + 1
HONOR_POINTS_CONDITION_REMOVED_BRONZE = HONOR_POINTS_CONDITION_REMOVED_SILVER + 1

function Player.getHonorBuff(self, buff)

    if not self or not buff then
	   return false
	end
	
	local player = Player(self)
	local t = { }
	
	if buff == "Gold" then
	   local storage = HONOR_POINTS_GOLD_BUFF_ACTIVE_STORAGE
	   if player:getStorageValue(storage) >= os.time() then
	      t = { ["Timeleft"] = get_date(player, storage), ["Table"] = buff }
	      return t
		  else
		  return false
	   end
	   
	elseif buff == "Silver" then
	   local storage = HONOR_POINTS_SILVER_BUFF_ACTIVE_STORAGE
	   if player:getStorageValue(storage) >= os.time() then
	      t = { ["Timeleft"] = get_date(player, storage), ["Table"] = buff }
	      return t
		  else
		  return false
	   end
	elseif buff == "Bronze" then
	   local storage = HONOR_POINTS_BRONZE_BUFF_ACTIVE_STORAGE
	   if player:getStorageValue(storage) >= os.time() then
	      t = { ["Timeleft"] = get_date(player, storage), ["Table"] = buff }
	      return t
		  else
		  return false
	   end
	end

	return false
end

function Player.addHonorBuff(self, buff, days)
    if not self or not buff or not days then
	   return false
	end
	
	local player = Player(self)
	
	if buff == "Gold" then
	   if player:getStorageValue(HONOR_POINTS_GOLD_BUFF_ACTIVE_STORAGE) >= os.time() then
	      return false
	   end
	   
	   player:setStorageValue(HONOR_POINTS_GOLD_BUFF_ACTIVE_STORAGE, os.time() + days * 86400)
	   player:addHonorBuffConditions(buff)
       player:setStorageValue(HONOR_POINTS_CONDITION_REMOVED_GOLD, 0)
	   return true
	elseif buff == "Silver" then
	   if player:getStorageValue(HONOR_POINTS_SILVER_BUFF_ACTIVE_STORAGE) >= os.time() then
	      return false
	   end
	   
	   player:setStorageValue(HONOR_POINTS_SILVER_BUFF_ACTIVE_STORAGE, os.time() + days * 86400)
	   player:addHonorBuffConditions(buff)
	   player:setStorageValue(HONOR_POINTS_CONDITION_REMOVED_SILVER, 0)
	   return true
	elseif buff == "Bronze" then
	   if player:getStorageValue(HONOR_POINTS_BRONZE_BUFF_ACTIVE_STORAGE) >= os.time() then
	      return false
	   end
	   
	   player:setStorageValue(HONOR_POINTS_BRONZE_BUFF_ACTIVE_STORAGE, os.time() + days * 86400)
	   player:addHonorBuffConditions(buff)
	   player:setStorageValue(HONOR_POINTS_CONDITION_REMOVED_BRONZE, 0)
	   return true
	end
	
	
	
	return false
end

function Player.addHonorBuffConditions(self, buff)
    if not self or not buff then
	   return false
	end
	
	local player = Player(self)
	local t = HONOR_BUFF_SYSTEM["Honor Buffs"][buff]
	
	if not t then
	   return false
	end
	
	if t.Regeneration then
	
	   if self:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, 80) then
	      self:removeCondition(CONDITION_REGENERATION, 80)
	   end
	   
	   if player:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, 81) then
	      player:removeCondition(CONDITION_REGENERATION, 81)
	   end
	   
	   local mpregen_condition = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	   mpregen_condition:setParameter(CONDITION_PARAM_SUBID, 80)
       mpregen_condition:setTicks(-1)
	   mpregen_condition:setParameter(CONDITION_PARAM_MANAGAIN, t.Regeneration)
       mpregen_condition:setParameter(CONDITION_PARAM_MANATICKS, 1000)

	   local hpregen_condition = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	   hpregen_condition:setParameter(CONDITION_PARAM_SUBID, 81)
       hpregen_condition:setTicks(-1)
	   hpregen_condition:setParameter(CONDITION_PARAM_HEALTHGAIN, t.Regeneration)
       hpregen_condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 1000)
	   
	   player:addCondition(mpregen_condition)
	   player:addCondition(hpregen_condition)
	end
	
	
	   player:setHonorSpeed(buff, false)
	  
	
	if t.increaseCap then
	   local percentage = t.increaseCap / 100
	   if player:getStorageValue(HONOR_POINTS_CAP_STORAGE) < 1 then
	      local value = (player:getCapacity() + (player:getCapacity() * percentage))
		  player:setCapacity(value)
	   end
	end
	
	
	   
	return true
end

function Player.setHonorSpeed(self, buff, loggedin)
   
    if not self or not buff then
	   return nil
	end
		
	local t = HONOR_BUFF_SYSTEM["Honor Buffs"][buff]
	
	if not t then
	   return nil
	end

	if not t.increaseSpeed then
	   return false
	end
	
	local percentage = t.increaseSpeed / 100
	
	if loggedin then
	   if self:getStorageValue(HONOR_POINTS_SPEED_STORAGE) == 1 then
	   	  local delta = math.ceil(self:getSpeed() + (self:getSpeed() * percentage))
	      self:changeSpeed(-self:getSpeed() + ((delta <= 220) and 220 or delta))
	   end
	   return true
	end
    
	
	if self:getStorageValue(HONOR_POINTS_SPEED_STORAGE) < 1 then
	   local delta = math.ceil(self:getSpeed() + (self:getSpeed() * percentage))
	   self:changeSpeed(-self:getSpeed() + ((delta <= 220) and 220 or delta))
	   self:setStorageValue(HONOR_POINTS_SPEED_STORAGE, 1)
       return true
	end
	
	if self:getStorageValue(HONOR_POINTS_SPEED_STORAGE) == 1 then
	   delta = (self:getSpeed() - (self:getSpeed() * percentage))
	   local delta = math.ceil((self:getSpeed() - (self:getSpeed() * percentage)) + 1)
	   self:changeSpeed(-self:getSpeed() + ((delta <= 220) and 220 or delta))
	   self:setStorageValue(HONOR_POINTS_SPEED_STORAGE, 0)
	   return true
	end
	
	-- if self:getStorageValue(HONOR_POINTS_SPEED_STORAGE) == 1 then
	   -- delta = (self:getSpeed() - (self:getSpeed() * percentage))
	   -- local delta = math.ceil((self:getSpeed() - (self:getSpeed() * percentage)) + 1)
	   -- self:changeSpeed(-self:getSpeed() + ((delta <= 220) and 220 or delta))
	-- end
	
	return true
end
	   

	   
function Player.removeHonorBuffConditions(self, buff)
    if not self or not buff then
	   return false
	end
	
	local player = Player(self)
	local t = HONOR_BUFF_SYSTEM["Honor Buffs"][buff]
	
	local storage = nil
	
	if not t then
	   return false
	end
	
	if buff == "Gold" then
	   storage = HONOR_POINTS_CONDITION_REMOVED_GOLD
	   if player:getStorageValue(storage) == 1 then
	   return false
	   end
	elseif buff == "Silver" then
	   storage = HONOR_POINTS_CONDITION_REMOVED_SILVER
       if player:getStorageValue(storage) == 1 then
	   return false
	   end
	elseif buff == "Bronze" then
	   storage = HONOR_POINTS_CONDITION_REMOVED_BRONZE
	   if player:getStorageValue(storage) == 1 then
	   return false
	   end
    end
	
	if not storage then
	   return false
	end
	  
	if t.Regeneration then
	
	   if self:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, 80) then
	      self:removeCondition(CONDITION_REGENERATION, 80)
	   end
	   
	   if player:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, 81) then
	      player:removeCondition(CONDITION_REGENERATION, 81)
	   end
	end
	
	if player:getStorageValue(HONOR_POINTS_SPEED_STORAGE) == 1 then
	   player:setHonorSpeed(buff, false)
	   player:setStorageValue(HONOR_POINTS_SPEED_STORAGE, 0)
	end
	
	if t.increaseCap then
	   local percentage = t.increaseCap / 100
	   if player:getStorageValue(HONOR_POINTS_CAP_STORAGE) == 1 then
	      local value = (player:getCapacity() - (player:getCapacity() * percentage))
		  player:setCapacity(value)
		  player:setStorageValue(HONOR_POINTS_CAP_STORAGE, 0)
	   end
	end
	
	player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Honor Buff" .. "[" .. buff .. "]" .. " is ended!.")
	player:setStorageValue(storage, 1)
	return true
end

function Player.getEquipmentBonuses(self)
    local newStats = {}
    
    for i = 1, 10 do
        local item = self:getSlotItem(i)
        
        if item then
            local stats = item:getBonuses()
            if #stats > 0 then
                local it = item:getType()
                local weapon = false
                if i == CONST_SLOT_RIGHT or i == CONST_SLOT_LEFT then
                    if it:isWeapon() then
                        weapon = true
                    end
                end

                for j = 1, #stats do
                    local statValues = stats[j]:getBonusesValues()
                    for k = 1, #statValues do                    
                        if isInArray(STAT_SYSTEM_STATTABLE, statValues[k].key) then
                            self:assignBonus(newStats, statValues[k])
                        end
                    end
                end                        
            end
        end
    end
    
    return newStats
end


-- function Player.updateBonuses(self, method)
    -- local cid = self:getId()
    -- local checklist = {} -- stats to remove in case they aren't in the updated set
	
	
	-- local currentHealth = self:getHealth()
	-- local maxHealth = self:getMaxHealth()
	
    -- if PLAYERSTATS[cid] then
        -- for k, v in pairs(PLAYERSTATS[cid]) do
            -- checklist[k] = v
        -- end
		        
        -- -- remove outdated stats
        -- for conditionCode, conditionValues in pairs(checklist) do  
		    -- if method == "update all" then
			   -- doRemoveCondition(cid, conditionValues[1], conditionCode)
               -- PLAYERSTATS[cid][conditionCode] = nil
			-- elseif method == "update normal" then
			   -- if not conditionCode == "1101" then
			      -- doRemoveCondition(cid, conditionValues[1], conditionCode)
                  -- PLAYERSTATS[cid][conditionCode] = nil
			   -- end
			-- elseif method == "update health" then
			   -- if conditionCode == "1101" then
			      -- doRemoveCondition(cid, conditionValues[1], conditionCode)
                  -- PLAYERSTATS[cid][conditionCode] = nil
			   -- end
			-- end
        -- end			
        -- else
        -- PLAYERSTATS[cid] = {}
    -- end
    
    -- -- get updated stats
    -- local newStats = self:getEquipmentBonuses()
    -- local updatedStats = {} -- new stats summed
    
    -- for stat, value in pairs(newStats) do
        -- if STAT_SYSTEM_CONDITIONTABLE[stat] then
            -- local vals = {value.flat, value.percent}
            
            -- for i = 1, #vals do
                -- local isFlat = i == 1
                -- if vals[i] then
                    -- local conditionCode = getConditionStatCode(stat, isFlat)

                    -- if conditionCode then
                        -- local conditionType = STAT_SYSTEM_CONDITIONTABLE[stat].type
                        
                        -- if updatedStats[conditionCode] then
                            -- updatedStats[conditionCode][2] = vals[i] + updatedStats[conditionCode][2]
                        -- else
                            -- updatedStats[conditionCode] = {conditionType, vals[i]}
                        -- end
                    -- end
                -- end
            -- end
        -- end
    -- end
    
    -- -- apply updated stats
    -- for conditionCode, conditionValues in pairs(updatedStats) do
        -- local buffType = nil
        -- local buffCode = tonumber(conditionCode:sub(-2, -1))
        
        -- buffType = STAT_SYSTEM_STATTABLE[buffCode]
        
        -- if buffType then
            -- local isFlat = tonumber(conditionCode:sub(-3, -3)) == 1
            -- local playerStat = PLAYERSTATS[cid][conditionCode]
            -- local conditionType = conditionValues[1]
            -- local ignore = false
            
            -- if playerStat then
                -- if playerStat[2] ~= conditionValues[2] then
                    -- doRemoveCondition(cid, conditionType, conditionCode)
                -- else
                    -- ignore = true -- avoid building already existing condition
                -- end
                
                -- checklist[conditionCode] = nil
            -- end

            -- -- build buff condition
            -- if not ignore then
                -- local buff = createConditionObject(conditionType)
                -- local buffValue = calculateBuffValue(self, buffType, conditionValues[2], isFlat)
                -- local buffData = STAT_SYSTEM_CONDITIONTABLE[buffType]
                
                -- setConditionParam(buff, getBonusesBuffParam(buffData, isFlat), buffValue)
                
                -- if buffData.ticks then
                    -- tickType, tickAmount = buffData.ticks(self)
                    -- setConditionParam(buff, tickType, tickAmount * 1000)
                -- end
                
                -- setConditionParam(buff, CONDITION_PARAM_TICKS, -1)
                -- setConditionParam(buff, CONDITION_PARAM_SUBID, conditionCode)
				
				-- if method == "update all" then
				   -- self:addCondition(buff)
				-- elseif method == "update normal" then
				   -- if not buffType == STAT_HP then
				      -- self:addCondition(buff)
                   -- end
                -- elseif method == "update health" then
                   -- if buffType == STAT_HP then	
                      -- self:addCondition(buff)
                   -- end
                -- end				   
				 
							
				
                
                -- PLAYERSTATS[cid][conditionCode] = {conditionType, conditionValues[2]}
            -- end
        -- else
            -- print("[statSystem] Warning: no buff found for STAT_SYSTEM_STATTABLE code " .. conditionCode:sub(0, -4) .. ", value " .. conditionCode:sub(-2, -1) .. " (condition code: " .. conditionCode .. ")")
        -- end
    -- end
    

-- end

-- function Player.updateBonuses(self, method)
    -- local cid = self:getId()
    -- local checklist = {} -- stats to remove in case they aren't in the updated set
	
	
	-- local currentHealth = self:getHealth()
	-- local maxHealth = self:getMaxHealth()
	
    -- if PLAYERSTATS[cid] then
        -- for k, v in pairs(PLAYERSTATS[cid]) do
            -- checklist[k] = v
        -- end
        
    -- -- remove outdated stats
    -- for conditionCode, conditionValues in pairs(checklist) do  
        -- doRemoveCondition(cid, conditionValues[1], conditionCode)
        -- PLAYERSTATS[cid][conditionCode] = nil
    -- end
    
    -- else
        -- PLAYERSTATS[cid] = {}
    -- end
    
    -- -- get updated stats
    -- local newStats = self:getEquipmentBonuses()
    -- local updatedStats = {} -- new stats summed
    
    -- for stat, value in pairs(newStats) do
        -- if STAT_SYSTEM_CONDITIONTABLE[stat] then
            -- local vals = {value.flat, value.percent}
            
            -- for i = 1, #vals do
                -- local isFlat = i == 1
                -- if vals[i] then
                    -- local conditionCode = getConditionStatCode(stat, isFlat)

                    -- if conditionCode then
                        -- local conditionType = STAT_SYSTEM_CONDITIONTABLE[stat].type
                        
                        -- if updatedStats[conditionCode] then
                            -- updatedStats[conditionCode][2] = vals[i] + updatedStats[conditionCode][2]
                        -- else
                            -- updatedStats[conditionCode] = {conditionType, vals[i]}
                        -- end
                    -- end
                -- end
            -- end
        -- end
    -- end
	

    
    -- -- apply updated stats
    -- for conditionCode, conditionValues in pairs(updatedStats) do
        -- local buffType = nil
        -- local buffCode = tonumber(conditionCode:sub(-2, -1))
        
        -- buffType = STAT_SYSTEM_STATTABLE[buffCode]
        
        -- if buffType then
            -- local isFlat = tonumber(conditionCode:sub(-3, -3)) == 1
            -- local playerStat = PLAYERSTATS[cid][conditionCode]
            -- local conditionType = conditionValues[1]
            -- local ignore = false
            
            -- if playerStat then
                -- if playerStat[2] ~= conditionValues[2] then
                    -- doRemoveCondition(cid, conditionType, conditionCode)
                -- else
                    -- ignore = true -- avoid building already existing condition
                -- end
                
                -- checklist[conditionCode] = nil
            -- end

            -- -- build buff condition
            -- if not ignore then
                -- local buff = createConditionObject(conditionType)
                -- local buffValue = calculateBuffValue(self, buffType, conditionValues[2], isFlat)
                -- local buffData = STAT_SYSTEM_CONDITIONTABLE[buffType]
                
                -- setConditionParam(buff, getBonusesBuffParam(buffData, isFlat), buffValue)
                
                -- if buffData.ticks then
                    -- tickType, tickAmount = buffData.ticks(self)
                    -- setConditionParam(buff, tickType, tickAmount * 1000)
                -- end
                
                -- setConditionParam(buff, CONDITION_PARAM_TICKS, -1)
                -- setConditionParam(buff, CONDITION_PARAM_SUBID, conditionCode)
                -- self:addCondition(buff)
                -- PLAYERSTATS[cid][conditionCode] = {conditionType, conditionValues[2]}
            -- end
        -- else
            -- print("[statSystem] Warning: no buff found for STAT_SYSTEM_STATTABLE code " .. conditionCode:sub(0, -4) .. ", value " .. conditionCode:sub(-2, -1) .. " (condition code: " .. conditionCode .. ")")
        -- end
    -- end
	
	-- --self:addHealth(currentHealth)

	-- -- if currentHealth >= maxHealth then
	      -- -- self:addHealth(self:getMaxHealth(), false)
	-- -- end

    

-- end


-- function Player.assignBonus(self, t, statValues)
    -- local k = statValues.key
    
    -- if not t[k] then
        -- t[k] = {}
    -- end

    -- if statValues.sign == "-" then
        -- statValues.amount = -statValues.amount
    -- end

    -- if statValues.flat then
        -- if t[k].flat then
            -- t[k].flat = t[k].flat + statValues.amount
        -- else
            -- t[k].flat = statValues.amount
        -- end
    -- else
        -- if t[k].percent then
            -- t[k].percent = t[k].percent + statValues.amount
        -- else
            -- t[k].percent = statValues.amount
        -- end
    -- end
-- end

-- function Player.bonus_onItemMoved(self, item, fromPosition, toPosition)
    -- if fromPosition.x == 65535 or toPosition.x == 65535 then
        -- if fromPosition.y <= 10 or toPosition.y <= 10 then
            -- self:updateBonuses("update all")
        -- end
    -- end
-- end

function Player.getFireResist(self)

	local value = 0	
	local stats = self:getEquipmentBonuses()
    local elemental = STAT_FIRE_RESIST
	
	if tableHasKey(stats, elemental) then
	local percent = stats[elemental]["percent"]
	value = percent
	end
	
    if value == 0 then
       return false
    end
	
    return value / 100
end


function Player.getEarthResist(self)

	local value = 0	
	local stats = self:getEquipmentBonuses()
    local elemental = STAT_EARTH_RESIST
	
	if tableHasKey(stats, elemental) then
	local percent = stats[elemental]["percent"]
	value = percent
	end
	
    if value == 0 then
       return false
    end
	
    return value / 100
end

function Player.getEnergyResist(self)

	local value = 0	
	local stats = self:getEquipmentBonuses()
    local elemental = STAT_ENERGY_RESIST
	
	if tableHasKey(stats, elemental) then
	local percent = stats[elemental]["percent"]
	value = percent
	end
	
    if value == 0 then
       return false
    end
	
    return value / 100
end

function Player.getIceResist(self)

	local value = 0	
	local stats = self:getEquipmentBonuses()
    local elemental = STAT_ICE_RESIST
	
	if tableHasKey(stats, elemental) then
	local percent = stats[elemental]["percent"]
	value = percent
	end
	
    if value == 0 then
       return false
    end
	
    return value / 100
end

function Player.getHolyResist(self)

	local value = 0	
	local stats = self:getEquipmentBonuses()
    local elemental = STAT_HOLY_RESIST
	
	if tableHasKey(stats, elemental) then
	local percent = stats[elemental]["percent"]
	value = percent
	end
	
    if value == 0 then
       return false
    end
	
    return value / 100
end

function Player.getDeathResist(self)

	local value = 0	
	local stats = self:getEquipmentBonuses()
    local elemental = STAT_DEATH_RESIST
	
	if tableHasKey(stats, elemental) then
	local percent = stats[elemental]["percent"]
	value = percent
	end
	
    if value == 0 then
       return false
    end
	
    return value / 100
end

function Player.getPhysicalResist(self)

	local value = 0	
	local stats = self:getEquipmentBonuses()
    local elemental = STAT_PHYSICAL_RESIST
	
	if tableHasKey(stats, elemental) then
	local percent = stats[elemental]["percent"]
	value = percent
	end
	
    if value == 0 then
       return false
    end
	
    return value / 100
end

function Player.getWandDamage(self, target, type)
	
    local item = self:getSlotItem(CONST_SLOT_LEFT)
	local it = nil
	local _found = false
		
	if item then
	   it = ItemType(item:getId())
	   if it:getRealSlot() == "wand" then
	       _found = true
	   end
	end
	
	if _found then
	   local level = item:getUpgradeLevel()
	         if level > 0 then
	            local atkStr = item:getUpgradeType("attack")[level]
	            atk = tonumber(getValueFromString(atkStr))
				if target then
				   if target:isMonster() then
				      local mType = MonsterType(target:getName())
					  if mType then
					     local elementals = mType:getElementList()
						 if elementals then
						    local elemental = elementals[type] 
						    if elemental and elemental > 0 then
							   elemental = elemental / 100
							   atk = atk - (atk * elemental)
							end
						end
					  end
					end
				end
	            return atk
			end
	end
			 
	return 0
end

function Player.hasUnityCharm(self)
	local slot = self:getSlotItem(CONST_SLOT_AMMO)
	if not slot then
	   return false
	end
		
	local id = slot:getId()
	if not id or id ~= 10342 then
	   return false
	end
	return true
end

function generateChanceTable(table)

    local number = math.random(1, 100)
    local percentage = 0

    for i=1, #table do
        local value = (table[#table + 1 - i].chance)
        if number <= value then
           percentage = table[#table + 1 - i].value
           break
        end
    end
    
    if percentage == 0 then
       return false
    end
    
    return percentage
end