local config = {
   [41745] = { transformTo = 41741 },
   [41686] = { transformTo = 41696 },
   [33989] = { transformTo = 32714 },
   [41688] = { transformTo = 41697 },
   [41687] = { transformTo = 41695 },
   [41746] = { transformTo = 41742 },
   [41743] = { transformTo = 41739 },
}
local action = Action()
function action.onUse(player, item, fromPos, target, toPos, isHotkey)
   if target then
      if target:isItem() then
         local it = config[target:getId()]
         if it then
            --player:sendSuccess(string.format("You transformed the item %s to %s.", getItemName(it), getItemName(it.transformTo)))
            target:remove(1)
            item:remove(1)
            player:addItem(it.transformTo, 1)
         else
            player:sendFail("You cannot transform this item.")
            return false
         end
      end
   end
   return true
end

action:id(18395)
action:register()
