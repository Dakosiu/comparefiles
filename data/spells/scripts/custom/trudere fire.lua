local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 36)
combat:setArea(createCombatArea(AREA_WAVE7, AREADIAGONAL_BEAM7))

function onGetFormulaValues(player, level, maglevel)
	return -8, -11
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
