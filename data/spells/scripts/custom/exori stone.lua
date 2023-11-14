local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE) 
combat:setParameter(COMBAT_PARAM_EFFECT, 334)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 12) 

function onGetFormulaValues(player, skill, attack, factor)
	local min = (player:getLevel() * 8) + (skill * attack / 2) + 1000
	local max = (player:getLevel() * 8) + (skill * attack / 2) + 2000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onTargetTile(cid, pos)
	addEvent(function(pos)
	doSendDistanceShoot({x = pos.x - 5, y = pos.y - 5, z = pos.z}, pos, 12)
	addEvent(doSendMagicEffect, 334, pos, 334)
	addEvent(doSendMagicEffect, 334, pos, 334)
	end, math.random(150,850), pos)
end
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

combat:setArea(createCombatArea(AREA_CIRCLE3X3))
 
function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end