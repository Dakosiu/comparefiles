function Player:onBrowseField(position)
	if hasEventCallback(EVENT_CALLBACK_ONBROWSEFIELD) then
		return EventCallback(EVENT_CALLBACK_ONBROWSEFIELD, self, position)
	end
	return true
end

function Player:onLook(thing, position, distance)
	local description = ""
	if hasEventCallback(EVENT_CALLBACK_ONLOOK) then
		description = EventCallback(EVENT_CALLBACK_ONLOOK, self, thing, position, distance, description)
	end
	self:sendTextMessage(MESSAGE_EVENT_ADVANCE, description)
	--self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInBattleList(creature, distance)
	local description = ""
	if hasEventCallback(EVENT_CALLBACK_ONLOOKINBATTLELIST) then
		description = EventCallback(EVENT_CALLBACK_ONLOOKINBATTLELIST, self, creature, distance, description)
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInTrade(partner, item, distance)
	local description = "You see " .. item:getDescription(distance)
	if hasEventCallback(EVENT_CALLBACK_ONLOOKINTRADE) then
		description = EventCallback(EVENT_CALLBACK_ONLOOKINTRADE, self, partner, item, distance, description)
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInShop(itemType, count, description)
	local description = "You see " .. description
	if hasEventCallback(EVENT_CALLBACK_ONLOOKINSHOP) then
		description = EventCallback(EVENT_CALLBACK_ONLOOKINSHOP, self, itemType, count, description)
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onInventoryUpdate(item, slot, equip)
end


local blockedIds = { 41759, 41675, 41671, 41672, 30165, 18388, 41667, 41761, 41762 }
function Player:onMoveItem(item, count, fromPosition, toPosition, fromCylinder, toCylinder)

    if isInArray(blockedIds, item:getId()) then
	   return RETURNVALUE_NOTPOSSIBLE
    end

	local tileIsCarpet = Tile(toPosition)
	if tileIsCarpet then
		local isCarpet = tileIsCarpet:getGround()
		if isCarpet then
			if isCarpet:getActionId() == CantThrash then
				return RETURNVALUE_NOTPOSSIBLE
			end
		end
	end

	if item:getActionId() == CURSED_CHESTS_AID then
		return RETURNVALUE_NOTPOSSIBLE
	end
    
	if item:getCustomAttribute("Unmovable") and item:getCustomAttribute("Unmovable") == 1 then
	   return RETURNVALUE_NOTPOSSIBLE
	end
	
	if item:getActionId() <= 11610 and item:getActionId() >= 11500 then
	   return RETURNVALUE_NOTPOSSIBLE
	end
	
	if item:getActionId() <= 54500 and item:getActionId() >= 54430 then
	   return RETURNVALUE_NOTPOSSIBLE
	end
	
	--useless loop
	-- for i = 54430, 54500 do
		-- if item:getActionId() == i then
			-- return RETURNVALUE_NOTPOSSIBLE
		-- end
	-- end

	-- for i = 11500, 11610 do
		-- if item:getActionId() == i then
			-- return RETURNVALUE_NOTPOSSIBLE
		-- end
	-- end
	

	if item:getId() == 1746 and item:getActionId() > 0 then
		return RETURNVALUE_NOTPOSSIBLE
	end

	if item:getActionId() == 33672 then
		return RETURNVALUE_NOTPOSSIBLE
	end

	local unmovable = item:getCustomAttribute("Unmovable")
	if unmovable then
		return RETURNVALUE_NOTPOSSIBLE
	end

	if destroyedItemsSystem:checkRemove(self, item, toPosition, toCylinder) then
		return RETURNVALUE_NOTPOSSIBLE
	end

	if Checkpoints:getBlockItemMove(self) then
		return RETURNVALUE_NOTPOSSIBLE
	end


	local tile = Tile(toPosition)
	if tile then
		local items = tile:getItems()
		if items then
			for index, itemEx in pairs(items) do
				local t = phoenixEvent:getTable(itemEx)
				if t then
					if phoenixEvent:isValidItem(t, item) then
						if phoenixEvent:MonstersAlive(t) then
							self:say("I have to kill all monsters.")
							return false
						end

						if phoenixEvent:getAttempts(itemEx) == t.attempts + 1 then
							self:say("Monsters already spawning..")
							return false
						end

						toPosition:sendMagicEffect(t["Effects"].onBurn)
						phoenixEvent:addAttempts(itemEx)
						item:remove()

						if phoenixEvent:getAttempts(itemEx) == 0 then
							phoenixEvent:displayTimer(t, toPosition, itemEx)
						end
					end
				end
			end
		end
	end

	if hasEventCallback(EVENT_CALLBACK_ONMOVEITEM) then
		return EventCallback(EVENT_CALLBACK_ONMOVEITEM, self, item, count, fromPosition, toPosition, fromCylinder,
			toCylinder)
	end
	return RETURNVALUE_NOERROR
end

function Player:onItemMoved(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	local shield
	if item then
		shield = item:getType():getWeaponType()
	end
	if shield == 4 then
		if self:getVocation():getId() == 23 or self:getVocation():getId() == 24 then
			self:moveSlotToBackpack(CONST_SLOT_RIGHT)
			self:sendCancelMessage("You cannot equip a shield as a berserker.")
			return false
		end
	end

	if item:getId() == 1746 and item:getActionId() > 0 then
		item:teleportTo(fromPosition)
		return false
	end

	if hasEventCallback(EVENT_CALLBACK_ONITEMMOVED) then
		EventCallback(EVENT_CALLBACK_ONITEMMOVED, self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	end
end

function Player:onMoveCreature(creature, fromPosition, toPosition)
	if hasEventCallback(EVENT_CALLBACK_ONMOVECREATURE) then
		return EventCallback(EVENT_CALLBACK_ONMOVECREATURE, self, creature, fromPosition, toPosition)
	end
	return true
end

function Player:onReportRuleViolation(targetName, reportType, reportReason, comment, translation)
	if hasEventCallback(EVENT_CALLBACK_ONREPORTRULEVIOLATION) then
		EventCallback(EVENT_CALLBACK_ONREPORTRULEVIOLATION, self, targetName, reportType, reportReason, comment,
			translation)
	end
end

function Player:onReportBug(message, position, category)
	if hasEventCallback(EVENT_CALLBACK_ONREPORTBUG) then
		return EventCallback(EVENT_CALLBACK_ONREPORTBUG, self, message, position, category)
	end
	return true
end

function Player:onTurn(direction)
	if hasEventCallback(EVENT_CALLBACK_ONTURN) then
		return EventCallback(EVENT_CALLBACK_ONTURN, self, direction)
	end
	return true
end

function Player:onTradeRequest(target, item)
	if hasEventCallback(EVENT_CALLBACK_ONTRADEREQUEST) then
		return EventCallback(EVENT_CALLBACK_ONTRADEREQUEST, self, target, item)
	end
	
	if rookgardSystem:isOnRookgard(target) or rookgardSystem:isOnRookgard(self) then
	   player:sendCancelMessage("You cant use trade here.")
	   return false
	end

	-- if target:getStorageValue(19285) == 1 and target:getStorageValue(rookgardSystem.storage) == 1 then
		-- return false
	-- end
	
	if item:getActionId() <= 11610 and item:getActionId() >= 11500 then
	   return false
	end
	
	if item:getActionId() <= 54500 and item:getActionId() >= 54430 then
	   return false
	end


	if item:getActionId() == 33672 then
		return false
	end

	local unmovable = item:getCustomAttribute("Unmovable")
	if unmovable then
		return false
	end
	return true
end

function Player:onTradeAccept(target, item, targetItem)
	if hasEventCallback(EVENT_CALLBACK_ONTRADEACCEPT) then
		return EventCallback(EVENT_CALLBACK_ONTRADEACCEPT, self, target, item, targetItem)
	end

	
	if item:getActionId() <= 54500 and item:getActionId() >= 54430 then
	   return false
	end
	
	local unmovable = item:getCustomAttribute("Unmovable")
	if unmovable then
		return false
	end

	return true
end

function Player:onTradeCompleted(target, item, targetItem, isSuccess)
	if hasEventCallback(EVENT_CALLBACK_ONTRADECOMPLETED) then
		EventCallback(EVENT_CALLBACK_ONTRADECOMPLETED, self, target, item, targetItem, isSuccess)
	end
end

local soulCondition = Condition(CONDITION_SOUL, CONDITIONID_DEFAULT)
soulCondition:setTicks(4 * 60 * 1000)
soulCondition:setParameter(CONDITION_PARAM_SOULGAIN, 1)

local function useStamina(player)
	local staminaMinutes = player:getStamina()
	if staminaMinutes == 0 then
		return
	end

	local playerId = player:getId()
	if not nextUseStaminaTime[playerId] then
		nextUseStaminaTime[playerId] = 0
	end

	local currentTime = os.time()
	local timePassed = currentTime - nextUseStaminaTime[playerId]
	if timePassed <= 0 then
		return
	end

	if timePassed > 60 then
		if staminaMinutes > 2 then
			staminaMinutes = staminaMinutes - 2
		else
			staminaMinutes = 0
		end
		nextUseStaminaTime[playerId] = currentTime + 120
	else
		staminaMinutes = staminaMinutes - 1
		nextUseStaminaTime[playerId] = currentTime + 60
	end
	player:setStamina(staminaMinutes)
end

function Player:onGainExperience(source, exp, rawExp)
	if not source or source:isPlayer() then
		return exp
	end

	-- Soul regeneration
	local vocation = self:getVocation()
	if self:getSoul() < vocation:getMaxSoul() and exp >= self:getLevel() then
		soulCondition:setParameter(CONDITION_PARAM_SOULTICKS, vocation:getSoulGainTicks() * 1000)
		self:addCondition(soulCondition)
	end

	-- Apply experience stage multiplier
	exp = exp * Game.getExperienceStage(self:getLevel())

	-- Stamina modifier
	if configManager.getBoolean(configKeys.STAMINA_SYSTEM) then
		useStamina(self)

		local staminaMinutes = self:getStamina()
		if staminaMinutes > 2400 and self:isPremium() then
			exp = exp * 1.1
		elseif staminaMinutes <= 840 then
			exp = exp * 0.5
		end
	end

	--[[ if self:hasBlessing(5) then
		exp = exp * 1.1
	end
	if self:hasBlessing(6) then
		exp = exp * 1.1
	end
	if self:hasBlessing(5) and self:hasBlessing(6) then
		exp = exp * 1.2
	end
 --]]
	if source:isMonster() then
		local level = source:getMonsterLevel()
		local percentage = getConfigInfo("levelMonsterBonusExperience")
		if level > 0 then
			if percentage and percentage ~= 0 then
				local bonus = percentage * level
				exp = exp + (exp * bonus)
				rateShow = exp + (exp * bonus)
			end
		end
	end
	--end

	if getGlobalStorageValue(17589) > os.time() then
		exp = exp * (1 + getGlobalStorageValue(17585) / 100)
	end


	local maxLevel = 22
	local maxExperience = getExperienceForLevel(maxLevel)

	if self:getVocation():getId() == 0 then
		if self:getExperience() >= maxExperience or self:getExperience() >= maxExperience + exp then
			self:sendTextMessage(MESSAGE_STATUS_WARNING,
				"You will not gain anymore any experience, you are grown up soul, its time to pick your path at temple.")
			self:setExperience(maxExperience)
			exp = 0
		end
	end

	return hasEventCallback(EVENT_CALLBACK_ONGAINEXPERIENCE) and
		 EventCallback(EVENT_CALLBACK_ONGAINEXPERIENCE, self, source, exp, rawExp) or exp
end

function Player:onLoseExperience(exp)
	return hasEventCallback(EVENT_CALLBACK_ONLOSEEXPERIENCE) and EventCallback(EVENT_CALLBACK_ONLOSEEXPERIENCE, self, exp)
		 or exp
end

SkillRates = {
	Skills = {
		[1] = { minlevel = 1, maxlevel = 50, multiplier = 15 },
		[2] = { minlevel = 51, maxlevel = 60, multiplier = 10 },
		[3] = { minlevel = 61, maxlevel = 70, multiplier = 5 },
		[4] = { minlevel = 71, maxlevel = 80, multiplier = 4 },
		[5] = { minlevel = 81, maxlevel = 90, multiplier = 3 },
		[6] = { minlevel = 91, maxlevel = 100, multiplier = 2 },
		[7] = { minlevel = 101, multiplier = 1 }
	}
}

local function getRateSkill(self, skill)
	local lv = self:getSkillLevel(skill)
	local sk = SkillRates.Skills
	for v, k in pairs(sk) do
		if lv >= sk[v].minlevel and sk[v].maxlevel and lv <= sk[v].maxlevel then
			return sk[v].multiplier
		elseif lv >= sk[v].minlevel and sk[v].maxlevel == nil then
			return sk[v].multiplier
		else
			return 10
		end
	end
end

MagicRates = {
	Paladin = {
		[1] = { minlevel = 0, maxlevel = 10, multiplier = 10 },
		[2] = { minlevel = 11, maxlevel = 15, multiplier = 8 },
		[3] = { minlevel = 16, maxlevel = 20, multiplier = 6 },
		[4] = { minlevel = 21, maxlevel = 25, multiplier = 4 },
		[5] = { minlevel = 26, maxlevel = 30, multiplier = 2 },
		[6] = { minlevel = 31, multiplier = 1 }
	},
	Knight = {
		[1] = { minlevel = 0, maxlevel = 5, multiplier = 8 },
		[2] = { minlevel = 6, maxlevel = 7, multiplier = 4 },
		[3] = { minlevel = 8, maxlevel = 9, multiplier = 2 },
		[4] = { minlevel = 10, multiplier = 1 }
	},
	Mage = {
		[1] = { minlevel = 0, maxlevel = 30, multiplier = 10 },
		[2] = { minlevel = 31, maxlevel = 50, multiplier = 8 },
		[3] = { minlevel = 51, maxlevel = 70, multiplier = 6 },
		[4] = { minlevel = 71, maxlevel = 80, multiplier = 5 },
		[5] = { minlevel = 81, maxlevel = 90, multiplier = 4 },
		[6] = { minlevel = 91, maxlevel = 100, multiplier = 3 },
		[7] = { minlevel = 101, maxlevel =110, multiplier = 2 },
		[8] = { minlevel = 111, multiplier = 1 }
	},
	None = {
		[1] = { minlevel = 0, maxlevel = 2, multiplier = 10 },
		[2] = { minlevel = 3, maxlevel = 4, multiplier = 5 },
		[3] = { minlevel = 5, maxlevel = 6, multiplier = 3 },
		[4] = { minlevel = 6, multiplier = 1 }
	}
}

local function getRateMagic(self)
	local lv = self:getBaseMagicLevel()
	local vc = self:getVocation():getId()
	if vc == 3 or vc == 7 or vc == 9 or vc == 11 or vc == 10 or vc == 12 then
		local mk = MagicRates.Paladin
		for v, k in pairs(mk) do
			if lv >= mk[v].minlevel and mk[v].maxlevel and lv <= mk[v].maxlevel then
				return mk[v].multiplier
			elseif lv >= mk[v].minlevel and mk[v].maxlevel == nil then
				return mk[v].multiplier
			end
		end
	elseif vc == 1 or vc == 2 or vc == 5 or vc == 6 or vc == 17 or vc == 18 or vc == 19 or vc == 20 or vc == 15 or vc == 16 or vc == 13 or vc == 14 then
		local mk = MagicRates.Mage
		for v, k in pairs(mk) do
			if lv >= mk[v].minlevel and mk[v].maxlevel and lv <= mk[v].maxlevel then
				return mk[v].multiplier
			elseif lv >= mk[v].minlevel and mk[v].maxlevel == nil then
				return mk[v].multiplier
			end
		end
	elseif vc == 4 or vc == 8 or vc == 21 or vc == 22 or vc == 23 or vc == 24 then
		local mk = MagicRates.Knight
		for v, k in pairs(mk) do
			if lv >= mk[v].minlevel and mk[v].maxlevel and lv <= mk[v].maxlevel then
				return mk[v].multiplier
			elseif lv >= mk[v].minlevel and mk[v].maxlevel == nil then
				return mk[v].multiplier
			end
		end
	elseif vc == 0 then
		local mk = MagicRates.None
		for v, k in pairs(mk) do
			if lv >= mk[v].minlevel and mk[v].maxlevel and lv <= mk[v].maxlevel then
				return mk[v].multiplier
			elseif lv >= mk[v].minlevel and mk[v].maxlevel == nil then
				return mk[v].multiplier
			end
		end
	else
		 return 6
	end
end

function Player:onGainSkillTries(skill, tries)
	if APPLY_SKILL_MULTIPLIER == false then
		return hasEventCallback(EVENT_CALLBACK_ONGAINSKILLTRIES) and
			 EventCallback(EVENT_CALLBACK_ONGAINSKILLTRIES, self, skill, tries) or tries
	end
	if skill == SKILL_MAGLEVEL then
		tries = tries * getRateMagic(self)
		if getGlobalStorageValue(17590) > os.time() then
			tries = tries * (1 + getGlobalStorageValue(17586) / 100)
		end
		return hasEventCallback(EVENT_CALLBACK_ONGAINSKILLTRIES) and
			 EventCallback(EVENT_CALLBACK_ONGAINSKILLTRIES, self, skill, tries) or tries
	end
	tries = tries * getRateSkill(self, skill)
	if getGlobalStorageValue(17590) > os.time() then
		tries = tries * (1 + getGlobalStorageValue(17586) / 100)
	end
	return hasEventCallback(EVENT_CALLBACK_ONGAINSKILLTRIES) and
		 EventCallback(EVENT_CALLBACK_ONGAINSKILLTRIES, self, skill, tries) or tries
end

function Player:onWrapItem(item)
	local topCylinder = item:getTopParent()
	if not topCylinder then
		return
	end

	local tile = Tile(topCylinder:getPosition())
	if not tile then
		return
	end

	local house = tile:getHouse()
	if not house then
		self:sendCancelMessage("You can only wrap and unwrap this item inside a house.")
		return
	end

	if house ~= self:getHouse() and
		 not string.find(house:getAccessList(SUBOWNER_LIST):lower(), "%f[%a]" .. self:getName():lower() .. "%f[%A]") then
		self:sendCancelMessage("You cannot wrap or unwrap items from a house, which you are only guest to.")
		return
	end

	local wrapId = item:getAttribute("wrapid")
	if wrapId == 0 then
		return
	end

	if not hasEventCallback(EVENT_CALLBACK_ONWRAPITEM) or EventCallback(EVENT_CALLBACK_ONWRAPITEM, self, item) then
		local oldId = item:getId()
		item:remove(1)
		local item = tile:addItem(wrapId)
		if item then
			item:setAttribute("wrapid", oldId)
		end
	end
end

function Player:onRequestQuestLog()
	self:sendQuestLog()
end
function Player:onRequestQuestLine(questId)
	self:sendQuestLine(questId)
end
function Player:onStorageUpdate(key, value, oldValue, currentFrameTime)
	self:updateStorage(key, value, oldValue, currentFrameTime)
end