local interval = 30 * 1000 * 60


local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_SUBID, 666)
condition:setParameter(CONDITION_PARAM_TICKS, interval)
condition:setParameter(CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT, 115)
condition:setParameter(CONDITION_PARAM_DISABLE_DEFENSE, true)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
combat:addCondition(condition)

local spell = Spell("instant")
function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("Small Mana Buff")
spell:words("small mana buff")
spell:group("support")
spell:vocation("master sorcerer;true", "elder druid;true", "sorcerer;true", "druid;true")
spell:id(107)
--spell:cooldown(2 * 60 * 100)
spell:cooldown(300000)
spell:groupCooldown(1 * 1000)
spell:level(450)
spell:mana(1000)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:needLearn(false)
spell:register()