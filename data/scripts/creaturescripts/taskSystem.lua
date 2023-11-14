local creatureevent = CreatureEvent("TaskSystem")

function creatureevent.onKill(creature, target, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
   local player = Player(creature)
   if not player then
      return true
   end
   local targetMonster = target:getMonster()
   if not targetMonster then
      return true
   end

   for players, damage in pairs(target:getDamageMap()) do
      local players = Player(players)
      for i in pairs(NPCTasks) do
         local a = NPCTasks[i]
         if a.creature then
            local b = a.Storage
            if players and players:getStorageValue(b) == 1 then
               local creatureName
               for v, k in pairs(a.creature) do
                  if targetMonster:getName() == k then
                     creatureName = k
                  end
               end
               if creatureName then
                  local c = (b * 2)
                  local killCount = players:getStorageValue(c)
                  if killCount < 0 then
                     players:setStorageValue(c, 0)
					 killCount = 0
                  end
                  local killTotal = a.Quantity
                  if killCount >= 0 and killCount < killTotal and players:getStorageValue(b) == 1 then
				     players:setStorageValue(c, killCount + 1)
                     players:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE,
                        "[TASKSYSTEM]: " ..
                        players:getStorageValue(c) .. "/" .. killTotal .. " " .. creatureName .. "s, Killed.")
                  end
                  if killCount + 1 >= killTotal and players:getStorageValue(b) == 1 then
                     players:sendTextMessage(MESSAGE_STATUS_WARNING, "You completed your task, go report it to the npc.")
                     players:setStorageValue(b, 3)
                  end
               end
            end
         elseif a.boss then
            local b = a.Storage
            local c = (b * 2)
            local killCount
            if players then
               killCount = players:getStorageValue(c)
               if killCount < 0 then
                  players:setStorageValue(c, 0)
				  killCount = 0
               end
            end
            local killTotal = a.Quantity
            if players and players:getStorageValue(b) == 1 then
               local creatureName
               for v, k in pairs(a.boss) do
                  if targetMonster:getName() == k then
                     creatureName = k
                  end
               end
               if creatureName then
                  if killCount >= 0 and killCount < killTotal and players:getStorageValue(b) == 1 then
                     players:setStorageValue(c, 1)
                     players:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE,
                        "[TASKSYSTEM]: " ..
                        players:getStorageValue(c) .. "/" .. killTotal .. " " .. creatureName .. "s, Killed.")
                  end
                  if killCount + 1 >= killTotal and players:getStorageValue(b) == 1 then
                     players:sendTextMessage(MESSAGE_STATUS_WARNING, "You killed the " .. creatureName .. " go report it to the npc.")
                     players:setStorageValue(b, 3)
                  end
               end
            end
         end
      end
   end
end

--[[
MESSAGE_STATUS_CONSOLE_RED = 18, /*Red message in the console*/
MESSAGE_EVENT_ORANGE = 19, /*Orange message in the console*/
MESSAGE_STATUS_CONSOLE_ORANGE = 20,  /*Orange message in the console*/
MESSAGE_STATUS_WARNING = 21, /*Red message in game window and in the console*/
MESSAGE_EVENT_ADVANCE = 22, /*White message in game window and in the console*/
MESSAGE_EVENT_DEFAULT = 23, /*White message at the bottom of the game window and in the console*/
MESSAGE_STATUS_DEFAULT = 24, /*White message at the bottom of the game window and in the console*/
MESSAGE_STATUS_WARNING = 25, /*Green message in game window and in the console*/
MESSAGE_STATUS_SMALL = 26, /*White message at the bottom of the game window"*/
MESSAGE_STATUS_CONSOLE_BLUE = 27, /*FIXME Blue message in the console*/
--]]

creatureevent:register()
creatureevent = CreatureEvent("taskSystem_onLogin")
function creatureevent.onLogin(player)
   player:registerEvent("TaskSystem")
   return true
end

creatureevent:register()