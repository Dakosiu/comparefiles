if not ADD_STATS_POINT_SYSTEM then
   ADD_STATS_POINT_SYSTEM = {} 
end

ADD_STATS_POINT_SYSTEM.config = {
                                     -- [1] = {
						                     -- itemID = 2494,
											 -- usages = 99,
									         -- rewards = { 
									                     -- { type = "talent", name = "Experience Gain", value = 1 },
											           -- }

								           -- },
                                     -- [2] = {
						                     -- itemID = 2495,
											 -- usages = 2,
									         -- rewards = { 
									                     -- { type = "stats", name = "Trapped Energy", value = 1 },
														
											           -- }

								           -- },
                                     -- [3] = {
						                     -- itemID = 2470,
											 -- usages = 50,
									         -- rewards = { 
									                     -- { type = "talent", name = "Health", value = 0.01 },
														 -- { type = "talent", name = "Mana", value = 0.01 },
														 -- { type = "talent", name = "Experience Gain", value = 0.01 },
														 -- { type = "talent", name = "Reflect", value = 0.01 },
														 -- { type = "talent", name = "Dodge", value = 0.01 },
														 -- { type = "talent", name = "Speed", value = 0.01 },
														 -- { type = "talent", name = "Healing", value = 0.01 },
														 -- { type = "talent", name = "Attack", value = 0.01 },
														 -- { type = "talent", name = "Attack Speed", value = 0.01 },
														 -- { type = "talent", name = "Trapped Energy", value = 0.01 },
														 -- { type = "stats", name = "Trapped Energy", value = 1 },
														 -- { type = "item", id = 2473, count = 1 },
														 -- { type = "soul", value = 30 },
														
											           -- }

								           -- }											  
						        }
								
								
ADD_STATS_POINT_SYSTEM.pointsStorage = 126000								
ADD_STATS_POINT_SYSTEM.abilitiesTable = {
                                          ["Health"] = ADD_STATS_POINT_SYSTEM.pointsStorage,
									      ["Mana"] = ADD_STATS_POINT_SYSTEM.pointsStorage + 1,
									      ["Attack"] = ADD_STATS_POINT_SYSTEM.pointsStorage + 2,
									      ["Protection All"] = ADD_STATS_POINT_SYSTEM.pointsStorage + 3,
									      ["Healing"] = ADD_STATS_POINT_SYSTEM.pointsStorage + 4,
									      ["Reflect"] = ADD_STATS_POINT_SYSTEM.pointsStorage + 5,
									      ["Dodge"] = ADD_STATS_POINT_SYSTEM.pointsStorage + 6,
									      ["Speed"] = ADD_STATS_POINT_SYSTEM.pointsStorage + 7,
									      ["Trapped Energy"] = ADD_STATS_POINT_SYSTEM.pointsStorage + 8,
									      ["Experience Gain"] = ADD_STATS_POINT_SYSTEM.pointsStorage + 9,
									      ["Critical Chance"] = ADD_STATS_POINT_SYSTEM.pointsStorage + 10,
									      ["Critical Damage"] = ADD_STATS_POINT_SYSTEM.pointsStorage + 11,
									      ["Life Leech Chance"] = ADD_STATS_POINT_SYSTEM.pointsStorage + 12,
									      ["Life Leech Amount"] = ADD_STATS_POINT_SYSTEM.pointsStorage + 13,
									      ["Mana Leech Chance"] = ADD_STATS_POINT_SYSTEM.pointsStorage + 14,
									      ["Mana Leech Amount"] = ADD_STATS_POINT_SYSTEM.pointsStorage + 15,
                                          ["Attack Speed"] = ADD_STATS_POINT_SYSTEM.pointsStorage + 16												
								        }								
							

ADD_STATS_POINT_SYSTEM.subid = {
                                 ["Health"] = 300,
								 ["Mana"] = 301,
							   }
						 
ADD_STATS_POINT_SYSTEM.storage = 32250	
					 
local function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function ADD_STATS_POINT_SYSTEM:findTable(id)
    for i, v in ipairs(self.config) do
        if v.itemID == id then
	       return v
		end
	end
	return false
end

function ADD_STATS_POINT_SYSTEM:findIndex(id)
    for i, v in ipairs(self.config) do
        if v.itemID == id then
	       return i
		end
	end
	return false
end

function ADD_STATS_POINT_SYSTEM:getUsages(player, index)
	local value = player:getStorageValue(self.storage + index)
	if value < 0 then
	   value = 0
	end
	return value
end

function ADD_STATS_POINT_SYSTEM:addUsages(player, index, value)
	if not value then
	   value = 1
	end
	return player:setStorageValue(self.storage + index, self:getUsages(player, index) + value)
end

function ADD_STATS_POINT_SYSTEM:canUse(player, index)
    
	local id = item:getId()
	local t = self.config[index]
    
    if not t then
       return false
    end
    
	local usages = t.usages
	if not usages then
	   return true
	end
	
	if ADD_STATS_POINT_SYSTEM:getUsages(player, index) >= usages then
	    player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have already used this item " .. usages .. " times.")
	    return false
	end
	
	return true
end

function ADD_STATS_POINT_SYSTEM:getPrice(player, t, storagex)
		local added = 0
		for i, v in pairs(t) do
			local c = player:getStorageValue(storagex) 
			local d = v.Limit * v.Gain
			local e = t
			if e[1] and c < e[1].Limit and added < 1 then
				added = added + 1
				return { e[1].Price, e[1].Gain, e[1].Limit }
			elseif e[2] and c >= e[1].Limit and c < e[2].Limit and added < 1 then
				added = added + 1
				return { e[2].Price, e[2].Gain, e[2].Limit }
			elseif e[3] and c >= e[2].Limit and c < e[3].Limit and added < 1 then
				added = added + 1
				return { e[3].Price, e[3].Gain, e[3].Limit }
			elseif e[4] and c >= e[3].Limit and c < e[4].Limit and added < 1 then
				added = added + 1
				return { e[4].Price, e[4].Gain, e[4].Limit }
			elseif e[5] and c >= e[4].Limit and c < e[5].Limit and added < 1 then
				added = added + 1
				return { e[5].Price, e[5].Gain, e[5].Limit }
			end
		end	
	return false
end

function ADD_STATS_POINT_SYSTEM:getTalent(player, ability)
 	local key = self.abilitiesTable[ability]
	if not key then
	   key = self.abilitiesTable[firstToUpper(ability)]
	end
	
	local value = player:getStorageValue(key)
	if value < 0 then
	   value = 0
	end
	return value
end

function ADD_STATS_POINT_SYSTEM:addTalent(player, ability, value)
	local key = self.abilitiesTable[ability]
	if not key then
	   key = self.abilitiesTable[firstToUpper(ability)]
	end
	local count = ADD_STATS_POINT_SYSTEM:getTalent(player, ability) --* 100
	return player:setStorageValue(key, count + value)
end

function ADD_STATS_POINT_SYSTEM:updateTalent(player, ability)
    local count = ADD_STATS_POINT_SYSTEM:getTalent(player, ability)
	if count < 1 then
	   return true
	end
	
	if ability == "Health" then
	   local subid = ADD_STATS_POINT_SYSTEM.subid[ability]
	   local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	   condition:setParameter(CONDITION_PARAM_TICKS, -1)
	   condition:setParameter(CONDITION_PARAM_SUBID, subid)
	   condition:setParameter(CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT, count)
	   player:addCondition(condition)
	   return true
	end
	
	if ability == "Mana" then
	   local subid = ADD_STATS_POINT_SYSTEM.subid[ability]
	   local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	   condition:setParameter(CONDITION_PARAM_TICKS, -1)
	   condition:setParameter(CONDITION_PARAM_SUBID, subid)
	   condition:setParameter(CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT, count)
	   player:addCondition(condition)
       return true
    end	   
end

function ADD_STATS_POINT_SYSTEM:addAbilityPoints(player, name, amount)
	
    local t = StatSystem.abilitiesTable[name]
	if not t then
	   t = StatSystem.abilitiesTable[firstToUpper(name)]
	end

	if not t then
	   return false
	end
	
	local storageex = t[2]
	local a = storageex
	

	local priceTable = ADD_STATS_POINT_SYSTEM:getPrice(player, t[1], storageex)
	if not priceTable then
	   return false
	end
	
	local price = priceTable[1]
	local gain = priceTable[2]
	local limit = priceTable[3]
	
	local points = player:getStorageValue(StatSystem.config.storages.pointsBalance)
	local pstoragex = player:getStorageValue(storagex)

	-- if price * amount > points then
		-- player:getPosition():sendMagicEffect(CONST_ME_POFF)
		-- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have enough points.")
		-- return false
	-- end
	
	
	if pstoragex + amount > limit then
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can't go pass the grade.")
		return false
	end

	
	if name == "health" or name == "Health" then
		player:setMaxHealth(player:getMaxHealth() - player:getBonusHealth() + gain * amount)
		local outfit = player:getOutfit()
		local addon = outfit.lookAddons
		if player:getCondition(CONDITION_INFIGHT) == false then
		   player:addHealth(player:getExtraHealthAddon())
		end
		player:setStorageValue(a, math.max(0, player:getStorageValue(a)) + gain * amount)
	elseif name == "mana" or name == "Mana" then
		player:setMaxMana(player:getMaxMana() - player:getBonusMana() + gain * amount)
		local outfit = player:getOutfit()
		local addon = outfit.lookAddons
		if player:getCondition(CONDITION_INFIGHT) == false then
		   player:addMana(player:getExtraManaAddon())
		end
		player:setStorageValue(StatSystem.config.storages.addedMana,
		math.max(0, player:getStorageValue(StatSystem.config.storages.addedMana)) + gain * amount)
	elseif name == "speed" or name == "Speed" then
		player:changeSpeed(gain * amount * 2)
	elseif name == "critical chance" or name == "Critical Chance" then
		player:addSpecialSkill(0, gain * amount)
	elseif name == "critical damage" or name == "Critical Damage" then
		player:addSpecialSkill(1, gain * amount)
	elseif name == "life leech chance" or name == "Life Leech Chance" then
	    player:addSpecialSkill(2, gain * amount)
	elseif name == "life leech amount" or name == "Life Leech Amount" then
	    player:addSpecialSkill(3, gain * amount)
	elseif name == "mana leech chance" or name == "Mana Leech Chance" then
	    player:addSpecialSkill(4, gain * amount)
	elseif name == "mana leech amount" or name == "Mana Leech Amount" then	
	    player:addSpecialSkill(5, gain * amount)
	end
	
	StatSystem.addPointToStat(player, name, amount*gain)
	StatSystem.addPoints(player, -price * amount)
	player:getPosition():sendMagicEffect(225)
	--player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You added " .. amount * price .. " point to chosen stat.")
	--player:sendTextMessage(MESSAGE_EVENT_ADVANCE, ADD_STATS_POINT_SYSTEM:getString(player, statsTable))
	if player:getStorageValue(ToReset) == -1 then
	    player:setStorageValue(ToReset, 0)
	end
	player:setStorageValue(ToReset, player:getStorageValue(ToReset) + amount * price)
	return true
end

-- function ADD_STATS_POINT_SYSTEM:addRewards(player, t)
    
	-- local str = "You have added "
	
	
	
	
	
	
	-- for i, v in ipairs(t) do
	    -- v.type == "stats" then
	       -- local count = v.value
		   -- local name = v.name
		   -- ADD_STATS_POINT_SYSTEM:addAbilityPoints(player, name, count)
		   -- str = str .. count .. " " .. name .. " stats"
		   -- if i < #t then
		      -- str = str .. ", "
		   -- end
    -- end
	
	-- if _cantAdd then
	   -- str = "You dont have enough points"
       -- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, str)
       -- return false
	-- end
	
	-- str = str .. "."
	-- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, str)
	-- return true
-- end


function ADD_STATS_POINT_SYSTEM:addRewards(container, t, returnStringOnly, highLight, skipChance)
    
	if not t then
	   return nil
	end
	
	local items = { }
	local itemsEx = {}
	local itemsStackable = {}
	local stats = {}
	local talents = {}
	local soul = 0

	
	local _itemsDisplayed = false
	local _statsDisplayed = false
	local _talentsDisplayed = false
	local _soulDisplayed = false
	
	local displayThings = 0
	local str = ""
	
	for index, v in pairs(t) do
		local chance = v.chance
		if not chance or skipChance then
		   chance = 100
		end
		if chance < 1 then
		   chance = chance * 100
		end
		
		
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
		     local itemEx = Game.createItem(id, count)
			 container:addItemEx(itemEx, false)
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
	    else
	       str = str .. ", "
        end
	end
		

	if #stats > 0 then
	   for index, stat in pairs(stats) do
	       local value = stat.value
		   local name = stat.name
		   if not returnStringOnly then
			  ADD_STATS_POINT_SYSTEM:addAbilityPoints(container, name, value)
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
		      ADD_STATS_POINT_SYSTEM:addTalent(container, name, value)
			  ADD_STATS_POINT_SYSTEM:updateTalent(container, name)
			  --ADD_STATS_POINT_SYSTEM:addAbilityPoints(container, name, value)
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
	      container:addSoul(soul)
	   end
	   str = str .. "+" .. soul .. " soul restored"
	    displayThings = displayThings - 1
		
	    if displayThings == 0 then
	       str = str .. "."
	    else
	       str = str .. ", "
        end
	end
	
	return container:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have got " .. str)
end	
   

local action = Action()
function action.onUse(player, item, fromPos, target, toPos, isHotkey)
    local id = item:getId()
	local t = ADD_STATS_POINT_SYSTEM:findTable(id)
	local index = ADD_STATS_POINT_SYSTEM:findIndex(id)
	if t.usages then
	   if ADD_STATS_POINT_SYSTEM:getUsages(player, index) >= t.usages then
	      player:sendCancelMessage("You can't use this item anymore.")
		  return true
	   end
	end
	
	
	local statsTable = t.rewards
	ADD_STATS_POINT_SYSTEM:addRewards(player, statsTable)
	if t.usages then
	   ADD_STATS_POINT_SYSTEM:addUsages(player, index, 1)
	end
	item:remove(1)
	---end
    return true
end

for i, v in pairs(ADD_STATS_POINT_SYSTEM.config) do
    local id = v.itemID
	if id then
       action:id(id)
	end
end
action:register()


   
