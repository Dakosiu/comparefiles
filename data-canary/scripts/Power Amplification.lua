if not PowerAmplification then
    PowerAmplification = {}
end

PowerAmplification.config = {
                                [1] = {
								        name = "Physical",
										value = 0.1,
										duration = { type = "hours", value = 1 },
									  },
								[2] = {
								        name = "Energy",
										value = 0.1,
                                        duration = { type = "hours", value = 1 },
									  },									  
								[3] = {
								        name = "Earth",
										value = 0.1,
                                        duration = { type = "hours", value = 1 },
									  },
								[4] = {
								        name = "Fire",
										value = 0.1,
                                        duration = { type = "hours", value = 1 },
									  },			
								[5] = {
								        name = "Ice",
										value = 0.1,
                                        duration = { type = "hours", value = 1 },
									  },	
								[6] = {
								        name = "Death",
										value = 0.1,
                                        duration = { type = "hours", value = 1 },
									  },									  
							}
							
PowerAmplification.ItemID = 34362
PowerAmplification.SubID = 900
PowerAmplification.ModalWindowID = 500

PowerAmplification.Params = {
                              ["Physical"] = { CONDITION_PARAM_BUFF_PHYSICAL_DAMAGE, COMBAT_PHYSICALDAMAGE },
							  ["Energy"] = { CONDITION_PARAM_BUFF_ENERGY_DAMAGE, COMBAT_ENERGYDAMAGE },
							  ["Eearth"] = { CONDITION_PARAM_BUFF_EARTH_DAMAGE, COMBAT_EARTHDAMAGE },
							  ["Fire"] = { CONDITION_PARAM_BUFF_FIRE_DAMAGE, COMBAT_FIREDAMAGE },
							  ["Ice"] = { CONDITION_PARAM_BUFF_ICE_DAMAGE, COMBAT_ICEDAMAGE },
							  ["Death"] = { CONDITION_PARAM_BUFF_DEATH_DAMAGE, COMBAT_DEATHDAMAGE },
							}

function PowerAmplification:getTableByName(name)
    for i, v in ipairs(self.config) do
        if v.name:lower() == name:lower() then
            return v		
		end			
    end
end

function PowerAmplification:getIndexByName(name)
    for i, v in ipairs(self.config) do
        if v.name:lower() == name:lower() then
            return i		
		end			
    end
	return false
end

function PowerAmplification:getTableByIndex(index)
    return self.config[index]
end

function PowerAmplification:addBonus(player, name)
    
	local t = self:getTableByName(name)
	if not t then
	    return nil
	end
	
	local index = self:getIndexByName(name)
	if not index then
	    return nil
	end
	
	if self:getBuff(player, index) then
	    return false
	end
	
	local durationTable = t.duration
	
	local method = durationTable.type
	local duration = durationTable.value
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
	
	local value = t.value
	if not value then
	    return nil
	end
	if value < 1 then
	    value = value * 100
	end
	
	local index = PowerAmplification:getIndexByName(name)
	local subid = self.SubID + index
	local condition = Condition(CONDITION_ATTRIBUTES)
	condition:setParameter(CONDITION_PARAM_SUBID, subid)
	local param = PowerAmplification:getParamByName(name)
	condition:setParameter(param, value)
	condition:setParameter(CONDITION_PARAM_TICKS, interval)
	player:addCondition(condition)
	return true
end

function PowerAmplification:getParamByName(name)
    local t = self.Params[name]
	if not t then
	    return false
	end
	
	return t[1]
end

function PowerAmplification:getCombatByName(name)
    local t = self.Params[name]
	if not t then
	    return false
	end
	
	return t[2]
end

function PowerAmplification:getBuff(player, index)
    local condition = player:getCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, self.SubID + index)
	if condition then
	    return condition
	end
	return false
end

function PowerAmplification:getEndConditionString(condition)
   
  local time_left = (condition:getEndTime() / 1000) - os.time()
  local days = math.floor(time_left/86400)
  local remaining = time_left % 86400
  local hours = math.floor(remaining/3600)
  remaining = remaining % 3600
  local minutes = math.floor(remaining/60)
  remaining = remaining % 60
  local seconds = remaining
  
  str = ""
  
  local isStarted = false
  
  if days > 0 then
     str = str .. days .. " days"
	 isStarted = true
  end
  
  if hours > 0 then
     if isStarted then
	    str = str .. ", "
	 end
	 str = str .. hours .. " hours"
	 isStarted = true
  end

  if minutes > 0 then
     if isStarted then
	    str = str .. ", "
	 end
	 str = str .. minutes .. " minutes"
	 isStarted = true
  end
  
  if seconds > 0 then
     if days == 0 and hours == 0 and minutes == 0 then
	    str = seconds .. " seconds"
     -- elseif minutes > 0 then
	    -- str = str .. " and " .. seconds .. " seconds"
	 end
  end
  
   str = str .. "."
   return str
end
	
function PowerAmplification:getActiveBonusesString(player)
    local first = true
	local message = "You have no active any power amplification yet."
	message = message .. "\n"
	for i, v in ipairs(self.config) do
	    local buff = self:getBuff(player, i)
	    if buff then
		    local timeleft = self:getEndConditionString(buff)
		    if first then
			    message = "Active Power Amplification's:"
				message = message .. "\n"
				message = message .. "-----------------------------"
				first = false
			end
			message = message .. "\n"
			message = message .. v.name .. " Damage: " .. v.value * 100 .. "%"
            message = message .. "\n"
            message = message .. "Timeleft: " .. timeleft
			message = message .. "\n"
			message = message .. "-----------------------------"
		end
	end
	return message
end
		
function PowerAmplification:sendModalWindow(player)
    
	local title = "Power Amplifications"
    local message = self:getActiveBonusesString(player)
	message = message .. "\n"
	message = message .. "\n"
	message = message .. "Select Amplification:"
	 
	local window = ModalWindow(self.ModalWindowID, title, message)
	for i, v in ipairs(self.config) do
	    window:addChoice(i, "" .. v.name .. " Damage" .. " +" .. v.value * 100 .. "%" .. "")
	end
	 
	 
    window:addButton(100, "Select") 
    window:addButton(101, "Cancel")     
    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)
	player:registerEvent('PowerAmplification_onModalWindow')
	return window:sendToPlayer(player)
end	
	 
	
	
	
local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)	
    if not dakosLib:canUse(player, item) then
	    player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendCancelMessage("You can't use this item from ground.")
		return true
	end
	PowerAmplification:sendModalWindow(player)
    return true
end
action:id(PowerAmplification.ItemID)
action:register()


local creaturescript = CreatureEvent("PowerAmplification_onModalWindow")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId) 
		if not modalWindowId == PowerAmplification.ModalWindowID then
		    return false
		end
		player:unregisterEvent("PowerAmplification_onModalWindow")
        
	    if buttonId == 101 then
		   return false
	    end
				
		local index = choiceId
		local t = PowerAmplification:getTableByIndex(index)
		if not t then
		    return false
		end
		local name = t.name
		if PowerAmplification:addBonus(player, name) == false then
		    player:popupFYI("You have already " .. name:lower() .. " power amplification.")
			return false
		end
		
		if not player:removeItem(PowerAmplification.ItemID, 1) then
		    player:popupFYI("You dont have power amplificaton item.")
			return false
		end
		
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		local interval = dakosLib:getInterval(t.duration)
		local message = "You have earned " .. t.value * 100 .. "%" .. " " .. name:lower() .. " power amplification."
		message = message .. "\n"
		message = message .. "It will last " .. dakosLib:getTimeString(interval)
		player:sendTextMessage(MESSAGE_INFO_DESCR, message)
	return true
end
creaturescript:register()