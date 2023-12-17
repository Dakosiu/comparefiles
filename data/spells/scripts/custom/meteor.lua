local condition = Condition(CONDITION_FIRE)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(4, 1, 500)


local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 475)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))
combat:addCondition(condition)


function onGetFormulaValues(player, level, magicLevel)
	local min = (level * 8) + (magicLevel * magicLevel) + 2500
	local max = (level * 15) + (magicLevel * magicLevel) + 6500
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end