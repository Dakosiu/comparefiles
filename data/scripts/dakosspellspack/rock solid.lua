local config = {
                 subid = 179,
				 value = 10,
				 interval = 120
			   }


local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)


local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)	
condition:setParameter(CONDITION_PARAM_BUFF_DECREASEDAMAGE, config.value)
condition:setParameter(CONDITION_PARAM_SUBID, config.subid)
condition:setParameter(CONDITION_PARAM_TICKS, config.value * 1000 * 60)

combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
    	
	local player = Player(creature)
	if player then
	   local party = player:getParty()
	   if party then
	      for _, member in pairs(party:getMembers()) do
		     member:addCondition(condition)
			 member:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
			 member:sendTextMessage(MESSAGE_EVENT_DEFAULT, "You are buffed by " .. player:getName() .. "." .. ", reduction damage by " .. config.value .. "%.")
		  end
		  local leader = party:getLeader()
		  if leader:getId() == player:getId() then
		     return combat:execute(creature, variant)
		  else
		     leader:addCondition(condition)
			 leader:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)	
			 leader:sendTextMessage(MESSAGE_EVENT_DEFAULT, "You are buffed by " .. player:getName() .. "." .. ", reduction damage by " .. config.value .. "%.")
          end			 
	   else
	     return combat:execute(creature, variant)
	   end
	end
	
end

spell:name("Rock Solid")
spell:words("rock solid")
spell:group("healing")
spell:vocation("elite knight;true")
spell:id(3)
spell:cooldown(2 * 60 * 1000)
spell:groupCooldown(1 * 1000)
spell:level(80)
spell:mana(75)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:needLearn(false)
spell:register()