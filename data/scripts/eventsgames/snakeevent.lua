--[[ -- SnakeEvent version de Sarah Wesker de otland.net
-- Version: 1.0
-- Fecha de creacion: Martes, 13 de Abril del 2021
-- Requerimientos del servidor:
-- *-> Engine TFS 1.3
-- *-> Revscript
-- *-> EventCallback

if not SnakeEvent or SnakeEvent.state == "stoped" then
    SnakeEvent = {
        talkAction = "/snake",
        misc = {
            exitPosition = Position(68, 2084, 7),
            minPlayers = 2,
            maxPlayers = 10,
            timeEventStart = "21:00:00"
        },
        area = {
            fromPos = Position(111, 1863, 7),
            toPos = Position(215, 1951, 7)
        },
        foods = {
            { itemId = 2674, count = 1, chance = 5 },
            { itemId = 2685, count = 2, chance = 3 },
            { itemId = 2680, count = 3, chance = 2 },
            { itemId = 8844, count = 5, chance = 1 }
        },
        teleport = {
            itemId = 1387,
            actionId = 9999,
            timeDisappear = 120, -- seconds
            position = Position(59, 2083, 7)
        },
        reward = {
            bagId = 1991,
            items = {
                { itemId = 2160, count = 50, chance = 100 },
                { itemId = 27604, count = 1, chance = 100 }
            }
        },
        state = "stoped", -- not modify
        debug = false
    }

    function SnakeEvent.checkCollision(player, tile)
        local playerGuid = player:getGuid()
        for _, info in pairs(SnakeEvent.foods) do
            local food = tile:getItemById(info.itemId)
            if food then
                SnakeEvent.cache.foods[playerGuid] = SnakeEvent.cache.foods[playerGuid] and SnakeEvent.cache.foods[playerGuid] +info.count or info.count
                local position = player:getPosition()
                position:sendMagicEffect(CONST_ME_MAGIC_RED)
                player:say(string.format("+%d", info.count), TALKTYPE_MONSTER_SAY, false, player, position)
                food:remove()
                break
            end
        end

        for _, creature in pairs(tile:getCreatures()) do
            if creature:isPlayer() then
                local food = SnakeEvent.cache.foods[playerGuid]
                local foodOther = SnakeEvent.cache.foods[creature:getGuid()]
                if food > foodOther then
                    return SnakeEvent.kill(player, creature)
                elseif food < foodOther then
                    return SnakeEvent.kill(creature, player)
                elseif math.random(1, 100) >= 50 then
                    return SnakeEvent.kill(player, creature)
                end
                return SnakeEvent.kill(creature, player)
            else
                local other = Player(creature:getMaxHealth())
                if other then
                    return SnakeEvent.kill(other, player)
                end
            end
        end
    end

    function SnakeEvent.kill(player, target)
        SnakeEvent.leave(target)
        if #SnakeEvent.cache.players == 1 then
            local winner = Player(SnakeEvent.cache.players[1])
            if winner then
                SnakeEvent.win(winner)
                SnakeEvent.leave(winner)
                Game.broadcastMessage(string.format("[SnakeEvent] %s is the winner.", winner:getName()))
            end
            return true
        end
        if SnakeEvent.debug then
            print(string.format("[SnakeEvent/Debug] Player %s kill to %s", player:getName(), target:getName()))
        end
        return false
    end

    function SnakeEvent.win(winner)
        local bag = Game.createItem(SnakeEvent.reward.bagId, 1)
        if bag then
            for _, it in pairs(SnakeEvent.reward.items) do
                if it.chance >= math.random(1, 100) then
                    bag:addItem(it.itemId, it.count)
                end
            end
            winner:getInbox():addItemEx(bag, INDEX_WHERETHER, FLAG_NOLIMIT)
            winner:sendTextMessage(MESSAGE_INFO_DESCR, string.format("You reward: %s.\nCheck your inbox!", bag:getContentDescription()))
        end
        if SnakeEvent.debug then
            print(string.format("[SnakeEvent/Debug] %s is the winner.", winner:getName()))
        end
    end

    function SnakeEvent.step(playerGuid)
        local player = Player(playerGuid)
        if not player then
            return
        end
        local position = player:getPosition()
        local destPos = Position(position.x, position.y, position.z)
        local direction = player:getDirection()
        destPos:getNextPosition(direction, 1)
        local wormHoleDir
        if destPos.x < SnakeEvent.area.fromPos.x then
            destPos.x = SnakeEvent.area.toPos.x
            wormHoleDir = DIRECTION_WEST
        elseif destPos.x > SnakeEvent.area.toPos.x then
            destPos.x = SnakeEvent.area.fromPos.x
            wormHoleDir = DIRECTION_EAST
        elseif destPos.y < SnakeEvent.area.fromPos.y then
            destPos.y = SnakeEvent.area.toPos.y
            wormHoleDir = DIRECTION_NORTH
        elseif destPos.y > SnakeEvent.area.toPos.y then
            destPos.y = SnakeEvent.area.fromPos.y
            wormHoleDir = DIRECTION_SOUTH
        end
        local tile = Tile(destPos)
        if tile and tile:isWalkable() then
            if SnakeEvent.checkCollision(player, tile) then
                return SnakeEvent.stop()
            end
            player:teleportTo(destPos, true)
            if wormHoleDir then
                player:setDirection(wormHoleDir)
            end
            local food = SnakeEvent.cache.foods[playerGuid]
            if food > 0 then
                local size = #SnakeEvent.cache.tails[playerGuid]
                local tiles = #SnakeEvent.cache.tiles[playerGuid]
                table.insert(SnakeEvent.cache.tiles[playerGuid], 1, position)
                if size > 0 then
                    for index = 1, size do
                        local copy = SnakeEvent.cache.tails[playerGuid][index]
                        if copy then
                            local toPos = SnakeEvent.cache.tiles[playerGuid][index]
                            if toPos then
                                local currPos = copy:getPosition()
                                copy:teleportTo(toPos, true)
                                for _, target in pairs(copy:getTargetList()) do
                                    copy:removeTarget(target)
                                end
                                if currPos:getDistance(toPos) > 1 then
                                    if currPos.x ~= toPos.x then
                                        copy:setDirection(currPos.x < toPos.x and DIRECTION_WEST or DIRECTION_EAST)
                                    elseif currPos.y ~= toPos.y then
                                        copy:setDirection(currPos.y < toPos.y and DIRECTION_NORTH or DIRECTION_SOUTH)
                                    end
                                end
                            end
                        end
                    end
                end
                if size < food then
                    local createPos = SnakeEvent.cache.tiles[playerGuid][tiles] or position
                    local tail = Game.createMonster("SnakeEvent Tail Ex", createPos)
                    if tail then
                        tail:setMaxHealth(player:getGuid())
                        tail:setOutfit(player:getOutfit())
                        tail:changeSpeed(player:getSpeed())
                        table.insert(SnakeEvent.cache.tails[playerGuid], tail)
                    end
                end
                if tiles > food then
                    if SnakeEvent.debug then
                        SnakeEvent.cache.tiles[playerGuid][tiles]:sendMagicEffect(CONST_ME_POFF)
                    end
                    table.remove(SnakeEvent.cache.tiles[playerGuid], tiles)
                end
            end
        end
    end

    function SnakeEvent.startAutoWalking()
        for _, playerGuid in pairs(SnakeEvent.cache.players) do
            if SnakeEvent.step(playerGuid) then
                return
            end
        end
        SnakeEvent.cache.events[4] = addEvent(SnakeEvent.startAutoWalking, 200)
    end

    function SnakeEvent.createFood()
        local position = Position(
            math.random(SnakeEvent.area.fromPos.x, SnakeEvent.area.toPos.x),
            math.random(SnakeEvent.area.fromPos.y, SnakeEvent.area.toPos.y),
            SnakeEvent.area.fromPos.z)
        local tile = Tile(position)
        if not tile then
            return false
        end
        for index = #SnakeEvent.foods, 1, -1 do
            local info = SnakeEvent.foods[index]
            if info.chance >= math.random(1, 100) then
                if not tile:getItemById(info.itemId) then
                    local food = Game.createItem(info.itemId, 1, position)
                    if food then
                        food:setCustomAttribute("SnakeEvent", info.count)
                        addEvent(function (pos, itemId)
                            local tile = Tile(pos)
                            if tile then
                                local food = tile:getItemById(itemId)
                                if food then
                                    food:remove()
                                    pos:sendMagicEffect(CONST_ME_POFF)
                                end
                            end
                        end, 1000 * 60, position, info.itemId)
                        position:sendMagicEffect(CONST_ME_TELEPORT)
                        return true
                    end
                    if SnakeEvent.debug then
                        print("[SnakeEvent/Debug] a food could not be generated.")
                    end
                end
            end
        end
        return false
    end

    function SnakeEvent.stop(force)
        if force then
            for _, playerGuid in pairs(SnakeEvent.cache.players) do
                local player = Player(playerGuid)
                if player then
                    SnakeEvent.leave(player)
                end
            end
            SnakeEvent.removeTeleport()
        end
        stopEvent(SnakeEvent.cache.events[1]) -- Stop main loop
        stopEvent(SnakeEvent.cache.events[2]) -- Stop teleport Event
        stopEvent(SnakeEvent.cache.events[3]) -- Stop warning messages
        stopEvent(SnakeEvent.cache.events[4]) -- Stop autoWalking
        SnakeEvent.state = "stoped"
        SnakeEvent.clear()
        if SnakeEvent.debug then
            print("[SnakeEvent/Debug] stop game!")
        end
        return true
    end

    function SnakeEvent.loop()
        SnakeEvent.createFood()
        SnakeEvent.cache.events[1] = addEvent(SnakeEvent.loop, 1000)
        return true
    end

    local monster = {}
    monster.description = "a snake tail ex"
    monster.experience = 0
    monster.outfit = {
        lookTypeEx = 7910
    }

    monster.health = 1
    monster.maxHealth = monster.health
    monster.race = "undead"
    monster.corpse = 0
    monster.speed = 350
    monster.maxSummons = 0

    monster.flags = {
        healthHidden = true,
        summonable = false,
        attackable = false,
        hostile = false,
        convinceable = false,
        illusionable = false,
        canPushItems = false,
        pushable = false,
        canPushCreatures = false,
        isBlockable = false,
        canWalkOnEnergy = false,
        canWalkOnFire = false,
        canWalkOnPoison = false
    }

    Game.createMonsterType("SnakeEvent Tail Ex"):register(monster)

    function SnakeEvent.start()
        local players = #SnakeEvent.cache.players
        if players < SnakeEvent.misc.minPlayers then
            Game.broadcastMessage("[SnakeEvent] The event could not start due to lack of participants.")
            for _, playerGuid in pairs(SnakeEvent.cache.players) do
                local player = Player(playerGuid)
                if player then
                    SnakeEvent.leave(player)
                end
            end
            SnakeEvent.state = "stoped"
            return false
        end
        if SnakeEvent.cache.events[2] then
            stopEvent(SnakeEvent.cache.events[2])
        end
        SnakeEvent.removeTeleport()
        SnakeEvent.state = "running"
        SnakeEvent.startAutoWalking()
        if SnakeEvent.debug then
            print("[SnakeEvent/Debug] event start!")
        end
        return SnakeEvent.loop()
    end

    local function getTime(s)
        return string.format("%.2d:%.2d", math.floor(s/60%60), math.floor(s%60))
    end

    function SnakeEvent.warnings(seconds)
        if seconds <= 0 then
            return SnakeEvent.start()
        end
        if SnakeEvent.state ~= "full" then
            Game.broadcastMessage(string.format("[SnakeEvent] Go to the teleport in the temple to enter the event.\nThe event starts at: %s", getTime(seconds)))
        else
            Game.broadcastMessage("[SnakeEvent] We are about to begin...")
        end
        local discount = math.ceil(math.max(5, seconds/5))
        SnakeEvent.cache.events[3] = addEvent(SnakeEvent.warnings, discount * 1000, seconds -discount)
    end

    function SnakeEvent.isExist(player)
        local playerGuid = player:getGuid()
        for index, guid in pairs(SnakeEvent.cache.players) do
            if playerGuid == guid then
                return index
            end
        end
        return false
    end

    function SnakeEvent.enter(player)
        if #SnakeEvent.cache.players >= SnakeEvent.misc.maxPlayers then
            return false
        end
        local playerGuid = player:getGuid()
        if SnakeEvent.isExist(player) then
            if SnakeEvent.debug then
                print(string.format("[SnakeEvent/Debug] Player %s already into event!", player:getName()))
            end
            return false
        end
        table.insert(SnakeEvent.cache.players, playerGuid)
        SnakeEvent.cache.tiles[playerGuid] = {}
        SnakeEvent.cache.tails[playerGuid] = {}
        SnakeEvent.cache.foods[playerGuid] = 0
        local position = Position(
            math.random(SnakeEvent.area.fromPos.x, SnakeEvent.area.toPos.x),
            math.random(SnakeEvent.area.fromPos.y, SnakeEvent.area.toPos.y),
            SnakeEvent.area.fromPos.z)
        player:teleportTo(position)
        player:setMovementBlocked(true)
        position:sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "~ Welcomen to SnakeEvent ~\nYou can change direction with Control+Arrows")
        if #SnakeEvent.cache.players >= SnakeEvent.misc.maxPlayers then
            Game.broadcastMessage("[SnakeEvent] The event is at full, we will start soon...")
            SnakeEvent.state = "full"
            stopEvent(SnakeEvent.cache.events[3])
            SnakeEvent.warnings(5)
        end
        if SnakeEvent.debug then
            print(string.format("[SnakeEvent/Debug] Player %s into event!", player:getName()))
        end
        return true
    end

    function SnakeEvent.leave(player)
        local playerGuid = player:getGuid()
        for _, copy in pairs(SnakeEvent.cache.tails[playerGuid]) do
            copy:remove()
        end
        local index = SnakeEvent.isExist(player)
        if not index then
            if SnakeEvent.debug then
                print(string.format("[SnakeEvent/Debug] Player %s not found!", player:getName()))
            end
            return false
        end

        table.remove(SnakeEvent.cache.players, index)
        player:teleportTo(SnakeEvent.misc.exitPosition)
        player:setMovementBlocked(false)
        SnakeEvent.misc.exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
        if SnakeEvent.debug then
            print(string.format("[SnakeEvent/Debug] Player %s leave success!", player:getName()))
        end
        return true
    end

    function SnakeEvent.removeTeleport()
        local tile = Tile(SnakeEvent.teleport.position)
        if tile then
            local teleport = tile:getItemById(SnakeEvent.teleport.itemId)
            if teleport then
                teleport:remove()
                SnakeEvent.teleport.position:sendMagicEffect(CONST_ME_POFF)
            end
        end
    end

    function SnakeEvent.createTeleport()
        local teleport = Game.createItem(SnakeEvent.teleport.itemId, 1, SnakeEvent.teleport.position)
        if teleport then
            teleport:setAttribute(ITEM_ATTRIBUTE_ACTIONID, SnakeEvent.teleport.actionId)
            SnakeEvent.warnings(SnakeEvent.teleport.timeDisappear)
            SnakeEvent.cache.events[2] = addEvent(SnakeEvent.removeTeleport, SnakeEvent.teleport.timeDisappear * 1000)
        end
    end

    function SnakeEvent.clear()
        SnakeEvent.cache = {
            foods = {},
            tails = {},
            tiles = {},
            players = {},
            events = {}
        }
    end
end

local teleportEvent = MoveEvent()

function teleportEvent.onStepIn(creature, item, pos, fromPosition)
    if creature:isPlayer() then
        if not SnakeEvent.enter(creature) then
            creature:teleportTo(fromPosition)
            creature:sendCancelMessage("There is not enough space.")
        end
    end
    return true
end

teleportEvent:aid(SnakeEvent.teleport.actionId)
teleportEvent:register()

local snakeTalk = TalkAction(SnakeEvent.talkAction)

function snakeTalk.onSay(player, words, param)
    local split = param:split(",")
    if split[1] == "run" then
        if SnakeEvent.state ~= "stoped" then
            player:sendCancelMessage("The event is running right now.")
            return false
        end
        SnakeEvent.clear()
        SnakeEvent.state = "waiting"
        SnakeEvent.createTeleport()
        return false
    elseif split[1] == "close" then
        if SnakeEvent.state ~= "stoped" then
            SnakeEvent.stop(true)
            return false
        end
        player:sendCancelMessage("The event is already stoped.")
    end
    return false
end

snakeTalk:access(true)
snakeTalk:separator(" ")
snakeTalk:register()

local snakeEvent = GlobalEvent("SnakeEventEventGlobal")

function snakeEvent.onTime(interval)
    SnakeEvent.clear()
    SnakeEvent.state = "waiting"
    SnakeEvent.createTeleport()
    return true
end

snakeEvent:time(SnakeEvent.misc.timeEventStart)
snakeEvent:register()

local directionOffset = {
    [DIRECTION_EAST] = DIRECTION_WEST,
    [DIRECTION_WEST] = DIRECTION_EAST,
    [DIRECTION_NORTH] = DIRECTION_SOUTH,
    [DIRECTION_SOUTH] = DIRECTION_NORTH
}

local ec = EventCallback

function ec.onTurn(player, direction)
    if SnakeEvent.state == "stoped" or not SnakeEvent.isExist(player) then
        return true
    end
    local currDirection = player:getDirection()
    if currDirection == direction then
        return false
    elseif directionOffset[currDirection] == direction then
        return false
    end
    return true
end

ec:register(-1)

local ec = EventCallback

function ec.onMoveItem(player, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
    if SnakeEvent.state == "stoped" or not SnakeEvent.isExist(player) then
        return true
    end

    if not player:getGroup():getAccess() then
        if toPosition.x ~= CONTAINER_POSITION or fromPosition.x ~= CONTAINER_POSITION then
            player:sendCancelMessage("It is not allowed to move items in the event.")
            return false
        end
    end
    return true
end

ec:register(-1) --]]