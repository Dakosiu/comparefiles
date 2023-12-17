local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 36)
combat:setArea(createCombatArea(AREA_WAVE7, AREADIAGONAL_BEAM7))

function onGetFormulaValues(cid, level, maglevel)
	min = -((level / 5) + (maglevel * 1.2) + 7)
	max = -((level / 5) + (maglevel * 2) + 12)
	return min, max
end


ombat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
