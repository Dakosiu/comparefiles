local statPointsChest = Action()
local aidBase = 11500

function statPointsChest.onUse(player, item, fromPosition, target, toPosition,
                               isHotkey)
    local aid = item.actionid
    local uid = item.uniqueid
    local amount = aid - aidBase
    local storage = 0
    for v, k in pairs(item:getPosition()) do storage = storage + k end
    storage = storage + aidBase
    if player:getStorageValue(storage) > 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR,
                               "This storage is being used in another quest.")
        return false
    end
    if player:getStorageValue(storage) < 1 then
        player:setStorageValue(storage, 1)
        if player:getStorageValue(STATS_POINT) == -1 then
            player:sendTextMessage(MESSAGE_EVENT_DEFAULT,
                                   "You received " .. amount .. " stats point.")
            player:sendTextMessage(MESSAGE_INFO_DESCR,
                                   "Points are used in !points you can increase your attributes like damage, health, reflect using those, explore more using !points.")
            player:addStatsPoint(amount + 1)
        else
            player:addStatsPoint(amount)
            player:sendTextMessage(MESSAGE_INFO_DESCR,
                                   "You received " .. amount .. " stats point.")
        end
        player:SME(31)
        return true
    end
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Its empty.")
    player:SME(CONST_ME_POFF)
end

for i = 1, 100 do statPointsChest:aid(aidBase + i) end
statPointsChest:register()

-- local ec = EventCallback

-- function ec.onMoveItem(player, item, count, fromPosition, toPosition,
                       -- fromCylinder, toCylinder)
    -- for i = 1, 100 do
        -- if item.actionid == aidBase + i then
            -- return RETURNVALUE_NOTPOSSIBLE
        -- end
    -- end
    -- return RETURNVALUE_NOERROR
-- end

-- ec:register( --[[0]] )
