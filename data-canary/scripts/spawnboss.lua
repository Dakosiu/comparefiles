local bossConfigurations = {
    [1] = {bossName = "Ghazbaran"},
    [2] = { bossName = "Apocalypse"},
    }


local bossRoom = {
    centerPosition = Position(1020, 696, 7),
    spawnRange = {from = Position(1018, 696, 7), to = Position(1018, 696, 7)},
    spawnArea = {x = 3, y = 2}
}

local function getRandomSpawnPosition(fromPosition, toPosition)
    return Position(math.random(fromPosition.x,  toPosition.x), math.random(fromPosition.y,  toPosition.y), math.random(fromPosition.z,  toPosition.z))
end

function startBossRoom()
    -- Clear existing monsters
    local spectators = Game.getSpectators(bossRoom.centerPosition, false, false, bossRoom.spawnArea.x, bossRoom.spawnArea.x, bossRoom.spawnArea.y, bossRoom.spawnArea.y)
    for _, spectator in pairs(spectators) do
        if spectator:isMonster() then
            spectator:remove()
        end
    end

    -- Select a random boss from the available configs
    local bossIndex = math.random(#bossConfigurations)
    local boss = bossConfigurations[bossIndex]

    -- Spawn the selected boss
    if boss.bossName then
        local spawnedBoss = Game.createMonster(boss.bossName, bossRoom.centerPosition, true, true)
        if spawnedBoss then
            Game.broadcastMessage("The boss room was cleaned and the boss " ..boss.bossName.. " was spawned.", MESSAGE_EVENT_ADVANCE)
        else
            print("[Spawn Boss Room] Failed to spawn boss " ..boss.bossName.." in boss room.", MESSAGE_EVENT_ADVANCE)
        end
    else
        Game.broadcastMessage("The boss room was cleaned and only common monsters was spawned.", MESSAGE_EVENT_ADVANCE)
    end

    -- Spawn summons for the selected boss
    local summons = boss.summons
    if summons then
        for _, summon in pairs(summons) do
            local summonName = summon.name
            local summonAmount = summon.amount
            for i = 1, summonAmount do
                local randomPosition = getRandomSpawnPosition(bossRoom.spawnRange.from, bossRoom.spawnRange.to)
                local summonedMonster = Game.createMonster(summonName, randomPosition, true, true)
                if not summonedMonster then
                    print("[Spawn Boss Room] Failed to spawn summon " ..summonName.. " in boss room.")
                end
            end
        end
    end
end

local randomBossEvent = GlobalEvent("Random Boss Event")

function randomBossEvent.onTime(interval)
    if type(startBossRoom) == "function" then
        startBossRoom()
        print("[Spawn Boss Room] event has started.")
    else
        print("[Spawn Boss Room] startBossRoom function does not exist.")
    end
    return true
end

randomBossEvent:interval(math.random(1, 2) * 60 * 60 * 1000) -- Set the interval to 3/7 hours
randomBossEvent:register()

local talk = TalkAction("/startBoss")

function talk.onSay(player, words, param)
    -- Check if player has access to the command
    if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
        return false
    end

    -- Check if the function "startBossRoom" exists
    if not startBossRoom then
        print("[Spawn Boss Room] startBossRoom does not exist.")
        return false
    end

    -- Call the startBossRoom function
    startBossRoom()
    player:sendTextMessage(MESSAGE_INFO_DESCR, "[Spawn Boss Room] event has started.")
    print("[Spawn Boss Room] event has started.")
    return false
end

talk:register()