local MarketLever = Action()
local aidBase = 54430

local Lever = {
   Red = 33064, -- 25
   Yellow = 33066, -- 20
   Purple = 33068, -- 15
   Green = 33070, -- 10
   Black = 39365,
   --! Use 0 if u want to use the Item that is on this Position
}

local config = {
   [1] = { Position = { x = 852, y = 877, z = 5 }, item = { id = 2173, count = 1 }, coins = { id = 2160, count = 10 }, Lever = 0 }, --!AOL
   [2] = { Position = { x = 154, y = 1864, z = 10 }, item = { id = 30525, count = 1 }, coins = { id = 40554, count = 50 }, Lever = Lever.Red }, --!Legendary Upgrade
   [3] = { Position = { x = 155, y = 1864, z = 10 }, item = { id = 30524, count = 1 }, coins = { id = 41529, count = 1 }, Lever = Lever.Red }, --!Medium Upgrade
   [4] = { Position = { x = 156, y = 1864, z = 10 }, item = { id = 30523, count = 1 }, coins = { id = 2160, count = 50 }, Lever = Lever.Red }, --!Low Upgrade
   [5] = { Position = { x = 157, y = 1864, z = 10 }, item = { id = 8300, count = 1 }, coins = { id = 41529, count = 1 }, Lever = Lever.Purple }, --!Legendary Slot
   [6] = { Position = { x = 158, y = 1864, z = 10 }, item = { id = 8302, count = 1 }, coins = { id = 2160, count = 50 }, Lever = Lever.Purple }, --!Medium Slot
   [7] = { Position = { x = 159, y = 1864, z = 10 }, item = { id = 8306, count = 1 }, coins = { id = 2160, count = 25 }, Lever = Lever.Purple }, --!Low Slot
   [8] = { Position = { x = 160, y = 1864, z = 10 }, item = { id = 39384, count = 1 }, coins = { id = 40554, count = 50 }, Lever = Lever.Yellow }, --!Bonus Remover
   [9] = { Position = { x = 161, y = 1864, z = 10 }, item = { id = 32659, count = 1 }, coins = { id = 40554, count = 100 }, Lever = Lever.Yellow }, --!Bonus Get
   [10] = { Position = { x = 857, y = 915, z = 2 }, item = { id = 41639, count = 1 }, coins = { id = 41529, count = 100 }, 0 }, --!!book of the dryads 25x stat point item
   [11] = { Position = { x = 857, y = 916, z = 2 }, item = { id = 41611, count = 1 }, coins = { id = 26179, count = 10 }, 0 }, --!stat pearl 1x 
   [12] = { Position = { x = 852, y = 917, z = 3 }, item = { id = 36436, count = 1 }, coins = { id = 26179, count = 20 }, 0 }, --!diamond of dryads
   [13] = { Position = { x = 853, y = 917, z = 3 }, item = { id = 36435, count = 1 }, coins = { id = 8918, count = 10 }, 0 }, --!dryads brick
   [14] = { Position = { x = 854, y = 917, z = 3 }, item = { id = 36434, count = 1 }, coins = { id = 7405, count = 10 }, 0 }, --!dryads sushi
   [15] = { Position = { x = 164, y = 1879, z = 10 }, item = { id = 27604, count = 1 }, coins = { id = 26179, count = 5 }, Lever = Lever.Purple }, --!teleportation drink
   [16] = { Position = { x = 169, y = 1879, z = 10 }, item = { id = 28436, count = 1 }, coins = { id = 40554, count = 100 }, Lever = Lever.Black }, --!exp pearls bag
   [17] = { Position = { x = 176, y = 1881, z = 10 }, item = { id = 21401, count = 1 }, coins = { id = 40554, count = 50 }, Lever = Lever.Black }, --!bp +1 item
   [18] = { Position = { x = 850, y = 910, z = 4 }, item = { id = 32709, count = 1 }, coins = { id = 6500, count = 1000 }, 0 }, --!golden dragon statue 10stat pt/10x use
   [19] = { Position = { x = 857, y = 916, z = 1 }, item = { id = 12328, count = 1 }, coins = { id = 26157, count = 10 }, 0 }, --!interdimensional potion 5k hp/mp
   [20] = { Position = { x = 857, y = 915, z = 1 }, item = { id = 36865, count = 1 }, coins = { id = 12405, count = 350 }, 0 }, --!vampire blood 5stat pt/20x use
   [21] = { Position = { x = 837, y = 864, z = 5 }, item = { id = 41535, count = 1 }, coins = { id = 40554, count = 100 }, 0 }, --!3 day premium scroll
   [22] = { Position = { x = 162, y = 1885, z = 10 }, item = { id = 34394, count = 1 }, coins = { id = 26179, count = 2 }, 0 }, --! 500hp/mp item
   [23] = { Position = { x = 162, y = 1886, z = 10 }, item = { id = 32081, count = 1 }, coins = { id = 26179, count = 5 }, 0 }, --! 1k hp/mp item
   [24] = { Position = { x = 162, y = 1887, z = 10 }, item = { id = 30117, count = 1 }, coins = { id = 40554, count = 30 }, 0 }, --! 1k hp/mp item
   [25] = { Position = { x = 162, y = 1888, z = 10 }, item = { id = 28837, count = 1 }, coins = { id = 40554, count = 30 }, 0 }, --! 1k hp/mp item
   [26] = { Position = { x = 162, y = 1889, z = 10 }, item = { id = 10614, count = 1 }, coins = { id = 31949, count = 5 }, 0 }, --! 2k hp/mp item
   [27] = { Position = { x = 177, y = 1881, z = 10 }, item = { id = 35420, count = 1 }, coins = { id = 26179, count = 5 }, Lever = Lever.Green }, --! stamina doll
   [28] = { Position = { x = 154, y = 1878, z = 10 }, item = { id = 36548, count = 1 }, coins = { id = 40554, count = 10 }, 0 }, --! 10% protection loss potion
   [29] = { Position = { x = 837, y = 865, z = 5 }, item = { id = 28632, count = 1 }, coins = { id = 41530, count = 3 }, 0 }, --! stat reset potion, for dark energy coin
   [30] = { Position = { x = 150, y = 1882, z = 10 }, item = { id = 26332, count = 1 }, coins = { id = 26180, count = 100 }, 0 }, --! 10% protection loss teamwork doll
   [31] = { Position = { x = 147, y = 1880, z = 10 }, item = { id = 30501, count = 1 }, coins = { id = 41529, count = 2 }, 0 }, --! 10% protection loss traveler doll
   [32] = { Position = { x = 147, y = 1878, z = 10 }, item = { id = 10305, count = 1 }, coins = { id = 2472, count = 10 }, 0 }, --! 10% protection loss holy item
   [33] = { Position = { x = 147, y = 1876, z = 10 }, item = { id = 34006, count = 1 }, coins = { id = 2646, count = 10 }, 0 }, --! 10% protection loss Golden Elixyr
   [34] = { Position = { x = 571, y = 782, z = 11 }, item = { id = 35450, count = 1 }, coins = { id = 40554, count = 120 }, 0 }, --! 6 hour frag time remover
   [35] = { Position = { x = 571, y = 783, z = 11 }, item = { id = 35423, count = 1 }, coins = { id = 40554, count = 200 }, 0 }, --! 12 hour frag time remover
   [36] = { Position = { x = 571, y = 784, z = 11 }, item = { id = 36442, count = 1 }, coins = { id = 40554, count = 350 }, 0 }, --! 24 hour frag time remover
   [37] = { Position = { x = 571, y = 785, z = 11 }, item = { id = 35424, count = 1 }, coins = { id = 41530, count = 4 }, 0 }, --! 48 hour frag time remover
   [38] = { Position = { x = 823, y = 871, z = 3 }, item = { id = 45204, count = 1 }, coins = { id = 2534, count = 11 }, 0 }, --! real vampire shield
   [39] = { Position = { x = 74, y = 2080, z = 6 }, item = { id = 11339, count = 1 }, coins = { id = 44281, count = 1 }, 0 }, --! Clay to gamble for good prize
   [40] = { Position = { x = 75, y = 2080, z = 6 }, item = { id = 11343, count = 1 }, coins = { id = 44281, count = 2 }, 0 }, --! marble rock with obsidian knife to use and gamble for prize
   [41] = { Position = { x = 63, y = 2087, z = 6 }, item = { id = 10511, count = 1 }, coins = { id = 44280, count = 1 }, 0 }, --! rope/shovel - all in one
   [42] = { Position = { x = 64, y = 2087, z = 6 }, item = { id = 10515, count = 1 }, coins = { id = 44280, count = 1 }, 0 }, --! rope/shovel - all in one
   [43] = { Position = { x = 65, y = 2087, z = 6 }, item = { id = 10513, count = 1 }, coins = { id = 44280, count = 1 }, 0 }, --! rope/shovel - all in one
   [44] = { Position = { x = 76, y = 2085, z = 6 }, item = { id = 26143, count = 1 }, coins = { id = 44281, count = 10 }, 0 }, --!
   [45] = { Position = { x = 76, y = 2086, z = 6 }, item = { id = 11394, count = 1 }, coins = { id = 44281, count = 20 }, 0 }, --!
   [46] = { Position = { x = 76, y = 2087, z = 6 }, item = { id = 34251, count = 1 }, coins = { id = 44281, count = 50 }, 0 }, --!
   [47] = { Position = { x = 76, y = 2088, z = 6 }, item = { id = 31551, count = 1 }, coins = { id = 44281, count = 100 }, 0 }, --!
   [48] = { Position = { x = 76, y = 2089, z = 6 }, item = { id = 31543, count = 1 }, coins = { id = 44280, count = 5 }, 0 }, --!
   [49] = { Position = { x = 75, y = 2089, z = 6 }, item = { id = 44802, count = 1 }, coins = { id = 44280, count = 10 }, 0 }, --!
   [50] = { Position = { x = 74, y = 2089, z = 6 }, item = { id = 41637, count = 1 }, coins = { id = 44280, count = 30 }, 0 }, --!
   [51] = { Position = { x = 73, y = 2089, z = 6 }, item = { id = 44892, count = 1 }, coins = { id = 44280, count = 60 }, 0 }, --!
   [52] = { Position = { x = 72, y = 2089, z = 6 }, item = { id = 12667, count = 1 }, coins = { id = 44280, count = 100 }, 0 }, --!
   [53] = { Position = { x = 71, y = 2089, z = 6 }, item = { id = 46092, count = 1 }, coins = { id = 44279, count = 2 }, 0 }, --!
   

}

function MarketLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local pos = player:getPosition()
   local aid = item.actionid
   for a in pairs(config) do
      local total = (aidBase + a)
      if aid == total then
         local v = (total - aidBase)
         v = config[v]
         if v then
            local moneyPrice = 0

            if v.coins.id == 2160 or v.coins.id == 2152 or v.coins.id == 2148 or v.coins.id == 41529 then
               if v.coins.id == 41529 then
                  moneyPrice = moneyPrice + (1000000 * v.coins.count)
               end
               if v.coins.id == 2160 then
                  moneyPrice = moneyPrice + (10000 * v.coins.count)
               end
               if v.coins.id == 2152 then
                  moneyPrice = moneyPrice + (100 * v.coins.count)
               end
               if v.coins.id == 2148 then
                  moneyPrice = moneyPrice + (1 * v.coins.count)
               end
            end
            if moneyPrice > 0 then
               if player:getTotalMoney() >= moneyPrice then
                  player:removeTotalMoney(moneyPrice)
                  player:addItem(v.item.id, v.item.count)
                  player:SME(54)
                  player:say("I've bought an item!")
                  local transformIds = _G.transformItems[item:getId()]
                  if not transformIds then
                     return false
                  end
                  item:transform(transformIds)
               elseif player:getTotalMoney() < moneyPrice then
                  player:getPosition():sendMagicEffect(CONST_ME_POFF)
                  player:say("I need " .. moneyPrice .. " coins to buy this item.")
                  player:sendTextMessage(MESSAGE_STATUS_SMALL, "I need " .. moneyPrice .. " coins to buy this item.")
               end
               return false
            end

            if player:removeItem(v.coins.id, v.coins.count) then
               if not v.item.count then
                  player:addItem(v.item.id, 1)
               else
                  player:addItem(v.item.id, v.item.count)
               end
               pos:sendMagicEffect(54)
               player:say("I've bought an item!")
               local transformIds = _G.transformItems[item:getId()]
               if not transformIds then
                  return false
               end
               item:transform(transformIds)
            else
               player:getPosition():sendMagicEffect(CONST_ME_POFF)
               player:say("I need " .. v.coins.count .. "x " .. getItemName(v.coins.id) .. ".")
               player:sendTextMessage(MESSAGE_STATUS_SMALL,
                  "I need " .. v.coins.count .. "x " .. getItemName(v.coins.id) .. ".")
            end
         end
      end
   end
end

for i in pairs(config) do
   MarketLever:aid(aidBase + i)
end
MarketLever:register()

local globalevent = GlobalEvent("load_Market")

function globalevent.onStartup()
   for i in pairs(config) do
      local tile = Tile(Position(config[i].Position.x, config[i].Position.y, config[i].Position.z))
      local item = config[i].Lever
      if item ~= 0 then
         Game.createItem(item, 1, Position(config[i].Position.x, config[i].Position.y, config[i].Position.z))
      end
      if tile then
         local thing = tile:getTopVisibleThing()
         if thing then
            thing:setCustomAttribute("Unmovable")
            thing:setAttribute(ITEM_ATTRIBUTE_ACTIONID, aidBase + i)
         end
      end
   end
end

globalevent:register()
