local config = { 
				{ type = "item", itemid = "22118", count = 5, chance = 0.45 },
				{ type = "item", itemid = "29289", count = 25, chance = 0.45 },
				{ type = "item", itemid = "29287", count = 1, chance = 0.45 },
				{ type = "item", itemid = "29288", count = 1, chance = 0.45 },
				{ type = "item", itemid = "31354", count = 1, chance = 0.45 },
				{ type = "item", itemid = "42315", count = 1, chance = 0.45 },
				{ type = "item", itemid = "31356", count = 1, chance = 0.45 },
				{ type = "item", itemid = "21947", count = 1, chance = 0.45 },
				{ type = "item", itemid = "27846", count = 1, chance = 0.45 },
			  }
					
					


local lotteryTicket= Action()
function lotteryTicket.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local rewardTable = dakosLib:getSingleReward(config)
	local id = tonumber(rewardTable["itemid"])
	local count = tonumber(rewardTable["count"])
	player:addItem(id, count)
	player:getPosition():sendMagicEffect(CONST_ME_HEARTS)
	local str = "You have received " .. count .. "x " .. getItemName(id)
	player:sendTextMessage(MESSAGE_INFO_DESCR, str)
	item:remove(1)
	return true
end
lotteryTicket:id(5957)
lotteryTicket:register()
