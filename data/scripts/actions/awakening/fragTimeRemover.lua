local skullRemover = Action()

local config = {
   [35450] = { hours = 6 },
   [35423] = { hours = 12 },
   [36442] = { hours = 24 },
   [35424] = { hours = 48 },
}

function skullRemover.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local pos = player:getPosition()
   local skullTime = math.floor(player:getSkullTime() / 3600)
   local id = item.itemid
   local a = config[id]
   if a then
      if player:getSkullTime() <= 0 or player:getSkullTime() < 3600 * a.hours then
         pos:sendMagicEffect(CONST_ME_POFF)
         player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You have less than " .. a.hours .. " hour frag time.")
         return true
      end
      player:setSkullTime(player:getSkullTime() - a.hours)
      if skullTime <= 0 then
         player:setSkullTime(1)
      end
      pos:sendMagicEffect(167)
      player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You have decreased frag time.")
      item:remove(1)
   end
end

skullRemover:id(35450, 35423, 36442, 35424)
skullRemover:register()
