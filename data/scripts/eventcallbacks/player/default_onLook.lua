local ec = EventCallback
ec.onLook = function(self, thing, position, distance, description, exp)
	local description = "You see " .. thing:getDescription(distance)
	if thing:isItem() then
		local blow = thing:getBlow()
		local bounce = thing:getBounce()
		local explosion = thing:getExplosion()
		local chain = thing:getChain()
		local newAttribute = true

		if bounce or explosion or chain or blow then
			description = description .. "\n" .. "Attributes\n--------------"
			newAttribute = false
		end

		if bounce then
			description = description .. "\n" .. "Bounce: " .. bounce .. "x"
		end

		if explosion then
			description = description .. "\n" .. "Explosion: " .. explosion .. "x"
		end

		if chain then
			description = description .. "\n" .. "Chain: " .. chain .. "x"
		end

		if blow then
			description = description .. "\n" .. "Blow: " .. blow .. "x"
		end

		if newAttribute == false then
			description = description .. "\n" .. "-------------- "
		end
		
		local toRemove = thing:getCustomAttribute(itemUpgradeSystem.markedToRemove)
		if toRemove then
		   description = description .. "\n" .. "To Remove: " .. toRemove 
		end

	end

	if thing:isItem() then
		local stats = thing:displayStats()
		if stats ~= "" then
			description = description .. "\n" .. stats
		end
	end

	if self:getAccountType() >= ACCOUNT_TYPE_GOD then 
		if thing:isItem() then
			description = string.format("%s\nItem ID: %d", description, thing:getId())

			local actionId = thing:getActionId()
			if actionId ~= 0 then
				description = string.format("%s, Action ID: %d", description, actionId)
			end

			local uniqueId = thing:getUniqueId()
			if uniqueId < 65000 then
				description = string.format("%s, Unique ID: %d", description, uniqueId)
			end

			local itemType = thing:getType()

			local transformEquipId = itemType:getTransformEquipId()
			local transformDeEquipId = itemType:getTransformDeEquipId()
			if transformEquipId ~= 0 then
				description = string.format("%s\nTransforms to: %d (onEquip)", description, transformEquipId)
			elseif transformDeEquipId ~= 0 then
				description = string.format("%s\nTransforms to: %d (onDeEquip)", description, transformDeEquipId)
			end

			local decayId = itemType:getDecayId()
			if decayId ~= -1 then
				description = string.format("%s\nDecays to: %d", description, decayId)
			end
		end
	end
	if self:getAccountType() >= ACCOUNT_TYPE_GOD then
		if thing:isCreature() then
			if thing:isPlayer() then

				local str = "%s\nHealth: %d / %d"
				if thing:getMaxMana() > 0 then
					str = string.format("%s Mana: %d / %d", str, thing:getMana(), thing:getMaxMana())
				end
				description = string.format(str, description, thing:getHealth(), thing:getMaxHealth()) .. "."
			end
		end
	end
	if thing:isCreature() then
		if thing:isPlayer() then
			local attackSpeed = thing:getVocation():getAttackSpeed() - thing:getStorageValue(BonusAttackSpeed)
			if attackSpeed > 0 then
				description = description .. "\n" .. "Attack Speed: " .. attackSpeed .. "ms"
			end

			local protectionLoss = thing:getLossPercent()
			if protectionLoss > 0 then
				description = description .. "\n" .. "Protection Loss: " .. protectionLoss .. "%"
			end
			
			local trappedEnergy = thing:getStorageValue(StatSystem.config.storages.trappedEnergyPoints)
			if trappedEnergy > 0 then
				description = description .. "\n" .. "Trapped Energy: " .. trappedEnergy .. "%"
			end
			local extraHealing = thing:getTotalExtraHealing()
			if extraHealing > 0 then
				description = description .. "\n" .. "Healing Boost: " .. extraHealing .. "%"
			end

			local extraHealth = thing:onLookBonusHealth()
			if extraHealth > 0 then
				if thing:getStorageValue(10005) > 0 then
					description = string.format("%s \nBonus Health: %d", description, extraHealth + thing:getStorageValue(10005))
				else
					description = string.format("%s \nBonus Health: %d", description, extraHealth)
				end
			end
			
			local extraMana = thing:onLookBonusMana()
			if extraMana > 0 then
				if thing:getStorageValue(10006) > 0 then
					description = string.format("%s \nBonus Mana: %d", description, extraMana + thing:getStorageValue(10006))
				else
					description = string.format("%s \nBonus Mana: %d", description, extraMana)
				end
			end

			local speed = thing:getTotalSpeedBonus() / 2
			local outfit = thing:getOutfit()
			--[[ if outfit.lookMount > 0 then
				speed = speed + 10
			end --]]


			if speed >= 1 then
				description = string.format("%s \n Speed Bonus: %d", description, speed) .. "."
			end

			local rate = _G.rate + thing:statsExpBonus() * 100
			if rate then
				if rate >= 1 then
					description = string.format("%s \nExp Boost: %d", description, rate) .. "%"
				end
			end

			local cap = thing:getStorageValue(31214124) * 25
			if cap >= 1 then
				description = string.format("%s \n Cap Bonus: %d", description, cap) .. "."
			end

			local toAddHere = 0
			if thing:getItemsBonusDamage() then
				toAddHere = thing:getItemsBonusDamage()
			end

			local attackDamage = math.max(0, thing:getStorageValue(StatSystem.config.storages.attackPoints)) + toAddHere
			if attackDamage > 0 then
				description = description .. "\n" .. "Bonus Damage: " .. attackDamage .. "%"
			end

			local reflection = thing:getTotalReflect()
			if reflection > 0 then
				description = description .. "\n" .. "Reflect: " .. reflection .. "%"
			end

			local dodge = thing:getTotalDodge()
			if dodge > 0 then
				description = description .. "\n" .. "Dodge: " .. dodge .. "%"
			end

			local protection = thing:getAllProtection()
			if protection > 0 then
				--description = string.format("%s,\nProtection: %d", description, protection) .. "%"
				description = description .. "\n" .. "Protection All: " .. protection .. "%"
			end

			local healthRegen = thing:getExtraHealthRegeneration()
			local manaRegen = thing:getExtraManaRegeneration()
			if healthRegen >= 1 then
				description = string.format("%s \nHP: %d", description, healthRegen) .. "/s"
			end

			if manaRegen >= 1 then
				description = string.format("%s \nMP: %d", description, manaRegen) .. "/s"
			end
		end
	end

	if self:getAccountType() >= ACCOUNT_TYPE_GOD or self:getName() == "Dakosek" then
		local position = thing:getPosition()
		description = string.format(
			"%s\nPosition(%d, %d, %d",
			description, position.x, position.y, position.z
		) .. ")"

		if thing:isPlayer() then
			local client = thing:getClient()
			description = string.format("%s\nIP: %s Ping: %i Fps: %i.", description, Game.convertIpToString(thing:getIp()),
				client.ping, client.fps)
		end

		if thing:isCreature() and not thing:isPlayer() then

			local mHP = thing:getMaxHealth()
			local aHP = thing:getHealth()
			description = string.format("%s \nHealth: %d", description, aHP) .. "/" .. mHP .. "."
		end
	end
	return description
end

ec:register()
