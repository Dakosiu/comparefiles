local combat = Combat()

combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)

function onGetFormulaValues(player, level, magicLevel)
    local min = (level * 7) + (magicLevel * magicLevel) + 10
    local max = (level * 7) + (magicLevel * magicLevel) + 15
    return -min, -max
end
combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onTargetTile(cid, pos)
    doSendDistanceShoot(getThingPos(cid), pos, CONST_ANI_FIRE)
end
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onCastSpell(creature, variant) return combat:execute(creature, variant) end
