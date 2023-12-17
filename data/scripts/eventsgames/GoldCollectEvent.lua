if 💛 then
    -- Reload Case
    💛:setState('⏹️')
    if 💛.DEBUG then
        print("[Dream Of Gold]: Reloaded")
    end
end

💛 = {}

💛.DEBUG = true
💛.COMMAND = '!golddream'
💛.DESCRIPTION = 'Dream Of Gold Event!'
--💛:VERSION: 1.0
--💛:AUTHOR: 𝓜𝓲𝓵𝓵𝓱𝓲𝓸𝓻𝓮 𝓑𝓣
💛.MAX_MC = 3
💛.MIN_LEVEL = 22
💛.MIN_PLAYERS = 1
💛.MAX_PLAYERS = 5

--[[
    🆔: The item id
    💸: The amount of items
    🎲: The chance of getting the item
    🔝: Only for top # player
]]--
💛.REWARD_BAG = 'cake backpack'
💛.REWARD_BAG_REMOVE_EFFECT = CONST_ME_CAKE
💛.REWARDS = {
    -- Default:
    { 🆔 = 'crystal coin', 💸 = 100 },
    { 🆔 = 'crystal coin', 💸 = 50, 🎲 = 50 },
    { 🆔 = 'boots of haste', 🎲 = 50 },

    -- TOP 1:
    { 🆔 = 'magic plate armor', 🔝 = 1 },
    { 🆔 = 'magic plate armor', 🔝 = 1 },
    { 🆔 = 'magic plate armor', 🔝 = 1 },

    -- TOP 2:
    { 🆔 = 'magic plate armor', 🔝 = 2 },

    -- TOP 3:
    { 🆔 = 'dragon scale mail', 🔝 = 3 }
}

--[[
    🆔: The item id
    💸: The score gained
    🎲: The chance of generating the item
    🚷: Only usable.
    🌈: Animated Number Colour
]]--
💛.SCORE_ITEMS = {
    { 🆔 = 'gold coin', 💸 = 1, 🎲 = 100, 🌈 = TEXTCOLOR_YELLOW },
    { 🆔 = 'platinum coin', 💸 = 2, 🎲 = 50, 🌈 = TEXTCOLOR_LIGHTGREY },
    { 🆔 = 2160, 💸 = 3, 🎲 = 25, 🌈 = TEXTCOLOR_LIGHTBLUE },
    { 🆔 = 5675, 💸 = 1000, 🎲 = 2, 🚷 = true, 🌈 = TEXTCOLOR_YELLOW }
}

-- ActionID used by [🚷 = true] score items
💛.SCORE_ITEM_USABLE_ACTIONID = 77771

💛.SCORE_ITEM_UPDATE = 25 -- When there are 25% of score items on the map the map is refilled.
💛.PLAYER_SPEED = 300
💛.JOIN_TIME = 10
💛.WAIT_TIME = 10
💛.PREPARE_TIME = 10
💛.GAME_TIME = 60 * 5
💛.FINISH_TIME = 10

-- Multiplier for the score gained when a player gives a score item.
💛.🎛MIN = 1
💛.🎛MAX = 10

-- Automatic calculate the speed
💛.PLAYER_SPEED = 💛.PLAYER_SPEED * 2
💛.EVENTS = {}
💛.SCOREBOARD = {}
💛.SCOREBOARD_TOP_COUNT = 10 -- The amount of top players to show on the scoreboard.
💛.SCORE_ITEM_COUNT = 0
💛.SCORE_ITEM_COUNT_MAX = 0

-- Using a 24-hour clock (23) [00-23]
💛.SCHEDULE = {
    "12:00:00",
    "17:00:00",
    "19:00:00"
}

--[[ STATES:
    ⏹️: Stopped
    🔴: Started
    🔵: Waiting for players
    📋: Preparing
    🔶: In progress
    🔷: Finished
]]
💛.STATE = '⏹️'

💛.GAMEAREA = {
    fromPos = Position(2, 2109, 7),
    toPos = Position(24, 2131, 7)
}

💛.LOBBYAREA = {
    fromPos = Position(28, 2105, 7),
    toPos = Position(37, 2111, 7)
}

💛.EXIT_POSITION = Position(68, 2084, 7)

💛.GAMEPOSITIONS = {}
for x = 💛.GAMEAREA.fromPos.x, 💛.GAMEAREA.toPos.x do
    for y = 💛.GAMEAREA.fromPos.y, 💛.GAMEAREA.toPos.y do
        for z = 💛.GAMEAREA.fromPos.z, 💛.GAMEAREA.toPos.z do
            💛.GAMEPOSITIONS[#💛.GAMEPOSITIONS + 1] = Position(x, y, z)
        end
    end
end

-- Auto-calculate the game area
💛.GAMEAREA.width = 💛.GAMEAREA.toPos.x - 💛.GAMEAREA.fromPos.x
💛.GAMEAREA.height = 💛.GAMEAREA.toPos.y - 💛.GAMEAREA.fromPos.y
💛.GAMEAREA.center = Position(💛.GAMEAREA.fromPos.x + 💛.GAMEAREA.width / 2, 💛.GAMEAREA.fromPos.y + 💛.GAMEAREA.height / 2, 💛.GAMEAREA.fromPos.z)

-- Auto-calculate the lobby area
💛.LOBBYAREA.width = 💛.LOBBYAREA.toPos.x - 💛.LOBBYAREA.fromPos.x
💛.LOBBYAREA.height = 💛.LOBBYAREA.toPos.y - 💛.LOBBYAREA.fromPos.y
💛.LOBBYAREA.center = Position(💛.LOBBYAREA.fromPos.x + 💛.LOBBYAREA.width / 2, 💛.LOBBYAREA.fromPos.y + 💛.LOBBYAREA.height / 2, 💛.LOBBYAREA.fromPos.z)

💛.CHECK_IP = {}

💛.getRandomPos = function (💛, area)
    local x = math.random(area.fromPos.x, area.toPos.x)
    local y = math.random(area.fromPos.y, area.toPos.y)
    local z = math.random(area.fromPos.z, area.toPos.z)
    local randomTile = Tile(x, y, z)
    local now = os.mtime()
    while not randomTile or not randomTile:isWalkable() or randomTile:getCreatureCount() ~= 0 do
        x = math.random(area.fromPos.x, area.toPos.x)
        y = math.random(area.fromPos.y, area.toPos.y)
        z = math.random(area.fromPos.z, area.toPos.z)
        randomTile = Tile(x, y, z)
        if os.mtime() - now > 20 then
            if 💛.DEBUG then
                print("[Dream Of Gold - Warning]: 💛.getRandomPos valid tile not found.")
            end
            return
        end
    end
    return Position(x, y, z)
end

💛.getGamePlayers = function (💛)
    local rangeX = 💛.GAMEAREA.width / 2
    local rangeY = 💛.GAMEAREA.height / 2
    return Game.getSpectators(💛.GAMEAREA.center, false, true, rangeX, rangeX, rangeY, rangeY)
end

💛.getLobbyPlayers = function (💛)
    local rangeX = 💛.LOBBYAREA.width / 2
    local rangeY = 💛.LOBBYAREA.height / 2
    return Game.getSpectators(💛.LOBBYAREA.center, false, true, rangeX, rangeX, rangeY, rangeY)
end

💛.addEvent = function (💛, 💠, ⌚, ...)
    if not 💠(💛, ⌚, ...) and ⌚ > 0 then
        💛.EVENTS[#💛.EVENTS + 1] = addEvent(💛.addEvent, 1000, 💛, 💠, ⌚ - 1, ...)
    end
end

💛.setState = function (💛, newState)
    if newState == '⏹️' then
        💛.STATE = '⏹️'
        if 💛.DEBUG then
            print('[Dream Of Gold - Info]: Dream of Gold event stopped.')
        end
        💛:stopEvent()
    elseif newState == '🔴' then
        💛.STATE = '🔴'
        if 💛.DEBUG then
            print('[Dream Of Gold - Info]: Dream of Gold event started.')
        end
        💛:startEvent()
    elseif newState == '🔵' then
        💛.STATE = '🔵'
        if 💛.DEBUG then
            print('[Dream Of Gold - Info]: Dream of Gold event waiting for players.')
        end
        💛:waitForPlayers()
    elseif newState == '📋' then
        💛.STATE = '📋'
        if 💛.DEBUG then
            print('[Dream Of Gold - Info]: Dream of Gold event preparing.')
        end
        💛:prepareEvent()
    elseif newState == '🔶' then
        💛.STATE = '🔶'
        if 💛.DEBUG then
            print('[Dream Of Gold - Info]: Dream of Gold event in progress.')
        end
        💛:startGame()
    elseif newState == '🔷' then
        💛.STATE = '🔷'
        if 💛.DEBUG then
            print('[Dream Of Gold - Info]: Dream of Gold event finished.')
        end
        💛:finishEvent()
    end
end

💛.broadcastMessage = function (💛, message, ...)
    for _, player in pairs(Game.getPlayers()) do
        player:sendTextMessage(MESSAGE_INFO_DESCR, message:format(...))
    end
end

💛.broadcastGame = function (💛, message, ...)
    for _, gamePlayer in pairs(💛:getGamePlayers()) do
        gamePlayer:sendTextMessage(MESSAGE_INFO_DESCR, message:format(...))
    end
end

💛.broadcastLobby = function (💛, message, ...)
    for _, lobbyPlayer in pairs(💛:getLobbyPlayers()) do
        lobbyPlayer:sendTextMessage(MESSAGE_INFO_DESCR, message:format(...))
    end
end

💛.getTime = function (💛, ⌚)
    if ⌚ < 1 then
        return '0 second'
    end

    local seconds = ⌚ % 60
    local minutes = (⌚ - seconds) / 60
    if seconds > 0 and minutes > 0 then
        return string.format("%d minute%s and %d second%s", minutes, minutes > 1 and 's' or '', seconds, seconds > 1 and 's' or '')
    elseif minutes > 0 then
        return string.format("%d minute%s", minutes, minutes == 1 and '' or 's')
    elseif seconds > 0 then
        return string.format("%d second%s", seconds, seconds == 1 and '' or 's')
    end
end

💛.createItems = function (💛)
    for _, position in pairs(💛.GAMEPOSITIONS) do repeat
        local tile = Tile(position)
        if not tile or tile:getItemCount() ~= 0 then
            break
        end

        local now = os.mtime()
        while true do
            if os.mtime() - now > 20 then
                if 💛.DEBUG then
                    print("[Dream Of Gold - Warning]: 💛.createItems valid score item not found.")
                end
                return
            end

            local scoreItemIndex = math.random(#💛.SCORE_ITEMS)
            local scoreItem = 💛.SCORE_ITEMS[scoreItemIndex]
            if scoreItem and math.random(100) <= scoreItem.🎲 then
                local it = ItemType(scoreItem.🆔)
                if it then
                    local item = Game.createItem(scoreItem.🆔, it:isStackable() and math.random(100) or 1, position)
                    if item then
                        if scoreItem.🚷 then
                            item:setCustomAttribute('scoreItemIndex', scoreItemIndex)
                        end
                        item:setActionId(💛.SCORE_ITEM_USABLE_ACTIONID)
                        💛.SCORE_ITEM_COUNT = 💛.SCORE_ITEM_COUNT + 1
                    end
                    break
                end
            end
        end
    until true end
    💛.SCORE_ITEM_COUNT_MAX = 💛.SCORE_ITEM_COUNT
end

💛.getScoreboard = function (💛)
    local scoreboard = {}
    for playerGuid, score in pairs(💛.SCOREBOARD) do
        local player = Player(playerGuid)
        if player then
            scoreboard[#scoreboard + 1] = {
                name = player:getName(),
                💸 = score.💸
            }
        end
    end
    table.sort(scoreboard, function (a, b)
        return a.💸 > b.💸
    end)
    local description = {}
    for index = 1, 💛.SCOREBOARD_TOP_COUNT do
        local score = scoreboard[index]
        if score then
            description[#description + 1] = string.format('%d. %s - %d', index, score.name, score.💸)
        end
    end
    return table.concat(description, "\n")
end

💛.startEvent = function (💛)
    💛:broadcastMessage(string.format("[Dream of Gold] event opened.\nIn <green>%s seconds you can type <blue>%s join to join the event.\n\nRules:\n1. <yellow>The collection efficiency will be affected a little if you change your speed in the game.", 💛.JOIN_TIME, 💛.COMMAND))
    💛:addEvent(function (💛, ⌚)
        if ⌚ == 0 then
            💛:setState('🔵')
        end
    end, 💛.JOIN_TIME)
end

💛.waitForPlayers = function (💛)
    💛:addEvent(function (💛, ⌚)
        if ⌚ == 0 then
            local lobbyPlayers = 💛:getLobbyPlayers()
            if #lobbyPlayers < 💛.MIN_PLAYERS then
                💛:setState('⏹️')
                💛:broadcastMessage("[Dream of Gold] event stopped.")
                return
            end
            💛:setState('📋')
            return
        end
        local lobbyPlayers = 💛:getLobbyPlayers()
        if #lobbyPlayers >= 💛.MAX_PLAYERS then
            💛:setState('📋')
            return true
        end
        if ⌚ % math.floor(💛.WAIT_TIME / 4) == 0 then
            💛:broadcastMessage("[Dream of Gold] event waiting for players.\nType <blue>%s join to join the event.\nIn <green>%s the event will start.", 💛.COMMAND, 💛:getTime(⌚))
        end
    end, 💛.WAIT_TIME)
end

💛.prepareEvent = function (💛)
    💛:broadcastMessage("[Dream of Gold] event started.")
    💛:createItems()
    💛:addEvent(function (💛, ⌚)
        if ⌚ == 0 then
            💛:setState('🔶')
        elseif ⌚ % math.floor(💛.PREPARE_TIME / 4) == 0 then
            💛:broadcastLobby("[Dream of Gold] event in preparing.\nIn <green>%s the game will start.", 💛:getTime(⌚))
        end
    end, 💛.PREPARE_TIME)
end

💛.startGame = function (💛)
    -- lobbyPlayers send to game
    for _, lobbyPlayer in pairs(💛:getLobbyPlayers()) do
        local randomPos = 💛:getRandomPos(💛.GAMEAREA)
        if not randomPos then
            return
        end

        💛.SCOREBOARD[lobbyPlayer:getGuid()] = { 💸 = 0, 🎛 = 1 }
        lobbyPlayer:removeCondition(CONDITION_HASTE)
        local speed = lobbyPlayer:getSpeed()
        if speed ~= 💛.PLAYER_SPEED then
            lobbyPlayer:changeSpeed(💛.PLAYER_SPEED - speed)
        end
        lobbyPlayer:teleportTo(randomPos, false)
        randomPos:sendMagicEffect(CONST_ME_TELEPORT)
    end

    💛:addEvent(function (💛, ⌚)
        local gamePlayers = 💛:getGamePlayers()
        if #gamePlayers == 0 then
            💛:setState('⏹️')
            💛:broadcastMessage("[Dream of Gold] event stopped.")
            if 💛.DEBUG then
                print("[Dream Of Gold > Stopped]: No players in game.")
            end
            return true
        else
            for _, lobbyPlayer in pairs(gamePlayers) do
                local speed = lobbyPlayer:getSpeed()
                if speed ~= 💛.PLAYER_SPEED then
                    local score = 💛.SCOREBOARD[lobbyPlayer:getGuid()]
                    if score.🎛 < 💛.🎛MAX and speed > 💛.PLAYER_SPEED then
                        lobbyPlayer:removeCondition(CONDITION_HASTE)
                        lobbyPlayer:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
                        lobbyPlayer:sendCancelMessage("The efficiency of collection will be affected shortly.")
                        score.🎛 = math.min(score.🎛 + 1, 💛.🎛MAX)
                    end
                end
            end
        end

        if ⌚ == 0 then
            💛:setState('🔷')
        elseif ⌚ % math.floor(💛.GAME_TIME / 4) == 0 then
            💛:broadcastGame("[Dream of Gold] event in progress.\nIn <green>%s the event will finish.", 💛:getTime(⌚))
        elseif ⌚ % math.floor(💛.GAME_TIME / 8) == 0 then
            💛:broadcastGame("[Dream of Gold] Scoreboard:\n\n%s", 💛:getScoreboard())
        end

        -- Automatic create score items
        if 💛.SCORE_ITEM_COUNT / 💛.SCORE_ITEM_COUNT_MAX < 💛.SCORE_ITEM_UPDATE / 100 then
            💛:createItems()
            if 💛.DEBUG then
                print("[Dream Of Gold - Debug]: Automatic create score items.")
            end
        end
    end, 💛.GAME_TIME)
end

💛.finishEvent = function (💛)
    -- Stoped players
    for playerGuid, score in pairs(💛.SCOREBOARD) do
        local player = Player(playerGuid)
        if player then
            player:setMovementBlocked(true)
            player:setDirection(DIRECTION_SOUTH)
        end
    end
    -- Clear event
    for _, position in pairs(💛.GAMEPOSITIONS) do
        local tile = Tile(position)
        if tile then
            for _, item in pairs(tile:getItems()) do
                item:remove()
            end
        end
    end
    💛.SCORE_ITEM_COUNT = 0
    💛.SCORE_ITEM_COUNT_MAX = 0
    💛:broadcastMessage("[Dream of Gold] event finished.")
    💛:addEvent(function (💛, ⌚)
        if ⌚ == 0 then
            💛:sendRewards()
            💛:setState('⏹️')
            if 💛.DEBUG then
                print("[Dream Of Gold - Debug]: Stop event and send rewards.")
            end
        else
            💛:broadcastGame("[Dream of Gold] Scoreboard:\n\n%s", 💛:getScoreboard())
            for playerGuid, score in pairs(💛.SCOREBOARD) do
                local player = Player(playerGuid)
                if player then
                    player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
                end
            end
        end
    end, 💛.FINISH_TIME)
end

💛.sendRewards = function (💛)
    local scoreboard = {}
    for playerGuid, score in pairs(💛.SCOREBOARD) do
        scoreboard[#scoreboard + 1] = {
            playerGuid = playerGuid,
            💸 = score.💸
        }
    end
    table.sort(scoreboard, function (a, b)
        return a.💸 > b.💸
    end)
    for 🔝, score in pairs(scoreboard) do
        local player = Player(score.playerGuid)
        if player then
            local rewardBag = Game.createItem(💛.REWARD_BAG, 1)
            if rewardBag then
                rewardBag:setAttribute(ITEM_ATTRIBUTE_NAME, "Dream of Gold - Reward")
                rewardBag:setCustomAttribute("DreamOfGoldRewardBag", true)
                for _, rewardIt in pairs(💛.REWARDS) do repeat
                    if rewardIt.🎲 and math.random(100) > rewardIt.🎲 then
                        break
                    end
                    if rewardIt.🔝 and rewardIt.🔝 ~= 🔝 then
                        break
                    end
                    local it = ItemType(rewardIt.🆔)
                    if not it or it:getId() == 0 then
                        if 💛.DEBUG then
                            print("[Dream Of Gold - Debug]: Reward item not found: " .. rewardIt.🆔)
                        end
                        break
                    end
                    local reward = Game.createItem(rewardIt.🆔, it:isStackable() and math.min(100, math.max(1, rewardIt.💸 or 1)) or 1)
                    if reward then
                        rewardBag:addItemEx(reward, FLAG_NOLIMIT)
                    end
                until true end
                local returnValue = player:addItemEx(rewardBag)
                if returnValue ~= RETURNVALUE_NOERROR then
                    local inbox = player:getInbox()
                    if inbox then
                        inbox:addItemEx(rewardBag, INDEX_WHERETHER, FLAG_NOLIMIT)
                        player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("You are the TOP %d and your received in your inbox:\n%s", 🔝, rewardBag:getContentDescription()))
                    end
                else
                    player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("You are the TOP %d and your received:\n%s", 🔝, rewardBag:getContentDescription()))
                end
            end
        end
    end
end

💛.stopEvent = function (💛)
    for _, eventId in pairs(💛.EVENTS) do
        stopEvent(eventId)
    end
    💛.EVENTS = {}
    if 💛.SCORE_ITEM_COUNT ~= 0 or 💛.SCORE_ITEM_COUNT_MAX ~= 0 then
        -- Clear event
        for _, position in pairs(💛.GAMEPOSITIONS) do
            local tile = Tile(position)
            if tile then
                for _, item in pairs(tile:getItems()) do
                    item:remove()
                end
            end
        end
        💛.SCORE_ITEM_COUNT = 0
        💛.SCORE_ITEM_COUNT_MAX = 0
    end
    💛.CHECK_IP = {}
    local lobbyPlayers = 💛:getLobbyPlayers()
    for _, lobbyPlayer in pairs(lobbyPlayers) do
        lobbyPlayer:teleportTo(💛.EXIT_POSITION, false)
    end
    local gamePlayers = 💛:getGamePlayers()
    for _, gamePlayer in pairs(gamePlayers) do
        gamePlayer:removeCondition(CONDITION_HASTE)
        local speed = gamePlayer:getSpeed()
        local baseSpeed = gamePlayer:getBaseSpeed()
        if speed ~= baseSpeed then
            gamePlayer:changeSpeed(baseSpeed - speed)
        end
        gamePlayer:teleportTo(💛.EXIT_POSITION, false)
        gamePlayer:setMovementBlocked(false)
    end
    💛.SCOREBOARD = {}
    if #lobbyPlayers > 0 or #gamePlayers > 0 then
        💛.EXIT_POSITION:sendMagicEffect(CONST_ME_TELEPORT)
    end
end

local 📣 = TalkAction(💛.COMMAND)

📣.onSay = function (player, words, param, type)
    if param == 'join' then
        if 💛.STATE == '⏹️' then
            player:sendCancelMessage("[Dream Of Gold]: The event is closed.")
            return false
        elseif 💛.STATE ~= '🔵' then
            player:sendCancelMessage("[Dream Of Gold]: The event is not waiting for players.")
            return false
        end

        if player:getLevel() < 💛.MIN_LEVEL then
            player:sendCancelMessage("[Dream Of Gold]: You need level " .. 💛.MIN_LEVEL .. " or higher to join.")
            return false
        end

        local 🏷 = player:getIp()
        local MC = 💛.CHECK_IP[🏷] or 0
        if (MC - 1) >= 💛.MAX_MC then
            player:sendCancelMessage("[Dream Of Gold]: You have reached the maximum number of players.")
            return false
        end

        local lobbyPlayers = 💛:getLobbyPlayers()
        if #lobbyPlayers >= 💛.MAX_PLAYERS then
            player:sendCancelMessage("[Dream Of Gold]: The event is full.")
            return false
        end

        for _, lobbyPlayer in pairs(lobbyPlayers) do
            if lobbyPlayer:getGuid() == player:getGuid() then
                player:sendCancelMessage("[Dream Of Gold]: You are already in the lobby.")
                return false
            end
        end

        local randomPos = 💛:getRandomPos(💛.LOBBYAREA)
        if not randomPos then
            if 💛.DEBUG then
                print("[Dream Of Gold - Debug]: No random position found in lobby area.")
            end
            return false
        end

        💛.CHECK_IP[🏷] = MC + 1
        player:teleportTo(randomPos, false)
        randomPos:sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "[Dream Of Gold]: You have been teleported to the lobby.")
        return false
    elseif param == "leave" then
        if 💛.STATE == '⏹️' then
            player:sendCancelMessage("[Dream Of Gold]: The event is closed.")
            return false
        elseif 💛.STATE == '🔵' then
            for _, lobbyPlayer in pairs(💛:getLobbyPlayers()) do
                if lobbyPlayer:getGuid() == player:getGuid() then
                    player:teleportTo(💛.EXIT_POSITION, false)
                    💛.EXIT_POSITION:sendMagicEffect(CONST_ME_TELEPORT)
                    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "[Dream Of Gold]: You have been teleported to the exit.")
                    local 🏷 = player:getIp()
                    local MC = 💛.CHECK_IP[🏷] or 0
                    if MC > 0 then
                        💛.CHECK_IP[🏷] = MC - 1
                    end
                    return false
                end
            end
            player:sendCancelMessage("[Dream Of Gold]: You are not in the lobby.")
            return false
        elseif 💛.STATE == '🔶' then
            for _, gamePlayer in pairs(💛:getGamePlayers()) do
                if gamePlayer:getGuid() == player:getGuid() then
                    player:teleportTo(💛.EXIT_POSITION, false)
                    💛.EXIT_POSITION:sendMagicEffect(CONST_ME_TELEPORT)
                    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "[Dream Of Gold]: You have been teleported to the exit.")
                    local 🏷 = player:getIp()
                    local MC = 💛.CHECK_IP[🏷] or 0
                    if MC > 0 then
                        💛.CHECK_IP[🏷] = MC - 1
                    end
                    return false
                end
            end
            player:sendCancelMessage("[Dream Of Gold]: You are not in the game.")
            return false
        end
        return false
    elseif param == "start" then
        if player:getAccountType() < ACCOUNT_TYPE_GOD then
            if player:getGroup():getAccess() then
                player:sendCancelMessage("[Dream Of Gold]: You don't have enough rights.")
            end
            return false
        end

        if 💛.STATE ~= '⏹️' then
            player:sendCancelMessage("[Dream Of Gold]: The event already started.")
            return false
        end

        💛:setState('🔴')
        return false
    elseif param == "stop" then
        if player:getAccountType() < ACCOUNT_TYPE_GOD then
            if player:getGroup():getAccess() then
                player:sendCancelMessage("[Dream Of Gold]: You don't have enough rights.")
            end
            return false
        end

        if 💛.STATE == '⏹️' then
            player:sendCancelMessage("[Dream Of Gold]: The event is closed.")
            return false
        end

        💛:setState('⏹️')
        💛:broadcastMessage("[Dream of Gold] event stopped.")
        return false
    elseif param == "finish" then
        if player:getAccountType() < ACCOUNT_TYPE_GOD then
            if player:getGroup():getAccess() then
                player:sendCancelMessage("[Dream Of Gold]: You don't have enough rights.")
            end
            return false
        end

        if 💛.STATE ~= '🔶' then
            player:sendCancelMessage("[Dream Of Gold]: The event is not in progress.")
            return false
        end

        💛:setState('🔷')
        return false
    end

    player:popupFYI(string.format("%s\n\nCommands:\n1. %s join - To join game.\n2. %s leave - Leave the game.%s", 💛.DESCRIPTION, 💛.COMMAND, 💛.COMMAND, (player:getAccountType() >= ACCOUNT_TYPE_GOD and string.format("\n3. %s start - Start game.\n4. %s stop - Stop game.\n5. %s finish - Finish game.", 💛.COMMAND, 💛.COMMAND, 💛.COMMAND) or "")))
    return false
end

📣:separator(" ")
📣:register()

local 🏃 = MoveEvent()

🏃.onStepIn = function (creature, item, pos, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local tile = Tile(pos)
    if not tile or 💛.STATE ~= '🔶' then
        return true
    end

    for _, it in pairs(💛.SCORE_ITEMS) do
        local foundItem = tile:getItemById(it.🆔)
        if foundItem and not it.🚷 then
            local score = 💛.SCOREBOARD[player:getGuid()]
            if not score then
                if 💛.DEBUG then
                    print(string.format("[Dream Of Gold]: Player %s has no score.", player:getName()))
                end
                return true
            end

            local scoreGained = (it.💸 * foundItem:getCount()) / score.🎛
            score.💸 = score.💸 + scoreGained
            player:sendTextMessage(MESSAGE_EXPERIENCE_OTHERS, nil, pos, scoreGained, it.🌈, 0, TEXTCOLOR_NONE)
            foundItem:remove()
            💛.SCORE_ITEM_COUNT = 💛.SCORE_ITEM_COUNT - 1
            return true
        end
    end
    return true
end

🏃:position(unpack(💛.GAMEPOSITIONS))
🏃:register()

local 🎬 = Action()

🎬.onUse = function (player, item, fromPos, target, toPos, isHotkey)
    if 💛.STATE ~= '🔶' then
        return true
    end

    local scoreItemIndex = item:getCustomAttribute("scoreItemIndex")
    if not scoreItemIndex then
        return true
    end

    local scoreItem = 💛.SCORE_ITEMS[scoreItemIndex]
    if not scoreItem then
        return true
    end

    local score = 💛.SCOREBOARD[player:getGuid()]
    if not score then
        if 💛.DEBUG then
            print(string.format("[Dream Of Gold]: Player %s has no score.", player:getName()))
        end
        return true
    end

    local scoreGained = scoreItem.💸 / score.🎛
    score.💸 = score.💸 + scoreGained
    player:sendTextMessage(MESSAGE_EXPERIENCE_OTHERS, nil, fromPos, scoreGained, scoreItem.🌈, 0, TEXTCOLOR_NONE)
    item:remove()
    💛.SCORE_ITEM_COUNT = 💛.SCORE_ITEM_COUNT - 1
    return true
end

🎬:aid(💛.SCORE_ITEM_USABLE_ACTIONID)
🎬:register()

for _, time in pairs(💛.SCHEDULE) do
    local 📡 = GlobalEvent(string.format("DreamOfGoldTimer_%s", time))

    📡.onTime = function (interval)
        if 💛.STATE ~= '⏹️' then
            if 💛.DEBUG then
                print("[Dream Of Gold]: Try to start the event but the event is already running.")
            end
            return
        end
        💛:setState('🔴')
        return true
    end

    📡:time(time)
    📡:register()
end

local ♐ = EventCallback

♐.onMoveItem = function (player, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
    if toCylinder:isItem() and toCylinder:getCustomAttribute("DreamOfGoldRewardBag") then
        -- You dont want to move items to the reward bag.
        return RETURNVALUE_NOTPOSSIBLE
    end

    if 💛.SCOREBOARD[player:getGuid()] then
        if item:getActionId() == 💛.SCORE_ITEM_USABLE_ACTIONID then
            -- You dont want to move score items.
            return RETURNVALUE_NOTPOSSIBLE
        end
        local topParent = Item.getTopParent(toCylinder) or toCylinder
        local topParentIsPlayer = topParent:isCreature() and topParent:getId() == player:getId()
        local fromParent = Item.getTopParent(fromCylinder) or fromCylinder
        local fromParentIsPlayer = fromParent:isCreature() and fromParent:getId() == player:getId()
        if topParentIsPlayer and not fromParentIsPlayer then
            -- You dont want to move items from the ground to your inventory.
            return RETURNVALUE_NOTPOSSIBLE
        elseif fromParentIsPlayer and not topParentIsPlayer then
            -- You dont want to move items from your inventory to the ground.
            return RETURNVALUE_NOTPOSSIBLE
        end
    end
    return RETURNVALUE_NOERROR
end

♐:register(-666)

local ♋ = EventCallback

♋.onItemMoved = function (player, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
    if fromCylinder and fromCylinder:isItem() and fromCylinder:getCustomAttribute("DreamOfGoldRewardBag") and #fromCylinder:getItems() == 0 then
        fromCylinder:remove()
        player:getPosition():sendMagicEffect(💛.REWARD_BAG_REMOVE_EFFECT)
        -- Reward Bag removed.
    end
end

♋:register(-666)

local ec = EventCallback

function ec.onTradeRequest(player, target, item)
    if item:getActionId() == 💛.SCORE_ITEM_USABLE_ACTIONID then
        player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        return false
    end
    return true
end

ec:register(-666)
