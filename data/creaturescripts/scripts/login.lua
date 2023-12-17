function onLogin(player)
	if player:getStorageValue(ROOKGARD_SYSTEM.storage) == nil or player:getStorageValue(ROOKGARD_SYSTEM.storage) < 0 then
		player:setStorageValue(ROOKGARD_SYSTEM.storage, 0)
	elseif player:getStorageValue(ROOKGARD_SYSTEM.storage) == 1 then
		player:sendTextMessage(ROOKGARD_SYSTEM.messages.failed.type, ROOKGARD_SYSTEM.messages.failed.value)
		player:teleportTo(ROOKGARD_SYSTEM.position)
	end

	player:setStorageValue(85489, os.time() + 3)
	--[[ if player:getSpeedBonus() >= 1 then
		player:changeSpeed(player:getSpeedBonus())
	end --]]

	--[[ if player.accountStorage[85675] > 0 then
		player:changeSpeed(player.accountStoragwe[85675])
	end --]]

	-- if player:getStorageValue(rookgardSystem.storage) == 1 then
		-- player:setStorageValue(rookgardSystem.storage, -1)
	-- end

	if player:speedStatsBonus() > 0 then
		player:changeSpeed(player:speedStatsBonus())
	end
	
	player:getTotalExpBonus()
	player:setStorageValue(bonusMount, 0)

	local protecBase = player:getProtectionAllBase()
	local healBase = player:getExtraHealingBase()
	local reflectBase = player:getReflectBase()

	if protecBase < 0 or protecBase > 1000 then
		player:setProtectionAllBase(0)
	end
	if healBase < 0 or healBase > 1000 then
		player:setExtraHealingBase(0)
	end
	if reflectBase < 0 or reflectBase > 1000 then
		player:setReflect(0)
	end

	-- Events
	player:registerEvent("PlayerBless")
	player:registerEvent("PlayerDeath")
	player:registerEvent("RewardLoot")
	player:registerEvent("DropLoot")
	player:registerEvent("killRuby")
	player:registerEvent("Bonuses")
	player:registerEvent("Piano")
	player:registerEvent("loot")
	player:registerEvent("Shop")
	player:registerEvent("OfflineTraining")
	return true
end

function onLogin(player)
	if player:getStorageValue(ROOKGARD_SYSTEM.storage) == nil or player:getStorageValue(ROOKGARD_SYSTEM.storage) < 0 then
		player:setStorageValue(ROOKGARD_SYSTEM.storage, 0)
	elseif player:getStorageValue(ROOKGARD_SYSTEM.storage) == 1 then
		player:sendTextMessage(ROOKGARD_SYSTEM.messages.failed.type, ROOKGARD_SYSTEM.messages.failed.value)
		player:teleportTo(ROOKGARD_SYSTEM.position)
	end

	player:setStorageValue(85489, os.time() + 3)
	--[[ if player:getSpeedBonus() >= 1 then
		player:changeSpeed(player:getSpeedBonus())
	end --]]

	--[[ if player.accountStorage[85675] > 0 then
		player:changeSpeed(player.accountStoragwe[85675])
	end --]]

	-- if player:getStorageValue(rookgardSystem.storage) == 1 then
		-- player:setStorageValue(rookgardSystem.storage, -1)
	-- end

	if player:speedStatsBonus() > 0 then
		player:changeSpeed(player:speedStatsBonus())
	end
	
	player:getTotalExpBonus()
	player:setStorageValue(bonusMount, 0)

	local protecBase = player:getProtectionAllBase()
	local healBase = player:getExtraHealingBase()
	local reflectBase = player:getReflectBase()

	if protecBase < 0 or protecBase > 1000 then
		player:setProtectionAllBase(0)
	end
	if healBase < 0 or healBase > 1000 then
		player:setExtraHealingBase(0)
	end
	if reflectBase < 0 or reflectBase > 1000 then
		player:setReflect(0)
	end

	-- Events
	player:registerEvent("PlayerBless")
	player:registerEvent("PlayerDeath")
	player:registerEvent("RewardLoot")
	player:registerEvent("DropLoot")
	player:registerEvent("killRuby")
	player:registerEvent("Bonuses")
	player:registerEvent("Piano")
	player:registerEvent("loot")
	player:registerEvent("Shop")
	player:registerEvent("OfflineTraining")
	return true
end
