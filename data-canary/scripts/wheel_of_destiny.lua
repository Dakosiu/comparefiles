local wheelOfDestiny = CreatureEvent("wheelOfDestiny")
function wheelOfDestiny.onLogin(player)
	player:updateWheelOfDestinyBuffs(player:getWheelOfDestiny())
	return true
end
wheelOfDestiny:register()

local wheelOfDestinyGiftOfLife = CreatureEvent("wheelOfDestinyGiftOfLife")
function wheelOfDestinyGiftOfLife.onHealthChange(player, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if primaryType == COMBAT_HEALING or secondaryType == COMBAT_HEALING then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	if math.abs(primaryDamage + secondaryDamage) >= player:getHealth() then
		if not player:getCondition(4096, CONDITIONID_COMBAT, WheelOfDestiny.Revelation.Gift_Of_Life.SUBID) then
			local level = player:getWheelOfDestinyRevelationLevel(WheelOfDestiny.Revelation.Gift_Of_Life.SIDE)
			if level then
				local data = WheelOfDestiny.Revelation.Gift_Of_Life[level]
				if math.abs(primaryDamage + secondaryDamage) < (player:getHealth() + (player:getMaxHealth() * data.overkill)) then
					local condition = Condition(4096)
					condition:setParameter(CONDITION_PARAM_PERSISTENT_ON_DEATH, true)
					condition:setParameter(CONDITION_PARAM_TICKS, data.cooldown)
					condition:setParameter(CONDITION_PARAM_SUBID, WheelOfDestiny.Revelation.Gift_Of_Life.SUBID)
					player:addCondition(condition)
					doTargetCombatHealth(player, player, COMBAT_HEALING, player:getMaxHealth() * data.healing, player:getMaxHealth() * data.healing, CONST_ME_HOLYAREA, ORIGIN_SPELL, false)
					player:sendTextMessage(MESSAGE_INFO_DESCR, WheelOfDestiny.Revelation.Gift_Of_Life.MESSAGE)
					return primaryDamage, primaryType, secondaryDamage, secondaryType
				end	
			end
		end
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
	
end
wheelOfDestinyGiftOfLife:register()
