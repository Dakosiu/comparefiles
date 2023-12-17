if not destroyedItemsSystem then
   destroyedItemsSystem = {}
end
destroyedItemsSystem.id = 13412
destroyedItemsSystem.eventName = "ModalWindow_destroyedItemsSystem"
destroyedItemsSystem.markedToDelete = "DESTROYED_ITEM_SYSTEM_DELETE"

function destroyedItemsSystem:sendWindow(player, item)
    
	if not player then
	   return nil
	end
	
	player:registerEvent(destroyedItemsSystem.eventName)
    local title = "         Warning!         "
    local message = "You cant drop on ground items in this area. " .. "\n" .. "Item will be destroyed." .. " Are you sure?"
   
    local window = ModalWindow(destroyedItemsSystem.id, title, message)
	window:addButton(100, "Accept")
    window:addButton(101, "Decline")     
    window:addButton(102, "Accept 4Ever")     
    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101) 
	return window:sendToPlayer(player)
end

function destroyedItemsSystem:isContainerOwner(player, toCylinder)

	if not toCylinder or not toCylinder:isContainer() then
	   return false
	end
	
	local scanContainers = {}
	
	for i = 1, 11 do
		local slotItem = player:getSlotItem(i)		
		if slotItem then
			if slotItem:isContainer() then
				if slotItem.uid == toCylinder.uid then
				   return true
				end
				table.insert(scanContainers, slotItem)
		    end
	    end
	end
	
	while #scanContainers > 0 do
		  for i = 0, scanContainers[1]:getSize() - 1 do
		      local slotItem = scanContainers[1]:getItem(i)
			  if slotItem then
			     if slotItem:isContainer() then
				    if slotItem.uid == toCylinder.uid then
					   return true
					end
				    table.insert(scanContainers, slotItem)
				 end
			  end
		  end
		  table.remove(scanContainers, 1)
	end
	return false
end

function destroyedItemsSystem:itemShouldDelete(item)
   	
	if not item then 
	   return nil
	end
	
	if item:getCustomAttribute(destroyedItemsSystem.markedToDelete) == 1 then
	   return true
	end
	
	return false
end

function destroyedItemsSystem:setItemToDelete(item, method)
    
	if not item then 
	   return nil
	end
	
	if method then
	   return item:setCustomAttribute(destroyedItemsSystem.markedToDelete, 1)
	end
	return item:removeCustomAttribute(destroyedItemsSystem.markedToDelete)
end

function destroyedItemsSystem:deleteItem(player)
	
	local scanContainers = {}
	
	for i = 1, 11 do
		local slotItem = player:getSlotItem(i)		
		if slotItem then
		    if destroyedItemsSystem:itemShouldDelete(slotItem) then
			   slotItem:remove()
			   return true
			end
			if slotItem:isContainer() then
				table.insert(scanContainers, slotItem)
		    end
	    end
	end
	
	while #scanContainers > 0 do
		  for i = 0, scanContainers[1]:getSize() - 1 do
		      local slotItem = scanContainers[1]:getItem(i)
			  if slotItem then
		        if destroyedItemsSystem:itemShouldDelete(slotItem) then
			        slotItem:remove()
			        return true
			    end
			    if slotItem:isContainer() then
				   table.insert(scanContainers, slotItem)
		        end
			  end
		  end
		  table.remove(scanContainers, 1)
	end

end

function destroyedItemsSystem:revertItem(player)
	
	local scanContainers = {}
	
	for i = 1, 11 do
		local slotItem = player:getSlotItem(i)		
		if slotItem then
		    if destroyedItemsSystem:itemShouldDelete(slotItem) then
			   destroyedItemsSystem:setItemToDelete(slotItem, false)
			   return true
			end
			if slotItem:isContainer() then
				table.insert(scanContainers, slotItem)
		    end
	    end
	end
	
	while #scanContainers > 0 do
		  for i = 0, scanContainers[1]:getSize() - 1 do
		      local slotItem = scanContainers[1]:getItem(i)
			  if slotItem then
		        if destroyedItemsSystem:itemShouldDelete(slotItem) then
			        destroyedItemsSystem:setItemToDelete(slotItem, false)
			        return true
			    end
			    if slotItem:isContainer() then
				   table.insert(scanContainers, slotItem)
		        end
			  end
		  end
		  table.remove(scanContainers, 1)
	end

end
	
function destroyedItemsSystem:canMove(player, toPosition, toCylinder)

	local isGround = false
    if toPosition.x ~= CONTAINER_POSITION then
        isGround = true
    end
	
	if not isGround then
	   if toPosition.y < 64 then
	      return true
       end
	end
	
	if not destroyedItemsSystem:isContainerOwner(player, toCylinder) then
	   return false
	end
	
	return true
end

function destroyedItemsSystem:checkRemove(player, item, toPosition, toCylinder)
    
	if not player then
	   return nil
	end
	
	-- if not rookgardSystem:isOnRookgard(player) then
	   -- return false
	-- end

	-- if player:getStorageValue(19285) == 1 then --and player:getStorageValue(rookgardSystem.storage) == 1  then
		-- if not destroyedItemsSystem:canMove(player, toPosition, toCylinder) then
			-- destroyedItemsSystem:setItemToDelete(item, true)
			-- destroyedItemsSystem:deleteItem(player)
			-- return true
		-- end
	-- end
	
    -- if not destroyedItemsSystem:canMove(player, toPosition, toCylinder) then
	   -- destroyedItemsSystem:setItemToDelete(item, true)
	   -- destroyedItemsSystem:sendWindow(player)
	   -- return true
	-- end
	
	return false
end

local creaturescript = CreatureEvent(destroyedItemsSystem.eventName)
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId) 
        
		if modalWindowId == destroyedItemsSystem.id then

			if buttonId == 102 then
				destroyedItemsSystem:deleteItem(player)
				player:setStorageValue(19285, 1)
			end
			if buttonId == 101 then
			   destroyedItemsSystem:revertItem(player)
			   player:sendCancelMessage("You have canceled this action.")
			   return
			end
			
			if buttonId == 100 then	 
			   destroyedItemsSystem:deleteItem(player)
			end
		end
end
creaturescript:register()