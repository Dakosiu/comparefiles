local combat = Combat()
local time_between_hits = 0.3 --seconds

combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 37)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 4)
combat:setArea(createCombatArea(AREA_CIRCLE2X2))

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()
	
	local min = (level / 5) + (skill + 25) / 3
	local max = (level / 5) + skill + 25

	return -min, -max
end
combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")


local spell = Spell("instant")

function spell.onCastSpell(creature, var)
  combat:execute(creature, var)
  addEvent(function()  combat:execute(creature, var) end, time_between_hits * 1000)
  return true
end

spell:group("attack")
spell:id(112)
spell:name("Fire Release")
spell:words("fire release")
spell:level(800)
spell:mana(1500)
spell:isPremium(true)
spell:range(3)
spell:needCasterTargetOrDirection(true)
spell:blockWalls(true)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:needLearn(false)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()