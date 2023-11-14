local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onCastSpell(creature, variant)
	local min = (creature:getLevel() * 20) + (creature:getMagicLevel() * 20) + 1000
	local max = (creature:getLevel() * 25) + (creature:getMagicLevel() * 25) + 2000
	for _, target in ipairs(combat:getTargets(creature, variant)) do
		local master = target:getMaster()
		if target:isPlayer() or master and master:isPlayer() then
			doTargetCombat(0, target, COMBAT_HEALING, min, max)
		end
	end
	return true
end
