local cooldown = 15

local talk = TalkAction("!effects", "/effects")

function talk.onSay(player, words, param)
    if player:getStorageValue(storage) <= os.time() then
        player:setStorageValue(storage, os.time() + cooldown)
        if player:getStorageValue(48091) <= 0 then
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You have de-activated effects.")
            player:setStorageValue(48091, 1)
        else
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You have activated effects.")
            player:setStorageValue(48091, -1)    
        end
    else
        player:sendCancelMessage("Can only be executed once every " .. cooldown .. " seconds. Remaining cooldown: " .. player:getStorageValue(storage) - os.time())
    end
    return false
end

talk:register()