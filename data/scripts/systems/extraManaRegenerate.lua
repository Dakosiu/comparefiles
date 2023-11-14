MANA_REGENERATION_CONFIG = {
                               value = 10, --- how many mana regenerate per point
							   interval = 10000, -- in ms (1s = 1000ms )
							 }

function Player.addManaRegeneratePoint(self, value)
     
	if not self then
	   return nil
	end
	
	local points = self:getExtraManaRegeneration()
	self:setExtraManaRegeneration(points + value)
	self:updateManaRegeneration()
	return true
end

function Player.updateManaRegeneration(self)
    
	if not self then
	   return nil
	end
	
	local points = self:getExtraManaRegeneration()
	
	if points <= 0 then
	   return false
	end

	if self:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, 71) then
	   self:removeCondition(CONDITION_REGENERATION, 71)
	end
	
	local condition = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	condition:setParameter(CONDITION_PARAM_SUBID, 71)
	condition:setTicks(-1)
	local value = points * MANA_REGENERATION_CONFIG.value
	local interval = MANA_REGENERATION_CONFIG.interval
	condition:setParameter(CONDITION_PARAM_MANAGAIN, value)
    condition:setParameter(CONDITION_PARAM_MANATICKS, interval)
	
	self:addCondition(condition)
	return true
end

local creatureevent = CreatureEvent("manaRegeneration_onLogin")
function creatureevent.onLogin(player)
	player:updateManaRegeneration()
	return true
end
creatureevent:register()
	
-- local talk = TalkAction("/regtest", "!regtest")
-- function talk.onSay(player, words, param)
	-- player:addHealthRegeneratePoint(1)
	-- return false
-- end
-- talk:separator(" ")
-- talk:register()
