local config = {
                 damage = { rounds = 15, interval = 2000, value = 50 },
				 upgrade = { everyLevel = 5, value = 1 }
			   }


local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, 1)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)
combat:setParameter(COMBATPARAM_USECHARGES, 1)

local condition = Condition(CONDITION_BLEEDING)
condition:setParameter(CONDITION_PARAM_DELAYED, 10)
--condition:addDamage(15, 2000, -50)
--combat:addCondition(condition)

local function getUpgradeValue(player)
   local t = config.upgrade
   local level = t.everyLevel
   local value = t.value
   local playerLevel = player:getLevel()
   if playerLevel < level then
      return 0
   end
   return math.max(playerLevel / level) * value
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    local player = Player(creature)
	if player then
	   condition:addDamage(config.damage.rounds, config.damage.interval, -config.damage.value + getUpgradeValue(player))
	end  
	combat:addCondition(condition)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(141)
spell:name("Inflict Wound")
spell:words("utori kor")
spell:level(40)
spell:mana(30)
spell:isAggressive(true)
spell:range(1)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(30 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("knight;true", "elite knight;true")
spell:register()