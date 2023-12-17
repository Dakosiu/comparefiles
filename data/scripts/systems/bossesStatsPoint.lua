local bosses = {
   ["The Snapper"] = { statsPoint = 1, always = false, index = 0 }, -- ! Just add one more for each line you create, the index is to apply correctly the storages without performance issues.
   ["Dark Troll"] = { statsPoint = 1, always = false, index = 1 },
   ["Hide"] = { statsPoint = 1, always = false, index = 2 },
   ["Rorc"] = { statsPoint = 1, always = false, index = 3 },
   ["Tromphonyte"] = { statsPoint = 1, always = false, index = 4 },
   ["The Horned Fox"] = { statsPoint = 1, always = false, index = 5 },
   ["The Old Widow"] = { statsPoint = 1, always = false, index = 6 },
   ["Esmeralda"] = { statsPoint = 1, always = false, index = 7 },
   ["Mutated Wailing Widow"] = { statsPoint = 1, always = false, index = 8 },
   ["Haunter"] = { statsPoint = 1, always = false, index = 9 },
   ["Sulphur Scuttler"] = { statsPoint = 2, always = false, index = 10 },
   ["Necropharus"] = { statsPoint = 2, always = false, index = 11 },
   ["Dark Hero"] = { statsPoint = 2, always = false, index = 12 },
   ["Minishabaal"] = { statsPoint = 2, always = false, index = 13 },
   ["Batthus Bat"] = { statsPoint = 2, always = false, index = 14 },
   ["Raging Mage"] = { statsPoint = 2, always = false, index = 15 },
   ["Demodras"] = { statsPoint = 2, always = false, index = 16 },
   ["Orshabaal"] = { statsPoint = 3, always = false, index = 17 },
   ["Ghazbaran"] = { statsPoint = 4, always = false, index = 18 },
   ["Wyvern Draco"] = { statsPoint = 4, always = false, index = 19 },
   ["The Noxious Spawn"] = { statsPoint = 4, always = false, index = 20 },
   ["Morgaroth"] = { statsPoint = 5, always = false, index = 21 },
   ["Mutated Behemoth"] = { statsPoint = 5, always = false, index = 22 },
   ["Apocalypse"] = { statsPoint = 3, always = true, index = 23 },
   ["Snake God Essence"] = { statsPoint = 7, always = false, index = 24 },
   ["Souleater Ultima"] = { statsPoint = 5, always = false, index = 25 },
   ["Draken Spellweaver Ultima"] = { statsPoint = 5, always = false, index = 26 },
   ["Abyssador"] = { statsPoint = 10, always = false, index = 27 },
   ["Deathstrike"] = { statsPoint = 5, always = false, index = 28 },
   ["Gnomevil"] = { statsPoint = 4, always = true, index = 29 },
}

--[[ Dark Troll
abyssador
batthus bat
mutated behemoth
wyvern draco --]]
local creatureEvent = CreatureEvent("bossStatsPoint_onKill")
function creatureEvent.onKill(creature, target)
   if not creature:isPlayer() or creature:getMaster() then
      return true
   end
   if target:isPlayer() then
      return true
   end
   local master = creature:getMaster()
   local player = Player(creature)
   local monster = target:getName()
   if bosses[monster] then
      local it = bosses[monster]
      local storage = bossStatSystem + it.index
      if not it.always then
         if player:getStorageValue(storage) ~= 1 then
            player:setStorageValue(storage, 1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
               string.format("You received %i stats point for killing the %s boss.", it.statsPoint, monster))
            player:addStatsPoint(it.statsPoint)
         end
      else
         player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
            string.format("You received %i stats point for killing the %s boss.", it.statsPoint, monster))
         player:addStatsPoint(it.statsPoint)
      end
   end

   return true
end

creatureEvent:register()

local creatureEvent = CreatureEvent("bossStatsPoint_onLogin")

function creatureEvent.onLogin(player)
   player:registerEvent("bossStatsPoint_onKill")
   return true
end

creatureEvent:register()
