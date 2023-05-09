local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)

local area = createCombatArea(AREA_CIRCLE1X1)
setCombatArea(combat, area)

function onGetFormulaValues(cid, level)
    min = -60
    max = -(level * 4) * 1
    return min, max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onUseWeapon(cid, var)
    return doCombat(cid, combat, var)
end