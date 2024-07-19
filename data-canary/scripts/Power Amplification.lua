if not PowerAmplification then
    PowerAmplification = {}
end

PowerAmplification.config = {
                                [1] = {
								        name = "Physical",
										value = 0.1,
										duration = { type = "hours", value = 1 },
										attribute = COMBAT_PHYSICALDAMAGE,
									  },
								[2] = {
								        name = "Ice",
										value = 0.1,
                                        duration = { type = "hours", value = 1 },
										attribute = COMBAT_ICEDAMAGE,
									  }
							}
							
PowerAmplification.storage = 1837297
PowerAmplification.storage2 = 1637297
PowerAmplification.ItemID = 34362


function PowerAmplification:getTableByName(name)
    for i, v in ipairs(self.config) do
        if v:name():lower() == name:lower() then
            return v		
		end			
    end
end

function PowerAmplification:getTableByIndex(index)
    return self.config[index]
end

function PowerAmplification:addBonus(player, name)
    
	local t = self:getTableByName(name)
	if not t then
	    return true
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
	   interval = duration * 60
    elseif string.find(method, "hour") then 
	   interval = duration * 60 * 60
    end 
	
	local attribute = t.attribute
	if not attribute then
	    return false
	end
	
	local value = t.value
	if not value then
	    return false
	end
	if value < 1 then
	    value = value * 100
	end
	
	player:setStorageValue(self.storage + attribute, interval + os.time())
	player:setStorageValue(self.storage2 + value)
end

function PowerAmplification:isBonusActive(player, attribute)
    if player:getStorageValue(self.storage + attribute) > os.time() then
        return true
    end
  
    return false
end

function PowerAmplification:getExhaustString(player, attribute)
  local time_left = player:getStorageValue(self.storage + attribute) - os.time()
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
     elseif minutes > 0 then
	    str = str .. " and " .. seconds .. " seconds"
	 end
  end
  
   str = str .. "."
   return str
end

function PowerAmplification:getTimeLeft(player, index)
    local t = self:getTableByIndex(index)
	
	
end

function PowerAmplification:getIncreaseValue(player, attribute)
	if not self:isBonusActive(player, attribute) then
	    return 0
	end
	return player:getStorageValue(self.storage2 + attribute)
end

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
	player:sendTextMessage(MESSAGE_INFO_DESCR, "Test")
	

    return true
end

stones:id(PowerAmplification.ItemID)
stones:register()



