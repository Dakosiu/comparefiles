------ CONSTANTS
-- Constants for choiceId
local SHREDDER_CATEGORIES = {
    AMULETS = 1,
    RINGS = 2,
    HELMETS = 3,
    ARMORS = 4,
    LEGS = 5,
    BOOTS = 6,
    SHIELDS = 7,
    CLUBS = 8,
    SWORDS = 9,
    AXES = 10,
    DISTANCE = 11,
    AMMO = 12,
    WANDS = 13,
    RODS = 14
}

-- String equivalents
local CATEGORY_NAMES = {
    [SHREDDER_CATEGORIES.AMULETS] = "Amulets",
    [SHREDDER_CATEGORIES.RINGS] = "Rings",
    [SHREDDER_CATEGORIES.HELMETS] = "Helmets",
    [SHREDDER_CATEGORIES.ARMORS] = "Armors",
    [SHREDDER_CATEGORIES.LEGS] = "Legs",
    [SHREDDER_CATEGORIES.BOOTS] = "Boots",
    [SHREDDER_CATEGORIES.SHIELDS] = "Shields",
    [SHREDDER_CATEGORIES.CLUBS] = "Weapons: Clubs",
    [SHREDDER_CATEGORIES.SWORDS] = "Weapons: Swords",
    [SHREDDER_CATEGORIES.AXES] = "Weapons: Axes",
    [SHREDDER_CATEGORIES.DISTANCE] = "Weapons: Distance",
    [SHREDDER_CATEGORIES.AMMO] = "Weapons: Ammunition",
    [SHREDDER_CATEGORIES.WANDS] = "Weapons: Wands",
    [SHREDDER_CATEGORIES.RODS] = "Weapons: Rods"
}

local function getCategoryName(categoryId)
    return CATEGORY_NAMES[categoryId]
end

------ CONFIG
local ShredderRequiredStorage = {80014, 1}
local SHREDDER_CATEGORY_STORAGE = 80015
local SHREDDER_CHOICE_STORAGE = 80016

local ShredderPos = Position(913, 1137, 7)

local ShredderMeta = {
    [SHREDDER_CATEGORIES.AMULETS] = {
        {itemId = 3055, itemCount = 1, output = {{29346, 4}, {2148, 1}}},
        {itemId = 3080, itemCount = 1, output = {{29346, 4}, {2148, 1}}},
    },
    [SHREDDER_CATEGORIES.RINGS] = {
        {itemId = 36141, itemCount = 1, output = {{29346, 4}, {2148, 1}}},
    },
    [SHREDDER_CATEGORIES.HELMETS] = {
        {itemId = 27647, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
        {itemId = 5741, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
    },
    [SHREDDER_CATEGORIES.ARMORS] = {
        {itemId = 8053, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
        {itemId = 8064, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
        {itemId = 19391, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
        {itemId = 27648, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
        {itemId = 8051, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
        {itemId = 8049, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
        {itemId = 8054, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
    },
    [SHREDDER_CATEGORIES.LEGS] = {
        {itemId = 27649, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
    },
    [SHREDDER_CATEGORIES.BOOTS] = {
        {itemId = 32619, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
    },
    [SHREDDER_CATEGORIES.SHIELDS] = {
        {itemId = 3427, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
        {itemId = 27650, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
        {itemId = 19363, itemCount = 1, output = {{29347, 4}, {2148, 1}}},
    },
    [SHREDDER_CATEGORIES.CLUBS] = {
        {itemId = 9384, itemCount = 1, output = {{29345, 4}, {2148, 1}}},
        {itemId = 3312, itemCount = 1, output = {{29345, 4}, {2148, 1}}},
        {itemId = 3309, itemCount = 1, output = {{29345, 4}, {2148, 1}}},
        {itemId = 7426, itemCount = 1, output = {{29345, 4}, {2148, 1}}},
    },
    [SHREDDER_CATEGORIES.SWORDS] = {
        {itemId = 27651, itemCount = 1, output = {{29345, 4}, {2148, 1}}},
    },
    [SHREDDER_CATEGORIES.AXES] = {},
    [SHREDDER_CATEGORIES.DISTANCE] = {
        {itemId = 19362, itemCount = 1, output = {{29345, 4}, {2148, 1}}},
    },
    [SHREDDER_CATEGORIES.AMMO] = {},
    [SHREDDER_CATEGORIES.WANDS] = {
        {itemId = 28825, itemCount = 1, output = {{29345, 4}, {2148, 1}}},
    },
    [SHREDDER_CATEGORIES.RODS] = {},
}

function Player:onShredderFail(reason)
    local modalWindow = ModalWindow({
        title = "Error",
        message = reason and reason:len() > 0 and reason or "This action is unavailable.",
    })
    modalWindow:addButton("Ok")

    modalWindow:sendToPlayer(self)

    -- reset ui
    self:setStorageValue(SHREDDER_CATEGORY_STORAGE, -1)
    self:setStorageValue(SHREDDER_CHOICE_STORAGE, -1)
end

------ MODAL FRONTEND
-- categories selection
function Player:sendShredderUIMain()
    local modalWindow = ModalWindow({
        title = "Scrap Item",
        message = "Select the category of item you wish to destroy:",
    })

    for categoryId, items in pairs(ShredderMeta) do
        if #items > 0 then
            modalWindow:addChoice(getCategoryName(categoryId), function(_, button, choice)
                if button.name == "Ok" then
                    self:setStorageValue(SHREDDER_CATEGORY_STORAGE, categoryId)
                    self:sendShredderUICategory()
                end
            end)
        end
    end

    modalWindow:addButton("Ok")
    modalWindow:addButton("Cancel")

    modalWindow:sendToPlayer(self)
end

-- category options
function Player:sendShredderUICategory()
    local selectedCategoryId = self:getStorageValue(SHREDDER_CATEGORY_STORAGE)
    if selectedCategoryId == -1 or not ShredderMeta[selectedCategoryId] or #ShredderMeta[selectedCategoryId] == 0 then
        self:onShredderFail()
        return
    end

    local modalWindow = ModalWindow({
        title = "Scrap Item",
        message = "Select the item you wish to destroy:",
    })

    local selectedCategory = ShredderMeta[selectedCategoryId]
    for choiceId, item in ipairs(selectedCategory) do
        local itemType = ItemType(item.itemId)
        local itemName = itemType:getName()
        modalWindow:addChoice(itemName, function(_, button, choice)
            if button.name == "Ok" then
                self:setStorageValue(SHREDDER_CHOICE_STORAGE, choiceId)
                self:sendShredderUIConfirm()
            end
        end)
    end

    modalWindow:addButton("Ok")
    modalWindow:addButton("Cancel")

    modalWindow:sendToPlayer(self)
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

    local modalWindow = ModalWindow({
        title = "Scrap Item",
        message = string.format("Item%s to destroy:\n- %s\n\nComponents to retrieve:%s\n\nContinue?", count == 1 and "" or "s", itemType:getName(), table.concat(components, "")),
    })

    modalWindow:addChoice("Yes", function(_, button, choice)
        if button.name == "Yes" then
            self:useShredder()
        end
    end)

    modalWindow:addButton("Yes")
    modalWindow:addButton("No")

    modalWindow:sendToPlayer(self)
end

-- confirm reaction
function Player:useShredder()
    -- can use shredder?
    if self:getStorageValue(ShredderRequiredStorage[1]) < ShredderRequiredStorage[2] then
        self:onShredderFail("You are not permitted to use the shredder yet.")
        return
    end

    -- is around shredder?
    if self:getPosition():getDistanceBetween(ShredderPos) > 1 then
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
            self:onShredderFail("You do not have the selected item.")
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
            self:onShredderFail("You do not have the selected item.")
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

------ UI LAUNCHER
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

