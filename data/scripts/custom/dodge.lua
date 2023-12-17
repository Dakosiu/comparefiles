local creatureevent = CreatureEvent("system_Dodge_Health")
function creatureevent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)

    if primaryType == COMBAT_HEALING then
       return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
   
    local player = Player(creature)
    if not player then
       	return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	
	local ability = ABILITY_SYSTEM:getDodge(player)
	if ability > 0 then
	    local rnd = math.random(1, 100)
        if rnd <= ability then
		    primaryDamage = 0
			secondaryDamage = 0
			player:getPosition():sendMagicEffect(382)
		end
	end
	
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end


creatureevent:register()

creatureevent = CreatureEvent("system_Dodge_Mana")
function creatureevent.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)

   if primaryType == COMBAT_MANADRAIN and primaryDamage > 0 then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end
   
    local player = Player(creature)
    if not player then
       	return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	
	local ability = ABILITY_SYSTEM:getDodge(player)
	if ability > 0 then
	    local rnd = math.random(1, 100)
        if rnd <= ability then
		    primaryDamage = 0
			secondaryDamage = 0
			player:getPosition():sendMagicEffect(382)
		end
	end
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
creatureevent:register()

creatureevent = CreatureEvent("system_Dodge_Login")
function creatureevent.onLogin(player)
   player:registerEvent("system_Dodge_Health")
   player:registerEvent("system_Dodge_Mana")
   return true
end

creatureevent:register()