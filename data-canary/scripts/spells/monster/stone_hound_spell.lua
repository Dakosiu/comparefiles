local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_STONES)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EARTH)
combat:setArea(createCombatArea(AREA_CIRCLE6X6))

local condition = Condition(CONDITION_POISON)
condition:setParameter(CONDITION_PARAM_DELAYED, true)
condition:addDamage(1, 0, math.random(-50, -200))
condition:addDamage(4, 4000, -25) -- 4x co 4 sekundy, obrazenia: -25
condition:addDamage(9, 4000, -15) -- 9x co 4 sekundy, obrazenia: -15
condition:addDamage(20, 4000, -5) -- 20x co 4 sekundy, obrazenia: -5
combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    return combat:execute(creature, var)
end

spell:name("stone hound spell")
spell:words("###996")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()