RANDOM_ITEMS_SYSTEM_CONFIG = {
                                ["ItemID"] = {
							                    [31986] = {
														    _removeItem = true,
														    ["Rewards"] = {
														                    { type = "item", itemid = 3057, count = 1, chance = 0.05 },
																		    { type = "item", itemid = 10342, count = 1, chance = 0.05 },
																	      },
															["Effect"] = { value = CONST_ME_MAGIC_GREEN, enabled = true },			  
                                                         }																		  
							                 },
                                ["ActionID"] = {
							                     [66666] = {
														     _removeItem = true,
														     ["Rewards"] = {
														                     { type = "item", itemid = 3057, count = 1, chance = 0.05 },
																		     { type = "item", itemid = 10342, count = 1, chance = 0.05 },
																	       },
															 ["Effect"] = { value = CONST_ME_MAGIC_GREEN, enabled = true },
                                                            }																		  
							                   },											 
                               							   
						      }


local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local t = RANDOM_ITEMS_SYSTEM_CONFIG["ItemID"][item:getId()]
   local rewardTable = t["Rewards"]
   local effectTable = t["Effect"]
   local shouldRemove = t._removeItem
   
   dakosLib:addSingleReward(player, rewardTable)
   
   if effectTable.enabled then
      player:getPosition():sendMagicEffect(effectTable.value)
   end
   
   if shouldRemove then
      item:remove(1)
   end
   return true
end
for i, v in pairs(RANDOM_ITEMS_SYSTEM_CONFIG["ItemID"]) do
action:id(i)
end
action:register()


action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local t = RANDOM_ITEMS_SYSTEM_CONFIG["ActionId"][item:getActionId()]
   local rewardTable = t["Rewards"]
   local effectTable = t["Effect"]
   local shouldRemove = t._removeItem
   
   dakosLib:addSingleReward(player, rewardTable)
   
   if effectTable.enabled then
      player:getPosition():sendMagicEffect(effectTable.value)
   end
   
   if shouldRemove then
      item:remove(1)
   end
   return true
end
for i, v in pairs(RANDOM_ITEMS_SYSTEM_CONFIG["ActionID"]) do
action:aid(i)
end
action:register()