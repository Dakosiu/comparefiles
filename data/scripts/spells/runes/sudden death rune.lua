local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)
combat:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)

function onGetFormulaValues(player, level, magicLevel)
	local min = (level * 25) + (magicLevel * magicLevel) + 1
	local max = (level * 35) + (magicLevel * magicLevel) + 1000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell(SPELL_RUNE)

function spell.onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end

spell:name("sudden death rune")
spell:runeId(2263)
spell:group("attack")
spell:id(24)
spell:level(8)
spell:magicLevel(15)
spell:needTarget(true)
spell:isAggressive(true)
spell:allowFarUse(true)
spell:charges(1)
spell:register()
 