local interval = 2 * 1000 * 60


local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_SUBID, 6667)
condition:setParameter(CONDITION_PARAM_TICKS, interval)
condition:setParameter(CONDITION_PARAM_BUFF_INCREASEDAMAGE, 50)
condition:setParameter(CONDITION_PARAM_DISABLE_DEFENSE, true)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
combat:addCondition(condition)

condition = Condition(CONDITION_MANASHIELD)
condition:setParameter(CONDITION_PARAM_TICKS, interval)
combat:addCondition(condition4)

local spell = Spell("instant")
function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("Strong Mana Shield")
spell:words("strong utamo vita")
spell:group("healing")
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:id(7)
--spell:cooldown(2 * 60 * 100)
spell:cooldown(30000)
spell:groupCooldown(1 * 1000)
spell:level(80)
spell:mana(0)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:needLearn(false)
spell:register()