local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 9)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))


function onGetFormulaValues(player, level, magicLevel)
	local min = (level * 60) + (magicLevel * 50) + 4000
	local max = (level * 70) + (magicLevel * 60) + 8000
	local damage = math.floor(math.floor(min/6))
	local poison = Condition(CONDITION_POISON)
	poison:setParameter(CONDITION_PARAM_DELAYED, true)
	poison:addDamage(3, 200, -damage)
	combat:addCondition(poison)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, var)
    return combat:execute(creature, var)
end