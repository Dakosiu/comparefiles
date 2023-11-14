local protecLossItems = {
   { itemID = 36548, protecLoss = 10 },
   { itemID = 30501, protecLoss = 10 },
   { itemID = 10305, protecLoss = 10 },
   { itemID = 34006, protecLoss = 10 },
   { itemID = 26332, protecLoss = 10 },
}

local protecLossItemsAction = Action()

function protecLossItemsAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local id = item.itemid
   local it
   local index
   for i in pairs(protecLossItems) do
      if id == protecLossItems[i].itemID then
         it = protecLossItems[i]
         index = i
      end
   end

   local itStorage = (FIRST_PROTECTIONLOSS - 1) + index
   if player:getStorageValue(itStorage) == 1 then
      player:sendTextMessage(MESSAGE_STATUS_WARNING, "You already have this effect")
      player:getPosition():sendMagicEffect(CONST_ME_POFF)
      return false
   end
   item:remove(1)
   player:setStorageValue(itStorage, 1)
   player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received " .. it.protecLoss .. " Protection Loss")
   return true
end

for _, items in pairs(protecLossItems) do
   protecLossItemsAction:id(items.itemID)
end
protecLossItemsAction:register()

function Player.getProtecLossItems(player)
   local value = 0
   for v, protect in pairs(protecLossItems) do
      if player:getStorageValue(FIRST_PROTECTIONLOSS - 1 + v) == 1 then
         value = value + protecLossItems[v].protecLoss
      end
   end
   if value > 100 then return 0 end
   return value
end

function Player.resetProtectLossItems(player)
   local value = player:getProtecLossItems()
   if value > 0 then
      for v, protect in pairs(protecLossItems) do
         return player:setStorageValue(FIRST_PROTECTIONLOSS - 1 + v, 0)
      end
   end
end
