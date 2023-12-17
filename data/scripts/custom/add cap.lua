<<<<<<< HEAD
local config = {
   addCapacity = { value = 50, maxUsed = 7777 },
   _displayEffects = true,
   storage = 31214124
}

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)

   local pos = player:getPosition()
   local cap = player:getCapacity()

   if player:getStorageValue(config.storage) >= config.addCapacity.maxUsed then
      if config._displayEffects then
         pos:sendMagicEffect(3)
      end
      player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED,
         "You cannot use the item anymore, because it doesnt do any effect on you anymore.")
      return true
   end

   if player:getStorageValue(config.storage) < 1 then
      player:setStorageValue(config.storage, 1)
      player:setCapacity(cap + config.addCapacity.value * 100)
   elseif player:getStorageValue(config.storage) >= 1 then
      player:setStorageValue(config.storage, player:getStorageValue(config.storage) + 1)
      player:setCapacity(cap + config.addCapacity.value * 100)
   end

   player:sendTextMessage(MESSAGE_STATUS_SMALL, "You have increased your capacity by " .. config.addCapacity.value .. ".")
   pos:sendMagicEffect(311)
   item:remove(1)


   return true
end

action:id(12411)
action:register()
=======
local config = {
   addCapacity = { value = 50, maxUsed = 7777 },
   _displayEffects = true,
   storage = 31214124
}

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)

   local pos = player:getPosition()
   local cap = player:getCapacity()

   if player:getStorageValue(config.storage) >= config.addCapacity.maxUsed then
      if config._displayEffects then
         pos:sendMagicEffect(3)
      end
      player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED,
         "You cannot use the item anymore, because it doesnt do any effect on you anymore.")
      return true
   end

   if player:getStorageValue(config.storage) < 1 then
      player:setStorageValue(config.storage, 1)
      player:setCapacity(cap + config.addCapacity.value * 100)
   elseif player:getStorageValue(config.storage) >= 1 then
      player:setStorageValue(config.storage, player:getStorageValue(config.storage) + 1)
      player:setCapacity(cap + config.addCapacity.value * 100)
   end

   player:sendTextMessage(MESSAGE_STATUS_SMALL, "You have increased your capacity by " .. config.addCapacity.value .. ".")
   pos:sendMagicEffect(311)
   item:remove(1)


   return true
end

action:id(12411)
action:register()
>>>>>>> 8900eb460efeecbd5e68adf2d4e6fc52d6346528
