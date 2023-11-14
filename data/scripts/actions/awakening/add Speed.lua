local config = {
   limit = 1000, -- Limit bonusSpeed
   _displayEffects = true,
   storage = 85675,
   effect = 138,
   increase = 10
}

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)

   local pos = player:getPosition()
   local speed = player:getBaseSpeed()

   if player.accountStorage[config.storage] >= config.limit then
      if config._displayEffects then
         pos:sendMagicEffect(CONST_ME_POFF)
      end
      player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You cannot use the item anymore, you reached max use of it.")
      return true
   end

   if player.accountStorage[config.storage] < 1 then
      player.accountStorage[config.storage] = player.accountStorage[config.storage] + config.increase
      player:changeSpeed(config.increase)
   elseif player.accountStorage[config.storage] >= 1 then
      player.accountStorage[config.storage] = player.accountStorage[config.storage] + config.increase
      player:changeSpeed(config.increase)
   end
   item:remove(1)
   player:sendTextMessage(MESSAGE_INFO_DESCR, "You have increased your speed to " .. player:getSpeed() .. ".")
   pos:sendMagicEffect(config.effect)

   return true
end

action:id(13546)
action:register()