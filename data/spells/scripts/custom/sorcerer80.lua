local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)  
combat:setParameter(COMBAT_PARAM_EFFECT, 282)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 69) 
function onGetFormulaValues(player, level, magicLevel)
	local min = (level * 4) + (magicLevel * magicLevel * 2) + 5
	local max = (level * 20) + (magicLevel * magicLevel * 4) + 9
	return -min, -max
end
combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onTargetTile(cid, pos)
	addEvent(function(pos)
	doSendDistanceShoot({x = pos.x - 5, y = pos.y - 5, z = pos.z}, pos, 68)
	addEvent(doSendMagicEffect, 250, pos, 281)
	addEvent(doSendMagicEffect, 250, pos, 289)
	end, math.random(150,850), pos)
end
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

combat:setArea(createCombatArea(AREA_CIRCLE2X2))
 
function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end