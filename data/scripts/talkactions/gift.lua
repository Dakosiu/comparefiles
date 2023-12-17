local talk = TalkAction("/additem", "!additem")

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
         local itemID = tonumber(split[2])
         local count = tonumber(split[3])
         target:getPosition():sendMagicEffect(31)
         target:addItem(itemID, count)
         target:sendTextMessage(MESSAGE_INFO_DESCR,
            "You received: " .. split[3] .. "x " .. getItemName(itemID) .. " from " .. player:getName() .. ".")
      else
         player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! additem playerName, itemID, count")
      end
   else
      player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Correct way to use is / or ! additem playerName, itemID, count")
   end
end

talk:separator(" ")
talk:register()


local function getPlayerDiffIps()
   local players = Game.getPlayers()
   local ipList = {}
   for index, player in pairs(players) do
      if not ipList[player:getIp()] then
         ipList[player:getIp()] = player
      end
   end
   return ipList
end

local talk = TalkAction("/globalreward", "!globalreward")
function talk.onSay(player, words, param)
   local split = param:split(",")
   local itemId = tonumber(split[1]) or 0
   local count = tonumber(split[2]) or 1
   local itemType = ItemType(itemId)
   if itemType:getId() == 0 then
      itemType = ItemType(tostring(split[1]))
      if itemType:getId() == 0 then
         player:sendCancelMessage("ID or Name of the wrong item.")
         return false
      end
   end
   count = math.floor(count)
   count = math.max(1, count)
   if itemType:isStackable() then
      count = math.min(100, count)
   else
      count = math.min(1, count)
   end
   for index, pla in pairs(getPlayerDiffIps()) do
      if pla:getFreeCapacity() >= itemType:getWeight(count) then
         pla:addItem(itemType:getId(), count)
         pla:getPosition():sendMagicEffect(31)
      end
   end
   Game.broadcastMessage(string.format("All the players have received %u %s.", count, itemType:getName()))
   return false
end

talk:separator(" ")
talk:register()
