if not QUEST_SYSTEM then
   QUEST_SYSTEM = {}
end




QUEST_SYSTEM.storage = 8000

QUEST_SYSTEM.chests = { 1740, 1738, 1748 }

function QUEST_SYSTEM:createReward(chest, boolean)
    
	local itemsTable = {}
	local items = chest:getItems()
	if items and #items > 0 then
	   for _, item in pairs(items) do
	       if item:isContainer() then
		      local containerItems = QUEST_SYSTEM:createReward(item, true)
			  if not itemsTable["Container Items"] then
			     itemsTable["Container Items"] = {}
			  end	  
			  local values = { container_id = item:getId(), items = containerItems }
		      table.insert(itemsTable["Container Items"], values)
		   else
			  local values = { id = item:getId(), count = item:getCount() }
			  if boolean then
			     table.insert(itemsTable, values)
		      else
			  	 if not itemsTable["Items"] then
			        itemsTable["Items"] = {}
		         end
		         table.insert(itemsTable["Items"], values)
			  end
		   end
	   end
	end
	return itemsTable
end

function QUEST_SYSTEM:getReward(t, str, capacity)
   
    local str = ""
	local capValue = 0
    local regularItems = t["Items"]
    if regularItems and #regularItems > 0 then
        for i, v in pairs(regularItems) do
	      local id = tonumber(v.id)
		  local count = tonumber(v.count)
		  local name = getItemName(id):lower()
		  if capacity then
		     capValue = capValue + (ItemType(id):getCapacity() * count)
		  end 
			 
          str = str .. count .. "x " .. name
	      if i < #regularItems then
	         str = str .. ", "
	      end
        end
    end
	
	local containerItems = t["Container Items"]
	if containerItems then
	   if #regularItems > 0 then
	      if containerItems == 1 then
		     str = str .. " and "
	      else
		     str = str .. ", "
	      end
	   end
	   for i, v in ipairs(containerItems) do
	       local container_id = v.container_id
		   local container_name = getItemName(container_id):lower()
		   if capacity then
		      capValue = capValue + (ItemType(container_id):getCapacity())
		   end
		   
		   str = str .. container_name
		   local container_items = v.items
		   if container_items and #container_items > 0 then			  
			  str = str .. "("
			  local begin = true
			  for z, b in ipairs(container_items) do
			      local count = b.count
				  local id = tonumber(b.id)
				  if capacity then
		             capValue = capValue + (ItemType(id):getCapacity() * count)
		          end
				  local name = getItemName(id):lower()
				  str = str .. count .. "x " .. name
				  if z < #container_items then
				     str = str .. ", "
				  end
			   end
			   str = str .. ")"
			   if i == #containerItems then
			      str = str .. "."
			   elseif #containerItems > 1 and i == #containerItems - 1 then
			      str = str .. " and "
			   else
			      str = str .. ", "
			   end
		   end
	   end
	end
	if capacity then
	   return capValue
	end
	return str
end

function QUEST_SYSTEM:addReward(player, t)
    
	local requiredCapacity = QUEST_SYSTEM:getReward(t, false, true)
	local rewardString = QUEST_SYSTEM:getReward(t, true, false)
	if player:getFreeCapacity() < requiredCapacity then
	   player:sendCancelMessage(string.format('You have found %s weighing %.2f oz. You have no capacity.', rewardString, (requiredCapacity / 100)))
	   return false
	end
	
	
	local itemsDelete = {}
	local canReward = true
	
	local regularItems = t["Items"]
    if regularItems and #regularItems > 0 then
        for i, v in pairs(regularItems) do
		    local id = tonumber(v.id)
		    local count = tonumber(v.count)
		    local item = Game.createItem(id, count)
			if item then
			   if player:addItemEx(item) ~= RETURNVALUE_NOERROR then
				  canReward = false
				  table.insert(itemsDelete, item)
				  break
	           else
			      table.insert(itemsDelete, item)
			   end
			end
	    end
	end
	
	local containerItems = t["Container Items"]
	if containerItems then
	   for i, v in ipairs(containerItems) do
	       local container_id = v.container_id
		   local container_name = getItemName(container_id):lower()
		   
           local container = Game.createItem(container_id, 1)
		   if container then
		      local container_items = v.items
		      if container_items and #container_items > 0 then			  
			     local begin = true
			     for z, b in ipairs(container_items) do
			         local count = b.count
				     local id = tonumber(b.id)
				     container:addItem(id, count)
			     end
			  end
			  if player:addItemEx(container) ~= RETURNVALUE_NOERROR then
				  canReward = false
				  table.insert(itemsDelete, container)
				  break
	          else
			      table.insert(itemsDelete, container)
			   end			     
			     
		   end
	   end
	end
		
	if not canReward then
	   player:sendCancelMessage('You have found ' .. rewardString .. ', but you have no room to take it.')
	   for _, item in pairs(itemsDelete) do
	       item:remove()
	   end
	   return false
	end
	
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have found ' .. rewardString)
	
	
	
	return true
end
	
local action = Action()
function action.onUse(player, item, fromPos, target, toPos, isHotkey)
   
   
    local storage = item:getUniqueId()
	if storage and storage > 0 and storage < 65535 then
       if storage < 2000 or storage > 65535 then
          print("Quest Chest Error: UniqueId out of range. (" .. storage .. ")")
          return false
       end

       if player:getStorageValue(storage) > 0 then
          player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'The ' .. ItemType(item.itemid):getName() .. ' is empty.')
          return true
       end

       local items, reward = {}
       local size = item:isContainer() and item:getSize() or 0
       if size == 0 then
          reward = item:clone()
       else
          local container = Container(item.uid)
          for i = 0, container:getSize() - 1 do
              items[#items + 1] = container:getItem(i):clone()
          end
       end

       size = #items
       if size == 1 then
          reward = items[1]:clone()
       end

       local result = ''
       if reward then
          local ret = ItemType(reward.itemid)
          if ret:isRune() then
             result = ret:getArticle() .. ' ' ..  ret:getName() .. ' (' .. reward.type .. ' charges)'
          elseif ret:isStackable() and reward:getCount() > 1 then
             result = reward:getCount() .. ' ' .. ret:getPluralName()
          elseif ret:getArticle() ~= '' then
             result = ret:getArticle() .. ' ' .. ret:getName()
          else
             result = ret:getName()
          end
       else
          if size > 20 then
             reward = Game.createItem(item.itemid, 1)
          elseif size > 8 then
             reward = Game.createItem(1988, 1)
          else
             reward = Game.createItem(1987, 1)
          end

          for i = 1, size do
              local tmp = items[i]
              if reward:addItemEx(tmp) ~= RETURNVALUE_NOERROR then
                 print('[Warning] QuestSystem:', 'Could not add quest reward to container')
              end
          end
          local ret = ItemType(reward.itemid)
          result = ret:getArticle() .. ' ' .. ret:getName()
       end

       if player:addItemEx(reward) ~= RETURNVALUE_NOERROR then
          local weight = reward:getWeight()
          if player:getFreeCapacity() < weight then
             player:sendCancelMessage(string.format('You have found %s weighing %.2f oz. You have no capacity.', result, (weight / 100)))
          else
             player:sendCancelMessage('You have found ' .. result .. ', but you have no room to take it.')
          end
          return true
       end

       player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have found ' .. result .. '.')
       player:setStorageValue(storage, 1)
	   return true
	end
	
	
	
	
	storage = item:getActionId()
    if not storage or storage <= 0 then
	   return false
	end
	
	
	
	if player:getStorageValue(QUEST_SYSTEM.storage + storage) == 1 then
	   player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'The ' .. ItemType(item.itemid):getName() .. ' is empty.')
	   return true
	end
	
	
	
	local itemsTable = QUEST_SYSTEM:createReward(item)
	local regularItems = itemsTable["Items"]
	
	if not QUEST_SYSTEM:addReward(player, itemsTable) then
	   return true
	end
	
	player:setStorageValue(QUEST_SYSTEM.storage + storage, 1)
    return true
end

for i, id in pairs(QUEST_SYSTEM.chests) do
    action:id(id)
end
action:register()



local moveevent = MoveEvent()
moveevent:type("stepin")
function moveevent.onStepIn(creature, item, pos, fromPosition)	
	if (item.uid > 0 and item.uid <= 65535) or item:getActionId() > 0 then
		creature:teleportTo(fromPosition, false)
	end
    return true
end
for i, id in pairs(QUEST_SYSTEM.chests) do
    moveevent:id(id)
end
moveevent:register()

-- function onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- local storage = item:getUniqueId()
-- if storage < 2000 or storage > 65535 then
    -- print("Quest Chest Error: UniqueId out of range. (" .. storage .. ")")
    -- return false
-- end

    -- if player:getStorageValue(storage) > 0 then
        -- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'The ' .. ItemType(item.itemid):getName() .. ' is empty.')
        -- return true
    -- end

    -- local items, reward = {}
    -- local size = item:isContainer() and item:getSize() or 0
    -- if size == 0 then
        -- reward = item:clone()
    -- else
        -- local container = Container(item.uid)
        -- for i = 0, container:getSize() - 1 do
            -- items[#items + 1] = container:getItem(i):clone()
        -- end
    -- end

    -- size = #items
    -- if size == 1 then
        -- reward = items[1]:clone()
    -- end

    -- local result = ''
    -- if reward then
        -- local ret = ItemType(reward.itemid)
        -- if ret:isRune() then
            -- result = ret:getArticle() .. ' ' ..  ret:getName() .. ' (' .. reward.type .. ' charges)'
        -- elseif ret:isStackable() and reward:getCount() > 1 then
            -- result = reward:getCount() .. ' ' .. ret:getPluralName()
        -- elseif ret:getArticle() ~= '' then
            -- result = ret:getArticle() .. ' ' .. ret:getName()
        -- else
            -- result = ret:getName()
        -- end
    -- else
        -- if size > 20 then
            -- reward = Game.createItem(item.itemid, 1)
        -- elseif size > 8 then
            -- reward = Game.createItem(1988, 1)
        -- else
            -- reward = Game.createItem(1987, 1)
        -- end

        -- for i = 1, size do
            -- local tmp = items[i]
            -- if reward:addItemEx(tmp) ~= RETURNVALUE_NOERROR then
                -- print('[Warning] QuestSystem:', 'Could not add quest reward to container')
            -- end
        -- end
        -- local ret = ItemType(reward.itemid)
        -- result = ret:getArticle() .. ' ' .. ret:getName()
    -- end

    -- if player:addItemEx(reward) ~= RETURNVALUE_NOERROR then
        -- local weight = reward:getWeight()
        -- if player:getFreeCapacity() < weight then
            -- player:sendCancelMessage(string.format('You have found %s weighing %.2f oz. You have no capacity.', result, (weight / 100)))
        -- else
            -- player:sendCancelMessage('You have found ' .. result .. ', but you have no room to take it.')
        -- end
        -- return true
    -- end

    -- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have found ' .. result .. '.')
    -- player:setStorageValue(storage, 1)
    -- return true
-- end