local aol = {money = 5000, item = 2173, itemName = "Amulet of Loss", quantity = 1, exhaustStorage = 42312}

--TODO: Add exhaust so players dont spam it

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getTotalMoney() >= aol.money then
		player:removeTotalMoney(aol.money)
		player:addItem(aol.item, aol.quantity)
		player:getPosition():sendMagicEffect(54)
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "You bought " .. aol.quantity .. aol.itemName)
		player:say("I've bought an aol")
	elseif player:getTotalMoney() < aol.money then
		player:say('I need 5x platinum coins.')
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
end
