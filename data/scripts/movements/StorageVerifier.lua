local StorageVerifier = MoveEvent()
local AID = 10080
StorageVerifier:type("stepin")

local QuestsStorage = {
   [1] = { Name = "Evotronus Banshee Quest", Id = 9170, Done = true },
   [2] = { Name = "Evotronus Desert Quest", Id = 9158, Done = true },
   [3] = { Name = "Evotronus Warlock Quest", Id = 9143, Done = true },
   [4] = { Name = "Evotronus Behemoth Quest", Id = 1298, Done = true },
   [5] = { Name = "Evotronus Inexistent Quest", Id = 42184, Done = true },
}

local config = {
   [1] = { Position = { x = 76, y = 2030, z = 10 },
      Storages = { QuestsStorage[1].Id, QuestsStorage[2].Id, QuestsStorage[4].Id }, Level = 100, CancelEffect = 20,
      EnterEffect = 19, WelcomeMessage = "Annihiliator Quest" },
   [2] = { Position = { x = 76, y = 2030, z = 10 },
      Storages = { 0 }, Level = 200, CancelEffect = 20,
      EnterEffect = 19, WelcomeMessage = "Pedro Quest" },
}

function StorageVerifier.onStepIn(creature, item, pos, fromPosition)
   local player = Player(creature)
   local pos = player:getPosition()
   local aid = item.actionid
   local questsToDo = {}
   local value = "nil"
   local h
   local t

   for a in pairs(config) do
      local total = (AID + a)
      if aid == total then
         local o = (total - AID)
         o = config[o]
         if o then

            --? Verify Storage and return false quest names

            for v, k in pairs(o.Storages) do
               --print(k)
               for i in pairs(QuestsStorage) do
                  if k == QuestsStorage[i].Id then
                     if player:getStorageValue(QuestsStorage[i].Id) ~= 1 then
                        QuestsStorage[i].Done = false
                        table.insert(questsToDo, QuestsStorage[i].Name)
                     end
                  end
               end
            end
            for v, k in pairs(questsToDo) do
               h = v
            end
            if h == 9 then
               value = questsToDo[1] ..
                   ", " ..
                   questsToDo[2] ..
                   ", " ..
                   questsToDo[3] ..
                   ", " ..
                   questsToDo[4] ..
                   ", " ..
                   questsToDo[5] ..
                   ", " ..
                   questsToDo[6] .. ", " .. questsToDo[7] .. ", " .. questsToDo[8] .. ", " .. questsToDo[9] .. "."
            elseif h == 8 then
               value = questsToDo[1] ..
                   ", " ..
                   questsToDo[2] ..
                   ", " ..
                   questsToDo[3] ..
                   ", " ..
                   questsToDo[4] ..
                   ", " ..
                   questsToDo[5] .. ", " .. questsToDo[6] .. ", " .. questsToDo[7] .. ", " .. questsToDo[8] .. "."
            elseif h == 7 then
               value = questsToDo[1] ..
                   ", " ..
                   questsToDo[2] ..
                   ", " ..
                   questsToDo[3] ..
                   ", " ..
                   questsToDo[4] .. ", " .. questsToDo[5] .. ", " .. questsToDo[6] .. ", " .. questsToDo[7] .. "."
            elseif h == 6 then
               value = questsToDo[1] ..
                   ", " ..
                   questsToDo[2] ..
                   ", " ..
                   questsToDo[3] .. ", " .. questsToDo[4] .. ", " .. questsToDo[5] .. ", " .. questsToDo[6] .. "."
            elseif h == 5 then
               value = questsToDo[1] ..
                   ", " ..
                   questsToDo[2] .. ", " .. questsToDo[3] .. ", " .. questsToDo[4] .. ", " .. questsToDo[5] .. "."
            elseif h == 4 then
               value = questsToDo[1] .. ", " .. questsToDo[2] .. ", " .. questsToDo[3] .. ", " .. questsToDo[4] .. "."
            elseif h == 3 then
               value = questsToDo[1] .. ", " .. questsToDo[2] .. ", " .. questsToDo[3] .. "."
            elseif h == 2 then
               value = questsToDo[1] .. ", " .. questsToDo[2] .. "."
            elseif h == 1 then
               value = questsToDo[1] .. "."
            else
               value = nil
            end

            if value ~= nil then
               player:getPosition():sendMagicEffect(o.CancelEffect)
               player:teleportTo(fromPosition)
               player:sendTextMessage(MESSAGE_STATUS_WARNING, "You still need to complete the quests: " .. value)
               return false
            end

            if o.Level > 0 then
               if player:getLevel() < o.Level then
                  player:sendTextMessage(MESSAGE_STATUS_WARNING, "You need level " .. o.Level .. " to enter here.")
                  player:getPosition():sendMagicEffect(o.CancelEffect)
                  player:teleportTo(fromPosition)
                  return false
               end
            end
            player:getPosition():sendMagicEffect(o.EnterEffect)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Welcome to: " .. o.WelcomeMessage)
         end
      end
   end
end

for i in pairs(config) do
   StorageVerifier:aid(AID + i)
end
StorageVerifier:register()

local globalevent = GlobalEvent("load_StorageVerifier")
function globalevent.onStartup()
   for i in pairs(config) do
      local tile = Tile(Position(config[i].Position.x, config[i].Position.y, config[i].Position.z))
      if tile then
         local thing = tile:getTopVisibleThing()
         if thing then
            thing:setAttribute(ITEM_ATTRIBUTE_ACTIONID, AID + i)
         end
      end
   end
end

globalevent:register()
