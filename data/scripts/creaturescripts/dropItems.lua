local function getItems(player)
   local items = {}
   for i = 1, #DROP_ITEMS do
      local level = DROP_ITEMS[i].Level

      if player:getLevel() >= level then
         for z = 1, #DROP_ITEMS[i].items do
            local id = DROP_ITEMS[i].items[z][1]
            local counts = DROP_ITEMS[i].items[z][2]
            local tempItem = { itemId = id, count = counts }
            table.insert(items, tempItem)
         end
      end

   end
   return items
end

local function getItem(player, corpse)

   local bag = corpse:addItem(5926)

   if bag then

      for z = 1, #getItems(player) do
         local id = getItems(player)[z]["itemId"]
         local count = getItems(player)[z]["count"]
         local itemtype = ItemType(id)
         if not itemtype:isStackable() and count > 1 then
            for i = 1, count do
               bag:addItem(id, count)
            end
         else
            bag:addItem(id, count)
         end
      end
   end
end

local creatureevent = CreatureEvent("dropItems_onDeath")
function creatureevent.onDeath(player, corpse, killer, mostDamage, unjustified, mostDamageUnjustified)
   if not killer then
      return true
   end
   if player:isPlayer() and killer:isPlayer() and mostDamage:isPlayer() then
      if player and mostDamage then
			local item = 21394
			local heart = killer:addItem(item, 1)
			heart:setAttribute(ITEM_ATTRIBUTE_NAME, string.format("%s's heart", player:getName()))
			heart:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION,"This heart was retrived by " .. killer:getName() .. "(" .. killer:getLevel() .. ")" .. " for killing " .. player:getName() .. "(" .. player:getLevel() .. ")")
		end
   end

   if mostDamage:isPlayer() then
      local party = mostDamage:getParty()
      if party then
         local leader = party:getLeader()
         if leader == player then
            return true
         end

         local members = party:getMembers()
         if members then
            for _, member in pairs(members) do
               if member == player then
                  return true
               end
            end
         end
      end
   end



   if mostDamage and mostDamage:isPlayer() then
      local ip1 = player:getIp()
      local ip2 = killer:getIp()
      if ip1 ~= ip2 then
         getItem(player, corpse)
      end
   end

   return true
end

creatureevent:register()

creatureevent = CreatureEvent("dropItems_onLogin")

function creatureevent.onLogin(player)
   player:registerEvent("dropItems_onDeath")
   return true
end

creatureevent:register()
