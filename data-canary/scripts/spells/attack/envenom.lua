local config = {
                 damage = { rounds = 25, interval = 3000, value = 45 },
				 upgrade = { everyLevel = 5, value = 1 }
			   }

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLPLANTS)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EARTH)

local condition = Condition(CONDITION_POISON)
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
spell:id(142)
spell:name("Envenom")
spell:words("utori pox")
spell:level(50)
spell:mana(30)
spell:range(3)
spell:isAggressive(true)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(5 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("druid;true", "elder druid;true")
spell:register()