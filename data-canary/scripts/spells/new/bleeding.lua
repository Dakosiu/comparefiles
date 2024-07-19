local config = {
                 rounds = 15,
				 delay = 2000,
				 baseValue = 50,
				 increase = { level = 20, value = 1 }
			   }


local function getBleedingValue(player)
   local t = config.increase
   local level = t.level
   local value = t.value
   local playerLevel = player:getLevel()
   if playerLevel < level then
      return 0
   end
   return math.floor(playerLevel / level) * value
end
   
   
   
   


local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, 1)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)
combat:setParameter(COMBATPARAM_USECHARGES, 1)

local spell = Spell("instant")
function spell.onCastSpell(creature, var)
    local condition = Condition(CONDITION_BLEEDING)
    condition:setParameter(CONDITION_PARAM_DELAYED, 10)
	local damage = config.baseValue
	local player = Player(creature)
	if player then
	   damage = damage + getBleedingValue(player)
	end
	
    condition:addDamage(config.rounds, config.delay, -damage)
    combat:addCondition(condition)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(1671)
spell:name("Bleeding")
spell:words("bleeding")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_INFLICT_WOUND)
spell:level(40)
spell:mana(30)
spell:isAggressive(true)
spell:range(7)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(30 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("knight;true", "elite knight;true")
spell:register()