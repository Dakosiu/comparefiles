local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local skill = Condition(CONDITION_ATTRIBUTES)
skill:setParameter(CONDITION_PARAM_TICKS, 10000)
skill:setParameter(CONDITION_PARAM_SKILL_DISTANCEPERCENT, 150)
skill:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
combat:addCondition(skill)


function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
