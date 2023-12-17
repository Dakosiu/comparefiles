local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 202)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 11)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 2, 9, 5, 18)

local area = createCombatArea({
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 1, 0, 0, 0},
{0, 0, 1, 3, 1, 0, 0},
{0, 0, 0, 1, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0}
})

setCombatArea(combat, area)

function onUseWeapon(cid, var)

return doCombat(cid, combat, var)
end
