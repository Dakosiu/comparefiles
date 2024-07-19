local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
	if player:hasCondition(CONDITION_INFIGHT) then
	   player:sendCancelMessage("You can't use this scroll while fighting.")
	   return true
	end
	
	
	player:teleportTo(player:getTown():getTemplePosition())
	player:sendCancelMessage("You have been teleported to temple.")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have been teleported to temple.")
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	item:remove(1)
    return true
end
action:id(25718)
action:register()