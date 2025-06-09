function Container.isContainer(self)
	return true
end

function Container.createLootItem(self, item)
	if self:getEmptySlots() == 0 then
		return true
	end

	local itemCount = 0
	local randvalue = getLootRandom()
	local itemType = ItemType(item.itemId)
	
	local _applyBonuses = false
	local bonusCount = 0
			
	if randvalue < item.chance then
		if itemType:isStackable() then
			itemCount = randvalue % item.maxCount + 1
		else
			itemCount = 1
		end
		
		local classification = itemType:getClassification()
		if classification > 0 then
		    if ADVANCED_ATTRIBUTES:isInList(itemType:getName():lower()) then
			    bonusCount = math.random(1, classification)
		        -- local currentClassification = classification
		        -- local maxItemChance = 100000
			    -- local classificationTable = {}
				-- local factorTable = ADVANCED_ATTRIBUTES:getFactorTable()
			    -- while factorTable[currentClassification] do
					-- classificationTable[currentClassification] = {}
				    -- classificationTable[currentClassification].id = currentClassification
				    -- classificationTable[currentClassification].factor = CLASSIFICATION_FACTOR[currentClassification].factor
				    -- currentClassification = currentClassification - 1
			    -- end

				-- table.sort(classificationTable, function(a, b) return a.factor < b.factor end)
				
				-- local rand_factor = math.random(1, 100)
				
				-- for i, v in ipairs(classificationTable) do
				    -- local factor = v.factor
					-- local chance = 5000 / 100000
					-- print("Chance: " .. chance)
					-- local value = (factor / chance)--* 100000
					-- print("Value1:" .. value)
					-- --value = value / 100000
					-- --print("Value2:" .. value)
					-- local percentage = 100 - value
					-- print("Percentage: " .. percentage)
				-- end
				

				-- for i, v in ipairs(classificationTable) do
				    -- --if rand_factor <= v.factor then
					    -- print("Tu jestem 1")
					    -- bonusCount = v.id
						-- break
					-- --end
				-- end
				
				if bonusCount > 0 then
				    _applyBonuses = true
				end	
				
			end
		end		
	end

	while itemCount > 0 do
		local count = math.min(100, itemCount)
		
		local subType = count
		if itemType:isFluidContainer() then
			subType = math.max(0, item.subType)
		end
		
		local tmpItem = Game.createItem(item.itemId, subType)
		if not tmpItem then
			return false
		end

		if tmpItem:isContainer() then
			for i = 1, #item.childLoot do
				if not tmpItem:createLootItem(item.childLoot[i]) then
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
		
		if _applyBonuses then
		    ADVANCED_ATTRIBUTES:rollBonuses(tmpItem, bonusCount)
		end

		local ret = self:addItemEx(tmpItem)
		if ret ~= RETURNVALUE_NOERROR then
			tmpItem:remove()
		end

		itemCount = itemCount - count
	end
	return true
end
