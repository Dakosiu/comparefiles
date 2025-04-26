-- local creatureevent = CreatureEvent('reduceDamage_OnLogin')
-- function creatureevent.onLogin(player)
	-- player:registerEvent('generalReduceDamage')
    -- return true
-- end
-- creatureevent:register()

-- creatureevent = CreatureEvent("generalReduceDamage")
-- function creatureevent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    
	-- if not attacker then
	    -- return primaryDamage, primaryType, secondaryDamage, secondaryType
	-- end
	
	-- local monster = Monster(attacker)
	-- if not monster then
	    -- return primaryDamage, primaryType, secondaryDamage, secondaryType
	-- end
	
	-- local ratio = getConfigInfo('ReduceDamageMonsters')
	-- if not ratio then
	    -- ratio = 0.75
	-- end
	
	-- primaryDamage = (primaryDamage - (primaryDamage * ratio))
	-- secondaryDamage = (secondaryDamage - (secondaryDamage * ratio))	
    -- return primaryDamage, primaryType, secondaryDamage, secondaryType
-- end
-- creatureevent:register()