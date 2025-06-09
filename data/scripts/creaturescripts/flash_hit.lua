local shaderName = "Outfit - Flash"
local creatures = {}

local creatureevent = CreatureEvent("SendFlashOnHit_onHealthChange")
function creatureevent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    
	local player = Player(attacker)
	if not player then
	   return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	
	
	local c_id = creature:getId()
	local p_id = player:getId()
	player:sendFlashOnHit(creature, shaderName)
    
	local event = creatures[c_id]
	if event then
	   stopEvent(event)
	end
	   
	creatures[c_id] = addEvent(function(c_id, p_id)
	   local c = Creature(p_id)
	   local p = Player(p_id)
	   if c and p then
	      local target = p:getTarget()
		  if target:getId() == c_id then
		     --print("here?")
		     p:sendFlashOnHit(creature, "Outfit - Attack")
		  else
		     --print("here? 2")
	         p:sendFlashOnHit(creature, "Outfit - Default")
	      end
	   end
	end, 1000, c_id, p_id)
	
	
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
creatureevent:register()

local creatureevent = CreatureEvent("SendFlashOnHit_onLogin")
function creatureevent.onLogin(player)
    player:registerEvent("SendFlashOnHit_onHealthChange")
	return true
end