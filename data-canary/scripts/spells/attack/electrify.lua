local config = {
                 damage = { rounds = 25, interval = 3000, value = 45 },
				 upgrade = { everyLevel = 5, value = 1 }
			   }


local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)

local condition = Condition(CONDITION_ENERGY)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
--condition:addDamage(25, 3000, -45)
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
spell:id(140)
spell:name("Electrify")
spell:words("utori vis")
spell:level(34)
spell:mana(30)
spell:isAggressive(true)
spell:range(3)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(30 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()