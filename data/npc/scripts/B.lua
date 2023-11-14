configurationArenaSystem = {
   minLevel = 80,
   timeToKick = 10,
   hoursCooldown = 20,
   moneyMultiplier = 1000, --! So Level * moneyMultiplier = price
   monstersPoints = {
      ["Fire Elemental"] = { points = 1 },
      ["Vampire"] = { points = 1 },
      ["Dragon"] = { points = 2 },
      ["Giant Spider"] = { points = 2 },
      ["Vampire Bride"] = { points = 2 },
      ["Vampire Viscount"] = { points = 2 },
      ["Elf"] = { points = 2 },
      ["Dragon Lord"] = { points = 3 },
      ["Hydra"] = { points = 3 },
      ["Frost Dragon"] = { points = 3 },
      ["Elf Scout"] = { points = 3 },
      ["Elf Arcanist"] = { points = 4 },
      ["Medusa"] = { points = 4 },
      ["Demon"] = { points = 6 },
      ["Behemoth"] = { points = 6 },
      ["Grim Reaper"] = { points = 6 },
      ["Hellfire Fighter"] = { points = 6 },
      ["Hellhound"] = { points = 7 },
      ["Fury"] = { points = 7 },
      ["Spidris Elite"] = { points = 7 },
      ["Kollos"] = { points = 7 },
      ["Serpent Spawn"] = { points = 10 }
   },
   waves = 10,
   monstersPerWave = 10,
   secondsToSpawnWave = 10,
   multiplierWin = 1.4, -- 40%
   timerColor = 10,
}
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end

function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end

function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

function onThink() npcHandler:onThink() end

local randomMonsterstoSpawn = {}
for monster, info in pairs(configurationArenaSystem.monstersPoints) do
   if not table.contains(randomMonsterstoSpawn, monster) then
      table.insert(randomMonsterstoSpawn, monster)
   end
end

local function timeOutArena(p)
   local player = Player(p)
   if player then
      local spectators = Game.getSpectators(Position(150, 1763, 7), false, true, 8, 8, 8, 8)
      if #spectators > 0 then
         for _, players in pairs(spectators) do
            if players == player then
               player:sendFail("You have been kicked from arena.")
               player:teleportTo(player:getTown():getTemplePosition())
            end
         end
      end
   end
end

local function generateRandomPosition(x, y, z, minA, minB)
   local a = math.random(x - minA, x + minA)
   local b = math.random(y - minB, y + minB)
   local c = z
   return a, b, c
end

local function cleanArena()
   local monsterCounter = Game.getSpectators(Position(150, 1763, 7), false, false, 8, 8, 8, 8)
   for v, k in pairs(monsterCounter) do
      if k:isMonster() then
         k:getPosition():sendMagicEffect(CONST_ME_POFF)
         k:remove()
      end
   end
end

local function generateRandomMonster()
   local randomCreatureIndex = math.random(#randomMonsterstoSpawn) or 0
   local monsterName = randomMonsterstoSpawn[randomCreatureIndex] or "Demon"
   return monsterName
end

local function spawnMonsters()
   for i = 0, configurationArenaSystem.monstersPerWave do
      local x, y, z = generateRandomPosition(150, 1763, 7, 5, 5)
      local monsterName = generateRandomMonster()
      local monster = Game.createMonster(monsterName, Position(x, y, z), false, true)
      monster:registerEvent("ArenaCreature_onDeath")
   end
end

local function spawnTimer(seconds, color, createPos)
   for i = 1, seconds do
      addEvent(function()
         createPos:sendAnimatedText(seconds + 1 - i, color)
         if i == seconds then
            spawnMonsters()
            setGlobalStorageValue(waitingArena, 0)
         end
      end, i * 1000)
   end
end

local function giveArenaReward(p, score, win)
   local player = Player(p)
   if player then
      if win == true then
         score = score * configurationArenaSystem.multiplierWin
      end
      player:sendTextMessage(MESSAGE_EVENT_ORANGE,
         string.format("You received a multiplier of %i%% for winning, so your total points are %i",
            configurationArenaSystem.multiplierWin * 100 - 100, score))
      if score < 1000 then
         player:sendFail(string.format("You scored only %i, and didnt received any rewards.", score))
      elseif score < 2000 then
         player:addItem(39647, 1)
         player:sendSuccess(string.format("Congratulations, you scored %i points and received %i %s", score, 1,
            getItemName(39647)))
      elseif score < 3000 then
         player:addItem(39648, 1)
         player:sendSuccess(string.format("Congratulations, you scored %i points and received %i %s", score, 1,
            getItemName(39648)))
      elseif score >= 3000 then
         player:addItem(39649, 1)
         player:sendSuccess(string.format("Congratulations, you scored %i points and received %i %s", score, 1,
            getItemName(39649)))
      end
      local destination = Position(152, 1774, 5)
      player:teleportTo(destination)
      player:setStorageValue(pointsArena, 0)
   end
end

local function startArena(p, actualWave)
   local monsterCounter = Game.getSpectators(Position(150, 1763, 7), false, false, 8, 8, 8, 8)
   if #monsterCounter <= 1 and actualWave >= 0 then
      local player = Player(p)
      local time = configurationArenaSystem.secondsToSpawnWave
      if configurationArenaSystem.waves - actualWave <= configurationArenaSystem.waves then
         if getGlobalStorageValue(waitingArena) ~= 1 and actualWave > 0 then
            actualWave = actualWave - 1
            setGlobalStorageValue(waitingArena, 1)
            player:sendTextMessage(MESSAGE_STATUS_WARNING,string.format("Wave: %i/%i", configurationArenaSystem.waves - actualWave, configurationArenaSystem.waves))
            spawnTimer(time, configurationArenaSystem.timerColor, Position(150, 1763, 7))
         end
      end
   end
   if actualWave > 0 then -- !Continue Checking
      addEvent(startArena, 2000, p, actualWave)
   else
      local player = Player(p)
      giveArenaReward(player:getId(), player:getStorageValue(pointsArena), true)
   end
end

local function creatureSayCallback(cid, type, msg)
   if not npcHandler:isFocused(cid) then return false end
   local player = Player(cid)
   local it = configurationArenaSystem
   if msgcontains(msg, 'arena') then
      local lvl = player:getLevel()
      if lvl >= it.minLevel then
         local price = it.moneyMultiplier * lvl
         if player:getStorageValue(timeCooldownArena) > os.time() then
            npcHandler:say(
               "You cant enter in here yet, you still need to wait " ..
               timeLeft(player:getStorageValue(timeCooldownArena) - os.time(), true), cid)
            npcHandler.topic[cid] = 0
         end
         if player:getMoney() <= price then
            npcHandler:say("You dont have enough money to enter the arena, you need " .. price .. ".", cid)
            npcHandler.topic[cid] = 0
         end
         npcHandler:say("You seem to be stronger enough, want to enter the arena then ?", cid)
         npcHandler.topic[cid] = 1
      else
         npcHandler:say("You are not strong enough, please, leave..", cid)
         npcHandler.topic[cid] = 0
      end
   end

   if npcHandler.topic[cid] == 1 then
      if msgcontains(msg, 'yes') then
         local spectators = Game.getSpectators(Position(150, 1763, 7), false, true, 8, 8, 8, 8)
         if #spectators > 0 then
            npcHandler:say("Someone is already doing it, come back later!", cid)
            npcHandler.topic[cid] = 0
            return
         end
         npcHandler:say("Good luck in there!", cid)
         local destination = Position(150, 1763, 7)
         player:teleportTo(destination)
         player:setStorageValue(timeCooldownArena, it.hoursCooldown * 3600)
         addEvent(timeOutArena, it.timeToKick * (60 * 1000), player:getId())
         player:setStorageValue(pointsArena, 0)
         cleanArena()
         startArena(player:getId(), configurationArenaSystem.waves)
      end
   end
end

npcHandler:setMessage(MESSAGE_GREET, "Hey |PLAYERNAME|, want to enter the {arena} ?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Come back when you get time, |PLAYERNAME|, i want to see you fightning again.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
