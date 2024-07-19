ADDON_BONUS_SYSTEM_CONFIG = {
                              increaseHealth = 0.0025,
							  increaseMana = 0.0025,
							  retroOutfits = { 963, 962, 965, 964, 967, 966, 969, 968, 971, 970, 973, 972, 975, 974 }
							}







ADDON_BONUS_SYSTEM_CONFIG.storages = {
                                       getAddon = 9750000,
									   getAddonsCount = 1766544
									 }
ADDON_BONUS_SYSTEM = {}

function ADDON_BONUS_SYSTEM:isRetro(looktype)
    
	for i, v in pairs(ADDON_BONUS_SYSTEM_CONFIG.retroOutfits) do
	    if v == looktype then
		   return true
		end
	end
	return false
end

function ADDON_BONUS_SYSTEM:isCollected(player, looktype)
    
	if not player or not looktype then
	   return nil
	end
	
	if player:getStorageValue(ADDON_BONUS_SYSTEM_CONFIG.storages.getAddon + looktype) >= 2 then
	   return true
	end
	return false
end

function ADDON_BONUS_SYSTEM:getAddonValue(player, looktype)
    
	local value = player:getStorageValue(ADDON_BONUS_SYSTEM_CONFIG.storages.getAddon + looktype)
	if not value or value < 1 then
	   value = 0
	end
	return value
end

function ADDON_BONUS_SYSTEM:setAddonValue(player, looktype, value)
	return player:setStorageValue(ADDON_BONUS_SYSTEM_CONFIG.storages.getAddon + looktype, value)
end

function ADDON_BONUS_SYSTEM:getFullAddonCount(player)

    local value = player:getStorageValue(ADDON_BONUS_SYSTEM_CONFIG.storages.getAddonsCount)
	if value < 0 then
	   value = 0
	end
	return value
end

function ADDON_BONUS_SYSTEM:addFullAddonCount(player)
    
	local value = ADDON_BONUS_SYSTEM:getFullAddonCount(player)
	player:setStorageValue(ADDON_BONUS_SYSTEM_CONFIG.storages.getAddonsCount, value + 1)

end

function ADDON_BONUS_SYSTEM:updateStats(player)
    
	local subid = 932
	
	
	local hp_value = ADDON_BONUS_SYSTEM:getFullAddonCount(player) * ADDON_BONUS_SYSTEM_CONFIG.increaseHealth
    if hp_value > 0 and hp_value < 1 then
	   hp_value = hp_value * 100
	end
	
	local mp_value = ADDON_BONUS_SYSTEM:getFullAddonCount(player) * ADDON_BONUS_SYSTEM_CONFIG.increaseMana
	if mp_value > 0 and mp_value < 1 then
	   mp_value = mp_value * 100
	end
	
	
	local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
    condition:setParameter(CONDITION_PARAM_TICKS, -1)
    condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
    condition:setParameter(CONDITION_PARAM_SUBID, subid)
	
	condition:setParameter(CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT, 100 + hp_value)
	condition:setParameter(CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT, 100 + mp_value)
	
	if player:getCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, subid) then
	   player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, subid)
    end
	
	if ADDON_BONUS_SYSTEM:getFullAddonCount(player) <= 0 then
	   return true
	end
	player:addCondition(condition) 
end
    
	
	

function Player.addOutfitAddon(self, looktype, id, _skipBonus)
    
	if not self or not id or not looktype then
       return nil
    end
	
	if self:hasOutfit(looktype, id) then
	   return false
	end
	
	if ADDON_BONUS_SYSTEM:isCollected(self, looktype) then
	   return false
	end
	
	self:addOutfitAddonEx(looktype, id)
	
	if id == 0 then
	   if not ADDON_BONUS_SYSTEM:isRetro(looktype) then
	      return true
	   end
	end
	
	if _skipBonus then
	   return true
	end
	
	local value = ADDON_BONUS_SYSTEM:getAddonValue(self, looktype)
	
	if id > 0 then
	   if id == 3 then
	      ADDON_BONUS_SYSTEM:setAddonValue(self, looktype, 3)
	   else
	      ADDON_BONUS_SYSTEM:setAddonValue(self, looktype, value + 1)
	   end
	end
	
	if ADDON_BONUS_SYSTEM:isCollected(self, looktype) or ADDON_BONUS_SYSTEM:isRetro(looktype) then
	   ADDON_BONUS_SYSTEM:addFullAddonCount(self)
	   self:sendTextMessage(MESSAGE_INFO_DESCR, "Congratulations!, You have collected full addons for this outfit, You have " .. ADDON_BONUS_SYSTEM:getFullAddonCount(self) .. " collected full addon's." .. "\n" .. "Health Increased by: " .. ADDON_BONUS_SYSTEM:getFullAddonCount(self) * ADDON_BONUS_SYSTEM_CONFIG.increaseHealth * 100 .. "%" .. "\n" .. "Mana Increased by: " .. ADDON_BONUS_SYSTEM:getFullAddonCount(self) * ADDON_BONUS_SYSTEM_CONFIG.increaseMana * 100 .. "%")
	   ADDON_BONUS_SYSTEM:updateStats(self)
	end
	

	return true
end

local creatureevent = CreatureEvent("onLogin_BonusSystem")

function creatureevent.onLogin(player)
    ADDON_BONUS_SYSTEM:updateStats(player)
	return true
end
creatureevent:register()


local talkaction = TalkAction("!addonbonus")
function talkaction.onSay(player, words, param)
	
	if ADDON_BONUS_SYSTEM:getFullAddonCount(player) == 0 then
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "You haven't collected any full addon yet.")
	   return false
	end
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have " .. ADDON_BONUS_SYSTEM:getFullAddonCount(player) .. " collected full addon's." .. "\n" .. "Health Increased by: " .. ADDON_BONUS_SYSTEM:getFullAddonCount(player) * ADDON_BONUS_SYSTEM_CONFIG.increaseHealth * 100 .. "%" .. "\n" .. "Mana Increased by: " .. ADDON_BONUS_SYSTEM:getFullAddonCount(player) * ADDON_BONUS_SYSTEM_CONFIG.increaseMana * 100 .. "%")
	return false
end
talkaction:separator(" ")
talkaction:register()