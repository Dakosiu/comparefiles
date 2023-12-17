local talk = TalkAction("/addWing", "!addWing")

function talk.onSay(player, words, param)
   if not player:getGroup():getAccess() then
      return true
   elseif player:getAccountType() < ACCOUNT_TYPE_GOD then
      return false
   end
   local split = param:split(",")
   if player:getGroup():getAccess() and param ~= "" then
      if split[2] then
         local target = Creature(split[1])
         local WingID = tonumber(split[2])
         target:getPosition():sendMagicEffect(31)
         target:addWing(WingID)
      else
         player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addWing playerName, WingID")
      end
   else
      player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addWing playerName, WingID")
   end
end

talk:separator(" ")
talk:register()

local talk = TalkAction("/addAllWing", "!addAllWing")

function talk.onSay(player, words, param)
   if not player:getGroup():getAccess() and player:getAccountType() < ACCOUNT_TYPE_GOD then
      return true
   end
   local split = param:split(",")
   if player:getGroup():getAccess() and param ~= "" then
      if split[1] then
         local target = Creature(split[1])
         target:getPosition():sendMagicEffect(31)
         for i = 1, 50 do
            target:addWing(i)
         end
      else
         player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addAllWing playerName")
      end
   else
      player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addAllWing playerName")
   end
end

talk:separator(" ")
talk:register()
