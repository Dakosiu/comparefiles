local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 222)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 74)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 5, 30, 11, 70)

local area = createCombatArea({
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
{0, 1, 0, 0, 0, 1, 0},
{1, 0, 1, 3, 1, 0, 1},
{0, 1, 0, 0, 0, 1, 0},
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0}
})

setCombatArea(combat, area)

function onUseWeapon(cid, var)

return doCombat(cid, combat, var)
end
