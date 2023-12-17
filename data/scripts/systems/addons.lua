--ALTER TABLE  `players` ADD  `extraHealthAddon` INT( 11 ) NOT NULL DEFAULT  '0'
--ALTER TABLE  `players` ADD  `extraManaAddon` INT( 11 ) NOT NULL DEFAULT  '0'

ADDONS_BONUS_CONFIG = {
	increaseHealth = 1000,
	increaseMana = 1000,
	increaseProtection = 0.1,
	increaseHealing = 0.5,
	trappedEnergy = 0.1,
	mountToken = 0.1,
}

ADDONS_BONUS_STORAGE_COUNT = 1235524

local STORAGE_ADDON_BONUS = 566653
function Player.addOutfitAddon(self, lookType, addon)

	if not self or not lookType or not addon then
		return nil
	end

	self:addOutfitAddonEx(lookType, addon)

	if self:hasOutfit(lookType, 3) then
		if self:getStorageValue(STORAGE_ADDON_BONUS + lookType) >= 1 then
			return true
		end
		local hp = ADDONS_BONUS_CONFIG.increaseHealth
		local mp = ADDONS_BONUS_CONFIG.increaseMana
		self:setExtraHealthAddon(self:getExtraHealthAddon() + hp)
		self:setExtraManaAddon(self:getExtraManaAddon() + mp)
		self:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		self:setStorageValue(STORAGE_ADDON_BONUS + lookType, 1)
		local addonCounts = self:getFullAddonsCount()
		self:setStorageValue(ADDONS_BONUS_STORAGE_COUNT, addonCounts + 1)
		self:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,
			"You have received " .. hp .. " Health and " .. mp .. " Mana for complete addons for this outfit.")
		self:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Bonus Health Addon: " .. self:getExtraHealthAddon() .. ".")
		self:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Bonus Mana Addon: " .. self:getExtraManaAddon() .. ".")
		self:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Additional Protection: " .. self:getFullAddonsCount() * ADDONS_BONUS_CONFIG.increaseProtection .. ".")
		self:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Additional Healing: " .. self:getFullAddonsCount() * ADDONS_BONUS_CONFIG.increaseHealing .. ".")
		self:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Bonus will activate when u wear any outfit with full addons.")

	end

	return true
end

function Player.getFullAddonsCount(self)
	local value = self:getStorageValue(ADDONS_BONUS_STORAGE_COUNT)
	if value < 0 then
		value = 0
	end
	return value
end

function Player.updateHealthAddonBonus(self, addon)

	if not self or not addon then
		return nil
	end

	local id = 211

	if self:getCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, id) then
		self:removeCondition(CONDITION_ATTRIBUTES, id)
	end

	local value = self:getExtraHealthAddon()

	if addon < 3 then
		value = 0
	end

	local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	condition:setParameter(CONDITION_PARAM_SUBID, id)
	condition:setTicks(-1)
	condition:setParameter(CONDITION_PARAM_STAT_MAXHITPOINTS, value)
	self:addCondition(condition)
	return true
end

function Player.updateManaAddonBonus(self, addon)

	if not self or not addon then
		return nil
	end

	local id = 212

	if self:getCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, id) then
		self:removeCondition(CONDITION_ATTRIBUTES, id)
	end

	local value = self:getExtraManaAddon()

	if addon < 3 then
		value = 0
	end

	local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	condition:setParameter(CONDITION_PARAM_SUBID, id)
	condition:setTicks(-1)
	condition:setParameter(CONDITION_PARAM_STAT_MAXMANAPOINTS, value)
	self:addCondition(condition)
	self:SME(15)
	return true
end

function Player.getAddonsBonusProtection(self)
	local addon = self:getOutfit().lookAddons
	local value = self:getFullAddonsCount()
	if addon == 3 then
		value = value * ADDONS_BONUS_CONFIG.increaseProtection
		if not value or value == nil then
			value = 0
		end
		return value
	end
	return 0
end

function Player.getAddonsExtraHealing(self)
	local addon = self:getOutfit().lookAddons
	local value = self:getFullAddonsCount()
	if addon == 3 then
		value = value * ADDONS_BONUS_CONFIG.increaseHealing
		if not value or value == nil then
			value = 0
		end
		return value
	end
	return 0
end

--[[ local creatureevent = CreatureEvent("addonBonus_onHealthChange")
function creatureevent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
   
   if not attacker then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end
   
   local player = Player(creature)
   if not player then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end
   
   local addon = player:getOutfit().lookAddons
   if addon < 3 then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end
   
   local value = player:getAddonsBonusProtection()
   

   
   primaryDamage = primaryDamage - primaryDamage * value
   secondaryDamage = secondaryDamage - secondaryDamage * value
   
   
return primaryDamage, primaryType, secondaryDamage, secondaryType 
end
creatureevent:register()
--]]
creatureevent = CreatureEvent("addonBonus_onLogin")
function creatureevent.onLogin(player)
	--player:registerEvent("addonBonus_onHealthChange")
	local addon = player:getOutfit().lookAddons
	player:updateHealthAddonBonus(addon)
	player:updateManaAddonBonus(addon)
	return true
end

creatureevent:register()
