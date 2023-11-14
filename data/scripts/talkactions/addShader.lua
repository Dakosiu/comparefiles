local talk = TalkAction("/addShader", "!addShader")

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
         local ShaderID = tonumber(split[2])
         target:getPosition():sendMagicEffect(31)
         target:addShader(ShaderID)
      else
         player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addShader playerName, ShaderID")
      end
   else
      player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addShader playerName, ShaderID")
   end
end

talk:separator(" ")
talk:register()

local talk = TalkAction("/addAllShader", "!addAllShader")

function talk.onSay(player, words, param)
   if not player:getGroup():getAccess() then
      return true
   elseif player:getAccountType() < ACCOUNT_TYPE_GOD then
      return false
   end
   local split = param:split(",")
   if player:getGroup():getAccess() and param ~= "" then
      if split[1] then
         local target = Creature(split[1])
         target:getPosition():sendMagicEffect(31)
         for i = 1, 50 do
            target:addShader(i)
         end
      else
         player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addAllShader playerName")
      end
   else
      player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addAllShader playerName")
   end
end

talk:separator(" ")
talk:register()
