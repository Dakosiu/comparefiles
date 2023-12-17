local talk = TalkAction("/setStorage", "!setStorage")

function talk.onSay(player, words, param)
   local split = param:split(",")
   if not player:getGroup():getAccess() and param ~= "" then
      if split[3] then
         local target = Creature(split[1])
         local key = tonumber(split[2])
         local value = tonumber(split[3])
         target:getPosition():sendMagicEffect(31)
         target:setStorageValue(key, value)
         player:sendTextMessage(MESSAGE_INFO_DESCR,
            "You gived the value: " .. split[3] .. " for Storage " .. key .. ".")
      else
         player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! setStorage playerName, key, value")
      end
   else
      player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! setStorage playerName, key, value")
   end
end

talk:separator(" ")
talk:register()

local talk = TalkAction("/getStorage", "!getStorage")

function talk.onSay(player, words, param)
   local split = param:split(",")
   if not player:getGroup():getAccess() and param ~= "" then
      if split[2] then
         local target = Creature(split[1])
         local key = tonumber(split[2])
         target:getPosition():sendMagicEffect(31)
         target:getStorageValue(key)
         player:sendTextMessage(MESSAGE_INFO_DESCR,
            "The value for " .. key .. " is: " .. target:getStorageValue(key) .. ".")
      else
         player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! getStorage playerName, key, value")
      end
   else
      player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! getStorage playerName, key, value")
   end
end

talk:separator(" ")
talk:register()
