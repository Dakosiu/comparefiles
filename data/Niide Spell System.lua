if not NIIDE_SPELLS then
   NIIDE_SPELLS = {}
end


---Runes Area
--- "0" = damage with no effect
--- "1" = target square
--- "2" = damage with effect



print("Niide Spells System v.2.0 >> Loaded")



NIIDE_SPELLS.spellList = {
                            ["Goat's Hop"] = {
							                    ["spell_type"] = "instant",
							                    ["spell_action"] = "special",
							                    ["spell_words"] = "goats hop",
												["vocations"] = { "Shepherd of Aureh"},
												["cooldown"] = 10,
												["manaCost"] = 150,
												["aggressive"] = true,
												["minimum_level_to_usage"] = 1,
												["spellGroup"] = 1,
												["groupCooldown"] = 2,
												["functions"] = {
												                  ["dash"] = { maxDashes = 3, maxSquares = 3, inActiveDuration = 3 } --- 
															    },
												["buffs"] = {
												                [BUFF_ATTACKSPEED] = { value = 0.5, duration = 10000 },
																[BUFF_DAMAGE] = { value = 0.5, duration = 10000 },
															}
											 },		 
                            ["Summon Bamboo Healer"] = {
							                    ["spell_type"] = "instant",
							                    ["spell_action"] = "support",
							                    ["spell_words"] = "summon bamboo healer",
												["vocations"] = { "Jade Mystic"},
												["cooldown"] = 10,
												["manaCost"] = 150,
												["aggressive"] = false,
												["minimum_level_to_usage"] = 1,
												["spellGroup"] = 1,
												["groupCooldown"] = 2,
												["functions"] = {
												                  ["summon"] = { name = "Bamboo Healer", maxSummons = 2 } 
															    },
											 },													 
						 }

-- if not NIIDE_SPELLS.exhaust then
    -- NIIDE_SPELLS.exhaust = {}
-- end

if not NIIDE_SPELLS.events then
    NIIDE_SPELLS.events = {}
end

if not NIIDE_SPELLS.exhaust then
    NIIDE_SPELLS.exhaust = {}
end

NIIDE_SPELLS.buffs = {
                        [BUFF_ATTACKSPEED] = { subid = 100, param = CONDITION_PARAM_BUFF_ATTACKSPEED },
						[BUFF_DAMAGE] = { subid = 101, param = CONDITION_PARAM_BUFF_DAMAGE }
					 }

function NIIDE_SPELLS:getDashPosition(pos, direction, squares)
    local t = {}
	if direction == DIRECTION_NORTH then
	    t.pos = {"x","o"}
		t.value = -1
	elseif direction == DIRECTION_SOUTH then
	    t.pos = {"x","o"}
		t.value = 1
    elseif direction == DIRECTION_WEST then	    
	    t.pos = {"o","x"}
		t.value = -1
	elseif direction == DIRECTION_EAST then	 
	    t.pos = {"o","x"}
		t.value = 1	    
    end
	
	local newPos = nil
	local square = 1
	
	for i = 1, squares do
	    local currentPosition = nil
	    local x = pos.x
		local y = pos.y
		if t.pos[1] == "o" then
		    if t.value > 0 then
		       x = x + square
			else
			   x = x - square
			end
		end
		if t.pos[2] == "o" then
		    if t.value > 0 then
		        y = y + square
			else
			    y = y - square
			end
		end
		
		currentPosition = (Position(x, y, pos.z))   
		local tile = Tile(currentPosition)
        if not tile then
            break
        end	

        local creatures = tile:getCreatures()
        if creatures and #creatures	> 0 then
            if square == 1 then
				return false
			end
			return newPos
		end

		local items = tile:getItems()
        for _, item in ipairs(items) do
            if item:hasProperty(CONST_PROP_BLOCKSOLID) then
                if square == 1 then
					return false
				end
				return newPos
            end
		end
		
		square = square + 1
		newPos = currentPosition
	end
    return newPos
end
	
function NIIDE_SPELLS:setExhaust(tableName, player, method, duration)
    if not NIIDE_SPELLS.exhaust[tableName] then
       NIIDE_SPELLS.exhaust[tableName] = {}
     end

    if not NIIDE_SPELLS.exhaust[tableName][player:getGuid()] then
       NIIDE_SPELLS.exhaust[tableName][player:getGuid()] = {}
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
    NIIDE_SPELLS.exhaust[tableName][player:getGuid()] = os.mtime() + interval
end

function NIIDE_SPELLS:getExhaust(tableName, player)
    
  if not NIIDE_SPELLS.exhaust[tableName] then
     return false
  end
  
  if not NIIDE_SPELLS.exhaust[tableName][player:getGuid()] then
     return false
  end
  
  if NIIDE_SPELLS.exhaust[tableName][player:getGuid()] >= os.mtime()  then
     return true
  end
  
  return false
end

function NIIDE_SPELLS:getExhaustString(tableName, player)    
	if not NIIDE_SPELLS.exhaust[tableName] then
       return "not set"
    end
  
	local duration = NIIDE_SPELLS.exhaust[tableName][player:getGuid()]
	if not duration then
	   return "not set"
	end
	
	if duration < os.mtime()  then
	   return "not set"
	end

	
	local time_string = ""
	local time_left = ""
	
	time_left = duration - os.mtime() 
	
	local h = string.format("%02.f", math.floor(time_left / (60*60*1000)))
    time_left = string.format("%02.f", math.floor(time_left - h*(60*60*1000)))
    local m = string.format("%02.f", math.floor(time_left / (60*1000)))
    time_left = string.format("%02.f", math.floor(time_left - m*(60*1000)))
    local s = string.format("%02.f", math.floor(time_left / 1000))
    time_left = string.format("%02.f", math.floor(time_left - s*1000))
    
	
	
	
	h = tonumber(h)
	m = tonumber(m)
	s = tonumber(s)
	
	local str = ""
	
	if h > 0 then
	    str = str .. h .. " hours"
	end
		
	if m > 0 then
	    if h > 0 then
		    str = str .. ", "
	    end
	    str = str .. m .. " minutes"
	end
	
	if s > 0 then
	    if m > 0 or h > 0 then
		    str = str .. ", "
		end
	    str = str .. s .. " seconds"
	end
	
	if h == 0 and m == 0 and s == 0 then
	    return false
	end
    
	return str:lower()
end

function NIIDE_SPELLS:getSpellTable(spell_name) --- getting table of spell
    return self.spellList[spell_name]
end
	
function NIIDE_SPELLS:getType(spell_name) --- getting type of spell
    local t = self.spellList[spell_name]
	if not t then
	    return false
	end
	return t["spell_type"]
end

function NIIDE_SPELLS:getCooldown(spell_name)
    local t = self.spellList[spell_name]
	if not t then
	    return false
	end
    return t["cooldown"]
end

function NIIDE_SPELLS:getFunctionList(spell_name) --- getting function of spell
    local t = self:getSpellTable(spell_name)
	if not t then
	    return false
	end
	local functionList = t["functions"]
	if not functionList then
	    return false
	end
	return functionList
end

function NIIDE_SPELLS:getBuffList(spell_name)
    local t = self:getSpellTable(spell_name)
	if not t then
	    return false
	end
	local buffList = t["buffs"]
	if not buffList then
	    return false
	end	
	return buffList
end
	
function NIIDE_SPELLS:createCondition(creature, buffList)
    for i, v in pairs(buffList) do
	    local buffName = i
		local value = v.value
		if value > 0 and value < 1 then
		    value = value * 100
		end		
		local duration = v.duration		
		local buffsTable = NIIDE_SPELLS.buffs[buffName]
		local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
		condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
		condition:setParameter(CONDITION_PARAM_SUBID, buffsTable.subid)
		condition:setParameter(buffsTable.param, value)
		condition:setParameter(CONDITION_PARAM_TICKS, duration)
		creature:addCondition(condition)
	end
end

function NIIDE_SPELLS:removeCondition(creature, buffList)
    for i, v in pairs(buffList) do
	    local buffName = i
		local buffsTable = NIIDE_SPELLS.buffs[buffName]
		creature:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, buffsTable.subid)
	end
end
	

function NIIDE_SPELLS:returnMessage(player, type, message)
    return player:sendTextMessage(type, message)
end

function NIIDE_SPELLS:stopEvent(player_id, spell_name)
	if not self.events then
	    return
	end
	
	if not self.events[spell_name] then
	    return
	end
	
	if not self.events[spell_name][player_id] then
	   return
	end
	
	local event = self.events[spell_name][player_id].event
	if not event then
	    return
	end
	stopEvent(event)
end
	
function NIIDE_SPELLS:Dash(player, maxDashes, inActiveDuration, spell_name, maxSquares)
    
	if not player then
	    return false
	end
	
	if not NIIDE_SPELLS.events[spell_name] then
	    NIIDE_SPELLS.events[spell_name] = {}
	end
	
	local buffList = NIIDE_SPELLS:getBuffList(spell_name)
	
	if self:getExhaust(spell_name, player) and self:getExhaustString(spell_name, player) then
		if NIIDE_SPELLS.events[spell_name][player:getId()] then
		    NIIDE_SPELLS.events[spell_name][player:getId()] = nil
		end
		NIIDE_SPELLS:stopEvent(player:getId(), spell_name)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Spell is on cooldown, it will last:  " .. self:getExhaustString(spell_name, player) .. ".")
		return false
	end
	
	if not NIIDE_SPELLS.events[spell_name][player:getId()] then
	    NIIDE_SPELLS.events[spell_name][player:getId()] = {}
		NIIDE_SPELLS.events[spell_name][player:getId()].usedDashes = 0
		NIIDE_SPELLS.events[spell_name][player:getId()].lastDashBetween = 0
	end
	
	-- if NIIDE_SPELLS.events[spell_name][player:getId()].lastDashBetween and NIIDE_SPELLS.events[spell_name][player:getId()].lastDashBetween > os.mtime() then
	    -- player:sendTextMessage(MESSAGE_INFO_DESCR, "You have to wait " .. delayBetweenDash .. " seconds to dash again.")
		-- return true
	-- end
	
	local cooldown = NIIDE_SPELLS:getCooldown(spell_name)
	local direction = player:getDirection()
	local pos = player:getPosition()
	local dashPos = NIIDE_SPELLS:getDashPosition(pos, direction, maxSquares)
	if dashPos then
	    addEvent(function() player:teleportTo(dashPos,true,250) end,10)
	end
	
	NIIDE_SPELLS.events[spell_name][player:getId()].usedDashes = NIIDE_SPELLS.events[spell_name][player:getId()].usedDashes + 1
	if NIIDE_SPELLS.events[spell_name][player:getId()].usedDashes >= maxDashes then
	    self:setExhaust(spell_name, player, "second", cooldown)
		NIIDE_SPELLS:stopEvent(player:getId(), spell_name)
		NIIDE_SPELLS.events[spell_name][player:getId()] = nil
		return false
	end
	
	NIIDE_SPELLS:stopEvent(player:getId(), spell_name)
	NIIDE_SPELLS.events[spell_name][player:getId()].lastDashTime = os.mtime()
	--NIIDE_SPELLS.events[spell_name][player:getId()].lastDashBetween = os.mtime() + (delayBetweenDash * 1000)
		
	NIIDE_SPELLS.events[spell_name][player:getId()].event = addEvent(function(player_id)
	local player = Player(player_id)
	if not player then
	    return false
	end
	
	if NIIDE_SPELLS.events[spell_name][player_id].lastDashTime < os.mtime() then
	    player:sendTextMessage(MESSAGE_INFO_DESCR, "You were inactive, spell is on coldown.")
		NIIDE_SPELLS.events[spell_name][player:getId()] = nil
		self:setExhaust(spell_name, player, "second", cooldown)
		-- if buffList then
		    -- NIIDE_SPELLS:removeCondition(player, buffList)
		-- end
	end
	
	end, inActiveDuration * 1000, player:getId())
	
	return true
end
	
function NIIDE_SPELLS:getVocationsString(spell_name)
    local t = self:getSpellTable(spell_name)
	if not t then 
        return ""
	end
	
	local vocationsTable = t["vocations"]
	if not vocationsTable then
	    return ""
	end
	
	local vocationString = ""
	for index, vocName in pairs(vocationsTable) do
	    vocationString = vocationString .. vocName .. ";" .. "true"
		if index < #vocationsTable then
		    vocationString = vocationString .. ", "
		end
	end
	return vocationString
end

function NIIDE_SPELLS:castSpell(creature, spell_name)
	local functionList = NIIDE_SPELLS:getFunctionList(spell_name)
	local buffList = NIIDE_SPELLS:getBuffList(spell_name)
	local isDash = false
	if functionList then
	    for functionName, functionTable in pairs(functionList) do
		    if functionName == "dash" then
			    local maxDashes = functionTable["maxDashes"]
				local delayBetweenDash = functionTable["delayBetweenDash"]
				local inActiveDuration = functionTable["inActiveDuration"]
				local maxSquares = functionTable["maxSquares"]
			    if not self:Dash(creature, maxDashes, inActiveDuration, spell_name, maxSquares) then
				    return false
				end
			end
			if functionName == "summon" then
			    local summonName = functionTable.name
			    local maxSummons = functionTable.maxSummons
				
				if creature:getSummons() and #creature:getSummons() >= maxSummons then
				    return false
				end
				
				local summon = Game.createMonster(summonName, creature:getPosition(), true)
				if not summon then
				    return false
				end
				
				creature:addSummon(summon)
			end
		end
	end
	
	if buffList then
	    NIIDE_SPELLS:createCondition(creature, buffList)
	end
	    
	return true
end

-- function NIIDE_SPELLS:createArea(area)
    -- if not area then
	    -- return false
	-- end
	
    -- return area
-- end

-- function onGetFormulaValues(player, level, maglevel)
	-- local min = (level / 5) + (maglevel * 1.2) + 7
	-- local max = (level / 5) + (maglevel * 2.8) + 17
	-- return -min, -max
-- end

-- function NIIDE_SPELLS:createCombat(area, effect, distance_effect)

-- end
	
-- local combat = Combat()
-- combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
-- combat:setParameter(COMBAT_PARAM_EFFECT, effect)
-- combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, distance_effect)
-- --combat:setArea((area))
-- combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")	

-- function NIIDE_SPELLS:castRune(creature, var, spellName)
	-- local spellTable = self:getSpellTable(spellName)
	-- local area = spellTable["area"]
	-- if area then
	    -- self:createArea(area)
	-- end
	-- local effect = spellTable["effect"]
	-- local distance_effect = spellTable["distance_effect"]
	
	-- combat:setArea(AREA_CIRCLE3X3)
	
	-- --local combat = self:createCombat(area, effect, distance_effect)
	


	
	
	-- print("It works")
	-- return combat:execute(creature, var)
-- end



