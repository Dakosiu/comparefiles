local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 226)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 89)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 4, 25, 9, 70)

local area = createCombatArea({
{0, 1, 0},
{1, 3, 1},
{0, 1, 0}
})

setCombatArea(combat, area)

function onUseWeapon(cid, var)

return doCombat(cid, combat, var)
end
