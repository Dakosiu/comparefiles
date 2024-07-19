function Item:getUpgradeLevel()
    return self:getCustomAttribute("item_upgrade_level") or 0
end

function Item:setUpgradeLevel(value)
    return self:setCustomAttribute("item_upgrade_level", value)
end

function Item:getUpgradeDescription()
    return self:getCustomAttribute("item_upgrade_description") or "empty"
end

function Item:setUpgradeDescription(text)
     return self:setCustomAttribute("item_upgrade_description", text)
end

function Item:getUpgradeType(upgradeType)
    local separator = "`"
    local value = self:getCustomAttribute(upgradeType) or ""
    value = value:split(separator)

    return value
end

function Item:addUpgradeType(key,value)

        local upgradeType = ""
		
		if key == "attack" then
           upgradeType = "attack"
		elseif key == "defense" then
           upgradeType = "defense"
		elseif key == "armor" then
	   upgradeType = "armor"
		   else
		   return false
		end
		
        local list = self:getUpgradeType(upgradeType)		
	local separator = ";"
		
        local newList = key .. separator .. value
        if not value:verifyStatIntegrity() then
            error("Incorrect stat syntax")
        end
        table.insert(list, newList)
        
        local newList = compileUpgradeTable(list)
		self:setCustomAttribute(upgradeType, newList)
		   
    return true
end


function Item:getBonuses()
    local slots = self:getCustomAttribute(CUSTOM_ATTRIBUTE_BONUSES) or ""
    slots = slots:split("`")

    return slots
end

function Item:addBonus(key,value,index)

        local stats = self:getBonuses()
        local newStat = key .. ";" .. value
		
		local attr = nil
		
		local formated = key .. " " .. value
		
        if not value:verifyStatIntegrity() then
            error("Incorrect stat syntax")
        end
        table.insert(stats, newStat)
        
        local newStats = compileItemBonuses(stats)
        self:setCustomAttribute(CUSTOM_ATTRIBUTE_BONUSES, newStats)
		
		if index == 1 then
		   attr = "bonuses1"
		elseif index == 2 then
		   attr = "bonuses2"
		elseif index == 3 then
		   attr = "bonuses3"
		end
		
		if not attr then
		   return true
		end
		
		
		self:setCustomAttribute(attr, formated)
		
		
        return true
    
end

function Item:removeBonus(index)
    local stats = self:getBonuses()
    local attr = "empty"
	
	if index == 1 then
		   attr = "bonuses1"
	elseif index == 2 then
		   attr = "bonuses2"
	elseif index == 3 then
		   attr = "bonuses3"
	end
	
	self:removeCustomAttribute(attr)
	
	
	
    if index > 0 and index <= #stats then
        table.remove(stats, index)
        local newStats = compileItemBonuses(stats)
        self:setCustomAttribute(CUSTOM_ATTRIBUTE_BONUSES, newStats)
        return true
    end
	
	
    
    return false
end

function Item:displayBonuses()
    if self:getCustomAttribute(CUSTOM_ATTRIBUTE_BONUSES) then
        local stats = self:getBonuses()
        local out = ""
        
        for _, v in pairs(stats) do
            v = v:split(";")
            if v[2] then
                out = out .. string.format("%s %s", v[1], v[2])
            end
        end
				
        return out
    end
    
    return ""
end