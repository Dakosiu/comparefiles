local stones = Action()
function stones.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local positionHash = toPosition.x .. toPosition.y .. toPosition.z

    if player:getStorageValue(positionHash) < 1 then
        local itemType = ItemType(9642)
        player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have found a ' .. itemType:getName() .. '.')
        player:addItem(9642, 1)
        player:setStorageValue(positionHash, 1)

        return true
    end

    return false
end

stones:aid(3456)
stones:register()