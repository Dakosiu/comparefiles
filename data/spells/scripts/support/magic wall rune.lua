local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setParameter(COMBAT_PARAM_CREATEITEM, 38525)

function onCastSpell(creature, var, isHotkey)
	return combat:execute(creature, var)
end
