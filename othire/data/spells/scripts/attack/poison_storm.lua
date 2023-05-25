local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)

local area = createCombatArea(AREA_CROSS6X6)
setCombatArea(combat, area)

local condition = createConditionObject(CONDITION_POISON)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 1, 2000, -145)
addDamageCondition(condition, 1, 2000, -140)
addDamageCondition(condition, 1, 2000, -135)
addDamageCondition(condition, 1, 2000, -130)
addDamageCondition(condition, 3, 3000, -120)
addDamageCondition(condition, 2, 3000, -110)
addDamageCondition(condition, 3, 3000, -70)
addDamageCondition(condition, 3, 3000, -50)
addDamageCondition(condition, 4, 3000, -40)
addDamageCondition(condition, 6, 3000, -30)
addDamageCondition(condition, 9, 3000, -20)
addDamageCondition(condition, 12, 3000, -10)
setCombatCondition(combat, condition)

function onGetFormulaValues(cid, level, maglevel)
	min = -((level * 2) + (maglevel * 3)) * 0.9
	max = -((level * 2) + (maglevel * 3)) * 1.5
	return min, max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end