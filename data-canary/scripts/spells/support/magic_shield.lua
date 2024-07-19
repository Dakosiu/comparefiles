local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)

local spell = Spell("instant")
local legacyMode = getConfigInfo("LegacyManaShield")

function spell.onCastSpell(creature, var)

	if legacyMode then
	   local condition = Condition(CONDITION_MANASHIELD)
       condition:setParameter(CONDITION_PARAM_TICKS, 200000)
       combat:addCondition(condition)
	   return combat:execute(creature, var)
	end

	local condition = Condition(CONDITION_MANASHIELD)
	condition:setParameter(CONDITION_PARAM_TICKS, 200000)
	local player = creature:getPlayer()
	if player then
		condition:setParameter(CONDITION_PARAM_MANASHIELD, math.min(player:getMaxMana(), 300 + 7.6 * player:getLevel() + 7 * player:getMagicLevel()))
	end
	creature:addCondition(condition)
	return combat:execute(creature, var)
end

spell:name("Magic Shield")
spell:words("utamo vita")
spell:group("support")
spell:vocation("druid;true", "elder druid;true", "sorcerer;true", "master sorcerer;true")
spell:id(44)
if legacyMode then
   spell:cooldown(2 * 1000)
else
   spell:cooldown(14 * 1000)
end
spell:groupCooldown(2 * 1000)
spell:level(14)
spell:mana(50)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:needLearn(false)
spell:register()
