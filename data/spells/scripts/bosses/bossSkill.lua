local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combat:setArea(createCombatArea(AREA_CIRCLE5X5))

local combatShow = Combat()
combatShow:setParameter(COMBAT_PARAM_EFFECT, 57)
combatShow:setArea(createCombatArea(AREA_CIRCLE5X5))

function onGetFormulaValues(player, level, magicLevel)
	local min = (level * 5) + (magicLevel * magicLevel) + 500
	local max = (level * 20) + (magicLevel * magicLevel) + 1900
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	combatShow:execute(creature,variant)
	addEvent(function ()
		return combat:execute(creature, variant)
	end, 1000)
end