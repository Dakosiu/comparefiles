function Player.canUseFromGround(self, item)

    for i = 1, 11 do
	    local item2 = self:getSlotItem(i)
		if item2 then
		   if item2 == item then
		      return true
		   end
		end
	end
	

    local container = self:getSlotItem(CONST_SLOT_BACKPACK)
	
    local containers = {}
	
	local items = {}
	if container and container:isContainer() then
        table.insert(containers, container)
    end
    while #containers > 0 do
		for i = (containers[1]:getSize() - 1), 0, -1 do
			local it = containers[1]:getItem(i)
			if it.uid == item.uid then
			   return true
			end
			if it:isContainer() then
                table.insert(containers, it)
			else
			    table.insert(items, it.uid)
            end
        end
        table.remove(containers, 1)
    end
	
	if not isInArray(items, item.uid) then
	   return false
	end
	
    return true
end

local foodCondition = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)

function Player.feed(self, food)
	local condition = self:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	if condition then
		condition:setTicks(condition:getTicks() + (food * 1000))
	else
		local vocation = self:getVocation()
		if not vocation then
			return nil
		end

		foodCondition:setTicks(food * 1000)
		foodCondition:setParameter(CONDITION_PARAM_HEALTHGAIN, vocation:getHealthGainAmount())
		foodCondition:setParameter(CONDITION_PARAM_HEALTHTICKS, vocation:getHealthGainTicks() * 1000)
		foodCondition:setParameter(CONDITION_PARAM_MANAGAIN, vocation:getManaGainAmount())
		foodCondition:setParameter(CONDITION_PARAM_MANATICKS, vocation:getManaGainTicks() * 1000)

		self:addCondition(foodCondition)
	end
	return true
end

function Player.getClosestFreePosition(self, position, extended)
	if self:getGroup():getAccess() and self:getAccountType() >= ACCOUNT_TYPE_GOD then
		return position
	end
	return Creature.getClosestFreePosition(self, position, extended)
end

function Player.getDepotItems(self, depotId)
	return self:getDepotChest(depotId, true):getItemHoldingCount()
end

function Player.hasFlag(self, flag)
	return self:getGroup():hasFlag(flag)
end

function Player.getLossPercent(self) --LossPercent%
	local lossPercentValue = 0
	if self:hasBlessing(1) then
		lossPercentValue = lossPercentValue + 5 -- 5
	end
	if self:hasBlessing(2) then
		lossPercentValue = lossPercentValue + 5 -- 5
	end
	if self:hasBlessing(3) then
		lossPercentValue = lossPercentValue + 5 -- 5
	end
	if self:hasBlessing(4) then
		lossPercentValue = lossPercentValue + 5 -- 10
	end
	if self:hasBlessing(5) then
		lossPercentValue = lossPercentValue + 5 -- 10
	end
	if self:hasBlessing(6) then
		lossPercentValue = lossPercentValue + 5 -- 10
	end

	if self:getProtecLossItems() > 0 then
		lossPercentValue = lossPercentValue + self:getProtecLossItems() -- 10
	end
	local lossPercent = 100 - lossPercentValue
	return lossPercentValue, lossPercent
end

function Player:getWeaponType()
	local weapon = self:getSlotItem(CONST_SLOT_RIGHT)
	if (weapon) then
		return ItemType(weapon:getId()):getWeaponType()
	end
	return WEAPON_NONE
end

function Player.moveSlotToBackpack(self, slot)
	if slot == CONST_SLOT_BACKPACK then
		return false
	end
	local item = self:getSlotItem(slot)
	if item then
		local backpack = self:getSlotItem(CONST_SLOT_BACKPACK)
		if backpack then
			return item:moveTo(backpack)
		end
	end
	return false
end

function Player.getPremiumTime(self)
	return math.max(0, self:getPremiumEndsAt() - os.time())
end

function Player.setPremiumTime(self, seconds)
	self:setPremiumEndsAt(os.time() + seconds)
	return true
end

function Player.addPremiumTime(self, seconds)
	self:setPremiumTime(self:getPremiumTime() + seconds)
	return true
end

function Player.removePremiumTime(self, seconds)
	local currentTime = self:getPremiumTime()
	if currentTime < seconds then
		return false
	end

	self:setPremiumTime(currentTime - seconds)
	return true
end

function Player.getPremiumDays(self)
	return math.floor(self:getPremiumTime() / 86400)
end

function Player.addPremiumDays(self, days)
	return self:addPremiumTime(days * 86400)
end

function Player.removePremiumDays(self, days)
	return self:removePremiumTime(days * 86400)
end

function Player.isPremium(self)
	return self:getPremiumTime() > 0 or configManager.getBoolean(configKeys.FREE_PREMIUM) or
		 self:hasFlag(PlayerFlag_IsAlwaysPremium)
end

function Player.sendCancelMessage(self, message)
	if type(message) == "number" then
		message = Game.getReturnMessage(message)
	end
	return self:sendTextMessage(MESSAGE_STATUS_SMALL, message)
end

function Player.isUsingOtClient(self)
	return self:getClient().os >= CLIENTOS_OTCLIENT_LINUX
end

function Player.sendExtendedOpcode(self, opcode, buffer)
	if not self:isUsingOtClient() then
		return false
	end

	local networkMessage = NetworkMessage()
	networkMessage:addByte(0x32)
	networkMessage:addByte(opcode)
	networkMessage:addString(buffer)
	networkMessage:sendToPlayer(self)
	networkMessage:delete()
	return true
end

function Player.sendExtendedJSONOpcode(self, opcode, json_data)
	if not self:isUsingOtClient() then
		return false
	end

	local buffer = json.encode(json_data)

	local networkMessage = NetworkMessage()
	networkMessage:addByte(0x32)
	networkMessage:addByte(opcode)
	networkMessage:addString(buffer)
	networkMessage:sendToPlayer(self)
	networkMessage:delete()

	return true
end

APPLY_SKILL_MULTIPLIER = true
local addSkillTriesFunc = Player.addSkillTries
function Player.addSkillTries(...)
	APPLY_SKILL_MULTIPLIER = false
	local ret = addSkillTriesFunc(...)
	APPLY_SKILL_MULTIPLIER = true
	return ret
end

local addManaSpentFunc = Player.addManaSpent
function Player.addManaSpent(...)
	APPLY_SKILL_MULTIPLIER = false
	local ret = addManaSpentFunc(...)
	APPLY_SKILL_MULTIPLIER = true
	return ret
end

-- Always pass the number through the isValidMoney function first before using the transferMoneyTo
function Player.transferMoneyTo(self, target, amount)
	if not target then
		return false
	end

	-- See if you can afford this transfer
	local balance = self:getBankBalance()
	if amount > balance then
		return false
	end

	-- See if player is online
	local targetPlayer = Player(target.guid)
	if targetPlayer then
		targetPlayer:setBankBalance(targetPlayer:getBankBalance() + amount)
	else
		db.query("UPDATE `players` SET `balance` = `balance` + " .. amount .. " WHERE `id` = '" .. target.guid .. "'")
	end

	self:setBankBalance(self:getBankBalance() - amount)
	return true
end

function Player.canCarryMoney(self, amount)
	-- Anyone can carry as much imaginary money as they desire
	if amount == 0 then
		return true
	end

	-- The 3 below loops will populate these local variables
	local totalWeight = 0
	local inventorySlots = 0

	-- Add amber coins to totalWeight and inventorySlots
	local type_amber = ItemType(ITEM_AMBER_COIN)
	local amberCoins = math.floor(amount / 1000000)
	if amberCoins > 0 then
		amount = amount - (amberCoins * 1000000)
		while amberCoins > 0 do
			local count = math.min(100, amberCoins)
			totalWeight = totalWeight + type_amber:getWeight(count)
			amberCoins = amberCoins - count
			inventorySlots = inventorySlots + 1
		end
	end

	-- Add crystal coins to totalWeight and inventorySlots
	local type_crystal = ItemType(ITEM_CRYSTAL_COIN)
	local crystalCoins = math.floor(amount / 10000)
	if crystalCoins > 0 then
		amount = amount - (crystalCoins * 10000)
		while crystalCoins > 0 do
			local count = math.min(100, crystalCoins)
			totalWeight = totalWeight + type_crystal:getWeight(count)
			crystalCoins = crystalCoins - count
			inventorySlots = inventorySlots + 1
		end
	end

	-- Add platinum coins to totalWeight and inventorySlots
	local type_platinum = ItemType(ITEM_PLATINUM_COIN)
	local platinumCoins = math.floor(amount / 100)
	if platinumCoins > 0 then
		amount = amount - (platinumCoins * 100)
		while platinumCoins > 0 do
			local count = math.min(100, platinumCoins)
			totalWeight = totalWeight + type_platinum:getWeight(count)
			platinumCoins = platinumCoins - count
			inventorySlots = inventorySlots + 1
		end
	end

	-- Add gold coins to totalWeight and inventorySlots
	local type_gold = ItemType(ITEM_GOLD_COIN)
	if amount > 0 then
		while amount > 0 do
			local count = math.min(100, amount)
			totalWeight = totalWeight + type_gold:getWeight(count)
			amount = amount - count
			inventorySlots = inventorySlots + 1
		end
	end

	-- If player don't have enough capacity to carry this money
	if self:getFreeCapacity() < totalWeight then
		return false
	end

	-- If player don't have enough available inventory slots to carry this money
	local backpack = self:getSlotItem(CONST_SLOT_BACKPACK)
	if not backpack or backpack:getEmptySlots(true) < inventorySlots then
		return false
	end
	return true
end

function Player.withdrawMoney(self, amount)
	local balance = self:getBankBalance()
	if amount > balance or not self:addMoney(amount) then
		return false
	end

	self:setBankBalance(balance - amount)
	return true
end

function Player.depositMoney(self, amount)
	if not self:removeMoney(amount) then
		return false
	end

	self:setBankBalance(self:getBankBalance() + amount)
	return true
end

function Player.removeTotalMoney(self, amount)
	local moneyCount = self:getMoney()
	local bankCount = self:getBankBalance()
	if amount <= moneyCount then
		self:removeMoney(amount)
		return true
	elseif amount <= (moneyCount + bankCount) then
		if moneyCount ~= 0 then
			self:removeMoney(moneyCount)
			local remains = amount - moneyCount
			self:setBankBalance(bankCount - remains)
			self:sendTextMessage(MESSAGE_INFO_DESCR,
				("Paid %d from inventory and %d gold from bank account. Your account balance is now %d gold."):format(moneyCount,
					amount - moneyCount, self:getBankBalance()))
			return true
		else
			self:setBankBalance(bankCount - amount)
			self:sendTextMessage(MESSAGE_INFO_DESCR,
				("Paid %d gold from bank account. Your account balance is now %d gold."):format(amount, self:getBankBalance()))
			return true
		end
	end
	return false
end

function Player.addLevel(self, amount, round)
	round = round or false
	local level, amount = self:getLevel(), amount or 1
	if amount > 0 then
		return self:addExperience(Game.getExperienceForLevel(level + amount) -
			(round and self:getExperience() or Game.getExperienceForLevel(level)))
	else
		return self:removeExperience((
			(round and self:getExperience() or Game.getExperienceForLevel(level)) - Game.getExperienceForLevel(level + amount)))
	end
end

function Player.addMagicLevel(self, value)
	local currentMagLevel = self:getBaseMagicLevel()
	local sum = 0

	if value > 0 then
		while value > 0 do
			sum = sum + self:getVocation():getRequiredManaSpent(currentMagLevel + value)
			value = value - 1
		end

		return self:addManaSpent(sum - self:getManaSpent())
	else
		value = math.min(currentMagLevel, math.abs(value))
		while value > 0 do
			sum = sum + self:getVocation():getRequiredManaSpent(currentMagLevel - value + 1)
			value = value - 1
		end

		return self:removeManaSpent(sum + self:getManaSpent())
	end
end

function Player.addSkillLevel(self, skillId, value)
	local currentSkillLevel = self:getSkillLevel(skillId)
	local sum = 0

	if value > 0 then
		while value > 0 do
			sum = sum + self:getVocation():getRequiredSkillTries(skillId, currentSkillLevel + value)
			value = value - 1
		end

		return self:addSkillTries(skillId, sum - self:getSkillTries(skillId))
	else
		value = math.min(currentSkillLevel, math.abs(value))
		while value > 0 do
			sum = sum + self:getVocation():getRequiredSkillTries(skillId, currentSkillLevel - value + 1)
			value = value - 1
		end

		return self:removeSkillTries(skillId, sum + self:getSkillTries(skillId), true)
	end
end

function Player.addSkill(self, skillId, value, round)
	if skillId == SKILL_LEVEL then
		return self:addLevel(value, round or false)
	elseif skillId == SKILL_MAGLEVEL then
		return self:addMagicLevel(value)
	end
	return self:addSkillLevel(skillId, value)
end

function Player.getWeaponType(self)
	local weapon = self:getSlotItem(CONST_SLOT_LEFT)
	if weapon then
		return weapon:getType():getWeaponType()
	end
	return WEAPON_NONE
end

function Player.getTotalMoney(self)
	return self:getMoney() + self:getBankBalance()
end


function Player.isKnight(self)
	local vocation = self:getVocation()
	local name = vocation:getName()
	if string.find(name, "knight") then
	   return true
	end
	return false
end

function Player.isPaladin(self)
	local vocation = self:getVocation()
	local name = vocation:getName()
	if string.find(name, "paladin") then
	   return true
	end
	return false
end

function Player.isSorcerer(self)
	local vocation = self:getVocation()
	local name = vocation:getName()
	if string.find(name, "sorcerer") then
	   return true
	end
	return false
end

function Player.isDruid(self)
	local vocation = self:getVocation()
	local name = vocation:getName()
	if string.find(name, "druid") then
	   return true
	end
	return false
end