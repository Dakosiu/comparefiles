local config = {
    itemId = ITEM_AMULETOFLOSS,
    price = 50000
}

local itemType = ItemType(config.itemId)
local itemWeight = itemType:getWeight()

local talkaction = TalkAction("!buyaol", "!aol")
function talkaction.onSay(player, words, param)
	local playerCap = player:getFreeCapacity()
    if player:removeMoney(config.price) and playerCap >= itemWeight then
        player:addItem(config.itemId)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You bought an amulet of loss for " .. config.price .. " gold coins.")
    elseif playerCap < itemWeight then
        player:sendCancelMessage("You can not recieve " .. itemType:getName() .. " weighing " .. itemWeight .. " oz, it is too heavy.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
    else
        player:sendCancelMessage("You do not have enough money, an amulet of loss costs " .. config.price .. " gold coins.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
    end
	return false
end
talkaction:separator(" ")
talkaction:register()