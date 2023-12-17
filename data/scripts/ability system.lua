if not ABILITY_SYSTEM then
    ABILITY_SYSTEM = {}
end

function ABILITY_SYSTEM:getDodge(player)
    local value = 0
    local ability = player:getAbility(ABILITIES_DODGE)
	if ability > 0 then
	   value = value + ability
	end
	
	local stats = player:dodgeStatsBonus()
	if stats > 0 then
	   value = value + stats
	end
	return value
end

function ABILITY_SYSTEM:getReflect(player)
    local value = 0
    local ability = player:getAbility(ABILITIES_REFLECT)
	if ability > 0 then
	   value = value + ability
	end
	
	local stats = player:reflectStatsBonus()
	if stats > 0 then
	   value = value + stats
	end
	return value
end

function ABILITY_SYSTEM:getProtectionAll(player)
    local value = 0
    local ability = player:getAbility(ABILITIES_PROTECTIONALL)
	if ability > 0 then
	   value = value + ability
	end
	
	local stats = player:protectionAllStatsBonus()
	if stats > 0 then
	   value = value + stats
	end
	
	local addons = player:getAddonsBonusProtection()
	if addons > 0 then
	    value = value + addons
	end	
	return value
end

function ABILITY_SYSTEM:getSummonDamage(player)
    local value = 0
    local ability = player:getAbility(ABILITIES_SUMMONDAMAGE)
	if ability > 0 then
	   value = value + ability
	end
	
	local stats = math.max(0, player:getStorageValue(StatSystem.config.storages.attackPoints))
	if stats > 0 then
	   value = value + stats
	end
	return value
end

function ABILITY_SYSTEM:getExperience(player)
    local value = 0
    local ability = player:getAbility(ABILITIES_GAINEXPERIENCE)
	if ability > 0 then
	   value = value + ability
	end
	
	local stats = player:statsExpBonus()
	if stats > 0 then
	   value = value + stats
	end
	
	local grate = _G.rate
	if grate > 0 then
	    value = value + grate
	end
	
	return value
end
	
function ABILITY_SYSTEM:getHealing(player)
    local value = 0
    local ability = player:getAbility(ABILITIES_HEALING)
	if ability > 0 then
	   value = value + ability
	end
	
	local stats = player:healingBoostStatsBonus()
	if stats > 0 then
	   value = value + stats
	end
	
	return value  
end

function ABILITY_SYSTEM:getTrappedEnergy(player)
    local value = 0
    local ability = player:getAbility(ABILITIES_TRAPPEDENERGY)
    if ability > 0 then
	    value = value + ability
	end
	
	local stats = player:trappedEnergyAllStatsBonus()
	if stats > 0 then
	    value = value + stats
	end
	return value
end

function ABILITY_SYSTEM:getBonusDamage(player)
    local value = 0
    local ability = player:getAbility(ABILITIES_DAMAGE)
    if ability > 0 then
	    value = value + ability
	end
	
	local stats = math.max(0, player:getStorageValue(StatSystem.config.storages.attackPoints))
	if stats > 0 then
	    value = value + stats
	end
	return value
end

function ABILITY_SYSTEM:getSpellCooldown(player)
    local value = 0
    local ability = player:getAbility(ABILITIES_SPELLCOOLDOWN)
    if ability > 0 then
	    value = value + ability
	end
	
	return value
end