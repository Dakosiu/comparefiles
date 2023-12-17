local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)

AREA_NECRO_WAVE = {
{1, 1, 1, 1, 1},
{0, 1, 1, 1, 0},
{0, 0, 1, 0, 0},
{0, 0, 1, 0, 0},
{0, 0, 3, 0, 0},
{0, 1, 0, 1, 0}
 }

combat:setArea(createCombatArea(AREA_NECRO_WAVE))
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DEATH)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)

function onGetFormulaValues(player, level, magicLevel)
	local min = (level * 10) + (magicLevel * magicLevel) + 4600
	local max = (level * 10) + (magicLevel * magicLevel) + 4900
	return -min, -max
end
function onTargetTile(creature, position)
    if creature then
        creature:getPosition():sendDistanceEffect(position, CONST_ANI_DEATH)
    end
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end