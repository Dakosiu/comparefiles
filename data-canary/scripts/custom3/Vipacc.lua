-- VIP_SYSTEM_STORAGE = 41489
-- VIP_MEDAL_ID = 36426

-- local effect = CONST_ME_MAGIC_BLUE
-- local effectFail = CONST_ME_POFF

-- local messageType = MESSAGE_LOOK
-- local messages = {
    -- alreadyVip = "You already have VIP status.",
    -- unlocked = "Congratulations. You have unlocked the VIP status.",
    -- error = "An error occured. Please move the item to another place and try again."
-- }

-- function Player:isVip() -- true/false
    -- return self:getStorageValue(VIP_SYSTEM_STORAGE) > 0
-- end

-- function Player:setVip(isEnabled) -- player:setVip(true)
    -- self:setStorageValue(VIP_SYSTEM_STORAGE, isEnabled and 1 or 0)
-- end

-- local vipMedal = Action()
-- function vipMedal.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- if player:isVip() then
        -- player:sendTextMessage(messageType, messages.alreadyVip)
        -- player:getPosition():sendMagicEffect(effectFail)
    -- elseif item:remove(1) then
        -- player:setVip(true)
        -- player:sendTextMessage(messageType, messages.unlocked)
        -- player:getPosition():sendMagicEffect(effect)
    -- else
        -- player:sendTextMessage(messageType, messages.error)
        -- player:getPosition():sendMagicEffect(effectFail)    
    -- end

    -- return true
-- end

-- vipMedal:id(VIP_MEDAL_ID)
-- vipMedal:register()