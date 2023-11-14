-- config (things player see, safe to edit anytime)
STAT_SYSTEM_CONFIG = {
    slotsOutputFormat = "[%s %s]", -- this item has %s stat modified by %s value
    emptySlotSymbol = "[ ]" -- available slot symbol
}

-- WARNING: changing values below after system launch may damage previously upgraded items
-- attributes config (things player don't see)
CUSTOM_ATTRIBUTE_STATS = "stats2"
CUSTOM_ATTRIBUTE_SOCKETS = "sockets"
-- stat separators, common characters that are unlikely to appear in stat systems
SLOT_SEPARATOR = "`"
SLOT_VALUE_SEPARATOR = ";"

-- stat names configuration
STAT_HP = "HP"
STAT_MP = "MP"

-- skills
STAT_MAGICLEVEL = "MLvl"
STAT_MELEE = "Melee"
STAT_FIST = "Fist"
STAT_CLUB = "Club"
STAT_SWORD = "Sword"
STAT_AXE = "Axe"
STAT_DISTANCE = "Distance"
STAT_SHIELDING = "Shielding"
STAT_FISHING = "Fishing"
-- other
STAT_CRIT = "Crit"
STAT_CRITCHANCE = "Crit%"
STAT_LIFELEECH = "LifeLeech"
STAT_LIFELEECHCHANCE = "LifeLeech%"
STAT_MANALEECH = "ManaLeech"
STAT_MANALEECHCHANCE = "ManaLeech%"
-- regeneration
STAT_HPREGEN = "HP Regeneration"
STAT_MPREGEN = "MP Regeneration"
STAT_EXPERIENCE = "Experience"
STAT_LOOTRATE = "Loot Rate"
-- custom

STAT_SYSTEM_STATTABLE = {
    STAT_HP, STAT_MP, STAT_MAGICLEVEL, STAT_MELEE, STAT_FIST, STAT_CLUB,
    STAT_SWORD, STAT_AXE, STAT_DISTANCE, STAT_SHIELDING, STAT_FISHING,
    STAT_CRIT, STAT_CRITCHANCE, STAT_LIFELEECH, STAT_LIFELEECHCHANCE, -- hp leech
    STAT_MANALEECH, STAT_MANALEECHCHANCE, -- mana leech  
    STAT_HPREGEN, STAT_MPREGEN, STAT_EXPERIENCE, STAT_LOOTRATE
}

STAT_SYSTEM_CONDITIONTABLE = {
    -- regular stats
    [STAT_HP] = {
        type = CONDITION_ATTRIBUTES,
        flat = CONDITION_PARAM_STAT_MAXHITPOINTS,
        percent = CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT
    },
    [STAT_MP] = {
        type = CONDITION_ATTRIBUTES,
        flat = CONDITION_PARAM_STAT_MAXMANAPOINTS,
        percent = CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT
    },

    [STAT_MAGICLEVEL] = {
        type = CONDITION_ATTRIBUTES,
        flat = CONDITION_PARAM_STAT_MAGICPOINTS,
        percent = CONDITION_PARAM_STAT_MAGICPOINTSPERCENT
    },
    [STAT_MELEE] = {
        type = CONDITION_ATTRIBUTES,
        flat = CONDITION_PARAM_SKILL_MELEE,
        percent = CONDITION_PARAM_SKILL_MELEEPERCENT
    },
    [STAT_FIST] = {
        type = CONDITION_ATTRIBUTES,
        flat = CONDITION_PARAM_SKILL_FIST,
        percent = CONDITION_PARAM_SKILL_FISTPERCENT
    },
    [STAT_CLUB] = {
        type = CONDITION_ATTRIBUTES,
        flat = CONDITION_PARAM_SKILL_CLUB,
        percent = CONDITION_PARAM_SKILL_CLUBPERCENT
    },
    [STAT_SWORD] = {
        type = CONDITION_ATTRIBUTES,
        flat = CONDITION_PARAM_SKILL_SWORD,
        percent = CONDITION_PARAM_SKILL_SWORDPERCENT
    },
    [STAT_AXE] = {
        type = CONDITION_ATTRIBUTES,
        flat = CONDITION_PARAM_SKILL_AXE,
        percent = CONDITION_PARAM_SKILL_AXEPERCENT
    },
    [STAT_DISTANCE] = {
        type = CONDITION_ATTRIBUTES,
        flat = CONDITION_PARAM_SKILL_DISTANCE,
        percent = CONDITION_PARAM_SKILL_DISTANCEPERCENT
    },
    [STAT_SHIELDING] = {
        type = CONDITION_ATTRIBUTES,
        flat = CONDITION_PARAM_SKILL_SHIELD,
        percent = CONDITION_PARAM_SKILL_SHIELDPERCENT
    },
    [STAT_FISHING] = {
        type = CONDITION_ATTRIBUTES,
        flat = CONDITION_PARAM_SKILL_FISHING,
        percent = CONDITION_PARAM_SKILL_FISHINGPERCENT
    },
    -- special cases (different starting point for % values)
    [STAT_LIFELEECH] = {
        type = CONDITION_ATTRIBUTES,
        flat = CONDITION_PARAM_SPECIALSKILL_LIFELEECHAMOUNT,
        percent = CONDITION_PARAM_SPECIALSKILL_LIFELEECHAMOUNT,
        specialPercent = true
    },
    [STAT_LIFELEECHCHANCE] = {
        type = CONDITION_ATTRIBUTES,
        flat = CONDITION_PARAM_SPECIALSKILL_LIFELEECHCHANCE,
        percent = CONDITION_PARAM_SPECIALSKILL_LIFELEECHCHANCE,
        specialPercent = true
    },
    [STAT_MANALEECH] = {
        type = CONDITION_ATTRIBUTES,
        flat = CONDITION_PARAM_SPECIALSKILL_MANALEECHAMOUNT,
        percent = CONDITION_PARAM_SPECIALSKILL_MANALEECHAMOUNT,
        specialPercent = true
    },
    [STAT_MANALEECHCHANCE] = {
        type = CONDITION_ATTRIBUTES,
        flat = CONDITION_PARAM_SPECIALSKILL_MANALEECHCHANCE,
        percent = CONDITION_PARAM_SPECIALSKILL_MANALEECHCHANCE,
        specialPercent = true
    },
    [STAT_CRIT] = {
        type = CONDITION_ATTRIBUTES,
        flat = CONDITION_PARAM_SPECIALSKILL_CRITICALHITAMOUNT,
        percent = CONDITION_PARAM_SPECIALSKILL_CRITICALHITAMOUNT,
        specialPercent = true
    },
    [STAT_CRITCHANCE] = {
        type = CONDITION_ATTRIBUTES,
        flat = CONDITION_PARAM_SPECIALSKILL_CRITICALHITCHANCE,
        percent = CONDITION_PARAM_SPECIALSKILL_CRITICALHITCHANCE,
        specialPercent = true
    }
}

if not PLAYERSTATS then PLAYERSTATS = {} end

-- tfs just doesn't have it lol
table.finda = function(table, value)
    for i, v in pairs(table) do if v == value then return i end end
    return false
end

if not itemUpgradeSystem then
    itemUpgradeSystem = {}
    itemUpgradeSystem.markedToRemove = "ITEM_UPGRADE_SYSTEM_REMOVE"
end

function itemUpgradeSystem:setToRemove(item, value)
    if not item or not value then return nil end
    
	if value == 0 then
	   return item:removeCustomAttribute(itemUpgradeSystem.markedToRemove)
	end
	-- local it = ItemType(item:getId())
	-- if not it:isStackable() then
	   -- return nil
	-- end
    
	--print("Ustawiam do remove: " .. item:getName())

    return item:setCustomAttribute(itemUpgradeSystem.markedToRemove, value)
end

function itemUpgradeSystem:shouldRemove(item)
    if not item then return nil end
    if item:getCustomAttribute(itemUpgradeSystem.markedToRemove) == 1 then
        return true
    end
    return false
end

function itemUpgradeSystem:removeItem(player, id)

    if not id or not player then return nil end

    local scanContainers = {}
    local item = nil

    for i = 1, 11 do
        local slotItem = player:getSlotItem(i)
        if slotItem then
            if slotItem:getId() == id then
                slotItem:remove(1)
                return
            end
            if slotItem:isContainer() then
                table.insert(scanContainers, slotItem)
            end
        end
    end

    while #scanContainers > 0 do
        for i = 0, scanContainers[1]:getSize() - 1 do
            local slotItem = scanContainers[1]:getItem(i)
            if slotItem then
                if slotItem:getId() == id then
                    slotItem:remove(1)
                    return
                end
                if slotItem:isContainer() then
                    table.insert(scanContainers, slotItem)
                end
            end
        end
        table.remove(scanContainers, 1)
    end
end

function itemUpgradeSystem:getItem(player, item)

    if not item or not player then return nil end

    local scanContainers = {}

    for i = 1, 11 do
        local slotItem = player:getSlotItem(i)
        if slotItem then
            if slotItem == item then return true end
            if slotItem:isContainer() then
                table.insert(scanContainers, slotItem)
            end
        end
    end

    while #scanContainers > 0 do
        for i = 0, scanContainers[1]:getSize() - 1 do
            local slotItem = scanContainers[1]:getItem(i)
            if slotItem then
                if slotItem == item then return true end
                if slotItem:isContainer() then
                    table.insert(scanContainers, slotItem)
                end
            end
        end
        table.remove(scanContainers, 1)
    end
    return false
end

function itemUpgradeSystem:removeAttribute(player, choiceId)

    if not choiceId or not player then return nil end

    local scanContainers = {}
    local item = nil

    for i = 1, 11 do
        local slotItem = player:getSlotItem(i)
        if slotItem then
            if itemUpgradeSystem:shouldRemove(slotItem) then
                item = slotItem
                break
            end
            if slotItem:isContainer() then
                table.insert(scanContainers, slotItem)
            end
        end
    end

    while #scanContainers > 0 do
        for i = 0, scanContainers[1]:getSize() - 1 do
            local slotItem = scanContainers[1]:getItem(i)
            if slotItem then
                if itemUpgradeSystem:shouldRemove(slotItem) then
                    item = slotItem
                    break
                end
                if slotItem:isContainer() then
                    table.insert(scanContainers, slotItem)
                end
            end
        end
        table.remove(scanContainers, 1)
    end

    if item then
        item:removeStat(choiceId)
		itemUpgradeSystem:setToRemove(item, 0)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have removed bonus.")
        local pos = player:getPosition()
        pos:sendMagicEffect(CONST_ME_MAGIC_RED)
        player:updateStats()
        return true
    end
    return false
end

function itemUpgradeSystem:clean(player)

    if not player then return nil end

    local scanContainers = {}

    for i = 1, 11 do
        local slotItem = player:getSlotItem(i)
        if slotItem then
		    --local it = ItemType(slotItem:getId())
			--if not it:isStackable() then
               itemUpgradeSystem:setToRemove(slotItem, 0)
			--end
            if slotItem:isContainer() then
                  table.insert(scanContainers, slotItem)
			end
        end
    end

    while #scanContainers > 0 do
        for i = 0, scanContainers[1]:getSize() - 1 do
            local slotItem = scanContainers[1]:getItem(i)
            if slotItem then
			    --local it = ItemType(slotItem:getId())
				--if not it:isStackable() then
                   itemUpgradeSystem:setToRemove(slotItem, 0)
				--end
                if slotItem:isContainer() then
                    table.insert(scanContainers, slotItem)
                end
            end
        end
        table.remove(scanContainers, 1)
    end
end

function Item:getMaxSockets()
    return self:getCustomAttribute(CUSTOM_ATTRIBUTE_SOCKETS) or 0
end

function Item:setMaxSockets(amount)
    if type(amount) == "number" then
        return self:setCustomAttribute(CUSTOM_ATTRIBUTE_SOCKETS, amount)
    end

    return false
end

function Item:getStats()
    local slots = self:getCustomAttribute(CUSTOM_ATTRIBUTE_STATS) or ""
    slots = slots:split(SLOT_SEPARATOR)

    return slots
end

function Item:getFreeSockets() return self:getMaxSockets() - #self:getStats() end

function compileItemStats(stats) return table.concat(stats, SLOT_SEPARATOR) end

function string:verifyStatIntegrity()
    local word = self:match("[+-x]?%d+%.?%d*%%?") or ""
    local length = self:len()

    return word:len() == length
end

function Item:addStat(key, value)
    if self:getFreeSockets() > 0 then
        local stats = self:getStats()
        local newStat = key .. SLOT_VALUE_SEPARATOR .. value
        if not value:verifyStatIntegrity() then
            error("Incorrect stat syntax")
        end
        table.insert(stats, newStat)

        local newStats = compileItemStats(stats)
        self:setCustomAttribute(CUSTOM_ATTRIBUTE_STATS, newStats)
        return true
    end

    return false
end

function Item:removeStat(index)
    local stats = self:getStats()

    if index > 0 and index <= #stats then
        table.remove(stats, index)
        local newStats = compileItemStats(stats)
        self:setCustomAttribute(CUSTOM_ATTRIBUTE_STATS, newStats)
        return true
    end

    return false
end

function Item:displayStats()
    if self:getCustomAttribute(CUSTOM_ATTRIBUTE_STATS) or self:getMaxSockets() >
        0 then
        local stats = self:getStats()
        local out = ""

        for _, v in pairs(stats) do
            v = v:split(SLOT_VALUE_SEPARATOR)
            if v[2] then
                out = out ..
                          string.format(STAT_SYSTEM_CONFIG.slotsOutputFormat,
                                        v[1], v[2])
            end
        end

        local freeSlots = self:getFreeSockets()
        if freeSlots > 0 then
            for i = 1, freeSlots do
                out = out .. STAT_SYSTEM_CONFIG.emptySlotSymbol
            end
        end

        return out
    end

    return ""
end

function string:getStatValues()
    local s = self:split(SLOT_VALUE_SEPARATOR)
    local out = {}

    if not s[2] then s[2] = "" end

    out = {
        {
            key = s[1],
            sign = s[2]:match("[+-x]?"),
            amount = s[2]:match("%d+%.?%d*"),
            flat = not s[2]:match("%%")
        }
    }

    return out
end

function ItemType:isWeapon()
    -- NOTE: stackable weapons such as throwing stars and spears are treated as ammunition
    -- ammunition is not supposed to be upgradeable
    -- stackable items with attributes can't be restacked
    return (self:getAttack() > 0 or self:getShootRange() > 1) and
               not self:isStackable()
end

-- doesn't actually apply buffs, just collects values based on player's data
function Player:assignStat(t, statValues)
    local k = statValues.key

    if not t[k] then t[k] = {} end

    if statValues.sign == "-" then statValues.amount = -statValues.amount end

    if statValues.flat then
        if t[k].flat then
            t[k].flat = t[k].flat + statValues.amount
        else
            t[k].flat = statValues.amount
        end
    else
        if t[k].percent then
            t[k].percent = t[k].percent + statValues.amount
        else
            t[k].percent = statValues.amount
        end
    end
end

function Player:getEquipmentStats()
    local newStats = {}

    for i = 1, 10 do
        local item = self:getSlotItem(i)

        if item then
            local stats = item:getStats()
            if #stats > 0 then
                local it = item:getType()
                local weapon = false
                if i == CONST_SLOT_RIGHT or i == CONST_SLOT_LEFT then
                    if it:isWeapon() then weapon = true end
                end

                for j = 1, #stats do
                    local statValues = stats[j]:getStatValues()
                    for k = 1, #statValues do
                        if isInArray(STAT_SYSTEM_STATTABLE, statValues[k].key) then
                            self:assignStat(newStats, statValues[k])
                        end
                    end
                end
            end
        end
    end

    return newStats
end

function calculateBuffValue(player, buffType, buffValue, isFlat)
    local buffData = STAT_SYSTEM_CONDITIONTABLE[buffType]
    if buffData then
        if not isFlat then
            if not buffData.specialPercent then
                buffValue = buffValue + 100
            end
        end

        return buffValue
    end
end

function getConditionStatCode(stat, isFlat)
    local statIndex = table.finda(STAT_SYSTEM_STATTABLE, stat)
    if statIndex then
        return 1 .. (isFlat and 1 or 0) .. (statIndex < 10 and "0" .. statIndex or statIndex)
    end
end

function getStatBuffParam(buffData, isFlat)
    if isFlat then return buffData.flat end

    return buffData.percent
end

function Player:updateStats()
    local cid = self:getId()
    local checklist = {} -- stats to remove in case they aren't in the updated set

    if PLAYERSTATS[cid] then
        for k, v in pairs(PLAYERSTATS[cid]) do checklist[k] = v end
    else
        PLAYERSTATS[cid] = {}
    end

    -- get updated stats
    local newStats = self:getEquipmentStats()
    local updatedStats = {} -- new stats summed

    for stat, value in pairs(newStats) do

        if STAT_SYSTEM_CONDITIONTABLE[stat] then
            local vals = {value.flat, value.percent}

            for i = 1, #vals do
                local isFlat = i == 1
                if vals[i] then
                    local conditionCode = getConditionStatCode(stat, isFlat)

                    if conditionCode then
                        local conditionType =
                            STAT_SYSTEM_CONDITIONTABLE[stat].type

                        if updatedStats[conditionCode] then
                            updatedStats[conditionCode][2] = vals[i] +
                                                                 updatedStats[conditionCode][2]
                        else
                            updatedStats[conditionCode] = {
                                conditionType, vals[i]
                            }
                        end
                    end
                end
            end
        end
    end

    -- apply updated stats
    for conditionCode, conditionValues in pairs(updatedStats) do
        local buffType
        local buffCode = tonumber(conditionCode:sub(-2, -1))

        buffType = STAT_SYSTEM_STATTABLE[buffCode]

        if buffType then
            local isFlat = tonumber(conditionCode:sub(-3, -3)) == 1
            local playerStat = PLAYERSTATS[cid][conditionCode]
            local conditionType = conditionValues[1]
            local ignore = false

            if playerStat then
                if playerStat[2] ~= conditionValues[2] then
                    doRemoveCondition(cid, conditionType, conditionCode)
                else
                    ignore = true -- avoid building already existing condition
                end

                checklist[conditionCode] = nil
            end

            -- build buff condition
            if not ignore then
                local buff = createConditionObject(conditionType)
                local buffValue = calculateBuffValue(self, buffType,
                                                     conditionValues[2], isFlat)
                local buffData = STAT_SYSTEM_CONDITIONTABLE[buffType]

                setConditionParam(buff, getStatBuffParam(buffData, isFlat),
                                  buffValue)

                if buffData.ticks then
                    tickType, tickAmount = buffData.ticks(self)
                    setConditionParam(buff, tickType, tickAmount * 1000)
                end

                setConditionParam(buff, CONDITION_PARAM_TICKS, -1)
                setConditionParam(buff, CONDITION_PARAM_SUBID, conditionCode)
                self:addCondition(buff)
                PLAYERSTATS[cid][conditionCode] = {
                    conditionType, conditionValues[2]
                }
            end
        else
            print(
                "[statSystem] Warning: no buff found for STAT_SYSTEM_STATTABLE code " ..
                    conditionCode:sub(0, -4) .. ", value " ..
                    conditionCode:sub(-2, -1) .. " (condition code: " ..
                    conditionCode .. ")")
        end
    end

    -- remove outdated stats
    for conditionCode, conditionValues in pairs(checklist) do
        doRemoveCondition(cid, conditionValues[1], conditionCode)

        PLAYERSTATS[cid][conditionCode] = nil
    end

    if self:getManaRegeneration() then
        if self:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, 80) then
            self:removeCondition(CONDITION_REGENERATION, 80)
        end

        local value = self:getManaRegeneration()
        local mpregen_condition = Condition(CONDITION_REGENERATION,
                                            CONDITIONID_DEFAULT)
        mpregen_condition:setParameter(CONDITION_PARAM_SUBID, 80)
        mpregen_condition:setTicks(-1)
        mpregen_condition:setParameter(CONDITION_PARAM_MANAGAIN, value)
        mpregen_condition:setParameter(CONDITION_PARAM_MANATICKS, 2000)
        self:addCondition(mpregen_condition)
    else
        if self:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, 80) then
            self:removeCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, 80)
        end
    end

    if self:getHealthRegeneration() then
        if self:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, 81) then
            self:removeCondition(CONDITION_REGENERATION, 81)
        end

        local value = self:getHealthRegeneration()
        local hpregen_condition = Condition(CONDITION_REGENERATION,
                                            CONDITIONID_DEFAULT)
        hpregen_condition:setParameter(CONDITION_PARAM_SUBID, 81)
        hpregen_condition:setTicks(-1)
        hpregen_condition:setParameter(CONDITION_PARAM_HEALTHGAIN, value)
        hpregen_condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 1000)
        self:addCondition(hpregen_condition)
    else
        if self:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, 81) then
            self:removeCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, 81)
        end
    end

end

-- player events hooks
local creatureevent = CreatureEvent("ItemSystem_onLogin")
function creatureevent.onLogin(player)
    -- player:registerEvent("ItemSystemLogin")
    local function updateAgain(playerId)
        local player = Player(playerId)
        if not player then
            return
        end
        player:updateStats()
        addEvent(updateAgain, 3000, player:getId())
    end
    player:updateStats()
    addEvent(updateAgain, 3000, player:getId())
    return true
end
creatureevent:register()

function Player:stat_onItemMoved(item, fromPosition, toPosition)
    if fromPosition.x == 65535 or toPosition.x == 65535 then
        if fromPosition.y <= 10 or toPosition.y <= 10 then
            self:updateStats()
        end
    end
end

-- example:
-- local it = player:addItem(2125, 1)
-- it:setMaxSockets(3)
-- it:addStat("HP", "+2%")
-- it:addStat("Sword", "+2")
-- it:removeStat(2) -- removes sword buff

function getValueFromString(txt)
    local str = ""
    string.gsub(txt, "%d+", function(e) str = str .. e end)
    return str;
end

function tableHasKey(table, key) return table[key] ~= nil end

function Player.getManaRegeneration(self)

    local value = 0
    local stats = self:getEquipmentStats()

    if tableHasKey(stats, "MP Regeneration") then
        local statValue = stats["MP Regeneration"]["flat"]
        if statValue then statValue = tonumber(statValue) end

        value = statValue
    end

    if value <= 0 then return 0 end

    return value
end

function Player.getHealthRegeneration(self)

    local value = 0
    local stats = self:getEquipmentStats()

    if tableHasKey(stats, "HP Regeneration") then
        local statValue = stats["HP Regeneration"]["flat"]
        if statValue then statValue = tonumber(statValue) end

        value = statValue
    end

    if value <= 0 then return 0 end

    return value
end

function Player.getUpgradeExperience(self)

    local value = 0
    local stats = self:getEquipmentStats()

    if tableHasKey(stats, "Experience") then
        local statValue = stats["Experience"]["percent"]
        if statValue then statValue = tonumber(statValue) end

        value = statValue
    end

    if value <= 0 then return 0 end

    return value / 100
end

function Player.getUpgradeLootRate(self)

    local value = 0
    local stats = self:getEquipmentStats()

    if tableHasKey(stats, "Loot Rate") then
        local statValue = stats["Loot Rate"]["percent"]
        if statValue then statValue = tonumber(statValue) end

        value = statValue
    end

    if value <= 0 then return 0 end

    return value / 100
end

function Player:generateSetTest()
    local set = {2125, 2461, 2379, 2467, 2512, 2124, 2649, 2050, 2643}

    for i = 1, #set do
        local it = Item(doPlayerAddItem(self:getId(), set[i], 1))
        it:setMaxSockets(3)
        for j = 1, 3 do
            local value = STAT_SYSTEM_STATTABLE[math.random(1,
                                                            #STAT_SYSTEM_STATTABLE)]
            local percent = math.random(0, 1) == 1 and "%" or ""
            it:addStat(value, "+" .. math.random(1, 100) .. percent)
        end
    end
end