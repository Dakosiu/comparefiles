local Lottery = GlobalEvent("Lottery")
local timeBetweenLotteries = 3 *60 * 60 * 1000 -- in hours

local tiers = {
   [1] = { Name = "Tier 1", maxAmount = 20, maxLevel = 20},
   [2] = { Name = "Tier 2", maxAmount = 40, maxLevel = 40 },
   [3] = { Name = "Tier 3", maxAmount = 60, maxLevel = 60 },
   [4] = { Name = "Tier 4", maxAmount = 80, maxLevel = 80 },
   [5] = { Name = "Tier 5", maxAmount = 100, maxLevel = 100},
}

local items = {
   [1] = { item = 2160},
   [2] = { item = 2152},
}

function executeLottery(cid)
   local p = Player(cid)
   if p then
      local l = p:getLevel()
      local count 
      local tier 
      if l <= tiers[1].maxLevel then
         count = tiers[1].maxAmount
         tier = tiers[1].Name
      elseif l <= tiers[2].maxLevel then
         count = tiers[2].maxAmount
         tier = tiers[2].Name
      elseif l <= tiers[3].maxLevel then
         count = tiers[3].maxAmount
         tier = tiers[3].Name
      elseif l <= tiers[4].maxLevel then
         count = tiers[4].maxAmount
         tier = tiers[4].Name
      elseif l <= tiers[5].maxLevel or l >= tiers[5].maxLevel then
         count = tiers[5].maxAmount
         tier = tiers[5].Name
      end
      local b = math.random(#items)
      local quant = math.random(1, count)
      p:addItem(items[b].item, quant)
      Game.broadcastMessage(p:getName() .. "[" .. p:getLevel() .. "]" .. " Won the Lottery and received a " .. tier .. " reward" ..  "\n<<Next World Lottery in 3 hours, stay active!>>",MESSAGE_STATUS_WARNING)
   end
end

function Lottery.onThink(interval, lastExecution)
   local players = Game.getPlayers()
   local id
   local ids = {}

   for v, k in pairs(players) do
      id = k
      table.insert(ids, k)
   end

   local a = ids[math.random(#ids)]

   if a then
      addEvent(executeLottery, 1, a:getId())
   end

end

Lottery:interval(timeBetweenLotteries)
Lottery:register()
