local extraHealing = CreatureEvent("extraHealing_onHealthChange")
function extraHealing.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
   
    local player = Player(creature)
    if not player then
       return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
   
    if not primaryType == COMBAT_HEALING then
       return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    if not secondaryType == COMBAT_HEALING then
       return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local ability = ABILITY_SYSTEM:getHealing(player)
	if ability > 0 then
	    ability = ability / 100
		primaryDamage = primaryDamage + (primaryDamage * ability)
		secondaryDamage = secondaryDamage + (secondaryDamage * ability)
	end   
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
extraHealing:register()

extraHealing = CreatureEvent("extraHealing_onLogin")
function extraHealing.onLogin(player)
    player:registerEvent("extraHealing_onHealthChange")
	return true
end
extraHealing:register()