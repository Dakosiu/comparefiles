local FridayChest = Action()
local FridayQuest = 99347

local Pos = Position(807, 871, 5)

local cfg = {
    ["Normal"] = {
        chance = 100,
        items = { -- 100%
            {item = 2160, count = 50}, {item = 2160, count = 60},
            {item = 2160, count = 70}, {item = 2160, count = 80},
            {item = 2160, count = 90}, {item = 2160, count = 100}
        }
    },
    ["Rare"] = {
        chance = 20,
        items = { -- 20%
            {item = 2160, count = 100}, {item = 27604, count = 100}
        }
    },
    ["Epic"] = {
        chance = 10,
        items = { -- 10%
            {item = 35969, count = 1}, {item = 35969, count = 2} -- ! 0 Makes it randomize from 0 to 100
        }
    },
    ["Legendary"] = {
        chance = 5,
        items = { -- 5%
            {item = 35969, count = 3}, {item = 35969, count = 5}
        }
    }
}

local random
local RandomCount

local legendary = cfg["Legendary"]
local epic = cfg["Epic"]
local rare = cfg["Rare"]
local normal = cfg["Normal"]

function FridayChest.onUse(player, item, fromPosition, target, toPosition,
                           isHotkey)
    local date = os.date('%A')
    local chance = math.random(1, 100)
    local day = "Friday"
    local FridayStorage = 33333
    local NormalStorage = 33332
    local lastTime = player:getStorageValue(NormalStorage)
    local cooldown = player:getStorageValue(FridayStorage) - os.time()
    local now = os.time() + 1 * 24 * 60 * 60 * 1000
    if lastTime == -1 then lastTime = 0 end
    if date == day and cooldown <= 0 then
        -- local random = math.random(1, #rewards)
        if chance <= legendary.chance then
            random = math.random(1, #cfg["Legendary"].items)
            local LegendaryCount = cfg["Legendary"].items[random].count
            if cfg["Legendary"].items[random].count == 0 then
                RandomCount = math.random(1, 100)
            else
                RandomCount = cfg["Legendary"].items[random].count
            end
            player:addItem(cfg["Legendary"].items[random].item, RandomCount)
            Pos:sendMagicEffect(101)
            Pos:sendAnimatedText("Legendary", TEXTCOLOR_ORANGE, player)
            Game.broadcastMessage(player:getName() ..
                                      " got a Legendary Loot from Friday Chest")
            player:sendTextMessage(MESSAGE_INFO_DESCR,
                                   'You have found ' .. RandomCount .. "x " ..
                                       getItemName(
                                           cfg["Legendary"].items[random].item) ..
                                       '.')
            player:setStorageValue(FridayStorage, now)
            player:setStorageValue(NormalStorage, lastTime + 1)
            return false
        end
        if chance <= epic.chance then
            random = math.random(1, #cfg["Epic"].items)
            if cfg["Epic"].items[random].count == 0 then
                RandomCount = math.random(1, 100)
            else
                RandomCount = cfg["Epic"].items[random].count
            end
            player:addItem(cfg["Epic"].items[random].item, RandomCount)
            Pos:sendMagicEffect(102)
            Pos:sendAnimatedText("Epic", TEXTCOLOR_PURPLE, player)
            player:sendTextMessage(MESSAGE_INFO_DESCR,
                                   'You have found ' .. RandomCount .. "x " ..
                                       getItemName(
                                           cfg["Epic"].items[random].item) ..
                                       '.')
            player:setStorageValue(FridayStorage, now)
            player:setStorageValue(NormalStorage, lastTime + 1)
            return false
        end
        if chance <= rare.chance then
            random = math.random(1, #cfg["Rare"].items)
            if cfg["Rare"].items[random].count == 0 then
                RandomCount = math.random(1, 100)
            else
                RandomCount = cfg["Rare"].items[random].count
            end
            player:addItem(cfg["Rare"].items[random].item, RandomCount)
            Pos:sendMagicEffect(103)
            Pos:sendAnimatedText("Rare", TEXTCOLOR_BLUE, player)
            player:sendTextMessage(MESSAGE_INFO_DESCR,
                                   'You have found ' .. RandomCount .. "x " ..
                                       getItemName(
                                           cfg["Rare"].items[random].item) ..
                                       '.')
            player:setStorageValue(FridayStorage, now)
            player:setStorageValue(NormalStorage, lastTime + 1)
            return false
        end
        if chance <= normal.chance then
            random = math.random(1, #cfg["Normal"].items)
            if cfg["Normal"].items[random].count == 0 then
                RandomCount = math.random(1, 100)
            else
                RandomCount = cfg["Normal"].items[random].count
            end
            player:addItem(cfg["Normal"].items[random].item, RandomCount)
            Pos:sendMagicEffect(100)
            Pos:sendAnimatedText("Normal", TEXTCOLOR_GREEN, player)
            player:sendTextMessage(MESSAGE_INFO_DESCR,
                                   'You have found ' .. RandomCount .. "x " ..
                                       getItemName(
                                           cfg["Normal"].items[random].item) ..
                                       '.')
            player:setStorageValue(FridayStorage, now)
            player:setStorageValue(NormalStorage, lastTime + 1)
            return false
        end
    elseif date ~= day then
        player:say("Its not friday yet")
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'The chest is locked.')
        Pos:sendMagicEffect(CONST_ME_POFF)
    elseif player:getStorageValue(FridayStorage) < now then
        player:say("I already claimed it this Friday")
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You found nothing.')
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
    end
end

FridayChest:aid(99347)
FridayChest:register()

local globalevent = GlobalEvent("load_FridayChest")

function globalevent.onStartup()
    local tile = Tile(Pos)
    if tile then
        local thing = tile:getTopVisibleThing()
        if thing then
            -- FridayQuest = 99347
            thing:setAttribute(ITEM_ATTRIBUTE_ACTIONID, FridayQuest)
        end
    end
end

globalevent:register()