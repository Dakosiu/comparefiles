local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYPOISON)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISON)

local conditionParalize = Condition(CONDITION_PARALYZE)
conditionParalize:setParameter(CONDITION_PARAM_TICKS, 30000)
conditionParalize:setFormula(-0.3, 0, -0.45, 0)
combat:addCondition(conditionParalize)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    return combat:execute(creature, var)
end

spell:name("paralyze")
spell:words("###999")
spell:isAggressive(true)
spell:needTarget(true)
spell:needLearn(true)
spell:isSelfTarget("1")
spell:register()