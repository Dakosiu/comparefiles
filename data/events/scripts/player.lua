CONTAINER_WEIGHT_CHECK = true -- true = enable / false = disable
CONTAINER_WEIGHT_MAX = 1000000 -- 1000000 = 10k = 10000.00 oz

local storeItemID = {
	-- registered item ids here are not tradable with players
	-- these items can be set to moveable at items.xml
	-- 500 charges exercise weapons
	28552, -- exercise sword
	28553, -- exercise axe
	28554, -- exercise club
	28555, -- exercise bow
	28556, -- exercise rod
	28557, -- exercise wand

	-- 50 charges exercise weapons
	28540, -- training sword
	28541, -- training axe
	28542, -- training club
	28543, -- training bow
	28544, -- training wand
	28545, -- training club

	-- magic gold and magic converter (activated/deactivated)
	28525, -- magic gold converter
	28526, -- magic gold converter
	23722, -- gold converter
	25719, -- gold converter

	-- foods
	29408, -- roasted wyvern wings
	29409, -- carrot pie
	29410, -- tropical marinated tiger
	29411, -- delicatessen salad
	29412, -- chilli con carniphila
	29413, -- svargrond salmon filet
	29414, -- carrion casserole
	29415, -- consecrated beef
	29416, -- overcooked noodles
}

-- Players cannot throw items on teleports if set to true
local blockTeleportTrashing = true

local titles = {
	{storageID = 14960, title = " Scout"},
	{storageID = 14961, title = " Sentinel"},
	{storageID = 14962, title = " Steward"},
	{storageID = 14963, title = " Warden"},
	{storageID = 14964, title = " Squire"},
	{storageID = 14965, title = " Warrior"},
	{storageID = 14966, title = " Keeper"},
	{storageID = 14967, title = " Guardian"},
	{storageID = 14968, title = " Sage"},
	{storageID = 14969, title = " Tutor"},
	{storageID = 14970, title = " Senior Tutor"},
	{storageID = 14971, title = " King"},
}

local function getTitle(uid)
	local player = Player(uid)
	if not player then return false end

	for i = #titles, 1, -1 do
		if player:getStorageValue(titles[i].storageID) == 1 then
			return titles[i].title
		end
	end

	return false
end

function Player:onBrowseField(position)
	return true
end

local function getHours(seconds)
	return math.floor((seconds/60)/60)
end

local function getMinutes(seconds)
	return math.floor(seconds/60)
end

local function getSeconds(seconds)
	return seconds%60
end

local function getTime(seconds)
	local hours, minutes = getHours(seconds), getMinutes(seconds)
	if (minutes > 59) then
		minutes = minutes-hours*60
	end

	if (minutes < 10) then
		minutes = "0" ..minutes
	end

	return hours..":"..minutes.. "h"
end

local function getTimeinWords(secs)
	local hours, minutes, seconds = getHours(secs), getMinutes(secs), getSeconds(secs)
	if (minutes > 59) then
		minutes = minutes-hours*60
	end

	local timeStr = ''

	if hours > 0 then
		timeStr = timeStr .. ' hours '
	end

	timeStr = timeStr .. minutes .. ' minutes and '.. seconds .. ' seconds.'

	return timeStr
end

function Player:onCastSpell(words)
	if self:getStorageValue(hungerGamesStorages.playerJoinedEvent) == 1 then
		return hungerGamesEvent:onCastSpell(self, words)
	end
	return true
end


function Player:onLook(thing, position, distance)
	local description = "You see "
	if thing:isItem() then
		if thing.actionid == 5640 then
			description = description .. "a honeyflower patch."
		elseif thing.actionid == 5641 then
			description = description .. "a banana palm."
		elseif thing.itemid >= ITEM_HEALTH_CASK_START and thing.itemid <= ITEM_HEALTH_CASK_END
		or thing.itemid >= ITEM_MANA_CASK_START and thing.itemid <= ITEM_MANA_CASK_END
		or thing.itemid >= ITEM_SPIRIT_CASK_START and thing.itemid <= ITEM_SPIRIT_CASK_END
		or thing.itemid >= ITEM_KEG_START and thing.itemid <= ITEM_KEG_END then
			description = description .. thing:getDescription(distance)
			local charges = thing:getCharges()
			if charges then
				description = string.format("%s\nIt has %d refilllings left.", description, charges)
			end
		else
			description = description .. thing:getDescription(distance)
		end
		
		if thing:getCustomAttribute("RaidName") then
		   local name = thing:getCustomAttribute("RaidName")
	           local index = thing:getCustomAttribute("RaidIndex")
	           local count = raid:monsters(name)
	                 description = description .. "\n" .. "Monsters left to finish raid: " .. count
	                 local v = CITIES_TO_RAID[name]
	               if v then
	                  --print(dump(v.monsters))
	                 --if tableHasKey(v.monsters[1], "boss") then
	                    --if v.monsters[1]["boss"] then
			    local boss = Monster(v.monsters["Boss"][1])
			    if boss then 
	                       description = description .. "\n" .. "Boss: " .. boss:getName() .. " is still alive!"
	                    end
	                    if Game.getStorageValue(RAID_STORAGE_TIME_LEFT + index) >= os.time() then
	                       description = description .. "\n" .. "Raid will end at: " .. raid:timeleft(RAID_STORAGE_TIME_LEFT + index)
	                    end
	                 --end
	               end
        end
		
		-- local addonScroll = ADDON_SCROLL_SYSTEM:getDescription(thing)
		-- if addonScroll then
		   -- description = description .. "\n" .. addonScroll 
		-- end
		
		local displayItem = SUMMON_SYSTEM:displayItem(thing)
		if displayItem then
		   description = description .. "\n" .. displayItem
		end
		
		local maxRefillCharges = REFILLABLE_POTION_SYSTEM:getMaxCharges(thing)
		if maxRefillCharges and maxRefillCharges > 0 then
		   local charges = thing:getRefil()
		   description = description .. "\n" .. "it has " .. charges .. " / " .. maxRefillCharges .. " charges left."
		   -- if charges > 0 then
		      -- --description = description .. "\n" .. "it has " .. charges .. " charges left. Max Charges: " .. REFILABLE_POTION_SYSTEM:getMaxCharges(thing) .. "."

		   -- else
		      -- description = description .. "\n" .. "it has " .. charges .. " / " .. maxRefillCharges .. " charges left."
		   --end
		   local healthValue = REFILLABLE_POTION_SYSTEM:getHealthValues(thing)
		   if healthValue then
		      description = description .. "\n" .. healthValue
		   end
		   local manaValue = REFILLABLE_POTION_SYSTEM:getManaValues(thing)
		   if manaValue then
		      description = description .. "\n" .. manaValue
		   end			  
		   local level = REFILLABLE_POTION_SYSTEM:getLevel(thing)
		   if level > 0 then
		      description = description .. "\n" .. "this potion is upgraded to " .. level .. " level."
		   else
		      description = description .. "\n" .. "this potion is in normal state."
		   end
		end
		local keyDescription = DOOR_KEY_SYSTEM:getDescription(thing)
		if keyDescription then
		    description = description .. "\n" .. keyDescription
	    end
		if thing.actionid == larvikTask.actionid then
		   description = description .. "\n" .. larvikTask:sendOnLook()
		end
		
		local houseBid = false
		
		if houseBid then
		   local tile = Tile(position)
		   if tile and tile:getHouse() then
		      local house = tile:getHouse()
		      local id = house:getId()
		      local bid = AUCTION_HOUSE_SYSTEM:getBidding(house)
		      --local price = house:getTileCount() * configManager.getNumber(configKeys.HOUSE_PRICE)
		      if AUCTION_HOUSE_SYSTEM:isBidding(house) then
		         local timeleft = AUCTION_HOUSE_SYSTEM:getAuctionTime(id)
		         description = description .. "\n" .. " Minimum bid is " .. bid .. " gold coins." .. "\n" .. "Highest Bid belong to: " .. AUCTION_HOUSE_SYSTEM:getHighestBidder(id) .. "."
			     if timeleft then
			        description = description .. "\n" .. " Auction end at: " .. timeleft
		        end
		      else
		         if house:getOwnerGuid() == 0 then
		            description = description .. " Minimum bid is " .. bid .. " gold coins."
			     end
			  end
		   end
		end
	else
		description = description .. thing:getDescription(distance)
		if thing:isMonster() then
			local master = thing:getMaster()
			if master and table.contains({'sorcerer familiar','knight familiar','druid familiar','paladin familiar'},
																						thing:getName():lower()) then
				description = description..' (Master: ' .. master:getName() .. '). \z
				It will disappear in ' .. getTimeinWords(master:getStorageValue(Storage.FamiliarSummon) - os.time())
			end
		end
	end

	if self:getGroup():getAccess() then
		if thing:isItem() then
			description = string.format("%s\nClient ID: %d", description, thing:getId())

			local actionId = thing:getActionId()
			if actionId ~= 0 then
				description = string.format("%s, Action ID: %d", description, actionId)
			end

			local uniqueId = thing:getAttribute(ITEM_ATTRIBUTE_UNIQUEID)
			if uniqueId > 0 and uniqueId < 65536 then
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
			
			local isQuest = QUEST_SYSTEM:isQuest(thing)
			if isQuest then
			   local questDescription = QUEST_SYSTEM:getDescription(thing)
			   description = "\n" .. description .. questDescription
			end

		elseif thing:isCreature() then
			local str = "%s\nHealth: %d / %d"
			if thing:isPlayer() and thing:getMaxMana() > 0 then
				str = string.format("%s, Mana: %d / %d", str, thing:getMana(), thing:getMaxMana())
			end
			description = string.format(str, description, thing:getHealth(), thing:getMaxHealth()) .. "."
		end

		description = string.format(
		"%s\nPosition: %d, %d, %d",
		description, position.x, position.y, position.z
		)

		if thing:isCreature() then
			local speedBase = thing:getBaseSpeed()
			local speed = thing:getSpeed()
			description = string.format("%s\nSpeedBase: %d", description, speedBase)
			description = string.format("%s\nSpeed: %d", description, speed)
			
			description = description .. "\n" .. "Looktype: " .. thing:getOutfit().lookType

			if thing:isPlayer() then
				description = string.format("%s\nIP: %s.", description, Game.convertIpToString(thing:getIp()))
			end
		end
	end
	self:sendTextMessage(MESSAGE_LOOK, description)
end

function Player:onLookInBattleList(creature, distance)
	local description = "You see " .. creature:getDescription(distance)
	if creature:isMonster() then
		local master = creature:getMaster()
		local summons = {'sorcerer familiar','knight familiar','druid familiar','paladin familiar'}
		if master and table.contains(summons, creature:getName():lower()) then
			description = description..' (Master: ' .. master:getName() .. '). \z
				It will disappear in ' .. getTimeinWords(master:getStorageValue(Storage.FamiliarSummon) - os.time())
		end
	end
	if self:getGroup():getAccess() then
		local str = "%s\nHealth: %d / %d"
		if creature:isPlayer() and creature:getMaxMana() > 0 then
			str = string.format("%s, Mana: %d / %d", str, creature:getMana(), creature:getMaxMana())
		end
		description = string.format(str, description, creature:getHealth(), creature:getMaxHealth()) .. "."

		local position = creature:getPosition()
		description = string.format(
		"%s\nPosition: %d, %d, %d",
		description, position.x, position.y, position.z

		)

		if creature:isPlayer() then
			description = string.format("%s\nIP: %s", description, Game.convertIpToString(creature:getIp()))
		end
	end
	self:sendTextMessage(MESSAGE_LOOK, description)
end

function Player:onLookInTrade(partner, item, distance)
	self:sendTextMessage(MESSAGE_LOOK, "You see " .. item:getDescription(distance))
end

function Player:onLookInShop(itemType, count)
	return true
end

local config = {
	maxItemsPerSeconds = 1,
	exhaustTime = 2000,
}

if not pushDelay then
	pushDelay = { }
end

local function antiPush(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	if toPosition.x == CONTAINER_POSITION then
		return true
	end

	local tile = Tile(toPosition)
	if not tile then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return false
	end

	local cid = self:getId()
	if not pushDelay[cid] then
		pushDelay[cid] = {items = 0, time = 0}
	end

	pushDelay[cid].items = pushDelay[cid].items + 1

	local currentTime = systemTime()
	if pushDelay[cid].time == 0 then
		pushDelay[cid].time = currentTime
	elseif pushDelay[cid].time == currentTime then
		pushDelay[cid].items = pushDelay[cid].items + 1
	elseif currentTime > pushDelay[cid].time then
		pushDelay[cid].time = 0
		pushDelay[cid].items = 0
	end

	if pushDelay[cid].items > config.maxItemsPerSeconds then
		pushDelay[cid].time = currentTime + config.exhaustTime
	end

	if pushDelay[cid].time > currentTime then
		self:sendCancelMessage("You can't move that item so fast.")
		return false
	end

	return true
end

function Player:onMoveItem(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	
	if toPosition then
	   local oldItem = self:getSlotItem(toPosition.y)
	   if oldItem then
	      ITEM_BONUS_SYSTEM:updateStats(self, oldItem, true)	
	      ITEM_BONUS_SYSTEM:updateSkills(self, oldItem, true)
	      ITEM_BONUS_SYSTEM:updateSpecialSkills(self, oldItem, true)		  
	   end
	end
	
	if toPosition.x ~= CONTAINER_POSITION then
	   local summon = getSummonByItem(item)
	   if summon then
	      if summon:getCreature() then
		     self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
			 return false
		  end
	   end
	   summon = getSummonByPlayer(self)
	   if summon then
	      if item:isContainer() then
		     self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
			 return false
	      end
	   end
	end
	
	if item:getAttribute(ITEM_ATTRIBUTE_ACTIONID) and item:getAttribute(ITEM_ATTRIBUTE_ACTIONID) == 6103 then
	   self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
	   return false
	end
	
	if TRAINING_ROOM_SYSTEM:isTrainingRoomItem(item) then
	   self:sendCancelMessage("You are not allowed to move this item.")
	   return false
	end
	   
	-- No move items with actionID = 100
	if item:getActionId() == NOT_MOVEABLE_ACTION then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return false
	end
	
	-- No move if item count > 20 items
	local tile = Tile(toPosition)
	if tile and tile:getItemCount() > 20 then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return false
	end

	-- No move parcel very heavy
	if CONTAINER_WEIGHT_CHECK and ItemType(item:getId()):isContainer()
	and item:getWeight() > CONTAINER_WEIGHT_MAX then
		self:sendCancelMessage("Your cannot move this item too heavy.")
		return false
	end

	-- Players cannot throw items on teleports
	if blockTeleportTrashing and toPosition.x ~= CONTAINER_POSITION then
		local thing = Tile(toPosition):getItemByType(ITEM_TYPE_TELEPORT)
		if thing then
			self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
			self:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end
	end
	
	if QUEST_SYSTEM:isQuest(item) then
	   self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
	   return false
	end
	
	local tile = Tile(toPosition)
	if tile then
	   local items = tile:getItems()
	   if items and #items > 0 then
	      for _, item in pairs(items) do
	         if QUEST_SYSTEM:isQuest(item) then
			    self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		        return false
		     end
		  end
		end
	end
	

	-- SSA exhaust
	local exhaust = { }
	if toPosition.x == CONTAINER_POSITION and toPosition.y == CONST_SLOT_NECKLACE
	and item:getId() == ITEM_STONE_SKIN_AMULET then
		local pid = self:getId()
		if exhaust[pid] then
			self:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
			return false
		else
			exhaust[pid] = true
			addEvent(function() exhaust[pid] = false end, 2000, pid)
			return true
		end
	end

	-- Store Inbox
	local containerIdFrom = fromPosition.y - 64
	local containerFrom = self:getContainerById(containerIdFrom)
	if (containerFrom) then
		if (containerFrom:getId() == ITEM_STORE_INBOX
		and toPosition.y >= 1 and toPosition.y <= 11 and toPosition.y ~= 3) then
			self:sendCancelMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM)
			return false
		end
	end

	local containerTo = self:getContainerById(toPosition.y-64)
	if (containerTo) then
		if (containerTo:getId() == ITEM_STORE_INBOX) or (containerTo:getParent():isContainer() and containerTo:getParent():getId() == ITEM_STORE_INBOX and containerTo:getId() ~= ITEM_GOLD_POUCH) then
			self:sendCancelMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM)
			return false
		end
		-- Gold Pouch
		if (containerTo:getId() == ITEM_GOLD_POUCH) then
			if (not (item:getId() == ITEM_CRYSTAL_COIN or item:getId() == ITEM_PLATINUM_COIN
			or item:getId() == ITEM_GOLD_COIN)) then
				self:sendCancelMessage("You can move only money to this container.")
				return false
			end
		end
	end


	-- Bath tube
	local toTile = Tile(toCylinder:getPosition())
	local topDownItem = toTile:getTopDownItem()
	if topDownItem and table.contains({ BATHTUB_EMPTY, BATHTUB_FILLED }, topDownItem:getId()) then
		return false
	end

	-- Handle move items to the ground
	if toPosition.x ~= CONTAINER_POSITION then
		return true
	end

	-- Check two-handed weapons
	if item:getTopParent() == self and bit.band(toPosition.y, 0x40) == 0 then
		local itemType, moveItem = ItemType(item:getId())
		if bit.band(itemType:getSlotPosition(), SLOTP_TWO_HAND) ~= 0 and toPosition.y == CONST_SLOT_LEFT then
			moveItem = self:getSlotItem(CONST_SLOT_RIGHT)
			if moveItem and itemType:getWeaponType() == WEAPON_DISTANCE and ItemType(moveItem:getId()):isQuiver() then
				return true
			end
		elseif itemType:getWeaponType() == WEAPON_SHIELD and toPosition.y == CONST_SLOT_RIGHT then
			moveItem = self:getSlotItem(CONST_SLOT_LEFT)
			if moveItem and bit.band(ItemType(moveItem:getId()):getSlotPosition(), SLOTP_TWO_HAND) == 0 then
				return true
			end
		end

		if moveItem then
			local parent = item:getParent()
			if parent:getSize() == parent:getCapacity() then
				self:sendTextMessage(MESSAGE_FAILURE, Game.getReturnMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM))
				return false
			else
				return moveItem:moveTo(parent)
			end
		end
	end

	-- Reward System
	if toPosition.x == CONTAINER_POSITION then
		local containerId = toPosition.y - 64
		local container = self:getContainerById(containerId)
		if not container then
			return true
		end

		-- Do not let the player insert items into either the Reward Container or the Reward Chest
		local itemId = container:getId()
		if itemId == ITEM_REWARD_CONTAINER or itemId == ITEM_REWARD_CHEST then
			self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
			return false
		end

		-- The player also shouldn't be able to insert items into the boss corpse
		local tileCorpse = Tile(container:getPosition())
		for index, value in ipairs(tileCorpse:getItems() or { }) do
			if value:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER) == 2^31 - 1 and value:getName() == container:getName() then
				self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
				return false
			end
		end
	end

	-- Do not let the player move the boss corpse.
	if item:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER) == 2^31 - 1 then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return false
	end

	-- Players cannot throw items on reward chest
	local tileChest = Tile(toPosition)
	if tileChest and tileChest:getItemById(ITEM_REWARD_CHEST) then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		self:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if tile and tile:getItemById(370) then -- Trapdoor
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		self:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if not antiPush(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder) then
		return false
	end
	


	return true
end

function Player:onItemMoved(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
     
	local summon = getSummonByPlayer(self)
	if summon then
	   summon:checkItem()
	end
	

	
	ITEM_BONUS_SYSTEM:updateSkills(self, item)
	ITEM_BONUS_SYSTEM:updateStats(self, item)
	ITEM_BONUS_SYSTEM:updateSpecialSkills(self, item)
	

	
	--self:bonus_onItemMoved(item, fromPosition, toPosition)
	
	if IsRunningGlobalDatapack() then
		-- Cults of Tibia begin
		local frompos = Position(33023, 31904, 14) -- Checagem
		local topos = Position(33052, 31932, 15) -- Checagem
		local removeItem = false
		if self:getPosition():isInRange(frompos, topos) and item:getId() == 23729 then
			local tileBoss = Tile(toPosition)
			if tileBoss and tileBoss:getTopCreature() and tileBoss:getTopCreature():isMonster() then
				if tileBoss:getTopCreature():getName():lower() == 'the remorseless corruptor' then
					tileBoss:getTopCreature():addHealth(-17000)
					tileBoss:getTopCreature():remove()
					local monster = Game.createMonster('The Corruptor of Souls', toPosition)
					if not monster then
						return false
					end
					removeItem = true
					monster:registerEvent('CheckTile')
					if Game.getStorageValue('healthSoul') > 0 then
						monster:addHealth(-(monster:getHealth() - Game.getStorageValue('healthSoul')))
					end
					Game.setStorageValue('CheckTile', os.time()+30)
				elseif tileBoss:getTopCreature():getName():lower() == 'the corruptor of souls' then
					Game.setStorageValue('CheckTile', os.time()+30)
					removeItem = true
				end
			end
			if removeItem then
				item:remove(1)
			end
		end
		-- Cults of Tibia end
	end
	
	return true
end

function Player:onMoveCreature(creature, fromPosition, toPosition)
	local player = creature:getPlayer()
	if player and onExerciseTraining[player:getId()] and self:getGroup():hasFlag(PlayerFlag_CanPushAllCreatures) == false then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return false
	end
	
	local tile = Tile(toPosition)
	if tile then
	   local items = tile:getItems()
	   if items and #items > 0 then
	      for _, item in pairs(items) do
	         if QUEST_SYSTEM:isQuest(item) then
			    if player then
			       self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
				end
		        return false
		     end
		  end
		end
	end
	
	return true
end

local function hasPendingReport(name, targetName, reportType)
	local f = io.open(string.format("%s/reports/players/%s-%s-%d.txt", CORE_DIRECTORY, name, targetName, reportType), "r")
	if f then
		io.close(f)
		return true
	else
		return false
	end
end

function Player:onReportRuleViolation(targetName, reportType, reportReason, comment, translation)
	local name = self:getName()
	if hasPendingReport(name, targetName, reportType) then
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your report is being processed.")
		return
	end

	local file = io.open(string.format("%s/reports/players/%s-%s-%d.txt", CORE_DIRECTORY, name, targetName, reportType), "a")
	if not file then
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE,
			"There was an error when processing your report, please contact a gamemaster.")
		return
	end

	io.output(file)
	io.write("------------------------------\n")
	io.write("Reported by: " .. name .. "\n")
	io.write("Target: " .. targetName .. "\n")
	io.write("Type: " .. reportType .. "\n")
	io.write("Reason: " .. reportReason .. "\n")
	io.write("Comment: " .. comment .. "\n")
	if reportType ~= REPORT_TYPE_BOT then
		io.write("Translation: " .. translation .. "\n")
	end
	io.write("------------------------------\n")
	io.close(file)
	self:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Thank you for reporting %s. Your report \z
	will be processed by %s team as soon as possible.", targetName, configManager.getString(configKeys.SERVER_NAME)))
	return
end

function Player:onReportBug(message, position, category)
	if self:getAccountType() == ACCOUNT_TYPE_NORMAL then
		return false
	end

	local name = self:getName()
	local file = io.open(string.format("%s/reports/bugs/%s/report.txt", CORE_DIRECTORY, name), "a")

	if not file then
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE,
			"There was an error when processing your report, please contact a gamemaster.")
		return true
	end

	io.output(file)
	io.write("------------------------------\n")
	io.write("Name: " .. name)
	if category == BUG_CATEGORY_MAP then
		io.write(" [Map position: " .. position.x .. ", " .. position.y .. ", " .. position.z .. "]")
	end
	local playerPosition = self:getPosition()
	io.write(" [Player Position: " .. playerPosition.x .. ", " .. playerPosition.y .. ", " .. playerPosition.z .. "]\n")
	io.write("Comment: " .. message .. "\n")
	io.close(file)

	self:sendTextMessage(MESSAGE_EVENT_ADVANCE,
		"Your report has been sent to " .. configManager.getString(configKeys.SERVER_NAME) .. ".")
	return true
end

function Player:onTurn(direction)
	if self:getGroup():getAccess() and self:getDirection() == direction then
		local nextPosition = self:getPosition()
		nextPosition:getNextPosition(direction)

		self:teleportTo(nextPosition, true)
	end

	return true
end

function Player:onTradeRequest(target, item)
	-- No trade items with actionID = 100
	if item:getActionId() == NOT_MOVEABLE_ACTION then
		return false
	end

	if table.contains(storeItemID,item.itemid) then
		return false
	end
	return true
end

function Player:onTradeAccept(target, item, targetItem)
	self:closeForge()
	target:closeForge()
	self:closeImbuementWindow()
	target:closeImbuementWindow()
	local summon = getSummonByPlayer(self)
	if summon then
	   summon:checkItem()
	end
	return true
end

local soulCondition = Condition(CONDITION_SOUL, CONDITIONID_DEFAULT)
soulCondition:setTicks(4 * 60 * 1000)
soulCondition:setParameter(CONDITION_PARAM_SOULGAIN, 1)

local function useStamina(player)
	if not player then
		return false
	end

	local staminaMinutes = player:getStamina()
	if staminaMinutes == 0 then
		return
	end

	local playerId = player:getId()
	if not playerId or not nextUseStaminaTime[playerId] then
		return false
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
		player:removePreyStamina(120)
	else
		staminaMinutes = staminaMinutes - 1
		nextUseStaminaTime[playerId] = currentTime + 60
		player:removePreyStamina(60)
	end
	player:setStamina(staminaMinutes)
end

local function useStaminaXpBoost(player)
	if not player then
		return false
	end

	local staminaMinutes = player:getExpBoostStamina() / 60
	if staminaMinutes == 0 then
		return
	end

	local playerId = player:getId()
	if not playerId then
		return false
	end

	local currentTime = os.time()
	local timePassed = currentTime - nextUseXpStamina[playerId]
	if timePassed <= 0 then
		return
	end

	if timePassed > 60 then
		if staminaMinutes > 2 then
			staminaMinutes = staminaMinutes - 2
		else
			staminaMinutes = 0
		end
		nextUseXpStamina[playerId] = currentTime + 120
	else
		staminaMinutes = staminaMinutes - 1
		nextUseXpStamina[playerId] = currentTime + 60
	end
	player:setExpBoostStamina(staminaMinutes * 60)
end


function Player:getExperienceMultiplier()
    local multiplier = 0
    	
	-- local worldQuestsBoost = worldQuests:getAllBoostsMultiplier()["experience boost"]
	-- if worldQuestsBoost and worldQuestsBoost > 0 then
	   -- multiplier = multiplier + worldQuestsBoost
	   	-- print("Multiplier 2 World Quest" .. multiplier)
	-- end
	
	local experience_bonus = self:getExperienceBonus()
	if experience_bonus and experience_bonus > 0 then
	   multiplier = multiplier + experience_bonus
	   	print("Multiplier 3 Experience Bonus" .. multiplier)
	end
	
	if self:isGoldenAccount() then
	    local golden_account_bonus = GOLDEN_ACCOUNT_FEATURES:getExperienceBonus()
	    if golden_account_bonus > 0 then
	       multiplier = multiplier + golden_account_bonus
		   print("Multiplier 4 Golden Account" .. multiplier)
		end
	end
		
	if larvikTask:canUseBoost() then	
	   local value = larvikTask:getMultiplier()
	   if value and value > 0 then
	      multiplier = multiplier + value
		  print("Multiplier 5 Larvik Task" .. multiplier)
	   end
	end
	
	local knowledgeBoost = ABILITY_SCROLL_SYSTEM:getBoostStorage(self, "increaseExperience")
	if knowledgeBoost then
	   multiplier = multiplier + knowledgeBoost
	   print("Multiplier 6 Knowledge Boost" .. multiplier)
	end
	
	
	return multiplier
end

function Player:onGainExperience(target, exp, rawExp)
	if not target or target:isPlayer() then
		return exp
	end
	
	-- Soul regeneration
	local vocation = self:getVocation()
	if self:getSoul() < vocation:getMaxSoul() and exp >= self:getLevel() then
		soulCondition:setParameter(CONDITION_PARAM_SOULTICKS, vocation:getSoulGainTicks())
		self:addCondition(soulCondition)
	end

	-- Store Bonus
	useStaminaXpBoost(self) -- Use store boost stamina

	local Boost = self:getExpBoostStamina()
	local stillHasBoost = Boost > 0
	local storeXpBoostAmount = stillHasBoost and self:getStoreXpBoost() or 0

	self:setStoreXpBoost(storeXpBoostAmount)

	-- Stamina Bonus
	local staminaBoost = 1
	if configManager.getBoolean(configKeys.STAMINA_SYSTEM) then
		useStamina(self)
		local staminaMinutes = self:getStamina()
			if staminaMinutes > 2340 and self:isPremium() then
				staminaBoost = 1.5
			elseif staminaMinutes <= 840 then
				staminaBoost = 0.5 --TODO destroy loot of people with 840- stamina
			end
		self:setStaminaXpBoost(staminaBoost * 100)
	end

	-- Boosted creature
	if target:getName():lower() == (Game.getBoostedCreature()):lower() then
		exp = exp * 2
	end

	-- Prey system
	if configManager.getBoolean(configKeys.PREY_ENABLED) then
		local monsterType = target:getType()
		if monsterType and monsterType:raceId() > 0 then
			exp = math.ceil((exp * self:getPreyExperiencePercentage(monsterType:raceId())) / 100)
		end
	end
	
	
	local baseRate = self:getFinalBaseRateExperience()
	
	
	--local finalExperience
	if configManager.getBoolean(configKeys.RATE_USE_STAGES) then
	   exp = exp * baseRate
	end
	
	local multiplier = self:getExperienceMultiplier()
	if multiplier and multiplier > 0 then
	   exp = exp + (exp * multiplier)
	end
	exp = exp * staminaBoost
	exp = exp + (exp * (storeXpBoostAmount / 100))


	--Familiar Experience
	-- local familiar = getFamiliarByLooktype(self)
	-- if familiar then
	   -- local summon = familiar:getCreature()
	   -- if summon then
	      -- local familiar_experience = FAMILIAR_SYSTEM:getExperience(familiar, target)
		  -- if familiar_experience then
			 -- familiar:addExperience(familiar_experience)
		  -- end
	   -- end
	-- end
	return math.max(exp)
end


-- function Player:onGainExperience(target, exp, rawExp)
	-- if not target or target:isPlayer() then
		-- return exp
	-- end

	-- -- Soul regeneration
	-- local vocation = self:getVocation()
	-- if self:getSoul() < vocation:getMaxSoul() and exp >= self:getLevel() then
		-- soulCondition:setParameter(CONDITION_PARAM_SOULTICKS, vocation:getSoulGainTicks())
		-- self:addCondition(soulCondition)
	-- end

	-- -- Store Bonus
	-- useStaminaXpBoost(self) -- Use store boost stamina

	-- local Boost = self:getExpBoostStamina()
	-- local stillHasBoost = Boost > 0
	-- local storeXpBoostAmount = stillHasBoost and self:getStoreXpBoost() or 0

	-- self:setStoreXpBoost(storeXpBoostAmount)

	-- -- Stamina Bonus
	-- local staminaBonusXp = 1
	-- if configManager.getBoolean(configKeys.STAMINA_SYSTEM) then
		-- useStamina(self)
		-- staminaBonusXp = self:getFinalBonusStamina()
		-- self:setStaminaXpBoost(staminaBonusXp * 100)
	-- end

	-- -- Concoction System
	-- -- useConcoctionTime(self)

	-- -- Boosted creature
	-- if target:getName():lower() == (Game.getBoostedCreature()):lower() then
		-- exp = exp * 2
	-- end

	-- -- Prey system
	-- if configManager.getBoolean(configKeys.PREY_ENABLED) then
		-- local monsterType = target:getType()
		-- if monsterType and monsterType:raceId() > 0 then
			-- exp = math.ceil((exp * self:getPreyExperiencePercentage(monsterType:raceId())) / 100)
		-- end
	-- end

	-- if configManager.getBoolean(configKeys.VIP_SYSTEM_ENABLED) then
		-- local vipBonusExp = configManager.getNumber(configKeys.VIP_BONUS_EXP)
		-- if vipBonusExp > 0 and self:isVip() then
			-- vipBonusExp = (vipBonusExp > 100 and 100) or vipBonusExp
			-- exp = exp * (1 + (vipBonusExp / 100))
		-- end
	-- end

	-- local lowLevelBonuxExp = self:getFinalLowLevelBonus()
	-- local baseRate = self:getFinalBaseRateExperience()

	-- return (exp + (exp * (xpBoostPercent / 100) + (exp * (lowLevelBonuxExp / 100)))) * staminaBonusXp * baseRate
-- end


function Player:onLoseExperience(exp)
	return exp
end

function Player:onGainSkillTries(skill, tries)
	-- Dawnport skills limit
	if  IsRunningGlobalDatapack() and isSkillGrowthLimited(self, skill) then
		return 0
	end
	if APPLY_SKILL_MULTIPLIER == false then
		return tries
	end

	-- Event scheduler skill rate
	local STAGES_DEFAULT = skillsStages or nil
	local SKILL_DEFAULT = self:getSkillLevel(skill)
	local RATE_DEFAULT = configManager.getNumber(configKeys.RATE_SKILL)

	if(skill == SKILL_MAGLEVEL) then -- Magic Level
		-- STAGES_DEFAULT = magicLevelStages or nil
		-- SKILL_DEFAULT = self:getBaseMagicLevel()
		-- RATE_DEFAULT = configManager.getNumber(configKeys.RATE_MAGIC)
		
		-- Magic Level
		if configManager.getBoolean(configKeys.RATE_USE_STAGES) then
			STAGES_DEFAULT = magicLevelStages
		end
		SKILL_DEFAULT = self:getBaseMagicLevel()
		RATE_DEFAULT = configManager.getNumber(configKeys.RATE_MAGIC)
	end

	skillOrMagicRate = getRateFromTable(STAGES_DEFAULT, SKILL_DEFAULT, RATE_DEFAULT)

	if SCHEDULE_SKILL_RATE ~= 100 then
		skillOrMagicRate = math.max(0, (skillOrMagicRate * SCHEDULE_SKILL_RATE) / 100)
	end

	return tries / 100 * (skillOrMagicRate * 100)
end

function Player:onRemoveCount(item)
	self:sendWaste(item:getId())
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

function Player:onCombat(target, item, primaryDamage, primaryType, secondaryDamage, secondaryType)
	if not item or not target then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	if ItemType(item:getId()):getWeaponType() == WEAPON_AMMO then
		if table.contains({ITEM_OLD_DIAMOND_ARROW, ITEM_DIAMOND_ARROW}, item:getId()) then
			return primaryDamage, primaryType, secondaryDamage, secondaryType
		else
			item = self:getSlotItem(CONST_SLOT_LEFT)
		end
	end

	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

function Player:onChangeZone(zone)
	--if self:isPremium() then
		local event = staminaBonus.eventsPz[self:getId()]

		if configManager.getBoolean(configKeys.STAMINA_PZ) then
			if zone == ZONE_PROTECTION then
				if self:getStamina() < 2520 then
					if not event then
						local delay = configManager.getNumber(configKeys.STAMINA_ORANGE_DELAY)
						local value = 0
						if self:getStamina() > 2400 and self:getStamina() <= 2520 then
							delay = configManager.getNumber(configKeys.STAMINA_GREEN_DELAY)
							if self:isGoldenAccount() then
							   value = GOLDEN_ACCOUNT_FEATURES:getStaminaRegeneration()
							   if value and value > 0 then
							      delay = delay - (delay * value)
							   end
							end
						end
                        
						if self:isGoldenAccount() and value > 0 then
						self:sendTextMessage(MESSAGE_STATUS, "Golden Account Profit: Your stamina will regenerate " .. value * 100 .. "% faster In protection zone. \n Every " .. delay .. " minutes, gain " .. configManager.getNumber(configKeys.STAMINA_PZ_GAIN) .. " stamina.")				
						else
						self:sendTextMessage(MESSAGE_STATUS,
                                             string.format("In protection zone. \
                                                           Every %i minutes, gain %i stamina.",
                                                           delay, configManager.getNumber(configKeys.STAMINA_PZ_GAIN)
                                             )
                        )
						end
						staminaBonus.eventsPz[self:getId()] = addEvent(addStamina, delay * 60 * 1000, nil, self:getId(), delay * 60 * 1000)
					end
				end
			else
				if event then
					self:sendTextMessage(MESSAGE_STATUS, "You are no longer refillling stamina, \z
                                         since you left a regeneration zone.")
					stopEvent(event)
					staminaBonus.eventsPz[self:getId()] = nil
				end
			end
			return not configManager.getBoolean(configKeys.STAMINA_PZ)
		end
	--end
	return false
end
