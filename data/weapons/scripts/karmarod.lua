local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 236)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 32)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 6, 25, 11, 70)

local area = createCombatArea({
{1, 0, 0, 0, 1},
{0, 1, 0, 1, 0},
{0, 0, 3, 0, 0},
{0, 1, 0, 1, 0},
{1, 0, 0, 0, 1}
})

setCombatArea(combat, area)

function onUseWeapon(cid, var)

return doCombat(cid, combat, var)
end
