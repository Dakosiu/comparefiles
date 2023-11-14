local combat = Combat()
local time_between_hits = 0.3 --seconds
 
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 54)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLICE)
combat:setArea(createCombatArea(AREA_SQUARE1X1))
 
function onGetFormulaValues(player, level, maglevel)
    local min = (level / 5) + (maglevel * 2.5) + 30
    local max = (level / 5) + (maglevel * 2.5) + 30
    return -min, -max
end
combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(creature, var)
   combat:execute(creature, var)
  addEvent(function()  combat:execute(creature, var) end, time_between_hits * 1000)
  return true
end