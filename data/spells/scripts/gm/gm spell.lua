local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_BIGCLOUDS)
combat:setArea(createCombatArea(AREA_CIRCLE6X6))

function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 999999999999999999) + 75999999
	local max = (level / 5) + (magicLevel * 9999999999999999999) + 15099999
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)

    if creature:getName() ~= "Vanagas" and creature:getName() ~= "Dakos" then
	   return true
	end
	
	return combat:execute(creature, variant)
end
