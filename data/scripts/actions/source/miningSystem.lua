local config = {
   pickaxes = {
      [12670] = { sucessRate = 10 },
      [32075] = { sucessRate = 20 },
      [24828] = { sucessRate = 30 },
      [35367] = { sucessRate = 40 },
	  [41839] = { sucessRate = 50 },
	  [44960] = { sucessRate = 60 },
   },
   crystals = {
      [41749] = { lootItem = 41745, seedID = 41765 },
      [41664] = { lootItem = 41686, seedID = 41690 },
      [30159] = { lootItem = 33989, seedID = 32742 },
      [41668] = { lootItem = 41688, seedID = 41691 },
      [41677] = { lootItem = 41687, seedID = 41689 },
      [41750] = { lootItem = 41746, seedID = 41766 },
      [41747] = { lootItem = 41743, seedID = 41763 },
   },
   respawnOreTime = 1,
   sucessMineEffect = 1056,
}

local function restoreOre(target)
   local saveItem = target:getId()
   local position = target:getPosition()
   target:remove()
   addEvent(function()
      Game.createItem(config.crystals[saveItem].seedID, 1, position)
   end, config.respawnOreTime * (8 * 1000))
end

local action = Action()
function action.onUse(player, item, fromPos, target, toPos, isHotkey)
   local it = config.pickaxes[item:getId()]
   if it then
      if not target or not target:isItem() then
         return false
      end
      local crystal = config.crystals[target:getId()]
      if not crystal then
         return false
      end
      local random = math.random(1, 100)
      if random >= it.sucessRate then
         player:sendFail(string.format("You failed mining %s.", getItemName(target:getId())))
         target:getPosition():sendMagicEffect(932)
         restoreOre(target)
         return false
      end
      player:sendSuccess(string.format("You successfully mined %s and received 1 %s.",getItemName(target:getId()), getItemName(crystal.lootItem)))
      player:addItem(crystal.lootItem)
      target:getPosition():sendMagicEffect(config.sucessMineEffect)
      restoreOre(target)
   end
   return true
end

for item, _ in pairs(config.pickaxes) do
   action:id(item)
end
action:register()
