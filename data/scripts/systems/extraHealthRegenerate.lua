HEALTH_REGENERATION_CONFIG = {
                               value = 10, --- how many health regenerate per point
							   interval = 10000,--20000 -- in ms (1s = 1000ms ) == Changed to seconds
							 }

function Player.addHealthRegeneratePoint(self, value)
     
	if not self then
	   return nil
	end
	
	local points = self:getExtraHealthRegeneration()
	self:setExtraHealthRegeneration(points + value)
	self:updateHealthRegeneration()
	return true
end

function Player.updateHealthRegeneration(self)
    
	if not self then
	   return nil
	end
	
	local points = self:getExtraHealthRegeneration()
	
	if points <= 0 then
	   return false
	end

	if self:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, 70) then
	   self:removeCondition(CONDITION_REGENERATION, 70)
	end
	
	local condition = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	condition:setParameter(CONDITION_PARAM_SUBID, 70)
	condition:setTicks(-1)
	local value = points * HEALTH_REGENERATION_CONFIG.value
	local interval = HEALTH_REGENERATION_CONFIG.interval
	condition:setParameter(CONDITION_PARAM_HEALTHGAIN, value)
    condition:setParameter(CONDITION_PARAM_HEALTHTICKS, interval)
	
	self:addCondition(condition)
	return true
end

local creatureevent = CreatureEvent("healthRegeneration_onLogin")
function creatureevent.onLogin(player)
	player:updateHealthRegeneration()
	return true
end
creatureevent:register()
	
-- local talk = TalkAction("/regtest", "!regtest")
-- function talk.onSay(player, words, param)
	-- player:addHealthRegeneratePoint(1)
	-- player:addManaRegeneratePoint(1)
	-- return false
-- end
-- talk:separator(" ")
-- talk:register()
