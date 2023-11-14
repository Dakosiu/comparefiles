function onDeath(player, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	if player:getGroup():getAccess() then
		return true
	end
	if player:hasFlag(PlayerFlag_NotGenerateLoot) or player:getVocation():getId() == VOCATION_NONE then
		return true
	end
	if player:getStorageValue(19285) == 1 and player:getStorageValue(rookgardSystem.storage) == 1 then
		return true
	end

	local amulet = player:getSlotItem(CONST_SLOT_NECKLACE)
	local isRedOrBlack = table.contains({ SKULL_RED, SKULL_BLACK }, player:getSkull())
	if amulet and amulet.itemid == ITEM_AMULETOFLOSS and not isRedOrBlack or
		 amulet and amulet.itemid == 41131 and not isRedOrBlack then
		local isPlayer = false
		if killer then
			if killer:isPlayer() then
				isPlayer = true
			else
				local master = killer:getMaster()
				if master and master:isPlayer() then
					isPlayer = true
				end
			end
		end
		if not isPlayer or not player:hasBlessing(6) then
			player:removeItem(ITEM_AMULETOFLOSS, 1, -1, false)
		end
	else
		for i = 0, CONST_SLOT_AMMO do --Maybe make people dont lose backpack so u can keep upgrading your backpack without the fear of losing it
			local item = player:getSlotItem(i)
			local lossPercent = select(2, player:getLossPercent())
			if item then
				--print(math.random(item:isContainer() and 100 or 1000))
				if isRedOrBlack or math.random(item:isContainer() and 100 or 1000) <= lossPercent then
					if (isRedOrBlack or lossPercent ~= 0) and not item:moveTo(corpse) then
						item:remove()
					end
				end
			end
		end
	end

	if player:getProtecLossItems() > 0 then
		player:resetProtectLossItems()
	end

	if not player:getSlotItem(CONST_SLOT_BACKPACK) then
		player:addItem(ITEM_BAG, 1, false, CONST_SLOT_BACKPACK)
	end
	return true
end
