if not REWARD_BOX_SYSTEM then
    REWARD_BOX_SYSTEM = {}
end

REWARD_BOX_SYSTEM.config = {
                              [3997] = {
							                { type = "item", id = 3381, count = 1 },
											{ type = "item", id = 3382, count = 1 },
											{ type = "item", id = 3079, count = 1 },
											{ type = "fist", value = 10 },
											{ type = "club", value = 9 },
											{ type = "sword", value = 8 },
											{ type = "axe", value = 7 },
											{ type = "distance", value = 6 },
											{ type = "shielding", value = 5 },
											{ type = "fishing", value = 4 },
											{ type = "magic level", value = 3 },
									   }
						   }

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local itemTable = REWARD_BOX_SYSTEM.config[item:getId()]
	if not itemTable then
	    return true
	end
	--dakosLib:addReward(player, t, customString, returnStringOnly, skipText, customContainer, skipPrefix, highLight, skipChance)
	local str = dakosLib:addReward(player, itemTable, false, true, false, false, true, false, true)
	dakosLib:addReward(player, itemTable, false, false, true, false, true, false, true)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have received: " .. str)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	--dakosLib:updateSkills(player)
	item:remove(1)
return true
end

for i,v in pairs(REWARD_BOX_SYSTEM.config) do
    action:id(i)
end
action:register()