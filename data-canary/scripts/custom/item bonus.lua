




-- local function removeAttribute(item)
    
	-- if not item then
	   -- return nil
	-- end

	-- local key = "item_bonus_resist_physical"
	-- if item:getCustomAttribute(key) and item:getCustomAttribute(key) > 0 then
	   -- item:removeCustomAttribute(key)
	-- end
	-- key = "item_bonus_resist_energy"
	-- if item:getCustomAttribute(key) and item:getCustomAttribute(key) > 0 then
	   -- item:removeCustomAttribute(key)
	-- end	
	-- key = "item_bonus_resist_earth"
	-- if item:getCustomAttribute(key) and item:getCustomAttribute(key) > 0 then
	   -- item:removeCustomAttribute(key)
	-- end	
	-- key = "item_bonus_resist_fire" 
	-- if item:getCustomAttribute(key) and item:getCustomAttribute(key) > 0 then
	   -- item:removeCustomAttribute(key)
	-- end	
	-- key = "item_bonus_resist_undefined" 
	-- if item:getCustomAttribute(key) and item:getCustomAttribute(key) > 0 then
	   -- item:removeCustomAttribute(key)
	-- end	
	-- key = "item_bonus_resist_lifedrain" 
	-- if item:getCustomAttribute(key) and item:getCustomAttribute(key) > 0 then
	   -- item:removeCustomAttribute(key)
	-- end	
	-- key = "item_bonus_resist_manadrain" 
	-- if item:getCustomAttribute(key) and item:getCustomAttribute(key) > 0 then
	   -- item:removeCustomAttribute(key)
	-- end	
	-- key = "item_bonus_resist_drown" 
	-- if item:getCustomAttribute(key) and item:getCustomAttribute(key) > 0 then
	   -- item:removeCustomAttribute(key)
	-- end	
	-- key = "item_bonus_resist_ice" 
	-- if item:getCustomAttribute(key) and item:getCustomAttribute(key) > 0 then
	   -- item:removeCustomAttribute(key)
	-- end		
	-- key = "item_bonus_resist_holy" 
	-- if item:getCustomAttribute(key) and item:getCustomAttribute(key) > 0 then
	   -- item:removeCustomAttribute(key)
	-- end		
	-- key = "item_bonus_resist_death" 
	-- if item:getCustomAttribute(key) and item:getCustomAttribute(key) > 0 then
	   -- item:removeCustomAttribute(key)
	-- end
-- end	

-- local function addAttribute(item, bonusName, bonusValue, t)
    -- if not t or not bonusName or not item then
	   -- return nil
	-- end
	
	-- removeAttribute(item)
	-- for _, name in pairs(t) do
		-- if name == bonusName then
		   -- if bonusName == "Physical Resist" then
		      -- item:addPhysicalResist(bonusValue)
		   -- elseif bonusName == "Energy Resist" then
		      -- item:addEnergyResist(bonusValue)
		   -- elseif bonusName == "Earth Resist" then
		      -- item:addEarthResist(bonusValue)
		   -- elseif bonusName == "Fire Resist" then
		      -- item:addFireResist(bonusValue)
		   -- elseif bonusName == "Undefined Resist" then
		      -- item:addUndefinedResist(bonusValue)	
		   -- elseif bonusName == "LifeDrain Resist" then
		      -- item:addLifeDrainResist(bonusValue)	
		   -- elseif bonusName == "ManaDrain Resist" then
		      -- item:addManaDrainResist(bonusValue)	
		   -- elseif bonusName == "Drown Resist" then
		      -- item:addDrownResist(bonusValue)	
		   -- elseif bonusName == "Ice Resist" then
		      -- item:addIceResist(bonusValue)					  
		   -- elseif bonusName == "Holy Resist" then
		      -- item:addHolyResist(bonusValue)
		   -- elseif bonusName == "Death Resist" then
		      -- item:addDeathResist(bonusValue)	
		   -- end
		-- end
	-- end
-- end



-- local action = Action()
-- function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
         -- local pos = player:getPosition()
		 
		 
		 -- local weaponBonus = ITEM_BONUS_SYSTEM.WEAPON_BONUS[item:getId()]
		 -- if weaponBonus then
		 			
			-- if target.itemid == 0 then
			-- return true
			-- end
			
			-- local id = target:getId()			
			-- local it = ItemType(id)
            -- local slot = it:getRealSlot()
		    -- local _isWeapon = false
			
			-- if not slot then
			-- return true
			-- end
			
			-- if slot == "wand" or slot == "weapon" or slot == "distance" then
			-- _isWeapon = true
			-- end
			
			-- if not _isWeapon then
			   -- player:sendTextMessage(MESSAGE_STATUS_WARNING, "This gem can be only used on weapons.")
			   -- return true
			-- end
		    
		    -- local percentage = generateChanceTable(weaponBonus)
		    -- if not percentage then
			   -- player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have failed adding bonus to item.")
			   -- pos:sendMagicEffect(CONST_ME_POFF)
		       -- item:remove(1)
			   -- return true
	        -- end
			
			-- local bonus = weaponBonus.AVAIBLE_BONUSES[math.random(1, #weaponBonus.AVAIBLE_BONUSES)]
			
			-- local allBonuses = target:getBonuses()
			-- local newTable = target:getBonuses()
			
			-- for z = 1, #weaponBonus.AVAIBLE_BONUSES do
			    -- local b = weaponBonus.AVAIBLE_BONUSES[z]
				-- for i, bonuses in pairs(target:getBonuses()) do
				    -- if string.find(bonuses, b) then
					   -- table.remove(newTable, i)
					-- end
			    -- end
			-- end
			
			-- target:removeCustomAttribute(CUSTOM_ATTRIBUTE_BONUSES)
			-- target:removeCustomAttribute("bonuses1")
			-- target:removeCustomAttribute("bonuses2")
			-- target:removeCustomAttribute("bonuses3")
						
		    -- for i, bonuses in pairs(newTable) do
			    -- local t = newTable[i]:getBonusesValues()
                      -- local key = t[1].key
                      -- local amount = t[1].amount
					  -- local sign = t[1].sign
					  -- local flat = t[1].flat
					 					  
					  -- if flat == false then
					     -- target:addBonus(key, sign .. amount .. "%", i)
						 -- else
						 -- target:addBonus(key, sign .. amount, i)
					 -- end
					  
			-- end
			
			-- local index = #target:getBonuses() + 1
						
			-- if method then
			   -- if method == "normal" then
			      -- target:addBonus(bonus, "+" .. percentage, index)
				  -- else
				  -- target:addBonus(bonus, "+" .. percentage .. "%", index)
			   -- end
			   -- else
			-- target:addBonus(bonus, "+" .. percentage .. "%", index)
			-- end
						
			-- item:remove(1)
			
			-- if method == "normal" then
			-- player:sendTextMessage(MESSAGE_INFO_DESCR, "You have sucessfully added bonus: " .. bonus .. "+" .. percentage  .. " to item.")
			-- else
			-- player:sendTextMessage(MESSAGE_INFO_DESCR, "You have sucessfully added bonus: " .. bonus .. "+" .. percentage  .. "%" .. " to item.")
			-- end
			-- pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
			-- if bonus == STAT_HP then
			   -- player:updateBonuses("update health")
			-- else
			   -- player:updateBonuses("update normal")
			-- end
			-- return true
			
	     -- end
		 
		 -- local equipmentBonus = ITEM_BONUS_SYSTEM.EQUIPMENT_BONUS[item:getId()]
		 -- if equipmentBonus then
		 			
			-- if target.itemid == 0 then
			-- return true
			-- end
			
			-- local id = target:getId()			
			-- local it = ItemType(id)
            -- local slot = it:getRealSlot()
		    -- local _isWeapon = false
			
			-- if not slot then
			-- return true
			-- end
			
			-- if slot == "wand" or slot == "weapon" or slot == "distance" then
			-- _isWeapon = true
			-- end
			
			-- local isStatGem = false
			-- local canUseOnBoots = false
			
		    -- for i, bonuses in pairs(equipmentBonus.AVAIBLE_BONUSES) do
				-- if bonuses == STAT_ALLSKILLS then
				-- isStatGem = true
				-- break
				-- end
			-- end
			
			-- if not isStatGem then
			   -- if slot == "boots" then
			      -- player:sendTextMessage(MESSAGE_STATUS_WARNING, "You can't use this gem on boots.")
				  -- return true
			   -- elseif _isWeapon then
			      -- player:sendTextMessage(MESSAGE_STATUS_WARNING, "You can't use this gem on weapons.")
				  -- return true
			   -- end
			-- end
			   		    
			-- local percentage = 0
			-- local method = nil
			
			-- if equipmentBonus.NORMAL then
			   -- local number = math.random(0,1) 
			   -- if number == 0 then
			      -- method = "normal"
				  -- else
				  -- method = "percentage"
			   -- end
			-- end
			
			-- if method then
			   -- if method == "normal" then
			      -- percentage = generateChanceTable(equipmentBonus.NORMAL)
				  -- else
				  -- percentage = generateChanceTable(equipmentBonus.PERCENTAGES)
			   -- end
			   -- else
			      -- percentage = generateChanceTable(equipmentBonus)
		    -- end
			
		    -- if not percentage then
			   -- player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have failed adding bonus to item.")
			   -- pos:sendMagicEffect(CONST_ME_POFF)
		       -- item:remove(1)
			   -- return true
	        -- end
						
			-- local bonus = equipmentBonus.AVAIBLE_BONUSES[math.random(1, #equipmentBonus.AVAIBLE_BONUSES)]
						
			-- local allBonuses = target:getBonuses()
			-- local newTable = target:getBonuses()
			
			-- for z = 1, #equipmentBonus.AVAIBLE_BONUSES do
			    -- local b = equipmentBonus.AVAIBLE_BONUSES[z]
				-- for i, bonuses in pairs(target:getBonuses()) do
				    -- if string.find(bonuses, b) then
					   -- table.remove(newTable, i)
					-- end
			    -- end
			-- end
			
			-- target:removeCustomAttribute(CUSTOM_ATTRIBUTE_BONUSES)
			-- target:removeCustomAttribute("bonuses1")
			-- target:removeCustomAttribute("bonuses2")
			-- target:removeCustomAttribute("bonuses3")
						
		    -- for i, bonuses in pairs(newTable) do
			    -- local t = newTable[i]:getBonusesValues()
                      -- local key = t[1].key
                      -- local amount = t[1].amount
					  -- local sign = t[1].sign
					  -- local flat = t[1].flat
					 					  
					  -- if flat == false then
					     -- target:addBonus(key, sign .. amount .. "%", i)
						 -- else
						 -- target:addBonus(key, sign .. amount, i)
					 -- end
					  
			-- end
			
			-- local index = #target:getBonuses() + 1
						
			-- if method then
			   -- if method == "normal" then
			      -- target:addBonus(bonus, "+" .. percentage, index)
				  -- else
				  -- target:addBonus(bonus, "+" .. percentage .. "%", index)
			   -- end
			   -- else
			   -- target:addBonus(bonus, "+" .. percentage .. "%", index)
			   -- addAttribute(target, bonus, percentage, equipmentBonus.AVAIBLE_BONUSES)
			-- end
						
			-- item:remove(1)
			-- if method == "normal" then
			-- player:sendTextMessage(MESSAGE_INFO_DESCR, "You have sucessfully added bonus: " .. bonus .. "+" .. percentage  .. " to item.")
			-- else
			-- player:sendTextMessage(MESSAGE_INFO_DESCR, "You have sucessfully added bonus: " .. bonus .. "+" .. percentage  .. "%" .. " to item.")
			-- end
			-- pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
			-- if bonus == STAT_HP then
			   -- player:updateBonuses("update health")
			-- else
			   -- player:updateBonuses("update normal")
			-- end
			-- return true
			
	     -- end
		 		 
-- return true
-- end
					
-- for i, weapon in pairs(ITEM_BONUS_SYSTEM.WEAPON_BONUS) do
-- action:id(i)
-- end	

-- for i, equipment in pairs(ITEM_BONUS_SYSTEM.EQUIPMENT_BONUS) do
-- action:id(i)
-- end			
-- action:register()

-- local playerLogin = CreatureEvent("ItemSystemLogin")
-- function playerLogin.onLogin(player)
    -- player:updateBonuses("update all")
	-- player:registerEvent("ItemSystemResistance")
    -- return true
-- end

-- playerLogin:register()

-- local playerResistance = CreatureEvent("ItemSystemResistance")
-- function playerResistance.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
        
    -- local player = Player(creature) 
	
    -- if player == nil then
	   -- return primaryDamage, primaryType, secondaryDamage, secondaryType
	-- end
	
	-- if primaryType == COMBAT_PHYSICALDAMAGE then
	   -- if player:getPhysicalResist() then
	      -- primaryDamage = primaryDamage - (primaryDamage * player:getPhysicalResist())
	   -- end
	-- elseif primaryType == COMBAT_FIREDAMAGE then
	   -- if player:getFireResist() then
	      -- primaryDamage = primaryDamage - (primaryDamage * player:getFireResist())
	   -- end
	-- elseif primaryType == COMBAT_EARTHDAMAGE then
	   -- if player:getEarthResist() then
	      -- primaryDamage = primaryDamage - (primaryDamage * player:getEarthResist())
	   -- end
	-- elseif primaryType == COMBAT_ENERGYDAMAGE then
	   -- if player:getEnergyResist() then
	      -- primaryDamage = primaryDamage - (primaryDamage * player:getEnergyResist())
	   -- end
    -- elseif primaryType == COMBAT_ICEDAMAGE then
	   -- if player:getIceResist() then
	      -- primaryDamage = primaryDamage - (primaryDamage * player:getIceResist())
	   -- end
	-- elseif primaryType == COMBAT_HOLYDAMAGE then
	   -- if player:getHolyResist() then
	      -- primaryDamage = primaryDamage - (primaryDamage * player:getHolyResist())
	   -- end
	-- elseif primaryType == COMBAT_DEATHDAMAGE then
	   -- if player:getDeathResist() then
	      -- primaryDamage = primaryDamage - (primaryDamage * player:getDeathResist())
	   -- end
	-- end
	
	
	-- return primaryDamage, primaryType, secondaryDamage, secondaryType
-- end
-- playerResistance:register()