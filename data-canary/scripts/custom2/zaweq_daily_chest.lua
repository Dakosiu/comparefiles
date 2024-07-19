local id_of_chest = 24877
local rewards = {
    {id = 3043, amount = 15},
    {id = 32771, amount = 10},
    {id = 29288, amount = 1},
    {id = 29287, amount = 1},
    {id = 29289, amount = 1}
}

local dailyReset = {
    time = "01:00",
    storage = 60010,
    loginTimeStorage = 60011,
    rewardAvailableStorage = 60012,
    requiredLoginMinutes = 60,
}

local DailyChest = Action()
function DailyChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(dailyReset.storage) > 0 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already taken the reward today.")
        return true
    end

    if player:getLevel() < 200 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You need level 200 to take the daily reward!")
        return true
    end
    
    if player:getStorageValue(dailyReset.rewardAvailableStorage) ~= 1 then
        local loginTime = player:getStorageValue(dailyReset.loginTimeStorage)
        local currentTime = os.time()
        local elapsedMinutes = math.floor((currentTime - loginTime) / 60)
        local remainingMinutes = dailyReset.requiredLoginMinutes - elapsedMinutes
        if remainingMinutes > 0 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You need to be logged in for " .. remainingMinutes .. " more continuous minutes to take the daily reward.")
        else
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You need to be logged in for " .. dailyReset.requiredLoginMinutes .. " continuous minutes to take the daily reward.")
        end
        return true
    end

    local selectedReward = rewards[math.random(#rewards)]
    local itemReceived = player:addItem(selectedReward.id, selectedReward.amount)
    player:setStorageValue(dailyReset.storage, 1)
	player:setStorageValue(dailyReset.rewardAvailableStorage, -1)
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have received " .. selectedReward.amount .. "x " .. itemReceived:getName() .. " from the daily chest!")
    return true
end
DailyChest:id(id_of_chest)
DailyChest:register()

dailyReset.canSendReminder = true
local globalevent = GlobalEvent("dailyReset_onThink")
function globalevent.onThink(interval, lastExecution)
    if not dailyReset.canSendReminder then
        return true
    end
    
    local currentTime = os.date("%H:%M")
    if currentTime == dailyReset.time then
        dailyReset.canSendReminder = false
        local players = Game.getPlayers()
        for _, player in ipairs(players) do
            player:setStorageValue(dailyReset.storage, -1)
            player:setStorageValue(dailyReset.loginTimeStorage, -1)
            player:setStorageValue(dailyReset.rewardAvailableStorage, -1)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Daily Chest has been restarted.")

            if not dailyReset.players then
                dailyReset.players = {}
            end
            local guid = player:getGuid()
            if not dailyReset.players[guid] then
                dailyReset.players[guid] = guid
            end
        end
        addEvent(function()
            dailyReset.canSendReminder = true
        end, 1 * 1000 * 60)
    end

    return true
end
globalevent:interval(1000)
globalevent:register()

local creatureeventLogin = CreatureEvent("dailyReset_onLogin")
function creatureeventLogin.onLogin(player)
    local currentTime = os.date("%H:%M")
    
    player:setStorageValue(dailyReset.loginTimeStorage, os.time())
    
    if currentTime < dailyReset.time then
        return true
    end

    if not dailyReset.players then
        return true
    end

    local guid = player:getGuid()
    if dailyReset.players[guid] then
        return true
    end

    if player:getStorageValue(dailyReset.storage) <= 0 then
        return true
    end

    player:setStorageValue(dailyReset.storage, -1)
    player:setStorageValue(dailyReset.loginTimeStorage, -1)
    dailyReset.players[guid] = guid
    player:sendTextMessage(MESSAGE_INFO_DESCR, "Daily Chest has been restarted.")
    return true
end
creatureeventLogin:register()

local globalThinkEvent = GlobalEvent("trackLoginTime_onThink")
function globalThinkEvent.onThink(interval, lastExecution)
    local players = Game.getPlayers()
    for _, player in ipairs(players) do
        local loginTime = player:getStorageValue(dailyReset.loginTimeStorage)
        if loginTime ~= -1 and os.time() - loginTime >= dailyReset.requiredLoginMinutes * 60 then
            player:setStorageValue(dailyReset.rewardAvailableStorage, 1)
        end
    end
    return true
end
globalThinkEvent:interval(60 * 1000)
globalThinkEvent:register()
