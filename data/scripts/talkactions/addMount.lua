local talk = TalkAction("/addMount", "!addMount")

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
         local mountID = tonumber(split[2])
         target:getPosition():sendMagicEffect(31)
         target:addMount(mountID)
      else
         player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addOutfit playerName, outfit, addon")
      end
   else
      player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addOutfit playerName, outfit, addon")
   end
end

talk:separator(" ")
talk:register()