local config = {
   { words = "dp", Standxyz = { 845, 874, 5 }, minLevel = 50, effectBefore = 22, effectAfter = 33, teleportTo = { 821, 873, 4 } },
   { words = "azzs", Standxyz = { 783, 962, 5 }, minLevel = 50, effectBefore = 11, effectAfter = 44, teleportTo = { 781, 962, 5 } },
}

for index, table in pairs(config) do
   local a = config[index]
   local talk = TalkAction(a.words)
   function talk.onSay(player, words, param)
      local b = a.Standxyz
      local pos = Position(b[1], b[2], b[3])
      if player:getPosition() == pos and player:getLevel() >= a.minLevel then
         player:SME(a.effectBefore)
         local c = a.teleportTo
         local posTo = Position(c[1], c[2], c[3])
         player:teleportTo(posTo)
         player:SME(a.effectAfter)
         return false
      else
         return true
      end
   end
   talk:register()
end
