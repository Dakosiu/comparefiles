local raidBossInformation = {
    {
        dayToSpawn = "Sunday",
        position = Position(1008, 1147, 15),
        monsterName = "Orshabaal",
        respawnTime = 4, -- hours
        messageOnSpawn = "Orshabaal has been summoned from hell to plague the lands of mortals again.",
        messageOnDeath = "Orshabaal has been defeated, the demon master will reveal himself in Hrodimir in 4 hours.",
        creatureId = 0, -- don't touch
        lastKilledTime = 0 -- don't touch
    },
    {
        dayToSpawn = "Monday",
        position = Position(1008, 1147, 15),
        monsterName = "Orshabaal",
        respawnTime = 4, -- hours
        messageOnSpawn = "Orshabaal has been summoned from hell to plague the lands of mortals again.",
        messageOnDeath = "Orshabaal has been defeated, the demon master will reveal himself in Hrodimir in 4 hours.",
        creatureId = 0, -- don't touch
        lastKilledTime = 0 -- don't touch
    },
    {
        dayToSpawn = "Friday",
        position = Position(861, 890, 12),
        monsterName = "Ghazbaran",
        respawnTime = 4, -- hours
        messageOnSpawn = "Ghazbaran is awakening... demonic entities are entering the mortal realm in the Hrodmir mines.",
        messageOnDeath = "Ghazbaran has been defeated, the demon master will reveal himself in Hrodimir in 4 hours.",
        creatureId = 0, -- don't touch
        lastKilledTime = 0 -- don't touch
    },
    {
        dayToSpawn = "Saturday",
        position = Position(861, 890, 12),
        monsterName = "Ghazbaran",
        respawnTime = 4, -- hours
        messageOnSpawn = "Ghazbaran is awakening... demonic entities are entering the mortal realm in the Hrodmir mines.",
        messageOnDeath = "Ghazbaran has been defeated, the demon master will reveal himself in Hrodimir in 4 hours.",
        creatureId = 0, -- don't touch
        lastKilledTime = 0 -- don't touch
    },
    {
        dayToSpawn = "Thursday",
        position = Position(1418, 1016, 4),
        monsterName = "Ferumbras",
        respawnTime = 4, -- hours
        messageOnSpawn = "Ferumbras return is at hand. The Mi'hen Academy calls for Heroes to fight that evil..",
        messageOnDeath = "Ferumbras has been defeated, the wizard master will reveal himself in Citadel in 4 hours.",
        creatureId = 0, -- don't touch
        lastKilledTime = 0 -- don't touch
    },
    {
        dayToSpawn = "Wednesday",
        position = Position(1418, 1016, 4),
        monsterName = "Ferumbras",
        respawnTime = 4, -- hours
        messageOnSpawn = "Ghazbaran is awakening... demonic entities are entering the mortal realm in the Hrodmir mines.",
        messageOnDeath = "Ghazbaran has been defeated, the demon master will reveal himself in Hrodimir in 4 hours.",
        creatureId = 0, -- don't touch
        lastKilledTime = 0 -- don't touch
    },
    ------ Pits of Inferno
    {
        dayToSpawn = "Any",
        position = Position(1358, 802, 15),
        monsterName = "The Plasmother",
        respawnTime = 4, -- hours
        messageOnSpawn = "The Plasmother is awakening... demonic entities are spawning in the Verminor's throneroom.",
        messageOnDeath = "The Plasmother has been defeated, this demonic spawn will reveal himself in Verminor's throneroom in 1 hour.",
        creatureId = 0, -- don't touch
        lastKilledTime = 0 -- don't touch
    },
    {
        dayToSpawn = "Any",
        position = Position(1299, 834, 15),
        monsterName = "Countess Sorrow",
        respawnTime = 1, -- hour
        messageOnSpawn = "Countess Sorrow is awakening... demonic entities are spawning in the Bazir's throneroom.",
        messageOnDeath = "Countess Sorrow has been defeated, this demonic spawn will reveal himself in Bazir's throneroom in 1 hour.",
        creatureId = 0, -- don't touch
        lastKilledTime = 0 -- don't touch
    },
    {
        dayToSpawn = "Any",
        position = Position(1378, 740, 15),
        monsterName = "Massacre",
        respawnTime = 1, -- hour
        messageOnSpawn = "Massacre is awakening... demonic entities are spawning in the Bazir's throneroom.",
        messageOnDeath = "Massacre has been defeated, this demonic spawn will reveal himself in Apocalypse's throneroom in 1 hour.",
        creatureId = 0, -- don't touch
        lastKilledTime = 0 -- don't touch
    },
    {
        dayToSpawn = "Any",
        position = Position(1341, 783, 15),
        monsterName = "Dracola",
        respawnTime = 1, -- hour
        messageOnSpawn = "Dracola is awakening... demonic entities are spawning in the Ashfalor's throneroom.",
        messageOnDeath = "Dracola has been defeated, this demonic spawn will reveal himself in Ashfalor's throneroom in 1 hour.",
        creatureId = 0, -- don't touch
        lastKilledTime = 0 -- don't touch
    },
    {
        dayToSpawn = "Any",
        position = Position(1409, 691, 15),
        monsterName = "The Imperor",
        respawnTime = 1, -- hour
        messageOnSpawn = "The Imperor is awakening... demonic entities are spawning in the Ashfalor's throneroom.",
        messageOnDeath = "The Imperor has been defeated, this demonic spawn will reveal himself in Ashfalor's throneroom in 1 hour.",
        creatureId = 0, -- don't touch
        lastKilledTime = 0 -- don't touch
    },
    {
        dayToSpawn = "Any",
        position = Position(1296, 756, 15),
        monsterName = "The Handmaiden",
        respawnTime = 1, -- hour
        messageOnSpawn = "The Handmaiden is awakening... demonic entities are spawning in the Pumin's throneroom.",
        messageOnDeath = "The Handmaiden has been defeated, this demonic spawn will reveal himself in Pumin's throneroom in 1 hour.",
        creatureId = 0, -- don't touch
        lastKilledTime = 0 -- don't touch
    },
    {
        dayToSpawn = "Any",
        position = Position(1269, 718, 15),
        monsterName = "Mr. Punish",
        respawnTime = 1, -- hour
        messageOnSpawn = "Mr. Punish is awakening... demonic entities are spawning in the Tafariel's throneroom.",
        messageOnDeath = "Mr. Punish has been defeated, this demonic spawn will reveal himself in Tafariel's throneroom in 1 hour.",
        creatureId = 0, -- don't touch
        lastKilledTime = 0 -- don't touch
    },
}

local day -- don't touch

local function respawnBoss(index)
    local spawn = raidBossInformation[index]
    local monster = Game.createMonster(spawn.monsterName, spawn.position, false, true)
    if monster then
        spawn.creatureId = monster:getId()
        monster:setMasterPosition(spawn.position)
        monster:registerEvent("raidBossDeath")
        Game.broadcastMessage(spawn.messageOnSpawn, MESSAGE_EVENT_ADVANCE)
    else
        print("Failed to respawn index: " .. index .. " -> " .. spawn.monsterName .. "")
    end
end

local globalevent = GlobalEvent("raidBosses")

function globalevent.onStartup()
    day = os.date('%A')
    for index, spawn in pairs(raidBossInformation) do
        if spawn.dayToSpawn == day or spawn.dayToSpawn == "Any" then
            local monster = Game.createMonster(spawn.monsterName, spawn.position, false, true)
            if monster then
                spawn.creatureId = monster:getId()
                monster:setMasterPosition(spawn.position)
                monster:registerEvent("raidBossDeath")
            else
                print("Failed to spawn index: " .. index .. " -> " .. spawn.monsterName .. "")
            end
        end
    end
    return true
end

globalevent:register()


local creatureevent = CreatureEvent("raidBossDeath")

function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
    local bossId = creature:getId()
    for i = 1, #raidBossInformation do
        if raidBossInformation[i].creatureId == bossId then
            raidBossInformation[i].creatureId = 0
            raidBossInformation[i].lastKilledTime = os.time()
            Game.broadcastMessage(raidBossInformation[i].messageOnDeath, MESSAGE_EVENT_ADVANCE)
            addEvent(respawnBoss, 1000 * 60 * 60 * raidBossInformation[i].respawnTime, i)
            return true
        end
    end
    print("Something went wrong in raidBossDeath script.")
    return true
end

creatureevent:register()


local talk = TalkAction("/bosscheck", "!bosscheck")

function talk.onSay(player, words, param)
    local text = ""
    for i = 1, #raidBossInformation do
        if text ~= "" then
            text = text .. "\n"
        end
        text = text .. raidBossInformation[i].monsterName
        text = text .. " " .. (raidBossInformation[i].dayToSpawn == "Any" and " [" .. day .. "]" or " [" .. raidBossInformation[i].dayToSpawn .. "]") .. "\n    "
        if raidBossInformation[i].creatureId == 0 then
            if raidBossInformation[i].lastKilledTime == 0 then
                text = text .. "Unavailable"
            else
                text = text .. "Dead -> respawning in " .. os.date("!%Hh %Mm %Ss", (raidBossInformation[i].lastKilledTime + (60 * 60 * raidBossInformation[i].respawnTime)) - os.time())
            end
        else
            text = text .. "Alive"
        end
    end
    player:showTextDialog(2239, text, false)
    return false
end

talk:separator(" ")
talk:register()
