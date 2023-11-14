function Container.isContainer(self)
	return true
end

function Container.createLootItem(self, item, lootrate, debugMode)
	if self:getEmptySlots() == 0 then
		return true
	end

	local itemCount = 0
	local randvalue = 0
	
	if debugMode and debugMode == true then
	randvalue = getLootRandom(lootrate, true)
	else
	randvalue = getLootRandom(lootrate, false)
	end
	
	if debugMode and debugMode == true then
	   if lootrate then
	      print(getItemName(item.itemId) .. ": " .. "Chance for item: " .. item.chance .. ", Value Chance: " .. randvalue .. ", Loot boost: " .. "active: " .. (lootrate * 100) .. "%.")
	   else
	      print(getItemName(item.itemId) .. ": " .. "Chance for item: " .. item.chance .. ", Value Chance: " .. randvalue .. ", Loot boost: " .. "non-active.")
	   end
	end
	
	
	if randvalue < item.chance then
		if ItemType(item.itemId):isStackable() then
			itemCount = randvalue % item.maxCount + 1
		else
			itemCount = 1
		end
	end

	if itemCount > 0 then
		local tmpItem = Game.createItem(item.itemId, math.min(itemCount, 100))
		if not tmpItem then
			return false
		end
		
		if tmpItem:isContainer() then
			for i = 1, #item.childLoot do
				if not tmpItem:createLootItem(item.childLoot[i], lootrate, debugMode) then
					tmpItem:remove()
					return false
				end
			end

			if #item.childLoot > 0 and tmpItem:getSize() == 0 then
				tmpItem:remove()
				return true
			end
		end

		if item.subType ~= -1 then
			tmpItem:setAttribute(ITEM_ATTRIBUTE_CHARGES, item.subType)
		end

		if item.actionId ~= -1 then
			tmpItem:setActionId(item.actionId)
		end

		if item.text and item.text ~= "" then
			tmpItem:setText(item.text)
		end

		local ret = self:addItemEx(tmpItem)
		if ret ~= RETURNVALUE_NOERROR then
			tmpItem:remove()
		end

	end
	return true
end