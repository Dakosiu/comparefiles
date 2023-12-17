local talk = TalkAction("/addOutfit", "!addOutfit")

function talk.onSay(player, words, param)
   if not player:getGroup():getAccess() then
      return true
   elseif player:getAccountType() < ACCOUNT_TYPE_GOD then
      return false
   end
   local split = param:split(",")
   if player:getGroup():getAccess() and param ~= "" then
      if split[3] then
         local target = Creature(split[1])
         local OutfitID = tonumber(split[2])
         local Addons = tonumber(split[3])
         target:getPosition():sendMagicEffect(31)
         target:addOutfitAddon(OutfitID, Addons)
      else
         player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addOutfit playerName, outfit, addon")
      end
   else
      player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addOutfit playerName, outfit, addon")
   end
end

talk:separator(" ")
talk:register()

local talk = TalkAction("/addAllOutfits", "!addAllOutfits")

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
         for i = 1, 2200 do
            target:addOutfitAddon(i, 3)
         end
      else
         player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addAllOutfits playerName")
      end
   else
      player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! addAllOutfits playerName")
   end
end

talk:separator(" ")
talk:register()
