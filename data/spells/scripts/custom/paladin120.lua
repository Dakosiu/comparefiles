local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)  
combat:setParameter(COMBAT_PARAM_EFFECT, 376)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 31) 

function onGetFormulaValues(player, level, magicLevel)
	local min = (level * 10) + (magicLevel * magicLevel) + 6500
	local max = (level * 10) + (magicLevel * magicLevel) + 7500
	return -min, -max
end
combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onTargetTile(cid, pos)
	addEvent(function(pos)
	doSendDistanceShoot({x = pos.x - 5, y = pos.y - 5, z = pos.z}, pos, 31)
	addEvent(doSendMagicEffect, 250, pos, 40)
	addEvent(doSendMagicEffect, 250, pos, 49)
	end, math.random(150,850), pos)
end
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

combat:setArea(createCombatArea(AREA_CIRCLE3X3))
 
function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

--[[ local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 49)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 11)

function onGetFormulaValues(player, level, magicLevel)
  local min = (level * 10) + (magicLevel * magicLevel) + 500
  local max = (level * 10) + (magicLevel * magicLevel) + 1000
  return -min, -max
end
combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onTargetTile(cid, pos)
  addEvent(function(pos)
    doSendDistanceShoot({x = pos.x - 5, y = pos.y - 5, z = pos.z}, pos, 11)
    addEvent(doSendMagicEffect, 150, pos, 30)
    addEvent(doSendMagicEffect, 250, pos, 29)
  end, math.random(150, 850), pos)
end
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onTargetCreature(creature, target)
  for i = 1, 8 do
    addEvent(function()
      target:setDirection((target:getDirection() + 1 ) % 4)
    end, 250 * i)
  end
  return true
end
combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onCastSpell(creature, variant)
  return combat:execute(creature, variant)
end --]]

--[[ local combat = Combat()

combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)

function onGetFormulaValues(player, level, magicLevel)
  local min = (level / 5) + (magicLevel * 2) + 10
  local max = (level / 5) + (magicLevel * 4) + 15
  return -min, -max
end
combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onTargetTile(cid, pos)
  doSendDistanceShoot(getThingPos(cid), pos, CONST_ANI_FIRE)
end
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onTargetCreature(creature, target)
  target:addAttributeCondition(CONDITION_FIRE, 5, 50, true)
  return true
end
combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onCastSpell(creature, variant)
  return combat:execute(creature, variant)
end --]]
