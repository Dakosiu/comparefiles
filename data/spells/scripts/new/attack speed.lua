local combat = Combat()

combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)


local config = { 
                 exhaust = { enabled = true, duration = 5, storage = 3543672 },
                 ["Knight"] = { enabled = true, increaseSpeed = 1000, duration = 5, effect = CONST_ME_MAGIC_RED }, -- increaseSpeed in miliseconds, duration in seconds.
				 ["Paladin"] = { enabled = true, increaseSpeed = 1000, duration = 5, effect = CONST_ME_MAGIC_GREEN },
				 ["Mage"] = { enabled = true, increaseSpeed = 1500, duration = 5, effect = CONST_ME_MAGIC_BLUE },
			   }
			   

local function getTable(player)

    local t = nil
	
    if player == nil then
	return false
	end
	
	if player:isKnight() then
	t = "Knight"
	elseif player:isPaladin() then
	t = "Paladin"
	elseif player:isSorcerer() or player:isDruid() then
	t = "Mage"
	end
	
	return t
end
	

function onCastSpell(creature, variant)

    local player = Player(creature)
	local t = nil
	
	if player == nil then
	return true
	end
	
	if getTable(player) then
	t = getTable(player)
	end
	
	if t == nil then
	player:sendCancelMessage("Your vocation can't use this buff.")
	return false
	end
	
	local v = config[t]
	
    if not v.effect or not v.duration or not v.increaseSpeed or not v.enabled then
	player:sendCancelMessage("Your vocation can't use this buff.")
	return false
	end
	
	if player:getExhaustion(config.exhaust.storage) > 0 then
	player:sendCancelMessage("Attack Speed boost is already active.")
	return false
	end

	combat:setParameter(COMBAT_PARAM_EFFECT, v.effect)
    player:setAttackSpeed(v.increaseSpeed)
	player:sendCancelMessage("You have increased your attack speed by " .. v.increaseSpeed / 1000 .. " seconds.")
	
	if config.exhaust.enabled then
    player:setExhaustion(config.exhaust.storage, config.exhaust.duration)
	end
	
    addEvent(function()
    player:setAttackSpeed(0)
    end, v.duration * 1000)
		
    
	return combat:execute(creature, variant)
end
