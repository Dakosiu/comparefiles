local GlobalBuffs = Action()

local items = {
   [41019] = { name = "skill", RateBonus = 100, Hours = 0.5, skillKey = 17586, timeKey = 17590 },
   [41023] = { name = "skill", RateBonus = 1000, Hours = 1, skillKey = 17586, timeKey = 17590 },
   [41114] = { name = "exp", RateBonus = 15, Hours = 1, skillKey = 17585, timeKey = 17589 },
   [41113] = { name = "exp", RateBonus = 15, Hours = 2, skillKey = 17585, timeKey = 17589 },
   [41112] = { name = "exp", RateBonus = 15, Hours = 3, skillKey = 17585, timeKey = 17589 },
   [27046] = { name = "exp", RateBonus = 100, Hours = 0.1, skillKey = 17585, timeKey = 17589 },
}
function GlobalBuffs.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local a = item.itemid


   if a then
      if getGlobalStorageValue(items[a].timeKey) >= os.time() then
         player:getPosition():sendMagicEffect(CONST_ME_POFF)
         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Theres already a world bonus activated")
         return false
      end
      rate = _G.rate
      setGlobalStorageValue(items[a].skillKey, items[a].RateBonus * 10)
      setGlobalStorageValue(items[a].timeKey, os.time() + items[a].Hours * 60 * 60)
      broadcastMessage(player:getName() ..
         " have activated the global " ..
         items[a].RateBonus ..
         "% " .. items[a].name .. " rate boost for next " .. items[a].Hours .. " " .. (items[a].Hours == 1 and "hour" or "hours") .. ".",
         MESSAGE_STATUS_WARNING)
         item:remove(1)
         rate = rate + items[a].RateBonus
         _G.rate = rate 
   end
   return false
end

for v, k in pairs(items) do
   GlobalBuffs:id(v)
end
GlobalBuffs:register()
