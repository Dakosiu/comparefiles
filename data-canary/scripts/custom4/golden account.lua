-- Premium = {
	-- ExtraStaminaXp = 20,
	-- ExtraStaminaRegen = 30,
	-- ScrollDays = 30,
-- }

-- function Player.isRealPremium(self)
	-- return self:getPremiumDays() > 0
-- end

-- local scrollAction = Action()

-- function scrollAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	-- item:remove(1)
	-- player:addPremiumDays(Premium.ScrollDays)
	-- player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
	-- player:sendCancelMessage("You got " .. Premium.ScrollDays .. " golden account days.")
	-- return true
-- end

-- scrollAction:id(8176)
-- scrollAction:register()


-- local goldenAccountTalkAction = TalkAction("!goldenaccount")

-- function goldenAccountTalkAction.onSay(player, words, param)
	-- player:popupFYI("You have " .. player:getPremiumDays() .. " golden account days left.")
	-- return false
-- end

-- goldenAccountTalkAction:separator(" ")
-- goldenAccountTalkAction:register()