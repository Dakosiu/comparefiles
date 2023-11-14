local creatureevent = CreatureEvent("deathChannel_onDeath")
function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
   local info, win, lose = "%s [Level: %s] foi mort%s pelo %s %s%s",
       "%s obteve %s frags seguidos após derrotar %s.",
       "%s acabou de impedir que %s fizesse uma sequência de %s frags seguidos."
   local frags, storage = { 10, 15, 20, 25, 30, 35, 40, 45, 50 }, 30045

   if not creature:isPlayer() then
      return true
   end

   local player = Player(creature)

   if not killer then
      for _, players in ipairs(Game.getPlayers()) do
         players:sendChannelMessage('', string.format("%s Morreu por causas desconhecidas", player:getName()), TALKTYPE_CHANNEL_O, 10)
      end
      return true
   end

   if killer:isMonster() then
      for _, players in ipairs(Game.getPlayers()) do
         players:sendChannelMessage('', string.format("%s morreu lutando contra %s", player:getName(), killer:getName()), TALKTYPE_CHANNEL_O, 10)
      end
      return true
   end


   local target = killer
   target:setStorageValue(storage, target:getStorageValue(storage) + (target:getStorageValue(storage) == -1 and 2 or 1))
   for _, pid in ipairs(Game.getPlayers()) do
      pid:sendChannelMessage('', info:format(player:getName(), player:getLevel(),
         player:getSex() == 1 and "o" or "a", target:isPlayer() and "player" or "monstro", target:getName(),
         target:isPlayer() and " [Level: " .. target:getLevel() .. "]." or
         "."), TALKTYPE_CHANNEL_O, 10)
      for _, frag in ipairs(frags) do
         if target:getStorageValue(storage) == frag then
            pid:sendChannelMessage('', win:format(target:getName(), frag, player:getName()), TALKTYPE_CHANNEL_O, 10)
         end

         if player:getStorageValue(storage) >= frag then
            pid:sendChannelMessage('',
               lose:format(target:getName(), player:getName(), player:getStorageValue(storage) + 1),
               TALKTYPE_CHANNEL_O, 10)
         end
      end
   end
   player:setStorageValue(storage, 0)
   return true
end

creatureevent:register()
local creatureEvent = CreatureEvent("deathChannel_onLogin")
function creatureEvent.onLogin(player)
   player:registerEvent("deathChannel_onDeath")
   return true
end

creatureEvent:register()
