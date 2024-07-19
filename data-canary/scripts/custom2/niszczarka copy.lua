------ CONSTANTS
-- constants for choiceId
SHREDDER_CATEGORY_AMULETS = 1
SHREDDER_CATEGORY_RINGS = 2
SHREDDER_CATEGORY_HELMETS = 3
SHREDDER_CATEGORY_ARMORS = 4
SHREDDER_CATEGORY_LEGS = 5
SHREDDER_CATEGORY_BOOTS = 6
SHREDDER_CATEGORY_SHIELDS = 7
SHREDDER_CATEGORY_CLUBS = 8
SHREDDER_CATEGORY_SWORDS = 9
SHREDDER_CATEGORY_AXES = 10
SHREDDER_CATEGORY_DISTANCE = 11
SHREDDER_CATEGORY_AMMO = 12
SHREDDER_CATEGORY_WANDS = 13
SHREDDER_CATEGORY_RODS = 14

-- string equivalents
do
	local categoryNames = {
		[SHREDDER_CATEGORY_AMULETS] = "Amulets",
		[SHREDDER_CATEGORY_RINGS] = "Rings",
		[SHREDDER_CATEGORY_HELMETS] = "Helmets",
		[SHREDDER_CATEGORY_ARMORS] = "Armors",
		[SHREDDER_CATEGORY_LEGS] = "Legs",
		[SHREDDER_CATEGORY_BOOTS] = "Boots",
		[SHREDDER_CATEGORY_SHIELDS] = "Shields",
		[SHREDDER_CATEGORY_CLUBS] = "Weapons: Clubs",
		[SHREDDER_CATEGORY_SWORDS] = "Weapons: Swords",
		[SHREDDER_CATEGORY_AXES] = "Weapons: Axes",
		[SHREDDER_CATEGORY_DISTANCE] = "Weapons: Distance",
		[SHREDDER_CATEGORY_AMMO] = "Weapons: Ammunition",
		[SHREDDER_CATEGORY_WANDS] = "Weapons: Wands",
		[SHREDDER_CATEGORY_RODS] = "Weapons: Rods",
	}
	function getShredderCategoryName(categoryId)
		return categoryNames[categoryId]
	end
end

------ CONFIG
ShredderRequiredStorage = {80014, 1} -- key, value required to use

SHREDDER_CATEGORY_STORAGE = 80015
SHREDDER_CHOICE_STORAGE = 80016

SHREDDER_MODAL_CATEGORY = 80000
SHREDDER_MODAL_CHOICE = 80001
SHREDDER_MODAL_CONFIRM = 80002
SHREDDER_MODAL_ERROR = 80003

ShredderFromPos = Position(912, 1137, 7)
ShredderToPos = Position(914, 1137, 7)

ShredderMeta = {
	[SHREDDER_CATEGORY_AMULETS] = {
	[1] = {itemId = 2171, itemCount = 1, output = {{29346, 4}, {2148, 1}}},
	[2] = {itemId = 3080, itemCount = 1, output = {{29346, 4}, {2148, 1}}},
	},
	[SHREDDER_CATEGORY_RINGS] = {
	[1] = {itemId = 36141, itemCount = 1, output = {{29346, 4}, {2148, 1}}},
	},
	[SHREDDER_CATEGORY_HELMETS] = {
	[1] = {itemId = 27647, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
	[2] = {itemId = 5741, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
	},
	[SHREDDER_CATEGORY_ARMORS] = {
	[1] = {name = "fireborn giant armor", itemId = 8053, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
	[2] = {name = "ethno coat", itemId = 8064, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
    [3] = {name = "furious frock", itemId = 19391, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
	[4] = {name = "gnome armor", itemId = 27648, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
	[5] = {name = "voltage armor", itemId = 8051, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
	[6] = {name = "lavos armor", itemId = 8049, itemCount = 1, output = {{29347, 4}, {2148, 1}}},	
	[7] = {name = "earthborn titan armor", itemId = 8054, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
	},
	[SHREDDER_CATEGORY_LEGS] = {
	[1] = {name = "gnome legs", itemId = 27649, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
	},
	[SHREDDER_CATEGORY_BOOTS] = {
	[1] = {name = "pair of nightmare boots", itemId = 32619, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
	},
	[SHREDDER_CATEGORY_SHIELDS] = {
	[1] = {name = "rose shield", itemId = 3427, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
	[2] = {name = "gnome shield", itemId = 27650, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
	[3] = {name = "runic ice shield", itemId = 19363, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
	},
	[SHREDDER_CATEGORY_CLUBS] = {
	[1] = {name = "scythe of the reaper", itemId = 9384, itemCount = 1, output = {{29345, 4}, {2148, 1}}},
	[2] = {name = "silver mace", itemId = 3312, itemCount = 1, output = {{29345, 4}, {2148, 1}}},
	[3] = {name = "thunder hammer", itemId = 3309, itemCount = 1, output = {{29345, 4}, {2148, 1}}},
	[4] = {name = "amber staff", itemId = 7426, itemCount = 1, output = {{29345, 4}, {2148, 1}}},
    },
	[SHREDDER_CATEGORY_SWORDS] = {
	[1] = {name = "gnome sword", itemId = 27651, itemCount = 1, output = {{29345, 4}, {2148, 1}}},
	},
	[SHREDDER_CATEGORY_AXES] = {},
	[SHREDDER_CATEGORY_DISTANCE] = {
	[1] = {name = "icicle bow", itemId = 19362, itemCount = 1, output = {{29345, 4}, {2148, 1}}},
	},
	[SHREDDER_CATEGORY_AMMO] = {},
	[SHREDDER_CATEGORY_WANDS] = {
    [1] = {name = "deepling ceremonial dagger", itemId = 28825, itemCount = 1, output = {{29345, 4}, {2148, 1}}},
	},
	[SHREDDER_CATEGORY_RODS] = {},
}

function Player:onShredderFail(reason)
	local m = ModalWindow(SHREDDER_MODAL_ERROR)
	m:setTitle("Error")
	m:setMessage(reason and reason:len() > 0 and reason or "This action is unavailable.")
	m:addButton(2, "Ok") -- "cancel" button id actually
	m:setDefaultEnterButton(2)
	m:setDefaultEscapeButton(2)
	m:sendToPlayer(self)
	
	-- reset ui
	self:setStorageValue(SHREDDER_CATEGORY_STORAGE, -1)
	self:setStorageValue(SHREDDER_CHOICE_STORAGE, -1)
end

------ MODAL FRONTEND
-- categories selection
function Player:sendShredderUIMain()
	local m = ModalWindow(SHREDDER_MODAL_CATEGORY, "Scrap Item", "Select the category of item you wish to destroy:")
	m:addButton(1, "Ok")
	m:addButton(2, "Cancel")
	m:setDefaultEnterButton(1)
	m:setDefaultEscapeButton(2)

	for categoryId = 1, #ShredderMeta do
		if ShredderMeta[categoryId] and #ShredderMeta[categoryId] > 0 then
			m:addChoice(categoryId, getShredderCategoryName(categoryId))
		end
	end
	
	m:sendToPlayer(self)
end

-- category options
function Player:sendShredderUICategory()
	local selectedCategoryId = self:getStorageValue(SHREDDER_CATEGORY_STORAGE)
	local m = ModalWindow(SHREDDER_MODAL_CHOICE)
	
	if selectedCategoryId == -1 or not ShredderMeta[selectedCategoryId] or #ShredderMeta[selectedCategoryId] == 0 then
		self:onShredderFail()
		return
	end
	
	m:setTitle("Scrap Item")
	m:setMessage("Select the item you wish to destroy:")

	-- choices
	local selectedCategory = ShredderMeta[selectedCategoryId]
	for choiceId = 1, #selectedCategory do
		m:addChoice(choiceId, ItemType(selectedCategory[choiceId].itemId):getName())
	end
	
	m:addButton(1, "Ok")
	m:addButton(2, "Cancel")
	m:setDefaultEnterButton(1)
	m:setDefaultEscapeButton(2)	
	m:sendToPlayer(self)
end

-- confirm selection
function Player:sendShredderUIConfirm()
	local selectedCategory = self:getStorageValue(SHREDDER_CATEGORY_STORAGE)
	local selectedChoice = self:getStorageValue(SHREDDER_CHOICE_STORAGE)
	
	if selectedCategory == -1 or selectedChoice == -1 or not ShredderMeta[selectedCategory] or not ShredderMeta[selectedCategory][selectedChoice] then
		self:onShredderFail()
		return
	end

	local shredderAction = ShredderMeta[selectedCategory][selectedChoice]
	local itemType = ItemType(shredderAction.itemId)
	if not itemType or itemType:getId() == 0 then
		self:onShredderFail()
		return
	end
	
	local count = shredderAction.itemCount or 1

	local m = ModalWindow(SHREDDER_MODAL_CONFIRM)
	m:setTitle("Scrap Item")
	local itemStr = itemType:getName()
	if count ~= 1 then
		itemStr = string.format("%dx %s", count, itemStr)
	end
	
	local components = {}
	for _, itemData in pairs(shredderAction.output) do
		local tmpItemType = ItemType(itemData[1])
		if tmpItemType and tmpItemType:getId() ~= 0 then
			local itemCount = itemData[2] or 1
			if itemCount > 0 then
				local componentStr = tmpItemType:getName()
				if itemCount > 1 then
					componentStr = string.format("%dx %s", itemCount, componentStr)
				end
				
				componentStr = string.format("\n- %s", componentStr)
				components[#components + 1] = componentStr
			end
		end
	end
	
	m:setMessage(string.format("Item%s to destroy:\n- %s\n\nComponents to retreive:%s\n\nContinue?", count == 1 and "" or "s", itemStr, table.concat(components, "")))
	m:addButton(1, "Yes")
	m:addButton(2, "No")
	m:setDefaultEnterButton(1)
	m:setDefaultEscapeButton(2)
	m:sendToPlayer(self)
end

-- confirm reaction
function Player:useShredder()
	-- can use shredder?
	if self:getStorageValue(ShredderRequiredStorage[1]) < ShredderRequiredStorage[2] then
		self:onShredderFail("You are not permitted to use the shredder yet.")
		return
	end
	
	-- is around shredder?
	if not self:getPosition():isInRange(ShredderFromPos, ShredderToPos) then
		self:onShredderFail("You are too far from the shredder.")
		return
	end
	
	-- is valid choice?
	local selectedCategory = self:getStorageValue(SHREDDER_CATEGORY_STORAGE)
	local selectedChoice = self:getStorageValue(SHREDDER_CHOICE_STORAGE)
	if selectedCategory == -1 or selectedChoice == -1 or not ShredderMeta[selectedCategory] or not ShredderMeta[selectedCategory][selectedChoice] then
		self:onShredderFail()
		return
	end
	
	-- is real item?
	local shredderAction = ShredderMeta[selectedCategory][selectedChoice]
	local itemType = ItemType(shredderAction.itemId)
	if not itemType or itemType:getId() == 0 then
		self:onShredderFail()
		return
	end

	local targetCount = shredderAction.itemCount
	
	-- get player bp
	local bp = self:getSlotItem(CONST_SLOT_BACKPACK)
	if not bp then
		if targetCount == 1 then
			self:onShredderFail("You do not have selected item.")
		else
			self:onShredderFail("You do not have enough items.")		
		end
		return
	end

	-- search item(s) in bp
	local tmpCount = 0
	local foundItems = {}
	
	local bpItems = bp:getItems(true)
	for _, containerItem in pairs(bpItems) do
		if containerItem:getId() == shredderAction.itemId then
			tmpCount = tmpCount + containerItem:getCount()
			foundItems[#foundItems + 1] = containerItem
			
			if tmpCount >= targetCount then
				break
			end
		end
	end
	
	-- check if enough items were found
	if #foundItems == 0 or tmpCount < targetCount then
		if targetCount == 1 then
			self:onShredderFail("You do not have selected item.")
		else
			self:onShredderFail("You do not have enough items.")		
		end
		return
	end
	
	-- remove items
	for i = 1, #foundItems do
		if targetCount <= 0 then
			break
		end
		
		local currentItem = foundItems[i]
		local stackSize = currentItem:getCount()
		local amountToRemove = math.min(targetCount, stackSize)
		currentItem:remove(amountToRemove)
		targetCount = targetCount - amountToRemove
	end
	
	-- add items
	for _, rewardData in pairs(shredderAction.output) do
		self:addItem(rewardData[1], rewardData[2])
	end
end

------ MODAL BACKEND
do
	local mw = CreatureEvent("shredderModal")
	function mw.onModalWindow(player, modalWindowId, buttonId, choiceId)  
		if buttonId ~= 1 then
			-- button other than ok was pressed
			return
		end
		
		if modalWindowId == SHREDDER_MODAL_CATEGORY then
			-- selected category
			player:setStorageValue(SHREDDER_CATEGORY_STORAGE, choiceId)
			player:sendShredderUICategory()
		elseif modalWindowId == SHREDDER_MODAL_CHOICE then
			-- selected choice
			player:setStorageValue(SHREDDER_CHOICE_STORAGE, choiceId)
			player:sendShredderUIConfirm()
		elseif modalWindowId == SHREDDER_MODAL_CONFIRM then
			-- selected yes/no
			player:useShredder()
		elseif modalWindowId == SHREDDER_MODAL_ERROR then
			-- error window / do nothing
		end
	end
	mw:register()
end
do
	local playerLogin = CreatureEvent("shredderLogin")
	function playerLogin.onLogin(player)
		--player:registerEvent("shredderModal")
		return true
	end
	playerLogin:register()
end

------ UI LAUNCHER
do
	local shredderUse = Action()
	shredderUse.onUse = function(player, item, fromPos, itemEx, toPos)
		-- can use shredder?
		if player:getStorageValue(ShredderRequiredStorage[1]) < ShredderRequiredStorage[2] then
			player:onShredderFail("You do not know how to use this yet.")
			return true
		end
	
		player:sendShredderUIMain()
		return true
	end
	shredderUse:id(22308)
	shredderUse:register()
end

