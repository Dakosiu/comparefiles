local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)

   local pos = player:getPosition()


   player:addPremiumPoints(1)
   
   player:sendTextMessage(MESSAGE_STATUS_SMALL, "You have added 1 premium point to account.")
   pos:sendMagicEffect(440)
   item:remove(1)


return true
end

action:id(18422)
action:register()