local creatureEvent = CreatureEvent("ArenaCreature_onDeath")

function creatureEvent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
   if not killer then return true end
   if killer and killer:isPlayer() or killer:getMaster() then
      local player2 = killer:getMaster()
      local player = killer
      local points = configurationArenaSystem.monstersPoints[creature:getName()].points
      if not points then
         return true
      end
      if player:isPlayer() then
         player:setStorageValue(pointsArena,
            player:getStorageValue(pointsArena) + configurationArenaSystem.monstersPoints[creature:getName()].points)
         player:sendTextMessage(MESSAGE_EVENT_ORANGE,
            string.format("You received %i score points for killing %s and now have %i", points, creature:getName(),
               player:getStorageValue(pointsArena)))
      elseif player2 then
         player2:setStorageValue(pointsArena,
            player2:getStorageValue(pointsArena) + configurationArenaSystem.monstersPoints[creature:getName()].points)
         player:sendTextMessage(MESSAGE_EVENT_ORANGE,
            string.format("You received %i score points for killing %s and now have %i", points, creature:getName(),
               player2:getStorageValue(pointsArena)))
      end
   end
   return true
end

creatureEvent:register()
