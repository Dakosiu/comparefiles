local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_USECHARGES, true)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

function onGetFormulaValues(player, skill, attack, factor)
	local min = (player:getLevel() * 4) + (skill * 10 + attack) + 200
	local max = (player:getLevel() * 8) + (skill * 12 + attack) + 2000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant) return combat:execute(creature, variant) end