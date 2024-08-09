local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 49)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 1)


function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 1.4) + 8
	local max = (level / 5) + (magicLevel * 2.2) + 14
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

-- function onCastSpell(creature, variant)
-- 	return combat:execute(creature, variant)
-- end

function onCastSpell(creature, variant)
	local position = creature:getPosition()
	-- addEvent(function()
	-- 	local effect = Position(position:getX(), position:getY(), position:getZ())
	-- 	effect:sendMagicEffect(49)
	-- end, 100)
	return combat:execute(creature, variant)
end

