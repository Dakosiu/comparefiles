local config = {
    ["premium"] = true,
    ["price"] = 20000,
    ["level"] = 20
}

local TA_promotion = TalkAction("!promotion")

function TA_promotion.onSay(player)

    -- Check if player need premium
    if not player:isPremium() and config.premium then
        player:sendCancelMessage("Sorry, you need to have a premium account.")
        return false
    end

    -- Check if player is already promoted
    local vocation = player:getVocation()
    local promotion = vocation:getPromotion()
    if vocation == promotion or player:getStorageValue(3000) == 1 then
        player:sendCancelMessage("You are already promoted!")
        player:setStorageValue(3000, 1)
        return false
    end

    -- Check if player is high enough level
    if player:getLevel() < config.level then
        player:sendCancelMessage("You can only be promoted once you have reached level " .. config.level .. ".")
        return false
    end

    -- Check if player can afford promotion
    if not player:removeMoney(config.price) then
        player:sendCancelMessage("You do not have enough money!")
        return false
    end

    player:setVocation(promotion)
    player:setStorageValue(3000, 1)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You are now promoted.")
    player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Congratulations! You are now promoted.")
    player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)

    return true
end

TA_promotion:register()