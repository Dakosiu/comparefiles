local function addExtraLoot(corpse, name)

	if not corpse then
		return nil
	end

	if not name then
		return nil
	end

	monsterStrongness = _G.monsterStrongness
	if monsterStrongness ~= nil then
		for index, itemTable in pairs(MONSTERS_EXTRA_LOOT[name]) do
			--print("AddLoot:" .. monsterStrongness)
			local id = itemTable.itemid
			local count = math.random(itemTable.count.min, itemTable.count.max)
			local chance = itemTable.chance

			local number = math.random(0, 100)
			local minHealth = itemTable.minhealth
			if number <= chance then
				if corpse then
					if minHealth <= monsterStrongness then
						corpse:addItem(id, count)
					end
				end
			end
		end
	end
end

local ec = EventCallback

ec.onDropLoot = function(self, corpse)
	if configManager.getNumber(configKeys.RATE_LOOT) == 0 then
		return
	end

	local player = Player(corpse:getCorpseOwner())

	local debugMode = nil
	local ratio = nil

	if player then
		debugMode = false
		local level = self:getMonsterLevel()
		if level and level > 0 then
			local percentage = getConfigInfo("levelMonsterBonusLootRate")
			if percentage then
				ratio = percentage * level
			end
		end
	end

	local mType = self:getType()
	if not player or player:getStamina() > 840 then
		local monsterLoot = mType:getLoot()
		for i = 1, #monsterLoot do
			 -- ? Bonus Loot
			 local bonusLoot = isBoostedCreature(self)
			 if bonusLoot > 0 then
				  extraPercent = bonusLoot
				  local default = monsterLoot[i].chance
				  if default < 100000 then
						extraLoot = true
						monsterLoot[i].chance = default + ((extraPercent * (default / 1000) / 100) * 1000)
				  end
			 end
			-- ? Bonus Loot
			local item = corpse:createLootItem(monsterLoot[i], ratio, debugMode)
			if not item then
				print('[Warning] DropLoot:', 'Could not add loot item to corpse.')
			end
		end

		if monsterStrongness ~= nil then
			if self:getSkull() == SKULL_RED then
				addExtraLoot(corpse, "Red Skull")
			elseif self:getSkull() == SKULL_ORANGE then
				addExtraLoot(corpse, "Orange Skull")
			end
		end

		if player then
			local text = ("Loot of %s: %s"):format(mType:getNameDescription(), corpse:getContentDescription())
			local party = player:getParty()
			if party then
				party:broadcastPartyLoot(text)
				player:sendTextMessage(MESSAGE_INFO_DESCR, text)
				player:sendChannelMessage("", text, TALKTYPE_CHANNEL_O, 9)
			else
				player:openChannel(9)
				player:sendTextMessage(MESSAGE_INFO_DESCR, text)
				player:sendChannelMessage("", text, TALKTYPE_CHANNEL_O, 9)
			end
		end
	else
		local text = ("Loot of %s: nothing (due to low stamina)"):format(mType:getNameDescription())
		local party = player:getParty()
		if party then
			party:broadcastPartyLoot(text)
			player:sendChannelMessage("", text, TALKTYPE_CHANNEL_O, 9)
		else
			player:openChannel(9)
			player:sendChannelMessage("", text, TALKTYPE_CHANNEL_O, 9)
		end
	end
end

ec:register()
