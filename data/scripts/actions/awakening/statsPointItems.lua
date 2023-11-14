--baseStorage = 99950 --!> 99950--99960

local statsPoint = {
    [41611] = { statsPoint = 1, maxUse = 500, effect = 392, storage = 99950 },
    [34280] = { statsPoint = 20, maxUse = 3, effect = 392, storage = 99951 },
    [36678] = { statsPoint = 5, maxUse = 10, effect = 392, storage = 99952 },
    [36679] = { statsPoint = 10, maxUse = 5, effect = 392, storage = 99953 },
	[34288] = { statsPoint = 1, maxUse = 500, effect = 392, storage = 99954 },
	[34089] = { statsPoint = 5, maxUse = 2, effect = 392, storage = 99955 },
	[34090] = { statsPoint = 20, maxUse = 2, effect = 392, storage = 99956 },
	[34091] = { statsPoint = 50, maxUse = 2, effect = 392, storage = 99957 },
	[34092] = { statsPoint = 100, maxUse = 2, effect = 392, storage = 99958 },
	[41639] = { statsPoint = 15, maxUse = 5, effect = 392, storage = 99959 },
	[32709] = { statsPoint = 10, maxUse = 10, effect = 392, storage = 99960 },
	[36865] = { statsPoint = 5, maxUse = 20, effect = 392, storage = 99961 },
	[9969] = { statsPoint = 1, maxUse = 10, effect = 392, storage = 99962 },
	[36680] = { statsPoint = 25, maxUse = 2, effect = 392, storage = 99963 },
	[5808] = { statsPoint = 2, maxUse = 5, effect = 392, storage = 99964 },
	[12635] = { statsPoint = 5, maxUse = 10, effect = 392, storage = 99965 },
	[11315] = { statsPoint = 5, maxUse = 10, effect = 392, storage = 99966 },
	[6566] = { statsPoint = 10, maxUse = 1, effect = 392, storage = 99967 },
	[11144] = { statsPoint = 10, maxUse = 1, effect = 392, storage = 99968 },
	[26174] = { statsPoint = 1000, maxUse = 100, effect = 392, storage = 99969 },
	[41043] = { statsPoint = 115, maxUse = 100, effect = 392, storage = 99970 },
	[21699] = { statsPoint = 10, maxUse = 1, effect = 392, storage = 99971 },
	[41078] = { statsPoint = 20, maxUse = 1, effect = 392, storage = 99972 },
	[41079] = { statsPoint = 40, maxUse = 1, effect = 392, storage = 99973 },
	[41077] = { statsPoint = 80, maxUse = 1, effect = 392, storage = 99974 },
	[41057] = { statsPoint = 160, maxUse = 1, effect = 392, storage = 99975 },
	[41076] = { statsPoint = 320, maxUse = 1, effect = 392, storage = 99976 },
	[41075] = { statsPoint = 640, maxUse = 1, effect = 392, storage = 99977 },
	[26883] = { statsPoint = 1280, maxUse = 1, effect = 392, storage = 99978 },
	[41110] = { statsPoint = 2560, maxUse = 1, effect = 392, storage = 99979 },
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not player then
        return true
    end

    local itemId = item:getId()
    local it = statsPoint[itemId]
    if player:getStorageValue(it.storage) >= it.maxUse then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "You already used the limit of this item")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received " .. it.statsPoint .. " stats point.")
    item:remove(1)
    player:addStatsPoint(it.statsPoint)
    player:getPosition():sendMagicEffect(it.effect)
    if player:getStorageValue(it.storage) == -1 then
        player:setStorageValue(it.storage, 1)
    else
        player:setStorageValue(it.storage, player:getStorageValue(it.storage) + 1)
    end
    return true
end

for i in pairs(statsPoint) do
    action:id(i)
end
action:register()