local talk = TalkAction("/quit", "!quit")

function talk.onSay(player, words, param)
   local there = { 75, 2227, 12 }
   if player:getStorageValue(INDUNGEON) == 1 then
      player:SME(66)
      player:teleportTo(Position(there[1], there[2], there[3]), false)
      player:setStorageValue(INDUNGEON, 1)
   else
      player:sendCancelMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You are not inside a dungeon.")
      return false
   end
end

talk:register()
