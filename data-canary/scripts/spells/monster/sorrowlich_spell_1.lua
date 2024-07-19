local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, CONST_ME_STONES)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_BIGCLOUDS)

local condition = Condition(CONDITION_ENERGY)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(math.random(100, 200), 3000, -45)
combat:setArea(createCombatArea(AREA_CIRCLE5X5))
combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    return combat:execute(creature, var)
end

spell:name("sorrowlich spell 1")
spell:words("###1001")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()