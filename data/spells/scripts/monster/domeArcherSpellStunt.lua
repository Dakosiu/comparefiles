local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
-- combat:setParameter(COMBAT_PARAM_EFFECT, 9)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 1)

function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 1.4) + 8
	local max = (level / 5) + (magicLevel * 2.2) + 14
	
	-- local min = (creature:getLevel() / 80) + (creature:getMagicLevel() * 0.55) + 6
	-- local max = (creature:getLevel() / 80) + (creature:getMagicLevel() * 0.75) + 7
	local damage = math.random(math.floor(min) * 1000, math.floor(max) * 1000) / 1000
	for _, target in ipairs(combat:getTargets(creature, variant)) do
		creature:addDamageCondition(target, 6, DAMAGELIST_LOGARITHMIC_DAMAGE, target:isPlayer() and damage / 2 or damage)
	end

	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end