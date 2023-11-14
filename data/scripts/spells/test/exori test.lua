local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEATTACK)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLICE)

function onGetFormulaValues(player, level, maglevel)

	return -100, -100
end


combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    
	if not player:getGroup():getAccess() and player:getAccountType() < ACCOUNT_TYPE_GOD  then
		return true
	end
    
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(2)
spell:name("Ice Test")
spell:words("exori test")
spell:level(1)
spell:mana(0)
--spell:isPremium(true)
spell:range(6)
spell:needCasterTargetOrDirection(true)
spell:blockWalls(true)
spell:cooldown(100)
spell:groupCooldown(100)
spell:needLearn(false)
spell:vocation("druid;true", "sorcerer;true", "elder druid;true", "master sorcerer;true", "merlin sorcerer;true", "ancient druid;true")
spell:register()