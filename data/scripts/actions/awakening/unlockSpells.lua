local unlockSpells = Action()
local AID = 19991
local Storage = 33299

local config = {
   [1] = { spell = "Speed Spell", itemID = 31521},
   [2] = { spell = "God Spell", itemID = 31509},
}

function unlockSpells.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local a = item.actionid
   for i, spellConfig in pairs(config) do
      if spellConfig.itemID == item.itemid then
         local storage = Storage + i
         if player:getStorageValue(storage) < 1 then
            player:setStorageValue(storage, 1)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You unlocked the spell: " .. spellConfig.spell)
            item:remove(1)
         else
            player:sendTextMessage(MESSAGE_STATUS_WARNING, "You already unlocked this spell")
         end
         return true
      end
   end
end

unlockSpells:id(31521, 31509)
unlockSpells:register()