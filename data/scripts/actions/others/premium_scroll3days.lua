local premiumScroll = Action()

function premiumScroll.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:remove(1)
	player:addPremiumDays(3)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have activated your 3 day premium time, relog to make it effective.")
	player:getPosition():sendMagicEffect(448)
	return true
end

premiumScroll:id(41535)
premiumScroll:register()
