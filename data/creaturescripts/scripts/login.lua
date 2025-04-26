local subid = 66

local function sendEffect(player_id, effect)
	local player = Player(player_id)
	if not player then
	    return false
	end
	if not player:getCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, subid) then
	    return false
	end
	
	local pos = player:getPosition()
	pos:sendMagicEffect(effect)
	
    addEvent(sendEffect, 1000, player_id, effect)
end

local function addBuff(player, value, interval)
    local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	condition:setParameter(CONDITION_PARAM_BUFF_DEFENSE, value)
	condition:setParameter(CONDITION_PARAM_SUBID, subid)
	condition:setTicks(interval)
	player:addCondition(condition)
	local player_id = player:getId()
	sendEffect(player_id, 55)
end


function onLogin(player)
	local loginStr = "Welcome to " .. configManager.getString(configKeys.SERVER_NAME) .. "!"
	if player:getLastLoginSaved() <= 0 then
		--loginStr = loginStr .. " Please choose your outfit."
		--player:sendOutfitWindow()
	else
		if loginStr ~= "" then
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
		end

		loginStr = string.format("Your last visit was on %s.", os.date("%a %b %d %X %Y", player:getLastLoginSaved()))
	end
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)

	-- Stamina
	nextUseStaminaTime[player.uid] = 0

	-- Promotion
	local vocation = player:getVocation()
	local promotion = vocation:getPromotion()
	if player:isPremium() then
		local value = player:getStorageValue(PlayerStorageKeys.promotion)
		if value == 1 then
			player:setVocation(promotion)
		end
	elseif not promotion then
		player:setVocation(vocation:getDemotion())
	end

	-- Events
	player:registerEvent("PlayerDeath")
	player:registerEvent("DropLoot")
	player:registerEvent("hotkeysOpcode")
	
	
	

    -- addBuff(player, 80, -1)
	-- print("Defense: " .. player:getBuff(BUFF_DEFENSE))


	
	return true
end
