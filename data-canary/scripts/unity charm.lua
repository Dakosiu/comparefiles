local creatureevent = CreatureEvent("UnityCharmLogin")
function creatureevent.onLogin(player)
	player:registerEvent("UnityCharmEvent")
    return true
end
creatureevent:register()

creatureevent = CreatureEvent("UnityCharmEvent")
function creatureevent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    	
    local player = Player(creature) 
	
	
    if not player then
	   return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	
	
	if not player:hasUnityCharm() then
	   return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	
	if primaryType == COMBAT_HEALING then
	   return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	
	primaryDamage = primaryDamage + (primaryDamage * 0.05)
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end
creatureevent:register()