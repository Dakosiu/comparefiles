local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 18)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 31)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 4, 30, 14, 70)

local area = createCombatArea({
{0, 0, 0, 0, 0, 0, 0},
{0, 1, 0, 0, 0, 1, 0},
{0, 0, 1, 1, 1, 0, 0},
{0, 0, 1, 3, 1, 0, 1},
{0, 0, 1, 1, 1, 0, 0},
{0, 1, 0, 0, 0, 1, 0},
{0, 0, 0, 0, 0, 0, 0}
})

setCombatArea(combat, area)

function onUseWeapon(cid, var)

return doCombat(cid, combat, var)
end
