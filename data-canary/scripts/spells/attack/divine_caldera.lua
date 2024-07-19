local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 6)
	local max = (level / 5) + (maglevel * 8)
	return -min * 1.8, -max * 1.8 -- TODO : Use New Real Formula instead of an %
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(124)
spell:name("Divine Caldera")
spell:words("exevo mas san")
spell:level(50)
spell:mana(160)
spell:isPremium(true)
spell:isSelfTarget(true)
spell:cooldown(2.8 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()