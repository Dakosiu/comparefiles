local staminarefill = Action()

function staminarefill.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)

    local s = player:getStamina() / 60
    local cfg = {}
        cfg.refuel = 42
        cfg.full = 40

    if s >= cfg.full then
        player:sendCancelMessage("Your stamina is already full.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Your stamina now is "..s.." h.")
    else
        player:setStamina(cfg.refuel*60)
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Your stamina has been refilled.")
		player:getPosition():sendMagicEffect(378)
        item:remove(1)
    end
    return true
end

staminarefill:id(35420)
staminarefill:register()