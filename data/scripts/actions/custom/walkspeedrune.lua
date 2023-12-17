local speedrunegrade1tAction = Action()

function speedrunegrade1tAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local config = {
        level = 50,      
        storage = 42007,  -- Storage to control wait time
        efeitoBoost = 221, -- Boost effect (haste)
        efeitoPoff = 10 -- poff poff effect
    }

    if player:getLevel() < config.level then
        return player:sendCancelMessage("You do not have enough level to use this.")
    end
   
    if player:getStorageValue(config.storage) > os.time() then
        local minutes = math.ceil((player:getStorageValue(config.storage) - os.time()) / 60)
        local s = (minutes == 1 and "" or "s")
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Boost is active, maybe wait ".. minutes .." minute".. s ..".")
        player:getPosition():sendMagicEffect(config.efeitoPoff)
        return true
    end
   
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You received a haste effect.")
    player:getPosition():sendMagicEffect(config.efeitoBoost)
   
    local condition = Condition(CONDITION_HASTE)
    condition:setParameter(CONDITION_PARAM_SPEED, 100) -- Increases speed by 100
    condition:setParameter(CONDITION_PARAM_TICKS, 90000) -- 90 seconds
    player:addCondition(condition)
   
    player:setStorageValue(config.storage, os.time() + 90) -- Storage time is in seconds
    item:remove(1)
   
    return true
end

speedrunegrade1tAction:id(41250) -- The ID of the item that grants the boost
speedrunegrade1tAction:register()