local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 44)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EARTH)

local area = createCombatArea(AREA_SQUAREWAVE5, AREADIAGONAL_SQUAREWAVE5)
setCombatArea(combat, area)

function onGetFormulaValues(cid, level, maglevel)
	min = -((level / 5) + (maglevel * 3.25) + 5)
	max = -((level / 5) + (maglevel * 6.75) + 30)
	return min, max
end

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end
