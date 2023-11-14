local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    	
	local condition = player:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	if condition and math.floor(condition:getTicks() / 1000 + (8 * 12)) >= 1200 then
		player:getPosition():sendMagicEffect(3)
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "You are full.")
	else
		doTargetCombat(0, player, COMBAT_HEALING, 100, 100)
	    doTargetCombat(0, player, COMBAT_MANADRAIN, 100, 100)
	    player:say("Yum.")
		player:getPosition():sendMagicEffect(357)
		player:feed(8 * 12)
		item:remove(1)
	end

    return true
end

action:id(342144)
action:register()
