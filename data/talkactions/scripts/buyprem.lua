local config = {
	days = 1,
	maxDays = 3650,
	price = 100000
}

function onSay(player, words, param)
	if configManager.getBoolean(configKeys.FREE_PREMIUM) then
		return true
	end

	if player:getPremiumDays() <= config.maxDays then
		if player:removeMoney(config.price) then
			player:addPremiumDays(config.days)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have bought " .. config.days .." days of premium account.")
		else
			player:sendCancelMessage("You don't have enough money, " .. config.days .. " days premium account costs " .. config.price .. " gold coins.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		end
	else
		player:sendCancelMessage("You can not buy more than " .. config.maxDays .. " days of premium account.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	return false
end