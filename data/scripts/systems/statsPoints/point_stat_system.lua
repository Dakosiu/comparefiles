if not StatSystem then
	StatSystem = {}
end

ToReset = 999377
LvlChest = 99927

StatSystem.config = {
	levels = {}, -- predefined levels which give 1 point to player
	effects = { getPoints = CONST_ME_TELEPORT, addMana = 38, addHealth = CONST_ME_TELEPORT,
		addAttack = CONST_ME_TELEPORT, addProtection = CONST_ME_TELEPORT, addHealing = CONST_ME_TELEPORT,
		addReflect = CONST_ME_TELEPORT, addDodge = CONST_ME_TELEPORT, addSpeed = CONST_ME_TELEPORT,
		addTrappedEnergy = CONST_ME_TELEPORT, addExperience = CONST_ME_TELEPORT, bonusAttackSpeed = CONST_ME_TELEPORT, addGodlyChest = CONST_ME_TELEPORT },
	message = "+5 Points",
	storages = {
		pointsBalance = STATS_POINT,
		healthPoints = 10001,
		manaPoints = 10002,
		attackPoints = 10003,
		nextLevel = 10004,
		addedHealth = 10005,
		addedMana = 10006,
		protectionAllPoints = 10007,
		healingBoostPoints = 10008,
		reflectPoints = 10009,
		dodgePoints = 10010,
		speedPoints = 10011,
		trappedEnergyPoints = 10012,
		experienceIncreasePoints = 10013,
		criticalChancePoints = 10014,
		criticalDamagePoints = 10015,
		lifeLeechChancePoints = 10016,
		lifeLeechAmountPoints = 10017,
		manaLeechChancePoints = 10018,
		manaLeechAmountPoints = 10019,
		bonusAttackSpeed = 99951,
		--godlyChestPoint = 10020,
	},
}

for i = 1, 5000 do
	table.insert(StatSystem.config.levels, 10 * i)
end

function StatSystem.onAdvanceLevel(player, oldLevel, newLevel)
	local nextLevel = player:getStorageValue(StatSystem.config.storages.nextLevel) == -1 and StatSystem.config.levels[1] or
		 player:getStorageValue(StatSystem.config.storages.nextLevel)
	if nextLevel > StatSystem.config.levels[#StatSystem.config.levels] then
		return true
	end

	for index, level in ipairs(StatSystem.config.levels) do
		if newLevel >= level and newLevel >= nextLevel and level >= nextLevel then
			StatSystem.addPoints(player, 5)
			player:say(StatSystem.config.message, TALKTYPE_MONSTER_SAY)
			player:getPosition():sendMagicEffect(StatSystem.config.effects.getPoints)
			player:setStorageValue(StatSystem.config.storages.nextLevel,
				StatSystem.config.levels[index + 1] or StatSystem.config.levels[#StatSystem.config.levels] + 1)
			player:setStorageValue(LvlChest, 0)
		end
	end
	return true
end

local config = {
	Health = {
		[1] = { Name = "Health Grade 1", Price = 1, Gain = 250, Type = "HP", Limit = 25000 },
		[2] = { Name = "Health Grade 2", Price = 2, Gain = 400, Type = "HP", Limit = 65000 },
		[3] = { Name = "Health Grade 3", Price = 5, Gain = 1000, Type = "HP", Limit = 165000 },
		[4] = { Name = "Health Grade 4", Price = 10, Gain = 2000, Type = "HP", Limit = 365000 },
		[5] = { Name = "Health Grade 5", Price = 20, Gain = 4000, Type = "HP", Limit = 765000 },
	},
	Mana = {
		[1] = { Name = "Mana Grade 1", Price = 1, Gain = 250, Type = "MP", Limit = 25000 },
		[2] = { Name = "Mana Grade 2", Price = 2, Gain = 400, Type = "MP", Limit = 65000 },
		[3] = { Name = "Mana Grade 3", Price = 5, Gain = 1000, Type = "MP", Limit = 165000 },
		[4] = { Name = "Mana Grade 4", Price = 10, Gain = 2000, Type = "MP", Limit = 365000 },
		[5] = { Name = "Mana Grade 5", Price = 20, Gain = 4000, Type = "MP", Limit = 765000 },
	},
	Attack = {
		[1] = { Name = "Bonus Damage Grade 1", Price = 1, Gain = 1, Type = "%", Limit = 5 },
		[2] = { Name = "Bonus Damage Grade 2", Price = 2, Gain = 1, Type = "%", Limit = 15 },
		[3] = { Name = "Bonus Damage Grade 3", Price = 5, Gain = 1, Type = "%", Limit = 35 },
		[4] = { Name = "Bonus Damage Grade 4", Price = 7, Gain = 1, Type = "%", Limit = 100 },
		[5] = { Name = "Bonus Damage Grade 5", Price = 10, Gain = 1, Type = "%", Limit = 200 },
	},
	Healing = {
		[1] = { Name = "Healing Grade 1", Price = 1, Gain = 1, Type = "%", Limit = 25 },
		[2] = { Name = "Healing Grade 2", Price = 2, Gain = 1, Type = "%", Limit = 50 },
		[3] = { Name = "Healing Grade 3", Price = 4, Gain = 1, Type = "%", Limit = 75 },
		[4] = { Name = "Healing Grade 4", Price = 6, Gain = 1, Type = "%", Limit = 150 },
		[5] = { Name = "Healing Grade 5", Price = 8, Gain = 1, Type = "%", Limit = 250 },
	},
	CriticalChance = {
		[1] = { Name = "Critical Chance Grade 1", Price = 3, Gain = 1, Type = "%", Limit = 2 },
		[2] = { Name = "Critical Chance Grade 2", Price = 6, Gain = 1, Type = "%", Limit = 4 },
		[3] = { Name = "Critical Chance Grade 3", Price = 9, Gain = 1, Type = "%", Limit = 6 },
		[4] = { Name = "Critical Chance Grade 4", Price = 12, Gain = 1, Type = "%", Limit = 8 },
		[5] = { Name = "Critical Chance Grade 5", Price = 15, Gain = 1, Type = "%", Limit = 10 },
	},
	CriticalDamage = {
		[1] = { Name = "Critical Damage Grade 1", Price = 1, Gain = 1, Type = "%", Limit = 5 },
		[2] = { Name = "Critical Damage Grade 2", Price = 2, Gain = 1, Type = "%", Limit = 15 },
		[3] = { Name = "Critical Damage Grade 3", Price = 4, Gain = 1, Type = "%", Limit = 65 },
		[4] = { Name = "Critical Damage Grade 4", Price = 5, Gain = 1, Type = "%", Limit = 130 },
		[5] = { Name = "Critical Damage Grade 5", Price = 10, Gain = 1, Type = "%", Limit = 260 },
	},
	BonusAttackSpeed = {
		[1] = { Name = "Attack Speed Grade 1", Price = 1, Gain = 5, Type = "ms", Limit = 500 }, -- 1500 attack speed (from normal(2000) to max of this)
		[2] = { Name = "Attack Speed Grade 2", Price = 2, Gain = 5, Type = "ms", Limit = 1000 }, 
		[3] = { Name = "Attack Speed Grade 3", Price = 4, Gain = 10, Type = "ms", Limit = 1400 },
	},
	ProtectionAll = {
		[1] = { Name = "Protection All Grade 1", Price = 5, Gain = 1, Type = "%", Limit = 5 },
		[2] = { Name = "Protection All Grade 2", Price = 10, Gain = 1, Type = "%", Limit = 10 },
		[3] = { Name = "Protection All Grade 3", Price = 15, Gain = 1, Type = "%", Limit = 15 },
		[4] = { Name = "Protection All Grade 4", Price = 20, Gain = 1, Type = "%", Limit = 20 },
		[4] = { Name = "Protection All Grade 4", Price = 35, Gain = 1, Type = "%", Limit = 25 },
	},
	Reflection = {
		[1] = { Name = "Reflection Grade 1", Price = 1, Gain = 1, Type = "%", Limit = 10 },
		[2] = { Name = "Reflection Grade 2", Price = 2, Gain = 1, Type = "%", Limit = 30 },
		[3] = { Name = "Reflection Grade 3", Price = 3, Gain = 1, Type = "%", Limit = 80 },
		[4] = { Name = "Reflection Grade 4", Price = 5, Gain = 1, Type = "%", Limit = 130 },
		[5] = { Name = "Reflection Grade 5", Price = 10, Gain = 1, Type = "%", Limit = 200 },
	},
	Dodge = {
		[1] = { Name = "Dodge Grade 1", Price = 10, Gain = 1, Type = "%", Limit = 1 },
		[2] = { Name = "Dodge Grade 2", Price = 20, Gain = 1, Type = "%", Limit = 2 },
		[3] = { Name = "Dodge Grade 2", Price = 30, Gain = 1, Type = "%", Limit = 3 },
		[4] = { Name = "Dodge Grade 2", Price = 40, Gain = 1, Type = "%", Limit = 4 },
		[5] = { Name = "Dodge Grade 2", Price = 50, Gain = 1, Type = "%", Limit = 5 },
	},
	Speed = {
		[1] = { Name = "Walking Speed Grade 1", Price = 3, Gain = 5, Type = " Points", Limit = 50 },
		[2] = { Name = "Walking Speed Grade 2", Price = 5, Gain = 10, Type = " Points", Limit = 100 },
		[3] = { Name = "Walking Speed Grade 3", Price = 10, Gain = 10, Type = " Points", Limit = 200 },
		[4] = { Name = "Walking Speed Grade 4", Price = 20, Gain = 10, Type = " Points", Limit = 400 },
		[5] = { Name = "Walking Speed Grade 5", Price = 30, Gain = 10, Type = " Points", Limit = 500 },
	},
	TrappedEnergy = {
		[1] = { Name = "Trapped Energy Grade 1", Price = 10, Gain = 1, Type = "%", Limit = 1 },
		[2] = { Name = "Trapped Energy Grade 2", Price = 20, Gain = 1, Type = "%", Limit = 2 },
		[3] = { Name = "Trapped Energy Grade 4", Price = 40, Gain = 1, Type = "%", Limit = 3 },
	},
	ExpRate = {
		[1] = { Name = "Bonus Experience Grade 1", Price = 5, Gain = 1, Type = "%", Limit = 5 },
		[2] = { Name = "Bonus Experience Grade 2", Price = 10, Gain = 1, Type = "%", Limit = 10 },
		[3] = { Name = "Bonus Experience Grade 3", Price = 15, Gain = 1, Type = "%", Limit = 15 },
		[4] = { Name = "Bonus Experience Grade 4", Price = 20, Gain = 1, Type = "%", Limit = 20 },
		[5] = { Name = "Bonus Experience Grade 5", Price = 25, Gain = 1, Type = "%", Limit = 25 },
	},
	ManaLeechChance = {
		[1] = { Name = "Mana Leech Chance Grade 1", Price = 3, Gain = 1, Type = "%", Limit = 2 },
		[2] = { Name = "Mana Leech Chance Grade 2", Price = 6, Gain = 1, Type = "%", Limit = 4 },
		[3] = { Name = "Mana Leech Chance Grade 3", Price = 9, Gain = 1, Type = "%", Limit = 6 },
		[4] = { Name = "Mana Leech Chance Grade 4", Price = 12, Gain = 1, Type = "%", Limit = 8 },
		[5] = { Name = "Mana Leech Chance Grade 5", Price = 15, Gain = 1, Type = "%", Limit = 10 },
	},
	ManaLeechAmount = {
		[1] = { Name = "Mana Leech Amount Grade 1", Price = 5, Gain = 1, Type = "%", Limit = 5 },
		[2] = { Name = "Mana Leech Amount Grade 2", Price = 10, Gain = 1, Type = "%", Limit = 10 },
		[3] = { Name = "Mana Leech Amount Grade 3", Price = 15, Gain = 1, Type = "%", Limit = 15 },
		[4] = { Name = "Mana Leech Amount Grade 4", Price = 20, Gain = 1, Type = "%", Limit = 20 },
		[5] = { Name = "Mana Leech Amount Grade 5", Price = 25, Gain = 1, Type = "%", Limit = 25 },
	},
	LifeLeechChance = {
		[1] = { Name = "Life Leech Chance Grade 1", Price = 3, Gain = 1, Type = "%", Limit = 2 },
		[2] = { Name = "Life Leech Chance Grade 2", Price = 6, Gain = 1, Type = "%", Limit = 4 },
		[3] = { Name = "Life Leech Chance Grade 3", Price = 9, Gain = 1, Type = "%", Limit = 6 },
		[4] = { Name = "Life Leech Chance Grade 4", Price = 12, Gain = 1, Type = "%", Limit = 8 },
		[5] = { Name = "Life Leech Chance Grade 5", Price = 15, Gain = 1, Type = "%", Limit = 10 },
	},
	LifeLeechAmount = {
		[1] = { Name = "Life Leech Amount Grade 1", Price = 5, Gain = 1, Type = "%", Limit = 5 },
		[2] = { Name = "Life Leech Amount Grade 2", Price = 10, Gain = 1, Type = "%", Limit = 10 },
		[3] = { Name = "Life Leech Amount Grade 3", Price = 15, Gain = 1, Type = "%", Limit = 15 },
		[4] = { Name = "Life Leech Amount Grade 4", Price = 20, Gain = 1, Type = "%", Limit = 20 },
		[5] = { Name = "Life Leech Amount Grade 5", Price = 25, Gain = 1, Type = "%", Limit = 25 },
	},
}



if not StatSystem.abilitiesTable then
   local t = config
   local t2 = StatSystem.config.storages
   StatSystem.abilitiesTable = {
                                    ["Health"] = { t.Health, t2.healthPoints },
									["Mana"] = { t.Mana, t2.manaPoints },
									["Attack"] = { t.Attack, t2.attackPoints },
									["Protection All"] = { t.ProtectionAll, t2.protectionAllPoints },
									["Healing"] = { t.Healing, t2.healingBoostPoints },
									["Reflect"] = { t.Reflection, t2.reflectPoints },
									["Dodge"] = { t.Dodge, t2.dodgePoints },
									["Speed"] = { t.Speed, t2.speedPoints },
									["Trapped Energy"] = { t.TrappedEnergy, t2.trappedEnergyPoints },
									["Experience Gain"] = { t.ExpRate, t2.experienceIncreasePoints },
									["Critical Chance"] = { t.CriticalChance, t2.criticalChancePoints },
									["Critical Damage"] = { t.CriticalDamage, t2.criticalDamagePoints },
									["Life Leech Chance"] = { t.LifeLeechChance, t2.lifeLeechChancePoints },
									["Life Leech Amount"] = { t.LifeLeechAmount, t2.lifeLeechAmountPoints },
									["Mana Leech Chance"] = { t.ManaLeechChance, t2.manaLeechChancePoints },
									["Mana Leech Amount"] = { t.ManaLeechAmount, t2.manaLeechAmountPoints },	
                                    ["Attack Speed"] = { t.BonusAttackSpeed, t2.bonusAttackSpeed }												
								}
end 

--print(dump(StatSystem.abilitiesTable))
   



function StatSystem.getConfig()
    local t = config
    return t
end

function StatSystem.sendModalWindow(player)
	player:registerEvent("StatSystemModal")
	local modalwindow = ModalWindow(16556, "Stat System",
		"Welcome to stat system, your points balance is " ..
		math.max(0, player:getStorageValue(StatSystem.config.storages.pointsBalance)) .. ".")
	function addThisChoice(player, type, storagex, choiceIds)
		local added = 0
		added = 0
		for i, v in pairs(type) do
			local c = player:getStorageValue(storagex) 
			local d = type[i].Limit * type[i].Gain
			local e = type
			if e[1] and c < e[1].Limit and added < 1 then
				modalwindow:addChoice(choiceIds,
					e[1].Name ..
					" || Price " ..
					e[1].Price .. " || " .. "Gain " .. e[1].Gain .. e[1].Type .. "  || Used " .. c / e[1].Gain .. "/" .. e[1].Limit / e[1].Gain)
				added = added + 1
				return e[1].Price, e[1].Gain, e[1].Limit
			elseif e[2] and c >= e[1].Limit and c < e[2].Limit and added < 1 then
				modalwindow:addChoice(choiceIds,
					e[2].Name ..
					" || Price " ..
					e[2].Price ..
					" || " ..
					"Gain " .. e[2].Gain .. e[2].Type .. "  || Used " .. (c - e[1].Limit) / e[2].Gain .. "/" .. (e[2].Limit - e[1].Limit) / e[2].Gain)
				added = added + 1
				return e[2].Price, e[2].Gain, e[2].Limit
			elseif e[3] and c >= e[2].Limit and c < e[3].Limit and added < 1 then
				modalwindow:addChoice(choiceIds,
					e[3].Name ..
					" || Price " ..
					e[3].Price ..
					" || " ..
					"Gain " .. e[3].Gain .. e[3].Type .. "  || Used " .. (c - e[2].Limit) / e[3].Gain .. "/" .. (e[3].Limit - e[2].Limit) / e[3].Gain)
				added = added + 1
				return e[3].Price, e[3].Gain, e[3].Limit
			elseif e[4] and c >= e[3].Limit and c < e[4].Limit and added < 1 then
				modalwindow:addChoice(choiceIds,
					e[4].Name ..
					" || Price " ..
					e[4].Price ..
					" || " ..
					"Gain " .. e[4].Gain .. e[4].Type .. "  || Used " .. (c - e[3].Limit) / e[4].Gain .. "/" .. (e[4].Limit - e[3].Limit) / e[4].Gain)
				added = added + 1
				return e[4].Price, e[4].Gain, e[4].Limit
			elseif e[5] and c >= e[4].Limit and c < e[5].Limit and added < 1 then
				modalwindow:addChoice(choiceIds,
					e[5].Name ..
					" || Price " ..
					e[5].Price ..
					" || " ..
					"Gain " .. e[5].Gain .. e[5].Type .. "  || Used " .. (c - e[4].Limit) / e[5].Gain .. "/" .. (e[5].Limit - e[4].Limit) / e[5].Gain)
				added = added + 1
				return e[5].Price, e[5].Gain, e[5].Limit
			end
		end
	end

	local a = StatSystem.config.storages
	local b = config
	addThisChoice(player, b.Health, a.healthPoints, 0)
	addThisChoice(player, b.Mana, a.manaPoints, 1)
	addThisChoice(player, b.Attack, a.attackPoints, 2)
	addThisChoice(player, b.ProtectionAll, a.protectionAllPoints, 3)
	addThisChoice(player, b.Healing, a.healingBoostPoints, 4)
	addThisChoice(player, b.Reflection, a.reflectPoints, 5)
	addThisChoice(player, b.Dodge, a.dodgePoints, 6)
	addThisChoice(player, b.Speed, a.speedPoints, 7)
	addThisChoice(player, b.TrappedEnergy, a.trappedEnergyPoints, 8)
	addThisChoice(player, b.ExpRate, a.experienceIncreasePoints, 9)
	addThisChoice(player, b.CriticalChance, a.criticalChancePoints, 10)
	addThisChoice(player, b.CriticalDamage, a.criticalDamagePoints, 11)
	addThisChoice(player, b.LifeLeechChance, a.lifeLeechChancePoints, 12)
	addThisChoice(player, b.LifeLeechAmount, a.lifeLeechAmountPoints, 13)
	addThisChoice(player, b.ManaLeechChance, a.manaLeechChancePoints, 14)
	addThisChoice(player, b.ManaLeechAmount, a.manaLeechAmountPoints, 15)
	addThisChoice(player, b.BonusAttackSpeed, a.bonusAttackSpeed, 16)
	modalwindow:addButton(5, "Confirm x50")
	modalwindow:addButton(4, "Confirm x10")
	modalwindow:addButton(3, "Confirm x5")
	modalwindow:addButton(0, "Use")
	modalwindow:addButton(1, "Reset")
	modalwindow:addButton(2, "Cancel")
	modalwindow:setDefaultEnterButton(0)
	modalwindow:setDefaultEscapeButton(2)
	modalwindow:sendToPlayer(player)
end

function Player.resetStatSystemStorages(player)
	local speed = player:getStorageValue(StatSystem.config.storages.speedPoints)
	-- reset all points
	local spentPoints = math.max(0, player:getStorageValue(StatSystem.config.storages.healthPoints)) +
		 math.max(0, player:getStorageValue(StatSystem.config.storages.manaPoints)) +
		 math.max(0, player:getStorageValue(StatSystem.config.storages.attackPoints)) +
		 math.max(0, player:getStorageValue(StatSystem.config.storages.protectionAllPoints)) +
		 math.max(0, player:getStorageValue(StatSystem.config.storages.healingBoostPoints)) +
		 math.max(0, player:getStorageValue(StatSystem.config.storages.reflectPoints)) +
		 math.max(0, player:getStorageValue(StatSystem.config.storages.dodgePoints)) +
		 math.max(0, player:getStorageValue(StatSystem.config.storages.speedPoints)) +
		 math.max(0, player:getStorageValue(StatSystem.config.storages.trappedEnergyPoints)) +
		 math.max(0, player:getStorageValue(StatSystem.config.storages.experienceIncreasePoints)) +
		 math.max(0, player:getStorageValue(StatSystem.config.storages.criticalChancePoints)) +
		 math.max(0, player:getStorageValue(StatSystem.config.storages.criticalDamagePoints)) +
		 math.max(0, player:getStorageValue(StatSystem.config.storages.lifeLeechChancePoints)) +
		 math.max(0, player:getStorageValue(StatSystem.config.storages.lifeLeechAmountPoints)) +
		 math.max(0, player:getStorageValue(StatSystem.config.storages.manaLeechChancePoints)) +
		 math.max(0, player:getStorageValue(StatSystem.config.storages.manaLeechAmountPoints)) +
		 math.max(0, player:getStorageValue(StatSystem.config.storages.bonusAttackSpeed))
	if spentPoints > 0 then
		player:removeItem(36583, 1)
		player:setMaxHealth(player:getMaxHealth() - player:getBonusHealth() -
		math.max(0, player:getStorageValue(StatSystem.config.storages.addedHealth)))
		player:setMaxMana(player:getMaxMana() - player:getBonusMana() -
		math.max(0, player:getStorageValue(StatSystem.config.storages.addedMana)))
		local outfit = player:getOutfit()
		local addon = outfit.lookAddons
		player:updateHealthAddonBonus(addon)
		player:updateManaAddonBonus(addon)
		if player:getCondition(CONDITION_INFIGHT) == false and
			 not player:getHealth() + player:getExtraHealthAddon() >= player:getMaxHealth() == false then
			player:addHealth(player:getExtraHealthAddon())
		end
		if player:getCondition(CONDITION_INFIGHT) == false and
			 not player:getMana() + player:getExtraManaAddon() >= player:getMaxMana() == false then
			player:addMana(player:getExtraManaAddon())
		end
		player:setStorageValue(StatSystem.config.storages.addedHealth, 0)
		player:setStorageValue(StatSystem.config.storages.addedMana, 0)
		player:setStorageValue(StatSystem.config.storages.healthPoints, 0)
		player:setStorageValue(StatSystem.config.storages.manaPoints, 0)
		player:setStorageValue(StatSystem.config.storages.attackPoints, 0)
		player:setStorageValue(StatSystem.config.storages.protectionAllPoints, 0)
		player:setStorageValue(StatSystem.config.storages.healingBoostPoints, 0)
		player:setStorageValue(StatSystem.config.storages.reflectPoints, 0)
		player:setStorageValue(StatSystem.config.storages.dodgePoints, 0)
		player:setStorageValue(StatSystem.config.storages.speedPoints, 0)
		player:changeSpeed( -speed * 20)
		player:setStorageValue(StatSystem.config.storages.trappedEnergyPoints, 0)
		player:setStorageValue(StatSystem.config.storages.experienceIncreasePoints, 0)
		player:setStorageValue(StatSystem.config.storages.criticalChancePoints, 0)
		player:setStorageValue(StatSystem.config.storages.criticalDamagePoints, 0)
		player:setStorageValue(StatSystem.config.storages.lifeLeechChancePoints, 0)
		player:setStorageValue(StatSystem.config.storages.lifeLeechAmountPoints, 0)
		player:setStorageValue(StatSystem.config.storages.manaLeechChancePoints, 0)
		player:setStorageValue(StatSystem.config.storages.manaLeechAmountPoints, 0)
		player:setStorageValue(StatSystem.config.storages.bonusAttackSpeed, 0)
		StatSystem.addPoints(player, spentPoints)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your stats were succesfully reset, your points were returned.")
	end
end

function StatSystem.answerModal(player, modalId, buttonId, choiceId)
	local a = StatSystem.config.storages
	local b = config
	local gain
	if modalId ~= 16556 then
		return true
	end
	function useThisChoice(player, type, storagex, name, amount)
		local a = StatSystem.config.storages
		local b = config
		local price = select(1, addThisChoice(player, type, storagex))
		local gain = select(2, addThisChoice(player, type, storagex))
		local limit = select(3, addThisChoice(player, type, storagex))
		local points = player:getStorageValue(StatSystem.config.storages.pointsBalance)
		local pstoragex = player:getStorageValue(storagex)

		if price * amount > points then
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have enough points.")
			return false
		end
		if pstoragex + amount > limit then
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can't go pass the grade.")
			return false
		end
		if name == "health" then
			player:setMaxHealth(player:getMaxHealth() - player:getBonusHealth() + gain * amount)
			local outfit = player:getOutfit()
			local addon = outfit.lookAddons
			if player:getCondition(CONDITION_INFIGHT) == false then
				player:addHealth(player:getExtraHealthAddon())
			end
			player:setStorageValue(a.addedHealth, math.max(0, player:getStorageValue(a.addedHealth)) + gain * amount)
		end
		if name == "mana" then
			player:setMaxMana(player:getMaxMana() - player:getBonusMana() + gain * amount)
			local outfit = player:getOutfit()
			local addon = outfit.lookAddons
			if player:getCondition(CONDITION_INFIGHT) == false then
				player:addMana(player:getExtraManaAddon())
			end
			player:setStorageValue(StatSystem.config.storages.addedMana,
				math.max(0, player:getStorageValue(StatSystem.config.storages.addedMana)) + gain * amount)
		end
		if name == "speed" then
			player:changeSpeed(gain * amount * 2)
		end
		StatSystem.addPointToStat(player, name, amount*gain)
		StatSystem.addPoints(player, -price * amount)
		player:getPosition():sendMagicEffect(225)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You added " .. amount * price .. " point to chosen stat.")
		if player:getStorageValue(ToReset) == -1 then
			player:setStorageValue(ToReset, 0)
		end
		player:setStorageValue(ToReset, player:getStorageValue(ToReset) + amount * price)

		if name == "criticalChance" then
			player:addSpecialSkill(0, gain * amount)
		end
		if name == "criticalDamage" then
			player:addSpecialSkill(1, gain * amount)
		end
		if name == "lifeLeechChance" then
			player:addSpecialSkill(2, gain * amount)
		end
		if name == "lifeLeechAmount" then
			player:addSpecialSkill(3, gain * amount)
		end
		if name == "manaLeechChance" then
			player:addSpecialSkill(4, gain * amount)
		end
		if name == "manaLeechAmount" then
			player:addSpecialSkill(5, gain * amount)
		end
		return true
		--[[ SPECIALSKILL_CRITICALHITCHANCE,
	SPECIALSKILL_CRITICALHITAMOUNT,
	SPECIALSKILL_LIFELEECHCHANCE,
	SPECIALSKILL_LIFELEECHAMOUNT,
	SPECIALSKILL_MANALEECHCHANCE,
	SPECIALSKILL_MANALEECHAMOUNT, --]]
	end

	if buttonId == 0 then
		if choiceId == 0 then
			useThisChoice(player, b.Health, a.healthPoints, "health", 1)
		elseif choiceId == 1 then
			useThisChoice(player, b.Mana, a.manaPoints, "mana", 1)
		elseif choiceId == 2 then
			useThisChoice(player, b.Attack, a.attackPoints, "attack", 1)
		elseif choiceId == 3 then
			useThisChoice(player, b.ProtectionAll, a.protectionAllPoints, "protectionAll", 1)
		elseif choiceId == 4 then
			useThisChoice(player, b.Healing, a.healingBoostPoints, "healingBoost", 1)
		elseif choiceId == 5 then
			useThisChoice(player, b.Reflection, a.reflectPoints, "reflect", 1)
		elseif choiceId == 6 then
			useThisChoice(player, b.Dodge, a.dodgePoints, "dodge", 1)
		elseif choiceId == 7 then
			useThisChoice(player, b.Speed, a.speedPoints, "speed", 1)
		elseif choiceId == 8 then
			useThisChoice(player, b.TrappedEnergy, a.trappedEnergyPoints, "trappedEnergy", 1)
		elseif choiceId == 9 then
			useThisChoice(player, b.ExpRate, a.experienceIncreasePoints, "expGain", 1)
		elseif choiceId == 10 then
			useThisChoice(player, b.CriticalChance, a.criticalChancePoints, "criticalChance", 1)
		elseif choiceId == 11 then
			useThisChoice(player, b.CriticalDamage, a.criticalDamagePoints, "criticalDamage", 1)
		elseif choiceId == 12 then
			useThisChoice(player, b.LifeLeechChance, a.lifeLeechChancePoints, "lifeLeechChance", 1)
		elseif choiceId == 13 then
			useThisChoice(player, b.LifeLeechAmount, a.lifeLeechAmountPoints, "lifeLeechAmount", 1)
		elseif choiceId == 14 then
			useThisChoice(player, b.ManaLeechChance, a.manaLeechChancePoints, "manaLeechChance", 1)
		elseif choiceId == 15 then
			useThisChoice(player, b.ManaLeechAmount, a.manaLeechAmountPoints, "manaLeechAmount", 1)
		elseif choiceId == 16 then
			useThisChoice(player, b.BonusAttackSpeed, a.bonusAttackSpeed, "bonusAttackSpeed", 1)
		end
	elseif buttonId == 3 then
		if choiceId == 0 then
			useThisChoice(player, b.Health, a.healthPoints, "health", 5)
		elseif choiceId == 1 then
			useThisChoice(player, b.Mana, a.manaPoints, "mana", 5)
		elseif choiceId == 2 then
			useThisChoice(player, b.Attack, a.attackPoints, "attack", 5)
		elseif choiceId == 3 then
			useThisChoice(player, b.ProtectionAll, a.protectionAllPoints, "protectionAll", 5)
		elseif choiceId == 4 then
			useThisChoice(player, b.Healing, a.healingBoostPoints, "healingBoost", 5)
		elseif choiceId == 5 then
			useThisChoice(player, b.Reflection, a.reflectPoints, "reflect", 5)
		elseif choiceId == 6 then
			useThisChoice(player, b.Dodge, a.dodgePoints, "dodge", 5)
		elseif choiceId == 7 then
			useThisChoice(player, b.Speed, a.speedPoints, "speed", 5)
		elseif choiceId == 8 then
			useThisChoice(player, b.TrappedEnergy, a.trappedEnergyPoints, "trappedEnergy", 5)
		elseif choiceId == 9 then
			useThisChoice(player, b.ExpRate, a.experienceIncreasePoints, "expGain", 5)
		elseif choiceId == 10 then
			useThisChoice(player, b.CriticalChance, a.criticalChancePoints, "criticalChance", 5)
		elseif choiceId == 11 then
			useThisChoice(player, b.CriticalDamage, a.criticalDamagePoints, "criticalDamage", 5)
		elseif choiceId == 12 then
			useThisChoice(player, b.LifeLeechChance, a.lifeLeechChancePoints, "lifeLeechChance", 5)
		elseif choiceId == 13 then
			useThisChoice(player, b.LifeLeechAmount, a.lifeLeechAmountPoints, "lifeLeechAmount", 5)
		elseif choiceId == 14 then
			useThisChoice(player, b.ManaLeechChance, a.manaLeechChancePoints, "manaLeechChance", 5)
		elseif choiceId == 15 then
			useThisChoice(player, b.ManaLeechAmount, a.manaLeechAmountPoints, "manaLeechAmount", 5)
		elseif choiceId == 16 then
			useThisChoice(player, b.BonusAttackSpeed, a.bonusAttackSpeed, "bonusAttackSpeed", 5)
		end
	elseif buttonId == 4 then
		if choiceId == 0 then
			useThisChoice(player, b.Health, a.healthPoints, "health", 10)
		elseif choiceId == 1 then
			useThisChoice(player, b.Mana, a.manaPoints, "mana", 10)
		elseif choiceId == 2 then
			useThisChoice(player, b.Attack, a.attackPoints, "attack", 10)
		elseif choiceId == 3 then
			useThisChoice(player, b.ProtectionAll, a.protectionAllPoints, "protectionAll", 10)
		elseif choiceId == 4 then
			useThisChoice(player, b.Healing, a.healingBoostPoints, "healingBoost", 10)
		elseif choiceId == 5 then
			useThisChoice(player, b.Reflection, a.reflectPoints, "reflect", 10)
		elseif choiceId == 6 then
			useThisChoice(player, b.Dodge, a.dodgePoints, "dodge", 10)
		elseif choiceId == 7 then
			useThisChoice(player, b.Speed, a.speedPoints, "speed", 10)
		elseif choiceId == 8 then
			useThisChoice(player, b.TrappedEnergy, a.trappedEnergyPoints, "trappedEnergy", 10)
		elseif choiceId == 9 then
			useThisChoice(player, b.ExpRate, a.experienceIncreasePoints, "expGain", 10)
		elseif choiceId == 10 then
			useThisChoice(player, b.CriticalChance, a.criticalChancePoints, "criticalChance", 10)
		elseif choiceId == 11 then
			useThisChoice(player, b.CriticalDamage, a.criticalDamagePoints, "criticalDamage", 10)
		elseif choiceId == 12 then
			useThisChoice(player, b.LifeLeechChance, a.lifeLeechChancePoints, "lifeLeechChance", 10)
		elseif choiceId == 13 then
			useThisChoice(player, b.LifeLeechAmount, a.lifeLeechAmountPoints, "lifeLeechAmount", 10)
		elseif choiceId == 14 then
			useThisChoice(player, b.ManaLeechChance, a.manaLeechChancePoints, "manaLeechChance", 10)
		elseif choiceId == 15 then
			useThisChoice(player, b.ManaLeechAmount, a.manaLeechAmountPoints, "manaLeechAmount", 10)
		elseif choiceId == 16 then
			useThisChoice(player, b.BonusAttackSpeed, a.bonusAttackSpeed, "bonusAttackSpeed", 10)
		end
	elseif buttonId == 5 then
		--[[ if player then
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "Confirm all is disabled right now.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
		end --]]
		if choiceId == 0 then
			useThisChoice(player, b.Health, a.healthPoints, "health", 50)
		elseif choiceId == 1 then
			useThisChoice(player, b.Mana, a.manaPoints, "mana", 50)
		elseif choiceId == 2 then
			useThisChoice(player, b.Attack, a.attackPoints, "attack", 50)
		elseif choiceId == 3 then
			useThisChoice(player, b.ProtectionAll, a.protection50, "protectionAll", 50)
		elseif choiceId == 4 then
			useThisChoice(player, b.Healing, a.healingBoostPoints, "healingBoost", 50)
		elseif choiceId == 5 then
			useThisChoice(player, b.Reflection, a.reflectPoints, "reflect", 50)
		elseif choiceId == 6 then
			useThisChoice(player, b.Dodge, a.dodgePoints, "dodge", 50)
		elseif choiceId == 7 then
			useThisChoice(player, b.Speed, a.speedPoints, "speed", 50)
		elseif choiceId == 8 then
			useThisChoice(player, b.TrappedEnergy, a.trappedEnergyPoints, "trappedEnergy", 50)
		elseif choiceId == 9 then
			useThisChoice(player, b.ExpRate, a.experienceIncreasePoints, "expGain", 50)
		elseif choiceId == 10 then
			useThisChoice(player, b.CriticalChance, a.criticalChancePoints, "criticalChance", 50)
		elseif choiceId == 11 then
			useThisChoice(player, b.CriticalDamage, a.criticalDamagePoints, "criticalDamage", 50)
		elseif choiceId == 12 then
			useThisChoice(player, b.LifeLeechChance, a.lifeLeechChancePoints, "lifeLeechChance", 50)
		elseif choiceId == 13 then
			useThisChoice(player, b.LifeLeechAmount, a.lifeLeechAmountPoints, "lifeLeechAmount", 50)
		elseif choiceId == 14 then
			useThisChoice(player, b.ManaLeechChance, a.manaLeechChancePoints, "manaLeechChance", 50)
		elseif choiceId == 15 then
			useThisChoice(player, b.ManaLeechAmount, a.manaLeechAmountPoints, "manaLeechAmount", 50)
		elseif choiceId == 16 then
			useThisChoice(player, b.BonusAttackSpeed, a.bonusAttackSpeed, "bonusAttackSpeed", 50)
		end
	elseif buttonId == 1 then
		local speed = player:getStorageValue(StatSystem.config.storages.speedPoints)
		local spentPoints = player:getStorageValue(ToReset)
		
		local window = ModalWindow {
			title = 'Reset Points',
			message = 'To reset your points you need a reset bottle, are you sure that you want to use it to reset your points ?'
		}
		window:addButton('Yes',
			function(button, choice)
				if spentPoints > 0 and player:getItemCount(28632) > 0 then-- 0 and player:removeItem(28632, 1) then
					if spentPoints > 0 then
					
					    if not player:removeItem(28632, 1) then
	                       return true
	                    end
					
					
					
						player:setStorageValue(ToReset, 0)
						--player:removeItem(36583, 1)
						player:setMaxHealth(player:getMaxHealth() - player:getBonusHealth() -
						math.max(0, player:getStorageValue(StatSystem.config.storages.addedHealth)))
						player:setMaxMana(player:getMaxMana() - player:getBonusMana() -
						math.max(0, player:getStorageValue(StatSystem.config.storages.addedMana)))
						local outfit = player:getOutfit()
						local addon = outfit.lookAddons
						player:updateHealthAddonBonus(addon)
						player:updateManaAddonBonus(addon)
						if player:getCondition(CONDITION_INFIGHT) == false and
							 not player:getHealth() + player:getExtraHealthAddon() >= player:getMaxHealth() == false then
							player:addHealth(player:getExtraHealthAddon())
						end
						if player:getCondition(CONDITION_INFIGHT) == false and
							 not player:getMana() + player:getExtraManaAddon() >= player:getMaxMana() == false then
							player:addMana(player:getExtraManaAddon())
						end
						player:setStorageValue(StatSystem.config.storages.addedHealth, 0)
						player:setStorageValue(StatSystem.config.storages.addedMana, 0)
						player:setStorageValue(StatSystem.config.storages.healthPoints, 0)
						player:setStorageValue(StatSystem.config.storages.manaPoints, 0)
						player:setStorageValue(StatSystem.config.storages.attackPoints, 0)
						player:setStorageValue(StatSystem.config.storages.protectionAllPoints, 0)
						player:setStorageValue(StatSystem.config.storages.healingBoostPoints, 0)
						player:setStorageValue(StatSystem.config.storages.reflectPoints, 0)
						player:setStorageValue(StatSystem.config.storages.dodgePoints, 0)
						player:setStorageValue(StatSystem.config.storages.speedPoints, 0)
						player:changeSpeed( -speed * 20)
						
						player:setStorageValue(StatSystem.config.storages.trappedEnergyPoints, 0)
						player:setStorageValue(StatSystem.config.storages.experienceIncreasePoints, 0)
						player:setStorageValue(StatSystem.config.storages.criticalChancePoints, 0)
						player:setStorageValue(StatSystem.config.storages.criticalDamagePoints, 0)
						player:setStorageValue(StatSystem.config.storages.lifeLeechChancePoints, 0)
						player:setStorageValue(StatSystem.config.storages.lifeLeechAmountPoints, 0)
						player:setStorageValue(StatSystem.config.storages.manaLeechChancePoints, 0)
						player:setStorageValue(StatSystem.config.storages.manaLeechAmountPoints, 0)
						player:setStorageValue(StatSystem.config.storages.bonusAttackSpeed, 0)
						StatSystem.addPoints(player, spentPoints)
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
							"Your stats were succesfully reset, your points were returned.")
					else
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "There is no stats to reset.")
					end
				else
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You dont have the item or points to reset")
					player:SME(CONST_ME_POFF)
				end
			end
		)
		window:setDefaultEnterButton('Yes')
		window:addButton('No')
		window:setDefaultEscapeButton('No')
		window:sendToPlayer(player)
		player:unregisterEvent("StatSystemModal")
	end
	return true
end

function StatSystem.addPointToStat(player, statType, value)
	if statType == "health" or statType == "Health" then
		player:setStorageValue(StatSystem.config.storages.healthPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.healthPoints)) + value)
	elseif statType == "mana" or statType == "Mana" then
		player:setStorageValue(StatSystem.config.storages.manaPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.manaPoints)) + value)
	elseif statType == "attack" or statType == "Attack" then
		player:setStorageValue(StatSystem.config.storages.attackPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.attackPoints)) + value)
	elseif statType == "protectionAll" or statType == "Protection All" or statType == "protection all" then
		player:setStorageValue(StatSystem.config.storages.protectionAllPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.protectionAllPoints)) + value)
	elseif statType == "healingBoost" or statType == "Healing" or statType == "healing" then
		player:setStorageValue(StatSystem.config.storages.healingBoostPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.healingBoostPoints)) + value)
	elseif statType == "reflect" or statType == "Reflect" then
		player:setStorageValue(StatSystem.config.storages.reflectPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.reflectPoints)) + value)
	elseif statType == "dodge" or statType == "Dodge" then
		player:setStorageValue(StatSystem.config.storages.dodgePoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.dodgePoints)) + value)
	elseif statType == "speed" or statType == "Speed" then
		player:setStorageValue(StatSystem.config.storages.speedPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.speedPoints)) + value)
	elseif statType == "trappedEnergy" or statType == "Trapped Energy" or statType == "trapped energy" then
		player:setStorageValue(StatSystem.config.storages.trappedEnergyPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.trappedEnergyPoints)) + value)
	elseif statType == "expGain" or statType == "Experience Gain" or statType == "experience gain" then
		player:setStorageValue(StatSystem.config.storages.experienceIncreasePoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.experienceIncreasePoints)) + value)
	elseif statType == "criticalChance" or statType == "Critical Chance" or statType == "critical chance" then
		player:setStorageValue(StatSystem.config.storages.criticalChancePoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.criticalChancePoints)) + value)
	elseif statType == "criticalDamage" or statType == "Critical Damage" or statType == "critical damage" then
		player:setStorageValue(StatSystem.config.storages.criticalDamagePoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.criticalDamagePoints)) + value)
	elseif statType == "lifeLeechChance" or statType == "Life Leech Chance" or statType == "life leech chance" then
		player:setStorageValue(StatSystem.config.storages.lifeLeechChancePoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.lifeLeechChancePoints)) + value)
	elseif statType == "lifeLeechAmount" or statType == "Life Leech Amount" or statType == "life leech amount" then
		player:setStorageValue(StatSystem.config.storages.lifeLeechAmountPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.lifeLeechAmountPoints)) + value)
	elseif statType == "manaLeechChance" or statType == "Mana Leech Chance" or statType == "mana leech chance" then
		player:setStorageValue(StatSystem.config.storages.manaLeechChancePoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.manaLeechChancePoints)) + value)
	elseif statType == "manaLeechAmount" or statType == "Mana Leech Amount" or statType == "mana leech amount" then
		player:setStorageValue(StatSystem.config.storages.manaLeechAmountPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.manaLeechAmountPoints)) + value)
	elseif statType == "bonusAttackSpeed" or statType == "Attack Speed" or statType == "attack speed" then
		player:setStorageValue(StatSystem.config.storages.bonusAttackSpeed,
			math.max(0, player:getStorageValue(StatSystem.config.storages.bonusAttackSpeed)) + value)
	end
	return true
end

function StatSystem.removePointFromStat(player, statType, value)
	if statType == "health" then
		player:setStorageValue(StatSystem.config.storages.healthPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.healthPoints)) - value)
	elseif statType == "mana" then
		player:setStorageValue(StatSystem.config.storages.manaPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.manaPoints)) - value)
	elseif statType == "attack" then
		player:setStorageValue(StatSystem.config.storages.attackPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.attackPoints)) - value)
	elseif statType == "protectionAll" then
		player:setStorageValue(StatSystem.config.storages.protectionAllPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.protectionAllPoints)) - value)
	elseif statType == "healingBoostPoints" then
		player:setStorageValue(StatSystem.config.storages.healingBoostPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.healingBoostPoints)) - value)
	elseif statType == "reflect" then
		player:setStorageValue(StatSystem.config.storages.reflectPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.reflectPoints)) - value)
	elseif statType == "dodge" then
		player:setStorageValue(StatSystem.config.storages.dodgePoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.dodgePoints)) - value)
	elseif statType == "speed" then
		player:setStorageValue(StatSystem.config.storages.speedPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.speedPoints)) - value)
	elseif statType == "trappedEnergy" then
		player:setStorageValue(StatSystem.config.storages.trappedEnergyPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.trappedEnergyPoints)) - value)
	elseif statType == "expGain" then
		player:setStorageValue(StatSystem.config.storages.experienceIncreasePoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.experienceIncreasePoints)) - value)
	elseif statType == "criticalChance" then
		player:setStorageValue(StatSystem.config.storages.criticalChancePoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.criticalChancePoints)) - value)
	elseif statType == "criticalDamage" then
		player:setStorageValue(StatSystem.config.storages.criticalDamagePoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.criticalDamagePoints)) - value)
	elseif statType == "lifeLeechChance" then
		player:setStorageValue(StatSystem.config.storages.lifeLeechChancePoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.lifeLeechChancePoints)) - value)
	elseif statType == "lifeLeechAmount" then
		player:setStorageValue(StatSystem.config.storages.lifeLeechAmountPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.lifeLeechAmountPoints)) - value)
	elseif statType == "manaLeechChance" then
		player:setStorageValue(StatSystem.config.storages.manaLeechChancePoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.manaLeechChancePoints)) - value)
	elseif statType == "manaLeechAmount" then
		player:setStorageValue(StatSystem.config.storages.manaLeechAmountPoints,
			math.max(0, player:getStorageValue(StatSystem.config.storages.manaLeechAmountPoints)) - value)
	elseif statType == "bonusAttackSpeed" then
		player:setStorageValue(StatSystem.config.storages.bonusAttackSpeed,
			math.max(0, player:getStorageValue(StatSystem.config.storages.bonusAttackSpeed)) - value)
	end
	return true
end

function Player.protectionAllStatsBonus(player)
	local value = 0
	local storage = player:getStorageValue(StatSystem.config.storages.protectionAllPoints)
	if storage > 0 then
		value = storage
	end
	value = value + (ADD_STATS_POINT_SYSTEM:getTalent(player, "Protection All") / 100)
	return value
end

function Player.trappedEnergyAllStatsBonus(player)
    local value = 0
	local storage = player:getStorageValue(StatSystem.config.storages.trappedEnergyPoints)
	if storage > 0 then
	   value = storage
	end
	value = value + (ADD_STATS_POINT_SYSTEM:getTalent(player, "Trapped Energy") / 100)
	return value
end

function Player.healingBoostStatsBonus(player)
	local value = 0
	local storage = player:getStorageValue(StatSystem.config.storages.healingBoostPoints)
	if storage > 0 then
		value = storage
	end
	value = value + (ADD_STATS_POINT_SYSTEM:getTalent(player, "Healing") / 100)
	return value
end

function Player.reflectStatsBonus(player)
	local value = 0
	local storage = player:getStorageValue(StatSystem.config.storages.reflectPoints)
	if storage > 0 then
		value = storage
	end
	
	value = value + (ADD_STATS_POINT_SYSTEM:getTalent(player, "Reflect") / 100)
	return value
end

function Player.dodgeStatsBonus(player)
	local value = 0
	local storage = player:getStorageValue(StatSystem.config.storages.dodgePoints)
	if storage > 0 then
		value = storage
	end
	value = value + (ADD_STATS_POINT_SYSTEM:getTalent(player, "Dodge") / 100)
	return value
end

function Player.speedStatsBonus(player)
	local value = 0
	local storage = player:getStorageValue(StatSystem.config.storages.speedPoints) * 20
	if storage > 0 then
		value = storage
	end
	value = value + (ADD_STATS_POINT_SYSTEM:getTalent(player, "Speed") / 100)
	return value
end

function Player.statsExpBonus(player)
	local value = 0
	local storage = player:getStorageValue(StatSystem.config.storages.experienceIncreasePoints) / 100
	if storage > 0 then
	   value = storage
	end
	
	
	local talent = ADD_STATS_POINT_SYSTEM:getTalent(player, "Experience Gain") / 100
	if talent > 0 then
	   value = value + talent
	end
	return value
end

local ec = EventCallback

function ec.onGainExperience(self, source, exp, rawExp)
	if self:statsExpBonus() > 0 then
		exp = exp + (exp * self:statsExpBonus())
	end
	--exp = exp + (exp * ADD_STATS_POINT_SYSTEM:getTalent(player, "Experience Gain"))
	return exp
end

ec:register(3)

function StatSystem.addPoints(player, value)
	player:setStorageValue(StatSystem.config.storages.pointsBalance,
		math.max(0, player:getStorageValue(StatSystem.config.storages.pointsBalance)) + value)
	return true
end

local creatureevent = CreatureEvent("onAdvanceLevelStats")
function creatureevent.onAdvance(player, skill, oldLevel, newLevel)
	if skill ~= SKILL_LEVEL or newLevel <= oldLevel then
		return true
	end

	StatSystem.onAdvanceLevel(player, oldLevel, newLevel)
	return true
end

creatureevent:register()

local creatureevent = CreatureEvent("statsSystem_onHealthChange")
function creatureevent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if not creature or not attacker or not attacker:isPlayer() then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	
	local bonus = ABILITY_SYSTEM:getBonusDamage(attacker)
	if bonus > 0 then
	    bonus = bonus / 100
	    primaryDamage = primaryDamage + (primaryDamage * bonus)
	end
	-- local toAddHere = 0
	-- if attacker:getItemsBonusDamage() then
	   -- toAddHere = attacker:getItemsBonusDamage()
	-- end

	-- local attackDamage = math.max(0, attacker:getStorageValue(StatSystem.config.storages.attackPoints)) + toAddHere
	-- if attackDamage > 0 then
	   -- primaryDamage = primaryDamage + primaryDamage * attackDamage / 100
	-- end

	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

creatureevent:register()

creaturescript = CreatureEvent("statSystem_ModalWindow")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId)
	StatSystem.answerModal(player, modalWindowId, buttonId, choiceId)
	return true
end

creaturescript:register()

local talk = TalkAction("/points", "!points")
function talk.onSay(player, words, param)
	StatSystem.sendModalWindow(player)
	return false
end

talk:register()

creaturescript = CreatureEvent("statSystem_onLogin")
function creaturescript.onLogin(player)
	if player:getStorageValue(10014) > 0 then
		player:addSpecialSkill(0, player:getStorageValue(10014))
	end
	if player:getStorageValue(10015) > 0 then
		player:addSpecialSkill(1, player:getStorageValue(10015))
	end
	if player:getStorageValue(10016) > 0 then
		player:addSpecialSkill(2, player:getStorageValue(10016))
	end
	if player:getStorageValue(10017) > 0 then
		player:addSpecialSkill(3, player:getStorageValue(10017))
	end
	if player:getStorageValue(10018) > 0 then
		player:addSpecialSkill(4, player:getStorageValue(10018))
	end
	if player:getStorageValue(10019) > 0 then
		player:addSpecialSkill(5, player:getStorageValue(10019))
	end
	-- for _, storages in pairs(StatSystem.config.storages) do
		-- if player:getStorageValue(storages) < 0 then
			-- player:setStorageValue(storages, 0)
		-- end
	-- end
	player:registerEvent("onAdvanceLevelStats")
	player:registerEvent("statSystem_ModalWindow")
	player:registerEvent("statsSystem_onHealthChange")
	return true
end

creaturescript:register()
