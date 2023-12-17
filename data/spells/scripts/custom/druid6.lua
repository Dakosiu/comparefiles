local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)  
combat:setParameter(COMBAT_PARAM_EFFECT, 343)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 29) 
function onGetFormulaValues(player, level, maglevel)
local min = (level * 8) + (maglevel * maglevel) + 9000
local max = (level * 9) + (maglevel * maglevel) + 9000
return -min, -max
end
combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onTargetTile(cid, pos)
	addEvent(function(pos)
	doSendDistanceShoot({x = pos.x - 5, y = pos.y - 5, z = pos.z}, pos, 72)
	addEvent(doSendMagicEffect, 250, pos, 302)
	addEvent(doSendMagicEffect, 250, pos, 373)
	end, math.random(150,650), pos)
end
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

combat:setArea(createCombatArea(AREA_CIRCLE3X3))
 
function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end