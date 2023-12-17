local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 16)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 4)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 2, 10, 5, 20)

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
