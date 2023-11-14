if not SacraficeSystem then
   SacraficeSystem = {}
end
	
SacraficeSystem.config = {
                           [1] = {
                                   npcName = "Blooresia Sacra",
                                   missions = {
                                                [1] = {
						                                requiredLevel = 50, 
								                        --LevelsToSacrafice = 5,
														method = { name = "sacrafice level", value = 5 },
								                        rewards = { 
											                        { type = "stats points", value = 1 },
											                      }
								                      }, 
                                                [2] = {
						                                requiredLevel = 75, 
								                        method = { name = "sacrafice level", value = 10 },
								                        rewards = { 
											                        { type = "stats points", value = 2 },
											                      }
								                      }, 	
                                                [3] = {
						                                requiredLevel = 100, 
														method = { name = "sacrafice level", value = 20 },
								                        rewards = { 
											                        { type = "stats points", value = 5 },
											                      }
								                      },
                                                 [4] = {
						                                requiredLevel = 125, 
								                        method = { name = "sacrafice level", value = 40 },
								                        rewards = { 
											                        { type = "stats points", value = 10 },
																	{ type = "item", itemid = 40554, count = 100 },
											                       }
								                       } 													  
                                              }
                                 },
								 
                           [2] = {
                                   npcName = "Capcrificus Cappicus",
                                   missions = {
                                                [1] = {
						                                requiredLevel = 120, 
								                        --LevelsToSacrafice = 5,
														method = { name = "sacrafice capacity", value = 200 },
								                        rewards = { 
											                        { type = "stats points", value = 1 },
											                      }
								                      }, 
                                                [2] = {
						                                requiredLevel = 140, 
								                        method = { name = "sacrafice capacity", value = 500 },
								                        rewards = { 
											                        { type = "stats points", value = 2 },
											                      }
								                      }, 	
                                                [3] = {
						                                requiredLevel = 160, 
														method = { name = "sacrafice capacity", value = 1000 },
								                        rewards = { 
											                        { type = "stats points", value = 3 },
											                      }
								                      },
                                                 [4] = {
						                                requiredLevel = 220, 
								                        method = { name = "sacrafice capacity", value = 2000 },
								                        rewards = { 
											                        { type = "stats points", value = 5 },
											                        { type = "item", itemid = 12666, count = 1 },
											                        { type = "outfit", male = 932, female = 932, addon = 3, name = "Werewolf Alfa Outfit" },
											                       }
								                       } 													  
                                              }
											  
                                 },	
								 
                           [3] = {
                                   npcName = "Renttiele Sacra",
                                   missions = {
                                                [1] = {
						                                requiredLevel = 150, 
								                        --LevelsToSacrafice = 5,
														method = { name = "sacrafice level", value = 10 },
								                        rewards = { 
											                        { type = "stats points", value = 1 },
											                      }
								                      }, 
                                                [2] = {
						                                requiredLevel = 180, 
								                        method = { name = "sacrafice level", value = 20 },
								                        rewards = { 
											                        { type = "stats points", value = 3 },
											                      }
								                      }, 	
                                                [3] = {
						                                requiredLevel = 200, 
														method = { name = "sacrafice level", value = 30 },
								                        rewards = { 
											                        { type = "stats points", value = 5 },
											                      }
								                      },
                                                 [4] = {
						                                requiredLevel = 220, 
								                        method = { name = "sacrafice level", value = 50 },
								                        rewards = { 
											                        { type = "stats points", value = 10 },
																	{ type = "shadder", id = 16, name = "Black Outline Shader" },
																	{ type = "item", itemid = 40554, count = 200 },
											                       }
								                       } 													  
                                              }
                                 },	

                           [4] = {
                                   npcName = "Senntos Cappicus",
                                   missions = {
                                                [1] = {
						                                requiredLevel = 450, 
								                        --LevelsToSacrafice = 5,
														method = { name = "sacrafice capacity", value = 500 },
								                        rewards = { 
											                        { type = "stats points", value = 1 },
																	{ type = "item", itemid = 40554, count = 20 },
											                      }
								                      }, 
                                                [2] = {
						                                requiredLevel = 470, 
								                        method = { name = "sacrafice capacity", value = 1000 },
								                        rewards = { 
											                        { type = "stats points", value = 2 },
																	{ type = "item", itemid = 40554, count = 40 },
											                      }
								                      }, 	
                                                [3] = {
						                                requiredLevel = 490, 
														method = { name = "sacrafice capacity", value = 2000 },
								                        rewards = { 
											                        { type = "stats points", value = 3 },
																	{ type = "item", itemid = 40554, count = 60 },
																	{ type = "item", itemid = 12666, count = 2 },
											                      }
								                      },
                                                 [4] = {
						                                requiredLevel = 530, 
								                        method = { name = "sacrafice capacity", value = 4000 },
								                        rewards = { 
											                        { type = "stats points", value = 5 },
											                        { type = "item", itemid = 40554, count = 100 },
																	{ type = "item", itemid = 11754, count = 2 },
											                        { type = "outfit", male = 1407, female = 1407, addon = 3, name = "Scorpion King Outfit" },
											                       }
								                       } 													  
                                              }
											  
                                 },	
								 
						   [5] = {
                                   npcName = "Rattutulianee",
                                   missions = {
                                                [1] = {
						                                requiredLevel = 120, 
								                        --LevelsToSacrafice = 5,
														method = { name = "sacrafice capacity", value = 200 },
								                        rewards = { 
											                        { type = "stats points", value = 1 },
											                      }
								                      }, 
                                                [2] = {
						                                requiredLevel = 140, 
								                        method = { name = "sacrafice capacity", value = 500 },
								                        rewards = { 
											                        { type = "stats points", value = 2 },
											                      }
								                      }, 	
                                                [3] = {
						                                requiredLevel = 160, 
														method = { name = "sacrafice capacity", value = 3000 },
								                        rewards = { 
											                        { type = "stats points", value = 3 },
											                      }
								                      },
                                                 [4] = {
						                                requiredLevel = 220, 
								                        method = { name = "sacrafice capacity", value = 4000 },
								                        rewards = { 
								                                    { type = "premium points", value = 5 },
											                        { type = "stats points", value = 5 },
											                        { type = "item", itemid = 2470, count = 1 },
											                        { type = "money", value = 500 },
											                        { type = "wings", id = 3, name = "Dark Wings" },
											                        { type = "shadder", id = 1, name = "Rainbow Shadder" },
											                        { type = "aura", id = 1, name = "Protection Aura" },
											                        { type = "outfit", male = 145, female = 149, addon = 3, name = "Wizard Outfit" },
											                        { type = "mount", id = 7, name = "Titanica Mount" },
											                       }
								                       } 													  
                                              }
											  
                                 },	
								 
								 [6] = {
                                   npcName = "Elysandria Sacra",
                                   missions = {
                                                [1] = {
						                                requiredLevel = 250, 
								                        --LevelsToSacrafice = 5,
														method = { name = "sacrafice level", value = 15 },
								                        rewards = { 
											                        { type = "stats points", value = 1 },
																	{ type = "item", itemid = 26377, count = 1 },
											                      }
								                      }, 
                                                [2] = {
						                                requiredLevel = 280, 
								                        method = { name = "sacrafice level", value = 30 },
								                        rewards = { 
											                        { type = "stats points", value = 3 },
																	{ type = "item", itemid = 26377, count = 1 },
																	{ type = "item", itemid = 26144, count = 1 },
																	{ type = "item", itemid = 26377, count = 1 },
											                      }
								                      }, 	
                                                [3] = {
						                                requiredLevel = 320, 
														method = { name = "sacrafice level", value = 50 },
								                        rewards = { 
											                        { type = "stats points", value = 5 },
																	{ type = "item", itemid = 26377, count = 1 },
																	{ type = "item", itemid = 26144, count = 1 },
																	{ type = "item", itemid = 26377, count = 1 },
											                      }
								                      },
                                                 [4] = {
						                                requiredLevel = 360, 
								                        method = { name = "sacrafice level", value = 70 },
								                        rewards = { 
											                        { type = "stats points", value = 10 },
																	{ type = "shadder", id = 17, name = "Bluerish Shrine Shader" },
																	{ type = "item", itemid = 40554, count = 300 },
																	{ type = "item", itemid = 26377, count = 1 },
																	{ type = "item", itemid = 26144, count = 2 },
																	{ type = "item", itemid = 36765, count = 2 },
											                       }
								                       } 													  
                                              }
                                 },	
								 
								 [7] = {
                                   npcName = "Isolindra Sacra",
                                   missions = {
                                                [1] = {
						                                requiredLevel = 380, 
								                        --LevelsToSacrafice = 5,
														method = { name = "sacrafice level", value = 20 },
								                        rewards = { 
											                        { type = "stats points", value = 1 },
											                      }
								                      }, 
                                                [2] = {
						                                requiredLevel = 400, 
								                        method = { name = "sacrafice level", value = 40 },
								                        rewards = { 
											                        { type = "stats points", value = 3 },
																	{ type = "item", itemid = 26377, count = 1 },
																	{ type = "item", itemid = 26144, count = 1 },
																	{ type = "item", itemid = 36765, count = 1 },
											                      }
								                      }, 	
                                                [3] = {
						                                requiredLevel = 420, 
														method = { name = "sacrafice level", value = 60 },
								                        rewards = { 
											                        { type = "stats points", value = 5 },
																	{ type = "item", itemid = 26377, count = 1 },
																	{ type = "item", itemid = 26144, count = 2 },
																	{ type = "item", itemid = 36765, count = 2 },
											                      }
								                      },
                                                 [4] = {
						                                requiredLevel = 440, 
								                        method = { name = "sacrafice level", value = 80 },
								                        rewards = { 
											                        { type = "stats points", value = 10 },
																	{ type = "shadder", id = 18, name = "Redish Shrine Shader" },
																	{ type = "shadder", id = 19, name = "Greenish Shrine Shader" },
																	{ type = "shadder", id = 20, name = "Ywllowish Shrine Shader" },
																	{ type = "shadder", id = 21, name = "Transparent Shrine Shader" },
																	{ type = "item", itemid = 40554, count = 400 },
																	{ type = "item", itemid = 26377, count = 1 },
																	{ type = "item", itemid = 26144, count = 2 },
																	{ type = "item", itemid = 36765, count = 2 },
											                       }
								                       } 													  
                                              }
                                 },	
								 
								 [8] = {
                                   npcName = "Galadrielle Sacra",
                                   missions = {
                                                [1] = {
						                                requiredLevel = 510, 
								                        --LevelsToSacrafice = 5,
														method = { name = "sacrafice level", value = 25 },
								                        rewards = { 
											                        { type = "stats points", value = 2 },
											                      }
								                      }, 
                                                [2] = {
						                                requiredLevel = 540, 
								                        method = { name = "sacrafice level", value = 50 },
								                        rewards = { 
											                        { type = "stats points", value = 6 },
											                      }
								                      }, 	
                                                [3] = {
						                                requiredLevel = 570, 
														method = { name = "sacrafice level", value = 75 },
								                        rewards = { 
											                        { type = "stats points", value = 10 },
																	{ type = "item", itemid = 26144, count = 1 },
																	{ type = "item", itemid = 36765, count = 1 },
											                      }
								                      },
												[4] = {
						                                requiredLevel = 600, 
														method = { name = "sacrafice level", value = 100 },
								                        rewards = { 
											                        { type = "stats points", value = 15 },
																	{ type = "item", itemid = 26144, count = 1 },
																	{ type = "item", itemid = 36765, count = 1 },
											                      }
								                      },
												[5] = {
						                                requiredLevel = 630, 
														method = { name = "sacrafice level", value = 125 },
								                        rewards = { 
											                        { type = "stats points", value = 20 },
																	{ type = "item", itemid = 26377, count = 1 },
																	{ type = "item", itemid = 26144, count = 1 },
																	{ type = "item", itemid = 36765, count = 1 },
											                      }
								                      },
												[6] = {
						                                requiredLevel = 660, 
														method = { name = "sacrafice level", value = 150 },
								                        rewards = { 
											                        { type = "stats points", value = 25 },
																	{ type = "item", itemid = 26377, count = 1 },
																	{ type = "item", itemid = 26144, count = 2 },
																	{ type = "item", itemid = 36765, count = 2 },
											                      }
								                      },
                                                 [7] = {
						                                requiredLevel = 690, 
								                        method = { name = "sacrafice level", value = 175 },
								                        rewards = { 
											                        { type = "stats points", value = 30 },
																	{ type = "shadder", id = 26, name = "Blue Wave Shader" },
																	{ type = "shadder", id = 27, name = "Green Wave Shader" },
																	{ type = "shadder", id = 28, name = "Orange Wave Shader" },
																	{ type = "shadder", id = 29, name = "White Wave Shader" },
																	{ type = "aura", id = 13, name = "Angel Aura" },
																	{ type = "item", itemid = 40554, count = 500 },
																	{ type = "item", itemid = 26377, count = 3 },
																	{ type = "item", itemid = 26144, count = 4 },
																	{ type = "item", itemid = 36765, count = 4 },
											                       }
								                       } 													  
                                              }
                                 },	

								 
                         }								 
						     
SacraficeSystem.storage = 451221
function SacraficeSystem:getNpcId(name)
	for i, v in ipairs(self.config) do
	    local npcName = v.npcName
		if name == npcName or name:lower() == npcName:lower() then
		   return i
		end
	end
end

function SacraficeSystem:getMissionId(player, index)
    local value = player:getStorageValue(self.storage + index)
	if value < 1 then
	   value = 1
	elseif value > #self.config[index].missions then
	   return false
	end
	return value
end
   
function SacraficeSystem:getTable(player, index)
	local value = SacraficeSystem:getMissionId(player, index)
    if not value then
	   return false
	end
	
	return self.config[index].missions[value]
end

function SacraficeSystem:processMission(player, index)
    local id = SacraficeSystem:getMissionId(player, index)
	if not id then
	   return false
	end
	return player:setStorageValue(self.storage + index, id + 1)
end

function SacraficeSystem:getExperienceForLevel(level)
	level = level - 1
	return ((50 * level * level * level) - (150 * level * level) + (400 * level)) / 3
end

function SacraficeSystem:sacraficeLevels(player, value)
    local experience = player:getExperience()
	local level = player:getLevel()
	return player:removeExperience(experience - self:getExperienceForLevel(level - value))
end

function SacraficeSystem:sacraficeCapacity(player, value)
    local freeCap = player:getFreeCapacity()
	if freeCap < value then
	   return false
	end
	local cap = player:getCapacity()
	player:setCapacity((cap - value) * 100)
	return true
end


function SacraficeSystem:addReward(player, t, customString, returnStringOnly, skipText)
    
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
	
	local displayThings = 0
	local str = "You have received: "
	
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
		  if #items == index then
	         str = str .. count .. "x " .. getItemName(id)
		  else
		     str = str .. count .. "x " .. getItemName(id) .. ", "
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
	    elseif displayThings == 1 then
	       str = str .. " and "
	    elseif displayThings > 1 then
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
	    elseif displayThings == 1 then
	       str = str .. " and "
	    elseif displayThings > 1 then
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
	    elseif displayThings == 1 then
	       str = str .. " and "
	    elseif displayThings > 1 then
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
	    elseif displayThings == 1 then
	       str = str .. " and "
	    elseif displayThings > 1 then
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
	    elseif displayThings == 1 then
	       str = str .. " and "
	    elseif displayThings > 1 then
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
	  elseif displayThings == 1 then
	     str = str .. " and "
	  elseif displayThings > 1 then
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
		     db.query("UPDATE `accounts` set `premium_points` = `premium_points` - " .. premium_points .. " WHERE `id` = " .. player:getAccountId())
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
	
	if statPoints > 0 then
	      if not returnStringOnly then
		     --db.executeQuery("UPDATE `accounts` set `premium_points` = `premium_points` - " .. premium_points .. " WHERE `id` = " .. player:getAccountId())
			 player:addStatsPoint(statPoints)
		  end
	      str = str .. statPoints .. " stat point"
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