local config = {
    minLevel = 150,
    leverID = 39365,
    leverPosition = Position(814, 877, 3),
    stayPosition = Position(814, 876, 3),
    throwItemPos = Position(813, 876, 3),
    throwItemId = 35969,
    randomItems = {
        [34037] = {chance = 80, effect = 8},
        [34288] = {chance = 40, effect = 70},
        [41530] = {chance = 10, effect = 460}
    }
}
local moveEvent = MoveEvent()
function moveEvent.onStepIn(creature, item, pos, fromPosition)
    if creature:isPlayer() then
        local player = Player(creature)
        if player:getLevel() < config.minLevel then
            player:teleportTo(fromPosition)
            player:sendFail(string.format(
                                "You need level %i to decraft black cubes.",
                                config.minLevel))
        end
    end
    return true
end

moveEvent:aid(basinSystem)
moveEvent:register()

local globalevent = GlobalEvent("load_basinSystem")

function globalevent.onStartup()
    local tile = Tile(config.stayPosition)
    local lever = Tile(config.leverPosition)
    local tileBasin = Tile(config.throwItemPos)
    local item = config.leverID
    if lever and item then Game.createItem(item, 1, config.leverPosition) end
    if lever then
        local thing = lever:getTopVisibleThing()
        if thing then
            thing:setAttribute(ITEM_ATTRIBUTE_ACTIONID, basinSystemLever)
        end
    end
    if tileBasin then
        local thing = tileBasin:getTopVisibleThing()
        if thing then
            thing:setAttribute(ITEM_ATTRIBUTE_ACTIONID, basinSystemBasin)
        end
    end
    if tile then
        local thing = tile:getTopVisibleThing()
        if thing then
            thing:setAttribute(ITEM_ATTRIBUTE_ACTIONID, basinSystem)
        end
    end
end

globalevent:register()

local function giveRandomItem(position)
    local random = math.random(1, 100)
    local item
    if random <= config.randomItems[41530].chance then
        item = Game.createItem(41530, 1, position)
        position:sendMagicEffect(config.randomItems[41530].effect)
    elseif random <= config.randomItems[34037].chance then
        item = Game.createItem(34037, 1, position)
        position:sendMagicEffect(config.randomItems[34037].effect)
    elseif random > config.randomItems[34037].chance then
        item = Game.createItem(34288, 1, position)
        position:sendMagicEffect(config.randomItems[34288].effect)
    end
end

local function doTransformLever(item, execute)
    if item:getId() == 39365 then
        item:transform(39366)
    elseif item:getId() == 39366 then
        item:transform(39365)
    end
end

local action = Action()

function action.onUse(player, item, fromPos, target, toPos, isHotkey)
    local tile = Tile(config.throwItemPos)
    if tile then
        local item = tile:getTopVisibleThing()
        if item then
            if item:getId() == config.throwItemId then
                doTransformLever(item)
                item:remove(1)
                giveRandomItem(config.throwItemPos)
                return true
            else
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format(
                                           "You need to throw a %s in the basin to use the lever.",
                                           getItemName(config.throwItemId)))
                                           player:sendMagicEffect(CONST_ME_POFF)
                return true
            end
        end
    end
    return false
end

action:aid(basinSystemLever)
action:register()

local ec = EventCallback

function ec.onMoveItem(player, item, count, fromPosition, toPosition,
                       fromCylinder, toCylinder)
    local tile = player:getTile()
    if tile then
        local ground = tile:getGround()
        if toPosition == config.throwItemPos and player:getPosition() ~=
            config.stayPosition then return RETURNVALUE_NOTPOSSIBLE end
    end
    return RETURNVALUE_NOERROR
end

ec:register( --[[0]] )
