local talk = TalkAction("/addAura", "!addAura")

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
         local AuraID = tonumber(split[2])
         target:getPosition():sendMagicEffect(31)
         target:addAura(AuraID)
      else
         player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addAura playerName, AuraID")
      end
   else
      player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addAura playerName, AuraID")
   end
end

talk:separator(" ")
talk:register()

local talk = TalkAction("/addAllAura", "!addAllAura")

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
            target:addAura(i)
         end
      else
         player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addAllAura playerName")
      end
   else
      player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addAllAura playerName")
   end
end

talk:separator(" ")
talk:register()
