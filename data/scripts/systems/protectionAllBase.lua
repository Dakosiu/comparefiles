local protec = CreatureEvent("protectionAllBase_onHealthChange")
function protec.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if primaryType == COMBAT_HEALING then
       return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
	
	local player = Player(creature)
	if not player then
	    return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	
	local ability = ABILITY_SYSTEM:getProtectionAll(player)
    if ability > 0 then
	    ability = ability / 100
	    primaryDamage = primaryDamage - (primaryDamage * ability)
		secondaryDamage = secondaryDamage - (secondaryDamage * ability)
	end
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
protec:register()

--MANA
protec = CreatureEvent("protectionAllBase_onManaChange")
function protec.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if primaryType == COMBAT_MANADRAIN and primaryDamage > 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
   
	local player = Player(creature)
	if not player then
	    return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	
	local ability = ABILITY_SYSTEM:getProtectionAll(player)
    if ability > 0 then
	    ability = ability / 100
	    primaryDamage = primaryDamage - (primaryDamage * ability)
		secondaryDamage = secondaryDamage - (secondaryDamage * ability)
	end
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end

protec:register()

protec = CreatureEvent("protectionAllBase_onLogin")
function protec.onLogin(player)
    player:registerEvent("protectionAllBase_onManaChange")
    player:registerEvent("protectionAllBase_onHealthChange")
	return true
end
protec:register()