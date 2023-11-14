local DailyChest = Action()
local DailyChestBaseAID = 12748

local config = {
    [1] = {
        Position = { 73, 2218, 12 }, 
        Global = false,
        Daily = true,
        Hours = 1,
        Minutes = 999,
        Rewards = {
            Items = { 40554, 25 },
            Storage = 0,
            Experience = 0,
            StatsPoints = 0,
            PremiumPoints = 0,
        },
    },
    [2] = {
        Position = { 844, 872, 5 },-- 1 pacc point masshine
        Global = true,
        Daily = false,
        Hours = 2,
        Minutes = 0,
        Rewards = {
            Items = { 0 },
            Storage = 0,
            Experience = 0,
            StatsPoints = 0,
            PremiumPoints = 1,
        },
    },
	[3] = {
        Position = { 79, 2229, 12 },-- 1 pacc point masshine
        Global = true,
        Daily = false,
        Hours = 2,
        Minutes = 0,
        Rewards = {
            Items = { 0 },
            Storage = 0,
            Experience = 0,
            StatsPoints = 0,
            PremiumPoints = 1,
        },
    },
	[4] = {
        Position = { 48, 2144, 9 },-- 1 pacc point masshine
        Global = true,
        Daily = false,
        Hours = 2,
        Minutes = 0,
        Rewards = {
            Items = { 0 },
            Storage = 0,
            Experience = 0,
            StatsPoints = 0,
            PremiumPoints = 1,
        },
    },
	[5] = {
        Position = { 39, 2134, 9 }, -- 1 pacc point masshine
        Global = true,
        Daily = false,
        Hours = 2,
        Minutes = 0,
        Rewards = {
            Items = { 0 },
            Storage = 0,
            Experience = 0,
            StatsPoints = 0,
            PremiumPoints = 1,
        },
    },
	[6] = {
        Position = { 29, 2138, 9 }, -- 1 pacc point masshine
        Global = true,
        Daily = false,
        Hours = 2,
        Minutes = 0,
        Rewards = {
            Items = { 0 },
            Storage = 0,
            Experience = 0,
            StatsPoints = 0,
            PremiumPoints = 1,
        },
    },
    [7] = {
        Position = { 76, 2218, 12 },
        Global = true,
        Daily = false,
        Hours = 14,
        Minutes = 30,
        Rewards = {
            Items = { 0 },
            Storage = 0,
            Experience = 0,
            StatsPoints = 0,
            PremiumPoints = 1,
        },
    },
    [8] = {
        Position = { 62, 2226, 12 },
        Global = false,
        Daily = false,
        Hours = 48,
        Minutes = 0,
        Rewards = {
            Items = { 2160, 100 },
            Storage = 0,
            Experience = 1000000,
            StatsPoints = 1,
            PremiumPoints = 0,
		},
    },
    [9] = {
        Position = { 73, 2215, 12 },
        Global = false,
        Daily = false,
        Hours = 24,
        Minutes = 0,
        Rewards = {
            Items = { 2160, 25, 40554, 5 },
            Storage = 0,
            Experience = 10000,
            StatsPoints = 0,
            PremiumPoints = 0,
        },
    },
}

local function addRewards(player, value)
    local message = "You received: "
    local a = value.Items
    local b = value
    if a and a[1] > 0 then
        for i = 1, #a, 2 do
            player:addItem(a[i], a[i + 1])
            message = message .. "\nx" .. a[i + 1] .. " " .. getItemName(a[i]) .. ","
        end
    end
    message = string.sub(message, 1, -2) -- remove last comma
    if b.PremiumPoints > 0 then
        local name, accountId = player:getName(), nil
        local resultId = db.storeQuery('SELECT `account_id` FROM `players` WHERE `name` = ' ..
            db.escapeString(name) .. ' LIMIT 1;')
        if resultId ~= false then
            accountId = result.getDataInt(resultId, "account_id")
            result.free(resultId)
        end
        db.query("UPDATE `accounts` SET `premium_points` = `premium_points` + " ..
            b.PremiumPoints .. " WHERE `id` = " .. accountId)
        message = message .. "\n" .. b.PremiumPoints .. " premium points."
    end
    if b.StatsPoints > 0 then
        player:addStatsPoint(b.StatsPoints)
        message = message .. "\n" .. b.StatsPoints .. " stats points."
    end
    if b.Experience > 0 then
        player:addExperience(b.Experience)
        message = message .. "\n" .. b.Experience .. " experience points."
    end
    if b.Storage > 0 then
        player:setStorageValue(b.Storage, 1)
    end
    player:sendTextMessage(MESSAGE_INFO_DESCR, message)
end

function DailyChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local aid = item.actionid
    local a = aid - DailyChestBaseAID
    local b = config[a]
    local time = os.time()
    if b then
        local hrs = b.Hours * 3600
        local mnts = b.Minutes * 60
        local rwd = b.Rewards.Items
        local dly = time + (24 * 3600)
        if b.Daily == true then
            if b.Global == true then
                if getGlobalStorageValue(aid) > os.time() then
                    player:SME(CONST_ME_POFF)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
                        "You still need to wait: " .. timeLeft(getGlobalStorageValue(aid) - os.time(), true) .. ".")
                    return true
                end
                player:SME(39)
                addRewards(player, b.Rewards)
                setGlobalStorageValue(aid, dly)
                return true
            end
            if player:getStorageValue(aid) > os.time() then
                player:SME(CONST_ME_POFF)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
                    "You still need to wait: " .. timeLeft(player:getStorageValue(aid) - os.time(), true) .. ".")
                return true
            end
            player:SME(39)
            addRewards(player, b.Rewards)
            player:setStorageValue(aid, dly)
            return true
        end
        if b.Daily == false then
            local totalTime = os.time() + hrs + mnts
            if b.Global == true then
                if getGlobalStorageValue(aid) > os.time() then
                    player:SME(CONST_ME_POFF)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
                        "You still need to wait: " .. timeLeft(getGlobalStorageValue(aid) - os.time(), true) .. ".")
                    return true
                end
                player:SME(39)
                addRewards(player, b.Rewards)
                setGlobalStorageValue(aid, totalTime)
                return true
            end
            if player:getStorageValue(aid) > os.time() then
                player:SME(CONST_ME_POFF)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
                    "You still need to wait: " .. timeLeft(player:getStorageValue(aid) - os.time(), true) .. ".")
                return true
            end
            player:SME(39)
            addRewards(player, b.Rewards)
            player:setStorageValue(aid, totalTime)
            return true
        end
    end
end

for i in pairs(config) do DailyChest:aid(DailyChestBaseAID + i) end
DailyChest:register()

local globalevent = GlobalEvent("load_DailyChest")

function globalevent.onStartup()
    for i in pairs(config) do
        local a = config[i].Position
        local tile = Tile(Position(a[1], a[2], a[3]))
        if tile then
            local thing = tile:getTopVisibleThing()
            if thing then
                thing:setAttribute(ITEM_ATTRIBUTE_ACTIONID,
                    DailyChestBaseAID + i)
            end
        end
    end
end

globalevent:register()