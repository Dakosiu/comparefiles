local premiumScroll = Action()

function premiumScroll.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:remove(1)
	player:addPremiumDays(14)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have activated your 14 day premium time, relog to make it effective.")
	player:getPosition():sendMagicEffect(379)
	return true
end

premiumScroll:id(41537)
premiumScroll:register()
