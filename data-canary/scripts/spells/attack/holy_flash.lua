local config = {
                 damage = { rounds = { min = 7, max = 11 }, interval = 3000, value = 20 },
				 upgrade = { everyLevel = 5, value = 1 }
			   }



local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)
local condition = Condition(CONDITION_DAZZLED)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
	
--condition:addDamage(math.random(7,11), 3000, -20)
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
	   condition:addDamage(math.random(config.damage.rounds.min, config.damage.rounds.max), config.damage.interval, -config.damage.value + getUpgradeValue(player))
	end  
	combat:addCondition(condition)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(143)
spell:name("Holy Flash")
spell:words("utori san")
spell:level(70)
spell:mana(30)
spell:isAggressive(true)
spell:range(3)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(5 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()