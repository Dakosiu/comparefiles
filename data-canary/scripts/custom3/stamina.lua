local smallstaminarefill = Action()

local STAMINA_TIME = 24 * 3600
local STORAGE = 44341 -- any storage

function smallstaminarefill.onUse(player, item, ...)
    local stamina = player:getStamina()
    if stamina >= 2520 then
        player:sendCancelMessage("You have a full stamina.")
        return true
    end
	
	if player:getStorageValue(STORAGE) > os.time() then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You can only use this item every 24h!')
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end
	
    player:setStamina(math.min(2520, stamina + 120))
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    player:sendCancelMessage("You have regenerate 2 hours of stamina.")
	player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "You have regenerate 2 hours of stamina.")
	player:setStorageValue(STORAGE, os.time() + STAMINA_TIME)
    item:remove(1)
    return true
end

smallstaminarefill:id(34005)
smallstaminarefill:register()