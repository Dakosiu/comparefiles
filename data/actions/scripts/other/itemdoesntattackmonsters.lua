-- invisibilityItem.lua
local invisibilityItemId = 41263 -- replace with the actual Item ID
local invisibilityTime = 15000 -- 15 seconds in milliseconds
local invisibilityStorage = Storage.InvisibilityStorage -- replace with an unused storage value


local invisibilityEffect = CONST_ME_MAGIC_RED -- replace with the desired effect
local lastEffect = CONST_ME_MAGIC_BLUE -- replace with the desired last effect


function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(invisibilityStorage) > 0 then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You are already invisible.")
        return true
    end


    player:setStorageValue(invisibilityStorage, 1)
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You are now invisible to monsters for 15 seconds.")


    item:remove(1)
    
    -- Apply effects every second for the duration
    for i = 1, 14 do
        addEvent(function()
            player:getPosition():sendMagicEffect(invisibilityEffect)
        end, i * 1000)
    end


    -- Apply last effect after 15 seconds and remove invisibility
    addEvent(function()
        player:setStorageValue(invisibilityStorage, -1)
        player:getPosition():sendMagicEffect(lastEffect)
    end, invisibilityTime)


    return true
end