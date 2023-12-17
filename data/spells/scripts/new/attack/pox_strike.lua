local combat = Combat()
--combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 9)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 15)

function onGetFormulaValues(player, level, magicLevel)
	local min = (level * 30) + (magicLevel * 10) + 1000
	local max = (level * 40) + (magicLevel * 15) + 2000
	local damage = math.floor(math.floor(min/5))
	local poison = Condition(CONDITION_POISON)
	poison:setParameter(CONDITION_PARAM_DELAYED, true)
	poison:addDamage(5, 1000, -damage)
	combat:addCondition(poison)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
