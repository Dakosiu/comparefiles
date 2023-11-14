local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local speed = Condition(CONDITION_HASTE)
speed:setParameter(CONDITION_PARAM_TICKS, 1000000000)
--speed:setFormula(0.8, -64, 0.8, -64)
speed:setFormula(1.75, 1.75, 1.75, 1.75)
combat:addCondition(speed)

local cooldownAttackGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
cooldownAttackGroup:setParameter(CONDITION_PARAM_SUBID, 1)
cooldownAttackGroup:setParameter(CONDITION_PARAM_TICKS, 0)
combat:addCondition(cooldownAttackGroup)

local pacified = Condition(CONDITION_PACIFIED)
pacified:setParameter(CONDITION_PARAM_TICKS, 0)
combat:addCondition(pacified)

function onCastSpell(creature, variant)
   local player = Player(creature)
   if player:getStorageValue(33300) < 1 then
      player:sendCancelMessage("You need to unlock this spell first.")
      return false
   else
      return combat:execute(creature, variant)
   end
end
