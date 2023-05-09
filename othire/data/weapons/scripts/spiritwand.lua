local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DEATH)

local area = createCombatArea(AREA_CIRCLE5X1)
setCombatArea(combat, area)

function onGetFormulaValues(cid, level)
    min = 20
    max = -(level * 3) * 1
    return min, max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onUseWeapon(cid, var)
    return doCombat(cid, combat, var)
end