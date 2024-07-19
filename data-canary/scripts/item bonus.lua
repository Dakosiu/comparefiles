if not ITEM_BONUS_SYSTEM then
   ITEM_BONUS_SYSTEM = {}
end

ITEM_BONUS_SYSTEM.config = {
                              WEAPON_BONUS = {
                                               [42315] = {
												           ["Avaible Bonuses"] = {
															                      "BONUS_SPECIAL_SKILL_LIFE_LEECH_AMOUNT",
																				  "BONUS_SPECIAL_SKILL_MANA_LEECH_AMOUNT",
																				  "BONUS_SPECIAL_SKILL_CRITICAL_CHANCE"
																			     },
															  ["Values"] = {
															                 ["Percentage"] = {
									                                                           [1] = { chance = 1000, value = 1 },
												                                               [2] = { chance = 250, value = 2 },
												                                               [3] = { chance = 0.01, value = 3 },
                                                                                              }													  
															               },
														 },
                                             },
                              EQUIPMENT_BONUS = {
                                                  [31356] = {
												              ["Avaible Slots"] = { "shield", "legs", "armor" },
												              ["Avaible Bonuses"] = {
															                          "BONUS_RESISTANCE_FIRE",
			                                                                          "BONUS_RESISTANCE_EARTH",
			                                                                          "BONUS_RESISTANCE_ENERGY",
																					  "BONUS_RESISTANCE_ICE",
																					  "BONUS_RESISTANCE_HOLY",
																					  "BONUS_RESISTANCE_DEATH",
																					  "BONUS_RESISTANCE_PHYSICAL",
																					},
															  ["Values"] = {
															                 ["Percentage"] = {
															                                    [1] = { chance = 1000, value = 1 },
						                                                                        [2] = { chance = 500, value = 2 },
						                                                                        [3] = { chance = 150, value = 3 },
						                                                                        [4] = { chance = 100, value = 4 },
						                                                                        [5] = { chance = 0.01, value = 5 },
                                                                                              }													  
															               },
															},
												   [31355] = {
												               _chanceForPercentage = 0.9,
												               ["Avaible Bonuses"] = {
															                           "BONUS_STAT_HEALTH",
																					   "BONUS_STAT_MANA",
																					 },
															   ["Values"] = {					 
															                  ["Normal"] = {
															                                 [1] = { chance = 1000, value = 25 },
												                                             [2] = { chance = 500, value = 50 },
												                                             [3] = { chance = 100, value = 75 },
												                                             [4] = { chance = 0.01, value = 100 },
																			               },
															                  ["Percentage"] = {
															                                     [1] = { chance = 1000, value = 1 },
												                                                 [2] = { chance = 500, value = 2 },
												                                                 [3] = { chance = 100, value = 3 },
												                                                 [4] = { chance = 0.01, value = 4 },
																	                            }
																			}
															},	
												   [31354] = {
												               _chanceForPercentage = 0.9,
												               ["Avaible Bonuses"] = {
															                           "BONUS_SKILL_MAGICLEVEL",
																					   "BONUS_SKILL_ALL",
																					 },
															   ["Values"] = {					 
															                  ["Normal"] = {
															                                     [1] = { chance = 1000, value = 1 },
												                                                 [2] = { chance = 500, value = 2 },
												                                                 [3] = { chance = 100, value = 3 },
												                                                 [4] = { chance = 20, value = 4 },
																								 [5] = { chance = 0.01, value = 5 },
																						   },
															                  ["Percentage"] = {
															                                     [1] = { chance = 1000, value = 1 },
												                                                 [2] = { chance = 500, value = 2 },
												                                                 [3] = { chance = 100, value = 3 },
												                                                 [4] = { chance = 20, value = 4 },
																								 [5] = { chance = 0.01, value = 5 },
																	                            }
																			}
															},																
                                                }
												
                           }

ITEM_BONUS_SYSTEM.players = {}
					   
ITEM_BONUS_SYSTEM.subid =  {
                              skills = 832,
							  specialskills = 932,
							  stats = 1032
							}
							   


ITEM_BONUS_SYSTEM.attributeList = {
                                    BONUS_RESISTANCE_PHYSICAL =  { key = "item_bonus_resist_physical", text = "physical resistance" },
									BONUS_RESISTANCE_ENERGY =    { key = "item_bonus_resist_energy", text = "energy resistance" },
									BONUS_RESISTANCE_EARTH =     { key = "item_bonus_resist_earth", text = "earth resistance" },
									BONUS_RESISTANCE_FIRE =      { key = "item_bonus_resist_fire", text = "fire resistance" },
									BONUS_RESISTANCE_UNDEFINED = { key = "item_bonus_resist_undefined", text = "undefined resistance" },
									BONUS_RESISTANCE_LIFEDRAIN = { key = "item_bonus_resist_lifedrain", text = "lifedrain resistance" },
									BONUS_RESISTANCE_MANADRAIN = { key = "item_bonus_resist_manadrain", text = "manadrain resistance" },
									BONUS_RESISTANCE_DROWN =     { key = "item_bonus_resist_drown", text = "drown resistance" },
									BONUS_RESISTANCE_ICE =       { key = "item_bonus_resist_ice", text = "ice resistance" },
									BONUS_RESISTANCE_HOLY =      { key = "item_bonus_resist_holy", text = "holy resistance" },
									BONUS_RESISTANCE_DEATH =     { key = "item_bonus_resist_death", text = "death resistance" },
								  }						  
ITEM_BONUS_SYSTEM.skillsList = {								  
                                 BONUS_SKILL_SWORD = { key = "item_bonus_skill_sword", text = "sword" },
								 BONUS_SKILL_AXE = { key = "item_bonus_skill_axe", text = "axe" },
								 BONUS_SKILL_CLUB = { key = "item_bonus_skill_club", text = "club" },
								 BONUS_SKILL_DISTANCE = { key = "item_bonus_skill_distance", text = "distance" },
								 BONUS_SKILL_SHIELD = { key = "item_bonus_skill_shield", text = "shield" },
								 BONUS_SKILL_MAGICLEVEL = { key = "item_bonus_skill_magiclevel", text = "magic level" },
								 BONUS_SKILL_ALL = { key = "item_bonus_skill_all", text = "all skills" },
							   }
							   
ITEM_BONUS_SYSTEM.specialSkillsList = {							  
                                        BONUS_SPECIAL_SKILL_LIFE_LEECH_CHANCE = { key = "item_bonus_special_skill_life_leech_chance", text = "life leech chance" },
								        BONUS_SPECIAL_SKILL_LIFE_LEECH_AMOUNT = { key = "item_bonus_special_skill_life_leech_amount", text = "life leech amount" },
                                        BONUS_SPECIAL_SKILL_MANA_LEECH_CHANCE = { key = "item_bonus_special_skill_mana_leech_chance", text = "mana leech chance" },
								        BONUS_SPECIAL_SKILL_MANA_LEECH_AMOUNT = { key = "item_bonus_special_skill_mana_leech_amount", text = "mana leech amount" },	
									    BONUS_SPECIAL_SKILL_CRITICAL_CHANCE = { key = "item_bonus_special_skill_critical_chance", text = "critical chance" },
								        BONUS_SPECIAL_SKILL_CRITICAL_AMOUNT = { key = "item_bonus_special_skill_critical_amount", text = "critical amount" },
							          }
							   
ITEM_BONUS_SYSTEM.statsList = {	
                                BONUS_STAT_HEALTH = { key = "item_bonus_health", text = "health" },
                                BONUS_STAT_MANA = { key = "item_bonus_mana", text = "mana" },
                              }								


ITEM_BONUS_SYSTEM.skillsCondition = {
                                      BONUS_SKILL_SWORD =      { flat = CONDITION_PARAM_SKILL_SWORD, percent = CONDITION_PARAM_SKILL_SWORDPERCENT },
                                      BONUS_SKILL_AXE =        { flat = CONDITION_PARAM_SKILL_AXE, percent = CONDITION_PARAM_SKILL_AXEPERCENT },
                                      BONUS_SKILL_CLUB =       { flat = CONDITION_PARAM_SKILL_CLUB, percent = CONDITION_PARAM_SKILL_CLUBPERCENT },
                                      BONUS_SKILL_DISTANCE =   { flat = CONDITION_PARAM_SKILL_DISTANCE, percent = CONDITION_PARAM_SKILL_DISTANCEPERCENT },	
								      BONUS_SKILL_SHIELD =     { flat = CONDITION_PARAM_SKILL_SHIELD, percent = CONDITION_PARAM_SKILL_SHIELDPERCENT },
								      BONUS_SKILL_MAGICLEVEL = { flat = CONDITION_PARAM_STAT_MAGICPOINTS, percent = CONDITION_PARAM_STAT_MAGICPOINTSPERCENT },
									  BONUS_SKILL_ALL =        { flat = CONDITION_PARAM_SKILL_ALL, percent = CONDITION_PARAM_SKILL_ALLPERCENT }
							        }
									
									
ITEM_BONUS_SYSTEM.specialSkillsCondition = {
                                             BONUS_SPECIAL_SKILL_LIFE_LEECH_CHANCE = { flat = CONDITION_PARAM_SKILL_LIFE_LEECH_CHANCE, percent = CONDITION_PARAM_SKILL_LIFE_LEECH_CHANCE },
											 BONUS_SPECIAL_SKILL_LIFE_LEECH_AMOUNT = { flat = CONDITION_PARAM_SKILL_LIFE_LEECH_CUSTOM, percent = CONDITION_PARAM_SKILL_LIFE_LEECH_CUSTOM },
											 BONUS_SPECIAL_SKILL_MANA_LEECH_CHANCE = { flat = CONDITION_PARAM_SKILL_MANA_LEECH_CHANCE, percent = CONDITION_PARAM_SKILL_MANA_LEECH_CHANCE },
											 BONUS_SPECIAL_SKILL_MANA_LEECH_AMOUNT = { flat = CONDITION_PARAM_SKILL_MANA_LEECH_CUSTOM, percent = CONDITION_PARAM_SKILL_MANA_LEECH_CUSTOM },
											 BONUS_SPECIAL_SKILL_CRITICAL_CHANCE   = { flat = CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE, percent = CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE },
											 BONUS_SPECIAL_SKILL_CRITICAL_AMOUNT   = { flat = CONDITION_PARAM_SKILL_CRITICAL_HIT_AMOUNT, percent = CONDITION_PARAM_SKILL_CRITICAL_HIT_AMOUNT }
							               }
									
ITEM_BONUS_SYSTEM.statsCondition = {
                                      BONUS_STAT_HEALTH = { flat = CONDITION_PARAM_STAT_MAXHITPOINTS, percent = CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT },
                                      BONUS_STAT_MANA   = { flat = CONDITION_PARAM_STAT_MAXMANAPOINTS, percent = CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT }
							       }									
									
ITEM_BONUS_SYSTEM.storageHealth = 4474121


ITEM_BONUS_SYSTEM.bonusIndex = {
                                 ["ITEM_BONUS_SYSTEM.statsList"] = 1,
								 ["ITEM_BONUS_SYSTEM.skillsList"] = 2,
                                 ["ITEM_BONUS_SYSTEM.attributeList"] = 3,
								 ["ITEM_BONUS_SYSTEM.specialSkillsList"] = 4
				               }

function ITEM_BONUS_SYSTEM:generateValueTable(t)
    
	local valueTable = nil
	
	local percentTable = t["Values"]["Percentage"]
	local normalTable = t["Values"]["Normal"]
	if not percentTable then
	   return { ["Table"] = normalTable, ["Percentage"] = false }
	end
	
	if not normalTable then
	   return { ["Table"] = percentTable, ["Percentage"] = true }
	end
	
	local percentChance = t._chanceForPercentage
	if not percentChance then
	   percentChance = 0.5
	end
	
	local chance = 0
	if percentChance < 1 then
	   chance = percentChance * 100
	else
	   chance = percentChance
	end
	local rand = math.random(1, 100)
	if rand <= chance then
	   return { ["Table"] = percentTable, ["Percentage"] = true }
	end
	return { ["Table"] = normalTable, ["Percentage"] = false }
end
	
function ITEM_BONUS_SYSTEM:generateBonus(t)
    
	local bonusTable = t["Avaible Bonuses"]
    
	local valuesTable = ITEM_BONUS_SYSTEM:generateValueTable(t)
     	
	local chanceTable = valuesTable["Table"]
	local isPercentage = valuesTable["Percentage"]
											
	table.sort(chanceTable, function(a, b) return a.chance < b.chance end)
	
	
	local list2 = {}
	
	local lastChance = 0
	local rand = math.random(0, 1000)
	for i, v in ipairs(chanceTable) do
		local chance = v.chance
		if not chance then
		   chance = 100
		end
		if chance < 1 then
		   chance = chance * 1000
		end	
		
		
		if rand <= chance then
		   if lastChance == 0 or v.chance <= lastChance then
			  list2[#list2 + 1] = v
			  lastChance = v.chance
		   end
		end
	end
	
	if #list2 == 0 then
	   return "empty"
	end
					
	local value = list2[math.random(1, #list2)].value
	local name = bonusTable[math.random(1, #bonusTable)]
	local values = { ["Name"] = name, ["Value"] = value, ["Percentage"] = isPercentage }

	return values
end
	    	
function ITEM_BONUS_SYSTEM:getBonusIndex(attribute)
   local name = ITEM_BONUS_SYSTEM:findTableName(attribute)   
   for i, v in pairs(self.bonusIndex) do
       if i == name then
	      return v
	   end
   end
   return false
end
   
function ITEM_BONUS_SYSTEM:getValue(player, attribute)
    local value = 0
	for i = CONST_SLOT_FIRST, CONST_SLOT_LAST do
		local item = player:getSlotItem(i)
		if item then
		   local it = ItemType(item:getId())
		   if it then
			  local slot = it:getRealSlot2()
			  if slot then
				 local itemValue = ITEM_BONUS_SYSTEM:getAttribute(item, attribute)
				 if slot == "weapon" then
					if i == CONST_SLOT_LEFT or i == CONST_SLOT_RIGHT then
					   if itemValue and itemValue > 0 then
                          value = value + itemValue
                       end
					end
                    elseif i == slot then
 						if itemValue and itemValue > 0 then
                           value = value + itemValue
                        end                           
					end
			    end
			end
		end
	end	
	return value
end

function ITEM_BONUS_SYSTEM:getSingleValue(player, target, attribute)
    local value = 0
	for i = CONST_SLOT_FIRST, CONST_SLOT_LAST do
		local item = player:getSlotItem(i)
		if item and item == target then
		   local it = ItemType(item:getId())
		   if it then
			  local slot = it:getRealSlot2()
			  if slot then
				 local itemValue = ITEM_BONUS_SYSTEM:getAttribute(item, attribute)
				 if slot == "weapon" then
					if i == CONST_SLOT_LEFT or i == CONST_SLOT_RIGHT then
					   if itemValue and itemValue > 0 then
                          value = value + itemValue
						  return value
                       end
					end
                    elseif i == slot then
 						if itemValue and itemValue > 0 then
                           value = value + itemValue
						   return value
                        end                           
					end
			    end
			end
		end
	end	
	return value
end

function ITEM_BONUS_SYSTEM:updateSkills(player, item, removeBonus)
	local t = ITEM_BONUS_SYSTEM.skillsCondition
	for i, v in pairs(t) do	
        	
	    if ITEM_BONUS_SYSTEM:getAttribute(item, ITEM_BONUS_SYSTEM.skillsList[i]) > 0 then
		   local value = ITEM_BONUS_SYSTEM:getSingleValue(player, item, ITEM_BONUS_SYSTEM.skillsList[i])
		   local subid = ITEM_BONUS_SYSTEM:getSubID(player, item, "skills")		   
		   if not subid then
		      subid = ITEM_BONUS_SYSTEM:getFreeSubId(player, "skills")
			  ITEM_BONUS_SYSTEM:setSubID(player, item, subid, "skills")
		   end

	       local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
		   local conditionParam = nil
		   if ITEM_BONUS_SYSTEM:isPercentage(item, ITEM_BONUS_SYSTEM.skillsList[i]) then
	          conditionParam = tonumber(v.percent)
			  value = tonumber(value + 100)
		   else
		      conditionParam = tonumber(v.flat)
		   end
		   
		   if removeBonus then
		      value = 0
		   end
	       condition:setParameter(conditionParam, value)
	       condition:setParameter(CONDITION_PARAM_SUBID, subid)
	       condition:setTicks(-1)
		   player:addCondition(condition)
		 end
	end
end

function ITEM_BONUS_SYSTEM:updateAllSkills(player)
   
   	for i = CONST_SLOT_FIRST, CONST_SLOT_LAST do
	    for index, v in pairs(ITEM_BONUS_SYSTEM.skillsList) do
		    local item = player:getSlotItem(i)
		    if item then
		       local it = ItemType(item:getId())
		       if it then
			      local slot = it:getRealSlot2()
			      if slot then
				     local itemValue = ITEM_BONUS_SYSTEM:getAttribute(item, v)
				     if slot == "weapon" then
					    if i == CONST_SLOT_LEFT or i == CONST_SLOT_RIGHT then
					      if itemValue and itemValue > 0 then
                             ITEM_BONUS_SYSTEM:updateSkills(player, item)
                          end
					    end
                    elseif i == slot then
 						if itemValue and itemValue > 0 then
                           ITEM_BONUS_SYSTEM:updateSkills(player, item, true)
                        end                           
					end
			     end
			  end
			end
		end
	end	
end

function ITEM_BONUS_SYSTEM:updateSpecialSkills(player, item, removeBonus)
	local t = ITEM_BONUS_SYSTEM.specialSkillsCondition
	for i, v in pairs(t) do	
        	
	    if ITEM_BONUS_SYSTEM:getAttribute(item, ITEM_BONUS_SYSTEM.specialSkillsList[i]) > 0 then
		   local value = ITEM_BONUS_SYSTEM:getSingleValue(player, item, ITEM_BONUS_SYSTEM.specialSkillsList[i])
		   
		   local subid = ITEM_BONUS_SYSTEM:getSubID(player, item, "specialskills")
           		   
		   if not subid then
		      subid = ITEM_BONUS_SYSTEM:getFreeSubId(player, "specialskills")
			  ITEM_BONUS_SYSTEM:setSubID(player, item, subid, "specialskills")
		   end

	       local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
		   local conditionParam = nil
		   if ITEM_BONUS_SYSTEM:isPercentage(item, ITEM_BONUS_SYSTEM.specialSkillsList[i]) then
	          conditionParam = tonumber(v.percent)
		   else
		      conditionParam = tonumber(v.flat)
		   end
		   if removeBonus then
		      value = 0
		   end
	       condition:setParameter(conditionParam, value)
	       condition:setParameter(CONDITION_PARAM_SUBID, subid)
	       condition:setTicks(-1)
		   -- addEvent(function(player_id)
		      -- local player = Player(player_id)
			  -- if not player then
			     -- return false
		      -- end
		      -- player:addCondition(condition)
		   -- end, 50, player:getId())
		     player:addCondition(condition)
		 end
	end
end

function ITEM_BONUS_SYSTEM:updateAllSpecialSkills(player)
   
   	for i = CONST_SLOT_FIRST, CONST_SLOT_LAST do
	    for index, v in pairs(ITEM_BONUS_SYSTEM.specialSkillsList) do
		    local item = player:getSlotItem(i)
		    if item then
		       local it = ItemType(item:getId())
		       if it then
			      local slot = it:getRealSlot2()
			      if slot then
				     local itemValue = ITEM_BONUS_SYSTEM:getAttribute(item, v)
				     if slot == "weapon" then
					    if i == CONST_SLOT_LEFT or i == CONST_SLOT_RIGHT then
					      if itemValue and itemValue > 0 then
                             ITEM_BONUS_SYSTEM:updateSpecialSkills(player, item)
                          end
					    end
                    elseif i == slot then
 						if itemValue and itemValue > 0 then
                           ITEM_BONUS_SYSTEM:updateSpecialSkills(player, item, true)
                        end                           
					end
			     end
			  end
			end
		end
	end	
end

function ITEM_BONUS_SYSTEM:getSubID(player, item, tableName)
     
	local t = ITEM_BONUS_SYSTEM.players[player:getName()]
    if not t then
	   return false
	end
	
	if not t[tableName] then 
	   return false
	end

	local subid = tonumber(t[tableName][item:getId()])
	if subid then
	   return subid
	end
	return false
end

function ITEM_BONUS_SYSTEM:setSubID(player, item, value, tableName)
    if not ITEM_BONUS_SYSTEM.players[player:getName()] then
	   ITEM_BONUS_SYSTEM.players[player:getName()] = {}
	end
	
	if not ITEM_BONUS_SYSTEM.players[player:getName()][tableName] then
	   ITEM_BONUS_SYSTEM.players[player:getName()][tableName] = {}
	end
	ITEM_BONUS_SYSTEM.players[player:getName()][tableName][item:getId()] = tonumber(value)
end

function ITEM_BONUS_SYSTEM:getFreeSubId(player, tableName)
    
	local subid = self.subid[tableName]
	
    local t = ITEM_BONUS_SYSTEM.players[player:getName()]
    if not t then
	   return subid
	end
	
	if not t[tableName] then
	   return subid
    end
	
	local value = 0
	for i, v in pairs(t[tableName]) do
		if value < v then
		   value = v
		end
	end
	
	if value > 0 then
	   return value + 1
	end
	return subid
end

function ITEM_BONUS_SYSTEM:updateStats(player, item, removeBonus)
	local t = ITEM_BONUS_SYSTEM.statsCondition
	for i, v in pairs(t) do	
	    if ITEM_BONUS_SYSTEM:getAttribute(item, ITEM_BONUS_SYSTEM.statsList[i]) > 0 then
		   local value = ITEM_BONUS_SYSTEM:getSingleValue(player, item, ITEM_BONUS_SYSTEM.statsList[i])
		   local subid = ITEM_BONUS_SYSTEM:getSubID(player, item, "stats")		   
		   if not subid then
		      subid = ITEM_BONUS_SYSTEM:getFreeSubId(player, "stats")
			  ITEM_BONUS_SYSTEM:setSubID(player, item, subid, "stats")
		   end

	       local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
		   local conditionParam = nil
		   if ITEM_BONUS_SYSTEM:isPercentage(item, ITEM_BONUS_SYSTEM.statsList[i]) then
	          conditionParam = tonumber(v.percent)
			  value = tonumber(value + 100)
		   else
		      conditionParam = tonumber(v.flat)
		   end
		   
		   if removeBonus then
		      value = 0
		   end
	       condition:setParameter(conditionParam, value)
	       condition:setParameter(CONDITION_PARAM_SUBID, subid)
	       condition:setTicks(-1)
		   player:addCondition(condition)
		 end
	end
end

function ITEM_BONUS_SYSTEM:updateAllStats(player)
   
   	for i = CONST_SLOT_FIRST, CONST_SLOT_LAST do
	    for index, v in pairs(ITEM_BONUS_SYSTEM.statsList) do
		    local item = player:getSlotItem(i)
		    if item then
		       local it = ItemType(item:getId())
		       if it then
			      local slot = it:getRealSlot2()
			      if slot then
				     local itemValue = ITEM_BONUS_SYSTEM:getAttribute(item, v)
				     if slot == "weapon" then
					    if i == CONST_SLOT_LEFT or i == CONST_SLOT_RIGHT then
					      if itemValue and itemValue > 0 then
                             ITEM_BONUS_SYSTEM:updateStats(player, item)
                          end
					    end
                    elseif i == slot then
 						if itemValue and itemValue > 0 then
                           ITEM_BONUS_SYSTEM:updateStats(player, item, true)
                        end                           
					end
			     end
			  end
			end
		end
	end	
	
	local value = player:getStorageValue(ITEM_BONUS_SYSTEM.storageHealth)
	if value and value > 0 then
	   player:addHealth(value, true)
	end
	
end

function ITEM_BONUS_SYSTEM:findTable(attribute)
    local t = ITEM_BONUS_SYSTEM.attributeList
    for i, v in pairs(t) do
	    if i == attribute then
		   return t
		end
	end
	t = ITEM_BONUS_SYSTEM.skillsList
	for i, v in pairs(t) do
	    if i == attribute then
		   return t
		end
	end
	t = ITEM_BONUS_SYSTEM.statsList
	for i, v in pairs(t) do
	    if i == attribute then
		   return t
		end
	end	
	t = ITEM_BONUS_SYSTEM.specialSkillsList
	for i, v in pairs(t) do
	    if i == attribute then
		   return t
		end
	end	
	return false
end

function ITEM_BONUS_SYSTEM:findTableName(attribute)
    local t = ITEM_BONUS_SYSTEM.attributeList
    for i, v in pairs(t) do
	    if i == attribute then
		   return "ITEM_BONUS_SYSTEM.attributeList"
		end
	end
	t = ITEM_BONUS_SYSTEM.skillsList
	for i, v in pairs(t) do
	    if i == attribute then
		   return "ITEM_BONUS_SYSTEM.skillsList"
		end
	end
	t = ITEM_BONUS_SYSTEM.statsList
	for i, v in pairs(t) do
	    if i == attribute then
		   return "ITEM_BONUS_SYSTEM.statsList"
		end
	end	
	t = ITEM_BONUS_SYSTEM.specialSkillsList
	for i, v in pairs(t) do
	    if i == attribute then
		   return "ITEM_BONUS_SYSTEM.specialSkillsList"
		end
	end	
	return false
end

function ITEM_BONUS_SYSTEM:removeAttributes(item, t)
	for i, v in pairs(t) do
	    item:removeCustomAttribute(v.key)
	end
end

-- function ITEM_BONUS_SYSTEM:canUpgrade(item, gem, attribute)

    -- local name = ITEM_BONUS_SYSTEM:findTableName(attribute)
	
	-- if not name then
	   -- return false
	-- end

	-- local it = ItemType(item:getId())
	-- if it then
	   -- local slot = it:getRealSlot()
	   -- if not slot then
	      -- return false
	   -- end
	   -- print("Slot Name: " .. slot)
	   -- if slot == "boots" then
	      -- if name ~= "ITEM_BONUS_SYSTEM.skillsList" then
		     -- return false
	      -- end
	   -- elseif slot == "weapon" then
	      -- --player:say("Weapon?")
	      -- if name == "ITEM_BONUS_SYSTEM.skillsList" or name == "ITEM_BONUS_SYSTEM.specialSkillsList" then
		     -- print("Tu return?")
		     -- return true
		  -- end
	      -- return false
	   -- elseif slot == "legs" or slot == "armor" or slot == "ring" or slot == "necklace" or slot == "helmet" then
	      -- if name == "ITEM_BONUS_SYSTEM.skillsList" or name == "ITEM_BONUS_SYSTEM.specialSkillsList" then
		     -- return false
	      -- end
	   -- end
    -- end
   -- return true
-- end	


function ITEM_BONUS_SYSTEM:canUpgrade(item, gem, attribute)
    
	local it = ItemType(item:getId())
	if not it then
	   return false
	end
	
	local slot = it:getRealSlot()
	if not slot then
	   return false
	end

	local name = ITEM_BONUS_SYSTEM:findTableName(attribute)
	if not name then
	   return false
	end
		
	local isWeaponGem = ITEM_BONUS_SYSTEM.config.WEAPON_BONUS[gem:getId()]
	if isWeaponGem then	   
	   local ret = 1
	   if slot == "weapon" or slot == "wand" or slot == "distance" then
	      ret = 0
	   end	  
       if ret == 1 then
          return false
       end		  
	end
	
	if name == "ITEM_BONUS_SYSTEM.attributeList" then
	    local t = ITEM_BONUS_SYSTEM.config.EQUIPMENT_BONUS[gem:getId()]
	    local avaibleSlots = t["Avaible Slots"]
	    if avaibleSlots then
	        if not isInArray(avaibleSlots, slot) then
		       return false
	        end
	    end
	end
	
	if slot == "boots" then
	   if name ~= "ITEM_BONUS_SYSTEM.skillsList" then
	      return false
	   end
	   return true
	elseif slot == "weapon" or slot == "wand" or slot == "distance" then
	   if name ~= "ITEM_BONUS_SYSTEM.specialSkillsList" then
	      return false
	   end
	   return true
    end	   
		
	
	return true
end
	   
	
	
	
	   

function ITEM_BONUS_SYSTEM:setAttribute(item, t, value)
    return item:setCustomAttribute(t.key, value)
end
								  
function ITEM_BONUS_SYSTEM:addAttribute(item, t, value)
    local count = 0
	local countAttribute = self:getAttribute(item, t)
	if countAttribute then
	   count = countAttribute
	end
    return item:setCustomAttribute(t.key, count + value)
end

function ITEM_BONUS_SYSTEM:getAttribute(item, t)
    local value = 0
	local countAttribute = item:getCustomAttribute(t.key)
	if countAttribute then
	   value = countAttribute
	end
	return value
end

function ITEM_BONUS_SYSTEM:setPercentage(item, t, bool)	
    local key = tostring(t.key) .. "_percent"
	if bool then
	   item:setCustomAttribute(key, 1)
	else
	   item:setCustomAttribute(key, 0)
	end
	return true
end

function ITEM_BONUS_SYSTEM:isPercentage(item, t)
    local key = tostring(t.key) .. "_percent"
	local value = item:getCustomAttribute(key)
	if not value or value == 0 then
	   return false
	end
	return true
end
	



local creatureevent = CreatureEvent("ITEM_BONUS_SYSTEM_onLogin")
function creatureevent.onLogin(player)
   player:registerEvent("ITEM_BONUS_SYSTEM_onDeath")
   addEvent(function(player_id)
		      local player = Player(player_id)
			  if not player then
			     return false
		      end
			  ITEM_BONUS_SYSTEM:updateAllSpecialSkills(player)
			  ITEM_BONUS_SYSTEM:updateAllSkills(player)
			  ITEM_BONUS_SYSTEM:updateAllStats(player)
   end, 50, player:getId())
   
   -- addEvent(function(player_id)
		      -- local player = Player(player_id)
			  -- if not player then
			     -- return false
		      -- end
			  -- ITEM_BONUS_SYSTEM:updateAllSkills(player)
   -- end, 70, player:getId())
   
   -- addEvent(function(player_id)
		      -- local player = Player(player_id)
			  -- if not player then
			     -- return false
		      -- end
			  -- ITEM_BONUS_SYSTEM:updateAllStats(player)
   -- end, 100, player:getId())
   
   --ITEM_BONUS_SYSTEM:updateAllSkills(player)
   --ITEM_BONUS_SYSTEM:updateAllStats(player)
   --ITEM_BONUS_SYSTEM:updateAllSpecialSkills(player)
   return true
end
creatureevent:register()

creatureevent = CreatureEvent("ITEM_BONUS_SYSTEM_onLogout")
function creatureevent.onLogout(player)
   player:setStorageValue(ITEM_BONUS_SYSTEM.storageHealth, player:getHealth())
   return true
end
creatureevent:register()
					
							  
								  

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
	if not target then
	   return true
	end
	
	
	local itemTable = ITEM_BONUS_SYSTEM.config.EQUIPMENT_BONUS[item:getId()]
	if not itemTable then
       itemTable = ITEM_BONUS_SYSTEM.config.WEAPON_BONUS[item:getId()]
	end
	
	if not itemTable then
	   return true
	end
	

	
	if itemTable then
	   local values = ITEM_BONUS_SYSTEM:generateBonus(itemTable)
	  
	  if not values then
	     player:sendTextMessage(MESSAGE_STATUS_WARNING, "You can't upgrade this item with this gem.")
	     return true
	  end
	  
	  
	   if values == "empty" then
	      player:sendTextMessage(MESSAGE_STATUS_WARNING, "Gem has no effective power on item, upgrade failed!")
	      item:remove(1)
	      return true
	   end
	   
	   local bonus = values["Name"]
	   

	   if not ITEM_BONUS_SYSTEM:canUpgrade(target, item, bonus) then
	      player:sendTextMessage(MESSAGE_STATUS_WARNING, "You can't upgrade this item with this gem.")
	      return true
	   end

	   

	   

	   
	   local t = ITEM_BONUS_SYSTEM:findTable(bonus)
	   local bonusTable = t[bonus]
	   local value = values["Value"]
	   ITEM_BONUS_SYSTEM:removeAttributes(target, t)
	   ITEM_BONUS_SYSTEM:setAttribute(target, bonusTable, value)
	   
	   
	   local str = bonusTable.text
	   str = str:gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)
	   str = str .. " +" .. value 
	   local isPercent = values["Percentage"]
	   if isPercent then
	      str = str .. "%"
		  ITEM_BONUS_SYSTEM:setPercentage(target, bonusTable, true)
	   else
	      ITEM_BONUS_SYSTEM:setPercentage(target, bonusTable, false)
	   end
	   
	   
	   
	   local index = ITEM_BONUS_SYSTEM:getBonusIndex(bonus)
	   target:setCustomAttribute("bonuses" .. index, str)
	   ITEM_BONUS_SYSTEM:updateSkills(player, target)
	   ITEM_BONUS_SYSTEM:updateStats(player, target)
	   ITEM_BONUS_SYSTEM:updateSpecialSkills(player, target)
	   
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "Upgrade Sucesfull, " .. str .. ".")
	   player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	   item:remove(1)
	   return true
	end		 
return true
end
					
for i, weapon in pairs(ITEM_BONUS_SYSTEM.config.WEAPON_BONUS) do
action:id(i)
end	

for i, equipment in pairs(ITEM_BONUS_SYSTEM.config.EQUIPMENT_BONUS) do
action:id(i)
end			
action:register()