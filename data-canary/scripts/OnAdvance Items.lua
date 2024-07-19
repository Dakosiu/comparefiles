REWARDS_ON_ADVANCE_CONFIG = {
    ["Knight"] = {
        [20] = {
            { type = "item", name = "crystal coin", count = 2 },
        },
        [50] = {
            { type = "item", name = "knight armor", count = 1 },
            { type = "item", name = "knight legs", count = 1 },
            { type = "item", name = "dragon shield", count = 1 },
            { type = "item", name = "warrior helmet", count = 1 },
            { type = "item", name = "crystal coin", count = 5 },
            { type = "item", name = "relic sword", count = 1 },
            { type = "item", name = "northern star", count = 1 },
            { type = "item", name = "Ornamented Axe", count = 1 },
        },
    },
    ["Paladin"] = {
        [20] = {
            { type = "item", name = "crystal coin", count = 2 },
        },
        [50] = {
            { type = "item", name = "knight armor", count = 1 },
            { type = "item", name = "knight legs", count = 1 },
            { type = "item", name = "dragon shield", count = 1 },
            { type = "item", name = "warrior helmet", count = 1 },
            { type = "item", name = "crystal coin", count = 5 },
            { type = "item", name = "Composite Hornbow", count = 1 },
        },
    },
    ["Sorcerer"] = {
        [20] = {
            { type = "item", name = "crystal coin", count = 2 },
        },
        [50] = {
            { type = "item", name = "blue robe", count = 1 },
            { type = "item", name = "blue legs", count = 1 },
            { type = "item", name = "mystic turban", count = 1 },
            { type = "item", name = "crystal coin", count = 5 },
            { type = "item", name = "Wand of Voodoo", count = 1 },
            { type = "item", name = "Spellbook of Enlightenment", count = 1 },
        },
    },
    ["Druid"] = {
        [20] = {
            { type = "item", name = "crystal coin", count = 2 },
        },
        [50] = {
            { type = "item", name = "blue robe", count = 1 },
            { type = "item", name = "blue legs", count = 1 },
            { type = "item", name = "mystic turban", count = 1 },
            { type = "item", name = "crystal coin", count = 5 },
            { type = "item", name = "Underworld Rod", count = 1 },
            { type = "item", name = "Spellbook of Enlightenment", count = 1 },
        },
    },
}

REWARDS_ON_ADVANCE = {}

REWARDS_ON_ADVANCE_CONFIG.storage = 3127313

local VOCATION_PROMOTIONS = {
    ["Knight"] = "Elite Knight",
    ["Paladin"] = "Royal Paladin",
    ["Sorcerer"] = "Master Sorcerer",
    ["Druid"] = "Elder Druid",
}

function REWARDS_ON_ADVANCE:getVocationTable(player)
    local vocationName = player:getVocation():getName():lower()
    for baseVocation, promotion in pairs(VOCATION_PROMOTIONS) do
        if vocationName == baseVocation:lower() or vocationName == promotion:lower() then
            return REWARDS_ON_ADVANCE_CONFIG[baseVocation]
        end
    end
    return false
end

function REWARDS_ON_ADVANCE:getTableByLevel(level, t)
    for i, v in pairs(t) do
        if i == level then
            return v
        end
    end
    return false
end

function REWARDS_ON_ADVANCE:setLastLevel(player, value)
    player:setStorageValue(REWARDS_ON_ADVANCE_CONFIG.storage, value)
end

function REWARDS_ON_ADVANCE:getLastLevel(player)
    local value = player:getStorageValue(REWARDS_ON_ADVANCE_CONFIG.storage)
    if value < 0 then
        return 0
    end
    return value
end

local creatureevent = CreatureEvent("REWARDS_ON_ADVANCE_onAdvance")
function creatureevent.onAdvance(player, skill, oldLevel, newLevel)
    if skill ~= SKILL_LEVEL or newLevel < oldLevel then
        return true
    end

    local lastLevel = REWARDS_ON_ADVANCE:getLastLevel(player)
    for i = oldLevel + 1, newLevel do
        if lastLevel < i or lastLevel == 0 then
            local t = REWARDS_ON_ADVANCE:getVocationTable(player)
            if t then
                local levelTable = REWARDS_ON_ADVANCE:getTableByLevel(i, t)
                if levelTable then
                    dakosLib:addReward(player, levelTable, "By reaching " .. newLevel .. " level.")
                    REWARDS_ON_ADVANCE:setLastLevel(player, i)
                end
            end
        end
    end

    if newLevel > lastLevel then
        REWARDS_ON_ADVANCE:setLastLevel(player, newLevel)
    end

    return true
end
creatureevent:register()

creatureevent = CreatureEvent("REWARDS_ON_ADVANCE_onLogin")
function creatureevent.onLogin(player)
    player:registerEvent("REWARDS_ON_ADVANCE_onAdvance")
    return true
end
creatureevent:register()
