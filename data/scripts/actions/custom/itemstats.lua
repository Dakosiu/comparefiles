local function generateChance(value)
    local number = math.random(0, 100)

    if number <= value then return true end

    return false
end

local storage = 452342457
local storage2 = storage + 1

local action = Action()
function action.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)

    local pos = player:getPosition()

    local removebonus = ITEM_STATS_CONFIG.BONUS_REMOVER
    if item:getId() == removebonus then
        
		if not player:canUseFromGround(itemEx) or not player:canUseFromGround(item) then
		               player:sendTextMessage(MESSAGE_STATUS_WARNING,
                                   "this item cannot be used from ground.")
            pos:sendMagicEffect(CONST_ME_POFF)
			return true
		end
		
        -- if fromPosition.z ~= 0 then
            -- player:sendTextMessage(MESSAGE_STATUS_WARNING,
                                   -- "this item cannot be used from ground.")
            -- pos:sendMagicEffect(CONST_ME_POFF)
            -- return true
        -- end

        if next(itemEx:getStats()) == nil then
            player:sendTextMessage(MESSAGE_INFO_DESCR,
                                   "this item have no bonuses to remove.")
            return true
        end

        player:registerEvent("ModalWindow_ItemStats")
        local title = "Item Stats"
        local message = "Bonus List"
        local window = ModalWindow(5000, title, message)
        window:addButton(100, "Remove Bonus")
        window:addButton(101, "Cancel")

        for i, addsocket in pairs(itemEx:getStats()) do
            local text = addsocket:gsub("%;", "")
            window:addChoice(i, text)
        end

        window:setDefaultEnterButton(100)
        window:setDefaultEscapeButton(101)

        player:setStorageValue(storage, itemEx.uid)

        player:setStorageValue(storage2, item:getId())
		
	    itemUpgradeSystem:clean(player)
        itemUpgradeSystem:setToRemove(itemEx, 1)

        window:sendToPlayer(player)
        return true

    end

    local pos = player:getPosition()

    local transfer = ITEM_STATS_CONFIG.BONUS_TRANSFER
    if item:getId() == transfer then

        if fromPosition.z ~= 0 then
            player:sendTextMessage(MESSAGE_STATUS_WARNING,
                                   "this item cannot be used from ground.")
            pos:sendMagicEffect(CONST_ME_POFF)
            return true
        end

        if next(itemEx:getStats()) == nil then
            player:sendTextMessage(MESSAGE_INFO_DESCR,
                                   "this item have no bonuses to remove.")
            return true
        end

        player:registerEvent("ModalWindow_ItemStats")
        local title = "Item Stats"
        local message = "Bonus List"
        local window = ModalWindow(5001, title, message)
        window:addButton(100, "Get Bonus")
        window:addButton(101, "Cancel")

        for i, addsocket in pairs(itemEx:getStats()) do
            local text = addsocket:gsub("%;", "")
            window:addChoice(i, text)
        end

        window:setDefaultEnterButton(100)
        window:setDefaultEscapeButton(101)

        item:setCustomAttribute("Bonus", itemEx.uid)

        player:setStorageValue(storage, itemEx.uid)

        player:setStorageValue(storage2, item:getId())

        window:sendToPlayer(player)
        return true

    end

    local addsocket = ITEM_STATS_CONFIG.ADD_SOCKET[item:getId()]
    if addsocket then

        local it = ItemType(itemEx:getId())
		
		if not it:getRealSlot2() then
		   player:sendTextMessage(MESSAGE_STATUS_WARNING, "You cannot use this item in it.")
		   player:getPosition():sendMagicEffect(CONST_ME_POFF)
		   return false
		end
		
		-- print("IT Armor: " .. it:getArmor())
        -- if it:getWeaponType() == WEAPON_NONE or it:getArmor() ~= 0 or it:getDefense() ~= 0 then
            -- player:sendTextMessage(MESSAGE_STATUS_WARNING, "You cannot use this item in it.")
            -- player:getPosition():sendMagicEffect(CONST_ME_POFF)
            -- return false
        -- end

        if not itemEx or not itemEx:getMaxSockets() then return true end

        if itemEx:getMaxSockets() == ITEM_STATS_CONFIG.SLOT_MAX then
            player:sendTextMessage(ITEM_STATS_CONFIG.ADD_SOCKET.Events.MaxSlots
                                       .type, ITEM_STATS_CONFIG.ADD_SOCKET
                                       .Events.MaxSlots.text)
            return true
        end

        if generateChance(addsocket.chance) then
            itemEx:setMaxSockets(itemEx:getMaxSockets() + 1)
            pos:sendMagicEffect(ITEM_STATS_CONFIG.ADD_SOCKET.Events.Success
                                    .effect)
            player:sendTextMessage(ITEM_STATS_CONFIG.ADD_SOCKET.Events.Success
                                       .type, ITEM_STATS_CONFIG.ADD_SOCKET
                                       .Events.Success.text)
        else
            pos:sendMagicEffect(ITEM_STATS_CONFIG.ADD_SOCKET.Events.Failed
                                    .effect)
            player:sendTextMessage(ITEM_STATS_CONFIG.ADD_SOCKET.Events.Failed
                                       .type, ITEM_STATS_CONFIG.ADD_SOCKET
                                       .Events.Failed.text)
        end
        item:remove(1)

        return true
    end

    local experienceGem = ITEM_STATS_CONFIG.ADD_BONUS["Experience Gem"].itemid
    if item:getId() == experienceGem then

        if itemEx:getFreeSockets() == 0 then
            player:sendTextMessage(ITEM_STATS_CONFIG.ADD_BONUS.Events.NoSocket
                                       .type, ITEM_STATS_CONFIG.ADD_BONUS.Events
                                       .NoSocket.text)
            return true
        end

        local addbonus = ITEM_STATS_CONFIG.ADD_BONUS["Experience Gem"]
        value = math.random(addbonus.maxExperience.min,
                            addbonus.maxExperience.max) .. "%"
        itemEx:addStat("Experience", "+" .. value)
        pos:sendMagicEffect(ITEM_STATS_CONFIG.ADD_BONUS.Events.Success.effect)
        player:sendTextMessage(ITEM_STATS_CONFIG.ADD_BONUS.Events.Success.type,
                               ITEM_STATS_CONFIG.ADD_BONUS.Events.Success.text)
        player:updateStats()
        item:remove(1)

        return true
    end

    local addbonus = ITEM_STATS_CONFIG.ADD_BONUS[item:getId()]
    if addbonus then

        if itemEx:getFreeSockets() == 0 then
            player:sendTextMessage(ITEM_STATS_CONFIG.ADD_BONUS.Events.NoSocket
                                       .type, ITEM_STATS_CONFIG.ADD_BONUS.Events
                                       .NoSocket.text)
            return true
        end

        local _chance = addbonus.chance
        if _chance then
            if not generateChance(addbonus.chance) then
                pos:sendMagicEffect(ITEM_STATS_CONFIG.ADD_BONUS.Events.Failed
                                        .effect)
                player:sendTextMessage(
                    ITEM_STATS_CONFIG.ADD_BONUS.Events.Failed.type,
                    ITEM_STATS_CONFIG.ADD_BONUS.Events.Failed.text)
                item:remove(1)
                return true
            end
        end

        -- local bonus = ITEM_STATS_CONFIG.AVAIBLE_BONUSES[math.random(1, #ITEM_STATS_CONFIG.AVAIBLE_BONUSES)]
        local bonus = ITEM_STATS_BONUSES[math.random(1, #ITEM_STATS_BONUSES)]

        local value = 0
        local _bonusSelected = false

        if bonus == STAT_HP then
            value = math.random(addbonus.maxHealth.min, addbonus.maxHealth.max)
            _bonusSelected = true
        elseif bonus == STAT_MP then
            value = math.random(addbonus.maxMana.min, addbonus.maxMana.max)
            _bonusSelected = true
        elseif bonus == STAT_EXPERIENCE then
            value = math.random(addbonus.maxExperience.min,
                                addbonus.maxExperience.max) .. "%"
            _bonusSelected = true
        elseif bonus == STAT_LOOTRATE then
            value = math.random(addbonus.maxLootRate.min,
                                addbonus.maxLootRate.max) .. "%"
            _bonusSelected = true
        end

        if not _bonusSelected then
            value = math.random(1, addbonus.maxStats)
        end

        itemEx:addStat(bonus, "+" .. value)
        pos:sendMagicEffect(ITEM_STATS_CONFIG.ADD_BONUS.Events.Success.effect)
        player:sendTextMessage(ITEM_STATS_CONFIG.ADD_BONUS.Events.Success.type,
                               ITEM_STATS_CONFIG.ADD_BONUS.Events.Success.text)
        player:updateStats()
        item:remove(1)
        return true
    end

    return true
end

for i, addsocket in pairs(ITEM_STATS_CONFIG.ADD_SOCKET) do action:id(i) end

action:id(30523)
action:id(30524)
action:id(30525)

action:id(ITEM_STATS_CONFIG.BONUS_REMOVER)
action:id(ITEM_STATS_CONFIG.BONUS_TRANSFER)
action:id(ITEM_STATS_CONFIG.ADD_BONUS["Experience Gem"].itemid)

action:register()

