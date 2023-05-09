local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_POFF)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_LARGEROCK)

local area = createCombatArea(AREA_CIRCLE2X2)
setCombatArea(combat, area)

function onGetFormulaValues(cid, level)
    min = 0
    max = -(level * 4) * 1
    return min, max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onUseWeapon(cid, var)
    return doCombat(cid, combat, var)
end