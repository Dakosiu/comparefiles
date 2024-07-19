local config = {
                 cooldown = 1 * 60 * 1000,
				 lifeCost = 250,
				 regenerate = { value = 20, interval = 2 * 1000 },
				 upgrade = { everyLevel = 10, value = 1 }
			   }

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)



local condition = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
condition:setParameter(CONDITION_PARAM_TICKS, config.cooldown)
--condition:setParameter(CONDITION_PARAM_HEALTHGAIN, config.regenerate.value)
condition:setParameter(CONDITION_PARAM_MANATICKS, config.regenerate.interval)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
condition:setParameter(CONDITION_PARAM_SUBID, 400)
--combat:addCondition(condition)

local function getUpgradeValue(player)
   local t = config.upgrade
   local level = t.everyLevel
   local value = t.value
   local playerLevel = player:getLevel()
   if playerLevel < level then
      return 0
   end
   return math.max(playerLevel / level) * value
end

local spell = Spell("instant")
function spell.onCastSpell(creature, variant)
    local lifeCost = config.lifeCost
    local player = Player(creature)
    if creature:getHealth() < lifeCost then
        if player then
	       sendCancelMessage("You dont have enough health points to use this spell.")
		   return false
	    end
        return false
    end
	
    doTargetCombatHealth(0, creature, COMBAT_LIFEDRAIN, -lifeCost, -lifeCost, CONST_ME_NONE)
	
	if player then
	   condition:setParameter(CONDITION_PARAM_HEALTHGAIN, config.regenerate.value + getUpgradeValue(player))
	end
	
    combat:addCondition(condition)
    return combat:execute(creature, variant)
end

spell:name("Motura")
spell:words("motura")
spell:group("healing")
spell:vocation("druid;true", "elder druid;true", "sorcerer;true", "master sorcerer;true")
spell:id(305)
--spell:cooldown(2 * 60 * 1000)
spell:cooldown(config.cooldown)
spell:groupCooldown(1 * 1000)
spell:level(50)
spell:mana(0)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:needLearn(false)
spell:register()