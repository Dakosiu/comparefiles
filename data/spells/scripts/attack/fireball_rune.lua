local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setArea(AREA_SQUARE1X1)

function onGetFormulaValues(player, level, magicLevel)
	local min = ((level / 5) + (magicLevel * 1.8) + 12)*0.7
	local max = ((level / 5) + (magicLevel * 3) + 17)*0.7
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant, isHotkey)
	local position = variant:getPosition()
    position.x = position.x + 1
    position.y = position.y + 1
	position:sendMagicEffect(35)
	return combat:execute(creature, variant)
end
