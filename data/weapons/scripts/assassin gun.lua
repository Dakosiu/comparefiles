local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 69)
combatSmall:setParameter(COMBAT_PARAM_EFFECT, 45)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 1, 0)

function onUseWeapon(player, variant)
	if not combat:execute(player, variant) then
		return false
	end

	if math.random(1, 100) <= 90 then
		return false
	end

	player:addDamageCondition(Creature(variant:getNumber()), CONDITION_DEATH, DAMAGELIST_LOGARITHMIC_DAMAGE, 2)
	return true
end
