ETERNAL_FLAMES_CONFIG = {
    [38231] = { --- just id eternal flame
        chance = 0.7,
        addExperience = 5, --- formula : level * level * 100
        expiration = 25, --- in seconds
        colour = 120,
        messages = {onSpawn = "1 grade Tornado Spawned!"}
    },
    [38780] = { --- just id eternal flame
        chance = 0.5,
        addExperience = 7, --- formula : level * level * 100
        expiration = 24, --- in seconds
        colour = 181,
        messages = {onSpawn = "2 grade Tornado Spawned!"}
    },
    [46911] = { --- just id eternal flame
        chance = 0.4,
        addExperience = 10, --- formula : level * level * 100
        expiration = 192, --- in seconds
        colour = 17,
        messages = {onSpawn = "3 grade Tornado Spawned!"}
    },
    [46913] = { --- just id eternal flame
        chance = 0.3,
        addExperience = 12, --- formula : level * level * 100
        expiration = 22, --- in seconds
        colour = 210,
        messages = {onSpawn = "4 grade Tornado Spawned!"}
    },
    [39400] = { --- just id eternal flame
        chance = 0.2,
        addExperience = 15, --- formula : level * level * 100
        expiration = 21, --- in seconds
        colour = 67,
        messages = {onSpawn = "5 grade Tornado Spawned!"}
	},
    [46910] = { --- just id eternal flame
        chance = 0.1,
        addExperience = 20, --- formula : level * level * 100
        expiration = 20, --- in seconds
        colour = 64,
        messages = {onSpawn = "6 grade Tornado Spawned!"}
	},
    [36447] = { --- just id eternal flame
        chance = 0.1,
        addExperience = 25, --- formula : level * level * 100
        expiration = 18, --- in seconds
        colour = 17,
        messages = {onSpawn = "7 grade Tornado Spawned!"}
	},
    [39581] = { --- just id eternal flame
        chance = 0.1,
        addExperience = 30, --- formula : level * level * 100
        expiration = 14, --- in seconds
        colour = 191,
        messages = {onSpawn = "8 grade Tornado Spawned!"}
	},
    [46909] = { --- just id eternal flame
        chance = 0.1,
        addExperience = 35, --- formula : level * level * 100
        expiration = 11, --- in seconds
        colour = 0,
        messages = {onSpawn = "9 grade Tornado Spawned!"}
	},
    [46912] = { --- just id eternal flame
        chance = 0.1,
        addExperience = 45, --- formula : level * level * 100
        expiration = 6, --- in seconds
        colour = 215,
        messages = {onSpawn = "10 grade Tornado Spawned!"}
    }



}

eternalflames = {}
eternalflames.__newindex = eternalflames
eternalflames.aid = 1728

function isBadTile(tile)
    return (tile == nil or tile:getGround() == nil or
               tile:hasProperty(TILESTATE_NONE) or
               tile:hasProperty(TILESTATE_FLOORCHANGE_EAST) or
               isItem(tile:getThing()) and not isMoveable(tile:getThing()) or
               tile:getTopCreature() or tile:hasFlag(TILESTATE_PROTECTIONZONE))
end

function eternalflames:tableSort()
    local sorted = {}

    for k, v in pairs(ETERNAL_FLAMES_CONFIG) do
        local values = {["Table"] = k, ["Chance"] = v.chance}
        sorted[#sorted + 1] = values
    end

    table.sort(sorted, function(a, b) return a["Chance"] < b["Chance"] end)
    eternalflames.t = sorted
end

function eternalflames:generateChance()

    local number = math.random(0, 10000)

    local t = eternalflames.t
    for index, v in pairs(t) do
        local chance = v["Chance"] * 100
        local tableid = v["Table"]
        if number <= chance then return tableid end
    end
    return false
end

function eternalflames:isSpawned(position, id)
    local tile = Tile(position)
    if tile then
        local items = tile:getItems()
        if items then
            for index, item in pairs(items) do
                if item:getId() == id then return true end
            end
        end
    end

    return false
end

function eternalflames:timer(times, position, id, colour)

    if times == 0 then
        stopEvent()
        return false
    end

    local delay = 0
    local interval = 1000
    for i = 1, times do
        if i == 1 then
            delay = 0
        else
            delay = delay + interval
        end

        addEvent(function()
            local found = eternalflames:isSpawned(position, id)
            if not found then return false end

            Game.sendAnimatedText(times - i, position, colour)
        end, delay)
    end
end

function eternalflames:spawn(creature, position, id)

    if not id then return print("ETERNAL FLAME - ERROR - CANT FIND ID") end

    if not position then
        return print("ETERNAL FLAME - ERROR - CANT FIND POSITION")
    end

    if not creature then
        return print("ETERNAL FLAME - ERROR - CANT FIND CREATURE")
    end

    local t = ETERNAL_FLAMES_CONFIG[id]
    if not t then return print("ETERNAL FLAME - ERROR - CANT FIND TABLE") end

    local interval = t.expiration
    if not interval then
        return print("ETERNAL FLAME - ERROR - CANT FIND EXPIRATION VALUE")
    end

    local colour = t.colour
    if not colour then
        return print("ETERNAL FLAME - ERROR - CANT FIND COLOUR")
    end

    local tile = Tile(position)
    if tile then
        local items = tile:getItems()
        if items then
            for index, item in pairs(items) do
                if item:getId() == id then return false end
            end
        end
    end

    local flame = Game.createItem(id, 1, position)
    if not flame then return false end

    flame:setAttribute(ITEM_ATTRIBUTE_ACTIONID, eternalflames.aid)
    eternalflames:timer(interval, position, id, colour)

    addEvent(function()
        local tile = Tile(position)
        if tile then
            local items = tile:getItems()
            if items then
                for index, item in pairs(items) do
                    if item then
                        if item:getId() == id then
                            item:remove()
                        end
                    end
                end
            end
        end
    end, interval * 1000)

    if not eternalflames:isSpawned(position, id) then return false end

    local players = creature:getDamageMap()
    for player_id in pairs(players) do
        local player = Player(player_id)
        if player then
            if player:getName() == "Dakoseq" then
                player:move(position)
                player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,
                                       "Spawned at position: " .. "\n" ..
                                           dump(position))
            end
            local messageSpawned = t.messages.onSpawn
            player:sendTextMessage(MESSAGE_STATUS_WARNING, messageSpawned ..
                                       " Hurry! It will disapear after " ..
                                       interval .. " seconds.")
        end
    end

    return true
end

function eternalflames:createPosition(creature, player)

    if not creature then return nil end

    local attempts = 0
    local creaturePosition = creature:getPosition()
    local x = nil
    local y = nil
    local z = creaturePosition.z
    local pos = nil

    while attempts < 20 do
        local number = math.random(0, 1)
        if number == 1 then
            x = creaturePosition.x + math.random(0, 5)
            y = creaturePosition.y + math.random(0, 5)
        else
            x = creaturePosition.x - math.random(0, 5)
            y = creaturePosition.y - math.random(0, 5)
        end
        pos = Position(x, y, z)
        local tile = Tile(pos)
        if tile and not isBadTile(tile) and creature:getPathTo(pos, 0, 1, true, true, 100) then
            return pos
        end
        pos = nil
        attempts = attempts + 1
    end

    if not pos then return false end

end

eternalflames:tableSort()
local creatureevent = CreatureEvent("eternalflame_onDeath")
function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller,
                               lastHitUnjustified, mostDamageUnjustified)

    local id = eternalflames:generateChance()
    if not id then return true end

    if not killer then return true end

    local pos = eternalflames:createPosition(creature, killer)
    if not pos then return true end

    eternalflames:spawn(creature, pos, id)
    return true
end

creatureevent:register()

local moveevent = MoveEvent()
moveevent:type("stepin")
function moveevent.onStepIn(creature, item, position, fromPosition)

    local player = Player(creature)

    if not player or player:isInGhostMode() then return true end

    local vocation = player:getVocation()
    if vocation:getId() == 0 then
        player:sendTextMessage(MESSAGE_STATUS_WARNING,
                               "Sorry, you must complete path test first.")
        player:teleportTo(fromPosition)
        return false
    end

    local t = ETERNAL_FLAMES_CONFIG[item:getId()]
    if not t then return true end

    if t ~= nil and item ~= nil then item:remove() end
    eternalflames:timer(0)
    local window = ModalWindow {
        title = 'Math Test',
        message = 'Choose the lowest number.'
    }

    local valuo = math.random(1, 10)
    local tryed = 0
    local added = 0
    while added < math.random(6) do
        local chanceToAdd = math.random(1, 5)
        if chanceToAdd <= 1 then
            window:addChoice(valuo * 2 + tryed + added)
            added = added + 1
        end
        tryed = tryed + 1
    end
    local choiceCorrect = window:addChoice(valuo)
    choiceCorrect.value = valuo
    lowestChoice = choiceCorrect
    lowestChoice.correct = true
    local tryed2 = 0
    while tryed2 < 6 do
        local chanceToAdd = math.random(1, 6)
        if chanceToAdd <= 1 then
            window:addChoice(valuo * 2 + tryed2 + tryed)
        end
        tryed2 = tryed2 + 1
    end
    if added < 2 then
        while added < 4 do
            window:addChoice(valuo * 2 + tryed + added)
            added = added + 1
        end
    end

    window:addButton('Ok', function(button, choice)
        if choice.correct and t then
            local value = t.addExperience
            local level = player:getLevel()
            local formula = level * level * value
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
            player:addExperience(formula)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
                                   "You have received " .. math.ceil(formula) ..
                                       " experience from eternal flame.")
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Wrong answer.")
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
        end
    end)
    window:setDefaultEnterButton('Ok')
    window:addButton('Close')
    window:setDefaultEscapeButton('Close')
    window:setDefaultCallback(function(button, choice)
        player:setStorageValue(DOINGETERNALFLAMES, 0)
    end)
    window:sendToPlayer(player)
end

moveevent:aid(eternalflames.aid)
moveevent:register()