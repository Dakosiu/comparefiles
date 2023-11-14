local premiumScroll = Action()

function premiumScroll.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:remove(1)
	player:addPremiumDays(1)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have activated your 1 day premium time, relog to make it effective.")
	player:getPosition():sendMagicEffect(17)
	return true
end

premiumScroll:id(41534)
premiumScroll:register()
